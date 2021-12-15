Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA196C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 05:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ABB7408BF;
	Wed, 15 Dec 2021 05:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V4Pwc_VTpsbi; Wed, 15 Dec 2021 05:31:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A165F40261;
	Wed, 15 Dec 2021 05:31:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ACE2C001E;
	Wed, 15 Dec 2021 05:31:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A16AC0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 05:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF68781427
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 05:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0dlUSrXlFOwQ for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 05:31:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 661AF81426
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 05:31:19 +0000 (UTC)
X-UUID: 254331c3e1e744628503f706386331d1-20211215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=i9I5Pq76XGu923LV95G8PHzGBpoVXt0t8Crp714UgVY=; 
 b=F4c+c9YhOzogtCX22SXrhBME+BYF92iL9d8hxXAmAWQZGgSgw5nsR4ZHkHS5PGNfhedQdcUSkZctNPskYE3vF07ESCWBnz9IwU3HXGVXvDBqJDXpBB3971r0dNwFRLkWYwJAn3ztbbzBm6vISasWoj8fKHUldmBi8LQapl115Ic=;
X-UUID: 254331c3e1e744628503f706386331d1-20211215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 717953459; Wed, 15 Dec 2021 13:31:14 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Dec 2021 13:31:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 15 Dec 2021 13:31:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Dec 2021 13:31:11 +0800
Message-ID: <2d66660f3507a50af618e109b7f41f411398b2ef.camel@mediatek.com>
Subject: Re: [SPAM][PATCH] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
From: Yong Wu <yong.wu@mediatek.com>
To: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 15 Dec 2021 13:31:13 +0800
In-Reply-To: <YbheCEbOS48Owcht@google.com>
References: <20211210205704.1664928-1-linux@roeck-us.net>
 <ebf58066a131f92c68e83a1ef56b88f435fa0d08.camel@mediatek.com>
 <YbheCEbOS48Owcht@google.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Dan
 Carpenter <dan.carpenter@oracle.com>, Will
 Deacon <will@kernel.org>, Guenter Roeck <linux@roeck-us.net>
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

On Tue, 2021-12-14 at 17:04 +0800, Tzung-Bi Shih wrote:
> On Tue, Dec 14, 2021 at 03:31:25PM +0800, Yong Wu wrote:
> > On Fri, 2021-12-10 at 12:57 -0800, Guenter Roeck wrote:
> > > Since commit baf94e6ebff9 ("iommu/mediatek: Add device link for
> > > smi-
> > > common
> > > and m4u"), the driver assumes that at least one phandle
> > > associated
> > > with
> > > "mediatek,larbs" exists. If that is not the case, for example if
> > > reason
> > > "mediatek,larbs" is provided as boolean property, the code will
> > > use
> > > an
> > > uninitialized pointer and may crash. To fix the problem, ensure
> > > that
> > > the
> > > number of phandles associated with "mediatek,larbs" is at least 1
> > > and
> > > bail out immediately if that is not the case.
> > 
> > From the dt-binding, "mediatek,larbs" always is a phandle-array. I 
> > assumed the dts should conform to the dt-binding before. Then the
> > problem is that if we should cover the case that someone
> > abuses/attacks
> > the dts. Could you help add more comment in the commit message?
> > something like: this is for avoid abuse the dt-binding.
> 
> How could you make sure dts conform to dt-bindings in runtime?  Code
> shouldn't rely on the assumptions but try the best to prevent any
> abuse/misconfigured/malicious cases especially if the assumptions are
> controllable by other parties.
> 
> Taking this case as an example, of_count_phandle_with_args() could
> return 3 types of values.
> 1. Negative: an error, it is already handled in the original code.
> 2. Positive: normal case, it falls down to the rest of code.
> 3. Zero: it still falls down to the rest of code, however, some
> variables won't be filled.
> 
> The code should handle all of the above types.
> 
> > > diff --git a/drivers/iommu/mtk_iommu.c
> > > b/drivers/iommu/mtk_iommu.c
> > > index 25b834104790..0bbe32d0a2a6 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -828,6 +828,8 @@ static int mtk_iommu_probe(struct
> > > platform_device
> > > *pdev)
> > >  					     "mediatek,larbs", NULL);
> > >  	if (larb_nr < 0)
> > >  		return larb_nr;
> > > +	if (larb_nr == 0)
> > > +		return -EINVAL;
> > 
> > Just assigning the larbnode to NULL may be simpler. In this case,
> > it
> > won't enter the loop below, and return 0 in the
> > of_parse_phandle(larbnode, "mediatek,smi", 0).
> > 
> > -       struct device_node      *larbnode, *smicomm_node;
> > +       struct device_node      *larbnode = NULL, *smicomm_node;
> 
> Setting larbnode to NULL doesn't make sense to me.  It wastes some
> more instructions.  If the code can exit earlier, why does it need to
> call another of_parse_phandle()?

Yes. it wastes more instrustions. But this function is only called in
the probe. it isn't called so often. Guenter has other suggestions.
Let's discuss in that thread.

Thanks very much for your comment.

> 
> Also, it adds another dependency between the code blocks.  What if
> someone move the code blocks without awareness of the dependency?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
