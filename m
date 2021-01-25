Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589CC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 10:11:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702DE229C4
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 10:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702DE229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC7FD87480;
	Mon, 25 Jan 2021 10:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsFtkThqI4sm; Mon, 25 Jan 2021 10:11:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DEC3C8746D;
	Mon, 25 Jan 2021 10:11:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDB9AC0FA7;
	Mon, 25 Jan 2021 10:11:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C630C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 10:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E4874272F5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 10:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V0asl1-S7cKV for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 10:11:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by silver.osuosl.org (Postfix) with ESMTP id A6703272E0
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 10:11:11 +0000 (UTC)
X-UUID: d00b039ff7fc4da48cc5d66e8a1fd2c7-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=y2RDQNIxeBbr5oP9MQDxQ2RnX+SiaVSuN0aKLK4cDXM=; 
 b=gLX+kveBxzWW8RV3tiF5QN0UxdfmN7/caF+k+1COnfxq0yOYWrMGjOO72MProaUbXwJVfNLwYUs5ry65eGDhtMou/7BexP1I5T+/5kwWC2n2qQBCsebSvCnUZVodLaGaqLL/rGBW9EijtNy3xeDX3972NtSbOpICq0pGIue0/BY=;
X-UUID: d00b039ff7fc4da48cc5d66e8a1fd2c7-20210125
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1075218079; Mon, 25 Jan 2021 18:11:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 Jan 2021 18:11:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 18:11:00 +0800
Message-ID: <1611569460.5302.7.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 25 Jan 2021 18:11:00 +0800
In-Reply-To: <20210125084450.wurwhi2hbbuueapy@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-4-yong.wu@mediatek.com>
 <20210122213558.qnboqc4obdmipxs4@kozik-lap>
 <1611557384.3184.22.camel@mhfsdcap03>
 <20210125084450.wurwhi2hbbuueapy@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C65905790A739B480B6FC175A3CD459FDCB438FD07C4250FE662618E0D5C5FF12000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yi.kuo@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Mon, 2021-01-25 at 09:44 +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 25, 2021 at 02:49:44PM +0800, Yong Wu wrote:
> > On Fri, 2021-01-22 at 22:35 +0100, Krzysztof Kozlowski wrote:
> > > On Thu, Jan 21, 2021 at 02:24:29PM +0800, Yong Wu wrote:
> > > > This patch switches MTK_SMI to tristate. Support it could be 'm'.
> > > > 
> > > > Meanwhile, Fix a build issue while MTK_SMI is built as module.
> > > 
> > > s/Fix/fix.
> > > 
> > > What error is being fixed here? How can I reproduce it? Aren't you just
> > > adjusting it to being buildable by module?
> > 
> > Sorry, I didn't copy the fail log here. This is the build log:
> > 
> > In file included from .../drivers/iommu/mtk_iommu.c:34:0:
> > .../drivers/iommu/mtk_iommu.h:84:28: error: array type has incomplete
> > element type 'struct mtk_smi_larb_iommu'
> >   struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
> > 
> > Our iommu driver will use this structure. but it was contained by
> > "#ifdef CONFIG_MTK_SMI". thus I change it to "#if
> > IS_ENABLED(CONFIG_MTK_SMI)"
> > 
> > If reproducing it, we should change mtk-iommu to module_init[1]. and
> > switch kconfig MTK_IOMMU to tristate, then change the CONFIG_MTK_IOMMU
> > to m. we could get the fail log.
> > 
> > In this case, Should I squash this change into this patch? I though this
> > is a preparing patch and the fail is caused by MTK_SMI. thus I squash
> > that into this patch. or change it as a independent patch and send when
> > I change MTK_IOMMU to tristate?
> 
> If I understand correctly, there is no error before this patch. In such
> case just don't mention the error to fix, because it is simply part of
> making things modular.

Yes. No error before this patch.

Appreciate for your help. I will remove this in the comment message in
the next version.

> 
> Best regards,
> Krzysztof
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
