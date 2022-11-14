Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF71C13
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 08:18:30 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id c1so18032386lfi.7
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 00:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3r9XnYw/2RXnn+nUkb+yTh4pjctNdhFSz8vipjIQJOs=;
        b=IVRu5kkIQIYzNHJ+iyooJNnVYeyKJv0UIdNzlROhpj1chZb+rlArxyt7HyF3Cfu/hP
         +984rrdUXoXm0Ni9hPrskavinNrc4F4z6m3DK7SNk1C9efJehQ6WgblAIUcAv6aNHmDM
         ARFwyG1RjVtxd1qxVFkqxOcgHGTnxaa2zP19HfJvNk9C1ep8XYzrBf0t8/oxFWrQ/gZ+
         N9lCHBuV/X28+qwNPgEuyeX1Vm17sv2McCOMWgpbLYpocj49LIyyTslmdZbd0DD7A+4C
         eB5xpzddJd5Mr9UlES+Mxm7FM7Nnpu0uR5LO0JqwT2NFO/bNaxUTPYKzi4iyNS1jDQr9
         SW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r9XnYw/2RXnn+nUkb+yTh4pjctNdhFSz8vipjIQJOs=;
        b=rWY8zK18AF1+6I9ogSCzsEYS5AINxahLa97X8lpm9rBWs/Qhr8QO7v0uipk72TO88K
         ZpMfvmtQTDkAxk8NP3sgQ4GHW8DbC7v6J4dgp/TLiOEwgJSn6JfmqlP5DHlwcUEzweVV
         yDL07RBqh+Wcq9VHUw5oeovA2k7GHaYzvPoP7JvMgc1xnkQmn39gZ2GguH2+/B6Qw4w4
         GCj+WArQ9XvnrIb0rvq3kOHyAotRTpz5P2UZbQO4QLui6u8obaANc/PGNxojj0NpZhxL
         kszkB7f5Sn8fpVoWTW8fp2lyA2Q7nWYdPhUXtaXgxMcTpfMW7rdCoKgvrxXzLYK3MxYT
         QNkA==
X-Gm-Message-State: ANoB5pmufuODK1AAVdruBXW7AdQqAoJRTQIuOXESeCj5oMtE4Dt5EZVE
	OQfv/sdl9JIFxyuYjltBS58mgQ==
X-Google-Smtp-Source: AA0mqf6SmmPHltZRuyUtC95655AwgGGqG2HLqvXIQ8oUpNilIOTugiIX+wOxgcbyq7b7C2aWU+iPQw==
X-Received: by 2002:ac2:5e9e:0:b0:49f:cb82:b3b0 with SMTP id b30-20020ac25e9e000000b0049fcb82b3b0mr4409967lfq.293.1668413908705;
        Mon, 14 Nov 2022 00:18:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o17-20020ac25e31000000b00498f23c249dsm1725813lfg.74.2022.11.14.00.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:18:28 -0800 (PST)
Message-ID: <08bfc625-6cdb-9754-5ac7-8a8ec0af7fc3@linaro.org>
Date: Mon, 14 Nov 2022 09:18:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/8] dt-bindings: iommu: qcom,iommu: Document
 qcom,ctx-num property
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
 <20221111145919.221159-2-angelogioacchino.delregno@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111145919.221159-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2022 15:59, AngeloGioacchino Del Regno wrote:
> Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
> contexts where required.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

