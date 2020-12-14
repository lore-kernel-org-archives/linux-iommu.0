Return-Path: <SRS0=68Au=FS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E27C4361B
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 09:33:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0847F22583
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 09:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0847F22583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 18DCF204CB;
	Mon, 14 Dec 2020 09:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9thEDdXjeXSv; Mon, 14 Dec 2020 09:33:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A323520455;
	Mon, 14 Dec 2020 09:33:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84AE3C088E;
	Mon, 14 Dec 2020 09:33:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25ABAC013B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 09:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0906686149
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 09:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nBiGzFDCl63c for <iommu@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 09:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E0C5B85F80
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 09:33:08 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x22so13055528wmc.5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TineRrEPPDttYAyutqZGvIPRC+1HCPGVhbRY4x0K8Gw=;
 b=afWbPJGiCE2mtIz13p0+yRbJLVOQgZMmsmuDvI9jIIAcPLtiFcG+XHo+k8dHq9ALU/
 9OjP+VVL168dcpsoMIV4XlM2SehyFwUo7Xv+LsuiZmq8m1b9aQ22yZiZY7vJt1XxAEks
 vCo7Kj8RPnv8VFaYhw9nSc9M5pSvAnTJqpqAG3e1iIte+0YvepCGIvzAK4/nUy1zR2Qh
 x+G9vrla5aDL+GI9wv+wOF/VIRiKPV4me3jTimLSIlGyfYw/jq1MSAT/DDJx9OITRW2f
 s5qdQSfRvUSotqJzh5FMC7vSs3jDxrlqt75Yuscx3M2qY6dqGzuTZtgX0kcTnlvweMHl
 o7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TineRrEPPDttYAyutqZGvIPRC+1HCPGVhbRY4x0K8Gw=;
 b=YUcSjJAUhPj9dmock4c+uyqTSB52yc8i28YXXGW4xmsIq4PaFgnOkz8rfj/rphlmgK
 9VaGYuf1noycOM55udOHcE9aMkhD/G+pIWq6WaccYC2CCtduXsCzEqt4MQ89Yp6UkZOr
 OKBTBw+MAaZQYkRePvMmfJNy6wn9pdJNS0BieCL0L8LW7t6ICtaez+T6ychmPB+JLLMI
 o+IcWAX/14ci2jSpvooqV0GXqPbD4WiFCxNhC54vfDRutlicMJXTg8zdwbcLDMeZUZ++
 w7J7LIuXXT3WnQwDcU+asvSG3wVzgAowf2rKmDC9p0tKIeEk/e5X4uuroeG9r4D8GLbd
 +maA==
X-Gm-Message-State: AOAM533NEN+7TA8VMr/kjoAHXI/cV+xKTiTzkx1YAd2VFflHpGtTkf+w
 0jEzjnpUCa1IaRK3di3zyydJLw==
X-Google-Smtp-Source: ABdhPJyFirWR60k25HcLsKbSDtl/crzD/mM5f4fKJkJAzdezDCgXo+JRjNimtjlIMUkKqgn0vf6CbA==
X-Received: by 2002:a1c:e309:: with SMTP id a9mr27264055wmh.172.1607938387127; 
 Mon, 14 Dec 2020 01:33:07 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c7sm22420381wro.16.2020.12.14.01.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Dec 2020 01:33:06 -0800 (PST)
Date: Mon, 14 Dec 2020 10:32:47 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Message-ID: <X9cxP8g5JgAGS2wD@myrica>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
 <20200924101340.GC170808@myrica>
 <47b244b99f284790b82b2c0a968ba830@huawei.com>
 <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Alistair Popple <apopple@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "will@kernel.org" <will@kernel.org>,
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

On Wed, Dec 09, 2020 at 07:49:09PM +0000, Krishna Reddy wrote:
> Hi Jean,
> > > Why is BTM mandated for SVA? I couldn't find this requirement in 
> > > SMMU spec (Sorry if I missed it or this got discussed earlier). But 
> > > if performance is the
> > only concern here,
> > > is it better just to allow it with a warning rather than limiting 
> > > SMMUs without
> > BTM?
> >
> > It's a performance concern and requires to support multiple 
> > configurations, but the spec allows it. Are there SMMUs without BTM 
> > that need it?
> 
> The Tegra Next Generation SOC uses arm-smmu-v3, but it doesn't have support for BTM.
> Do you have plan to get your earlier patch to handle invalidate notifications into upstream sometime soon? 
> Can the dependency on BTM be relaxed with the patch?
> 
> PATCH v9 13/13] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
> https://www.spinics.net/lists/arm-kernel/msg825099.html

This patch (which should be in 5.11) only takes care of sending ATC
invalidations to PCIe endpoints. With this, BTM is still required to
invalidate SMMU TLBs.

However we could enable command-queue invalidation when ARM_SMMU_FEAT_BTM
isn't set. Invalidations are still a relatively rare event so it may not
be outrageously slow. I can add a patch to my tree if you have hardware to
test. This could also be a first step for enabling SVA on other systems as
well, because I'm not finding time to work on BTM at the moment (requires
pinning VMIDs in KVM).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
