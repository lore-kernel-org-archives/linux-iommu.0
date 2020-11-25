Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016ABC5519F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 09:28:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E062206F9
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 09:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2TU+ZzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E062206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 90DEB27404;
	Wed, 25 Nov 2020 09:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdM6DBFboN1Z; Wed, 25 Nov 2020 09:28:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC8D5203F4;
	Wed, 25 Nov 2020 09:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2DAEC163C;
	Wed, 25 Nov 2020 09:28:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 455F3C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 09:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2D68686D64
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 09:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dNiBBuvskw0H for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B08EB86D63
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 09:28:10 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id d17so1037244edq.2
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 01:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=V6jfPwZkNeh5oW/xhyxIAPCS+jYbX5BnmAGa7tqS/UM=;
 b=J2TU+ZzTtpXOeRpQEU95Ot5rlO5r6/XqvYl5hbbxifRwxuudgrBEX+kHKxWKrh0yR+
 d57ZC0VghJ3JrkXqCZ5vuegixijbxUTkoHcoDeEg11SJPHlRp+2GvFW63hpArzENjq4U
 OlF4db7JcfP3J6yAqr1EhhDw3oaiUx2sAcSA0NzoqPQAALKchRAM7bJGV1FEyU/u8Zew
 714LCXKYumJNKQVlpjCTYX+Z7UJsT797AMbwG/YZfFX4eQ60bh81Lj92i3gDvaNhbTY/
 5f3jFSNHbCDkr9eiCZyarUEoxZFkkIlKVBkr3onMOxe0WoWtw4M6SyzvBKX/R+450e6r
 RKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V6jfPwZkNeh5oW/xhyxIAPCS+jYbX5BnmAGa7tqS/UM=;
 b=lqGkuVvEJPGaZGDlYkcwWMd2WwGPljJy+e930GWTfd1ivtdg/CNf06nT3aCkx3jUGo
 iNGL6nrLAA+7eg9oKOcM5OPoYHXjvdb7+3A3ziAegruO+IJ9kKSFf9PfPIRdTEDMIrqD
 Ck4UZkQwFMciWT4J3sPc6TkctOuZqYaYjkgZqqzb0TbPvQQLajCOwy6rsBpDCqIuCtUU
 uRXP5KsUl7jdQH0zGqnmDBWtz2yLt9IxXlxBLluKWhPfwskpcA/XVjcD5S/qYcP8q5SA
 JIdxuIjy0ZR9tymAM4gkuw1PZD+2dshnaL41gZWnJANZFvfaMs3QPrH7CnuzafadgCG1
 x3+A==
X-Gm-Message-State: AOAM533iVBGGiqRwpC2hQkhn1NjmacoqbVns0KIu1xqCjaID37K4++Si
 LQD3QvFbt5TqMwZ4bYB399ewxA==
X-Google-Smtp-Source: ABdhPJzvewHbh7Ug/phOO580pv1zq0+bZCsdfkc81eifmIcHg0fFb/d7vHs0RNWy2PR74Xir911t3A==
X-Received: by 2002:aa7:c716:: with SMTP id i22mr2632276edq.94.1606296489038; 
 Wed, 25 Nov 2020 01:28:09 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p14sm867798edq.6.2020.11.25.01.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 01:28:08 -0800 (PST)
Date: Wed, 25 Nov 2020 10:27:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 12/13] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20201125092749.GA2445658@myrica>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-13-jean-philippe@linaro.org>
 <20201124235800.GA242277@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201124235800.GA242277@nvidia.com>
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 24, 2020 at 07:58:00PM -0400, Jason Gunthorpe wrote:
> On Fri, Sep 18, 2020 at 12:18:52PM +0200, Jean-Philippe Brucker wrote:
> 
> > +/* Allocate or get existing MMU notifier for this {domain, mm} pair */
> > +static struct arm_smmu_mmu_notifier *
> > +arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
> > +			  struct mm_struct *mm)
> > +{
> > +	int ret;
> > +	struct arm_smmu_ctx_desc *cd;
> > +	struct arm_smmu_mmu_notifier *smmu_mn;
> > +
> > +	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
> > +		if (smmu_mn->mn.mm == mm) {
> > +			refcount_inc(&smmu_mn->refs);
> > +			return smmu_mn;
> > +		}
> > +	}
> > +
> > +	cd = arm_smmu_alloc_shared_cd(mm);
> > +	if (IS_ERR(cd))
> > +		return ERR_CAST(cd);
> > +
> > +	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
> > +	if (!smmu_mn) {
> > +		ret = -ENOMEM;
> > +		goto err_free_cd;
> > +	}
> > +
> > +	refcount_set(&smmu_mn->refs, 1);
> > +	smmu_mn->cd = cd;
> > +	smmu_mn->domain = smmu_domain;
> > +	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
> > +
> > +	ret = mmu_notifier_register(&smmu_mn->mn, mm);
> > +	if (ret) {
> > +		kfree(smmu_mn);
> > +		goto err_free_cd;
> > +	}
> 
> I suppose this hasn't been applied yet, but someone asked me to look
> at this series..

It's queued for v5.11, but I could submit improvements for 5.12

> Why did you drop the change to mmu_notifier_get here?

Dropped at v6 when I got rid of the io_mm cruft:
https://lore.kernel.org/linux-iommu/20200430143424.2787566-1-jean-philippe@linaro.org/

> I'm strongly
> trying to discourage static lists matching mm's like smmu_mn is
> doing. This is handled by the core code, don't open code it..

We discussed this at v6, which wonkily stored the mn ops in the domain to
obtain a unique notifier per {mm, domain}. A clean solution requires
changing mm_notifier_get() to use an opaque token. Rather than testing
{mm, ops} uniqueness it would compare {mm, ops, token}. I figured it
wasn't worth the effort for a single driver, especially since the SMMU
driver would still have one list matching because it needs to deal with
both {mm, domain} and {mm, device} uniqueness.
https://lore.kernel.org/linux-iommu/20200501121552.GA6012@infradead.org/

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
