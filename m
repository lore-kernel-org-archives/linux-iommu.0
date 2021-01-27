Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F32DC433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 13:20:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157F8207A9
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 13:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157F8207A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D96E86819;
	Wed, 27 Jan 2021 13:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tmpHJcZcshzV; Wed, 27 Jan 2021 13:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADE0786745;
	Wed, 27 Jan 2021 13:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94D6CC08A1;
	Wed, 27 Jan 2021 13:20:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 833D6C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7E27F85D2B
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aMdbb5O3zeP9 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 13:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5A96085C47
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:20:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52CDF207A2;
 Wed, 27 Jan 2021 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611753600;
 bh=inUC5PP/mCtOcJb9zEFFxMqaSkScQIwSvgVH1JRqWvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VNuRicZmVe/PskXlJzjLEJ722ZnXFAQLGeRAKTwdR9iqt8/1zUf0zHi0a93TqOGkP
 rd8J65szwWJe+FtycVSdjA/Pp/AKW60v17pMS7LryT8DkN5iWh0XRN509189hWu1NC
 jOXWisvo/4jyP2t9Bd+lGFriZvCvIB8ss7aB45OJw7wtGKw+k4zm3ftZh65z5ODLxm
 1Ol1KFwT6HKrPc7oGrdIdPgYUU49minUmwqG3Q3rdt0Y+1iKUtoXMA7U/bgxniSlHS
 bzV8KHX8UUQSGKM4SAl1HSQgAXL1RXse2L7wLfmgvCLY9frBzkvDeDYcOMrLBPNXuZ
 qP3grMuikAOow==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 0/7] MediaTek IOMMU improve tlb flush performance in
 map/unmap
Date: Wed, 27 Jan 2021 13:19:53 +0000
Message-Id: <161175074760.1106263.14591124622667700357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: anan.sun@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 David Laight <David.Laight@ACULAB.COM>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com,
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

On Thu, 7 Jan 2021 20:29:02 +0800, Yong Wu wrote:
> This patchset is to improve tlb flushing performance in iommu_map/unmap
> for MediaTek IOMMU.
> 
> For iommu_map, currently MediaTek IOMMU use IO_PGTABLE_QUIRK_TLBI_ON_MAP
> to do tlb_flush for each a memory chunk. this is so unnecessary. we could
> improve it by tlb flushing one time at the end of iommu_map.
> 
> [...]

After discussion with Joerg, I'll queue this (and hopefully the next posting
of your IOMMU driver) along with the Arm SMMU patches, and then send that
all together.

Applied to will (for-joerg/mtk), thanks!

[1/7] iommu: Move iotlb_sync_map out from __iommu_map
      https://git.kernel.org/arm64/c/d8c1df02ac7f
[2/7] iommu: Add iova and size as parameters in iotlb_sync_map
      https://git.kernel.org/arm64/c/2ebbd25873ce
[3/7] iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
      https://git.kernel.org/arm64/c/20143451eff0
[4/7] iommu: Switch gather->end to the inclusive end
      https://git.kernel.org/arm64/c/862c3715de8f
[5/7] iommu/io-pgtable: Allow io_pgtable_tlb ops optional
      https://git.kernel.org/arm64/c/77e0992aee4e
[6/7] iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
      https://git.kernel.org/arm64/c/f21ae3b10084
[7/7] iommu/mediatek: Remove the tlb-ops for v7s
      https://git.kernel.org/arm64/c/0954d61a59e3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
