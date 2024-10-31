Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4FA1C3F02
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396836; cv=none; b=cadYR5ZuUX5k9uNoJpd6dBxJbFEqfPgzgRy05xwBQGa19t2yihejWJBj5A23BKO1e2FvSjZlm+3IRyuqsPMtS26uwtYaBH6aaaGLgld7ulzFb1Gpbq4ul039p/QX8zKKY+U8Y3M/3xnquynw400PO2Sjky6iwzZhG+8KZB1RXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396836; c=relaxed/simple;
	bh=etimWnUfHOZ0ie66fb4DurfrF26rdEKMghR+1nBtEh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJRCxcUuQURn6/ww4FMK9bYg5x3Ou0QkptX/RIaXrC+lNX56K6/1LANyt8BClHNXIoweItzj2q1sFFdrDYsJ5Hg1q03Lk0jF7oUUxf/WfWn2aPTp1u2Kj/4fC8rZYsNA0VkcxTBrUks68gWCs7Ph27OevdZ2jqw068B4MGDeNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bxAJLPBN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxAJLPBN"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53c78ebe580so1316044e87.1
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730396832; x=1731001632; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icT0Jwpo8GGddZPXkZjIKzOMTai62xp7VfV8yD5nylk=;
        b=bxAJLPBNls/DuGr6wrorHyH8AiSCGkAXgic7WYjsAAWe76bXe5FZAWltiH+kNvBtrj
         4qSzH1cEah5hTDhsyNyeCm5FoJHPQkpya6rrhsjr6/tM4Mb8g4WvIXH1NTvENhiCZfoe
         b6evofHXt1YZ9Zu21vA+4x8Ki2GHXut+xeX2bGLmuw2qEMHNpv9TJzmnA/wxjLfdqssk
         XoAUEDRbWMJ52QhXuvpym+iCkpFuhd73XrhrrW/R9XDCruXFmmWJj1dIh2/NcDV4m9rq
         9ZSO0VcsDUz4YKENMvgWARUk2bA/prdUr1A7FHXoGHANYGKN1oUecEHBAar2Arkr5k7Y
         BqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396832; x=1731001632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icT0Jwpo8GGddZPXkZjIKzOMTai62xp7VfV8yD5nylk=;
        b=gngKSXNVmjQDu8J0EH8yPeTJ90uaTTPBqTFi4dlAf+1hfQSzSDPDLjYzXS44lN38c/
         NDm4f2neWlbg+0W8POlgAD81n3nKzgU1uAes7omXgh0sRd1d3GYb73SYBElWvgKV8aM7
         LOfCq30q/z0l9MUFdV/3XKACd/uWf732EhKn03LQ8CiiSt0PfZOFh8nSBs7QGcd+RKo2
         kMOfqYOhSHwIQHqo57YkBouyFVvdmRccXkHWoWN7vmskXUW9+ju3Co0Q4uukOhV62m32
         wlJjlOrZRvTRiKkk9dDtwBbjAZSrvuQfErwNtk7EEMULimXnvIhAThk1FyB0Gvk6gnTp
         j7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVYL7ub82igmd9O1w82WU0UZlNoB/Nc6RuPgBuC3IE/txywgaHDrQBxG9o1N90S/Q63VMejaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqULnLRmmWegjP/rHoD86QmOr0RDWJTgIKilPf7uw1WMHIqlQe
	7eg3GsVeVg7tXl2i8EpuupWv6QuBv5HOeMOH1ystXkdFVrxhhPT9L3cVlXx+8mQ=
X-Google-Smtp-Source: AGHT+IEjo7YeCGMc9+HFLWiOPZE+phU9MZtgtYpYPR3hQQmX7N1+hAOUoR8z5B0maKvphxFM4B9a5A==
X-Received: by 2002:a05:6512:3f12:b0:539:fd1b:bb0c with SMTP id 2adb3069b0e04-53d65d96dcfmr304797e87.11.1730396831927;
        Thu, 31 Oct 2024 10:47:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c133sm280042e87.100.2024.10.31.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:47:11 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:47:09 +0200
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
Subject: Re: [PATCH v2 04/15] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
Message-ID: <ucmcr4pbmmgkuaxvrky5376jtsxu5zejuo6tp3z5l4zbm43hok@a6fzyhvjxhaz>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:45AM +0100, Barnabás Czémán wrote:
> The PM8937 provides 4 MPPs.
> Add a compatible to support them.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
