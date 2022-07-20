Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9A602F
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 17:30:57 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id d12so31395965lfq.12
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dwu2BBEoj83lpS1r4JEpS+Hk0CrDCwjPWdyJ+RX619Q=;
        b=oYKI3U2GMEZIb5MUnj7eH4PFisbUGppSiFnnwksNQxqDoY4TfY57IpuwuuJGPK5cU+
         nM5c/h8JCEc1UX2T5D81mlXreJwA3KeuB4qwmmIyfvwUTTCC81FR3bjNiXB9s5gRKKMw
         oxjCtU4UZinS8ivcXmPCGiK99rHUO7QSU7HmkASt75ASN8UjVPqbCO/OAx1pbUg3Hkgb
         3u+fwtEKcZS/mughwSBv/mQm1ZGe2V7h3K0Ih9kgEgLoILx9XPyiHJCctn9wbee2GHM9
         Vl5fVQLE/cYvifMviioAlWLmFL6jNxsUC10FM01mPK+gVgpqZpIV5WRJauiDNT+VtBcH
         /FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dwu2BBEoj83lpS1r4JEpS+Hk0CrDCwjPWdyJ+RX619Q=;
        b=B4t4e5cVVnJ/Ka/4tujhRIXMTZDP+ADJn6vVXGAhyP6fm8fonrzzOXg3Un8HC4PvWG
         qBHIrwZjAhRoOTIVNWfdCJzYR4P2SwKIRibS/5kP4Qv2u23fQDuMSrGaO0EMNXPcguIw
         h4fP6n2qNPtAgdIlAgNaJhGC1ZhesF/zCcwDyqBYMkUI1D7lOB2lA5I5B8VCXT9s5AE7
         6sNmrnZ57F+U7I9EoyOcLS1ELTOBKAIeCkmx6GkIdFiF50mMOMz6sRNDrsL+D+aGlC2J
         rrl91vxWgbO6HE42y0Wnz/NOwv9hdjc9PNMSNocFLkOyJsrO4PuKGOaVMr8SFfSCc6B+
         VXTw==
X-Gm-Message-State: AJIora+yJEeodpymMxGfVtx2zmj+h0dLLCyRX60oQp5oKZrFl9csZp6A
	muJMC9ZLCwb7Sq0Wkk7ot2wQ5Q==
X-Google-Smtp-Source: AGRyM1svWBEnGoxfLgU/6XFYVxOvNlxfpkdOiQlU7cmJ6EexAMbAtjNzrJyianqFjVG2WYo/svPhmQ==
X-Received: by 2002:a05:6512:2094:b0:48a:581:f2e6 with SMTP id t20-20020a056512209400b0048a0581f2e6mr21907111lfr.379.1658338255557;
        Wed, 20 Jul 2022 10:30:55 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k1-20020a195601000000b0047f7b641951sm3919079lfb.272.2022.07.20.10.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:30:55 -0700 (PDT)
Message-ID: <bd22ee5e-7b51-9a5c-2108-664261c2028d@linaro.org>
Date: Wed, 20 Jul 2022 19:30:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/21] dt-bindings: iommu: mediatek: Increase max
 interrupt number
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
 <20220720123023.13500-2-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 14:30, Tinghan Shen wrote:
> mt8195 infra iommu uses 5 interrupts.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
