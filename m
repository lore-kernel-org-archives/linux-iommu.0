Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF48184
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 12:35:52 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 9685E6601A3B;
	Thu, 14 Jul 2022 13:35:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1657802144;
	bh=3tgtT8VanBEk9yfmpT18dxURM1+JmT9sPRThb3SqdXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vf5U0hWiMxt5Q3ex4YjkiE6+PBMaxDbDk39QDy2/0vcfRL4GItQlRJvDmnmy4C2/9
	 vgG7C0audHui/O0rF1kvHAMQKhq8/yZ7U6qo2aXejNLx+W4sNYlDY8uMl8xkB0jPzB
	 hL94+CfuXQQqqxQJGwkf0kyE297wqAyxao8kKEU5mO9JkYSBTH/Khppt/NV2DybmIz
	 hraUdGHLyueOoNEKQc6d5IsrZK4ywKSNN5vdVYAJn2Cf6A6zZvKu7PbbX1py7lTSRC
	 +FFx+ga5ctvdrPkJotwo8tFGmEBnCh/voC2uDA2C0pzZVt0BReL2jy1d0zX0uta4SM
	 4P+S9kvN9uAQg==
Message-ID: <eefcb818-484b-9964-4a64-dbfb98edd446@collabora.com>
Date: Thu, 14 Jul 2022 14:35:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 15/19] arm64: dts: mt8195: Add adsp node and adsp
 mailbox nodes
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 YC Hung <yc.hung@mediatek.corp-partner.google.com>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-16-tinghan.shen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220714122837.20094-16-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/07/22 14:28, Tinghan Shen ha scritto:
> From: YC Hung <yc.hung@mediatek.corp-partner.google.com>
> 
> Add adsp node and adsp mailbox nodes for mt8195.
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.corp-partner.google.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 37 ++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 818f7dea27c6..9cb68417c550 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -739,6 +739,43 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		adsp: adsp@10803000 {

adsp: dsp@10803000

(without the 'a', just dsp@....)

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

