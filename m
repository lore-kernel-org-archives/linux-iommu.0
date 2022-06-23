Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CF3C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 01:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 508C7410BB;
	Thu, 23 Jun 2022 01:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 508C7410BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_1Ls-Zkj-yW; Thu, 23 Jun 2022 01:54:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0C78409F0;
	Thu, 23 Jun 2022 01:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0C78409F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84C67C0032;
	Thu, 23 Jun 2022 01:54:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6CEFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9361D83163
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:54:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9361D83163
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lnfi5yUf8ODH for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 01:54:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA19680B99
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA19680B99
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:54:52 +0000 (UTC)
X-UUID: 5997c256dc0d48849e0a4781ec098522-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:88c7e930-efc3-41f6-98bf-236f94738288, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:b14ad71, CLOUDID:5332cc2d-1756-4fa3-be7f-474a6e4be921,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 5997c256dc0d48849e0a4781ec098522-20220623
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1236942881; Thu, 23 Jun 2022 09:54:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 23 Jun 2022 09:54:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 23 Jun 2022 09:54:44 +0800
Message-ID: <a53c4a4d9922c9a3fc774976494dea6da1bd8daa.camel@mediatek.com>
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
To: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 23 Jun 2022 09:54:44 +0800
In-Reply-To: <521ed82e-f213-f635-6f5e-3e35ff8cc020@arm.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-3-yong.wu@mediatek.com>
 <e2091397-b6e2-7296-1378-dc10b24c6ef4@arm.com>
 <b2ea919315d0084adb465378e6970dbfa4f0829e.camel@mediatek.com>
 <521ed82e-f213-f635-6f5e-3e35ff8cc020@arm.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com, yf.wang@mediatek.com,
 Guenter Roeck <groeck@chromium.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Dan
 Carpenter <dan.carpenter@oracle.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2022-06-16 at 11:31 +0100, Robin Murphy wrote:
> On 2022-06-16 11:08, Yong Wu wrote:
> > On Thu, 2022-06-16 at 09:59 +0100, Robin Murphy wrote:
> > > On 2022-06-16 06:42, Yong Wu wrote:
> > > > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if
> > > > the
> > > > i+1
> > > > larb is parsed fail(return -EINVAL), we should of_node_put for
> > > > the
> > > > 0..i
> > > > larbs. In the fail path, one of_node_put matches with
> > > > of_parse_phandle in
> > > > it.
> > > > 
> > > > Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow
> > > > with
> > > > the MM TYPE")
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >    drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
> > > >    1 file changed, 16 insertions(+), 5 deletions(-)

[snip..]

> > > > +err_larbnode_put:
> > > > +	while (i--) {
> > > > +		larbnode = of_parse_phandle(dev->of_node,
> > > > "mediatek,larbs", i);
> > > > +		if (larbnode &&
> > > > of_device_is_available(larbnode)) {
> > > > +			of_node_put(larbnode);
> > > > +			of_node_put(larbnode);
> > > > +		}
> > > 
> > > This looks a bit awkward - could we not just iterate through
> > > data->larb_imu and put dev->of_node for each valid dev?
> > 
> > It should work. Thanks very much.
> > 
> > > 
> > > Also, of_find_device_by_node() takes a reference on the struct
> > > device
> > > itself, so strictly we should be doing put_device() on those as
> > > well
> > > if we're bailing out.
> > 
> > Thanks for this hint. A new reference for me. I will add it.
> 
> In fact, thinking about it some more we may as well do the
> of_node_put() 
> unconditionally immediately after the of_find_device_by_node() call, 

of_node_put is called in component_release_of in the normal case, thus
we shouldn't call of_node_put unconditionally. Right?

(Sorry for reply late)

> so 
> then it's *only* the device references we'd need to worry about
> cleaning 
> up in the failure path.
> 
> Robin.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
