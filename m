Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47217B
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 11:30:53 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id g17so19696253lfv.4
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680089451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkStHhS8RicbgIIuIIrnClWQyhU0ssY7587G4EgzNw=;
        b=AezqGCBKF8JxwLe6ttFT/yFnOh4FBegYDojNt8VAclL2tZXfcP5EuORMusgm6F5p1U
         k6b8hqZWPiDnAT0h0AtwvdWXD3jrKt6ckoMP1Ho76vTn0j96UmjyE262J3GoQMUHYTcn
         REWSxM3kV4aocy28gjxwsvMxIGJffiMp3JmKhfgEZFAwm85IOpbFys8Af0RXC98TQ+YP
         MM9QFXxzLvogsuF2VLGva0zOlqbUJA4M09v5rQhf/asxYm1Mu+vWzH8OtyNfzaq+vyJX
         6HPzqBBQ2Vl/h7b2dYJJ8Zo/yTcrujJYgCss6d5aX3f5m1kX/A1hlVqsbjWCYeRCt4YU
         HkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkStHhS8RicbgIIuIIrnClWQyhU0ssY7587G4EgzNw=;
        b=2I4CA/fR/V8Rpj0l9CtZkCuhm6WdKAKSYwO9HX1akS1fnAmJ2XDyPP8yRlMC7wdyr1
         iJz5Lg5fu5tilfsQOPQsnxwqs9ztx+6USMqxK3F5KdCbG9Lcx5QFnvvutMs1IAtow74l
         B3stcd84veY+umnQ2Rwd1wuzeiizJd/MObb7GYYv0EGl7x+RMzso/amhi0GjTh1mx9Sk
         KkdnTrTvj0mtbK7J7AsSR3QVpTrvoloB6/eRLXDlb5d3ujIv9WprajBl47k7nXkevh+2
         Blg9ggEwlS9odVEbA+0Y1Q2WR22wiG//2T3RwsjxdkH9w6Eu/sYijBIbFlUgk7lh9G89
         R90g==
X-Gm-Message-State: AAQBX9eHsEV2yTInMB+phcJicZUpNqw+hwMQjpV3DGapisw1lCUtnOzy
	wQFt050UfSIRgweVh//fGODfYg==
X-Google-Smtp-Source: AKy350ZV6sDKOCTXP7mZPDivoS4M7xj7kfUle01CK32kBixoCg2P75PVeoCzYNaj3NW9WtiXMPPxQw==
X-Received: by 2002:ac2:596f:0:b0:4eb:e03:9e6c with SMTP id h15-20020ac2596f000000b004eb0e039e6cmr599912lfp.33.1680089451646;
        Wed, 29 Mar 2023 04:30:51 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id u3-20020a056512040300b0048b365176d9sm5467581lfk.286.2023.03.29.04.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:30:51 -0700 (PDT)
Message-ID: <95b4bd56-b307-6c72-494f-e9b190df8d74@linaro.org>
Date: Wed, 29 Mar 2023 13:30:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/7] clk: qcom: add the GPUCC driver for sa8775p
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Shazad Hussain <quic_shazhuss@quicinc.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-3-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230328193632.226095-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.03.2023 21:36, Bartosz Golaszewski wrote:
> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Add the clock driver for the Qualcomm Graphics Clock control module.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> [Bartosz: make ready for upstream]
> Co-authored-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
[...]

> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_IFACE,
I think it's never used?

[...]

> +static int gpu_cc_sa8775p_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sa8775p_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	/*
> +	 * Keep the clocks always-ON
> +	 * GPU_CC_CB_CLK
> +	 */
> +	regmap_update_bits(regmap, 0x93a4, BIT(0), BIT(0));
You set it as CRITICAL, this should be unnecessary now.

Konrad
> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sa8775p_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sa8775p_driver = {
> +	.probe = gpu_cc_sa8775p_probe,
> +	.driver = {
> +		.name = "gpu_cc-sa8775p",
> +		.of_match_table = gpu_cc_sa8775p_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sa8775p_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sa8775p_driver);
> +}
> +subsys_initcall(gpu_cc_sa8775p_init);
> +
> +static void __exit gpu_cc_sa8775p_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sa8775p_driver);
> +}
> +module_exit(gpu_cc_sa8775p_exit);
> +
> +MODULE_DESCRIPTION("SA8775P GPUCC driver");
> +MODULE_LICENSE("GPL");
