Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2991E8320
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772434265; cv=none; b=IWlp4aFFdmF6BWCC5tyMm+TZ2rwpqt5Muj9+JJqXAvUIx4Yk3A/RZdAZvE9MhYAZm5tnu8c8XqqvfwEjHEgUzCj+9MGyQNmrgjKOqnNfBEzqQvZQ2mMz5/NWRmMv2Dwet86W6BInUon2nf+8qGXPRlj6qax8M8U989EPEHLB7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772434265; c=relaxed/simple;
	bh=KfxHlb9EGa7F1zrztk6hQklz/axGIsGm0xY/noQxqKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJ91E7bCfL1Hcu0GYvWYkQmK/415mKN2fnjhA8v62uFIfQEdrvhX+rLt2P0I4eMVEkpX7ecvb9jon2kiP9A/DDboYrWk0M9iqmoRIZRHYh58zNXJML5Fx6h8hWNsvGshIaJLa3KU1OJukxaMxw2g6LxoKXPGPpziYEW26kTmf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIN1Pu3L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIN1Pu3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772434264; x=1803970264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KfxHlb9EGa7F1zrztk6hQklz/axGIsGm0xY/noQxqKk=;
  b=SIN1Pu3Lj+tNl2Fu+lICJd8sfq9qtTniG6GuYVI7ZdLSphytFnfZ3Ti/
   mbeBneofnrQFqtqbPpCkTxxDW7iBM0CtG57la2Et7QPQx7KP76939VfoS
   rSxSzTC1TuWkgtyX5eT8Gso/xsOOW81H8GzuJH1VgydzWyVwcGPMuv9Tf
   Ped7HNhMO/Aa+6TCFIvADV2bGOQ36xi2p4eozeM7w0sIVeMQaZ6fFTJYo
   hWOuuUViSIIEm2HOIfEuySTMGizM72aBxmPGnMmR+xwdqYNQdfmqnp6c+
   naqJ5Fpe0FvMZjrYviSQoqkTSYBCHHNFLlQFw2a3lovJDy5wY9eGNFoPo
   A==;
X-CSE-ConnectionGUID: y9xQDsmPSue9vce92uNzhA==
X-CSE-MsgGUID: v04A2tdgTFixtMgIRMUk3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="83769655"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="83769655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 22:51:03 -0800
X-CSE-ConnectionGUID: 2wALsoscR9KplylpdI+CaA==
X-CSE-MsgGUID: PBWDd3vhTzWQ6IDy8N1ASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="248059039"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 22:51:02 -0800
Message-ID: <0833d160-9659-4140-b775-a0ab0c17a451@linux.intel.com>
Date: Mon, 2 Mar 2026 14:50:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, vasant.hegde@amd.com
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260224183056.2628698-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/26 02:30, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>    iommu_domain_free()
>      mmdrop()
>        __mmdrop()
>          mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by taking a reference to the mm via mmgrab() before
> calling iommu_domain_free(), and dropping it with mmdrop() after
> finishing access to domain->mm->iommu_mm.
> 
> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>
> ---
>   drivers/iommu/iommu-sva.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 07d64908a05f..523b8c65c86f 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		return;
>   	}
>   
> +	mmgrab(domain->mm);
>   	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>   	if (--domain->users == 0) {
>   		list_del(&domain->next);
> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		if (list_empty(&iommu_sva_mms))
>   			iommu_sva_present = false;
>   	}
> +	mmdrop(domain->mm);
>   
>   	mutex_unlock(&iommu_sva_lock);
>   	kfree(handle);

How about making the iommu_mm structure itself an owner of the mm_struct
lifetime? Does something like the following work?

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 07d64908a05f..9c56c2222617 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -47,6 +47,7 @@ static struct iommu_mm_data 
*iommu_alloc_mm_data(struct mm_struct *mm, struct de
         iommu_mm->pasid = pasid;
         iommu_mm->mm = mm;
         INIT_LIST_HEAD(&iommu_mm->sva_domains);
+       mmgrab(mm);
         /*
          * Make sure the write to mm->iommu_mm is not reordered in front of
          * initialization to iommu_mm fields. If it does, readers may see a
@@ -212,6 +213,8 @@ void mm_pasid_drop(struct mm_struct *mm)
                 return;

         iommu_free_global_pasid(iommu_mm->pasid);
+       mm->iommu_mm = NULL;
+       mmdrop(mm);
         kfree(iommu_mm);
  }

Thanks,
baolu
