Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA086193084
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326546; cv=none; b=tihcPwBRLT0uHhEInMK0Z0olo4ToOts5aDbkm64broXyWLRsA3heNT9h3qPRuOl8yF4Ly+saGzTVG4C8al/uIsOjkSCXI3PXHeqy1N3v6v9N+BszXf9GmhypTJRrxp2fG1nPcXj540L904iGDGBQNKBusYXdy565YWMR+3+tc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326546; c=relaxed/simple;
	bh=cqj6ewJym1miHgUZm8iH3RiovqQFuy/3bRNULbbMasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj6wbxzBBuYg1ZdFEVJobDx+0qmjcAM8lNn/sYBYJnDMa4XnNJKuiVQDRcCjNpJ00osft3VEN37gGH/EVwn9LRqK3HcuEVfJYta/43yldRPauGS5VRMuUfUQygetKkxc+7xx9AKGUUl+jjRQ25ZSL9o0hpIAi/QXh/Sd+a5ih3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euwuHBYV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euwuHBYV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fcfso16154631fa.0
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326542; x=1741931342; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddZoIefzqan5unLa1d6QbkepNMobkeXSFMsHFbEyBPg=;
        b=euwuHBYV6U1lDGT1KWVR466oJ8bskQkazjg3+3MHvtKI4GwtVqPHu0R0bl/n2HfGus
         A5bAOm3tqJqTSEyHvTuouMFm4UTGzyyc38GdPxVr+8N9O5+M5zZe3CEkds6W6xIU4YZA
         gCjprlKtNG+SCjXq8F3uLQOntJd8p1daSFoy9BucjVY78SSi67TqvWJ757dVcz7YILzA
         h47HZYsa99jLC6l6FEadfg84xpg9AXD3gec9GH34lSaTOhmqBGoDaZsRgMV/o7N/lW40
         596bmZQ7jyrsjQOAFha0wz/j0JsZVU3m4hWqsk83I7ZaHcz1GMd5ifTvIy1rWUP9QQto
         dSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326542; x=1741931342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddZoIefzqan5unLa1d6QbkepNMobkeXSFMsHFbEyBPg=;
        b=Iuf1XAmkna4FHQxtLf8Y0fvmSnQ64FtMnggnOIdS1ZiLHjWQrELgTOKGykqLj+/KyC
         qqW/P9r6OY55ltaTP6+misFfFvEqzRO1LIp0WkqJFmgOoDECaZh6YZr/R7b2n9ArgM28
         liQeNhPuKui8yZ+dXhXqMQF1HjI004Q92/wvGRhnheVU6A9W6TwsZoWbL2njUPNJCnLz
         9KiaOrWHK9GchJNL7jLKQ/SBCeNBUYNBqpSPyAUVlpwRq+cIoRGg18/uwsAQ0D83vMw6
         n6XHHLmizrODD6PZxsZavcdk7g4udRqVWvLvT2KZz1qL7R/DilsKA/AYOtgmcLDbtSB2
         T7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtmk9D1rre4job/zBMEHdGaita8B04/eZwwzXWFNwbBQnsoFn852aurzfCApldJ8M9Jv/tLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyR+1jbYxJeBk2g8AZKXL2oQVbkjsSE/v2prXNf/ZxL61qe+Fu
	HXkoZx7TNAb0uaqUylpIGV6+ia/HawT7GnXnO+29jS6A9GnKXH5wHemBz+YU2l8=
X-Gm-Gg: ASbGncsg7F4BOvBltWto5rmRMFtDOGzoKllZPthi72HSJPVFsNIbPh3EZz39qsKU/tG
	23Vz0gALgEMBoqIocctBQRR7uvAYz3/Jbi+CsXDXrdT+YZcKh6Bkb3jnv47x9rCbnCdnWKJ2zJ8
	HROxfId5DOq9ZqP8zbKENrgfn0paBB9btIN/69p5ZJktH7VWkx9ULAWhPIAIZ7R5DYaKpYEtdJS
	lPA9ozosav0KmtX5F1hIl/9kuDyqS2QAGJ2qihaFkGn+pUFc1aP+tnjLpfg+fDB/VHN40/cFcF0
	qIdSClL1HyWfTQUmZMSRrf1Bo1itB9sy9+hIZbnz2t2Ce3+o0M1KNSWLEfvO+QsZQP7p+K0rZqP
	Xay5K5sgThTgfC7oQgCMreFEe
X-Google-Smtp-Source: AGHT+IEQXgwPTN0zWE14o/eWd+esiKQ+JOKkgZz1V9e0jKN/Xjh/s0kS262qvqbdXkWzD17f+19+eQ==
X-Received: by 2002:a2e:b88b:0:b0:30b:cceb:1e9a with SMTP id 38308e7fff4ca-30bf451104amr5734371fa.14.1741326541966;
        Thu, 06 Mar 2025 21:49:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98ec3f5sm4209511fa.28.2025.03.06.21.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:49:00 -0800 (PST)
Date: Fri, 7 Mar 2025 07:48:58 +0200
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
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sc8180x: Rename AOSS_QMP to
 power-management
Message-ID: <6fqpulpczqnzabdnpckd2rtrcdhxryydhkuou7vdhmsftquckt@wzuoxvhyep5d>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-8-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-8-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:20PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The node is currently named power-controller, which requires the device
> underneath is a power domain provider. Rename it to align with other
> SoCs and resolve this sort of warnings:
> 
> power-controller@c310000: '#power-domain-cells' is a required property
> 
> Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
