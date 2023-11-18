Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48C1097D
	for <iommu@lists.linux.dev>; Sat, 18 Nov 2023 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLxlbstA"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso2084029f8f.2
        for <iommu@lists.linux.dev>; Sat, 18 Nov 2023 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700306474; x=1700911274; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPUyKTXXSta6O2fovS/Sd+lPKUPKukl6VDR0zfaqpOc=;
        b=LLxlbstA4ERUkerd9dMAC8dcvM3INtdSwWn8HbD63RahWtvG5wcWdDBQUqMzeKGptT
         4c0huOD3WgaCZOwLIcqiYRkbhRZUDptzR1JBXPTC6l/6JHE85ghNqq850PZa+J1CjYGt
         E7+NZbqWZ6BgOr+AN3owLyJJWHEphxAgMLWxZn3haEERBRQFp0QuuH/3DqUvKYJ+M7T4
         sIoGOOelTlRLPbbYoR1AuQw/pmbeu5c/cR1PqPWQf90CJQTP2vr1IWvr8G4bNF7/oVYL
         ItrsDq25wPZhd8B1IQ0gkEdXHuRnO6YFVcZPfZYCf/j+8FZefkX+/LDVa4VQJPg7lJ+Q
         Lg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700306474; x=1700911274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPUyKTXXSta6O2fovS/Sd+lPKUPKukl6VDR0zfaqpOc=;
        b=LNMgkQezmQ/RRFI4cEczepLGDDgbCe//a/zVZXDI0LHkI38L/UKmQ9yfvDGjIf8JJ2
         n+ED/MDdoHNeYGmPx8V3QCyKbsjhvKBUma1DGPqlI6yo4mspk1MPn1X8ZXLLv81HuSBy
         1YQnLuX30UBS8uEHh948JeN6i85vonKlhKeD4myCcyU7SaGhBPNHR6MwQ7eNQCcJ+X88
         2V7m3McIiYZJRfVWhNm22JzJz5zQJ3vG0zvYq9Qn9YPagAi1VXtJHIFcwAiM8sRMs4G4
         JfSIIhfgO8Uz9FIKbT7fQd35yLHPBooD9DjRaWQPl0vZ5rvdGZT6lprQcd5A8AR2fohm
         lGNg==
X-Gm-Message-State: AOJu0Ywdrt5Kulw0PVNgMIm6k2Lz2CBrhH8sd1FpTJwoRvEDWiUFHyH5
	6MzlQPPhNSZl5Qj37uyEGSbBFA==
X-Google-Smtp-Source: AGHT+IGlRDKm9rqnOd1dR8K6pxIjfQMraB1ziQN/o0o+0J4lvPN9D0qU3XUhj/DS3Uy0+DQDIsEarA==
X-Received: by 2002:a5d:64ee:0:b0:32d:aa56:c0c7 with SMTP id g14-20020a5d64ee000000b0032daa56c0c7mr1242475wri.54.1700306473449;
        Sat, 18 Nov 2023 03:21:13 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d68c6000000b0032fdcbfb093sm5109586wrw.81.2023.11.18.03.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:21:12 -0800 (PST)
Message-ID: <fe74b1ab-078d-4c53-9133-cf7ab00a656d@linaro.org>
Date: Sat, 18 Nov 2023 11:21:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add support for Translation Buffer Units
Content-Language: en-US
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org
Cc: devicetree@vger.kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
 djakov@kernel.org
References: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2023 04:27, Georgi Djakov wrote:
> The TCUs (Translation Control Units) and TBUs (Translation Buffer
> Units) are key components of the MMU-500. Multiple TBUs are connected
> to a single TCU over an interconnect. Each TBU contains a TLB that
> caches page tables. The MMU-500 implements a TBU for each connected
> master, and the TBU is designed, so that it is local to the master.
> 
> The Qualcomm SDM845 platform has an implementation of the SMMU-500,
> that has multiple TBUs. A DT schema is added to describe the resources
> for each TBU (register space, power-domains, interconnects and clocks).
> 
> The TBU driver will manage the resources and allow the system to
> operate the TBUs during a context fault to obtain details by doing
> s1 inv, software + hardware page table walks etc. This is implemented
> with ATOS/eCATs as the ATS feature is not supported. Being able to
> query the TBUs is useful for debugging various hardware/software
> issues on these platforms.
> 
> v2:
> - Improve DT binding description, add full example. (Konrad)
> - Drop Qcom specific stuff from the generic binding. (Rob)
> - Unconditionally try to populate subnodes. (Konrad)
> - Improve TBU driver commit text, remove memory barriers. (Bjorn)
> - Move TBU stuff into separate file. Make the driver builtin.
> - TODO: Evaluate whether to keep TBU support as a separate driver
>    or just instantiate things from qcom_smmu_impl_init()
> 
> v1: https://lore.kernel.org/r/20231019021923.13939-1-quic_c_gdjako@quicinc.com

What is your suggested way to test this series ?

---
bod

