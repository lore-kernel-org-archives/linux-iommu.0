Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2480C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:11:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9AD64F5E
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9AD64F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AC6C4EBCD;
	Thu,  4 Mar 2021 17:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jl1f6LCNMnVK; Thu,  4 Mar 2021 17:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9850049E7A;
	Thu,  4 Mar 2021 17:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C872C000B;
	Thu,  4 Mar 2021 17:11:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3C0AC0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A69D4D15B
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVYjb9RzU9WA for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:11:20 +0000 (UTC)
X-Greylist: delayed 23:37:04 by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F37549E7A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:11:20 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id m7so2097784wmq.0
 for <iommu@lists.linux-foundation.org>; Thu, 04 Mar 2021 09:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xFBPptA1LX4xyld1RDDV7UcfKnkB6M3UWan7nS+Z21M=;
 b=tiAETIbaY5PD9LghmQ3hpAzU9/xT4+vZSyepR2JFaM6dHEk/nttduYLtMdNKlbr2F0
 2xGgwDcrWQicytfoFsHEZMFSB+tMZSqJXGirbIeyyBAC3+b+WR5V7b1uCEmu52HozAMb
 h8nRzWD3zCA7q7WSXN9wKLu7cnMPJZJZT+dApiQnAniTfYMWA0KTH7HBLWECDRgYYToV
 1/oSGc3jHjaz0ecfGCVuE8qn8ac/W6C4v44HP/uDzaCLEPs0kGrBaV2Y+WFlf7rYTJdL
 aSI7OWJff8UayvQr2V7rLdtbfuHyCjM7gUcKlBHvLg5uF8+ZjZed/hoZXH/Fff2EASul
 9Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xFBPptA1LX4xyld1RDDV7UcfKnkB6M3UWan7nS+Z21M=;
 b=ZE4SpVNF9/YDh3sKgH4XubGiAElyi1w5knM3HgJMYsKFFHK77DAk1G5s3VJWryIzb8
 fBP/3xFwqgERV4D1AHUnG1P61Dg9DAq/5xYqQv6lodjmHE6OiO6G0+wjcbipEbtSkke+
 iEA3ktfg1zXWk1xgDh0DQJgkDIQKwzDZXRhWAm6GuCdPqXQhlqBjL12EM9mYHPoC1Pfn
 zgDNohFDQUqUlogC9JGPfnt9GdkgGG8WASStKlTurWKr9pBcAHcl7gW7q2acBLPC1TPv
 MGH2JDRHienBiT+J7//rbQW1Bjem/8TnFI2+onwHVFpaF+z4pmfCqim5DiWOQQQzDNRr
 Yvzw==
X-Gm-Message-State: AOAM531qd1xciroQ7jCwO9QPzJvDAi/Y0yrnBTV8pM5JHWhHR+rN5pIv
 rJCEEbA80QoqOmqkBwNNvhLgqA==
X-Google-Smtp-Source: ABdhPJxOntYhGbDUS7U/hw2vNYCli4kH7kDgdSmiVlbsTu2jHmpDOTkFqOg/YkOfklJtre/JYQMOtg==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr4891812wmj.109.1614877878605; 
 Thu, 04 Mar 2021 09:11:18 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b186sm58826wmc.44.2021.03.04.09.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 09:11:18 -0800 (PST)
Date: Thu, 4 Mar 2021 18:10:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [RFC PATCH 4/5] iommu/arm-smmu-v3: Use pinned VMID for NESTED
 stage with BTM
Message-ID: <YEEUocRn3IfIDpLj@myrica>
References: <20210222155338.26132-1-shameerali.kolothum.thodi@huawei.com>
 <20210222155338.26132-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210222155338.26132-5-shameerali.kolothum.thodi@huawei.com>
Cc: maz@kernel.org, alex.williamson@redhat.com, linuxarm@openeuler.org,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
 zhangfei.gao@linaro.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Shameer,

On Mon, Feb 22, 2021 at 03:53:37PM +0000, Shameer Kolothum wrote:
> If the SMMU supports BTM and the device belongs to NESTED domain
> with shared pasid table, we need to use the VMID allocated by the
> KVM for the s2 configuration. Hence, request a pinned VMID from KVM.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 49 ++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 26bf7da1bcd0..04f83f7c8319 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -28,6 +28,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
> +#include <linux/kvm_host.h>
>  
>  #include <linux/amba/bus.h>
>  
> @@ -2195,6 +2196,33 @@ static void arm_smmu_bitmap_free(unsigned long *map, int idx)
>  	clear_bit(idx, map);
>  }
>  
> +static int arm_smmu_pinned_vmid_get(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_master *master;
> +
> +	master = list_first_entry_or_null(&smmu_domain->devices,
> +					  struct arm_smmu_master, domain_head);

This probably needs to hold devices_lock while using master.

> +	if (!master)
> +		return -EINVAL;
> +
> +	return kvm_pinned_vmid_get(master->dev);
> +}
> +
> +static int arm_smmu_pinned_vmid_put(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_master *master;
> +
> +	master = list_first_entry_or_null(&smmu_domain->devices,
> +					  struct arm_smmu_master, domain_head);
> +	if (!master)
> +		return -EINVAL;
> +
> +	if (smmu_domain->s2_cfg.vmid)
> +		return kvm_pinned_vmid_put(master->dev);
> +
> +	return 0;
> +}
> +
>  static void arm_smmu_domain_free(struct iommu_domain *domain)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> @@ -2215,8 +2243,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  		mutex_unlock(&arm_smmu_asid_lock);
>  	}
>  	if (s2_cfg->set) {
> -		if (s2_cfg->vmid)
> -			arm_smmu_bitmap_free(smmu->vmid_map, s2_cfg->vmid);
> +		if (s2_cfg->vmid) {
> +			if (!(smmu->features & ARM_SMMU_FEAT_BTM) &&
> +			    smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> +				arm_smmu_bitmap_free(smmu->vmid_map, s2_cfg->vmid);
> +		}
>  	}
>  
>  	kfree(smmu_domain);
> @@ -3199,6 +3230,17 @@ static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
>  				!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
>  			goto out;
>  
> +		if (smmu->features & ARM_SMMU_FEAT_BTM) {
> +			ret = arm_smmu_pinned_vmid_get(smmu_domain);
> +			if (ret < 0)
> +				goto out;
> +
> +			if (smmu_domain->s2_cfg.vmid)
> +				arm_smmu_bitmap_free(smmu->vmid_map, smmu_domain->s2_cfg.vmid);
> +
> +			smmu_domain->s2_cfg.vmid = (u16)ret;

That will require a TLB invalidation on the old VMID, once the STE is
rewritten.

More generally I think this pinned VMID set conflicts with that of
stage-2-only domains (which is the default state until a guest attaches a
PASID table). Say you have one guest using DOMAIN_NESTED without PASID
table, just DMA to IPA using VMID 0x8000. Now another guest attaches a
PASID table and obtains the same VMID from KVM. The stage-2 translation
might use TLB entries from the other guest, no?  They'll both create
stage-2 TLB entries with {StreamWorld=NS-EL1, VMID=0x8000}

It's tempting to allocate all VMIDs through KVM instead, but that will
force a dependency on KVM to use VFIO_TYPE1_NESTING_IOMMU and might break
existing users of that extension (though I'm not sure there are any).
Instead we might need to restrict the SMMU VMID bitmap to match the
private VMID set in KVM.

Besides we probably want to restrict this feature to systems supporting
VMID16 on both SMMU and CPUs, or at least check that they are compatible.

> +		}
> +
>  		smmu_domain->s1_cfg.cdcfg.cdtab_dma = cfg->base_ptr;
>  		smmu_domain->s1_cfg.s1cdmax = cfg->pasid_bits;
>  		smmu_domain->s1_cfg.s1fmt = cfg->vendor_data.smmuv3.s1fmt;
> @@ -3221,6 +3263,7 @@ static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
>  static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_master *master;
>  	unsigned long flags;
>  
> @@ -3237,6 +3280,8 @@ static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
>  		arm_smmu_install_ste_for_dev(master);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> +	if (smmu->features & ARM_SMMU_FEAT_BTM)
> +		arm_smmu_pinned_vmid_put(smmu_domain);

Aliasing here as well: the VMID is still live but can be reallocated by
KVM and another domain might obtain it.

Thanks,
Jean

>  unlock:
>  	mutex_unlock(&smmu_domain->init_mutex);
>  }
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
