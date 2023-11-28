Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195C524D6
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdXO28+j"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c8879a1570so69693961fa.1
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177476; x=1701782276; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ob6Dwe9f9aR6JR07mR40cYGUta2Fbcmoo05Dfdz/Nc0=;
        b=XdXO28+j56XS+wkbEPxF3HVY6YK9qnCxcQz6gwdmiX0/6Zb1EIReK1f95u2Nm8HAIS
         ZoMdovvysBlG8KAEkjjT9K51CQ2g6+njomB9i+lCVLLrU0V3QBr5+FmQbvWycr4oSml7
         jyu85lIQHxKr/1VGm/i6FU5A9wNzejiUpGd0omo29LhIULtUOMMsy9uj7VGlkCka1rlC
         QpdhYnrwugS6qH/apk3GSyjiv/v3GOUjX2P5zFV/U761PQ4MU3Wne2dXYl+UnRQEHOu7
         Pv6m1TKhVeG69xLr8J/easGb84kPalCJQjCT10VCmEKIU05T9THY32Hs/J89sWKPwcmd
         Ro8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177476; x=1701782276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob6Dwe9f9aR6JR07mR40cYGUta2Fbcmoo05Dfdz/Nc0=;
        b=vmN7a7vMOmWOuF7yjp7JcWIYciVtfLAL0rIZfP0jj6RH93G1CZPm95PLwMCKPxDdlN
         1euKMqoGBbzf2FZy3Z/HPr67RWbrPcY3tLhKLkey2ZkyA1cVTR9Hli6DrUDvcCIDZjlk
         Zwq/TxUbXDC2pF8/6ooyHbXlFSUYsnSyu78gATnHCGV9BnNEnWoHAFt+DGY3fvlqTvHh
         0A/mS/U5k73pzkIQUT9FkFjQeHP9uXaYpbOfL7FR5vTcAUCXlNqqdYj6PoV5+qOD8P5m
         M9USfBqWKD0uJxC5+OYxbvHaU86O5C3UlAt70Nify71ljjOHxFIKHSZc7rxU9wqxs96S
         6MVA==
X-Gm-Message-State: AOJu0YyGH8UTOZ5cWQ5T/hEXDiZf9AwEN1pUeFzzs7PHLTGEGwNDM5hW
	zeZzvEpIZNHslugpKdMTTjO5Sg==
X-Google-Smtp-Source: AGHT+IH1GIPmjgbvzy/uIw06dHH67zeJBobtku+FnhWeFT/vxlN0iIsyhl9fDbfRokKA4LPRXfdxDg==
X-Received: by 2002:a2e:b5ad:0:b0:2c9:a1f5:488d with SMTP id f13-20020a2eb5ad000000b002c9a1f5488dmr3993190ljn.24.1701177475968;
        Tue, 28 Nov 2023 05:17:55 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:17:55 -0800 (PST)
Message-ID: <e7fbb6ea-da13-4cb1-a459-99e8636bdd67@linaro.org>
Date: Tue, 28 Nov 2023 15:17:54 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] arm64: dts: qcom: qcm2290: Add display nodes
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
 <20231125-topic-rb1_feat-v2-8-979b28f35e4a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-8-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add the required nodes to support display on QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qcm2290.dtsi | 214 ++++++++++++++++++++++++++++++++++
>   1 file changed, 214 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

