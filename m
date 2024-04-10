Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E615B0F2
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751233; cv=none; b=WklI4NzAin2nV1QGayKBH7QB0wfnYXWwUfh9xwzEtb3EqAk7G6CmSj+MTNGRC1TCBCq/9k9Tc9kEYQyoXcZHYYTGMiTJSFbZb50LirdoZx/icSWTW/DewLH6NPlE4+qqyvjrOOeIAI+5Z2odBv7BfA09T5WdcXIWpwlG6k5Hczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751233; c=relaxed/simple;
	bh=tPOwWBLJB1MFKLdgaiVGADweFkVnXcVDzi3Q/kHAnnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFRWLQWuejsThbyzOYJaiLF4nwIpo22MIEkZnB8ojW0UUm2ofULdemom3LTCeF0Jq1s4adW89JL6YpVnKgP7c5wQm2FtowQBeAeFSpv5NhNcTP9aKCJrw8KV3nhqcxtbek3NJNkHDBDvi5kaizqU2xvlJMy4O/ZLqQR4CTTl37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QdKl6fRu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdKl6fRu"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so82825621fa.2
        for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712751229; x=1713356029; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fg3Vvg1Xh24G2Zq6sw5q/UepOitA2ehB5IlHwOwMid8=;
        b=QdKl6fRuXKyXQAKt8FSZ/V3MbpNu+CWQJgO9vs6daROsfipDl56qr/kNY/EMqKzDnA
         EnlaQ0hdVzzoD75ljAclBfnkugN8t/4gycJeLQy1NgrlcpQr7mp7bsHF8sixYJokNA6r
         EtHqo17LA/aVnzXUFj2lTYhNYCMkSATG0puAnokN4U++6B1zSxSw29/Rw//gYYVQIoLg
         By+Btg2AUrjjlMb1LWLPpIsQdtd2ubcLZMj0DTnRNmoICPMOUPqIuNbxaW7VODsD4XGJ
         1zJiA08MsqwS8a0WGnmmsXYor5u9495dlLvd8Qthocl9vk9BCmMmImrKlqDnQ32ScXtq
         GfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751229; x=1713356029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg3Vvg1Xh24G2Zq6sw5q/UepOitA2ehB5IlHwOwMid8=;
        b=gim+kGuYFLDhsplGuD6yHkuPcVBH7jkvuOX8qnGP3cql7afV6pMdHJ356g1Gc3TS7/
         QUgyIpmQ8zn/ZUaRUQ8QoJixr2qd17XTOGN5+i0YB9+sns3cc1bsZDzpjuPQ3jfehG/8
         RgK/khFIi5g1+lH147YvDDTbW68ekyGBCj1eiHJcEZMlegaE8ulkvhCNllK29iGal542
         u2s3QOToj9tXNGkl27p6Ipp4yYttJ/TFClTON5K9sXECQ/izX1Fx6xFtQQJDHqb+LM/e
         OvI6jrHTm1J9ERCNlVCz9gZ5LwrZXozt3D0rDZW5vShcODTWT0dkjncdic06GBE0y2CM
         jrBw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgRU+jZ1hpLSNiiky4Ji5ZrFqQv8ruPRLdRT2XxHcjCW4nRDDfY+0ddUn5fpOPl3PdvX13bS83xEriWYSKjwc5Rvp3tY=
X-Gm-Message-State: AOJu0YwISd/AXdQiMvs5OpeZMoRHZtIYIuLRtQ0ql9PhGyBDKB5/0otS
	IOw7wHhni8pzJxl9KikMdcmyinUGFN9Z0iOw+f+LwuxiCllOOUKkNvOKhIDlsmg=
X-Google-Smtp-Source: AGHT+IHOo1ulqABkUnEGstlgxKD4JbzMIdEWJXhF8DM9ulnSol2Yvi8EP7p0sUbwyjQKpLh8x3ZXsg==
X-Received: by 2002:a05:651c:198c:b0:2d8:527c:7ada with SMTP id bx12-20020a05651c198c00b002d8527c7adamr2137546ljb.38.1712751229448;
        Wed, 10 Apr 2024 05:13:49 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z17-20020a2eb531000000b002d8e5cb062esm21673ljm.113.2024.04.10.05.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:13:49 -0700 (PDT)
Message-ID: <86d349ee-9db3-4da3-93ff-6891c1c2dafa@linaro.org>
Date: Wed, 10 Apr 2024 14:13:47 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] arm64: dts: qcom: sc7280: Add DT nodes for the
 TBUs
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org,
 robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, djakov@kernel.org
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
 <20240329210638.3647523-8-quic_c_gdjako@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240329210638.3647523-8-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 22:06, Georgi Djakov wrote:
> Add the device-tree nodes for the TBUs (translation buffer units) that
> are present on the sc7280 platforms. The TBUs can be used debug the
> kernel and provide additional information when a context faults occur.
> 
> Describe all the registers, clocks, interconnects and power-domain
> resources that are needed for each of the TBUs.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---

[...]

> +		compute_dsp_0_tbu: tbu@151ed000 {

The labels are swapped between this node and the one below (the rest is ok)

> +			compatible = "qcom,sc7280-tbu";
> +			reg = <0x0 0x151ed000 0x0 0x1000>;
> +			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU1_GDSC>;
> +			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
> +		};
> +
> +		compute_dsp_1_tbu: tbu@151f1000 {
> +			compatible = "qcom,sc7280-tbu";
> +			reg = <0x0 0x151f1000 0x0 0x1000>;
> +			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			power-domains = <&gcc HLOS1_VOTE_TURING_MMU_TBU0_GDSC>;
> +			qcom,stream-id-range = <&apps_smmu 0x1400 0x400>;
> +		};

Konrad
