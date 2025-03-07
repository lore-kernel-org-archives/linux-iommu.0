Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA107192D76
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326592; cv=none; b=QQrm5ONEJyiYdskSoPOIwXf61Kserm6kYUjgKtT2gwKYm2H6RgTXXMr7g+ayvtPPiibJLTrDGFlTekqeSCbSjF7GeTwfc9ajJW2XPt0RMWcxCLQVc4e8MjmvZhWCQ8Vuv2PQHS4eL7zENEwEhbWkLo+qFM8lNn1qhTBu6PhUfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326592; c=relaxed/simple;
	bh=jmPY4fuI4EYqhmDWogqXXGjUVpVNhWMCq4sELYHNKNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMrb/0dQBY12flAxeMTIT/GnvMAnkbk/ohnGWo4OdP4Ry1csevglIIjTrl0nb5o2RadOa70Kym1rouyrBFWUtlre7uMAdvLYyxfp3Wt7fPKVOqYNNPjGrAcRb+0PoKTlTWOuOY1Fy3AMekKphy3HJHetTGZzphwVN/An4yQ39lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xefM6rzG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xefM6rzG"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5498fd0bce9so868453e87.3
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326589; x=1741931389; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jN6ZIl4heduOl3aV1Xlhy1GPaNYpaPeTUI2tGOU7POw=;
        b=xefM6rzG2hx7MUCVWvt3dJ+ENLPA7yOzjbrYtdE7+kfDVmxLbuESFGZ2hjwOa0G2S5
         2mIwKAus7hk11fMhdXm1tH1pn0nAriRhDeEDsZC3Kh7rhJ4cIe+Scy3LYsM+yk6BNkj2
         bOGLwJeTBOrxEiXabTCWD2stUYkJwJ9Fq4MkIgjxZvmXd5tcgN9H7/o+ixoCOHb8YQmP
         OadPIf77hlqYz6JDBhxcsDrU8XYDPznJS42QTrgH+dy42PlALL75dKx7qyFI74x0Tj+5
         soiKHokC7Lq4jNkY/lFjd9ES1jnoA7dqtQV8EgBfkHXHB1AmPbMhgce2rsVVtlcGq33A
         cQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326589; x=1741931389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN6ZIl4heduOl3aV1Xlhy1GPaNYpaPeTUI2tGOU7POw=;
        b=GdM6CyFsLC0vSaIIBhGP1tO/Gb3EWShift0p4lYl4eVGDy+uYSiEmcGgbMULwjh84t
         CEVNDdGJQENpLbk7mUbmJJuxl7/Zri9L5YKC1eWhVak4tJWSFtVxdnTn/uaR58taTxf3
         Dy24fej0WMSjvADZJ1+X1oGCF1Q5vpq7KfZ3MVuiJzhW54n/7NjCloOW6R/g/NLA4sCY
         Sa6E7JGKgXaOpa/BFdgH9TTLX44sskglT6dyUZdTo/xYVQkxWKoK9Wc6/VbxJLW/fZns
         0VCGGBnZ3RMnogqU1FgkVB07fk0PDjeRw+buX/KFxdSsfCjEnZzZ6SmUMZbU3WeiKR4V
         fEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHDE7udisQs/b954Gujydp9rnme6UXiuBCttAmrkwUCtpZtcKdESwNflkZVjYprufI1KGB1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjNBWLjGIUMs7NpjktLB6tBqAEtlE/WwRvgofQmqzw7OoJemYH
	moaEcLAthhxRLpZWtiSpWwQKKshxZ7LudJIRvDSLfY5OrHoSI8McncXRfH1vNcU=
X-Gm-Gg: ASbGncuuHeNxe0ul6Dz3T12P9757Hz4PXOvE8FhXLKraxHCG+cU07X868gnRFivteQ5
	hGkaEqmLhH/AtZ3i3C2wF+AnPyoaHXBx3WMo7Qm6IyuYHYfRJbYSYbPA2kf4a5IRIkvMJCJOsVg
	lxo5LRI6oiKiY5vxx22pITMYma5d50g1xo4cu3asY/HzHVBixcj40CFzZ758uC69JDBx3AgTDMs
	yQYxxN59fx6pCH4qhigCuUb9BaQYuseOSZoOnUWSVkG9jLfSGtEtg6LCbb/zqOddKqyO2bQ7Oim
	UhzNi0US6ZY5gbPPn1wY1CurwaRNFX8gkijXYc7pcz7pWka++/2yYKCufc+PoYCJpbNtwuulw3Z
	z9oJMzfqyO8voIXElXJdY6tNq
X-Google-Smtp-Source: AGHT+IGP9JChyCLN8oP+7KejrIg47v5OBKkR88FiJPVHk9F4HcqJxHQhiZKSP3fE87nRAiAkngPRQA==
X-Received: by 2002:a05:6512:2804:b0:545:2871:7cd5 with SMTP id 2adb3069b0e04-54990e3ed57mr611055e87.15.1741326588773;
        Thu, 06 Mar 2025 21:49:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1b2d66sm382417e87.153.2025.03.06.21.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:49:47 -0800 (PST)
Date: Fri, 7 Mar 2025 07:49:44 +0200
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
Subject: Re: [PATCH 10/11] arm64: dts: qcom: x1e80100-romulus: Drop
 clock-names from PS8830
Message-ID: <737cuybby2fsp5hl2c75q4dajax2keymfe7ka4w2b7omw5b4yx@elprmcldts5r>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-10-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-10-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:22PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The preemptively-merged node contains a property absent from the final
> bindings. Remove it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 

Fixes: b16ee3d0cda4 ("arm64: dts: qcom: x1e80100-romulus: Set up PS8830s")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
