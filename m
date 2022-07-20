Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6146AA0
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 17:38:07 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id v15so18214008ljc.1
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ICIFskbhDAxkqyFPFywjKrA2bMQUTmKy88Z9Ca4QMwc=;
        b=pU4v+a1Ih9uwueVmVnw/nnRcFBk6TOtjSs23U+h8gRjVlV7wDHKSroELFu22DOnyC0
         MyE9ToyAShxsaTpXlt+/dHrJQvJsInZpC6XHFrdQORgZmkhNz/GcLEL7aLSOnjghiFRF
         yoAig85kwvl0gdzvs1inz7BQHrpwSaBinQUgdUT2+pBtFMNJin0BEW+PLOuwnOieRzVS
         eAJFwaq+rF9flazp7+kc/D2u4tCzcGylZyCH4TsvhRfddoo6xg4QmIthqM/kEy8hQeCU
         JWHiDHl/sFzRmFD9/NxBYwUKVb7BC5bLLOH20jDlZ90DknQPvGOX7X1IVUSH0s7dKspk
         qXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ICIFskbhDAxkqyFPFywjKrA2bMQUTmKy88Z9Ca4QMwc=;
        b=0mXHyuPYkpUUauGFzntTCa6Bx9opJpsMeCjg+4amlF88CJ5i1hxGek2kgSxPb0NDVO
         rLnNrmKz1lZuFPlFzf+JDIJ65vOb5a26F05Cw7n4we4uhJmOWDjeS2VwwxUvNkaQ+vkY
         HR1egx2FCWDZ0Y3xAJV7QJgqqH3GUQTP9C0f+06fmkWsVpTI/iFEAc2OG3EooZi4baUF
         Qwq2bn9lsIwg+fnH+MklHth23eNylV0jA1mb95bUad/dHduAzqEq2xwv1cgcm53xFE8D
         i1F7W/TQZ2xSzhKyXQW9uokyMRvsaWU1fnEvMYCGEGXP8mwry7EOzvEMGoqn5iXKX+Ms
         mMMQ==
X-Gm-Message-State: AJIora8K04+AMgzojBTmkoARdUv3wAyFk4upDj//flsxEpR6AsMVGEkS
	rO1VnA5b7gazoyWBblX+9KMWxw==
X-Google-Smtp-Source: AGRyM1sG7lbScHD/ieFpA/+GQ6oByCyWagIFfgC4I8Gr18ItlMyGc5wtlKO06bA6wu+LjYej5okHsQ==
X-Received: by 2002:a2e:8e28:0:b0:25d:c1b9:aede with SMTP id r8-20020a2e8e28000000b0025dc1b9aedemr5581492ljk.28.1658338686017;
        Wed, 20 Jul 2022 10:38:06 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id v14-20020a056512348e00b0047f6b8c2127sm3909309lfr.186.2022.07.20.10.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:38:05 -0700 (PDT)
Message-ID: <3fab6834-7622-a33a-dc97-9c630702b6fe@linaro.org>
Date: Wed, 20 Jul 2022 19:38:04 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 07/21] dt-bindings: power: mediatek: Update example in
 dt-bindings
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
 <20220720123023.13500-8-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-8-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 14:30, Tinghan Shen wrote:
> Update the scpsys node compatible string to align with the
> scpsys node bindings.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Squash it with previous because logically it's the same change.

Best regards,
Krzysztof
