Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE496108
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:22:09 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id bk16so9090165wrb.11
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvYugD5smOlPeb8yw4a3uYKIpMLS5cDQVS3icNcFMKA=;
        b=Z6PyaEpVm6gQZPhyOA+umXIzP1gj2ivonb832kvaPK2LHBAyLgqzEzWs+trmEE0Jln
         khMmlms5Uv6PhL4q8PhFwsygO3DHLGc4l5gyw4ZBVAMxJaFNOTa/D+37v6hQEgNUi6HJ
         MwrpiJXqxUpvHZ/jLL+pwFgBfNyRIeOFG6BE2kS+7uUlUG3H6z1r5xzHXB+rv1s49c7Z
         /cxqXGU2xlMj3qBcL9i+f7FQf/GhDu4ibCR+/YuG/aUITAgdMLmIeG9x8sQ8tEVru5a6
         NNDcVLsWYktntSaFMN0HlSbfAEBeUesEeaNrLaNMlba8+UyRhbCP48f1qqKf5QYGnay+
         VoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvYugD5smOlPeb8yw4a3uYKIpMLS5cDQVS3icNcFMKA=;
        b=33XlGnW1MEipyEydDb/X0f37RZEqqpNEDIObynxnomtC8fRQy5Eh4pKf62A9ct2bnh
         Ub8uJCkbesJOzWg51LH0n0OW+dKYUHaR0wsEnUD8m4evc+MeEGFMo3vVHPGrTpzKJeG8
         Tu4FZBxBfLs1C6dN1lDp3AR8uQ0c3AVGD5k3KCymIRIv8RwqSWCUlNhGjLJQa1dV4VLf
         CuwR7r0/h5Fs6ncRNTY0AZqRczzBxtVRt2n8adRTKboo3+yz1TYeelchpLZRQnaU3c3B
         gP5lhGB9FWzvqhdPPbAgGTlVR4nnun2aaa9PFLJV/eH7l79n4I3cFkKV4dxRY7jQtb+0
         ybZA==
X-Gm-Message-State: AFqh2kqv7txT/x85BMvhcotWZoM7TbMOgZJa9s639ZIL401CCsITAPM2
	jAbXf+bls1bGGFIL7T8+pCrwig==
X-Google-Smtp-Source: AMrXdXvjfzGBA2k+30sjPaP84E+50hgotZRZMLKqmz8cAfThUKaz2IKhBGPXhX7+mGfJd+LOudPNGg==
X-Received: by 2002:a5d:5544:0:b0:26d:2af7:420 with SMTP id g4-20020a5d5544000000b0026d2af70420mr40676769wrw.33.1673288528036;
        Mon, 09 Jan 2023 10:22:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d62cf000000b002bbedd60a9asm3589168wrv.77.2023.01.09.10.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:22:07 -0800 (PST)
Message-ID: <e96fcaee-488f-53ff-5fb2-0cea411677b9@linaro.org>
Date: Mon, 9 Jan 2023 19:22:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 07/18] interconnect: qcom: add a driver for sa8775p
Content-Language: en-US
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
 Shazad Hussain <quic_shazhuss@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-8-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109174511.1740856-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2023 18:45, Bartosz Golaszewski wrote:
> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Introduce QTI SA8775P-specific interconnect driver.
> 

> +
> +static struct qcom_icc_desc sa8775p_pcie_anoc = {
> +	.nodes = pcie_anoc_nodes,
> +	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
> +	.bcms = pcie_anoc_bcms,
> +	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn3,
> +	&bcm_sn4,
> +	&bcm_sn9,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {
> +	[MASTER_GIC_AHB] = &qhm_gic,
> +	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
> +	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
> +	[MASTER_LPASS_ANOC] = &qnm_lpass_noc,
> +	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
> +	[MASTER_PIMEM] = &qxm_pimem,
> +	[MASTER_GIC] = &xm_gic,
> +	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
> +};
> +
> +static struct qcom_icc_desc sa8775p_system_noc = {

This and several others are const, which means you started entire work
on some old code. It's quite a waste of your effort as now you have to
get all the patches we did for cleanups. Much better to start off from a
newest file. If you based work on downstream code, then this definitely
needs many fixes...

Best regards,
Krzysztof

