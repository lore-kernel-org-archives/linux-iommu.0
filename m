Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF857C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 08:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90EE1402C9;
	Wed,  4 May 2022 08:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZiUCHnZnG9r3; Wed,  4 May 2022 08:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 615C9401FB;
	Wed,  4 May 2022 08:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28479C0039;
	Wed,  4 May 2022 08:37:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B7C4C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A29982F13
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8RB8cAXJ4N3 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:37:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C1D282EE1
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:37:02 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2265267B; Wed,  4 May 2022 10:36:59 +0200 (CEST)
Date: Wed, 4 May 2022 10:36:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] iommu: dart: Add missing module owner to ops structure
Message-ID: <YnI7KQ6qwwCKC6Hc@8bytes.org>
References: <20220502092238.30486-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502092238.30486-1-marcan@marcan.st>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

On Mon, May 02, 2022 at 06:22:38PM +0900, Hector Martin wrote:
> This is required to make loading this as a module work.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/iommu/apple-dart.c | 1 +
>  1 file changed, 1 insertion(+)

Applied for v5.18, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
