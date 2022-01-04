Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA98BC433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A75F826C1;
	Tue,  4 Jan 2022 15:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nViCCIlRvFHL; Tue,  4 Jan 2022 15:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 65EE282640;
	Tue,  4 Jan 2022 15:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50669C002F;
	Tue,  4 Jan 2022 15:54:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E06CC001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C60860C01
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYFopCeeMCPY for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6B1560BF9
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:54:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 5FF1A1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311664;
 bh=z8b4JgrEINeDdHaIUQNnWliGF0ifNcQlBrAvNR4lIjA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RIApkZCMkaFcib0aBu9CH9SoagjUf5BxhxJF4rMLq9d8min2nzflzYPa4uPoCn6Bz
 xQtr2frS8nyypu+J5vauINYYcwtNZA3CJ9SzP7gmHS2YTTWR9qyRTyBnl+LojUmG1S
 t6K7SXfjZ1LwtD6QCJPb41VsanF6DZrzmQJB1eIPniiBMHkdLzykaThTLtCd3O6IEY
 WYh2OaowGW6mYrkQmK3qzAfWT6XtHQiHOUrC71BUx4eVdPDo4DMknqv8L5gw31fQgY
 NY9U4jmNYy8qxqW6x1j1/hV25zioi207s+3xItCCFFBRKzBvXByWQnPmp6tDVtskmg
 g0iPgonHSmZuQ==
Subject: Re: [PATCH v3 27/33] iommu/mediatek: Initialise bank HW for each a
 bank
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-28-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <af588804-041c-b382-e5e4-4dfd0506b439@collabora.com>
Date: Tue, 4 Jan 2022 16:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-28-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Il 23/09/21 13:58, Yong Wu ha scritto:
> The mt8195 IOMMU HW max support 5 banks, and regarding the banks'
> registers, it looks like:
> 
>   ----------------------------------------
>   |bank0  | bank1 | bank2 | bank3 | bank4|
>   ----------------------------------------
>   |global |
>   |control|         null
>   |regs   |
>   -----------------------------------------
>   |bank   |bank   |bank   |bank   |bank   |
>   |regs   |regs   |regs   |regs   |regs   |
>   |       |       |       |       |       |
>   -----------------------------------------
> 
> Each bank has some special bank registers and it share bank0's global
> control registers. this patch initialise the bank hw with the bankid.
> 
> In the hw_init, we always initialise bank0's control register since
> we don't know if the bank0 is initialised.
> 
> Additionally, About each bank's register base, always delta 0x1000.
> like bank[x + 1] = bank[x] + 0x1000.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
