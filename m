Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC9C388F9
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 02:42:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91413207F7
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 02:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oA+Dbf0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91413207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0A1822037A;
	Thu, 12 Nov 2020 02:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x0YHBOd8mh8e; Thu, 12 Nov 2020 02:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2EE82200ED;
	Thu, 12 Nov 2020 02:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12FADC0889;
	Thu, 12 Nov 2020 02:41:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 522A4C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 39B4C86AF2
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iGm0yR2H3Pb3 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 02:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by whitealder.osuosl.org (Postfix) with ESMTP id B4C5084442
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:41:54 +0000 (UTC)
X-UUID: 3e322c4d6c014b81adca0a5a36afc2e5-20201112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Se+dg4+AYHxaxLtO87h0o7d56UKD1EUz3XmAcnOw+/s=; 
 b=oA+Dbf0qPb92/DZF3kFkxWYazzkKvsKg0/1OM5wOp9sggU1MDJbxATKYd0bHSif+NtHFeCDweuX4Xx505Zv1xeRj7V3hvcXe+mEqufaYZVEcfJvez7qhPfj56D9i4g12WU8yAbEq+Bpmpt1UfPVhRSSMTHDBrBUr75eoDoGa2HM=;
X-UUID: 3e322c4d6c014b81adca0a5a36afc2e5-20201112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1635741934; Thu, 12 Nov 2020 10:41:44 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 12 Nov 2020 10:41:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 10:41:42 +0800
Message-ID: <1605148902.26323.126.camel@mhfsdcap03>
Subject: Re: [PATCH v4 05/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 12 Nov 2020 10:41:42 +0800
In-Reply-To: <20201111213338.GD287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-6-yong.wu@mediatek.com>
 <20201111213338.GD287176@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1C18FA5020027ADAA5CD122CFFAF794DF7B24B6C49C7403F677C225959A3CB292000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@google.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, anan.sun@mediatek.com,
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

Hi Krzysztof,

On Wed, 2020-11-11 at 22:33 +0100, Krzysztof Kozlowski wrote:
> On Wed, Nov 11, 2020 at 08:38:19PM +0800, Yong Wu wrote:
> > This patch adds decriptions for mt8192 IOMMU and SMI.
> > 
> > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > table format. The M4U-SMI HW diagram is as below:
> > 
> >                           EMI
> >                            |
> >                           M4U
> >                            |
> >                       ------------
> >                        SMI Common
> >                       ------------
> >                            |
> >   +-------+------+------+----------------------+-------+
> >   |       |      |      |       ......         |       |
> >   |       |      |      |                      |       |
> > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > disp0   disp1   mdp    vdec                   IPE      IPE
> > 
> > All the connections are HW fixed, SW can NOT adjust it.
> > 
> > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > into different iova ranges:
> > 
> > domain-id  module     iova-range                  larbs
> >    0       disp        0 ~ 4G                      larb0/1
> >    1       vcodec      4G ~ 8G                     larb4/5/7
> >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > 
> > The iova range for CCU0/1(camera control unit) is HW requirement.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---

[...]

> > +#ifndef _DTS_IOMMU_PORT_MT8192_H_
> > +#define _DTS_IOMMU_PORT_MT8192_H_
> 
> Not accurate header guard. Shoud be:
> _DT_BINDINGS_MEMORY_MT8192_LARB_PORT_H_
> 
> Probably you copied it from some other Mediatek headers - all of them
> have header guard pointing to different directory.

Thanks very much for your reviewing so many patches.

This name like this when it was in the first version. Since it is only
used when the consumer devices enable IOMMU, thus called it
_IOMMU_PORT...

I will use a new patch to rename all of them.

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
