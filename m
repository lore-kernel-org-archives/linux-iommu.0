Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291216A39E
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072673; cv=none; b=Hylp7COOH3JSRYM2QXMQcUdLZx45NUJVevMHXI1QsAZPYrJKEbyerUCkDxKJD8jXbpxEah1OHEZi6NljN0l1moSSk4uN9w1HmIYmQpgJhyhY0KAwdO0Gz88sTXKOnmT6yz1l7L0NI3aL1js1hw3GZ2gVuI1PV9jNOl+QtV9sWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072673; c=relaxed/simple;
	bh=IYdbPe0OKx/9hkdhX0xvBdF2XVrWlDywpNqyZct7aPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMAV/BEU6bp9Kl5yyucDLL+eHKFJMO/WjcbOeDaf5EVuTspBBOXfkz6lRhXm/+1FRNbKfmNJWvGbBYODAnc/BhAgrNhDUORFLyAwFbNqaGRnp9cdSctUNA7VsAHgnHESAZ78nysf6QH+8V9qsTxSaQRzmffConyeavAsCTfGSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=qJQz0CPs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="qJQz0CPs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so37729045e9.1
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1724072670; x=1724677470; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0q7LUcKKVTgxdpr8vjwYxLdRxCnhdSlwF4/mUSsGME=;
        b=qJQz0CPscSjp97/Hil0ziUcuo+yp2pViPcSbehnCxWCyOfQa+jl2hshpcA19a2KBQX
         A6YiS6birsIfv7sQNTLEVdG6apJUqw+AMdR4qlUg7dWMQQGDebD39BCAdvDf946I8Txk
         xJtMEyI9y2gF10bzhs/f/boO0b6P/XzgrymCwVvHnkWJKUwVlCgiPZP+MKAOo0IyLfOW
         EPstG9i8A4RUruUVzgBqVrkP9YZew+U8+RyFDl4OSdCLc5LJ/Yb364yTOMEb9qZGxnD2
         jrgr2Whdn4hddMj4FY3krKtt9tiCiCiARThJiLJEIew8gtac3GhWODznRQC3ezH7+0kL
         k+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072670; x=1724677470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0q7LUcKKVTgxdpr8vjwYxLdRxCnhdSlwF4/mUSsGME=;
        b=DkugU1dgg1kQob7B31vASZLjBxeroItWsXqiUyUm8YpE8/N+MJc8GpK3tZjjJ2Qx15
         5JUiVuTmqtW7kDCkRSeiyU+HHDZWCOmsa/QdTFlyhBR7mZTtCg5hbnMduTSq2UU/K4ir
         Ok3flhYfR9y/2GPjbfa/DT1eQjLtJXo/YJbnKZ3dxA0YIFF8ZL1+vWgCZHAmNb5Kt22M
         20V2Iun3iNqYwB0oNJ0oEZm1UX7M/8QqCA51Q70CT5xgCtLM926HC/nj0w9cvqsxeo1q
         e4XPXr+Ec1vamuHMm7tk04AhOq9H91emqAxskKlSOJsBpS92VeDe7PAqPAIk59MOiPtl
         36lg==
X-Gm-Message-State: AOJu0YxaEYCGEBPkmb0vBDUyMWHnG3evVUabY/qnywcAG+r2zdJCaT34
	Iyc6sNwDn/+i4iM0AXsYgLjNhrm8SGpoWtn/L2F511mkHLg3OWSJCmjVaWjkFyo=
X-Google-Smtp-Source: AGHT+IGcco8Uu1B03BDNK+9I1i3zqOW3bHDc2syatTmIlBY0tq167mhZ/tsqdcQ13lZ+5LzGYNYw8Q==
X-Received: by 2002:a05:600c:3509:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-429ed7b8860mr78913165e9.21.1724072669628;
        Mon, 19 Aug 2024 06:04:29 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded29fcfsm165221705e9.20.2024.08.19.06.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:04:29 -0700 (PDT)
Message-ID: <bb3a8513-8ee2-4532-84e3-0f1de5e6ae96@freebox.fr>
Date: Mon, 19 Aug 2024 15:04:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Work around reserved SMMU context bank on msm8998
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <20240819-smmu-v1-0-bce6e4738825@freebox.fr>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <20240819-smmu-v1-0-bce6e4738825@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

PLEASE NOTE: b4 spazzed out, this is v2.

On 19/08/2024 14:59, Marc Gonzalez wrote:

> On qcom msm8998, writing to the last context bank of lpass_q6_smmu
> (base address 0x05100000) produces a system freeze & reboot.
> 
> The hardware/hypervisor reports 13 context banks for the LPASS SMMU
> on msm8998, but only the first 12 are accessible...
> Override the number of context banks
> 
> [    2.546101] arm-smmu 5100000.iommu: probing hardware configuration...
> [    2.552439] arm-smmu 5100000.iommu: SMMUv2 with:
> [    2.558945] arm-smmu 5100000.iommu: 	stage 1 translation
> [    2.563627] arm-smmu 5100000.iommu: 	address translation ops
> [    2.568923] arm-smmu 5100000.iommu: 	non-coherent table walk
> [    2.574566] arm-smmu 5100000.iommu: 	(IDR0.CTTW overridden by FW configuration)
> [    2.580220] arm-smmu 5100000.iommu: 	stream matching with 12 register groups
> [    2.587263] arm-smmu 5100000.iommu: 	13 context banks (0 stage-2 only)
> [    2.614447] arm-smmu 5100000.iommu: 	Supported page sizes: 0x63315000
> [    2.621358] arm-smmu 5100000.iommu: 	Stage-1: 36-bit VA -> 36-bit IPA
> [    2.627772] arm-smmu 5100000.iommu: 	preserved 0 boot mappings
> 
> Specifically, here:
> 
> 	qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
> 	arm_smmu_cb_write(smmu, qsmmu->bypass_cbndx, ARM_SMMU_CB_SCTLR, 0);
> 
> and here:
> 
> 	arm_smmu_write_context_bank(smmu, i);
> 	arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
> 
> It is likely that FW reserves the last context bank for its own use,
> thus a simple work-around would be: DON'T USE IT in Linux.
> 
> For reference, the lpass_q6_smmu node looks like this:
> 
> 	lpass_q6_smmu: iommu@5100000 {
> 		compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
> 		reg = <0x05100000 0x40000>;
> 		clocks = <&gcc HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
> 		clock-names = "iface";
> 
> 		#global-interrupts = <0>;
> 		#iommu-cells = <1>;
> 		interrupts =
> 			<GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> 			<GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> 
> 		power-domains = <&gcc LPASS_ADSP_GDSC>;
> 		status = "disabled";
> 	};
> 
> Changes in v2:
> - Use the compatible prop instead of a specific prop to trigger work-around (Bjorn & Caleb)
> - Add qcom,msm8998-lpass-smmu compatible string
> - Link to v1: https://lore.kernel.org/r/20240814-smmu-v1-0-3d6c27027d5b@freebox.fr
> 
> ---
> Marc Gonzalez (2):
>       iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux
>       arm64: dts: qcom: msm8998: add qcom,msm8998-lpass-smmu compatible
> 
>  arch/arm64/boot/dts/qcom/msm8998.dtsi      | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> ---
> base-commit: edb6307a8d9be5052ba5ce121e0bd55900ce44c4
> change-id: 20240814-smmu-d572c1a16aac

