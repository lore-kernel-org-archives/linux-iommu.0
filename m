Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F07F
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 08:43:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id j1so16023215wrw.1
        for <iommu@lists.linux.dev>; Thu, 04 Aug 2022 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gq6/HNhAQ3BSIj0Ba+RrM6ince6+tYXHxLdu6U01oYA=;
        b=Bz4WTRlH4WuC24dGsS4v9wUmu3j89xaxP+rFpcK9gzNyf2u7WsaEbVSkqPKTaRhp1K
         rCtoYXRr7DMDHo0p2wuEyRK5ESAigQlLRsQK048vHx+ZN3MlEJU6NjbligKTJhlDIyCa
         v6op2mKcqOaJnMtUnL+3EFmjIEyd8NFLRpjI+6Ajx4sstc6mkHuuGC33qfST+QgqVLe0
         6OxL3SquzsqrtYtHJAICTDBBbSRXx+RqJU98kzovk5vUrn6uhY8GFef0H6u3EW9BCcxA
         uVmSMsG/ujV2dJnRrdvdW8ZfxWPUNnNXim6cPFWvzprMZqohemyuebKpfnc3SWdroqHK
         Miag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gq6/HNhAQ3BSIj0Ba+RrM6ince6+tYXHxLdu6U01oYA=;
        b=YWzKSNCuTAWUs8siQNb3LUS3GmhteVKjL6Bo4UjPLuMJE3493gXsfnja/r9oRJkxFm
         2uGCXbp9MCAW4Cr1flXg1OlmBcW0fBJvXy09/NryM/xeh/+alZGcBhbTlkr7Vpul7OJk
         p1kGM+WZMpey4ln3DSJdj+ajfFWZzqQYU3Is8kxq5ufiNgo80ouABZqGeSXmia2gvThG
         M+U8P0eA4Ma5sa9eapWNLq7tF2n8rPJ2zdII+C0KmKPmWMBUDG1EefwCZoiVb3QP6Ba6
         NVWVfCROWlINd2TKGV7xbF2K1vW/j5uGr0Sy0qwzaUfEBjkzpoTG3MYzxBVMALxDOwqn
         zoYg==
X-Gm-Message-State: ACgBeo3G4f1GSSRqEIqaTY/HbDNItnjQSluwty9j3LX7i95sGKRXYctW
	QYUPGV+n45rrWKfswbTna7g=
X-Google-Smtp-Source: AA6agR7JMuieExtxMItJInX7x5ROJ6BsC9WvMHLa0/yaf92L6oTFOHBtIasKgc7TcO8y2gvcevC/6A==
X-Received: by 2002:adf:f407:0:b0:21f:a7b:b81c with SMTP id g7-20020adff407000000b0021f0a7bb81cmr661641wro.42.1659602593746;
        Thu, 04 Aug 2022 01:43:13 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b0022063e5228bsm422563wrw.93.2022.08.04.01.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:43:12 -0700 (PDT)
Message-ID: <11c7b04e-9837-440c-fa5b-3074a706e0ba@gmail.com>
Date: Thu, 4 Aug 2022 10:43:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 05/20] dt-bindings: power: mediatek: Update maintainer
 list
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-6-tinghan.shen@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220729063208.16799-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Weiyi Lu,

On 29/07/2022 08:31, Tinghan Shen wrote:
> Update the maintainer list of power controller binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 2d6afc0909473..03b7f6aa591d4 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Mediatek Power Domains Controller
>   
>   maintainers:
> -  - Weiyi Lu <weiyi.lu@mediatek.com>
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>

Are you ok with this change. Can you provide a Acked-by tag for that?

Regards,
Matthias

>     - Matthias Brugger <mbrugger@suse.com>
>   
>   description: |
