Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99D4315F
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146912; cv=none; b=jifvhWmDzAdDx/UlDFjhIuCVe6aaPzxmuj68Hm/RWUzeACrk5sjG7xytbtwI23thMU/xlb5y+q5uBxcanGbO6vztP1AR9ObOX2+0KTIWEj1WDrcQNVi/6bfTOOOfFhMrH4nuOjCo7BpLlZpKfrgDoAd7vRuBHD3kpnCGEbRLPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146912; c=relaxed/simple;
	bh=61/PYnar0zpbl7raIs1eYOdxh4sOub51dNJXPhCwEnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsu83hzvXM/aHisHicm1yQ5WTXeObtOCCiJ9IrIMgPQwJxQ6D7EhLGkPU1gAlq3X5f7vDxNHvGmPLQ28aOhtkCMwcFK/xNPrDqtF4SpSijLWFTRSeabFdAYmOMV087uUDlXi1Q8EIxkn8JnldXSJk9vkm7WzGpb0+BEwQiNnnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayDbDjLC; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayDbDjLC"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb78ead12so78746766b.1
        for <iommu@lists.linux.dev>; Wed, 13 Aug 2025 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755146909; x=1755751709; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19V6tagm9HF5/noSHD7BpUVx/BDrV4yWw/lL1iMr1sY=;
        b=ayDbDjLCEc+sjwjxle/P5isM8UQmbixedk3YJ8TBx8AcVXR445whA3mcBh6uBw1o+o
         sGmG/e2dkxFAnOBZFX1bak8toKuG5ltEDpdbgaxscBJrvPhTW/k4mNF8X6gNqcd9dVf8
         kbgR9MfCt6k8f0Uc+2db1vGLtmoCjdmq5yA/cNZoRDCb/hxeRsrsFguFwNSbZicekhrk
         FzGuOR2RKTqQEwitVo3+jkYYmWMCWwIJWdTUyy3Mdxv8sqPyIXH9tHGa7FCEbBWCNPMf
         3Rp9AELxc1sW7AmrtDFSxIEzWEMkNCPewRCkN3dAe2rSL1O8WuvsMq2P4smuVPNO2ZxG
         JEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755146909; x=1755751709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19V6tagm9HF5/noSHD7BpUVx/BDrV4yWw/lL1iMr1sY=;
        b=UQKnq4UiTRCJvjgd3dr30SqBua2Ou26juNx3SZJHR+Lu2GQ4C3p1QbU3KY4y9svf9y
         jczT4jAhy68iaiB0cDOMjVseRcQTsPA9rAoIt3F7WOQObPjhlUlbx+LCFJ1um+5lpxjR
         fQaU1OXWEAMQdqwqGtoVdSMNkCudhLuEedmXh4T3heK/HRfZRlMBHMn8Bej7AOh+f/eH
         LEoTo4iY1IijpRWgb+U26ZRea/UX0jPE9+TTzj0eEYZh/4gZLPGdrBEXgGCXboXepJtW
         M55rA7L3d266JX6ET1YInHK0gbbPH3ZFo/oPkoNq+Uh2ZRsyAgCfE+vq1MXm81KFgVCb
         ApDg==
X-Gm-Message-State: AOJu0YwQW4eKY+JBvqRFoJKIn0bRF3hZDENpk5bZaYP1roQOnkr8SJ0C
	kJqWyM8wSJ7k+MC+K/m7u91iMpEb8zO/Rj2DP3zXcDkfzwaJGBaOht+0
X-Gm-Gg: ASbGncsIFzqD9nwViZnqcSzJhXTLI3l4DfY5Fa/0A5AuWGVqTWNxzBCilnaWkpQNjZQ
	cDZT6ceGzc2FbW2AxGi8A8pbcJt5if6OyuuA4v+eJLNwZB+M5t3p/Bi8vUH17/u/z+QFz9nn0qz
	Qfw149hNDH5RX1roj8ERQ55eFvYTNNIBjx6/WeYHdGS9bDdmH2xfmksEgQiH54LSGg5OcuaVPDI
	2vAiB6ZinXe1Ss6yOtfwhJd1m9xh94CkqJHga42JrOOB5LZwGC61mbdrTh4W2XJwroyFsbqZNq9
	uQ2hck3/Z2j8/5/P81hDPjbHs9k38A2eS36RItQY8xzE+ZkXFao2A+OsFc9D7Gmh3e09bIgYLE6
	FVJNcLStaO+pPCrEJEgwIytdCcJMW71DOWNzIPoe1CHwshhRcvpaVFWVXkO+pz16EA8+vi8IrDt
	Co3oRB/fs6RXhnLe0AQ958s3TF8LxPt/CddtLew7iqjA==
X-Google-Smtp-Source: AGHT+IGitDN92GR08kSKccc2lp3rNN48eTD3MRtlTDAHoc4+QLBTDziVHi5VQT050W9sGTRHomI3fg==
X-Received: by 2002:a17:907:72d4:b0:ae3:a78d:a08a with SMTP id a640c23a62f3a-afcb93a2319mr123542066b.6.1755146908550;
        Wed, 13 Aug 2025 21:48:28 -0700 (PDT)
Received: from [26.26.26.1] (ec2-63-178-255-169.eu-central-1.compute.amazonaws.com. [63.178.255.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm1525583766b.6.2025.08.13.21.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 21:48:27 -0700 (PDT)
Message-ID: <6a61f3af-2d17-4261-8e54-c1117dbc289b@gmail.com>
Date: Thu, 14 Aug 2025 12:48:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/2025 1:25 PM, Lu Baolu wrote:
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. The Linux x86 architecture maps
> the kernel address space into the upper portion of every process’s page
> table. Consequently, in an SVA context, the IOMMU hardware can walk and
> cache kernel space mappings. However, the Linux kernel currently lacks
> a notification mechanism for kernel space mapping changes. This means
> the IOMMU driver is not aware of such changes, leading to a break in
> IOMMU cache coherence.
> 
> Modern IOMMUs often cache page table entries of the intermediate-level
> page table as long as the entry is valid, no matter the permissions, to
> optimize walk performance. Currently the iommu driver is notified only
> for changes of user VA mappings, so the IOMMU's internal caches may
> retain stale entries for kernel VA. When kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises.
> 
> If these freed page table pages are reallocated for a different purpose,
> potentially by an attacker, the IOMMU could misinterpret the new data as
> valid page table entries. This allows the IOMMU to walk into attacker-
> controlled memory, leading to arbitrary physical memory DMA access or
> privilege escalation.
> 
> To mitigate this, introduce a new iommu interface to flush IOMMU caches.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables, whenever a kernel page table
> update is done and the CPU TLB needs to be flushed.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc: stable@vger.kernel.org
> Suggested-by: Jann Horn <jannh@google.com>
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>   arch/x86/mm/tlb.c         |  4 +++
>   drivers/iommu/iommu-sva.c | 60 ++++++++++++++++++++++++++++++++++++++-
>   include/linux/iommu.h     |  4 +++
>   3 files changed, 67 insertions(+), 1 deletion(-)
> 
> Change log:
> v3:
>   - iommu_sva_mms is an unbound list; iterating it in an atomic context
>     could introduce significant latency issues. Schedule it in a kernel
>     thread and replace the spinlock with a mutex.
>   - Replace the static key with a normal bool; it can be brought back if
>     data shows the benefit.
>   - Invalidate KVA range in the flush_tlb_all() paths.
>   - All previous reviewed-bys are preserved. Please let me know if there
>     are any objections.
> 
> v2:
>   - https://lore.kernel.org/linux-iommu/20250709062800.651521-1-baolu.lu@linux.intel.com/
>   - Remove EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
>   - Replace the mutex with a spinlock to make the interface usable in the
>     critical regions.
> 
> v1: https://lore.kernel.org/linux-iommu/20250704133056.4023816-1-baolu.lu@linux.intel.com/
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..3b85e7d3ba44 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -12,6 +12,7 @@
>   #include <linux/task_work.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/mmu_context.h>
> +#include <linux/iommu.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/mmu_context.h>
> @@ -1478,6 +1479,8 @@ void flush_tlb_all(void)
>   	else
>   		/* Fall back to the IPI-based invalidation. */
>   		on_each_cpu(do_flush_tlb_all, NULL, 1);
> +
> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
Establishing such a simple one-to-one connection between CPU TLB flush
and IOMMU TLB flush is debatable. At the very least, not every process
is attached to an IOMMU SVA domain. Currently, devices and IOMMU 
operating in scalable mode are not commonly applied to every process.

Thanks,
Ethan>   }
>   
>   /* Flush an arbitrarily large range of memory with INVLPGB. */
> @@ -1540,6 +1543,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   		kernel_tlb_flush_range(info);
>   
>   	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>   }
>   
>   /*
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 1a51cfd82808..d0da2b3fd64b 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,8 @@
>   #include "iommu-priv.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> +static bool iommu_sva_present;
> +static LIST_HEAD(iommu_sva_mms);
>   static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   						   struct mm_struct *mm);
>   
> @@ -42,6 +44,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>   		return ERR_PTR(-ENOSPC);
>   	}
>   	iommu_mm->pasid = pasid;
> +	iommu_mm->mm = mm;
>   	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>   	/*
>   	 * Make sure the write to mm->iommu_mm is not reordered in front of
> @@ -132,8 +135,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	if (ret)
>   		goto out_free_domain;
>   	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>   
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		if (list_empty(&iommu_sva_mms))
> +			WRITE_ONCE(iommu_sva_present, true);
> +		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>   out:
>   	refcount_set(&handle->users, 1);
>   	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		list_del(&domain->next);
>   		iommu_domain_free(domain);
>   	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		list_del(&iommu_mm->mm_list_elm);
> +		if (list_empty(&iommu_sva_mms))
> +			WRITE_ONCE(iommu_sva_present, false);
> +	}
> +
>   	mutex_unlock(&iommu_sva_lock);
>   	kfree(handle);
>   }
> @@ -312,3 +327,46 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   
>   	return domain;
>   }
> +
> +struct kva_invalidation_work_data {
> +	struct work_struct work;
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +static void invalidate_kva_func(struct work_struct *work)
> +{
> +	struct kva_invalidation_work_data *data =
> +		container_of(work, struct kva_invalidation_work_data, work);
> +	struct iommu_mm_data *iommu_mm;
> +
> +	guard(mutex)(&iommu_sva_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm,
> +				data->start, data->end);
> +
> +	kfree(data);
> +}
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct kva_invalidation_work_data *data;
> +
> +	if (likely(!READ_ONCE(iommu_sva_present)))
> +		return;
> +
> +	/* will be freed in the task function */
> +	data = kzalloc(sizeof(*data), GFP_ATOMIC);
> +	if (!data)
> +		return;
> +
> +	data->start = start;
> +	data->end = end;
> +	INIT_WORK(&data->work, invalidate_kva_func);
> +
> +	/*
> +	 * Since iommu_sva_mms is an unbound list, iterating it in an atomic
> +	 * context could introduce significant latency issues.
> +	 */
> +	schedule_work(&data->work);
> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c30d12e16473..66e4abb2df0d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1134,7 +1134,9 @@ struct iommu_sva {
>   
>   struct iommu_mm_data {
>   	u32			pasid;
> +	struct mm_struct	*mm;
>   	struct list_head	sva_domains;
> +	struct list_head	mm_list_elm;
>   };
>   
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
> @@ -1615,6 +1617,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>   					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
>   #else
>   static inline struct iommu_sva *
>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1639,6 +1642,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>   }
>   
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
> +static inline void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end) {}
>   #endif /* CONFIG_IOMMU_SVA */
>   
>   #ifdef CONFIG_IOMMU_IOPF

