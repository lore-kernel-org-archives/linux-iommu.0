Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A810FC433EF
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 10:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4865383F64;
	Thu, 13 Jan 2022 10:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0N6gk5PWnLm; Thu, 13 Jan 2022 10:27:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06BEF83E90;
	Thu, 13 Jan 2022 10:27:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8220C002F;
	Thu, 13 Jan 2022 10:27:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93EDFC001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 10:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D2064026F
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 10:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=xs4all.nl
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5k9ny2-4axH for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 10:27:00 +0000 (UTC)
X-Greylist: delayed 00:11:06 by SQLgrey-1.8.0
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BE494023D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 10:26:59 +0000 (UTC)
X-KPN-MessageId: b2220258-7459-11ec-9a2e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b2220258-7459-11ec-9a2e-005056abbe64;
 Thu, 13 Jan 2022 11:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:from:to:subject:mime-version:date:message-id;
 bh=gDVXsjFxRvpjVOimhsqczbSYEgs92OjIY8q3HQ0xZLo=;
 b=HBr/18+Ajg3wdobbfWiqxNHvlD5i0q1fqXDA/Hd6sXbGh1VIvyCHpK08n/9w1Gb+CSo6G3/2+QYgh
 6D7DjgaCmpgmWNmn42nFiXcnqeWwFneTX2hFv5YkafeaAN8dL5/bS7kJYqwLF8oFL5LOH/DYFC2Xaw
 z5khnE9cYoIjJOWI43E5RtaLFz99+hrR107PUMVKQcoBO0na3FMPXEDUkQMcWIBcGs658HYp913aLt
 m6IiJ6/e/+N1z5xEO4Xds2vDDKkwI7t77pHPUpFWQ7yyyhuh9s9mbSvIdLJyIvhMqWnqKIHrw38aaX
 rjz44ENw3ycdGfIor0BEqqupi6EIUCw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|E3dVle7ORv8LVtMgyR7kL3/O5bzeh7Y0MMGEunRsfjRJEHWcSAEdfVoLox9zTgP
 iTmLz1DX0F5kFZJzXWyZNow==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
 by smtp.xs4all.nl (Halon) with ESMTPSA
 id c77cf44a-7459-11ec-83ab-005056ab1411;
 Thu, 13 Jan 2022 11:15:50 +0100 (CET)
Message-ID: <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
Date: Thu, 13 Jan 2022 11:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
 <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 mingyuan.ma@mediatek.com, linux-media@vger.kernel.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 libo.kang@mediatek.com, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>
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

On 13/01/2022 11:11, AngeloGioacchino Del Regno wrote:
> Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
>> Il 12/11/21 11:55, Yong Wu ha scritto:
>>> After this patchset, mtk_vcodec_release_enc_pm has only one line.
>>> then remove that function, use pm_runtime_disable instead.
>>>
>>> meanwhile, mtk_vcodec_init_enc_pm only operate for the clocks,
>>> rename it from the _pm to _clk.
>>>
>>> No functional change.
>>>
>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>> CC: Irui Wang <irui.wang@mediatek.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
> 
> Hello Yong,
> the mtk-vcodec patches were merged in Yunfei's vcodec patch series and Hans has
> scheduled that for v5.18.
> 
> Can you please send a v10 and drop patches 10/15, 11/15, 12/15 (all of the
> media: mtk-vcodec: *) from this series?
> 
> For the records, I think that after sending v10 this series is ready to be merged,
> as it was well reviewed and also tested on many MTK platforms.

Good to know. When I have the v10 I'll try to prioritize reviewing it and running
my usual tests.

Yong, please make sure you run 'checkpatch.pl --strict' over the v10 patches and fix
any issues (using common sense).

Regards,

	Hans

> 
> Thank you,
> - Angelo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
