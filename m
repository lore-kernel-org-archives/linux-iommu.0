Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC603C4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 02:26:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2172823718
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 02:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2172823718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B9E98713E;
	Thu, 17 Dec 2020 02:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Bqwa3e3AZH7; Thu, 17 Dec 2020 02:26:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB1978713F;
	Thu, 17 Dec 2020 02:26:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B48CFC088E;
	Thu, 17 Dec 2020 02:26:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE4CAC013B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 02:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB16F87736
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 02:26:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r8fju4Ld6wIE for <iommu@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 02:26:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id BA5DF87732
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 02:26:32 +0000 (UTC)
X-UUID: 6b57a697fc7343769c8cf30d3b0e206e-20201217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=rtpUbaZh/cAA+R5BRc6dTbvK+CjOyeTaJisNHX8GorM=; 
 b=M+7JG5RX2/VYnAMDWx472+5+2R3SDuSluClsjhpGaFaZfMt+KDqtPx/Fcdoihp99ptRyk2ve4hjPI+m1Eklg5MxjoHYrwvaTr0kDx6+NBs8Bfl9F4IzmIdOm5yPOUKN2bmRWe5D8Oz43YMUDnzYAfT/VZSMHX63zS+Ao5D5Jf8c=;
X-UUID: 6b57a697fc7343769c8cf30d3b0e206e-20201217
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1295937453; Thu, 17 Dec 2020 10:26:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 17 Dec 2020 10:26:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 10:26:06 +0800
Message-ID: <1608171967.26323.211.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
From: Yong Wu <yong.wu@mediatek.com>
To: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 17 Dec 2020 10:26:07 +0800
In-Reply-To: <6b4a1d37a90f4663adf6b4adb9f80e2b@AcuMS.aculab.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-5-yong.wu@mediatek.com>
 <6b4a1d37a90f4663adf6b4adb9f80e2b@AcuMS.aculab.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B9C6A281BF70BD4B15A9A916FF428EA37530DAF05AB6D1085009CD88534769EA2000:8
X-MTK: N
Cc: "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
 "anan.sun@mediatek.com" <anan.sun@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
 "chao.hao@mediatek.com" <chao.hao@mediatek.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 Greg Kroah-Hartman <gregkh@google.com>, Robin
 Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi David,

On Wed, 2020-12-16 at 11:03 +0000, David Laight wrote:
> From: Yong Wu
> > Sent: 16 December 2020 10:36
> > 
> > Currently gather->end is "unsigned long" which may be overflow in
> > arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
> > Although it doesn't affect the size(end - start), it affects the checking
> > "gather->end < end"
> > 
> > Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  include/linux/iommu.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 794d4085edd3..6e907a95d981 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -178,7 +178,7 @@ enum iommu_dev_features {
> >   */
> >  struct iommu_iotlb_gather {
> >  	unsigned long		start;
> > -	unsigned long		end;
> > +	unsigned long long	end;
> >  	size_t			pgsize;
> >  };
> 
> Doesn't that add two pad words on many 32bit systems?
> You probably ought to re-order the structure to keep the fields
> on their natural boundaries.
> 
> I'm not sure what is being mapped here, but could it make sense
> to just avoid using the highest addresses?
> Then you never hit the problem.

Thanks for your review. following Robin's suggesting, I will use "iova +
size - 1", then avoid this.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
