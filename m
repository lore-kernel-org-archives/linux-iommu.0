Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B712F57
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 13:35:29 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id d16so19366883wrr.3
        for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1YhFpbHOP2L3HxhjwTH61U3L7iFs9TCv/PZtz7Logkg=;
        b=N0JYE3iWPQ1xCxuDZNIk2bxNlQS4LgJcKSjCHSp25/b53nk1PfwMM9IfyDud+/2Uhv
         FCjjCUHfHpemnH2fLYu91Cq8ARwzcjQr0C54NF2J9Y0oTiJtqmTavOWiCTUsmibNvTLr
         qWmtMZuGtXJErZJ0BLlCp+p/fN5OF0eWR4m0ojXaCIqapBJlm2Cw1f9XZX2Ik+SZVRO9
         dHQglMsuAe/vrn4b6nI+R3FReQfvKD72ROlNdFLFOLDvm2VRhCQRREIDm0wjMc9iFntv
         OIpAnSIro5NzxkiU0Kn9/orvjhrrAS8qhV6jkqt29OpYYsXDvrqBTXaCvEYnuJcX0lys
         /7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1YhFpbHOP2L3HxhjwTH61U3L7iFs9TCv/PZtz7Logkg=;
        b=3kvowG199KywcDnv2FYWW541aDVdtBbRVliH8NRPYuku16ApJ3e5LGu1d7URwOm9Mk
         V0xlA0aw3gkHTOs9fGipmVvr9Ab1YaBgWQGq3CTpw2XrxijyJrpzXAcBCorCKsENKPAf
         75CHeg7AbYfyVKEeOt/ZuFA1DVekGEsOlx+6nHp5M225wvSKJHQ1mTghmh9LY0/gFlpj
         OmGN2RJOJ1/DhNj8SvHcr4hXAUoNDAfIz4xMM+9NalyCsKUZAkYcyxXC2T60/9xtJpdn
         syDUr2qnGuRhbBciGHnJl8MvgKv3VFYfq02PaTVhUEt0IGoJ9SfQV62jvJ/tRswHSptf
         fa2A==
X-Gm-Message-State: ACgBeo3zKxI2E7luTI3+F9lDAAMo9b9sW/lDVoQXQE5nNejl3yPU4nxs
	hbEHYxFenjyKRzfBYpmy6zE=
X-Google-Smtp-Source: AA6agR4PfR5XtModeZKlkxxKgqBGnJWBWtSf2rL7FYJx+m3m7L9lbMM1ne2k9EGyVvCJl7SZvK2x4w==
X-Received: by 2002:a5d:64ed:0:b0:225:11d4:76d1 with SMTP id g13-20020a5d64ed000000b0022511d476d1mr2312391wri.579.1661434527464;
        Thu, 25 Aug 2022 06:35:27 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003a32297598csm5145454wml.43.2022.08.25.06.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:35:26 -0700 (PDT)
Message-ID: <ac7afbb6-9c8f-4927-be0c-9f6089d1dc67@gmail.com>
Date: Thu, 25 Aug 2022 15:35:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 04/20] dt-bindings: power: mediatek: Support naming
 power controller node with unit address
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-5-tinghan.shen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220729063208.16799-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/07/2022 08:31, Tinghan Shen wrote:
> Support naming power controller node with unit address, also compatible
> with node names without unit address.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks

> ---
>   .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 321802c95308f..2d6afc0909473 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -19,7 +19,7 @@ description: |
>   
>   properties:
>     $nodename:
> -    const: power-controller
> +    pattern: '^power-controller(@[0-9a-f]+)?$'
>   
>     compatible:
>       enum:
