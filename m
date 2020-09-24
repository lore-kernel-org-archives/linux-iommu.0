Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA392C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:14:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416A121D24
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTJtSWmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416A121D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A2EBC2E0F9;
	Thu, 24 Sep 2020 10:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYjIQ7q4mnYf; Thu, 24 Sep 2020 10:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3337923018;
	Thu, 24 Sep 2020 10:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22665C0889;
	Thu, 24 Sep 2020 10:14:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9ECC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 16CFE8749C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvVsE7i+fNgp for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 38D4E87475
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:14:00 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z1so3182701wrt.3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kU3gnCMAsP2x/I5wCXT3/EKvoa/BON3ipEwTyPLZ/Ks=;
 b=iTJtSWmqJeU7llzv/rf2LzC0rJBnUIQYVHMUsA9Kd7kAivrPBT6K63Fi8f1slMi4nY
 EI76gDzdH6EXcJlD5LjQK0rmrKM4gjNPwEzpVa7ChVezK11LJd4bepFr6iALMv7J0cci
 SInOhF7PIAlVDnDrTmwd8hCE0kQRjfGXAL0bNg49k6BkYdBU4ynxjOqqUDxKlde5c/W2
 8Hs6RaSL6YO2t6K66sqH2zb+Ez8PBhPsK2cktrU7DJcUqL5ZVBSNaRXKOWn46As6PFBJ
 0JuecfRbRsz9JimHA4i8en4uCflh9w9eY25JOJ1yAn+gRrHUkb9+un2RBh6x+EXPh3ln
 cz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kU3gnCMAsP2x/I5wCXT3/EKvoa/BON3ipEwTyPLZ/Ks=;
 b=rO+tw0/GyZFYXvXYw/3q8tj9ZKwxXfmL9DMN01ZdmzDPGvlL6bXWwK1ZN1gghlydOC
 P8FmvXHY8YXmPGdthiD4oAXsL5V+31as4oSub6KWsTIp08jJZVWSru4AqSqerI+feiFN
 PlCwdo2Lvb/pshZ6LFZW6wJnQAUG0OetzBDTzf9aylImGOm60boIuDb4wBI+dx/WpHQu
 avCcvIVJqSNPhjs0doX9RucV7pG5Zy1mDGew3tt1+O1lHL9XOQH0/e8swCMdCkY5tJAQ
 hQmHRj9t884lGVvadDi1AFrdvAtuPwPk1HImKZ4UWDhG2Picw8+Vrftk8tWNTgZLN4Sv
 YCAg==
X-Gm-Message-State: AOAM532oOPUpi7FFW9ctISK/sNGYN6IgLXsB1hZTBF40VDroek37cGhm
 ylmGzHeVEDBq7TFts3E1kEX5gA==
X-Google-Smtp-Source: ABdhPJzwvyDtM5EY9cTKbSmfCPd8Ndctc7U1hxoVNhC0cIf/mU53M9YuULxQk3Bj1qzclp1sb8T/Iw==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr4708454wrm.0.1600942438754;
 Thu, 24 Sep 2020 03:13:58 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x16sm2948499wrq.62.2020.09.24.03.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:13:58 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:13:40 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Message-ID: <20200924101340.GC170808@myrica>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "will@kernel.org" <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 21, 2020 at 08:59:39AM +0000, Shameerali Kolothum Thodi wrote:
> > +bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> > +{
> > +	unsigned long reg, fld;
> > +	unsigned long oas;
> > +	unsigned long asid_bits;
> > +	u32 feat_mask = ARM_SMMU_FEAT_BTM |
> > ARM_SMMU_FEAT_COHERENCY;
> 
> Why is BTM mandated for SVA? I couldn't find this requirement in SMMU spec
> (Sorry if I missed it or this got discussed earlier). But if performance is the only concern here,
> is it better just to allow it with a warning rather than limiting SMMUs without BTM?

It's a performance concern and requires to support multiple
configurations, but the spec allows it. Are there SMMUs without BTM that
need it?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
