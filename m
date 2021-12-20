Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD12DC433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 12:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C358408F7;
	Mon, 20 Dec 2021 12:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8_Gxf9ojAdCW; Mon, 20 Dec 2021 12:40:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6716B408C7;
	Mon, 20 Dec 2021 12:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47FE6C002F;
	Mon, 20 Dec 2021 12:40:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF0E1C0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 12:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F02560C29
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 12:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vK9wIm5a9L22 for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 12:40:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2EFD60C24
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 12:40:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F9731042;
 Mon, 20 Dec 2021 04:40:10 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2690E3F718;
 Mon, 20 Dec 2021 04:40:09 -0800 (PST)
Message-ID: <e92a5d33-55a4-7262-0448-4ad8f924e6c3@arm.com>
Date: Mon, 20 Dec 2021 12:40:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] iommu/iova: Temporarily include dma-mapping.h from iova.h
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20211220123448.19996-1-joro@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211220123448.19996-1-joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-12-20 12:34, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some users of iova.h still expect that dma-mapping.h is also included.
> Re-add the include until these users are updated to fix compile
> failures in the iommu tree.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   include/linux/iova.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 0abd48c5e622..cea79cb9f26c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -12,6 +12,7 @@
>   #include <linux/types.h>
>   #include <linux/kernel.h>
>   #include <linux/rbtree.h>
> +#include <linux/dma-mapping.h>
>   
>   /* iova structure */
>   struct iova {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
