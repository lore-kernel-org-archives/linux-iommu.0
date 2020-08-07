Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EA6C433E1
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 02:14:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3934F2177B
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 02:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c5FOfhM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3934F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF918886E1;
	Fri,  7 Aug 2020 02:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZaM9SGY-J6t; Fri,  7 Aug 2020 02:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A023886D1;
	Fri,  7 Aug 2020 02:14:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 057D3C0051;
	Fri,  7 Aug 2020 02:14:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0CAC004C
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 02:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7EFF32538B
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 02:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfYZjI+P-Sbb for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 02:14:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by silver.osuosl.org (Postfix) with ESMTP id 8E92B25281
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 02:14:50 +0000 (UTC)
X-UUID: ae261989d0a84694b73d2c8c8dba076f-20200807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=JxLw+a2yeVjmglZikNxU8lr4nwwrSEYeYUL+KumKsqM=; 
 b=c5FOfhM3iSiu7+xP15b3XDvMWwrLlwtsPmxaHuWGhHoYIBNpLdWiYZJGvrfdK7jufM6otqkjqxA5FBbkLi+uAgsDYoMhfIPLdZwQwGc4nR78riPRRhBuVnYDK3Bbv/cI9bV7NAMueuIRJJUtPLzD1LV5vHtvpwLSZMPWlKchP70=;
X-UUID: ae261989d0a84694b73d2c8c8dba076f-20200807
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 2043936039; Fri, 07 Aug 2020 10:14:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 7 Aug 2020 10:14:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Aug 2020 10:14:41 +0800
Message-ID: <1596766438.18559.4.camel@mhfsdcap03>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
From: Yong Wu <yong.wu@mediatek.com>
To: chao hao <Chao.Hao@mediatek.com>
Date: Fri, 7 Aug 2020 10:13:58 +0800
In-Reply-To: <1595839778.2350.4.camel@mbjsdccf07>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-12-yong.wu@mediatek.com>
 <1595839778.2350.4.camel@mbjsdccf07>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1FA9D0F3014E9C59CFEAA84127CB84AF86104ADCF9CE47405B4B97E5C86E5DE82000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, chao hao <"Chao. Hao"@mediatek.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, 2020-07-27 at 16:49 +0800, chao hao wrote:
> On Sat, 2020-07-11 at 14:48 +0800, Yong Wu wrote:
> > In the previous SoC, the M4U HW is in the EMI power domain which is
> > always on. the latest M4U is in the display power domain which may be
> > turned on/off, thus we have to add pm_runtime interface for it.
> > 
> > we should enable its power before M4U hw initial. and disable it after HW
> > initialize.
> > 
> > When the engine work, the engine always enable the power and clocks for
> > smi-larb/smi-common, then the M4U's power will always be powered on
> > automatically via the device link with smi-common.
> > 
> > Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> > If its power already is on, of course it is ok. if the power is off,
> > the main tlb will be reset while M4U power on, thus the tlb flush while
> > m4u power off is unnecessary, just skip it.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>

...

> >  
> >  	if (data->plat_data->m4u_plat == M4U_MT8173) {
> > @@ -728,7 +756,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, data);
> >  
> > +	if (dev->pm_domain)
> > +		pm_runtime_enable(dev);
> 
> hi yong,
> 
> If you put "pm_runtime_enable" here, it maybe not device_link with
> smi_common for previous patch: 
> if(i || !pm_runtime_enabled(dev))
>     continue;
> 
> Whether put it up front?

Thanks for review. My fault here. I will fix it.

> 
> best regards,
> chao

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
