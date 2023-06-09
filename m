Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B9EC2
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 08:52:30 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f62b552751so1830420e87.3
        for <iommu@lists.linux.dev>; Fri, 09 Jun 2023 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686300748; x=1688892748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t9M/6Ovu01rsBXyQ4z3CLV3BYJ2AwcXEt+92u20gYU0=;
        b=iiurC7B4Vrou0Kyj6o9TuEY0C1+Vmop2kkwYy/JwMNiDfk3C9D08hdOM++i6BxmRzd
         N6XKMnwQDiNi28JaRt3QECP7LHvaVt24MPE22p6pXGwK6auvy0rrH2tYKbG+LGUzpAlh
         KcL+iHEQsD08trEyX01GdAoZzDL4Yqo7jQ2bZMe0rb62b1161EbSmTqgr768qYVVdbYj
         GHkJAOdXKod0NW/s29U6r2rdyD0USPziPrBZLcc+Qh2zv37cNG/PnMd7SVTfaAJ/gmkN
         NORjEeB6Eyz8QdYMI0rYneqdk3CVgwI3riZTea7I72bRNuswmBsd3NSm/R3eEeozJWmT
         XEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300748; x=1688892748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9M/6Ovu01rsBXyQ4z3CLV3BYJ2AwcXEt+92u20gYU0=;
        b=k2QcYl1/oYIwUo12Zf7dff/qH/yRcVoj//8CgDzgrF2oCpRJEpKniQKYNFILH2QL15
         LWzcZR/c2vs+Nxf7WzGCa1L1cZBerEl+jaDWl1kzVbEw5UvcKlG8l5P8RCF0JdqWuiqN
         R2Fwrjr1b3XhwRtErcq6HVU3w3uLH16n8cuvjafdNRK3rr/30OpgtDrUs5oNXF7HFOqm
         5x1yZWwzInuOttnHo30/zLFYyFfRd1O8KYWyPureUYLnsDmvMnu6bV0dA5WTW5YSborz
         YTXJCn2RyChAcwy5SHseX+nJ0LP6JJsKnBbjokAwPAUydUwdB4lhCjYNNWCecR2xpYsd
         6hkQ==
X-Gm-Message-State: AC+VfDw/PVpgHU8qaKZE87VWno3UuSXavIgGJ0KN4wGtMzjRkePaU6fx
	ADMWZaca/JeJLpZ3EPnoatj5EA==
X-Google-Smtp-Source: ACHHUZ6URLbtsV/hVc8kbJlOW1RBbNBO9Skf8vY3qzFMeRqmyo3pp7TL7kBdL12IqDoWVnHxXtbA8Q==
X-Received: by 2002:ac2:5f9b:0:b0:4ed:d2cf:857b with SMTP id r27-20020ac25f9b000000b004edd2cf857bmr411360lfe.5.1686300748434;
        Fri, 09 Jun 2023 01:52:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l13-20020ac24a8d000000b004f3b9adb04asm479339lfp.286.2023.06.09.01.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 01:52:27 -0700 (PDT)
Message-ID: <79206b05-674b-1f6c-6eb1-ed45e6bd5637@linaro.org>
Date: Fri, 9 Jun 2023 10:52:26 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sa8775p: Add interconnect to SMMU
To: Parikshit Pareek <quic_ppareek@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org,
 "linux-kernel @ vger . kernel . org Prasanna Kumar"
 <quic_kprasan@quicinc.com>, Shazad Hussain <quic_shazhuss@quicinc.com>
References: <20230609054141.18938-1-quic_ppareek@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230609054141.18938-1-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9.06.2023 07:41, Parikshit Pareek wrote:
> Some qcom SoCs have SMMUs, which need the interconnect bandwidth to be
> This series introduce the due support for associated interconnect, and
> setting of the due interconnect-bandwidth. Setting due interconnect
> bandwidth is needed to avoid the issues like [1], caused by not having
> due clock votes(indirectly dependent upon interconnect bandwidth).

[1] ???

Konrad
> 
> Parikshit Pareek (3):
>   dt-bindings: arm-smmu: Add interconnect for qcom SMMUs
>   arm64: dts: qcom: sa8775p: Add interconnect to PCIe SMMU
>   iommu/arm-smmu-qcom: Add support for the interconnect
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 22 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  4 ++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 16 ++++++++++++++
>  3 files changed, 42 insertions(+)
> 
