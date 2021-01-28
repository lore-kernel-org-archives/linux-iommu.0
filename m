Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E007FC433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 20:31:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B20160235
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 20:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B20160235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1FC9686141;
	Thu, 28 Jan 2021 20:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rtikv-gvs2AG; Thu, 28 Jan 2021 20:31:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 99DDF864BD;
	Thu, 28 Jan 2021 20:31:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A165C08A1;
	Thu, 28 Jan 2021 20:31:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C87EC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 20:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 67A7285DE0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 20:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbD-W8YIhG80 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 20:31:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E4E6185CDB
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 20:31:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D098D6146D;
 Thu, 28 Jan 2021 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611865914;
 bh=ikddncy7CqjnKtLrYpUeMTE7X6rsHUE6n+WXCE1YkD8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NE7JiXBzTuCvA2Q10N56mTYgsE2JGAo1XZjBq55zIpOGe69wexKJ0CpsuIGnRnzCu
 RTVEBT/NXKWmbkVtPmyUz7JqbLOMKJO94cn9iEM7hbHFv/AnvGGI/WWR4ecLb/LXd2
 kXmRgYJTobbDRdAybBw1clw7ORiky4RCY+RybW4FBQFRtldfnHllXuQg3oFGC+KyOI
 s1XVzSeET6vHDb3T+Yx8oz+kiW0+GbnEWZU2peBP25bN/rinjgfiXjKLDdCgpOh65k
 1rrHWUuuiISHr9dc5GXglLH0LXWkjsUJNy9/kGfstK4MYGveq1Pgh0PrfsL/cbegyb
 0XIo5233AkFHA==
Date: Thu, 28 Jan 2021 20:31:49 +0000
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 0/3] perf/smmuv3: Don't reserve the PMCG register spaces
Message-ID: <20210128203148.GG3016@willie-the-truck>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127113258.1421-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Wed, Jan 27, 2021 at 07:32:55PM +0800, Zhen Lei wrote:
> v2 --> v3:
> Patch 3 is updated because https://lkml.org/lkml/2021/1/22/532 has been queued in advance.
> 
> v1 --> v2:
> According to Robin Murphy's suggestion: https://lkml.org/lkml/2021/1/20/470
> Don't reserve the PMCG register spaces, and reserve the entire SMMU register space.
> 
> v1:
> Since the PMCG may implement its resigters space(4KB Page0 and 4KB Page1)
> within the SMMUv3 64KB Page0. In this case, when the SMMUv3 driver reserves the
> 64KB Page0 resource in advance, the PMCG driver try to reserve its Page0 and
> Page1 resources, a resource conflict occurs.
> 
> commit 52f3fab0067d6fa ("iommu/arm-smmu-v3: Don't reserve implementation
> defined register space") reduce the resource reservation range of the SMMUv3
> driver, it only reserves the first 0xe00 bytes in the 64KB Page0, to avoid
> the above-mentioned resource conflicts.
> 
> But the SMMUv3.3 add support for ECMDQ, its registers space is also implemented
> in the SMMUv3 64KB Page0. This means we need to build two separate mappings.
> New features may be added in the future, and more independent mappings may be
> required. The simple problem is complicated because the user expects to map the
> entire SMMUv3 64KB Page0.
> 
> Therefore, the proper solution is: If the PMCG register resources are located in
> the 64KB Page0 of the SMMU, the PMCG driver does not reserve the conflict resources
> when the SMMUv3 driver has reserved the conflict resources before. Instead, the PMCG
> driver only performs devm_ioremap() to ensure that it can work properly.
> 
> Zhen Lei (3):
>   perf/smmuv3: Don't reserve the PMCG register spaces
>   perf/smmuv3: Add a MODULE_SOFTDEP() to indicate dependency on SMMU
>   iommu/arm-smmu-v3: Reserving the entire SMMU register space

I'll need Robin's ack on these.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
