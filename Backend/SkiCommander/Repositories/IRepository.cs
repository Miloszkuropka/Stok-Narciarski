namespace SkiCommander.Repositories
{
    public interface IRepository<T>
    {
        IEnumerable<T> GetAll();

        void Update(T entity);

        void Add(T entity);

        void Delete(Guid id);
    }
}
