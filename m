Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E69C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF54560EBF;
	Mon, 14 Feb 2022 13:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IqBumWYguGr7; Mon, 14 Feb 2022 13:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 993BC60B5F;
	Mon, 14 Feb 2022 13:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAC3C0011;
	Mon, 14 Feb 2022 13:00:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97AC6C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 855D74015E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MfU_3JvFfLJ5 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:00:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 943E9400E0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:00:04 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9DDC82FB; Mon, 14 Feb 2022 14:00:02 +0100 (CET)
Date: Mon, 14 Feb 2022 14:00:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 0/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
Message-ID: <YgpSUWjWMYZa9GoD@8bytes.org>
References: <20220208002030.1319984-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208002030.1319984-1-yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, will@kernel.org
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

On Tue, Feb 08, 2022 at 09:20:28AM +0900, Yoshihiro Shimoda wrote:
> This patch series is based on renesas-drivers-2022-01-11-v5.16 [1].
> Note that we have to prepare the following registers' setting
> in a bootloader (U-Boot) because the registers are protected.
> Otherwise, data mismatch happened if dmatest with the ipmmu is running.
> 
>  => mw eed01500 0xc0000000; mw eed41500 0xc0000000
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tag/?h=renesas-drivers-2022-01-11-v5.16
> 
> Changes from v2:
>  - Add Reviewed-by tag in patch 1 and 2 (Geert-san, thanks!)
>  - Revise commit description in patch 1.
>  https://lore.kernel.org/all/20220204125653.1194249-1-yoshihiro.shimoda.uh@renesas.com/
> 
> Changes from v1:
>  - Add Reviewed-by tag in patch 1. (Geert-san, thanks!)
>  - Revise a comment in patch 2.
>  https://lore.kernel.org/all/20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com/
> 
> Y
> 
> Yoshihiro Shimoda (2):
>   dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779f0 support
>   iommu/ipmmu-vmsa: Add support for R-Car Gen4

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
