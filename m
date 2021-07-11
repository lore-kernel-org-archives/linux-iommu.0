Return-Path: <SRS0=Ihqs=MD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FF1C07E96
	for <iommu@archiver.kernel.org>; Sun, 11 Jul 2021 08:25:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8A161249
	for <iommu@archiver.kernel.org>; Sun, 11 Jul 2021 08:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8A161249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BA8E83ADB;
	Sun, 11 Jul 2021 08:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YI3yKe-ZtYRA; Sun, 11 Jul 2021 08:25:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC29F83AD3;
	Sun, 11 Jul 2021 08:25:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 946CBC001A;
	Sun, 11 Jul 2021 08:25:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7991C000E
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 08:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B652883A81
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 08:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8gS8H8XHPMeF for <iommu@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 08:25:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC58D83AD6
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 08:25:01 +0000 (UTC)
X-UUID: 66a7c42800e84741b6958cdd7e6f108b-20210711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=iEJdw0JyYUyniYoye3JWNvieJPx3fB4KYOOg4DQ+F4M=; 
 b=lOk4xUSh/as6K/L/wz/k/CSbenuIjRq5JLfC0Mx62sMvirx+QqunyMcqx1bQTOwUx5buHTFd3GZIBT0JO9oDjDKvm94B8m+Pwm1ggYXUMNn9GNqbnGr/Az4eBL54PnCRqUUr4UUFtvVKOCoqkvMmcSi1FvU+uTxuyZye1NCxFTk=;
X-UUID: 66a7c42800e84741b6958cdd7e6f108b-20210711
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 265461227; Sun, 11 Jul 2021 16:24:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 11 Jul 2021 16:24:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Jul 2021 16:24:52 +0800
Message-ID: <1625991892.22309.10.camel@mhfsdcap03>
Subject: Re: [PATCH 4/9] memory: mtk-smi: Rename smi_gen to smi_type
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Sun, 11 Jul 2021 16:24:52 +0800
In-Reply-To: <a3abe400-4172-4f62-1548-b78b9ec4c157@canonical.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-5-yong.wu@mediatek.com>
 <a3abe400-4172-4f62-1548-b78b9ec4c157@canonical.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B01E0EC6D5C0AC2DAEDDFBE2800052CB3386659EA74D944E43EC036F416268192000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
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

On Thu, 2021-07-08 at 11:34 +0200, Krzysztof Kozlowski wrote:
> On 16/06/2021 13:43, Yong Wu wrote:
> > This is a preparing patch for adding smi sub common.
> 
> Don't write "This patch". Use simple imperative:
> "Prepare for adding smi sub common."
> 
> https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L89

Thanks very much. I didn't notice this before.

>  
> > About the previou smi_gen, we have gen1/gen2 that stand for the generation
> > number for HW. I plan to add a new type(sub_common), then the "gen" is not
> > prober. this patch only change it to "type", No functional change.
> 
> Same.
> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
