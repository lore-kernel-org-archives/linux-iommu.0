Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302A12D1EA
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396822; cv=none; b=qMsvWzpbADQKKieWOjR0zncmOzB2uYvYayokjy4AKEuFLm/lFUA3Zp0eLHgGg5pz1XEtW+jTiKFh05u6v0Mo80sjszLM90TdG6KfBe+kY7n0wNzVcJgdizbdz5wVwYEJnuoIzyLE4Hrba2+d5AkXvk2RA5j+ONt9+JVDq4TYcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396822; c=relaxed/simple;
	bh=kNW5YJKFKEbItLM4uYNbuJvwCmMv78DkIkndczxT8eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvGDJMmtRW8qow44w8KKy+deLtljeeuVVpsuvX/p41dFllNu8HqaMNMpLZYbS9hbg5dgfJVQO3PPWxAUF7o6n3RQ/YT3stbW3Fo2iQIWORWPsRxHTkY0xnZkv0W6epYAtbpmpkCrDLOf4TkXhj2pv30DJPzpP8eBNeZwrj03QOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHa54wwE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHa54wwE"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1332465e87.3
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730396817; x=1731001617; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JYVW0G4jKWF/vesRuHI0K2kAx4zvmynSz5/bDZbMrwU=;
        b=qHa54wwEO5mXgf+DIfZK8vrbc9e2UU/IYJCSrxsNTSrtwcO7h5udzsMcyqvlkiY8WL
         EtoDDkh3hmYfDIkSruVtlTlcu2EDuMWCiF+zaUHt7/NMgQSdbl19t5ENycNIZbHPSHep
         7VoUsNwFlj5O7VaB2a0M3doYckfMiKU0AOIb1Avk9gCx2nWJvSu3KvahCnKSq06Pvn3T
         7YjN3aeCMSHJ9W1KRJKfzCQnr6FBwPGacvVaK0OXagAv2x2k2qOWG+XWSocB+1xdcjvH
         UVRdH5nFnOC0GfB09QmmDE5vaRlbO1jXZjqtnTSPNDLt4rWVpAaBXl8jADikTsRArk08
         HNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396817; x=1731001617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYVW0G4jKWF/vesRuHI0K2kAx4zvmynSz5/bDZbMrwU=;
        b=BB7DPrlyqsoM5O8g//5lHKRgOUAUcJZcu0fqOkhXTaeBM3Mb71k8ay1M1S/YdWOHDQ
         YL9pWhRBe4HUqqEBvqe5lnSlViGJFZ2sOd8TGSFBMIYKDmeaTIiEQ1O6n6TQC0QMMw7U
         KGMm8UIh7X3+15yLNvyfUKWTcoyTSD0MViItgXglpEyeBVONadm1ztJ9NVMmnewNWQYN
         1Dg+//UhrFzDP1ayUj6VfixW+8llUCplCMEhzJIWt9DD+rlbTCXUG9dEZeaNXdPrNkGj
         dc4LMbOb4WuGeqUkOsqcnKGAJTFqeGPXgzUy9mpRsGskdUkp11u//ec1+08dEEjlJwTy
         vhLA==
X-Forwarded-Encrypted: i=1; AJvYcCWEqdyIQNbaFqh4h/vnjnH5uU5VppgtPtZIZEqaxRCRPhjW9SOYsqG/svHxyz05oOJA3WGeFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYj+Ws7zDGfagmb1w+/rNALhuoC/Vl93pYf1MRfQc2NWZhmHEO
	P20qHKFnIfYybnbKSjY9CwTQJqcpvXiztLCGvLy7CFS5zhpQFQy5e0GL3v3q9uY=
X-Google-Smtp-Source: AGHT+IGyTeyeKwDRjDrsk0Wsj/rqtfm7DMEl1ilUZ4Hdph3NUKV99MLV9W0IhpqFsz6uKU4pSSuJcg==
X-Received: by 2002:a05:6512:33d1:b0:539:f705:dbb3 with SMTP id 2adb3069b0e04-53b348cf8f2mr10764252e87.23.1730396816837;
        Thu, 31 Oct 2024 10:46:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdccb0asm272005e87.226.2024.10.31.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:46:55 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:46:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 02/15] pinctrl: qcom-pmic-gpio: add support for PM8937
Message-ID: <qavxo7hx6zl77vzyfv7tht6gsayijredceaelh5qbb7rqjk7z6@6hghlu3bxg4u>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-2-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-msm8917-v2-2-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:43AM +0100, Barnabás Czémán wrote:
> PM8937 has 8 GPIO-s with holes on GPIO3, GPIO4 and GPIO6.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
