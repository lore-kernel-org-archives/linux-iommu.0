Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938DC2BBD1
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:38:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7EF2223D
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqR8ZJtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7EF2223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D21AC87638;
	Thu, 17 Sep 2020 14:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TFUo48ZEqEUk; Thu, 17 Sep 2020 14:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 405728762E;
	Thu, 17 Sep 2020 14:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19741C0864;
	Thu, 17 Sep 2020 14:38:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9E66C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B382587073
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z8p1_QG2lyr5 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 14:38:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CA4F58701E
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:38:16 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id y15so2313106wmi.0
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CtuxQ6lkdfUKpkWh0jJ03L2oWgI5bJRs5kCxaIOTdgc=;
 b=dqR8ZJtbdZoVqOaxXx6An97H+bvZ9ZsupkEh7t4eElzMzNz+oAL+bz8eGOmtAEsi1p
 WrTjCw73K0zy68tAA6gZrb3oYLEVH1aRMR1uGR9nQE7wjYboOdsYapnQ1CTMaaexV1nJ
 2q86IvaIc99ICArtKKDRMEr5YnnIMXDhNRkLq5HoOeZEPwbdvcjllvdrtf3R4OavIqEK
 Tna22S6UgAxeNaikwKPrShbYY34EWvcdXyp/gK2V72/+mjQwsuErLckF7dsLb5odholp
 KR/Wd/O3V5MCD3MUx5WObPFJUFzodQxUy2FzlxH/JUFhpFEFwNibKQ/LrjjLigLIn6ge
 MvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CtuxQ6lkdfUKpkWh0jJ03L2oWgI5bJRs5kCxaIOTdgc=;
 b=d1yllxpw6T81VUPDTcgaXBCHrk++z/0QQ2e8JjaDVRk0leaQGIQdZ7bh80Ajj46len
 Wjg7cD8vLOA1sB5dW4BV4iO4cNJ/br5uMv44Ct/ZP6gL/4vBHNsVrl9PL46v6OMruRqo
 wOCTv7GU7Sb48EK8Z0Qas645J5D50ipDNTexwqqPfHZHXsVYcZjvFWsZZoj8PoUzWiOR
 nH9OFYFpIIlwPDDDWszwe7NQYWuH262yp3GaEVWwHsmAxp1fVS0/Jfhl12impnJlbxZG
 WyR4Wttl8xQrd022ZktXlh3SxF9t6hu3h2h2L4yyCGRwbmzi6qus1jwKQIBE3qu/hReX
 UCEg==
X-Gm-Message-State: AOAM531H1SQTsbOEsGGaDVtMCe7GkXzAnNsyWMyEmVjdKXxIIoM2E1Z+
 k05Cmv3zgKnBYC48Z4+fCwCzJA==
X-Google-Smtp-Source: ABdhPJwUYlvmdwtMmGh+X0qxqKnktC6h/DAxu70padx26ZJ1ILdAhfe3pS25fq0Ysj5WyPx640t7Tw==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr9982683wmd.2.1600353495084; 
 Thu, 17 Sep 2020 07:38:15 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm3908305wrv.90.2020.09.17.07.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 07:38:14 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:37:55 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH RESEND v9 08/13] iommu/arm-smmu-v3: Share process page
 tables
Message-ID: <20200917143755.GC134903@myrica>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-9-jean-philippe@linaro.org>
 <496fbadf-a075-eed2-2dda-eeaaac35656e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <496fbadf-a075-eed2-2dda-eeaaac35656e@redhat.com>
Cc: fenghua.yu@intel.com, will@kernel.org, catalin.marinas@arm.com,
 zhengxiang9@huawei.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
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

On Tue, Sep 08, 2020 at 09:41:20AM +0200, Auger Eric wrote:
> > +static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
> > +{
> > +	u16 asid;
> > +	int err = 0;
> > +	u64 tcr, par, reg;
> > +	struct arm_smmu_ctx_desc *cd;
> > +	struct arm_smmu_ctx_desc *ret = NULL;
> > +
> > +	asid = arm64_mm_context_get(mm);
> > +	if (!asid)
> > +		return ERR_PTR(-ESRCH);
> > +
> > +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> > +	if (!cd) {
> > +		err = -ENOMEM;
> > +		goto out_put_context;
> > +	}
> > +
> > +	refcount_set(&cd->refs, 1);
> > +
> > +	mutex_lock(&arm_smmu_asid_lock);
> > +	ret = arm_smmu_share_asid(mm, asid);
> > +	if (ret) {
> > +		mutex_unlock(&arm_smmu_asid_lock);
> > +		goto out_free_cd;
> > +	}
> > +
> > +	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
> > +	mutex_unlock(&arm_smmu_asid_lock);
> I am not clear about the locking scope. Can't we release the lock before
> as if I understand correctly xa_insert/xa_erase takes the xa_lock.

The mutex prevents conflicts with the private ASID allocation:

	CPU 1					CPU 2
arm_smmu_alloc_shared_cd()		arm_smmu_attach_dev()
 arm_smmu_share_asid(mm, 1)		 arm_smmu_domain_finalise_s1()
  xa_load(&asid_xa, 1) -> NULL, ok
					  xa_alloc(&asid_xa) -> ASID #1
 xa_insert(&asid_xa, 1) -> error

> > +
> > +	if (err)
> > +		goto out_free_asid;
> > +
> > +	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
> Wondering if no additional check is needed to check if the T0SZ is valid
> as documented in 5.4 Context Descriptor T0SZ description.

Indeed, this code probably predates 52-bit VA support. Now patch 10 should
check the VA limits, and we should use vabits_actual rather than VA_BITS.
I'll leave out IDR3.STT for now because arch/arm64/ doesn't support it.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
