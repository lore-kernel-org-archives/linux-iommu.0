From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/6] drivers core: Add I/O ASID allocator
Date: Mon, 12 Nov 2018 15:40:39 +0100
Message-ID: <20181112144039.GA25808@8bytes.org>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181019181158.2395-3-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181019181158.2395-3-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On Fri, Oct 19, 2018 at 07:11:54PM +0100, Jean-Philippe Brucker wrote:
> The allocator doesn't really belong in drivers/iommu because some
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
> drivers/pci either since platform device also support PASID. Add the
> allocator in drivers/base.

I don't really buy this argument, in the end it is the IOMMU that
enforces the PASID mappings for a device. Why should a device not behind
an IOMMU need to allocate a pasid? Do you have examples of such devices
which also don't have their own iommu built-in?

> +int ioasid_for_each(struct ioasid_set *set, ioasid_iter_t func, void *data)
> +{
> +	int ret;
> +	struct ioasid_iter_data iter_data = {
> +		.set	= set,
> +		.func	= func,
> +		.data	= data,
> +	};
> +
> +	idr_lock(&ioasid_idr);
> +	ret = idr_for_each(&ioasid_idr, ioasid_iter, &iter_data);
> +	idr_unlock(&ioasid_idr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_for_each);

What is the intended use-case for this function?

> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	void *priv = NULL;
> +	struct ioasid_data *ioasid_data;
> +
> +	idr_lock(&ioasid_idr);
> +	ioasid_data = idr_find(&ioasid_idr, ioasid);
> +	if (ioasid_data && ioasid_data->set == set)
> +		priv = ioasid_data->private;
> +	idr_unlock(&ioasid_idr);
> +
> +	return priv;
> +}

I think using the idr_lock here will become a performance problem, as we
need this function in the SVA page-fault path to retrieve the mm_struct
belonging to a PASID.

The head comment in lib/idr.c states that it should be safe to use
rcu_readlock() on read-only iterations. If so, this should be used here
so that concurrent lookups are possible.

Regards,

	Joerg
