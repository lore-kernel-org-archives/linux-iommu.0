Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D4C38A2E
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 12:14:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42741206B9
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 12:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42741206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE1EF8689C;
	Sat, 18 Apr 2020 12:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TH2wD-noRXgs; Sat, 18 Apr 2020 12:14:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7874786881;
	Sat, 18 Apr 2020 12:14:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64EAAC089F;
	Sat, 18 Apr 2020 12:14:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C4D3C0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 47A4120130
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-hJRJnl3om1 for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 12:14:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 25DE62010A
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:14:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BFDE4342; Sat, 18 Apr 2020 14:14:41 +0200 (CEST)
Date: Sat, 18 Apr 2020 14:14:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu: Fix MTK_IOMMU dependencies
Message-ID: <20200418121440.GC6113@8bytes.org>
References: <20200410143047.19691-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200410143047.19691-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
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

On Fri, Apr 10, 2020 at 04:30:47PM +0200, Geert Uytterhoeven wrote:
 
> Fixes: e93a1695d7fb5513 ("iommu: Enable compile testing for some of drivers")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
