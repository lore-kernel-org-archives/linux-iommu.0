Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3B192B81
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326644; cv=none; b=J8OwYAs1vpu4W8M5XP73ouUoWQEpGugK++W5FMf0MHnznSAu77amwtg5Am+za/6O/sCPeEefWJb9Z4lbL7y7ySL34GwBtXVb/ddK4U6TQ6DOl9tNCfzihnM05DL4FslRfDoOO+g0pFtUVCc9cNoT6/5+Us4o39F3+y3avh/TtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326644; c=relaxed/simple;
	bh=PCXKIFLp/Z1c+K3aM1Oes6w/mNnO53eiL5mUb6LZxNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STUMiYFSNcRayeu++amqQ42/uXQQKy603HpPCqa1eFfiAORBfFNcujvDtKVsp6xS+mOQG6lX1fW35TL3gQ0+KLmexHRLo/PWhB14oP0O0Ys9kVIrvO0E4I4QfSJxq9Bz35GEOzQiV1tdKwQbuYPaU7rsLkKGIJrhEArMIVvYK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jnp1au1I; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jnp1au1I"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5494bc8a526so1621101e87.0
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326640; x=1741931440; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cklowoo6XciocBvug5xE2tihHXT/6nAX/LWrS1DCIo4=;
        b=Jnp1au1ITXDSQExn7VO+IOIre9dE6rm9Vez5Kjs2LAe8tOn5H6mNDtqqVXsAFRWBfh
         wF+IQmWFyjH7ZuC0Ri3XYkMLlleTKq77R0z9Zm34DdtjVKNObZWFC2tVNot7f+ikUpIK
         VUcAFuamEZivswf5oKU86pfp1xGdr2F4cy9KXPfF2/PBqu18/sohuAlMTu0jVUlE2yR0
         dMh45IAIZleTA3r2AgPw+A1bw3YLmY6+3OzMKUR3iZg4FJkEmb7csprYJngODqTo6G1U
         QynrUpUZXpqD5hDxpN6Fcdcxv275CkMoU3ZM77XQ09DgkUP2tR/u275YZT4axqOt4gb/
         SIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326640; x=1741931440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cklowoo6XciocBvug5xE2tihHXT/6nAX/LWrS1DCIo4=;
        b=RggUQihShw2z9CpNdRGRF5C+V58ooqijTuLOlim/od9czu609SYtu5yRYUUfDZzXRw
         2WV3VIqglS7zsyNa7AM04UhQdMOPk2iqhXSj6gUnw/C1p35i3bs8NT0iljUetb0HiP2S
         cMr2M5qUWVwsfJsBD+PM2EBG3JjoJWMl+FpSHZgj3hWnrtEfgcgLxLav2Cie98SFLghT
         gVAzFjZEuP3oToqAyg7cmWQ908HtkcxuI9iABlVVjGnrtqj01JkFVot0ekFOiw7odAIR
         hlLjkt0Bffvh1PGQBQ4Ubrm25duT9pvt4ZChT5Xvnsg3Z1WcDM9CUudrlU2PlY3RSxgP
         omKw==
X-Forwarded-Encrypted: i=1; AJvYcCULXJowD0rpZqorFnXO2ds/bETRiPkw87Q3yorDzzLYszBDRdA7RztNhrE0hn7KfNx40CyvGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbBK41W3IVNHmP1Rw7Ws+IhEPP7YD25VLX6O7HwIKeAeKO2359
	pfuDu/epdyYT456WBC3ZurSUlOdqWR6z/fm/tOnZ2IVWw1Faen8zzDmkcqv6lzk=
X-Gm-Gg: ASbGncs7JEZqQka4YlAl1TIb46T3/E7tQuA9q2+qUuTHNFXdMlz8JqiZ0QyI0sE/d5J
	uL/LRam/1WoU9ohO0ky3YXVZ7LUJ+IqUPxPQZeVydP10o5x4+vxiO8ISe1ffAKHOMM1a8HoZUjT
	rjVcHSU2wM8/AGsVJVyPy3aT8nDa94dW8owutDY/zPgHMBT+ZF4kusCq14kYO3He2fZCYFSk8d0
	hw1X2o2jntpNaM6IVD0DxjhcI+EzLCniFJaxqU0UXwY3RoZJK0hekeksQcVMYzrCTUXXM0hQGRk
	ziR0PfCOjb3l0KuXZEGo+Y+/+P/GWcFiqQfc63ndohMJ0yftSkiw81dIgGEb3iQg5vn6/Wy5BAS
	o2BseQJR9ubFiP1xYG0SR39g7
X-Google-Smtp-Source: AGHT+IFxMJzgkc6aT8SLqY3HFH44f3uS0Pbx7E1LtfSoww8PpYJPAwYDmAvb6be7iccEdwfO0MQmLQ==
X-Received: by 2002:a05:6512:12c3:b0:549:8cc9:67b3 with SMTP id 2adb3069b0e04-549910b5d9fmr492625e87.42.1741326639884;
        Thu, 06 Mar 2025 21:50:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc56asm382830e87.183.2025.03.06.21.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:50:39 -0800 (PST)
Date: Fri, 7 Mar 2025 07:50:37 +0200
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
Subject: Re: [PATCH 11/11] arm64: dts: qcom: x1e001de-devkit: Drop
 clock-names from PS8830
Message-ID: <ec272btbpxlewp2qiz42c7c77gpg476wdzx23dpv7fqoe2v5fj@53vu6jgpa7xc>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-11-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-11-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:23PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The preemptively-merged node contains a property absent from the final
> bindings. Remove it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 3 ---
>  1 file changed, 3 deletions(-)
> 

Fixes: 019e1ee32fec ("arm64: dts: qcom: x1e001de-devkit: Enable external DP support")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
