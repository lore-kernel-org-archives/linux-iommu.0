Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368321B5EC4
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882301; cv=none; b=RsoI9A6/mRuR87jCC1Huk6jcy8fjttSoQ51AUeYriCqO0+64uzVtn2KsN13QyzW6oNnEtrWbzzZRSsLtTmTLi9kqiDFbSPeIXDSxcDK+0zJ+9ACVe1fAzLFCV7biZWen6ulN+ccMBMMN7i9fQE/HwWBpsr2UFQ25d9wYb5X4UXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882301; c=relaxed/simple;
	bh=1XtdwS1BuwHLaOGGl2Ezr7HD5CSRgpRjz3svsCD0J4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg2qnhW7+bxTU2FIkn65uUg/yLmgjSdzsXaB1nGoSZjUDp7FTjDiPzoiBDfzDf8QP14ZpkGLaJl1/4kjz0ad16MriaugRUNAaAtYkhn5qTsmhz6PrcOglfGD1UC2Nmmn1ZoTq9MgSoaPZeDnrRxMSMaaYSm75/KOgv/j8bmLPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzLs8oEZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzLs8oEZ"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b47ff8a59aso40835437b3.2
        for <iommu@lists.linux.dev>; Mon, 09 Sep 2024 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725882298; x=1726487098; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHMp7t8px+6AxUX4EfGUZ1CrgCIutR7qR3goerY320s=;
        b=vzLs8oEZByJNM4GsHvne0ti3FX+2l7LOU8e7+viKG9496Ld5mqLccwDOfwtj23u4BW
         Mwwf+7AXec3ou8h7GI8+9AvhOVWY0YDlFRk738D/48ectKXKfHqKeiRa2oAJOxDWPaCE
         oxZSursonzWYyIxczklnWtfFioYqcIO9zTkmFoctFzKiTCHZACfU6XDWmUxX2xZMRa9u
         Sz59vLf8ixbk7NJ3vMbA+4snHwy7YInWV9sfQjyrYaM707UCfsGuc27nrIr5b3Cpi4Hb
         FExMkDkVyddtPng0iL76YPW5UAfDFo05/gZ15WsXojOfV8LzXS690HeWBnHGqj/wuj95
         z/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882298; x=1726487098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHMp7t8px+6AxUX4EfGUZ1CrgCIutR7qR3goerY320s=;
        b=kKOG8QxouA/JmeFNzK8RB0Fu0b5LsP6ccCOYPGz6MhiyC+geeJ6j/gt1jtfUy/DE20
         zvFg15TYT1WcMzKosHkl+BAP88YxCEYCdK95+9twMsD5UidhW/DFuk62OohyaBMvj65+
         pYNZkPkDmt+u6YkvFZHiQzCNmVPm4QOOQG7rLG/kJejK5R38j3ztxGZlh4mZQ+i1FoQ2
         krZvs0xpgtQRmgx0Rz0y505nAnsNEAtsK232Rzqq0vZHVSRWi5jdVYCw55wZuN3H6gVf
         mv05jsyRp6PD+YBhM2eAn6gANBP/FugQzasXaJ6PLuktUP3Xnn9RSv8cizPRT9s7jNSS
         mxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/L0IzWp3qCsMGU5euqFGoEELDbswQIwJSoRdJ8oAwdO311PcoT/XvxqZEdvII6u0v/V/gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1ebPqLpEA7z3J1LFSntSEHhK4HSkAS/jwj66NZ7ZdBFJ5E+Mr
	YyZq8EotOZnvDSpPuW2L25FZ5884pDJ8Dk/AWZ7xQKHlhsgDmye6qq7JaOSbaEGd4pQJVn88DKB
	lxnZU3D8Xso/z8rC7/Mk7aP0uZcGezlawv0Ouog==
X-Google-Smtp-Source: AGHT+IEL2EB9obdWluFvUFILah+EafTsx4pRuQJ41qUmDh0QV0Y+XJMMqLn2APcG9JQzxHLZUWbt/TqBjiz6G5VpUJ4=
X-Received: by 2002:a05:690c:5605:b0:6d3:98b1:e3bc with SMTP id
 00721157ae682-6db4516d21fmr130640627b3.32.1725882298275; Mon, 09 Sep 2024
 04:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
 <20240907-sdm660-wifi-v1-3-e316055142f8@linaro.org> <7265e8fd-0e0c-479e-b949-b374ce561386@kernel.org>
In-Reply-To: <7265e8fd-0e0c-479e-b949-b374ce561386@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 9 Sep 2024 14:44:47 +0300
Message-ID: <CAA8EJppN+fbWh4Rb41kdOLnJJ7XZ0U+GApEjQ=58HuL8LdU9BQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sda660-ifc6560: enable GPU
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 13:55, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> On 7.09.2024 8:48 PM, Dmitry Baryshkov wrote:
> > Enable Adreno GPU on the Inforce IFC6560 SBC. It requires the Zap shader
> > binary that was provided by the vendor.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
>
> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
>
> May I ask you to rename adreno_gpu to gpu for consistency
> with other DTs?

Yeah, I thought about it, but it would also require reworking existing DTs.

I'll do it.


-- 
With best wishes
Dmitry
