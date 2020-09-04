Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA7C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 09:05:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13729207EA
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 09:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13729207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4BF986E76;
	Fri,  4 Sep 2020 09:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7P8IPKQ9qh-g; Fri,  4 Sep 2020 09:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 571C786C26;
	Fri,  4 Sep 2020 09:05:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33FF5C0052;
	Fri,  4 Sep 2020 09:05:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B79C8C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B344986E71
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HKyKYK91w7K for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 09:05:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9215486C26
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:05:22 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 96D08433; Fri,  4 Sep 2020 11:05:20 +0200 (CEST)
Date: Fri, 4 Sep 2020 11:05:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
Message-ID: <20200904090519.GF6714@8bytes.org>
References: <20200814162252.31965-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814162252.31965-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>
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

On Fri, Aug 14, 2020 at 07:22:52PM +0300, Dmitry Osipenko wrote:
> The mapping operations of the Tegra SMMU driver are subjected to a race
> condition issues because SMMU Address Space isn't allocated and freed
> atomically, while it should be. This patch makes the mapping operations
> atomic, it fixes an accidentally released Host1x Address Space problem
> which happens while running multiple graphics tests in parallel on
> Tegra30, i.e. by having multiple threads racing with each other in the
> Host1x's submission and completion code paths, performing IOVA mappings
> and unmappings in parallel.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thierry, does this change look good to you?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
