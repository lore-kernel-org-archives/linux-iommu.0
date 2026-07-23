Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6347CA60
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819755; cv=none; b=LzuCdWUvGuKIpuqpU6oolUswvjbYntvTzsXakrQI9MUCJVQBR21CorD0pyMntzC/nPo9Gdl8GlPuFlZhNpExzn/OEUKgVqvxs2YtGmi0LxRCFwDxi4NRn4w5tIRSgDX6OxBA8e3IgrElyaEV6HMHV9779n3GcTJTsE5CIlSuxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819755; c=relaxed/simple;
	bh=AbZpuHYdT9bmv8owVlBDCivQtCLS1/6F0ma+B6QZBZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe/vc702MG1vPaX/D0+bBp5u3NYH9kJ80wu0YCFNHB52DH8jejyz6KgMlqrNdKEOzhwTPqcEZ/Y4dd9deKCKcmL7FDaNw42WPL9ZAa9zXjborJ1dLW7fUX5OG/wOv/0vSCmPh5CF0NTlI5t59il42hkK91Hv6NKjRyvMVY82tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2nIRdeE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2nIRdeE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69f21b7f6cdso11257a12.0
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784819752; x=1785424552; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rHtkaJhyp7hvNXFM/a/du/ejeo788OAfuxw7sqTwA3Q=;
        b=K2nIRdeEanZhSVy5wc/EE2XO08DcBsRlckS6ObW0QA8kKdVOu+jbUGBR3NGg4UIZ1t
         rf82ENZTGpjaj15bpADyQCgsrLtpYv5K6zUsa4zPFhbdsAh1D9udHXzEJkw/hLzD7jL8
         J9hUSHpjriPsRkPKgUj0p3kYPNdd1swTTgTBFzfnbZeO8SGLqai1yrTylxF+vxC70LZD
         k2TrF71iSQbhT+wPBnohBeu3gOz9TaoCrpzsqH/pdauRXZ6ds3tb6HME2wo+14mQFw8B
         FU36iFIo6QoaRGU++N6RqGzhLXcRKGOJUFcj7FzLGJKUVk9ZpY9lWXPcGSp1pwiZldlt
         3uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819752; x=1785424552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHtkaJhyp7hvNXFM/a/du/ejeo788OAfuxw7sqTwA3Q=;
        b=QHVH6Ghuca9LWuwCjagfchBx1Yw2Ocr+z9uBc1Zu48htIiDl+JLXDyf/fhUkrenwyO
         mpvhttecNDePT5qMKrKVwLP/MB4xqXo4ocVnWUtY4Rq9QoI3AY9eRpjwhjmQWsUH2pbZ
         8VGZUox/pHPZT+yB825OFHAFuvPLsjpe7rQwQRt3ovLZL1b9M2mlMEEL9YvQqSngKMWg
         tYT5Dvq4ehFwcvbVIeSV6nYtPDSzV35FqJTlJFdoDBCYASfkuEvQlnAm6jYTLxavnLcV
         lNXChw3yv9o8SjbMPa0a2aVEOLoaaWOQlCH+mzhu7XaICySEL17fJdCBazfng4CtsjGz
         +20w==
X-Forwarded-Encrypted: i=1; AHgh+Ro6PSvl+gk/c4SIxFKXMUjGj0ql4LS401Wg1lBoWsSC6pSo6/8kGhgEbwkp7GhEICXGws2W1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YymMzuQ5UNkU+yNwqt+v4E9MAA7wcyAT/kBviiOBm5NOPxtcqpq
	n7L5RUkQGuZJS1PlganEsYeaJF89FlRODBpVx9CYk1kyIwASJ9Tqdw04XjDQJWf1cg==
X-Gm-Gg: AR+sD13BgZmuEyFyXmG7PE34ZH1bgZWrciT+TTIy0o5rMgo0p3huuXOwz4OX7oUljIT
	b8st4MIVLb1obPXqBBeOsK1kPzwGTMl5zrMJGfrCRyx5siXRs0nCnqSZDicmBkiGOI+3BbrwsPM
	JBnIwjmNYieT3JuWETye/JU5IsRLH5prVdTXuogabZ9E46mNpA7+mhXX8sAFIJBdVAToxyZCCvk
	+gjgQxrV+bMmUcL1ALTHJQyl9i77OgtD1vjnteVE9VqEc8OUf44CAteu5WSTHfZ1Ok0QbQE0Mof
	3+Pi3l70oZgLmxI8d4DZQ7tzZ7QL/x7/wxj6KbUO6IqQVu+xRNap3M0p0FQ8pNgXFzBD5yeXAkB
	TpVsFaRMNzCb5Spo9Fyvx8SfIDiqOOteeS3GG8haF2mNfw+bEDtnmmCRx4ag+/WBtQC8xGrb+8p
	8El7+Ar9kNXARlmF8dgezgmJyIk5Lb1USD2oi1HQ==
X-Received: by 2002:a05:6402:a6c9:20b0:697:5678:bc77 with SMTP id 4fb4d7f45d1cf-69f6cd0cdb9mr48696a12.9.1784819751162;
        Thu, 23 Jul 2026 08:15:51 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34b9b064sm2548716a12.11.2026.07.23.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:15:48 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:15:42 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, keirf@google.com
Subject: Re: [PATCH v7 14/24] iommu/arm-smmu-v3-kvm: Shadow the command queue
Message-ID: <amIwHukKBxPrq3WT@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-15-smostafa@google.com>
 <amIrTPWg3eEhu2m7@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIrTPWg3eEhu2m7@google.com>

Hi Seb,

On Thu, Jul 23, 2026 at 02:55:08PM +0000, Sebastian Ene wrote:
> On Wed, Jul 15, 2026 at 11:58:55AM +0000, Mostafa Saleh wrote:
> > +	 * size as the host.
> > +	 * Only populate base_dma and llq.max_n_shift, the hypervisor will init
> > +	 * the rest.
> > +	 */
> > +	cmdq_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, SMMU_KVM_CMDQ_ORDER);
> > +	if (!cmdq_base)
> > +		return -ENOMEM;
> 
> Hi Mostafa,
> 
> Isn't this over-allocating when PAGE_SIZE > 4kB ? 

Yes, that means the queue have different size depending on PAGE_SIZE,
In the kernel driver CMDQ_MAX_SZ_SHIFT is defined in terms of page
size also, but I think in the hypervisor it doesn't really matter,
I can change this to a fixed size and use alloc_pages_exact().

> 
> > +
> > +	smmu->cmdq.base_dma = virt_to_phys(cmdq_base);
> > +	smmu->cmdq.llq.max_n_shift = SMMU_KVM_CMDQ_ORDER + PAGE_SHIFT - CMDQ_ENT_SZ_SHIFT;
> > +
> >  	if (of_dma_is_coherent(dev->of_node))
> >  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> >  
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > index af06c832fc6f..9f76f4e82341 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > @@ -11,7 +11,6 @@
> >  #include <nvhe/trap_handler.h>
> >  
> >  #include "arm_smmu_v3.h"
> > -#include "../arm-smmu-v3.h"
> >  
> >  size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
> >  struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
> > @@ -21,10 +20,68 @@ struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
> >  	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
> >  	     (smmu)++)
> >  
> > +#define cmdq_size(cmdq)	((1 << ((cmdq)->llq.max_n_shift)) * CMDQ_ENT_DWORDS * 8)
> > +
> > +static bool is_cmdq_enabled(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	return FIELD_GET(CR0_CMDQEN, smmu->cr0);
> > +}
> > +
> > +/*
> > + * CMDQ, STE host copies are accessed by the hypervisor, we share them to
> > + * - Prevent the host from passing protected VM memory.
> > + * - Having them mapped in the hyp page table.
> > + */
> > +static int smmu_share_pages(phys_addr_t addr, size_t size)
> > +{
> > +	size_t nr_pages = PAGE_ALIGN(size + (addr & ~PAGE_MASK)) >> PAGE_SHIFT;
> > +	phys_addr_t base = addr & PAGE_MASK;
> > +	int i, ret;
> > +
> > +	for (i = 0 ; i < nr_pages ; ++i) {
> > +		if (__pkvm_host_share_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT)) {
> > +			while (i--)
> > +				__pkvm_host_unshare_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT);
> > +			return -EPERM;
> > +		}
> > +	}
> > +
> > +	ret = hyp_pin_shared_mem(hyp_phys_to_virt(base),
> > +				 hyp_phys_to_virt(base + nr_pages * PAGE_SIZE));
> > +	if (ret) {
> > +		for (i = 0 ; i < nr_pages ; ++i)
> > +			__pkvm_host_unshare_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int smmu_unshare_pages(phys_addr_t addr, size_t size)
> > +{
> > +	size_t nr_pages = PAGE_ALIGN(size + (addr & ~PAGE_MASK)) >> PAGE_SHIFT;
> > +	phys_addr_t base = addr & PAGE_MASK;
> > +	int i, ret;
> > +
> > +	hyp_unpin_shared_mem(hyp_phys_to_virt(base),
> > +			     hyp_phys_to_virt(base + nr_pages * PAGE_SIZE));
> > +
> > +	for (i = 0 ; i < nr_pages ; ++i) {
> > +		ret = __pkvm_host_unshare_hyp((base + i * PAGE_SIZE) >> PAGE_SHIFT);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* Put the device in a state that can be probed by the host driver. */
> >  static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
> >  {
> >  	WARN_ON(__pkvm_hyp_donate_host_mmio(smmu->mmio_addr, smmu->mmio_size));
> > +
> > +	if (smmu->cmdq.base)
> > +		WARN_ON(__pkvm_hyp_donate_host(smmu->cmdq.base_dma >> PAGE_SHIFT,
> > +					       cmdq_size(&smmu->cmdq) >> PAGE_SHIFT));
> >  	smmu->base = NULL;
> >  }
> >  
> > @@ -75,6 +132,31 @@ static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * The kernel part of the driver will allocate the shadow cmdq,
> > + * and zero it. This function only donates it.
> > + */
> > +static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	size_t cmdq_nr_pages = cmdq_size(&smmu->cmdq) >> PAGE_SHIFT;
> > +	int ret;
> > +
> > +	ret = __pkvm_host_donate_hyp(smmu->cmdq.base_dma >> PAGE_SHIFT, cmdq_nr_pages);
> > +	if (ret)
> > +		return ret;
> > +
> > +	smmu->cmdq.base = hyp_phys_to_virt(smmu->cmdq.base_dma);
> > +	smmu->cmdq.prod_reg = smmu->base + ARM_SMMU_CMDQ_PROD;
> > +	smmu->cmdq.cons_reg = smmu->base + ARM_SMMU_CMDQ_CONS;
> > +	smmu->cmdq.q_base = smmu->cmdq.base_dma |
> > +			    FIELD_PREP(Q_BASE_LOG2SIZE, smmu->cmdq.llq.max_n_shift);
> > +	smmu->cmdq.ent_dwords = CMDQ_ENT_DWORDS;
> > +	writel_relaxed(0, smmu->cmdq.prod_reg);
> > +	writel_relaxed(0, smmu->cmdq.cons_reg);
> > +	writeq_relaxed(smmu->cmdq.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
> 
> do we need a dsb here ?

I do not think so, why would it be needed? No data written at this
point. When commands are written, writel() is used to advance the
queue pointer which includes a barrier to enusre that the commands
are observed.

Thanks,
Mostafa


> 
> 
> Thanks,
> Sebastian
