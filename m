Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D2CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 08:58:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17416206F5
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 08:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17416206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E61BB883CF;
	Wed, 13 May 2020 08:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dP4J23eVykwk; Wed, 13 May 2020 08:58:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92D3788395;
	Wed, 13 May 2020 08:58:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A7A1C088B;
	Wed, 13 May 2020 08:58:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 980F2C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 08:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 835A388611
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 08:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kW5-BxJqCzw2 for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 08:58:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0AF2288158
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 08:58:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9252C379; Wed, 13 May 2020 10:58:51 +0200 (CEST)
Date: Wed, 13 May 2020 10:58:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iommu/renesas: fix unused-function warning
Message-ID: <20200513085850.GG9820@8bytes.org>
References: <20200508220224.688985-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508220224.688985-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hai Nguyen Pham <hai.pham.ud@renesas.com>, Joerg Roedel <jroedel@suse.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Simon Horman <horms+renesas@verge.net.au>,
 Will Deacon <will@kernel.org>
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

On Sat, May 09, 2020 at 12:02:16AM +0200, Arnd Bergmann wrote:
> gcc warns because the only reference to ipmmu_find_group
> is inside of an #ifdef:
> 
> drivers/iommu/ipmmu-vmsa.c:878:28: error: 'ipmmu_find_group' defined but not used [-Werror=unused-function]
> 
> Change the #ifdef to an equivalent IS_ENABLED().
> 
> Fixes: 6580c8a78424 ("iommu/renesas: Convert to probe/release_device() call-backs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
