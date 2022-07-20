Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32F602F
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 17:32:53 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id t1so31337414lft.8
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GcNBK7YfKlN5L7E979o1SuVA3j9sFZjXk0q59JTAE0Y=;
        b=vTNsdywBo8SiezHq39d4MnSeL9RUzWS1d8tMBIYeJe001MMi+Pfnvmut9IFwSAtnN3
         fGyIN4s7PcC/f8EsnaeMS1xkZaz7UKZrqieviSAqqqh8sb1NOWx6I3+L0Hg7XRlBlVj0
         1EqUUBDqg1nn1lAH8A5uAqds6Xkz8s5NRfX/MiWSGoIJ46qXJNNoT4J1iD5w43lTie+5
         Efwe983Fi72oOGbMmZ7cpWuPBDt3gOR1v1OEz5y/0ccoLaKInzUF4DkPbDDP+UpPiSOF
         MeIEct+0P2goheEhfJJAJaH6CCnH86nKorzu/Phu0LDooAQXOFY3GXM8ZR88ss54PAKP
         c9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GcNBK7YfKlN5L7E979o1SuVA3j9sFZjXk0q59JTAE0Y=;
        b=ITobvitCyAC45iR7JbIJ6We/AXZknBSThVJHhq3pNK3rOMfgucpiTg3eWPHwSDWvZ6
         sTP2XY9BD4wwzi6Ffy4GY2HU8ElJaZ9wOMiyEP+66u83Di5O8LkJRQvFgR5evE585mSG
         +wLPd/DgTdGUXzX7m6u9Yz75kOECspMMTakrKkk2T0un50hU5Fx4zP5YHZ4mH6QmKEje
         OCxWmUDqBTR9ei4uQf9SctvbWNqJbYSV0/g0y8NvbXC+r16XFwUdSU2Py7nImCdatq/T
         rV92VSdyn7yuxboH4c97nimlaGpVSMgl4F/lj4pigOIWjLoBE676HvEJi2f45FcQWaTQ
         r5aQ==
X-Gm-Message-State: AJIora+TcwPGTtP/R9YlpySnjnN1qYm+rky05IU+Af81zoO9YF4B10o8
	RDsi0gE4WYd55z7yFSTHesgU8vCjQMjDejcJ
X-Google-Smtp-Source: AGRyM1vjhyD+PuVuOucmn/VLbxuPWiERqLYolpXPQm2ecA3hiaYSGUjH7QjRWdaV7kAA5xwQD+EL7A==
X-Received: by 2002:a05:6512:1312:b0:47f:7bd3:1427 with SMTP id x18-20020a056512131200b0047f7bd31427mr19135756lfu.128.1658338371434;
        Wed, 20 Jul 2022 10:32:51 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id b12-20020a056512304c00b0047fac765f39sm3906980lfb.219.2022.07.20.10.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:32:50 -0700 (PDT)
Message-ID: <5daec4cf-172b-88cd-fbc5-586dceb93d4e@linaro.org>
Date: Wed, 20 Jul 2022 19:32:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 04/21] dt-bindings: power: mediatek: Support naming
 power controller node with unit address
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
 <20220720123023.13500-5-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 14:30, Tinghan Shen wrote:
> Support naming power controller node with unit address, also compatible
> with node names without unit address.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
