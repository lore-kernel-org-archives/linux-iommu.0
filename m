Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20402C433F5
	for <iommu@archiver.kernel.org>; Tue, 11 Jan 2022 09:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C12A760E03;
	Tue, 11 Jan 2022 09:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WvwT4UTpymHh; Tue, 11 Jan 2022 09:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C06560D72;
	Tue, 11 Jan 2022 09:14:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F207C0030;
	Tue, 11 Jan 2022 09:14:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D979C001E
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 09:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 353F9410BD
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 09:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bUFSFMmukvSp for <iommu@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:14:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 180ED410A5
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 09:14:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 406F31F41CF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641892467;
 bh=OpxYFNpUHYIuTIBv0HTc/nmFe9b8Qv/VGZti7c3+o2U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=E36tFSyAwJ9yqEtW4Zcvc4HVc5FLPeXnQLYaUHLeifo11gu0nrFYC+KLoL1I5wQUc
 S0gtJ6Wg+HcWrdQXzuQDhl2NIWOZrk5opIpPRITsMDsDkSi/XOTvWCzr0mJ1JwfN49
 +X1aS8HgGRjr3ngm3mHvdVKIcGjWxBz13wCTl5Eqwqm43o7GXVdyQXuf48BK3xr5Nk
 otD8S5HJwXMMl+A2AUoM/aWxIJb+fSeAy3rcEa9DkbfP5YempRDLYjmk4Mla6C1e5D
 dbCv8ynX5pr2F12D3mVTfuXItQeE/PxnxUUcjyl582bHDOM2MdwgXYK7pwCW1yRASV
 JiDoBJx+kpv3w==
Subject: Re: [PATCH v2 5/6] memory: mtk-smi: Add sleep ctrl function
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-6-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <e3815197-8963-99a6-e83d-b801de1725f3@collabora.com>
Date: Tue, 11 Jan 2022 10:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111063904.7583-6-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 11/01/22 07:39, Yong Wu ha scritto:
> Sleep control means that when the larb goes to sleep, we should wait a bit
> until all the current commands are finished. Thus, when the larb runtime
> suspends, we need to enable this function to wait until all the existed
> commands are finished. When the larb resumes, just disable this function.
> This function only improves the safety of bus. Add a new flag for this
> function. Prepare for mt8186.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
