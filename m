Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CF0C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 01:53:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E46464DF1
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 01:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E46464DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C3E67204BC;
	Fri, 29 Jan 2021 01:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9BDFSeDSesx; Fri, 29 Jan 2021 01:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E2B3E2041E;
	Fri, 29 Jan 2021 01:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA301C0FA7;
	Fri, 29 Jan 2021 01:53:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A65CC013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 01:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4A3D220487
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 01:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cfkvpzJT+nmW for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 01:53:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by silver.osuosl.org (Postfix) with ESMTP id 3DB782041E
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 01:53:14 +0000 (UTC)
X-UUID: dc9c42d6294a48ee8dd193beffc176c0-20210129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=fdRmt55p+MQD3S1Cu81aNjjrFDffurU5HWdEwTLBEdQ=; 
 b=jvqRAwKx77mrVFAY9ifsdXuA3WEDaJy1giDwPh7i+foA2l69CMIuGplOP2nFEp2MMB+sHWv6dIo37lLmI7CfsflINWNm/SWr7TYK3ldCTKwsjuBjiCfFbmlndv8TkTGBVyWoRpmHZA156TMFaQobkyhbbLIw8Dtoa979/h0m8Og=;
X-UUID: dc9c42d6294a48ee8dd193beffc176c0-20210129
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1814884913; Fri, 29 Jan 2021 09:52:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 29 Jan 2021 09:52:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 09:52:41 +0800
Message-ID: <1611885162.5302.19.camel@mhfsdcap03>
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Fri, 29 Jan 2021 09:52:42 +0800
In-Reply-To: <20210128211442.GB3531@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
 <20210126222305.GB30460@willie-the-truck>
 <1611740356.5302.14.camel@mhfsdcap03>
 <20210128211020.GA3531@willie-the-truck>
 <20210128211442.GB3531@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C7FA721F47A35587783A8CC9CE434783D2147DE2CF3728D62F7C900CF55A2C7A2000:8
X-MTK: N
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

On Thu, 2021-01-28 at 21:14 +0000, Will Deacon wrote:
> On Thu, Jan 28, 2021 at 09:10:20PM +0000, Will Deacon wrote:
> > On Wed, Jan 27, 2021 at 05:39:16PM +0800, Yong Wu wrote:
> > > On Tue, 2021-01-26 at 22:23 +0000, Will Deacon wrote:
> > > > On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
> > > > > If group->default_domain exists, avoid reallocate it.
> > > > > 
> > > > > In some iommu drivers, there may be several devices share a group. Avoid
> > > > > realloc the default domain for this case.
> > > > > 
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > ---
> > > > >  drivers/iommu/iommu.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > > index 3d099a31ddca..f4b87e6abe80 100644
> > > > > --- a/drivers/iommu/iommu.c
> > > > > +++ b/drivers/iommu/iommu.c
> > > > > @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
> > > > >  	 * support default domains, so the return value is not yet
> > > > >  	 * checked.
> > > > >  	 */
> > > > > -	iommu_alloc_default_domain(group, dev);
> > > > > +	if (!group->default_domain)
> > > > > +		iommu_alloc_default_domain(group, dev);
> > > > 
> > > > I don't really get what this achieves, since iommu_alloc_default_domain()
> > > > looks like this:
> > > > 
> > > > static int iommu_alloc_default_domain(struct iommu_group *group,
> > > > 				      struct device *dev)
> > > > {
> > > > 	unsigned int type;
> > > > 
> > > > 	if (group->default_domain)
> > > > 		return 0;
> > > > 
> > > > 	...
> > > > 
> > > > in which case, it should be fine?
> > > 
> > > oh. sorry, I overlooked this. the current code is enough.
> > > I will remove this patch. and send the next version in this week.
> > > Thanks very much.
> > 
> > Actually, looking at this again, if we're dropping this patch and patch 6
> > just needs the kfree() moving about, then there's no need to repost. The
> > issue that Robin and Paul are discussing can be handled separately.
> 
> Argh, except that this version of the patches doesn't apply :)
> 
> So after all that, please go ahead and post a v7 ASAP based on this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/mtk

After confirm with Tomasz, He still need some time to take a look at v6.

thus I need wait some time to send v7 after his feedback.

Thanks for your comment. and Thanks Tomasz for the review.

> 
> Will

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
