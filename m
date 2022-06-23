Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4153DC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 07:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFD8D6135E;
	Thu, 23 Jun 2022 07:44:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFD8D6135E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMfjtMPBl79A; Thu, 23 Jun 2022 07:44:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C28B61351;
	Thu, 23 Jun 2022 07:44:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C28B61351
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 661B8C0039;
	Thu, 23 Jun 2022 07:44:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE1CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 021B661356
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:44:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 021B661356
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BjFi-Vbn32zv for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 07:44:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4509661351
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4509661351
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:44:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 83E66447; Thu, 23 Jun 2022 09:44:21 +0200 (CEST)
Date: Thu, 23 Jun 2022 09:44:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] iommu/amd: Use try_cmpxchg64 in alloc_pte and
 free_clear_pte
Message-ID: <YrQZ1PQIXfNYSq5g@8bytes.org>
References: <20220525145416.10816-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220525145416.10816-1-ubizjak@gmail.com>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Wed, May 25, 2022 at 04:54:16PM +0200, Uros Bizjak wrote:
> Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
> alloc_pte and free_clear_pte.  cmpxchg returns success in ZF flag, so this
> change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg). Also, remove racy explicit assignment to pteval
> when cmpxchg fails, this is what try_cmpxchg does implicitly from
> *pte in an atomic way.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/amd/io_pgtable.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
