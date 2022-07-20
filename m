Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B8602F
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 17:37:15 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id o7so31450097lfq.9
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7p5oDc+MTWM6fmNdT6fee7WsO1neY6yG3oroC+2SKog=;
        b=uBBjW1voxPKnjiUwz44hW4y0OUzcyPskpYpLmma9r982TTBOidFXfWEVU/AY1oGo/r
         BsSVH+28HZVm32tdTVBKorY9Xws+xoppKV8+DAEf2CF+HAWKQpNa+GST9Fj2MhscSFfB
         8IxE+rxjV/kcsEx7dsy1pSqzPDlRQTK0W425ZB2gM+fpTrZKtlJ3PU+1ep9pa3/JbJ9R
         QZYNPPMzEmWE6OkbS8MzRVsrJb9rD72jjGe9stQu0AAvWsB8BQ+XJyKjhBCuDiEjNt9W
         8KkmsZZVaqswHQJOg/lSN3BuT1XY8E69JTp33XS7s3m897Uv20neR+x+UnCch2PwB2hD
         /qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7p5oDc+MTWM6fmNdT6fee7WsO1neY6yG3oroC+2SKog=;
        b=CIfh0CVeWkDtHj57mn1/vp27uaawEOdUIl5OzPa0YWBWAvPF9mtBKh57dNToCu3v/0
         a5rSIdE5X/ydf0Wgv/JGCOhVb7Zs3ldFrvsWXRopTw2MiQxLIxRTNMC0MGZwpZvb0Esq
         z+E6RgNAlm6M0Ts9y9277c5Sje+VkmomX1afSFmxZndC9dvT0puWdLtddOU0FFJFvgIO
         EUDTduX2olgpyRDWfagwwGDmvLuQG5N+zJiofi70dtDEhvDoAO6L3ri8mpt7G6+Bhc4v
         XOvi//uPyaFONOx9oF3eZHcqUTPwnKRRWrcRM1yuKpx/Zce3kfStR/n/XXy3PtI95kfS
         gXdw==
X-Gm-Message-State: AJIora8Dy/K6pXH6nxFrU7uoxDIxLbixgO6axo9vfcklCmEHDLcB23KQ
	12reyGYw1w5LJR+8wMn6L3EY7g==
X-Google-Smtp-Source: AGRyM1v2HimajV1UlLGM1askxczmPNc2mGqOexFrLo7JMSfp0SaXQyHids9tDu8eFzlC2wiwqbwLCw==
X-Received: by 2002:a05:6512:b2a:b0:48a:2aaf:2ad3 with SMTP id w42-20020a0565120b2a00b0048a2aaf2ad3mr13421059lfu.552.1658338633301;
        Wed, 20 Jul 2022 10:37:13 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2498e000000b00488d1acb7b0sm3910823lfl.130.2022.07.20.10.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:37:12 -0700 (PDT)
Message-ID: <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
Date: Wed, 20 Jul 2022 19:37:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To: Lee Jones <lee.jones@linaro.org>, Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
 <YtgDu70Lpl/uPOkf@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YtgDu70Lpl/uPOkf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 15:31, Lee Jones wrote:
> On Wed, 20 Jul 2022, Tinghan Shen wrote:
> 
>> The System Control Processor System (SCPSYS) has several power
>> management related tasks in the system. Add the bindings for it.
>>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> Why have you ignored my review comments from v2?

If you refer whether the binding is needed at all, then the answer is
yes, because this is not simple syscons but a device with children,
which we want to parse/match.

Anyway Tinghan should respond to you about way how he proceeds...

Best regards,
Krzysztof
