Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C340FC4167B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 20:07:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555D523A02
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 20:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555D523A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 06D6B204DC;
	Wed,  9 Dec 2020 20:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1beGWad7fIj; Wed,  9 Dec 2020 20:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA84320392;
	Wed,  9 Dec 2020 20:07:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93955C0893;
	Wed,  9 Dec 2020 20:07:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D9C0C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 20:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EC550876E4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 20:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkVcaxMO_zs5 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 20:07:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8D62B876E2
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 20:07:48 +0000 (UTC)
Date: Wed, 9 Dec 2020 20:07:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607544468;
 bh=RwtPuIYol40kyDSA4Jk5Z51qfhMMaedTf5Q+9030Dtg=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=WjTRYZErNqmS7HSgHfZJvcGSudj6QQ/BoaTG0mpwRSde3DtGgpDV/4KNjtqyEp4N+
 2SFusGgwv6iZgTJCRLikjacas6bF+LBJeIO0GTHgZ4EvroAXOfs4Of64brnCCAiEL/
 NS4gCLeuTP+i1+ZCKXLR4nYVtPRM5cuymwlc4I/UEatT/px6/DX1ax9KzE7bxb22m0
 D2BA2bOs49gRHUGRFhScPxtDW0b+fk74I1a1oBmW5xKntFJsqo1uuXPCsQPbHQGka9
 x7PsjSp1nxXDMK0hxlRclxlkbHpcjvFPaN5DcSyltP56QCuHoa53NMckH935C/JDn1
 FhQiUpC9ttZAw==
From: Will Deacon <will@kernel.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Message-ID: <20201209200741.GA8992@willie-the-truck>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
 <20200924101340.GC170808@myrica>
 <47b244b99f284790b82b2c0a968ba830@huawei.com>
 <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Alistair Popple <apopple@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
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

On Wed, Dec 09, 2020 at 07:49:09PM +0000, Krishna Reddy wrote:
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
> Do you have plan to get your earlier patch to handle invalidate
> notifications into upstream sometime soon? 

Is that a limitation of the SMMU implementation, the interconnect or the
integration?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
