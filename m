Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DA20E0
	for <iommu@lists.linux.dev>; Sat, 15 Oct 2022 15:16:42 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id o22so4274066qkl.8
        for <iommu@lists.linux.dev>; Sat, 15 Oct 2022 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKv2Neqe+SMtTTaijkh7FooflaU4DtlHbUVwh4pOmRs=;
        b=dcZZqpG1ymU7in9PwT8w96vP85gCCag0+LTF/F+enSV5ZYsYpc5KImoUFpR05+0/0x
         VN7iKgkvgTN1fv3uvlOpEcU2vbVNHKWvfTPNnLQJdsEMpqd+bddrLfH2caIBqEXhzEiz
         4WH9O+zEMQv74ORexScnUaCMdf9dcQIITr522qUfVPb+dhifTchRm9jIPXQeTQMZxJ2t
         W4RZmOWlhfRXKoAVRcdY0IhFwQCXFnmJF38FSjmnzWjLR+qTL7AkIOaUwK8GWoSP4wAm
         FUwlrFag7IYp5Mk9PzKzSKOThZhGh5vQJSVb1N3frmXCOFpVofIK8pY3RZgdYZpHR3Y/
         fBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKv2Neqe+SMtTTaijkh7FooflaU4DtlHbUVwh4pOmRs=;
        b=OJL8Zvh2dinY6BVBnyrf8gnvvRk3rc1gu0XcMQiy2+1ZKaqysqIcLsKxDM4XIkwZ+r
         IvezONah5mJlnm8RgERvlez3Hs3UhdBnX0A6YBWrGkXzY8ycA3KBRF+CY6/lkm7VMVZz
         5SIp3WJ/hrwVs9sSITHzbeFo7nC8AKoI6+eHPlKN9fWZVwmVIDVHIk6jEmPApwJlI1F4
         6LRAsUNnK2f6CTe4eDof/Rw3jyrSCnYFI2KjYKtJ5G+0b+0mGkBecp4sN/m/uWH63U6u
         39qmdcx46Pce0iASdzdPw9aDh3/eTPWfLK4YPGMy7YPjd86CsXbdkH9/C2PIuYkg38yb
         /yPQ==
X-Gm-Message-State: ACrzQf2Q4SZzDTn0qIve6LPexT8/q9m83p+//ll9+8EPe8cH4wI33CZ9
	w6ik8Yb/a8Z2U6JGOUqKOehOSA==
X-Google-Smtp-Source: AMsMyM4mPw863JV4jFsOwm4iIwTcWvBxioxfHu1/Ugvy7rmvL6ArxQWzrw7RToxMuGaVpm7WZz+jmA==
X-Received: by 2002:a05:620a:29d2:b0:6ee:cdf4:c141 with SMTP id s18-20020a05620a29d200b006eecdf4c141mr2126155qkp.236.1665847001702;
        Sat, 15 Oct 2022 08:16:41 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id h16-20020a37de10000000b006a6ebde4799sm4607619qkj.90.2022.10.15.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:16:41 -0700 (PDT)
Message-ID: <fd36ae9b-2f15-43a1-51dd-bed475f12e5b@linaro.org>
Date: Sat, 15 Oct 2022 11:16:39 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/2] dt-bindings: arm-smmu: Add compatible bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To: Melody Olvera <quic_molvera@quicinc.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014221051.7434-1-quic_molvera@quicinc.com>
 <20221014221051.7434-2-quic_molvera@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221051.7434-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2022 18:10, Melody Olvera wrote:
> Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..ae314436eddb 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -34,6 +34,8 @@ properties:
>          items:
>            - enum:
>                - qcom,qcm2290-smmu-500
> +              - qcom,qdu1000-smmu-500
> +              - qcom,qru1000-smmu-500

No. You sent entirely different DTS.

Best regards,
Krzysztof

