Return-Path: <SRS0=6gDp=FO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8538C433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 17:29:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDE423A02
	for <iommu@archiver.kernel.org>; Thu, 10 Dec 2020 17:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDE423A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 818AD21543;
	Thu, 10 Dec 2020 17:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAGMzQN0ufWu; Thu, 10 Dec 2020 17:29:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B303A2152E;
	Thu, 10 Dec 2020 17:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97830C0FA7;
	Thu, 10 Dec 2020 17:29:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E805C013B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 17:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0CFFB86A04
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 17:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfM1fQxL+hTb for <iommu@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 17:29:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 32E9A869FE
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607621379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPix3SP1rka7hQ8hX1oDzx6oTaknX+t6svbdYJaNdNE=;
 b=XRYORGK0X3ouRu/XavFyfLTQufp0lwvLaZ7cQ+G1F4AaCzMos9zHGAJLnCRdy1VjbEwWKB
 9TeNjrumj8WT7/nMZ4SU9t98EfEDg0Z3FENenjYLmtMTVmTrSbqAiKsWlLkTGanS2NtpKU
 ofjeavJfNBw9UHSZkDo6I0sXGWXNQbc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-OXdqhQ0yMwmJsMntAgbZ4Q-1; Thu, 10 Dec 2020 12:29:36 -0500
X-MC-Unique: OXdqhQ0yMwmJsMntAgbZ4Q-1
Received: by mail-qv1-f70.google.com with SMTP id u8so382944qvm.5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Dec 2020 09:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=WPix3SP1rka7hQ8hX1oDzx6oTaknX+t6svbdYJaNdNE=;
 b=MmiEtscuxHbtngbL/bJhfO0XPKDX1yjQ+Jk1PGat1A8bf+tHrsVi1QrR4btXNbdaNM
 /b3v1oaFsBTO+3oYzM1s7tVTJDLsClhtBCBoismIKOynb0BiuMgLXVUkpratow5PQ12x
 mUodh/U+IEyQA4xQ4ZR8a2G5MkUTBGKZAO8HuZc/N6INqVd0vrMAcUFHLin3r7JGmnnP
 jVaeeJEJG11HZDfjEWSKyyZu8K3xWAXUypB9nstx2jYT2Wdq1iYJ3kIP5kY1VY881k14
 eg97r62G9HDFRIfcq1YGF0usR/Qt7iEnKNWk/8zIEEKgvt67j2oB+WMavZDQTifMYYtv
 A5zw==
X-Gm-Message-State: AOAM530cHT8j62Y+vJji0Iw032Ea912WTsGKVSqnEuyofsPBkr0hrFGb
 KaU0NB6X4bRLfxpwaxmo73lfKJudy4G3rdNcgZ04OXxcHUDo+GSSMqn0YKXAR1h7LKPvYXg5Wc5
 5vSm2qpkwQ8eSZMyjMSiS2HRgWJGbGg==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr10346812qtb.80.1607621375936; 
 Thu, 10 Dec 2020 09:29:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGU7fOjrqhiru2xOMuaLAkJpPXTV9UI0NjLAQmB/TsAVRPeqAVrpXoWFrEyVFjP/UZJwy8gQ==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr10346777qtb.80.1607621375681; 
 Thu, 10 Dec 2020 09:29:35 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id h26sm3807343qkj.96.2020.12.10.09.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 09:29:35 -0800 (PST)
References: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add sanity check for interrupt remapping
 table length macros
In-reply-to: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
Date: Thu, 10 Dec 2020 10:29:31 -0700
Message-ID: <871rfxtvr8.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: thomas.lendacky@amd.com, Jon.Grimm@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
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


Suravee Suthikulpanit @ 2020-12-10 09:24 MST:

> Currently, macros related to the interrupt remapping table length are
> defined separately. This has resulted in an oversight in which one of
> the macros were missed when changing the length. To prevent this,
> redefine the macros to add built-in sanity check.
>
> Also, rename macros to use the name of the DTE[IntTabLen] field as
> specified in the AMD IOMMU specification. There is no functional change.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 19 ++++++++++---------
>  drivers/iommu/amd/init.c            |  6 +++---
>  drivers/iommu/amd/iommu.c           |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 494b42a31b7a..899ce62df3f0 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -255,11 +255,19 @@
>  /* Bit value definition for dte irq remapping fields*/
>  #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
>  #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
> -#define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
>  #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> -#define DTE_IRQ_TABLE_LEN       (9ULL << 1)
>  #define DTE_IRQ_REMAP_ENABLE    1ULL
>  
> +/*
> + * AMD IOMMU hardware only support 512 IRTEs despite
> + * the architectural limitation of 2048 entries.
> + */
> +#define DTE_INTTAB_ALIGNMENT    128
> +#define DTE_INTTABLEN_VALUE     9ULL
> +#define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
> +#define DTE_INTTABLEN_MASK      (0xfULL << 1)
> +#define MAX_IRQS_PER_TABLE      (1 << DTE_INTTABLEN_VALUE)
> +
>  #define PAGE_MODE_NONE    0x00
>  #define PAGE_MODE_1_LEVEL 0x01
>  #define PAGE_MODE_2_LEVEL 0x02
> @@ -409,13 +417,6 @@ extern bool amd_iommu_np_cache;
>  /* Only true if all IOMMUs support device IOTLBs */
>  extern bool amd_iommu_iotlb_sup;
>  
> -/*
> - * AMD IOMMU hardware only support 512 IRTEs despite
> - * the architectural limitation of 2048 entries.
> - */
> -#define MAX_IRQS_PER_TABLE	512
> -#define IRQ_TABLE_ALIGNMENT	128
> -
>  struct irq_remap_table {
>  	raw_spinlock_t lock;
>  	unsigned min_index;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 23a790f8f550..6bec8913d064 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -989,10 +989,10 @@ static bool copy_device_table(void)
>  
>  		irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
>  		int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
> -		int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
> +		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
>  		if (irq_v && (int_ctl || int_tab_len)) {
>  			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
> -			    (int_tab_len != DTE_IRQ_TABLE_LEN)) {
> +			    (int_tab_len != DTE_INTTABLEN)) {
>  				pr_err("Wrong old irq remapping flag: %#x\n", devid);
>  				return false;
>  			}
> @@ -2674,7 +2674,7 @@ static int __init early_amd_iommu_init(void)
>  			remap_cache_sz = MAX_IRQS_PER_TABLE * (sizeof(u64) * 2);
>  		amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
>  							remap_cache_sz,
> -							IRQ_TABLE_ALIGNMENT,
> +							DTE_INTTAB_ALIGNMENT,
>  							0, NULL);
>  		if (!amd_iommu_irq_cache)
>  			goto out;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b9cf59443843..f7abf16d1e3a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3191,7 +3191,7 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
>  	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
>  	dte	|= iommu_virt_to_phys(table->table);
>  	dte	|= DTE_IRQ_REMAP_INTCTL;
> -	dte	|= DTE_IRQ_TABLE_LEN;
> +	dte	|= DTE_INTTABLEN;
>  	dte	|= DTE_IRQ_REMAP_ENABLE;
>  
>  	amd_iommu_dev_table[devid].data[2] = dte;


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
