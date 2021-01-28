Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184DDC433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 21:10:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DBF64DD9
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 21:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DBF64DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92DA986886;
	Thu, 28 Jan 2021 21:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muYFXCLbO2Cu; Thu, 28 Jan 2021 21:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E9AB785F54;
	Thu, 28 Jan 2021 21:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE0A7C0FA7;
	Thu, 28 Jan 2021 21:10:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14607C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 21:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 07C3020378
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 21:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x3E9EK3fMwuI for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 21:10:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 05B0C1FEB7
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 21:10:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E203464DDB;
 Thu, 28 Jan 2021 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611868226;
 bh=Wa3oCHdbhNI1rC5aNsjPzPLiyWlgSVs5J8jobh+d16o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UDy8g1B6xXUCMyvUCEeP3sXc/2mWaH+aOzhkdIt9x4BNWlNenfnPapZYWW8Am2sA0
 1P2Qr5F1Ssd+GPV0IbsWoNHLqxohnEy/M6feG0Sz6CS1rlYGIKNIUeE1xtVno9B/g4
 9RAF0vPuqOR028QU/LMmX1/Vjw9AQxLEkAw1QMPyVsJza2HePfbkP6rApwZZBXlZZU
 ZWH/oMCV/7zu/gOVT5AD0j2RGsyQ5AILr6L2tyo9xIMQXyLXXXU+e6pEYRYNiq7Rqy
 GlqCM3FSWikkY89/Yil+uuctnscrmmcMqJV/IfckIyfCmg5bgG3FIyDm7NpmplejKK
 j+hxxClSbtcNA==
Date: Thu, 28 Jan 2021 21:10:20 +0000
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
Message-ID: <20210128211020.GA3531@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
 <20210126222305.GB30460@willie-the-truck>
 <1611740356.5302.14.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611740356.5302.14.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, Jan 27, 2021 at 05:39:16PM +0800, Yong Wu wrote:
> On Tue, 2021-01-26 at 22:23 +0000, Will Deacon wrote:
> > On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
> > > If group->default_domain exists, avoid reallocate it.
> > > 
> > > In some iommu drivers, there may be several devices share a group. Avoid
> > > realloc the default domain for this case.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/iommu.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 3d099a31ddca..f4b87e6abe80 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
> > >  	 * support default domains, so the return value is not yet
> > >  	 * checked.
> > >  	 */
> > > -	iommu_alloc_default_domain(group, dev);
> > > +	if (!group->default_domain)
> > > +		iommu_alloc_default_domain(group, dev);
> > 
> > I don't really get what this achieves, since iommu_alloc_default_domain()
> > looks like this:
> > 
> > static int iommu_alloc_default_domain(struct iommu_group *group,
> > 				      struct device *dev)
> > {
> > 	unsigned int type;
> > 
> > 	if (group->default_domain)
> > 		return 0;
> > 
> > 	...
> > 
> > in which case, it should be fine?
> 
> oh. sorry, I overlooked this. the current code is enough.
> I will remove this patch. and send the next version in this week.
> Thanks very much.

Actually, looking at this again, if we're dropping this patch and patch 6
just needs the kfree() moving about, then there's no need to repost. The
issue that Robin and Paul are discussing can be handled separately.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
