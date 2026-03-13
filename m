Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27F305962
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427337; cv=none; b=RZBg82xsLxPPzcyAimPk4dka+RkaBCqY1ZsqGmWrliiIKQsnOyANmENguIg8lwqoTEqTKgoKsWDE7tSbmS8Mxdr0f7+jqOVqm1SSlo38ba+PzGcEwS+Hq4ll8bRxWFtGSeCFmm9t/xM5aZbhy8itw5FeI4KUNCvaarlu32w8K2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427337; c=relaxed/simple;
	bh=vQnylcqlyNpXPh4Hod0oajC03ZDjeSSkSB2Qk9zJRY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOX4vGE6Fk0u6m/pO7xr01iBhJov98O5af6Ev6NttwV3k2SuNqXtKSWQw3Z8MDpBuhcXnlSHBFBcWAE3cFnxYqk7hKu1qQ58rdZuxxGq6nk3hsoeh/2qOe00XY9aElT6SP4NoKr9B07DqoiKefnwMnAtOIu4aQOdrQjYwYJsStE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlH2vdwb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlH2vdwb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aea4ebb048so14565ad.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773427331; x=1774032131; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/A5FBLqlUiawqC7jWNaor6H1U3Nfh/py+Xr7ugd0EOQ=;
        b=JlH2vdwb5MQ4I/bjalQ/HSqp05y+xTjJpRhfeHvMCPGeJxqKA08BU7NsePKGL5vFd1
         9xaG88peFjbMlibIXpOFLvG6Ne0KGy6yat3bUCth6TF+gJbpcKAJhJ4tQQ049DcJuBN+
         OxoWqtF1zkGwzYjDhwF/6XA5Np7nnRqerIBpWHa781iMbsKfSLXwrzaZ4m1qGBozIX9U
         Rl1TQ4MHLtvine+YNMnhXevYxhIaVB/WCpyl+t0gyHYhXFaPqteOE0h6BzDe2V7EG6kt
         Vo8VHCKREKqTdcJPCOfaNAyRS0ph26IOMifPOlHB1a5rnAttbqzJmp5Cl2t7zWWWh7Qk
         RbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427331; x=1774032131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A5FBLqlUiawqC7jWNaor6H1U3Nfh/py+Xr7ugd0EOQ=;
        b=glivD3wDm/sWVCQQ4ig6ngO8IcMaN+JLH5mLqjltmhHe/Ik493d58qReI0+ley4x4s
         FkQmItlUK+5V4C2xaQFLwIX1+l4JiKbGnd9v4ZbH3x8a4EMEk0J7mQSrniYn1mIa8CUl
         nEI/0I2L4e6k0kbhWU06kEq/WkR7H9+k78ASXvfXEgO6QBkjrVIEb2EH8j8goJczM8N0
         I6H4vbBJ4Tuqrk8MaciVU22YkGz4I1Z2dXKJEHWyQfvLN+bwE3Oa0LKtQyWlBIdj5LIY
         cndAM1NICV1uyvjEY/RSuWxOjYYPDfGY8LjNuMb1Jjx4KwbbxQYbQvGQEBS4E41bI6XN
         DgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDqXx7UeHbU4D53QjNwSdQY2PIc19AropzYiirwauVGy7jWo+QccISPLMVrdsZv9ybp0NGuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2DAHhwo6O59lZT7vNWS2bKwH57q02IQs8eCoXvKRcLMhQPiec
	4wkg7eI7Sng05QVf09IiI0e7LyvSfM3Tsn9LBRYZM7354YF5S9fNpP148ivs8JroCQ==
X-Gm-Gg: ATEYQzxkHkn6GkIp3RMbtiNRvyY3r02keippYraZf7+22okCnjBT/Z/hh85UrVNDS+2
	g5nBgvKO6rwHtsv7Za/TiqTCsz9OrMuESOaOArFF/yOZ+VMTuDqgk7QqaWLGulztPINS9JrJQpu
	YtWyHvOxfGEsRfoUJw/U4DhtoDY4ROWrzcIQ25J6cUazzbsv7thD8VcN8fn7nVN4gcrYCSv/EqG
	0PW51fgEbjpZPLBtjNFiCzmb6pQbxI418SJPU9OjWHPgAfB0Y94s5YUbBqxhrvVgB5rG3FFx5bG
	GXPD7FAcQoUU7u+RC0WoKYJunblPfd6upZw9wY7i2+e1QJdOQhCugKFFZtjRlnER70Frg2QZiFm
	DgYs3yOI38C+WRtbT1aEB6PIumBs/wVL3TV/QkhWoAqPJ8gfnxUZQO+7Fihrn8zWPRNz+wMmsR7
	gltHtgTRU7TohuJlYhbDNulWd3vB4WAPNdrPkeEVqvOJhzDeKlOInEd9Hf0qcxBA==
X-Received: by 2002:a17:902:ce82:b0:2ae:618b:7522 with SMTP id d9443c01a7336-2b0420ab8damr476235ad.4.1773427330358;
        Fri, 13 Mar 2026 11:42:10 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm6490221b3a.32.2026.03.13.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:42:09 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:42:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <abROLLfSUK8pXM5J@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abNH7LAj9thuGOoG@google.com>

On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
>> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
>> they support IOMMU domain preservation across liveupdate. The new IOMMU
>> domain preserve, unpreserve and restore APIs call these ops to perform
>> respective live update operations.
>>
>> Similarly add IOMMU ops to preserve/unpreserve a device. These can be
>> implemented by the IOMMU drivers that support preservation of devices
>> that have their IOMMU domains preserved. During device preservation the
>> state of the associated IOMMU is also preserved. The device can only be
>> preserved if the attached iommu domain is preserved and the associated
>> iommu supports preservation.
>>
>> The preserved state of the device and IOMMU needs to be fetched during
>> shutdown and boot in the next kernel. Add APIs that can be used to fetch
>> the preserved state of a device and IOMMU. The APIs will only be used
>> during shutdown and after liveupdate so no locking needed.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommu.c      |   3 +
>>  drivers/iommu/liveupdate.c | 326 +++++++++++++++++++++++++++++++++++++
>>  include/linux/iommu-lu.h   | 119 ++++++++++++++
>>  include/linux/iommu.h      |  32 ++++
>>  4 files changed, 480 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4926a43118e6..c0632cb5b570 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -389,6 +389,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
>>
>>  	mutex_init(&param->lock);
>>  	dev->iommu = param;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	dev->iommu->device_ser = NULL;
>> +#endif
>>  	return param;
>>  }
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 6189ba32ff2c..83eb609b3fd7 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/iommu-lu.h>
>>  #include <linux/iommu.h>
>> +#include <linux/pci.h>
>>  #include <linux/errno.h>
>>
>>  static void iommu_liveupdate_restore_objs(u64 next)
>> @@ -175,3 +176,328 @@ int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  	return liveupdate_unregister_flb(handler, &iommu_flb);
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>> +
>> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> +				    void *arg)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct devices_ser *devices;
>> +	int ret, i, idx;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> +	if (ret)
>> +		return -ENOENT;
>> +
>> +	devices = __va(obj->ser->devices_phys);
>> +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
>> +		if (idx >= MAX_DEVICE_SERS) {
>> +			devices = __va(devices->objs.next_objs);
>> +			idx = 0;
>> +		}
>> +
>> +		if (devices->devices[idx].obj.deleted)
>> +			continue;
>> +
>> +		ret = fn(&devices->devices[idx], arg);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
>> +
>> +static inline bool device_ser_match(struct device_ser *match,
>> +				    struct pci_dev *pdev)
>> +{
>> +	return match->devid == pci_dev_id(pdev) && match->pci_domain == pci_domain_nr(pdev->bus);
>> +}
>> +
>> +struct device_ser *iommu_get_device_preserved_data(struct device *dev)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct devices_ser *devices;
>> +	int ret, i, idx;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return NULL;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	devices = __va(obj->ser->devices_phys);
>> +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
>> +		if (idx >= MAX_DEVICE_SERS) {
>> +			devices = __va(devices->objs.next_objs);
>> +			idx = 0;
>> +		}
>> +
>> +		if (devices->devices[idx].obj.deleted)
>> +			continue;
>> +
>> +		if (device_ser_match(&devices->devices[idx], to_pci_dev(dev))) {
>> +			devices->devices[idx].obj.incoming = true;
>> +			return &devices->devices[idx];
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(iommu_get_device_preserved_data);
>> +
>> +struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct iommus_ser *iommus;
>> +	int ret, i, idx;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	iommus = __va(obj->ser->iommus_phys);
>> +	for (i = 0, idx = 0; i < obj->ser->nr_iommus; ++i, ++idx) {
>> +		if (idx >= MAX_IOMMU_SERS) {
>> +			iommus = __va(iommus->objs.next_objs);
>> +			idx = 0;
>> +		}
>> +
>> +		if (iommus->iommus[idx].obj.deleted)
>> +			continue;
>> +
>> +		if (iommus->iommus[idx].token == token &&
>> +		    iommus->iommus[idx].type == type)
>> +			return &iommus->iommus[idx];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(iommu_get_preserved_data);
>> +
>> +static int reserve_obj_ser(struct iommu_objs_ser **objs_ptr, u64 max_objs)
>
>Isn't this more of an "insert" / "populate" / write_ser_entry? We can
>rename it to something like iommu_ser_push_entry / iommu_ser_write_entry

This is reserving an object in the objects array. The object is filled
once reservation is done. Maybe I can call it alloc_obj_ser or
alloc_entry_ser.
>
>> +{
>> +	struct iommu_objs_ser *next_objs, *objs = *objs_ptr;
>
>Not loving these names :(
>
>TBH, the reserve_obj_ser function isn't too readable, esp. with all the
>variable names, here and in the lu header.. I've had to go back n forth
>to the first patch. For example, here next_objs can be next_objs_page &
>objs can be curr_page. (PTAL at my reply on PATCH 01 about renaming).

Basically with current naming there are "serialization objects" in
"serializatoin object arrays". The object is a "base" type with
"inherited" types for iommu, domain etc. I will add explanation of all
this in the ABI header.

Maybe we can name it to:

struct iommu_obj_ser;
struct iommu_obj_array_ser; or struct iommu_obj_ser_array;

Then for reserve/alloc, we use names like "next_obj_array" and
"curr_obj_array"?
>
>> +	int idx;
>> +
>> +	if (objs->nr_objs == max_objs) {
>> +		next_objs = kho_alloc_preserve(PAGE_SIZE);
>> +		if (IS_ERR(next_objs))
>> +			return PTR_ERR(next_objs);
>> +
>> +		objs->next_objs = virt_to_phys(next_objs);
>> +		objs = next_objs;
>> +		*objs_ptr = objs;
>> +		objs->nr_objs = 0;
>> +		objs->next_objs = 0;
>
>This seems redundant, no need to zero these out, kho_alloc_preserve
>passes __GFP_ZERO to folio_alloc [1], which should z-alloc the pages.

Agreed. Will remove this.
>
>> +	}
>> +
>> +	idx = objs->nr_objs++;
>> +	return idx;
>> +}
>
>Just to give a mental model to fellow reviewers, here's how this is laid
>out:
>
>----------------------------------------------------------------------
>[ PAGE START ]                                                       |
>----------------------------------------------------------------------
>| iommu_objs_ser (The Page Header)                                   |
>|   - next_objs: 0x0000 (End of the page-chain)                      |
>|   - nr_objs: 2                                                     |
>----------------------------------------------------------------------
>| ITEM 0: iommu_domain_ser                                           |
>|   [ iommu_obj_ser (The entry header) ]                             |
>|     - idx: 0                                                       |
>|     - ref_count: 1                                                 |
>|     - deleted: 0                                                   |
>|   [ Domain Data ]                                                  |
>----------------------------------------------------------------------
>| ITEM 1: iommu_domain_ser                                           |
>|   [ iommu_obj_ser (The Price Tag) ]                                |
>|     - idx: 1                                                       |
>|     - ref_count: 1                                                 |
>|     - deleted: 0                                                   |
>|   [ Domain Data ]                                                  |
>----------------------------------------------------------------------
>| ... (Empty space for more domains) ...                             |
>|                                                                    |
>----------------------------------------------------------------------
>[ PAGE END ]                                                         |
>----------------------------------------------------------------------

+1

Will add a table in the header as you suggested.
>
>> +
>> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	int idx, ret;
>> +
>> +	if (!domain->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ret;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommu_domains,
>> +			      MAX_IOMMU_DOMAIN_SERS);
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	domain_ser = &flb_obj->iommu_domains->iommu_domains[idx];
>
>This is slightly less-readable as well, I understand we're trying to:
>
>iommu_domains_ser -> iommu_domain_ser[idx] but the same name
>(iommu_domains) makes it difficult to read.. we should rename this as:

Agreed.

I will update it to,

&flb_obj->curr_iommu_domains->domain_array[idx]
>
>&flb_obj->iommu_domains_page->domain_entries[idx] or something for
>better readability..
>
>Also, let's add a comment explaining that reserve_obj_ser actually
>advances the flb_obj ptr when necessary..

Agreed.
>
>IIUC, we start with PAGE 0 initially, store it's phys in the
>iommu_flb_preserve op (the iommu_ser_phys et al) & then we go on
>alloc-ing more pages and keep storing the "current" active page with the
>liveupdate core. Now when we jump into the new kernel, we read the
>ser_phys and then follow the page chain, right?

Yes, we do an initial allocation of arrays for each object type and then
later allocate more as needed. The flb_obj holds the address of
currently active array.

I will add this explanation in the header.
>
>> +	idx = flb_obj->ser->nr_domains++;
>> +	domain_ser->obj.idx = idx;
>> +	domain_ser->obj.ref_count = 1;
>> +
>> +	ret = domain->ops->preserve(domain, domain_ser);
>> +	if (ret) {
>> +		domain_ser->obj.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	domain->preserved_state = domain_ser;
>> +	*ser = domain_ser;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
>> +
>> +void iommu_domain_unpreserve(struct iommu_domain *domain)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	int ret;
>> +
>> +	if (!domain->ops->unpreserve)
>> +		return;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +
>> +	/*
>> +	 * There is no check for attached devices here. The correctness relies
>> +	 * on the Live Update Orchestrator's session lifecycle. All resources
>> +	 * (iommufd, vfio devices) are preserved within a single session. If the
>> +	 * session is torn down, the .unpreserve callbacks for all files will be
>> +	 * invoked, ensuring a consistent cleanup without needing explicit
>> +	 * refcounting for the serialized objects here.
>> +	 */
>> +	domain_ser = domain->preserved_state;
>> +	domain->ops->unpreserve(domain, domain_ser);
>> +	domain_ser->obj.deleted = true;
>> +	domain->preserved_state = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
>> +
>> +static int iommu_preserve_locked(struct iommu_device *iommu)
>> +{
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct iommu_ser *iommu_ser;
>> +	int idx, ret;
>> +
>> +	if (!iommu->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (iommu->outgoing_preserved_state) {
>> +		iommu->outgoing_preserved_state->obj.ref_count++;
>> +		return 0;
>> +	}
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ret;
>> +
>> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommus,
>> +			      MAX_IOMMU_SERS);
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	iommu_ser = &flb_obj->iommus->iommus[idx];
>> +	idx = flb_obj->ser->nr_iommus++;
>> +	iommu_ser->obj.idx = idx;
>> +	iommu_ser->obj.ref_count = 1;
>> +
>> +	ret = iommu->ops->preserve(iommu, iommu_ser);
>> +	if (ret)
>> +		iommu_ser->obj.deleted = true;
>> +
>> +	iommu->outgoing_preserved_state = iommu_ser;
>> +	return ret;
>> +}
>> +
>> +static void iommu_unpreserve_locked(struct iommu_device *iommu)
>> +{
>> +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
>> +
>> +	iommu_ser->obj.ref_count--;
>> +	if (iommu_ser->obj.ref_count)
>> +		return;
>> +
>> +	iommu->outgoing_preserved_state = NULL;
>> +	iommu->ops->unpreserve(iommu, iommu_ser);
>> +	iommu_ser->obj.deleted = true;
>> +}
>> +
>> +int iommu_preserve_device(struct iommu_domain *domain,
>> +			  struct device *dev, u64 token)
>> +{
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct device_ser *device_ser;
>> +	struct dev_iommu *iommu;
>> +	struct pci_dev *pdev;
>> +	int ret, idx;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!domain->preserved_state)
>> +		return -EINVAL;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	iommu = dev->iommu;
>> +	if (!iommu->iommu_dev->ops->preserve_device ||
>> +	    !iommu->iommu_dev->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ret;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->devices,
>> +			      MAX_DEVICE_SERS);
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	device_ser = &flb_obj->devices->devices[idx];
>> +	idx = flb_obj->ser->nr_devices++;
>> +	device_ser->obj.idx = idx;
>> +	device_ser->obj.ref_count = 1;
>> +
>> +	ret = iommu_preserve_locked(iommu->iommu_dev);
>> +	if (ret) {
>> +		device_ser->obj.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
>> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
>> +	device_ser->devid = pci_dev_id(pdev);
>> +	device_ser->pci_domain = pci_domain_nr(pdev->bus);
>> +	device_ser->token = token;
>> +
>> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
>> +	if (ret) {
>> +		device_ser->obj.deleted = true;
>> +		iommu_unpreserve_locked(iommu->iommu_dev);
>> +		return ret;
>> +	}
>> +
>> +	dev->iommu->device_ser = device_ser;
>> +	return 0;
>> +}
>> +
>> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>> +{
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct device_ser *device_ser;
>> +	struct dev_iommu *iommu;
>> +	struct pci_dev *pdev;
>> +	int ret;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	iommu = dev->iommu;
>> +	if (!iommu->iommu_dev->ops->unpreserve_device ||
>> +	    !iommu->iommu_dev->ops->unpreserve)
>> +		return;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (WARN_ON(ret))
>> +		return;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	device_ser = dev_iommu_preserved_state(dev);
>> +	if (WARN_ON(!device_ser))
>> +		return;
>> +
>> +	iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
>> +	dev->iommu->device_ser = NULL;
>> +
>> +	iommu_unpreserve_locked(iommu->iommu_dev);
>> +}
>
>I'm wondering ig we should guard these APIs against accidental or
>potential abuse by other in-kernel drivers. Since the Live Update
>Orchestrator (LUO) is architecturally designed around user-space
>driven sequences (IOCTLs, specific mutex ordering, etc.), for now.
>
>Since the header-file is also under include/linux, we should avoid any
>possibility where we end up having drivers depending on these API.
>We could add a check based on dma owner:
>
>+	/* Only devices explicitly claimed by a user-space driver
>+	 * (VFIO/IOMMUFD) are eligible for Live Update preservation.
>+	 */
>+	if (!iommu_dma_owner_claimed(dev))
>+		return -EPERM;
>
>This should ensure we aren't creating 'zombie' preserved states for
>devices not managed by IOMMUFD/VFIO.

Agreed. I will update this.
>
>
>> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
>> index 59095d2f1bb2..48c07514a776 100644
>> --- a/include/linux/iommu-lu.h
>> +++ b/include/linux/iommu-lu.h
>> @@ -8,9 +8,128 @@
>>  #ifndef _LINUX_IOMMU_LU_H
>>  #define _LINUX_IOMMU_LU_H
>>
>> +#include <linux/device.h>
>> +#include <linux/iommu.h>
>>  #include <linux/liveupdate.h>
>>  #include <linux/kho/abi/iommu.h>
>>
>> +typedef int (*iommu_preserved_device_iter_fn)(struct device_ser *ser,
>> +					      void *arg);
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +static inline void *dev_iommu_preserved_state(struct device *dev)
>> +{
>> +	struct device_ser *ser;
>> +
>> +	if (!dev->iommu)
>> +		return NULL;
>> +
>> +	ser = dev->iommu->device_ser;
>> +	if (ser && !ser->obj.incoming)
>> +		return ser;
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline void *dev_iommu_restored_state(struct device *dev)
>> +{
>> +	struct device_ser *ser;
>> +
>> +	if (!dev->iommu)
>> +		return NULL;
>> +
>> +	ser = dev->iommu->device_ser;
>> +	if (ser && ser->obj.incoming)
>> +		return ser;
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>> +{
>> +	struct iommu_domain_ser *ser;
>> +
>> +	ser = domain->preserved_state;
>> +	if (ser && ser->obj.incoming)
>> +		return ser;
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
>> +{
>> +	struct device_ser *ser = dev_iommu_restored_state(dev);
>> +
>> +	if (ser && iommu_domain_restored_state(domain))
>> +		return ser->domain_iommu_ser.did;
>> +
>> +	return -1;
>> +}
>> +
>> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> +				    void *arg);
>> +struct device_ser *iommu_get_device_preserved_data(struct device *dev);
>> +struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type);
>> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>> +void iommu_domain_unpreserve(struct iommu_domain *domain);
>> +int iommu_preserve_device(struct iommu_domain *domain,
>> +			  struct device *dev, u64 token);
>> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
>> +#else
>> +static inline void *dev_iommu_preserved_state(struct device *dev)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline void *dev_iommu_restored_state(struct device *dev)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
>> +{
>> +	return -1;
>> +}
>> +
>> +static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline struct device_ser *iommu_get_device_preserved_data(struct device *dev)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void iommu_domain_unpreserve(struct iommu_domain *domain)
>> +{
>> +}
>> +
>> +static inline int iommu_preserve_device(struct iommu_domain *domain,
>> +					struct device *dev, u64 token)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>> +{
>> +}
>> +#endif
>> +
>>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>>  int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 54b8b48c762e..bd949c1ce7c5 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -14,6 +14,8 @@
>>  #include <linux/err.h>
>>  #include <linux/of.h>
>>  #include <linux/iova_bitmap.h>
>> +#include <linux/atomic.h>
>> +#include <linux/kho/abi/iommu.h>
>>  #include <uapi/linux/iommufd.h>
>>
>>  #define IOMMU_READ	(1 << 0)
>> @@ -248,6 +250,10 @@ struct iommu_domain {
>>  			struct list_head next;
>>  		};
>>  	};
>> +
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct iommu_domain_ser *preserved_state;
>> +#endif
>>  };
>>
>>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> @@ -647,6 +653,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>>   *               resources shared/passed to user space IOMMU instance. Associate
>>   *               it with a nesting @parent_domain. It is required for driver to
>>   *               set @viommu->ops pointing to its own viommu_ops
>> + * @preserve_device: Preserve state of a device for liveupdate.
>> + * @unpreserve_device: Unpreserve state that was preserved earlier.
>> + * @preserve: Preserve state of iommu translation hardware for liveupdate.
>> + * @unpreserve: Unpreserve state of iommu that was preserved earlier.
>>   * @owner: Driver module providing these ops
>>   * @identity_domain: An always available, always attachable identity
>>   *                   translation.
>> @@ -703,6 +713,11 @@ struct iommu_ops {
>>  			   struct iommu_domain *parent_domain,
>>  			   const struct iommu_user_data *user_data);
>>
>> +	int (*preserve_device)(struct device *dev, struct device_ser *device_ser);
>> +	void (*unpreserve_device)(struct device *dev, struct device_ser *device_ser);
>
>Nit: Let's move the _device ops under the comment:
>`/* Per device IOMMU features */`

I will move these.
>
>> +	int (*preserve)(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>> +
>
>I'm wondering if there's any benefit to add these ops under a #ifdef ?

These should be NULL when liveupdate is disabled, so #ifdef should not
be needed. Not sure how much space we save if don't define these. I will
move these in #ifdef anyway.
>
>>  	const struct iommu_domain_ops *default_domain_ops;
>>  	struct module *owner;
>>  	struct iommu_domain *identity_domain;
>> @@ -749,6 +764,11 @@ struct iommu_ops {
>>   *                           specific mechanisms.
>>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>>   * @free: Release the domain after use.
>> + * @preserve: Preserve the iommu domain for liveupdate.
>> + *            Returns 0 on success, a negative errno on failure.
>> + * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
>> + * @restore: Restore the iommu domain after liveupdate.
>> + *           Returns 0 on success, a negative errno on failure.
>>   */
>>  struct iommu_domain_ops {
>>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
>> @@ -779,6 +799,9 @@ struct iommu_domain_ops {
>>  				  unsigned long quirks);
>>
>>  	void (*free)(struct iommu_domain *domain);
>> +	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
>> +	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
>> +	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
>>  };
>>
>>  /**
>> @@ -790,6 +813,8 @@ struct iommu_domain_ops {
>>   * @singleton_group: Used internally for drivers that have only one group
>>   * @max_pasids: number of supported PASIDs
>>   * @ready: set once iommu_device_register() has completed successfully
>> + * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
>> + * liveupdate.
>>   */
>>  struct iommu_device {
>>  	struct list_head list;
>> @@ -799,6 +824,10 @@ struct iommu_device {
>>  	struct iommu_group *singleton_group;
>>  	u32 max_pasids;
>>  	bool ready;
>> +
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct iommu_ser *outgoing_preserved_state;
>> +#endif
>>  };
>>
>>  /**
>> @@ -853,6 +882,9 @@ struct dev_iommu {
>>  	u32				pci_32bit_workaround:1;
>>  	u32				require_direct:1;
>>  	u32				shadow_on_flush:1;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct device_ser		*device_ser;
>> +#endif
>>  };
>>
>>  int iommu_device_register(struct iommu_device *iommu,
>
>Thanks,
>Praan
>
>[1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/kexec_handover.c#L1182
