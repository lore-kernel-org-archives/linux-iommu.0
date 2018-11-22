From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/6] drivers core: Add I/O ASID allocator
Date: Thu, 22 Nov 2018 09:44:29 +0100
Message-ID: <20181122084429.GB1586@8bytes.org>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181019181158.2395-3-jean-philippe.brucker@arm.com>
	<20181112144039.GA25808@8bytes.org>
	<8f17757a-c657-aab9-a6a0-fb0cc9c610a8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8f17757a-c657-aab9-a6a0-fb0cc9c610a8-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On Wed, Nov 21, 2018 at 11:16:07AM +0000, Jean-Philippe Brucker wrote:
> On 12/11/2018 14:40, Joerg Roedel wrote:
> > What is the intended use-case for this function?
> 
> I'm using it in sva_bind(), to see if there already exists an io_mm
> associated to the mm_struct given as argument

Can we store the pasid in the mm_struct directly? We still need a
reverse mapping for the page-fault path, but storing information in
mm_struct makes at least this path faster.

> diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
> index 5eb3abbf69ac..fa3b48c9c044 100644
> --- a/drivers/base/ioasid.c
> +++ b/drivers/base/ioasid.c
> @@ -13,6 +13,7 @@ struct ioasid_data {
>  	int id;
>  	struct ioasid_set *set;
>  	void *private;
> +	struct rcu_head rcu;
>  };
> 
>  static DEFINE_IDR(ioasid_idr);
> @@ -56,7 +57,8 @@ void ioasid_free(ioasid_t ioasid)
>  	ioasid_data = idr_remove(&ioasid_idr, ioasid);
>  	idr_unlock(&ioasid_idr);
> 
> -	kfree(ioasid_data);
> +	if (ioasid_data)
> +		kfree_rcu(ioasid_data, rcu);
>  }
>  EXPORT_SYMBOL_GPL(ioasid_free);
> 
> @@ -95,9 +97,9 @@ int ioasid_for_each(struct ioasid_set *set,
> ioasid_iter_t func, void *data)
>  		.data	= data,
>  	};
> 
> -	idr_lock(&ioasid_idr);
> +	rcu_read_lock();
>  	ret = idr_for_each(&ioasid_idr, ioasid_iter, &iter_data);
> -	idr_unlock(&ioasid_idr);
> +	rcu_read_unlock();
> 
>  	return ret;
>  }
> @@ -111,11 +113,11 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t
> ioasid)
>  	void *priv = NULL;
>  	struct ioasid_data *ioasid_data;
> 
> -	idr_lock(&ioasid_idr);
> +	rcu_read_lock();
>  	ioasid_data = idr_find(&ioasid_idr, ioasid);
>  	if (ioasid_data && ioasid_data->set == set)
>  		priv = ioasid_data->private;
> -	idr_unlock(&ioasid_idr);
> +	rcu_read_unlock();
> 
>  	return priv;
>  }

Looks good to me.
