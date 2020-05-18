Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07FDC433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:36:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC8E206D4
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC8E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4C7AF20797;
	Mon, 18 May 2020 13:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inM8I6U6QQL7; Mon, 18 May 2020 13:36:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3A02021135;
	Mon, 18 May 2020 13:36:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 228ABC0888;
	Mon, 18 May 2020 13:36:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBDBAC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA4A785D11
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwCO-_r5UgpO for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 13:36:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DA2AF85C7A
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:36:29 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C0D6B386; Mon, 18 May 2020 15:36:26 +0200 (CEST)
Date: Mon, 18 May 2020 15:36:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH -next] iommu/omap: Add check for iommu group when no
 IOMMU in use
Message-ID: <20200518133622.GA18353@8bytes.org>
References: <20200518111057.23140-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518111057.23140-1-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, tomi.valkeinen@ti.com
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

Hi Tero,

On Mon, May 18, 2020 at 02:10:57PM +0300, Tero Kristo wrote:
> Most of the devices in OMAP family of SoCs are not using IOMMU. The
> patch for converting the OMAP IOMMU to use generic IOMMU bus probe
> functionality failed to add a check for this, so add it here.
> 
> Fixes: c822b37cac48 ("iommu/omap: Remove orphan_dev tracking")
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> Hi Joerg,
> 
> This patch applies on top of linux-next, fixing an issue present there
> at the moment.
> 
> -Tero
> 
> 
>  drivers/iommu/omap-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
