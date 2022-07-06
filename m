Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40472C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 11:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E53A7600C5;
	Wed,  6 Jul 2022 11:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E53A7600C5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AZcs/8PQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CptoX7mlD52E; Wed,  6 Jul 2022 11:50:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3837607B5;
	Wed,  6 Jul 2022 11:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3837607B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C26BC0035;
	Wed,  6 Jul 2022 11:50:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6250DC002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BE44404F6
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:50:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BE44404F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AZcs/8PQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SdcCA5b-bZQ2 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 11:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A6B0400AC
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A6B0400AC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:50:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E559B61EF0;
 Wed,  6 Jul 2022 11:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43FFC3411C;
 Wed,  6 Jul 2022 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657108237;
 bh=pIkja7u4jVh70cjtOcr/icdaQPCTUe5JoMbq34s2vCA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AZcs/8PQUqBcCYbonWkSDNfeylddwt8DzSYGJceY9yQoymUm1LGtSSG4b7LjShl/7
 WZ2qs49p9ECdbmNoFL8nhUg0Q0m7QIs0zLU37eHfOGr1GFyMoHEh8juucfoVjyMmIR
 ajvq7TmLNCUyZHv4keoy/mTWt3SOqE0iwG5syLwvpZymYoObj/wihM6BGcOawmgbrz
 9uQ1gruOt4q9DFe5vAQv1ino7n6NpOQ+V3+FOiz3OSXF0FdnoZ5C9r6yFG2643vVpN
 9/N7yibHBWvj1Zmjy0dc0nHzxgb9JO/SxG+7fIHDKcyvqfDrpbhM0h+SSJGjUP1So6
 OMmUMmPsp7dHw==
Date: Wed, 6 Jul 2022 12:50:31 +0100
From: Will Deacon <will@kernel.org>
To: yf.wang@mediatek.com
Subject: Re: [PATCH v12 0/2] iommu/mediatek: TTBR up to 35bit support
Message-ID: <20220706115028.GC2403@willie-the-truck>
References: <20220630092927.24925-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630092927.24925-1-yf.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com,
 iommu@lists.linux-foundation.org, Libo Kang <Libo.Kang@mediatek.com>,
 linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, Ning Li <ning.li@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Jun 30, 2022 at 05:29:24PM +0800, yf.wang@mediatek.com wrote:
> This patchset adds MediaTek TTBR up to 35bit support for single normal zone.
> 
> Changes in v12:
> - Update [PATCH 1/2]: remove GENMASK(31, 7)
> - Update [PATCH 2/2]: remove MMU_PT_ADDR_MASK definition.

For both patches:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick these up for 5.20?

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
