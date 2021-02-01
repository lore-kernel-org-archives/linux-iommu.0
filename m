Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5912C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 15:50:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F1464E9B
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 15:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F1464E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F1858536C;
	Mon,  1 Feb 2021 15:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTIrzerUY7l2; Mon,  1 Feb 2021 15:50:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E6A1850DC;
	Mon,  1 Feb 2021 15:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25F44C0FA7;
	Mon,  1 Feb 2021 15:50:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 748D5C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3CBDE2047F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gH74FTQtuJRZ for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 15:50:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id BEB582048C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:50:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A91A464DE1;
 Mon,  1 Feb 2021 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612194626;
 bh=LPWd8gDhHLYrCTwScMmESUyKBXeoErabGVfpRcQJr+U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u/FlsACD4oNtPFVRFroArwrcZsqrjWj44oS3N5mE1F7BdrVdQnBCjSNm2Oa+s8k6r
 2WDU8laRguhCNh5YydQb6iyWj1cse4ICOgIjDJ58M+NSYAuA0mxbMzYDG6Q1iYo39P
 C5YepY1LzPeUNLz9+ooUGgO7Eq/MhEfESftRaxYgck8GzsTaE22n/HJxa8I9O3I/nu
 58Jx2bUa1UWE81F1LiKhPzsX096hCd9UF+Nh4K3HrIIgDFU1e8hQd2+q0F92KkCq+5
 saxOHhCgU1glFPBjXFGO4seBSpeDUdl3N8wdbdj8z6lH6QAo+yAKy6JUBJs58pTycY
 25G+SpNrAjjtg==
Date: Mon, 1 Feb 2021 15:50:21 +0000
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v5 0/1] perf/smmuv3: Don't reserve the PMCG register spaces
Message-ID: <20210201155021.GD15263@willie-the-truck>
References: <20210201132750.1709-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201132750.1709-1-thunder.leizhen@huawei.com>
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

On Mon, Feb 01, 2021 at 09:27:49PM +0800, Zhen Lei wrote:
> v4 --> v5:
> 1. Give up doing the mapping for the entire SMMU register space.
> 2. Fix some compile warnings. Sorry. So sorry.

That's alright, these things happen. However, this came in slightly too
late for 5.12, so please resend at -rc1 and we'll aim for 5.13.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
