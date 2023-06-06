Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DC2119
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 06:05:00 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-97458c97333so698575566b.2
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686031498; x=1688623498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9h6iIn8tVMxDio3DDyTS9fJwTAuNwCTFgsK9pHhOlo=;
        b=btZtmzTuI4MLVs+fYn14ZcCdRVIabbztQnAttPga6eE3e+r43+2jhik4nZnxAyehEG
         +hlXK6+pEhMvIFYsHSTZCgPFq3n72lrHIly4TuYWRIkg9fccQf6GPBkki/fwy2nfFR1L
         6id2R6puXXqyzQzZ8EiugsDJugS7MHcJH4BrPNgQu90oqnaD6hEOBDiTA4FYzNcFGDu1
         zf70oJbrRdcGt8pjU9BiqwR2lhWO1V6IuMbWVrV3avFSOnqeHZ8ltbic9kmjm6trqLlW
         HjrEwPcwF2LVilPS0yN30RFKcCGs/WvQF/yCw56++zcMJf8M7L3+CpWofZ8Ie+jtIk8A
         y4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686031498; x=1688623498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9h6iIn8tVMxDio3DDyTS9fJwTAuNwCTFgsK9pHhOlo=;
        b=LsW2aupV0UmvOlL29XHOpx63mn52COdWv9l61HeEdzlM8ZOgABvGVIye3N7yk0aPw8
         3hLzD02ee7gef2/inks9EW7ZnLLFmhdy2VIOloTuILe99fydr4MVcGg66LdYqtiKSPIj
         Uqdbef4AnMtpjQ/S/Pez1OfsgD37nZ15KAbOCnOdGaOX3z3pA5oce6IYKb+5GHxt7q3h
         /1RoKRc1Ya+lNLFhzZRMexA6sPQEsKjRDmwkdYmWqL6sMjuMKpFpgmKv2e7s+kPg9mNK
         bh9iMf2xIBrqKYPsBYs5ZFt8r0EHq3GdgBxGx0LDsTBQWc4otulZy5r4m/YcJvdDEKBz
         MGYQ==
X-Gm-Message-State: AC+VfDx7M34wBXNHGBh+hKmF1MLupb0HVew3GbccE7gtiv01FrinCj+N
	PbOewRXtwqlg8K/WabYm1DoXEA==
X-Google-Smtp-Source: ACHHUZ4HwHDNxVn79sHOEZUVTLCrNDJeMg/HIqnfWkb9LuwZmOx7L2932vKhcn3a/Rnq71N5KvWdwQ==
X-Received: by 2002:a17:907:8a0a:b0:969:fc68:fa9a with SMTP id sc10-20020a1709078a0a00b00969fc68fa9amr1224348ejc.40.1686031498531;
        Mon, 05 Jun 2023 23:04:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ks2-20020a170906f84200b009534211cc97sm5123968ejb.159.2023.06.05.23.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:04:58 -0700 (PDT)
Message-ID: <99873cd6-b9d7-8d3c-323e-9711315a67dc@linaro.org>
Date: Tue, 6 Jun 2023 08:04:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 05/10] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75
 compatible
To: Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, tglx@linutronix.de, maz@kernel.org,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, mani@kernel.org,
 robimarko@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1685982557-28326-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2023 18:29, Rohit Agarwal wrote:
> Add compatible for EPSS CPUFREQ-HW on SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

