Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE29C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:26:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89A8613AB
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89A8613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E03F4021A;
	Wed, 14 Jul 2021 08:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qZn71Wp3rH0; Wed, 14 Jul 2021 08:26:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD90240114;
	Wed, 14 Jul 2021 08:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1C15C001A;
	Wed, 14 Jul 2021 08:26:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A092C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B17C60A6C
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NeFjEHCpl7HZ for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:26:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E021D60A63
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:26:25 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623] (unknown
 [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C15441F41B8C;
 Wed, 14 Jul 2021 09:26:22 +0100 (BST)
Subject: Re: [PATCH v6 03/11] iommu/mediatek: Add device_link between the
 consumer and the larb devices
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <20210714025626.5528-4-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <f7b2c5e5-f540-b885-f063-9611031035bc@collabora.com>
Date: Wed, 14 Jul 2021 10:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714025626.5528-4-yong.wu@mediatek.com>
Content-Language: en-US
Cc: Xia Jiang <xia.jiang@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 ming-fan.chen@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 14.07.21 04:56, Yong Wu wrote:
> MediaTek IOMMU-SMI diagram is like below. all the consumer connect with
> smi-larb, then connect with smi-common.
> 
>          M4U
>           |
>      smi-common
>           |
>    -------------
>    |         |    ...
>    |         |
> larb1     larb2
>    |         |
> vdec       venc
> 
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
> 
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
> 
> This patch adds device_link between the consumer and the larbs.
> 
> When device_link_add, I add the flag DL_FLAG_STATELESS to avoid calling
> pm_runtime_xx to keep the original status of clocks. It can avoid two
> issues:
> 1) Display HW show fastlogo abnormally reported in [1]. At the beggining,
> all the clocks are enabled before entering kernel, but the clocks for
> display HW(always in larb0) will be gated after clk_enable and clk_disable
> called from device_link_add(->pm_runtime_resume) and rpm_idle. The clock
> operation happened before display driver probe. At that time, the display
> HW will be abnormal.
> 
> 2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
> pm_runtime_xx to avoid the deadlock.
> 
> Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
> device_link_removed should be added explicitly.
> 
> [1] https://lore.kernel.org/linux-mediatek/1564213888.22908.4.camel@mhfsdcap03/
> [2] https://lore.kernel.org/patchwork/patch/1086569/
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c    | 22 ++++++++++++++++++++++
>   drivers/iommu/mtk_iommu_v1.c | 20 +++++++++++++++++++-
>   2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index a02dde094788..ee742900cf4b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -571,22 +571,44 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct mtk_iommu_data *data;
> +	struct device_link *link;
> +	struct device *larbdev;
> +	unsigned int larbid;
>   
>   	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>   		return ERR_PTR(-ENODEV); /* Not a iommu client device */
>   
>   	data = dev_iommu_priv_get(dev);
>   
> +	/*
> +	 * Link the consumer device with the smi-larb device(supplier)
> +	 * The device in each a larb is a independent HW. thus only link
> +	 * one larb here.
> +	 */
> +	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> +	larbdev = data->larb_imu[larbid].dev;
> +	link = device_link_add(dev, larbdev,
> +			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +	if (!link)
> +		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
shoudn't ERR_PTR be returned in case of failure?

Thanks,
Dafna

>   	return &data->iommu;
>   }
>   
>   static void mtk_iommu_release_device(struct device *dev)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct mtk_iommu_data *data;
> +	struct device *larbdev;
> +	unsigned int larbid;
>   
>   	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>   		return;
>   
> +	data = dev_iommu_priv_get(dev);
> +	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> +	larbdev = data->larb_imu[larbid].dev;
> +	device_link_remove(dev, larbdev);
> +
>   	iommu_fwspec_free(dev);
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index d9365a3d8dc9..d2a7c66b8239 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -424,7 +424,9 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct of_phandle_args iommu_spec;
>   	struct mtk_iommu_data *data;
> -	int err, idx = 0;
> +	int err, idx = 0, larbid;
> +	struct device_link *link;
> +	struct device *larbdev;
>   
>   	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
>   					   "#iommu-cells",
> @@ -445,6 +447,14 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   
>   	data = dev_iommu_priv_get(dev);
>   
> +	/* Link the consumer device with the smi-larb device(supplier) */
> +	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
> +	larbdev = data->larb_imu[larbid].dev;
> +	link = device_link_add(dev, larbdev,
> +			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +	if (!link)
> +		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +
>   	return &data->iommu;
>   }
>   
> @@ -465,10 +475,18 @@ static void mtk_iommu_probe_finalize(struct device *dev)
>   static void mtk_iommu_release_device(struct device *dev)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct mtk_iommu_data *data;
> +	struct device *larbdev;
> +	unsigned int larbid;
>   
>   	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>   		return;
>   
> +	data = dev_iommu_priv_get(dev);
> +	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
> +	larbdev = data->larb_imu[larbid].dev;
> +	device_link_remove(dev, larbdev);
> +
>   	iommu_fwspec_free(dev);
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
