Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8835AC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 10:28:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EB320791
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 10:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IN3m1r89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EB320791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 088D685633;
	Fri,  4 Sep 2020 10:28:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6S0THYgMflPm; Fri,  4 Sep 2020 10:28:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3EBE985549;
	Fri,  4 Sep 2020 10:28:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 270D7C07FF;
	Fri,  4 Sep 2020 10:28:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A33C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BD662874DB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wE6y5Tg7VjAF for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 10:28:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by hemlock.osuosl.org (Postfix) with ESMTP id 156D48748A
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:28:50 +0000 (UTC)
X-UUID: 07771bdf2c1c4ee1ab180633629baa0e-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=W6qNdgT4XBpxvM+qKDnHlTrV/BrFHcflzIbO8Gjk/jY=; 
 b=IN3m1r89KoswFu3G3q/WjUwnve/HdkYvnt5t2G/75yVvGKnofYrpPUnyXkRaUTzN5ImRXXV9D6MlKN/DeygL95MarB5Awr6OZ9PXCVy0QYOdwTf4B8aHDzb59k7o+7QncEepnOw6xVuReZ1ttVelAKamGzp++oZhReYg/u+kYcY=;
X-UUID: 07771bdf2c1c4ee1ab180633629baa0e-20200904
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1434882807; Fri, 04 Sep 2020 18:28:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 18:28:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 18:28:42 +0800
Message-ID: <1599215324.29997.1.camel@mtkswgap22>
Subject: Re: [PATCH v5] iommu/mediatek: check 4GB mode by reading infracfg
From: Miles Chen <miles.chen@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Fri, 4 Sep 2020 18:28:44 +0800
In-Reply-To: <20200904094233.GP6714@8bytes.org>
References: <20200831105639.2856-1-miles.chen@mediatek.com>
 <20200904094233.GP6714@8bytes.org>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8CBC2E51C5EDEC8111200CFC22B3DC832000455B5036BDE4B17C4427343DBDC82000:8
X-MTK: N
Cc: Rob Herring <robh@kernel.org>, wsd_upstream@mediatek.com,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Christoph Hellwig <hch@lst.de>,
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

On Fri, 2020-09-04 at 11:42 +0200, Joerg Roedel wrote:
> On Mon, Aug 31, 2020 at 06:56:39PM +0800, Miles Chen wrote:
> > In previous discussion [1] and [2], we found that it is risky to
> > use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> > 
> > Check 4GB mode by reading infracfg register, remove the usage
> > of the un-exported symbol max_pfn.
> > 
> > This is a step towards building mtk_iommu as a kernel module.
> > 
> > [1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
> > [2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
> > [3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/
> > 
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> You forgot to add the tags here from v4, at least Matthias' Reviewed-by
> is missing. Please add the missing tags and resend.

Thanks for reminding. I'll add the tag and resend this patch ASAP.

Miles
> 
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
