Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23684185E
	for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 11:34:10 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id h9so1883415wrt.0
        for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dngPew9tfIsXqis9aTN0QEZkVjpf3qlZJxq/uUcFp5I=;
        b=aywOQVWHakfRF+EVLr/DXeg6DSIYTOV5WLZWZVJnFACVHAgqhjBNvfx71PxFj7lBpP
         nZw9U1PrY02zEP7x+fXGLHL2npkWvKUlHYsae5698cCJKZzzKEHBcBswduDBCOlsKQpg
         EKmDSFrWcCNfiw3++1Rz729iuntBQ3sAeB4JVP3JDWoZJkJt/Fd6SW2Y+YFaQZVR7vvT
         v/v09IA+QcA6ksQl91mZuU3tOFTuy43OVH+E6ULL7+hsCad+FhJXS9gXcEIZtcSHK22S
         AmNtdUFunoFiHV7xQC0aXvNrTD+8cJgfMjz+8f4dmXRtjYKgk7LDL1PIqGZV/tZRzTWF
         Rrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dngPew9tfIsXqis9aTN0QEZkVjpf3qlZJxq/uUcFp5I=;
        b=N1dqgROcy268K4rKHjpDNyvhnB67Mi9wiH10q1HNuNw7ok8WiBLqeawZ5rKa1xuqIo
         Ms7Qx4pLseb9tBPbVok2IqZhf7BTKSCbc69uMXRlFQkXo5+AEHWHR21JqyDPqdmYyUkZ
         lfrOYHbtAfy6HUzUeCRmsPRv421ttE+nlzisTQdTWTXpD7tM9+scDILQs6qD9jPQjlDU
         dzm9fyACNGBY/omS6z5FoSZPVv19mz5hCSPhzJ99jQM6aDOg4KWLG9EuvS1pxshJHzD3
         Fahcvp2mNaewKAcUk3oVaIp7IZLdr6MyIQES9cxHNPzO50TTq0u05w6HUC65wyFikF+Z
         nVYA==
X-Gm-Message-State: ACrzQf2+vPeIACGC3ejx0YL6QSXvRGIOFg4ksWdTkSabAAyNnphMDC9h
	cXOmouxMEVxCfLXHoqr/3w4=
X-Google-Smtp-Source: AMsMyM6ngVayMsn7VTfVuWEO1II37haoj7GbfGLyrR0yAWqi+VQnOmfQfpnim+VdFaOygMG5/Hkr4w==
X-Received: by 2002:a05:6000:228:b0:236:773e:a6c0 with SMTP id l8-20020a056000022800b00236773ea6c0mr39961152wrz.102.1668080048236;
        Thu, 10 Nov 2022 03:34:08 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b0023647841c5bsm15516987wrr.60.2022.11.10.03.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:34:07 -0800 (PST)
Message-ID: <bb9c065f-1ea3-ae7b-9bae-bfbb00047a31@gmail.com>
Date: Thu, 10 Nov 2022 12:34:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 0/3] iommu/mediatek: Add mt8365 iommu support
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/11/2022 16:18, Alexandre Mergnat wrote:
> Hi,
> 
> This series contains patches related to the support of mt8365 iommu.
> Thanks for your feedback so far.
> 
> Regards,
> Alex
> 
> Changes in v6:
> - Rebase
> - Add new trailers
> - Link to v5: https://lore.kernel.org/r/20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com
> 
> Changes in v5:
> - Fix name file in mediatek,iommu.yaml
> - Rename defines to be more consistent
> - Rework INT_ID_PORT_WIDTH_6 check
> - Link to v4: https://lore.kernel.org/r/20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com
> 
> Changes in v4:
> - Typo
> - Rebase
> - Link to v3: https://lore.kernel.org/r/20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com
> 
> Changes in v3:
> - Rename "mt8365-larb-port.h" to "mediatek,mt8365-larb-port.h"
> - Rework the macros which retrieve larb/port ID to improve human readability
> - Link to v2: https://lore.kernel.org/r/20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com
> 
> Changes in v2:
> - Rebase.
> - Change M4U_PORT_APU_READ & M4U_PORT_APU_WRITE port to avoid display
>    conflict in larb0. These definitions are used for vpu0 device node.
> - Add dual license.
> - Retitle commit.
> - Rename to int_id_port_width for more detail.
> - Fix typo.
> - Set banks_enable and banks_num in mt8365_data to fix kernel panic at boot.
> - Link to v1 - https://lore.kernel.org/lkml/20220530180328.845692-1-fparent@baylibre.com/
> 
> To: Yong Wu <yong.wu@mediatek.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: iommu@lists.linux.dev
> Cc: linux-mediatek@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Fabien Parent <fparent@baylibre.com>
> Cc: Markus Schneider-Pargmann <msp@baylibre.com>
> Cc: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> ---
> Fabien Parent (3):
>        dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
>        iommu/mediatek: add support for 6-bit encoded port IDs
>        iommu/mediatek: add support for MT8365 SoC
> 
>   .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
>   drivers/iommu/mtk_iommu.c                          | 25 +++++-
>   .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90 ++++++++++++++++++++++
>   3 files changed, 116 insertions(+), 1 deletion(-)
> ---
> base-commit: 11082343e3bf2953a937509f0316cabf69dbf908
> change-id: 20221001-iommu-support-f409c7e094e6
> 

For the whole series:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
