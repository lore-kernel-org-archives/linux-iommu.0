Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A1AC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81478828AA;
	Mon, 14 Feb 2022 12:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCOXa2PT1Lk5; Mon, 14 Feb 2022 12:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8163F813BB;
	Mon, 14 Feb 2022 12:41:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5304FC0011;
	Mon, 14 Feb 2022 12:41:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD4BC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9816409DA
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5dFADgUC2WI for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:41:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64B8B41061
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:41:34 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 287FF2FB; Mon, 14 Feb 2022 13:41:29 +0100 (CET)
Date: Mon, 14 Feb 2022 13:41:27 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Message-ID: <YgpN9zvNFohAESii@8bytes.org>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
 <YgpAfVVhkNljJhJY@8bytes.org>
 <c95e5d3a-d2b4-dcc1-b6ba-2e4e9ebc5bb0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c95e5d3a-d2b4-dcc1-b6ba-2e4e9ebc5bb0@arm.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
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

On Mon, Feb 14, 2022 at 12:32:21PM +0000, Robin Murphy wrote:
> In this particular case it cannot fail on any system the driver actually
> runs on - it's a platform device so the dma_mask pointer is always
> initialised, then dma_direct_supported() on arm64 will always return true
> for any mask wider than 32 bits, while arm_dma_supported() will also always
> pass since a 32-bit system cannot have memory above 40 bits either.
> 
> There's no great harm in adding the check for the sake of consistency, I
> guess, but it's purely cosmetic and not fixing anything.

Okay, thanks Robin and Nikita for looking to quickly into this. I will
apply it for 5.18 just to be on the safe side if the above assumptions
change.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
