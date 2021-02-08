Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E8C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:13:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABCF64E7E
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABCF64E7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2301858D4;
	Mon,  8 Feb 2021 08:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kd1vVikJGE7w; Mon,  8 Feb 2021 08:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E482C858C9;
	Mon,  8 Feb 2021 08:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB7E3C0174;
	Mon,  8 Feb 2021 08:13:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC476C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B796686FFD
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLzZ73eTgb1P for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 08:13:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3712786ECC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:13:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 596013A7; Mon,  8 Feb 2021 09:13:03 +0100 (CET)
Date: Mon, 8 Feb 2021 09:13:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH] MAINTAINERS: repair file pattern in MEDIATEK IOMMU DRIVER
Message-ID: <20210208081301.GB7302@8bytes.org>
References: <20210208061025.29198-1-lukas.bulwahn@gmail.com>
 <1612766125.19482.3.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1612766125.19482.3.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Joe Perches <joe@perches.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
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

On Mon, Feb 08, 2021 at 02:35:25PM +0800, Yong Wu wrote:
> On Mon, 2021-02-08 at 07:10 +0100, Lukas Bulwahn wrote:
> > Commit 6af4873852c4 ("MAINTAINERS: Add entry for MediaTek IOMMU") mentions
> > the pattern 'drivers/iommu/mtk-iommu*', but the files are actually named
> > with an underscore, not with a hyphen.
> > 
> > Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> > 
> >   warning: no file matches  F:    drivers/iommu/mtk-iommu*
> > 
> > Repair this minor typo in the file pattern.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on next-20210205
> > 
> > Yong, please ack.
> 
> +Joerg.
> 
> sorry for the typo.
> 
> Acked-by: Yong Wu <yong.wu@mediatek.com>

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
