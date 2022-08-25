Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23E2F57
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 13:34:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so2709964wmk.3
        for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=16mUpezxm80YWlJHrT1/vR/sK7zihBb/9bIY1O88uf0=;
        b=gZx8lYB9Id3gDBCjd8qFEkRWURnqOANH7rQGtZTj89Hy7ty6ajUb1in5wb4EUFylyK
         bjdEA9O7JJVOdwj/mg2wPm0K8/CF/RFgjCL5vlGHiuDSp3rtOe8jDQ5wzAMySvz+PWrk
         OYf3ICmgXmkkgFn1cw+8kUFs7710jpphO7H2ja7OjFywIzItHn8CHC2IEeSiDMKh+Zux
         iUn/ZFs8V0wQWiqkpVTDQ1w0Fs2tN72nQ5suXHZCRymcg222syTNp9ode82zSeHjs8wT
         22GrHi+qQ4Er/n9erGPOJpDZlS2G0y+HgecmU2fj1zY2Q35VcUqUk89mg1hHn7mmp4AA
         1o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=16mUpezxm80YWlJHrT1/vR/sK7zihBb/9bIY1O88uf0=;
        b=WgR/bHIIiCupHFp37kc5QdcrWvJeFZcC7drMa9jF+HW8CziygbgBQHfqmFktDmj2vJ
         vQ7z320l2FXF2+EvlcxiL9EhBvMoJgNT9wtjZOEfOByUHbth7KDOGbQ5N5SfnUUgFTHb
         SX8nmX4o/gVxf6UaQh6krPG2Hc8zBsEdyKLpnemHb56Yw5uckxb6ILv3B456TI+qCucX
         eUDTlQlyPnRBdH0EnwYkt+jdVYEbme7jBJKDk/RvKKcaxTjqRqOlwtnTfOTj1rHffjmm
         Pk4O07MFu+FSLwEcgf+kAVmCQ6tehcfoMH/yj+hrCG8/iAhGup2PypRvEtPzOgdpdeLP
         mH/g==
X-Gm-Message-State: ACgBeo3UhmwPMwfV1LHIflblbHyeINBnbYa7JgYehgbS0Z3Zhb6MERdq
	4LE31Ox0aLcw2dRHzou4luA=
X-Google-Smtp-Source: AA6agR5gHErvZPlnKGEvLXNiDwqGaydgJbZyT1M6n8zJ+OwyS+zQQCpAfBNjhqu25JRp5UCiEWpxXA==
X-Received: by 2002:a05:600c:3b0c:b0:3a6:aa0:5966 with SMTP id m12-20020a05600c3b0c00b003a60aa05966mr2367508wms.183.1661434494909;
        Thu, 25 Aug 2022 06:34:54 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6044000000b002254a7f4b9csm14356230wrt.48.2022.08.25.06.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:34:53 -0700 (PDT)
Message-ID: <24116d0a-38ec-8868-8b9c-1adbe98250f6@gmail.com>
Date: Thu, 25 Aug 2022 15:34:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 03/20] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-4-tinghan.shen@mediatek.com>
 <0bcc1575-2c43-8843-8edd-8b73ddc4d0fb@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <0bcc1575-2c43-8843-8edd-8b73ddc4d0fb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/07/2022 10:06, AngeloGioacchino Del Regno wrote:
> Il 29/07/22 08:31, Tinghan Shen ha scritto:
>> Extract duplicated properties and support more levels of power
>> domain nodes.
>>
>> This change fix following error when do dtbs_check,
>>      arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: 
>> power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 
>> 'power-domain@20', 'power-domain@21' do not match any of the regexes: 
>> 'pinctrl-[0-9]+'
>>      From schema: 
>> Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Applied, thanks
