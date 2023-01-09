Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51B8C09
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 20:10:47 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id bt23so14758192lfb.5
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYv8YtklJYFSBnqUzDCKD0SPZFw1ONkumQGMVniPZaI=;
        b=GDxTuQIRJgtel7vfxfPwHsWCDWNukZE5tnLZKPy88rB461vEjbSal8xpgOdpnmO8mR
         8MXuox/tp4GMowtxnXwz5/9sR24YuckCV8aVg/7CXnBelhfZArB6J/3PXs6HaxP5utyz
         ishkVfpqOLz+qWIHZDUQWnnhmzPN1pxcDLZACLj3xU4mC+QONy2/KX+Ih7BVP4VGtcrC
         0A+9Qk4CQxKHmwzHKEaGxQa0tcideu/IhvLfA2P45c8+UP7qveelrvsoEGNunkJvenog
         sxO1WnOY+FQgee1ZogSpSmbVWfOt7RfizZO61l63u38iIwheNeHQclE/ElOcrwE20xrf
         YpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYv8YtklJYFSBnqUzDCKD0SPZFw1ONkumQGMVniPZaI=;
        b=JSAvLbX5qj5FfVJgeSJmz7qjK2Uzk7G3PSt4pijg5/kZy5juf/aQmBroxVqToUoHr0
         vlG6nHEXzmPVoSLql6ERfrw2E45NqNQnxhUU01j63KDAFsMlFOSBV4Z2h9o6JvfWLq/V
         TQKXCuCP0Yzunj/ngsqmr9wzyQ6IJ6CayBMm7r/6Pl5J2M9TF3d1u3eDwGN20w8QRY9S
         /a6aPIK+3UreSsAKIg+Ww6VLXc2X9J5jkbuyxWSuXM4cdkiq1MSEXQnwVFEEBx6MNiu9
         +yj+zTtV58vMpdWPiVj9bGBuRERVHrEW4wIVLrJfnPUBVdZRWymscMaH4pOczaq9zjno
         h0Gg==
X-Gm-Message-State: AFqh2kqqDYnKu0TOMEXRNR6kw1gtW4XscqJhD5VU5sNyRXQhEquS32+r
	3ZD5uSq53pg0vGxbRUT9m4NMDQ==
X-Google-Smtp-Source: AMrXdXtPrpj6UYPWG3GXi/KKEUU8tcapTSxME54rfgaBkTDH5LSK/GVpX5mevXKdB2D1xY0QRN5y6A==
X-Received: by 2002:a05:6512:3b0e:b0:4cb:4362:381d with SMTP id f14-20020a0565123b0e00b004cb4362381dmr8105304lfv.62.1673295045061;
        Mon, 09 Jan 2023 12:10:45 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004cc548b35fbsm1769736lfr.71.2023.01.09.12.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 12:10:44 -0800 (PST)
Message-ID: <01baab80-4332-542e-e080-affb441f9c97@linaro.org>
Date: Mon, 9 Jan 2023 22:10:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 14/18] soc: qcom: rmphpd: add power domains for sa8775p
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
 <20230109174511.1740856-15-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230109174511.1740856-15-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2023 19:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add power domain description for sa8775p and a new compatible to match it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/soc/qcom/rpmhpd.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)

[skipped]

> +/* SA8775P RPMH power domains */
> +static struct rpmhpd *sa8775p_rpmhpds[] = {
> +	[SA8775P_CX] = &cx,
> +	[SA8775P_CX_AO] = &cx_ao,
> +	[SA8775P_EBI] = &ebi,
> +	[SA8775P_GFX] = &gfx,
> +	[SA8775P_LCX] = &lcx,
> +	[SA8775P_LMX] = &lmx,
> +	[SA8775P_MMCX] = &mmcx,
> +	[SA8775P_MMCX_AO] = &mmcx_ao,
> +	[SA8775P_MXC] = &mxc,
> +	[SA8775P_MXC_AO] = &mxc_ao,

Is there any parent/child relationship between mmcx/mxc and other domains?

> +	[SA8775P_MX] = &mx,
> +	[SA8775P_MX_AO] = &mx_ao,
> +	[SA8775P_NSP0] = &nsp0,
> +	[SA8775P_NSP1] = &nsp1,
> +};
> +
> +static const struct rpmhpd_desc sa8775p_desc = {
> +	.rpmhpds = sa8775p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
> +};
> +
>   /* SDM670 RPMH powerdomains */
>   static struct rpmhpd *sdm670_rpmhpds[] = {
>   	[SDM670_CX] = &cx_w_mx_parent,
> @@ -487,6 +520,7 @@ static const struct rpmhpd_desc sc8280xp_desc = {
>   static const struct of_device_id rpmhpd_match_table[] = {
>   	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
>   	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
> +	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
>   	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>   	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>   	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },

-- 
With best wishes
Dmitry

