Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597C9C433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Apr 2022 02:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1125582B21;
	Wed, 27 Apr 2022 02:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uyvLU8lAulMJ; Wed, 27 Apr 2022 02:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA43581A6A;
	Wed, 27 Apr 2022 02:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1920C0032;
	Wed, 27 Apr 2022 02:13:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA72CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 02:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A2A083192
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 02:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvHyU6yMLnE3 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 02:13:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DF7782B21
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 02:13:29 +0000 (UTC)
X-UUID: 2282832e28514f0a9b6b8bc582bcfb2e-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:5fad9234-5f94-4589-b8fb-d942025f39e9, OB:0,
 LO
 B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:25
X-CID-META: VersionHash:faefae9, CLOUDID:dd2c99c6-85ee-4ac1-ac05-bd3f1e72e732,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 2282832e28514f0a9b6b8bc582bcfb2e-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1230499426; Wed, 27 Apr 2022 10:13:24 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 10:13:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 27 Apr 2022 10:13:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 27 Apr 2022 10:13:21 +0800
To: <yong.wu@mediatek.com>
Subject: Re: [PATCH v2] iommu/mediatek: fix NULL pointer dereference when
 printing dev_name
Date: Wed, 27 Apr 2022 10:13:21 +0800
Message-ID: <20220427021321.22899-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <4ff4246cd5d567a3fa8124800f5d75be0034621c.camel@mediatek.com>
References: <4ff4246cd5d567a3fa8124800f5d75be0034621c.camel@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: miles.chen@mediatek.com, jroedel@suse.de, will@kernel.org,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 hverkuil-cisco@xs4all.nl, mchehab@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Yong,

>On Mon, 2022-04-25 at 11:03 +0100, Robin Murphy wrote:
>> On 2022-04-25 09:24, Miles Chen via iommu wrote:
>> > When larbdev is NULL (in the case I hit, the node is incorrectly
>> > set
>> > iommus = <&iommu NUM>), it will cause device_link_add() fail and
>> 
>> Until the MT8195 infra MMU support lands, is there ever a case where 
>> it's actually valid for larbdev to be NULL? If not, I think it would
>> be 
>> a lot clearer to explicitly fail the probe here, rather than
>> silently 
>> continue and risk fatal errors, hangs, or other weird behaviour if 
>> there's no guarantee that the correct LARB is powered up (plus then
>> the 
>> release callbacks wouldn't need to worry about it either).
>
>Yes. It should return fail for this case. This issue only happens when
>the dts parameters doesn't respect the definition from the binding[1].
>
>Locally Miles tested with a internal definition that have not send
>upstream to get this KE. In this case, I'm not sure if we should
>request the user use the right ID in dts. Anyway I have no objection to
>modifying this, then something like this: (Avoid invalid input from
>dtb)
>
>@@ -790,6 +790,8 @@ static struct iommu_device
>*mtk_iommu_probe_device(struct device *dev)
> 	 * All the ports in each a device should be in the same larbs.
> 	 */
> 	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>+	if (larbid >= MTK_LARB_NR_MAX)
>+		return ERR_PTR(-EINVAL);
> 	for (i = 1; i < fwspec->num_ids; i++) {
> 		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
> 		if (larbid != larbidx) {
>@@ -799,6 +801,8 @@ static struct iommu_device
>*mtk_iommu_probe_device(struct device *dev)
> 		}
> 	}
> 	larbdev = data->larb_imu[larbid].dev;
>+	if (!larbdev)
>+		return ERR_PTR(-EINVAL);
> 	link = device_link_add(dev, larbdev,
> 			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> 	if (!link)

Thanks for guilding me, I will put this in patch v2.

Thanks,
Miles

>
>
>[1] 
>https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml#L116

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
