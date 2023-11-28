Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A957883
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vA11vKzJ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9b5e50c1fso6745131fa.0
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177452; x=1701782252; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAr4/m2ajzddsi7hfMwi2CwtuYecaq14RypvJQRLzWo=;
        b=vA11vKzJgPpMjroqvGUJryZf8/K2Wf+5+eiG7Fbsw0cnqK0/EU1QzyEqkKF7dwX6i4
         8FzIq/6yXrp2FksZTm/rGZeNFUnjy3SBjeY0ax9cVugSSUZdoGj5hRlgX7HvbKU8NVbo
         XS7xAIqoT6m76ZmrRKKW2nA0ooIHe29SD8S9dIycsLn0VtpM0Ea1uZfu+2F9P16NVquU
         Der8fkedamtzopE7XvR8fcX4bVJUO6FS3MHrqXh2EoH6oQiXKuIRPf9aAIQ4Zgxn4Fyd
         ck0uIcDZoV98fOOL++xMIlctG5S93QUyAoDs/lVQPMj7V+g1Y5oj5OwJ8pr19HHWzg54
         bXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177452; x=1701782252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAr4/m2ajzddsi7hfMwi2CwtuYecaq14RypvJQRLzWo=;
        b=GG+IH2Vii0kQkDIhUAzVi67ej+KNUhBAKkaaKSS+Fg3zOTUulgzRQVJDMMPpOm78p2
         vQxMZWQsYWN6y1NyhForjXRYzZov6XCtl2QuJs0Q8aF1dHESutESxBFEaWLhJVqmoiDl
         Y7DeW/MB6B9CJ/pOGAr6XykzFsiw5fQ49ywfsgUX4MO7w908Q9zK/jFHj+w9oSvidlWg
         zW9ql8oxM1vIQWIfXBMI3lNSAeXE6EACuirILs+pJ4kwNLxk2adoUmr1g1RC13/bihHy
         2RHPxT83svrYCPy50IqKT2RRtcKmHTuog/HvewtSzepXi+wPGlo30kyHiIDZj083tiLW
         aC/A==
X-Gm-Message-State: AOJu0YwP/WhriwOM2pA27yDX+WYM4i+XX4RH6QcfxhRY9yRfjpAb84Te
	0+ourNH1d0PcF15YyTaGVGSE0Q==
X-Google-Smtp-Source: AGHT+IGVxWPP0V55ZOwwGMT/RGUBPGkfdgvpKvOQb9OJayj/M/2NUiUPahV+CyCvHpaWlYuulUl4pw==
X-Received: by 2002:a2e:9b4d:0:b0:2c9:b4c6:a7ff with SMTP id o13-20020a2e9b4d000000b002c9b4c6a7ffmr1015094ljj.40.1701177452153;
        Tue, 28 Nov 2023 05:17:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:17:31 -0800 (PST)
Message-ID: <c0ffb1bf-9a3a-4a6e-a62c-a7777c3458a0@linaro.org>
Date: Tue, 28 Nov 2023 15:17:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] arm64: dts: qcom: qcm2290: Hook up interconnects
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
 <20231125-topic-rb1_feat-v2-9-979b28f35e4a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-9-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add interconnect provider nodes and hook up interconnects to consumer
> devices, including bwmon.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qcm2290.dtsi | 248 ++++++++++++++++++++++++++++++++++
>   1 file changed, 248 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

