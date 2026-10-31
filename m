Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414826;
	b=0QzLCj6d0KodIN/Rlpojja8pD/OI6s2q8zgzsnQsaVNF2CGkm0HWgsaG8chfKSQCepmu
	 uUIApa/ttKyxIIu2eEnHutFjnhnfTB02kLEIPpHolGnr1u+vqmFmxk57699ZwTvO5a3+5
	 kP1RuiiqdISUZLtFkXrVQ6kLXa8F9iMJuMLepnK+jxcRrrnUzw4GW+vXzL1PK5JC8bCRB
	 SriJ7XXC+V7MhrD7XtlCGw0AdwhdO9s2EmcFD7eFdBYXRF/X5kC5QVKomPr7WKSH3RcnV
	 nfg/mI1kfDN3LBI3cWPhI3Xhs8tQ/HJjAXfkFrFR37S+paRHcCk72CI9ReecvzcBFyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414826;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iSKGNFmKLTpmgOIzqerV8G2tWlRDYIbrTVmalAdizuI=;
	b=4wQgg+tMC6dvWTusQmrBeZc5owkIozSv7976D98PDobv8gmsmeE50G1SO+tA4od3WVJh
	 Jr1F83DqKqRoZLdYCbMLVu46FEmNWSG7coarm14y7ddWPQtCWTE5fiWAQuv5mzOP6KS/O
	 wGbirqVAVCJq+e2KI5+aoMHixpXIydTuvW2RlEoPL/7f7oubhGbGqZnfrg6nUs+7JNQSk
	 a4ugOTxNwDbkHJlpB5twgWtJFv/TWl/mhFy/d9rn0EyRVK1bUPHW35KnNXHkXx/3bJOoV
	 ca2vInwOaIvKrd1DcwyvLbkUHEz+wEH7kzMnUp7jS94t1QDKKAC8TyO9yJ0GNVMupiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d1gNQvdA;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FB606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 02:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E04FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d1gNQvdA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793414825; x=1824950825;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwPYZzHb0mj1mjEbXeNxm8CM4NcJfsvX2Gzy0sS/kH8=;
  b=d1gNQvdAILLyb9JNUJdaNY6Yb6fQ3ZYYI336FPfiv4AdEYA3AFiUTY3N
   htJ1sJYyrDv8XpXjWRWPpcbLSIXFdtFJBR9BklBnpglv1YEc1yN70gzSC
   XqbxigIF1kNziTwusBECLZAdOvXOE0mgyk/hToFg1kFl8s+rBFaxfdN6Y
   JWW7KvDkTafrP71x79ZmYviCM5o6ZTJkGYqsPL34DAyL7DMn7ejx2E34P
   Q/PxRYDr7Wvks86h0ci7w28Lad7xkM09Lz/8K/QH8p+oUMEEGSkcmWR6B
   2M05KhaAxfLp6k6VJ2gU6sHWVsZ7N9FdHuCMN8wLlpQs/aDDg6qsZe4dg
   g==;
X-CSE-ConnectionGUID: 5SEtvwrZTb6FhWN3Xua4xA==
X-CSE-MsgGUID: pYCciW1pQmipzCnux44WKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2075244"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2075244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:47:03 -0700
X-CSE-ConnectionGUID: /PhNjvBYRlyhxoXUfZteEQ==
X-CSE-MsgGUID: KMELGtAZSbGpkpSsz46Iuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5971572"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:46:59 -0700
Message-ID: <98fe2806-d4a3-4bee-9324-d1862b2a2cb4@linux.intel.com>
Date: Sat, 31 Oct 2026 10:46:56 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, YiFei Zhu <zhuyifei@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 15/18] iommufd: Persist iommu hardware pagetables for
 live update
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-16-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-16-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Register iommufd with the LUO framework and implement the preserve and
> unpreserve ops to save marked HWPTs.
> 
> To make sure mappings do not change during preserved state, add a
> liveupdate_immutable flag to IOAS. When an HWPT is preserved, its IOAS
> is marked immutable and any map/unmap attempts will fail with -EBUSY.
> This is synchronized using the domains_rwsem to prevent races with
> concurrent mapping operations.
> 
> The preserve callback iterates over the marked HWPTs, verifies that the
> backing memory pages are preserved, and calls iommu_preserve_domain() to
> preserve the associated IOMMU domain.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   MAINTAINERS                             |   1 +
>   drivers/iommu/iommufd/io_pagetable.c    |  24 ++
>   drivers/iommu/iommufd/iommufd_private.h |  16 ++
>   drivers/iommu/iommufd/liveupdate.c      | 327 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/main.c            |  10 +-
>   include/linux/kho/abi/iommufd.h         |  56 ++++
>   6 files changed, 433 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/kho/abi/iommufd.h
> 

[...]
> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
> index 5fb491ff3a3d..828203d7254c 100644
> --- a/drivers/iommu/iommufd/liveupdate.c
> +++ b/drivers/iommu/iommufd/liveupdate.c
> @@ -9,9 +9,28 @@
>   
>   #include <linux/file.h>
>   #include <linux/iommufd.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/iommufd.h>
>   #include <linux/liveupdate.h>
> +#include <linux/iommu-liveupdate.h>
> +#include <linux/mm.h>
> +#include <linux/pci.h>
>   
>   #include "iommufd_private.h"
> +#include "io_pagetable.h"
> +
> +static u32 iopt_inc_num_preserved_domains(struct io_pagetable *iopt)
> +{
> +	guard(rwsem_write)(&iopt->domains_rwsem);
> +	return ++iopt->num_preserved_domains;
> +}
> +
> +static void iopt_dec_num_preserved_domains(struct io_pagetable *iopt)
> +{
> +	guard(rwsem_write)(&iopt->domains_rwsem);
> +	if (!WARN_ON(!iopt->num_preserved_domains))
> +		iopt->num_preserved_domains--;
> +}
>   
>   int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>   {
> @@ -70,3 +89,311 @@ int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ictx, &hwpt->common.obj);
>   	return rc;
>   }
> +
> +static int iopt_area_validate_file_pages(struct iopt_area *area)
> +{
> +	unsigned long last_index = iopt_area_last_index(area);
> +	unsigned long index = iopt_area_index(area);
> +	unsigned int page_offset = area->page_offset;
> +	struct iopt_pages *pages = area->pages;
> +	unsigned long iova = iopt_area_iova(area);
> +
> +	guard(mutex)(&pages->mutex);
> +	if (WARN_ON(!area->storage_domain))
> +		return -EINVAL;
> +
> +	while (index <= last_index) {
> +		phys_addr_t phys = iommu_iova_to_phys(area->storage_domain,
> +						      iova) - page_offset;

iommu_iova_to_phys() returns 0 when there is no underlying DMA
translation. It would be better to check for !phys and return -EINVAL
before passing it to page_folio():

		if (!phys)
			return -EINVAL;

> +		struct folio *folio = page_folio(pfn_to_page(PHYS_PFN(phys)));
> +
> +		if (folio->mapping != pages->file->f_mapping)
> +			return -EINVAL;
> +
> +		iova += PAGE_SIZE - page_offset;

This walks a full page table per 4K page size, right? Isn't it slow for
large mappings? Why not jump ahead by folio_size()?

> +		page_offset = 0;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int iopt_validate_preserved_memory(struct io_pagetable *iopt,
> +					  struct liveupdate_session *s)
> +{
> +	struct iopt_area *area;
> +	int ret = 0;
> +
> +	down_read(&iopt->iova_rwsem);
> +	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
> +	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
> +		struct iopt_pages *pages = area->pages;
> +
> +		if (!pages)
> +			continue;
> +
> +		/* Only allow file based mapping */
> +		if (pages->type != IOPT_ADDRESS_FILE) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/* Make sure that the file was preserved. */
> +		ret = liveupdate_get_token_outgoing(s, pages->file, NULL);
> +		if (ret)
> +			break;
> +
> +		/*
> +		 * Make sure the mapped pages are still associated with the
> +		 * preserved memfd.
> +		 */
> +		ret = iopt_area_validate_file_pages(area);
> +		if (ret)
> +			break;
> +	}
> +	up_read(&iopt->iova_rwsem);
> +
> +	return ret;
> +}
> +
> +static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
> +				 struct iommufd_hwpt_ser *hwpt_ser,
> +				 struct liveupdate_session *session)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	int rc;
> +
> +	/*
> +	 * Make IOAS immutable so the DMA mappings do not change while
> +	 * the HWPT is preserved. Since one IOAS can have multiple
> +	 * HWPTs, if an error occurs this call needs to make the IOAS
> +	 * mutable again if it was the one that made it immutable.
> +	 */
> +	if (iopt_inc_num_preserved_domains(&hwpt->ioas->iopt) == 1) {
> +		rc = iopt_validate_preserved_memory(&hwpt->ioas->iopt, session);
> +		if (rc)
> +			goto err;
> +	}
> +
> +	hwpt_ser->size = sizeof(*hwpt_ser);
> +	hwpt_ser->token = hwpt->liveupdate_token;
> +
> +	rc = iommu_preserve_domain(hwpt->common.domain, &domain_ser);
> +	if (rc < 0)
> +		goto err;
> +
> +	hwpt_ser->domain_ser_phys = virt_to_phys(domain_ser);
> +	return 0;
> +
> +err:
> +	iopt_dec_num_preserved_domains(&hwpt->ioas->iopt);
> +	return rc;
> +}
> +
> +static void _iommufd_unpreserve(struct iommufd_ctx *ictx,
> +				struct iommufd_ser *ser)
> +{
> +	struct iommufd_hwpt_paging *hwpt;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		if (!hwpt->liveupdate_preserved)
> +			continue;
> +
> +		xa_unlock(&ictx->objects);
> +
> +		iommu_unpreserve_domain(hwpt->common.domain);
> +		iopt_dec_num_preserved_domains(&hwpt->ioas->iopt);
> +
> +		hwpt->liveupdate_preserved = false;
> +		iommufd_put_object(ictx, obj);
> +
> +		xa_lock(&ictx->objects);
> +	}
> +	xa_unlock(&ictx->objects);
> +
> +	kho_unpreserve_free(ser);
> +}
> +
> +static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
> +{
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_hwpt_paging *hwpt;
> +	struct iommufd_ser *iommufd_ser;
> +	struct iommufd_object *obj;
> +	unsigned int num_hwpts;
> +	unsigned long index;
> +	unsigned int i;
> +	void *mem;
> +	int rc;
> +
> +	ictx = iommufd_ctx_from_file(args->file);
> +	if (IS_ERR(ictx))
> +		return PTR_ERR(ictx);
> +
> +	mutex_lock(&ictx->liveupdate_mutex);
> +
> +	/* Count the number of HWPTs to preserve */
> +	num_hwpts = 0;
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		if (!hwpt->common.domain) {
> +			rc = -EINVAL;
> +			xa_unlock(&ictx->objects);
> +			goto out_unlock;
> +		}
> +		num_hwpts++;
> +	}
> +	xa_unlock(&ictx->objects);
> +
> +	mem = kho_alloc_preserve(struct_size(iommufd_ser,
> +					     hwpt_array, num_hwpts));
> +	if (IS_ERR(mem)) {
> +		rc = PTR_ERR(mem);
> +		goto out_unlock;
> +	}
> +
> +	iommufd_ser = mem;
> +	iommufd_ser->size = sizeof(*iommufd_ser);
> +
> +	/* Preserve HWPTs */
> +	i = 0;
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		if (!iommufd_lock_obj(obj)) {
> +			rc = -ENOENT;
> +			xa_unlock(&ictx->objects);
> +			goto out_unpreserve;
> +		}
> +
> +		/*
> +		 * HWPT is locked so it will not be destroyed. The xarray lock
> +		 * can be released here before preserving the HWPT.
> +		 */
> +		xa_unlock(&ictx->objects);
> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		rc = iommufd_preserve_hwpt(hwpt, &iommufd_ser->hwpt_array[i++], args->session);
> +		if (rc) {
> +			iommufd_put_object(ictx, obj);
> +			goto out_unpreserve;
> +		}
> +
> +		/*
> +		 * Mark the HWPT as successfully preserved. This is distinct
> +		 * from IOMMUFD_OBJ_LIVEUPDATE_MARK, which only indicates the
> +		 * userspace intent to preserve.
> +		 */
> +		hwpt->liveupdate_preserved = true;

Can userspace re-mark an already-preserved HWPT with a new token? It
seems that mark_preserve() doesn't check hwpt->liveupdate_preserved.
Would it help to simply return -EBUSY from mark_preserve() once
hwpt->liveupdate_preserved is set?

> +		xa_lock(&ictx->objects);
> +	}
> +	xa_unlock(&ictx->objects);
> +
> +	/* Store the actual number of HWPTs that are preserved */
> +	iommufd_ser->num_hwpts = i;
> +
> +	args->serialized_data = virt_to_phys(iommufd_ser);
> +	mutex_unlock(&ictx->liveupdate_mutex);
> +	iommufd_ctx_put(ictx);
> +	return 0;
> +
> +out_unpreserve:
> +	_iommufd_unpreserve(ictx, iommufd_ser);
> +out_unlock:
> +	mutex_unlock(&ictx->liveupdate_mutex);
> +	iommufd_ctx_put(ictx);
> +	return rc;
> +}
> +
> +static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
> +{
> +	struct iommufd_ctx *ictx;
> +
> +	ictx = iommufd_ctx_from_file(args->file);
> +	if (WARN_ON(IS_ERR(ictx)))
> +		return;
> +
> +	mutex_lock(&ictx->liveupdate_mutex);
> +	_iommufd_unpreserve(ictx, phys_to_virt(args->serialized_data));
> +	mutex_unlock(&ictx->liveupdate_mutex);
> +
> +	iommufd_ctx_put(ictx);
> +}
[...]

Thanks,
baolu
