Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41C8C09
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 20:13:46 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id bu8so14808245lfb.4
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwlI2rC+HzJTLFLMhKZ8XXSbqvnPdbvWS7MaUPnObQo=;
        b=kz3Ist5SxOCjqV2Ocp2A6n17EHolOzFGiqs6Wco9XF+43bgkwP9nBpHWfzG4X/BXQx
         CyGQO1Ofksog/BjasUXnL0yAnmDUZ44XYgH8AYgP6Dnp3dav6Bea9C/x41l56t1mL2Sw
         chgSQ8gIVZWZ0S0UaW5amMhXBDegOHhh9IFm40U2qPAsFRM09/BF0IvMBNsMmmwR6KtA
         8cmvA2FyEnoOMh2ULjMshs5E4J7fz2izE+xtI+I4y42dmYwQMyTcgrXVpI7HVQs4caH4
         KEQ3vy9J0wHOewqQ99+KxtH1TIZOMtJuV/ljHg4FElybP2XRtibuBisf4wIQhKhHdkvW
         xT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwlI2rC+HzJTLFLMhKZ8XXSbqvnPdbvWS7MaUPnObQo=;
        b=18e2gkh9vBMhMo/q3hTkqVomBs1G49YUmgTl38Its9ODPDwyeLC4+y9ynff5J1+Txc
         hSLiNV7VktpaDFBySYR7Rl13OCSzfK+s28NPYuOZIjYHAaNh0bqXRkSmeKaJVRg+ud2m
         vvvnmTnRobNda5ECLHntumUEF2kGZO8SBNKE691QRCtIzNBkqpTBxczDeqWUBVzHpFkc
         UKK+hzHVlyR9lJ8qSSYnINd8JQR6H/qHWof72u4xo8hYq93IqYhT5Gn/j9e7sfCEJEth
         Zcu3OvZB1chIVQtOZUSjEro+gpjk1U4S6A17hv0r/6QWO72Ew2r1EfMmu6nmmYjiqXh2
         EYvQ==
X-Gm-Message-State: AFqh2kp9+vi9BCXnd/ED2GY0JY44pXIMLSYdrjJeyKnImCUq4p1OxBUB
	isdpPvb2V/A7rEbAyUeumtWwMg==
X-Google-Smtp-Source: AMrXdXtvNWi+5bMNS3mo/Qw4dk7CPRaMpdh2nLCV4A0yC2G+8sSbxJc6WOy18Yj7EqgI+pgZXWBpcA==
X-Received: by 2002:a05:6512:3601:b0:4b7:13b:259d with SMTP id f1-20020a056512360100b004b7013b259dmr16616174lfs.48.1673295225068;
        Mon, 09 Jan 2023 12:13:45 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x2-20020a056512130200b004a8f824466bsm1766455lfu.188.2023.01.09.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 12:13:44 -0800 (PST)
Message-ID: <bca87233-ae9d-00f8-07d3-07afef2cb92c@linaro.org>
Date: Mon, 9 Jan 2023 22:13:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 00/18] arm64: qcom: add support for sa8775p-ride
Content-Language: en-GB
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2023 19:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This adds basic support for the Qualcomm sa8775p platform and its reference
> board: sa8775p-ride. The dtsi contains basic SoC description required for
> a simple boot-to-shell. The dts enables boot-to-shell with UART on the
> sa8775p-ride board. There are three new drivers required to boot the board:
> pinctrl, interconnect and GCC clock. Other patches contain various tweaks
> to existing code. More support is coming up.
> 
> Bartosz Golaszewski (15):
>    dt-bindings: clock: sa8775p: add bindings for Qualcomm gcc-sa8775p
>    arm64: defconfig: enable the clock driver for Qualcomm SA8775P
>      platforms
>    dt-bindings: clock: qcom-rpmhcc: document the clock for sa8775p
>    clk: qcom: rpmh: add clocks for sa8775p
>    dt-bindings: interconnect: qcom: document the interconnects for
>      sa8775p
>    arm64: defconfig: enable the interconnect driver for Qualcomm SA8775P
>    dt-bindings: pinctrl: sa8775p: add bindings for qcom,sa8775p-tlmm
>    arm64: defconfig: enable the pinctrl driver for Qualcomm SA8775P
>      platforms
>    dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
>    dt-bindings: power: qcom,rpmpd: document sa8775p
>    soc: qcom: rmphpd: add power domains for sa8775p
>    dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
>    iommu: arm-smmu: qcom: add support for sa8775p
>    dt-bindings: arm: qcom: document the sa8775p reference board
>    arm64: dts: qcom: add initial support for qcom sa8775p-ride
> 
> Shazad Hussain (2):
>    clk: qcom: add the GCC driver for sa8775p

This patch didn't make it to the list. Please check if you can fix or 
split it somehow?

-- 
With best wishes
Dmitry

