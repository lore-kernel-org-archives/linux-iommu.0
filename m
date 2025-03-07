Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75F1990D8
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326528; cv=none; b=UY/CLn28s1FDw3n9CRcYV5pGrQnPKP6u+V+jR24K+NxsELKQ3SGEh5TCXfFChAC4BqQ6wXhr0LZTfT8gPLqSR2nKOeVndyJ1xtKuiFU44mqdelHeX9jeMK3JgzTc5QW4qzXopvKFo9oMcxr0j947dL64rw58QlNceMiz3O0dQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326528; c=relaxed/simple;
	bh=cUQog4O11KaHxKElLDtsQfwV4T6XOOi7M0oP18SotLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTqYuJtcT0JbvUD/hOhez+IFKOllGUxRtkQyGSmoKaKOxJHoWW7KIyKHkDbnUrLPwxONSRxZAX9QP4Iv7SWzv3xDOTF+kEP87VQHopmS00GBaClzJWr/0awa9gau7v+EN6NPmhct+VSYiRVh/cy1os5zi2IK21Upi3rYW3WfIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3IhWhjG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3IhWhjG"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30beef77634so6080121fa.3
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326525; x=1741931325; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZbBg036E5VQfq22pHnXrnX07SBhbwakhgnYEPNM1oo=;
        b=g3IhWhjGCS4fwVMG0ROH+Pf/0dGlP7KEVBrdici4OFU9JpLndSlAcrOf5Q5gf70SSe
         K16TgNLG05LgW98Ot+NW8hhXOCvVEU7SpGSMlGInBJwoJz0sJlQpGIjGe4AeR/Hpm+md
         Rqn02iIBTJoQ0+IxqNKKJ3B7cxmJrRFZcTwqvqQ1NpZ8c28utKoLKacxAi+kF5gvrAay
         7l/x8Hj4CjPYeYymSv5aI5S5nOvV0GKP3SEtTsbMdLBDrQQETLZM0Qy+mwtf7+QpLT1m
         2FJCGZ5AxyDood2x3PplgES7h7dQHhxPOiAQmjtz1k753CKFCY0J8wn1H/Gtx1Ey38P+
         fqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326525; x=1741931325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZbBg036E5VQfq22pHnXrnX07SBhbwakhgnYEPNM1oo=;
        b=wa9nocXD06GrvTcUSmwPKdK7ObSKv05TShO1CWCeDdqBbYsxuwNkIpJxfvM12pYlsQ
         434Vh53BqU7HoCq+/X2PGlHmOA6lFFRElKldPJOm6o4trOtWC0OgbTFb6cVG+dT2H/8x
         Ty/bRXgtvdoZoi00QazWPvPINWYMSjKkrx7semCek5cwI70rxzheVk1FnMp/ObCuBJe6
         WliwoRPGXNVXujZKpBU/7pi/aiSGb/zEhIiXA1slu+yXt0EluWlUcz4OtAMUGt1QVbpn
         hOYnHJabyZSmUn6WGbMtPVqohNrbGGrw0zOXXpOjpLfRuPwHNyoqtRu2CPctaG+O/bQG
         12cg==
X-Forwarded-Encrypted: i=1; AJvYcCXrybbXf+qfHc6v7f4mo4mN0m7JAAH9VDsS2gVkkxsaWn2vSRABrJSGeDHT7df0/TP8BRyxpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwISL2LDKVu7SrYDaaiTy3Pb3HDaULQojCF3damWZN+w2sALLUX
	0t5lx7y0PHL41tNkccLLWjGfPFRajhZXNFLY3SilFQVTx8+F7HfO+jWBjU8eLaA=
X-Gm-Gg: ASbGncs6rnIl9Z+TXkPLn1BtGT9pUdEIVdWKtfTqcaD8aqSj0PQtmlB/aqfNdAMzClu
	znPmnUNHFlA3eOk5IHt47aCUguTzoOC9DpxL38LrCbS6hzASvL1ZY42ssZmF/FZOIX2m8887+6Y
	Qm/5PLUxwLtXy98DzPgSOLoUqs7qFmQdeFJOD6wlz2nHAU3E8T/MirwQKQE1GfcX6C+sW1e5YQ+
	Y7zJqFeJAmf1Aw2I5mS0vHIiALHjLXq6Srj2a82qAec2TIZdIoi7Tyju1HsKPaqiiFriuyMZaH8
	J/xQcEudOAIoZs4eXmcvK1MxGgC8T3XWpzpHNx3KohERRmKvJLEps7H/H95TJbNXgV8EvEs0V8H
	Jm4I8/3kM3h7o1Rx8dNet7mkg
X-Google-Smtp-Source: AGHT+IHcVDS5X+VsoNTfLbd5EGvMqQkC6bXB00OiXoktlobfZRVvgZG5xWYx/7vdkvXRicvu3Fer6Q==
X-Received: by 2002:a05:6512:12c3:b0:545:17d:f96b with SMTP id 2adb3069b0e04-54990e5d38amr514102e87.14.1741326525147;
        Thu, 06 Mar 2025 21:48:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ff85e23sm181305e87.225.2025.03.06.21.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:48:43 -0800 (PST)
Date: Fri, 7 Mar 2025 07:48:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Robert Foss <rfoss@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rohit Agarwal <quic_rohiagar@quicinc.com>, 
	Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 07/11] arm64: dts: qcom: qcs615: Rename AOSS_QMP to
 power-management
Message-ID: <f5xqdwj7v4zpwlpkshfnofth6u5pyu4tkzlmr23laspv7q3wmx@ebsugcqok66a>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-7-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-7-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:19PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The node is currently named power-controller, which requires the device
> underneath is a power domain provider. Rename it to align with other
> SoCs and resolve this sort of warnings:
> 
> power-controller@c300000: '#power-domain-cells' is a required property
> 
> Fixes: 0775021783b5 ("arm64: dts: qcom: qcs615: add AOSS_QMP node")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
