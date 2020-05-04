Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE161C3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:06:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73159206A4
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dw8xcNvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73159206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4F29E87CB2;
	Mon,  4 May 2020 16:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KL2I4+9hfclJ; Mon,  4 May 2020 16:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C61DB87C09;
	Mon,  4 May 2020 16:06:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7774C088A;
	Mon,  4 May 2020 16:06:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1FE6C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DDD2E87C76
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J6t40U+gik3a for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 16:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6DCD87C09
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:06:51 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id y24so79766wma.4
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bp4AZOmEDFlGnUKxwTpEGrX9Ywb+/ercU9RXG60YpkA=;
 b=Dw8xcNvj2qmOKxxn59CPRrnhgYrQ5x4sBPM8qK0pmcxzWd1aH/YyCVxlXW3TIWT8Fw
 tx++cxMdi9+OTPqOJQ0MUb+cNtf6m3SYTI32z98924olcf+4nnXYi+IsldgCldMoIM07
 4h4F+MxzAqq6y91AHErfmlevgojJiWj+WryxD4tS6DchG+1L3m2rsTys97s7V6H+LEdC
 LCsZJU4jP6ekqf6cSccjS9Se5DU1Jiz5dlTN66yFFKaWMHEZyAdh3cs63tmpeqdXo7uR
 T2cb+IBgx5aIR71N/OxSIdsY99sFfZqoNjBPUH6CNGyQrSLxrlGkp1kmGkSQF8YKLWZh
 DMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bp4AZOmEDFlGnUKxwTpEGrX9Ywb+/ercU9RXG60YpkA=;
 b=ImBTlWfRJWHQRchlfA4UkEV0ZTddyJn2dw8/88A2EeMxInWcbkPhVdz/6aSip6u9OR
 cL4Vfs6IpS6j3OnVpxEwYrt8+DaHE7TysBbwRitlYyDYLH+cHRRmJLOLAZtaMgh7Cqwb
 Q2SFLZZElkIjhFC6RRAiU4yDTJUs9aWN+ffJ85opTGzbxAlCV6NkCtCbzB1TC8OTABM7
 q3hpbEG0m+Y5oXeEgOjHhWEzbfSFpp9FPySaG4bi6uZ1K11PmKTllvXdhWYCz46vUDjJ
 rhxukz789tYKNtYbCjk+y7yBO1purkT/2q43ynRJ9brSPocn7eqo2MOCG3lO3067lm4j
 Hs8Q==
X-Gm-Message-State: AGi0PuZWQ4Dy14z4GFeHgYaYoTlsPN9JLfGf5B4qfA+UzaO9hn8buCQJ
 9tHgtDaivbkMu15Dp2k166hFGw==
X-Google-Smtp-Source: APiQypKPyLr9D3x5aJJfh1E5/6u+cb8JP6Qo0I2a/ao2kDBpvQii1AZTwUzgtbi+yEe+qplCF2lrWg==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr16738870wmx.54.1588608410123; 
 Mon, 04 May 2020 09:06:50 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id b66sm15224708wmh.12.2020.05.04.09.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 09:06:48 -0700 (PDT)
Date: Mon, 4 May 2020 18:06:39 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200504160639.GD170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200501121552.GA6012@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501121552.GA6012@infradead.org>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, will@kernel.org,
 fenghua.yu@intel.com, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 felix.kuehling@amd.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org
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

On Fri, May 01, 2020 at 05:15:52AM -0700, Christoph Hellwig wrote:
> > @@ -432,6 +432,7 @@ config ARM_SMMU_V3
> >  	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> >  	depends on ARM64
> >  	select IOMMU_API
> > +	select IOMMU_SVA
> >  	select IOMMU_IO_PGTABLE_LPAE
> >  	select GENERIC_MSI_IRQ_DOMAIN
> 
> Doesn't this need to select MMU_NOTIFIER now?

Yes, will fix

> > +	struct mmu_notifier_ops		mn_ops;
> 
> Note: not a pointer.
> 
> > +	/* If bind() was already called for this (dev, mm) pair, reuse it. */
> > +	list_for_each_entry(bond, &master->bonds, list) {
> > +		if (bond->mm == mm) {
> > +			refcount_inc(&bond->refs);
> > +			return &bond->sva;
> > +		}
> > +	}
> > +
> > +	mn = mmu_notifier_get(&smmu_domain->mn_ops, mm);
> > +	if (IS_ERR(mn))
> > +		return ERR_CAST(mn);
> 
> Which seems to be to avoid mmu_notifier_get reusing notifiers registered
> by other arm_smmu_master instance right?

Yes, although I'm registering a single mmu notifier per (domain, mm) pair,
not (master, mm), because the SMMU driver keeps one set of PASID tables
per IOMMU domain.

> Either you could just use plain old mmu_notifier_register to avoid
> the reuse.  Or we could enhance the mmu_notifier_get to pass a private
> oaque instance ID pointer, which is checked in addition to the ops,
> and you could probably kill off the bonds list and lookup.

Going back to mmu_notifier_register() seems better for now. I don't want
to change the core APIs just for this driver, because it's likely to
change again when more hardware starts appearing and we optimize it.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
