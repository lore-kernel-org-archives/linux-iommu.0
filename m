Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A8FC433F5
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 13:41:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C1260F70
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 13:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15C1260F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE43560860;
	Thu, 11 Nov 2021 13:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1Faj4gaB_Xt; Thu, 11 Nov 2021 13:41:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC5CA6086F;
	Thu, 11 Nov 2021 13:41:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7C9BC0020;
	Thu, 11 Nov 2021 13:41:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4B2CC001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 13:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EED3817C3
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 13:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pzbDSP4TBQdy for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 13:41:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1E5E80F48
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 13:41:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 21BC01F45C4A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1636638099; bh=CHJDHhiAjdq3L1NauwCONE1XBN60xw/moDpKBFO9Dxw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=L9UMZXx8zbtGS9X/Im0l2+D9XOOvuHBhzVk09tPpvbMkqdxtPy9WYwmxG7BuJ8REw
 b2MrW2a/IZ8B46fb5VSAlCQfyJ39MI5brGxWrc+CWU2vQzKjX2DHab5QOUL+tjeCVv
 lc51RaT7Bz79Q2eRgbaf80NkVtf4mZTbjs29lvfMWJuwVEmYz4iFkwFQSlHGhp76mk
 UWckffRvR1upBhOlt//dMvm1QV9ljDZke7uiDJCzKwTI/8fVe43xn0FV3OZKAkN7qn
 2vfVnIhcB0k/pyl+mOUGE4nlDleWUGpzNy80RBZBTBqt3qzo/HZF8i46SIjskD6Oto
 6YSkobhbxS+Xw==
Subject: Re: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20211108082429.15080-1-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <1d72bac8-eb79-6f34-79ca-4c5c38d6d2bf@collabora.com>
Date: Thu, 11 Nov 2021 14:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108082429.15080-1-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anthony.huang@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 08/11/21 09:24, Yong Wu ha scritto:
> We add the ostd setting for mt8195. It introduces a KE for the
> previous SoC which doesn't have ostd setting. This is the log:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>   mtk_smi_larb_config_port_gen2_general+0x64/0x130
>   pm_generic_runtime_resume+0x2c/0x48
>   __genpd_runtime_resume+0x30/0xa8
>   genpd_runtime_resume+0x94/0x2c8
>   __rpm_callback+0x44/0x150
>   rpm_callback+0x6c/0x78
>   rpm_resume+0x310/0x558
>   __pm_runtime_resume+0x3c/0x88
> 
> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset(e.g.
> 0x80 above), it's also a valid value, then accessing "larbostd[i]" in the
> "for" loop will cause the KE above. To avoid this issue, initialize
> "larbostd" to NULL when the SoC doesn't have ostd setting.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> change note: Reword the commit message to show why it KE. and update the
> solution via initializing "larbostd" is NULL explicitly in the non-ostd
> case.
> ---
>   drivers/memory/mtk-smi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

This commit needs a Fixes tag. Please add the proper one.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
