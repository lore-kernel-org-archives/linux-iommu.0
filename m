Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91BAC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 15:54:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9A864F1B
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 15:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A864F1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicpenguin.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9DD54EC25;
	Tue,  2 Mar 2021 15:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_8nni27qaEp; Tue,  2 Mar 2021 15:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 276F34EBC1;
	Tue,  2 Mar 2021 15:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FAC2C000B;
	Tue,  2 Mar 2021 15:54:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2AACC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 15:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A173B605DB
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 15:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=cosmicpenguin-net.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3uW08aoTUfU for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 15:54:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56E7A605A8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 15:54:33 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id d5so18439020iln.6
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=4YmTDrctAKsG8cdbZH7XiMulPHMmL+Exyv4xwBQWD5M=;
 b=x2eE6P8J5KaO4DD0hNyzGz7Bru3WjGacf4IWFcF96JbCi3uflZJ3KWwSD3mb8vBH8Y
 a+6uictKWrojWO3H0XIV7GkIWxXJj8H/PIPNZorNQlkt6nuV7LxoNdwPgRDoAI/Gs6k/
 vltvTCdwZe0e8BxrWARFh4IgpX5RvemqQjmiLruck622jgL4pwslhEMGk8nrZ+T7bVaH
 j90QXNGuFzpXHZCd5Z/KHbfqh5zk14zaSDsGL+aCNySc+X9JAtxAwpSF32Dmozx8TFS4
 cGaxFEfZ245lWW5UEgzedysJtgECdzW7klS6VkJoGydEc00k/b3sBm0j7V/JHYD4iRes
 JH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=4YmTDrctAKsG8cdbZH7XiMulPHMmL+Exyv4xwBQWD5M=;
 b=Ezr0cbSQtA3GRVMbQBABvtXcwUWn3mP6qBy3q0buCPAI4bIB9kZMOz70OsmKEPjry1
 TI7RuOle1e+9iIokpW2L3ByUoNnGBYVkEVYFkz+b7EYyBe3IzAXU0kmQgwjXpu4rDaWt
 LXL+uGCoOChpQjK9TDMNMTgXb2e+mRzQuSZ9EDX7rM6rB/s9v/FUzsRdZNdLZ1ZjM9s/
 die/yQW+o8muWcW3DO/nQyZhouEohEjxPJcJNHOi8UsfEdfY/mDq7XZJbGvL+CktPpow
 +USFPFnrhnhkGcH1AW0MICPuGy1KG0OjTPh5OWPtguNkUcSOj/3heaQADmfFotqP1YBK
 AnUA==
X-Gm-Message-State: AOAM5338Ib+V2hKNSkW+yeBBIbLFLnhAanP6ywKSu0Rr25zO4viEoN9M
 y9/ykoErACY6hnn4PmS/ZG0WaQ==
X-Google-Smtp-Source: ABdhPJxklLSBBngic8Uzfbl/eBdoqe4frY99R/xM56OTzhIiYdli7cBeVq1FMv0i41nQlHiUfRCgwg==
X-Received: by 2002:a92:c54e:: with SMTP id a14mr18413282ilj.285.1614700465998; 
 Tue, 02 Mar 2021 07:54:25 -0800 (PST)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net.
 [71.237.100.236])
 by smtp.gmail.com with ESMTPSA id k23sm11935810iol.36.2021.03.02.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 07:54:25 -0800 (PST)
Date: Tue, 2 Mar 2021 08:54:23 -0700
From: Jordan Crouse <jordan@cosmicpenguin.net>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Add support for driver IOMMU
 fault handlers
Message-ID: <20210302155423.3e7xlal3phcz26bh@cosmicpenguin.net>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20210225175135.91922-1-jcrouse@codeaurora.org>
 <20210225175135.91922-2-jcrouse@codeaurora.org>
 <2d3c7595-0186-7231-96dc-ae52414480ee@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d3c7595-0186-7231-96dc-ae52414480ee@arm.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Tue, Mar 02, 2021 at 12:17:24PM +0000, Robin Murphy wrote:
> On 2021-02-25 17:51, Jordan Crouse wrote:
> > Call report_iommu_fault() to allow upper-level drivers to register their
> > own fault handlers.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index d8c6bfde6a61..0f3a9b5f3284 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -408,6 +408,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> >   	int idx = smmu_domain->cfg.cbndx;
> > +	int ret;
> >   	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> >   	if (!(fsr & ARM_SMMU_FSR_FAULT))
> > @@ -417,8 +418,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >   	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> >   	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> > -	dev_err_ratelimited(smmu->dev,
> > -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > +	ret = report_iommu_fault(domain, dev, iova,
> 
> Beware that "dev" here is not a struct device, so this isn't right. I'm not
> entirely sure what we *should* be passing here, since we can't easily
> attribute a context fault to a specific client device, and passing the IOMMU
> device seems a bit dubious too, so maybe just NULL?

Agreed. The GPU doesn't use it and I doubt anything else would either since the
SMMU device is opaque to the leaf driver.

Jordan

> Robin.
> 
> > +		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> > +
> > +	if (ret == -ENOSYS)
> > +		dev_err_ratelimited(smmu->dev,
> > +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> >   			    fsr, iova, fsynr, cbfrsynra, idx);
> >   	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> > 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
