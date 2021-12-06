Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2120BC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 12:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A87AA60BF7;
	Mon,  6 Dec 2021 12:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IAz1eMqKEgVm; Mon,  6 Dec 2021 12:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D95E605A0;
	Mon,  6 Dec 2021 12:04:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CAE8C002F;
	Mon,  6 Dec 2021 12:04:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86DEEC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C9B74014B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJKadwi2iGVi for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 12:04:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3043240130
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:04:10 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DCCD3396; Mon,  6 Dec 2021 13:04:06 +0100 (CET)
Date: Mon, 6 Dec 2021 13:04:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Fix table descriptor paddr
 formatting
Message-ID: <Ya38NRG7K/+Atovr@8bytes.org>
References: <20211120031343.88034-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211120031343.88034-1-marcan@marcan.st>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, Nov 20, 2021 at 12:13:43PM +0900, Hector Martin wrote:
>  drivers/iommu/io-pgtable-arm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
