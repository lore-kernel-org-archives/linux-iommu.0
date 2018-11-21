From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC PATCH 2/6] drivers core: Add I/O ASID allocator
Date: Wed, 21 Nov 2018 19:10:20 +0000
Message-ID: <62f05552-df46-6e12-10ed-820429dfda59@amd.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181019181158.2395-3-jean-philippe.brucker@arm.com>
	<20181112144039.GA25808@8bytes.org>
	<8f17757a-c657-aab9-a6a0-fb0cc9c610a8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8f17757a-c657-aab9-a6a0-fb0cc9c610a8-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Content-ID: <64D1B7FB802DA5409481666838A33E08-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am 21.11.18 um 12:16 schrieb Jean-Philippe Brucker:
> On 12/11/2018 14:40, Joerg Roedel wrote:
>> Hi Jean-Philippe,
>>
>> On Fri, Oct 19, 2018 at 07:11:54PM +0100, Jean-Philippe Brucker wrote:
>>> The allocator doesn't really belong in drivers/iommu because some
>>> drivers would like to allocate PASIDs for devices that aren't managed by
>>> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
>>> drivers/pci either since platform device also support PASID. Add the
>>> allocator in drivers/base.
>> I don't really buy this argument, in the end it is the IOMMU that
>> enforces the PASID mappings for a device. Why should a device not behind
>> an IOMMU need to allocate a pasid? Do you have examples of such devices
>> which also don't have their own iommu built-in?
> I misunderstood that requirement. Reading through the thread again
> (https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg25640.html)
> it's more about a device using PASIDs as context IDs. Some contexts are
> not bound to processes but they still need their ID in the same PASID
> space as the contexts that are bound to process address spaces. So we
> can keep that code in drivers/iommu

The problem with that approach is that we also need this allocator when 
IOMMU is completely disabled.

In other words PASIDs are used as contexts IDs by the hardware for 
things like signaling which application has caused an interrupt/event 
even when they are not used by IOMMU later on.

Additional to that we have some MMUs which are internal to the devices 
(GPUVM on AMD GPUs for example, similar exists for NVidia) which uses 
PASIDs for address translation internally in the device.

All of that is completely unrelated to IOMMU, but when IOMMU is enabled 
you need to use the same allocator because all use cases use the same ID 
space.

Regards,
Christian.

>
>>> +int ioasid_for_each(struct ioasid_set *set, ioasid_iter_t func, void *data)
>>> +{
>>> +	int ret;
>>> +	struct ioasid_iter_data iter_data = {
>>> +		.set	= set,
>>> +		.func	= func,
>>> +		.data	= data,
>>> +	};
>>> +
>>> +	idr_lock(&ioasid_idr);
>>> +	ret = idr_for_each(&ioasid_idr, ioasid_iter, &iter_data);
>>> +	idr_unlock(&ioasid_idr);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(ioasid_for_each);
>> What is the intended use-case for this function?
> I'm using it in sva_bind(), to see if there already exists an io_mm
> associated to the mm_struct given as argument
>
>>> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid)
>>> +{
>>> +	void *priv = NULL;
>>> +	struct ioasid_data *ioasid_data;
>>> +
>>> +	idr_lock(&ioasid_idr);
>>> +	ioasid_data = idr_find(&ioasid_idr, ioasid);
>>> +	if (ioasid_data && ioasid_data->set == set)
>>> +		priv = ioasid_data->private;
>>> +	idr_unlock(&ioasid_idr);
>>> +
>>> +	return priv;
>>> +}
>> I think using the idr_lock here will become a performance problem, as we
>> need this function in the SVA page-fault path to retrieve the mm_struct
>> belonging to a PASID.
>>
>> The head comment in lib/idr.c states that it should be safe to use
>> rcu_readlock() on read-only iterations. If so, this should be used here
>> so that concurrent lookups are possible.
> Agreed. I have a patch to use the RCU which looks simple enough, but
> since I haven't used RCU before I wasn't comfortable squashing it right
> away.
>
> Thanks,
> Jean
>
> diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
> index 5eb3abbf69ac..fa3b48c9c044 100644
> --- a/drivers/base/ioasid.c
> +++ b/drivers/base/ioasid.c
> @@ -13,6 +13,7 @@ struct ioasid_data {
>   	int id;
>   	struct ioasid_set *set;
>   	void *private;
> +	struct rcu_head rcu;
>   };
>
>   static DEFINE_IDR(ioasid_idr);
> @@ -56,7 +57,8 @@ void ioasid_free(ioasid_t ioasid)
>   	ioasid_data = idr_remove(&ioasid_idr, ioasid);
>   	idr_unlock(&ioasid_idr);
>
> -	kfree(ioasid_data);
> +	if (ioasid_data)
> +		kfree_rcu(ioasid_data, rcu);
>   }
>   EXPORT_SYMBOL_GPL(ioasid_free);
>
> @@ -95,9 +97,9 @@ int ioasid_for_each(struct ioasid_set *set,
> ioasid_iter_t func, void *data)
>   		.data	= data,
>   	};
>
> -	idr_lock(&ioasid_idr);
> +	rcu_read_lock();
>   	ret = idr_for_each(&ioasid_idr, ioasid_iter, &iter_data);
> -	idr_unlock(&ioasid_idr);
> +	rcu_read_unlock();
>
>   	return ret;
>   }
> @@ -111,11 +113,11 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t
> ioasid)
>   	void *priv = NULL;
>   	struct ioasid_data *ioasid_data;
>
> -	idr_lock(&ioasid_idr);
> +	rcu_read_lock();
>   	ioasid_data = idr_find(&ioasid_idr, ioasid);
>   	if (ioasid_data && ioasid_data->set == set)
>   		priv = ioasid_data->private;
> -	idr_unlock(&ioasid_idr);
> +	rcu_read_unlock();
>
>   	return priv;
>   }
>
