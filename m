Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61F4C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9187361079;
	Fri, 17 Dec 2021 08:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zC2i9H2xsy9D; Fri, 17 Dec 2021 08:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8454860DFC;
	Fri, 17 Dec 2021 08:08:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C94DC002F;
	Fri, 17 Dec 2021 08:08:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A69CDC0012;
 Fri, 17 Dec 2021 08:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8103440201;
 Fri, 17 Dec 2021 08:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HlUUrMcFcp5j; Fri, 17 Dec 2021 08:08:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C73B74015F;
 Fri, 17 Dec 2021 08:08:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A4A0436D; Fri, 17 Dec 2021 09:08:37 +0100 (CET)
Date: Fri, 17 Dec 2021 09:08:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH] iommu/virtio: Fix typo in a comment
Message-ID: <YbxFhHS0OFzGqbqX@8bytes.org>
References: <20211216083302.18049-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211216083302.18049-1-wangxiang@cdjrlc.com>
Cc: jean-philippe@linaro.org, iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Dec 16, 2021 at 04:33:02PM +0800, Xiang wangx wrote:
> The double `as' in a comment is repeated, thus it should be removed.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
