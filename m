Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A36AA0
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 17:39:27 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id d12so31434148lfq.12
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aeyafCkyinZJZTTcPy1wEfXMzXWZcIm0MV4FRs14iJQ=;
        b=zreXvg79hkBxKuShfS2H1ZVu3CjpX0spc5x+RYWSF3KMxuyjz5fLD7BBgfbuNGIvaN
         a2Wol5GaBcqFJs24Or/Cx8yVs8kKCzk2Q2Q+Kbw4VACBuD0IgavdZPfksPMWyjvHRkA3
         Xtom3dAIkGJ5NScEK9Dlt+XbFEMBKHcftw6XKQlhV5SMy5nxSAzs47rcxyG3JKnh9vEl
         /OKrKhIMKbRVpK72I4APWWgYq4traCLcCWzFv5auA0G14VIFu2oCCHlZ6ikxN3c33nsV
         XkKmrckQcwEb+7CWFRCHpGWzPJugLd1eKmVhWrUCUnW87mf1rv/60AlQED8RF/yHnS9t
         ELtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aeyafCkyinZJZTTcPy1wEfXMzXWZcIm0MV4FRs14iJQ=;
        b=zMc/FVgm85rPUzQfWU4U1DXfMQYmv3nOfuULLrM78DfAizxz/h/sXVGhkFmjqQBi84
         T67vgkjCpo6XBBJt+u0hJZPmj0Hrb1xQ+cf6vqmvSBqsjT8B6/yAdDLfpXBGER3271Gl
         Hb5S0F0Xmdw7vCoVW+RTdI9K6YR7wSD1heZbOtM6cvuPLIjxYRtNsofT9OJv9jvI/Cxa
         ZDh4lE6YB/qmNkhHa6DDm0ynUswfkfUp1IFpqBgyGK8iHxCrq35JV5sst5s4VpFW91AC
         n8sUiQUQn79Llm30LJZ2S1loOP23vKQLwhwq0MMmJDIF6Ob6WDbVz3pG5b3LHcIHElr6
         Y+aA==
X-Gm-Message-State: AJIora95Ccjan6LS6BxOjX5upZy5me5ZP1mInn11R2/XaA6DmursvbMB
	1tsAkBLGeHbBJNyx7O/1P9goCA==
X-Google-Smtp-Source: AGRyM1tlok4eLvijqT1LvZXgtABKbS0mRRyNVkb8xzG9GzfNEkfDR+8raI0dXp18XCp0w8HM7jBCAA==
X-Received: by 2002:a05:6512:410:b0:489:d17a:b2c0 with SMTP id u16-20020a056512041000b00489d17ab2c0mr21052431lfk.493.1658338765232;
        Wed, 20 Jul 2022 10:39:25 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id z13-20020a19504d000000b00489e64dcf75sm3940177lfj.204.2022.07.20.10.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:39:24 -0700 (PDT)
Message-ID: <085a003e-576d-b39a-60ce-ca8f53c89d43@linaro.org>
Date: Wed, 20 Jul 2022 19:39:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 08/21] arm64: dts: mediatek: Update mt81xx scpsys node
 to align with dt-bindings
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-9-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-9-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 14:30, Tinghan Shen wrote:
> Update scpsys nodes using simple-mfd in mt81xx SoC devicetree
> to align with the bindings.

"Update" is not accurate enough description. The same in commit title.
It answers "why" you are doing it, but does not answer what exactly you
are changing here and what is the effect. IOW, you need to explain the
true logic behind it - 10006000 is not power domain provider etc.

> 

Best regards,
Krzysztof
