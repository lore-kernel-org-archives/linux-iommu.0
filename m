Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D4EC433F5
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 11:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0D0740371;
	Wed, 24 Nov 2021 11:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGtar8UIaUjJ; Wed, 24 Nov 2021 11:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E5B84016D;
	Wed, 24 Nov 2021 11:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2234C001E;
	Wed, 24 Nov 2021 11:02:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF78C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 11:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41B18606A7
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 11:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kq5DIWF7eITj for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 11:02:53 +0000 (UTC)
X-Greylist: delayed 00:27:03 by SQLgrey-1.8.0
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF0BD6068C
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 11:02:52 +0000 (UTC)
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1mppcu-0004vP-Bj; Wed, 24 Nov 2021 11:35:44 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
Date: Wed, 24 Nov 2021 11:35:43 +0100
Message-ID: <2895944.ZOkXcVNkQQ@diego>
In-Reply-To: <20211124021325.858139-1-knaerzche@gmail.com>
References: <20211124021325.858139-1-knaerzche@gmail.com>
MIME-Version: 1.0
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-kernel@vger.kernel.org, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
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

Am Mittwoch, 24. November 2021, 03:13:25 CET schrieb Alex Bee:
> With the submission of iommu driver for RK3568 a subtle bug was
> introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
> the other way arround - that leads to random errors, especially when
> addresses beyond 32 bit are used.
> 
> Fix it.
> 
> Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> 
> I've found this bug, when testing the recent VOP2 submission, which is
> the first perpherial which uses iommu for RK356x. I could use it on my
> quartz64 8GB board only, when limiting the available memory to less 4GB.
> 
> This patch fixes it.
> 
>  drivers/iommu/rockchip-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5cb260820eda..7f23ad61c094 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -200,8 +200,8 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
>  #define DTE_HI_MASK2	GENMASK(7, 4)
>  #define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
>  #define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
> -#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
> -#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
> +#define PAGE_DESC_HI_MASK1	GENMASK_ULL(35, 32)
> +#define PAGE_DESC_HI_MASK2	GENMASK_ULL(39, 36)

With this change the PAGE_DESC_HI_MASK* now match the other
constants above them in what bits they access, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
