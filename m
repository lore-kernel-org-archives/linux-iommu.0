Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4664AC433E5
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:46:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7D32076D
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPfB56bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7D32076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4C0288AE0;
	Thu, 16 Jul 2020 15:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N0xhNlgfd3WL; Thu, 16 Jul 2020 15:46:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4039488AC0;
	Thu, 16 Jul 2020 15:46:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB8FC0893;
	Thu, 16 Jul 2020 15:46:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDFA7C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AA930203F4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cg4GtT4j+aqf for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 15:46:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 2C28A2010B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:46:14 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id d16so5056476edz.12
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6ljVtEAns8z/jn7DCignaoAnzmnNFDfpuHqi7UerqxU=;
 b=aPfB56bi8qbQ9Bnwzyzn1R7YAPhRGG2a7TuNSTdn1VG+EFU2a3GK0Os96HBqBxOA4Q
 crd5Uc/b5vofjrBBPsO1A1M1u9mJ8VlxCnRA3zghwvh+MzJO18eT+hOHd3EY1SY7BLTm
 yXhBPQr9E6IN6tHfotQyQ8cWkV+jODeykTCbVZVR6MfzIvqJy/PiX1x19JHDutuE9nan
 d//Grc923sXLl6RS3HS503/R80t9jP8jYvTth/s5OGZUNqw/HgDHl/08+hIEx5VKGemC
 wKzoutyUUbjWCgX8MnAhynaEkuG0UbKh7rrHT4Fo0p+uhXu48OFPLlynHiobSNh3EFZx
 rwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6ljVtEAns8z/jn7DCignaoAnzmnNFDfpuHqi7UerqxU=;
 b=ILQ5dPYzU5khgh4XdlOx1heWcrH3Iga7eO1wCZ0EfcRxjgbOMGpEeNAiFU0203ZFGE
 8+Ps+jp+ngOQi8/UclNBN1iksIr56FRJl8qcexibExwttGNSQ+Ik/qnuA4A24cLcoAZ5
 KjNu/3s8R0CSIMCSTo8Ao5tWL8WL1g5MK142fy6WsDEzZetVVG1sq1Pbanq1Dpp/RhB7
 0+Ywbd1vcTsJVieANJ3hpGaRMSU0/TkUAXYpbq2N3uTE+eXXemMWkoOydqjGbd2d4PrF
 Zp+OnZm+RunLE5g7KzyqzyqgZ8/rNXNSX7QvFK8KlEOYx2XCgCih0nUIZ9XPV+YF9WET
 tO1g==
X-Gm-Message-State: AOAM5313iyYoS54LaRLvilpUk/1nxOAa2I9+bD7tDjwvDyI8sekq5NW4
 nPHiEAJlql7e34ZHRG55JGmhlg==
X-Google-Smtp-Source: ABdhPJwbdkI3Q+F63rYDOBFMMWI1aDZf4JEWa5oyS7j5a2G8ovxWK10g6L0x8GCJgTIZg2aQM1EIpg==
X-Received: by 2002:a05:6402:31ba:: with SMTP id
 dj26mr5026934edb.181.1594914372307; 
 Thu, 16 Jul 2020 08:46:12 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f16sm5367024ejr.0.2020.07.16.08.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 08:46:11 -0700 (PDT)
Date: Thu, 16 Jul 2020 17:45:58 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 07/12] iommu/arm-smmu-v3: Share process page tables
Message-ID: <20200716154558.GC447208@myrica>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-8-jean-philippe@linaro.org>
 <20200713202236.GA3575@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713202236.GA3575@willie-the-truck>
Cc: fenghua.yu@intel.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 catalin.marinas@arm.com, zhengxiang9@huawei.com, hch@infradead.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 13, 2020 at 09:22:37PM +0100, Will Deacon wrote:
> > +static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
> > +{
> > +	struct arm_smmu_ctx_desc *cd;
> >  
> > -	xa_erase(&asid_xa, cd->asid);
> > +	cd = xa_load(&asid_xa, asid);
> > +	if (!cd)
> > +		return NULL;
> > +
> > +	if (cd->mm) {
> > +		/* All devices bound to this mm use the same cd struct. */
> > +		refcount_inc(&cd->refs);
> > +		return cd;
> > +	}
> 
> How do you handle racing against a concurrent arm_smmu_free_asid() here?

Patch 8 adds an asid_lock to deal with this, but it should be introduced
in this patch. There is a potential use-after-free here, if
arm_smmu_domain_free() runs concurrently.

> 
> > +__maybe_unused
> > +static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
> > +{
> > +	u16 asid;
> > +	int ret = 0;
> > +	u64 tcr, par, reg;
> > +	struct arm_smmu_ctx_desc *cd;
> > +	struct arm_smmu_ctx_desc *old_cd = NULL;
> > +
> > +	lockdep_assert_held(&sva_lock);
> 
> Please don't bother with these for static functions (but I can see the
> value in having them for functions with external callers).
> 
> > +
> > +	asid = mm_context_get(mm);
> > +	if (!asid)
> > +		return ERR_PTR(-ESRCH);
> > +
> > +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> > +	if (!cd) {
> > +		ret = -ENOMEM;
> > +		goto err_put_context;
> > +	}
> > +
> > +	arm_smmu_init_cd(cd);
> > +
> > +	old_cd = arm_smmu_share_asid(asid);
> > +	if (IS_ERR(old_cd)) {
> > +		ret = PTR_ERR(old_cd);
> > +		goto err_free_cd;
> > +	} else if (old_cd) {
> 
> Don't need the 'else'
> 
> > +		if (WARN_ON(old_cd->mm != mm)) {
> > +			ret = -EINVAL;
> > +			goto err_free_cd;
> > +		}
> > +		kfree(cd);
> > +		mm_context_put(mm);
> > +		return old_cd;
> 
> This is a bit messy. Can you consolidate the return path so that ret is a
> pointer and you have an 'int err', e.g.:
> 
> 	return err < 0 ? ERR_PTR(err) : ret;

Sure, I think it looks a little nicer this way

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
