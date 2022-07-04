Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC5C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 10:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F226081B70;
	Mon,  4 Jul 2022 10:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F226081B70
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Rtt8qO/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXV4jTo6gJ4g; Mon,  4 Jul 2022 10:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1D0781AA7;
	Mon,  4 Jul 2022 10:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1D0781AA7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9031AC0032;
	Mon,  4 Jul 2022 10:33:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8326C002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 754CC81A81
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 754CC81A81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4OuzG6uqBfG for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 10:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B645581A5F
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B645581A5F
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:33:29 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D6E1660198A;
 Mon,  4 Jul 2022 11:33:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1656930807;
 bh=I6gNnNJ8NBeXTrc04WgTIwAxpwHfOlZ6YbGYUe7r+Cs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Rtt8qO/doUejrNnhHwGmINTEgS/5BBt2XaRGCqfDMLekT3eRdV1gDdqRKcSU9Uywu
 BWDd1dlY/ptPHAPKhgj04EhO5HveCi5wDKKzYZh3zNJR2W8/xglREy/tLUjEpNH21G
 K8zfRG9P/edWVraOOoU1UWRDGPX/qBRa57zgv7Dhdrd7mSlMCa+HVIPvP5wFX7twYD
 GNpzF6s6ZlzlG9sEm5a9mTIRJoh+tZGoL2VjUo35ylUgzTrCliw1FVbAMkx8IOSn4E
 HKALylVGamheS79f+zaHA+ISuP4UIjQoORPnGhcfInHHH9t1atweIP/1qDQSYCJ2pO
 8bTI6xjPZZ9nA==
Message-ID: <6a2e41ad-1722-1d93-33ff-4aec370856c4@collabora.com>
Date: Mon, 4 Jul 2022 12:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 05/16] arm64: dts: mt8195: Disable I2C0 node
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-6-tinghan.shen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-6-tinghan.shen@mediatek.com>
Cc: devicetree@vger.kernel.org, Tzung-Bi Shih <tzungbi@chromium.org>,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

Il 04/07/22 12:00, Tinghan Shen ha scritto:
> From: Tzung-Bi Shih <tzungbi@chromium.org>
> 
> The I2C0 node doesn't need to be enabled in dtsi.
> 

"The I2C0 node should not be enabled globally, as usage is board dependant:
disable it in dtsi."

after which...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 436687ba826f..8032b839dfe8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -829,7 +829,7 @@
>   			clock-names = "main", "dma";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			status = "okay";
> +			status = "disabled";
>   		};
>   
>   		i2c1: i2c@11e01000 {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
