Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F41C13
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 08:21:41 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id b3so18050499lfv.2
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 00:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXwjJ+1nVh+Y0hu+zDgKARF1kxSAIVcPOIQgVlBh1rM=;
        b=L6rcOJEJ6KxeK+6HFTOUO+edq2uyaRuVyLohWHZIRH8JhNZ5V9zcK1resxFa/SG75O
         6ZikG7ZgaRRPQXJp9EP4B7P12vl73uQ7cYQD3OSn6sXd4Hd3eq3I0mJzTNTD4o5u9+84
         Mt42lAHR0uChZbOi0snfti+LoVhjQD7/g4Y424tEHJZNtmfWGlua0yDy8kr3oK2mctVW
         aw9nPS7CpOwlb/yX8ayJ7n643XBvpOq8Et4FdS0/xTTYo6IA+iS/MFlWc7oi1bRSnhQw
         E6+mGqxsfz9Hsq/xVZAS4JaGjaTdWw8/RJvD8dGeT1F4qmDkgXWKM4sTtCl9OTJJh2w6
         KX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXwjJ+1nVh+Y0hu+zDgKARF1kxSAIVcPOIQgVlBh1rM=;
        b=nzCjCliaYs12I+fYI2C3I3N4ZM6PaSU+zy66vPQz2vd4MnJR/0xmYlAeEP67JVC+Ow
         Dp0EtnnNfQR/Uj+Iqdqcxk6KsPg8e/I+mtgXEYFSAGX4wPOLIv7ITc3XJ5h5GjWzPNQW
         AII4wQ7PUQgb1cwMm6DUJN/JIQx68+FUVlgNsm/GldNI9QJSIzP+FgOxcauettYcN2+r
         5l4DMhj+C2LKqQUCLR3xa8XoquLrR6FUhrDeZmHp+o+bnE+AexQhHej6Me/FpGad7iTF
         0VPIZ0T0qk5qg8yrtmAwLxWistaTRoxBk7650pXYP5n+ddlBTYoWg7AU1bdbUdvzwK5T
         wdlg==
X-Gm-Message-State: ANoB5plLdmkroHkNrrICwK0rtJaExAdnUi2JGYJjihHwDSCh1QQfbHDz
	BaPLITYI+sfnbXQOz8+MtOZXwQ==
X-Google-Smtp-Source: AA0mqf4A6WdbunwRNdha5WmvtyEql8FV7Dy8+u6gVw7amCTsBnHAfoke633t1VDZkTsfbVQj0kl8hA==
X-Received: by 2002:ac2:4c55:0:b0:4a2:3d81:8aed with SMTP id o21-20020ac24c55000000b004a23d818aedmr3584098lfk.500.1668414099846;
        Mon, 14 Nov 2022 00:21:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o20-20020ac25e34000000b004b40c2fccfdsm1734650lfg.59.2022.11.14.00.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:21:39 -0800 (PST)
Message-ID: <5441bcee-2735-eea6-8d33-58226632b80d@linaro.org>
Date: Mon, 14 Nov 2022 09:21:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/8] dt-bindings: iommu: qcom,iommu: Document QSMMU v2
 compatibles
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 agross@kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
 <20221111145919.221159-7-angelogioacchino.delregno@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111145919.221159-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2022 15:59, AngeloGioacchino Del Regno wrote:
> Add compatible strings for "qcom,msm-iommu-v2" for the inner node,
> "qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
> bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 7 ++++++-

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

