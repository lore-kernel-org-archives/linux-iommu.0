Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9721105
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729343759; cv=none; b=He2ebVDol/DWrzIVMyuJiN4xcymsNedZPF/bKmrhkq8Ufs67MctPLCTmaH7w0sIBzn5C4IDzYO3Qqcn4YHzxm3iUIxzHWbPrMEfyDyNmF8QmSPHBgVox7PqzVvfGrXaGoWEMbI3k5VQaXJDGoLf8lCwGzcDdYibH+Enrt7WJKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729343759; c=relaxed/simple;
	bh=wISQD/DiPmIf9nJtmm3pdMffWiKrAmYAz8lDC5keNaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RchjaG0tZuKD5jqGLiZAYW/q7p1fIZl1CjKsE8MFvts4U4s2Sak4M+0wQwQ3rz3xyd2BsqsPT8m50+0UNzhq1owTYbbUNyz6flaP4TYd/UvqIOLWLuWDpfEETirkzp6L60Jxmgxt75hKkx36c1OGSRzdVgssbBm5wtb68bCNxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l4Uj+IBT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4Uj+IBT"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e7e73740so2800758e87.3
        for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729343754; x=1729948554; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nLoh5AgznUgCvu6vNVjF8MRQRk0OBbGWJlXddyz8ddc=;
        b=l4Uj+IBTEyNnYLJLE3KZchrFPh9hDqTD62VhrgEy/j+4idxng9vJMFSmrzWtpgNWmK
         9RX2y/QPPmJFf9MgQHwEL8sBMCOwbhEvQI15ZObxmKz37Jg1eekqppdB2EZ6AMgdiHAN
         BIf6RWGwqcGTrYh9PbaAirB1dV+HdNTCkb1LDr0X/zCJmZbBuA7QFnZNkAckQPBB3Ct7
         suev68ywRjd3E2ojtyYOhmJLbTt7vGZUUgCzI+EdxgOre43Cj76EAl2+ViHXSiKF/1EE
         bL6VWLNjHNwasQni1uaVPpg4geCvsExO/TYoXONrogCo4uROc2Yu71Lv5CkEaDX+C0VS
         UcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729343754; x=1729948554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLoh5AgznUgCvu6vNVjF8MRQRk0OBbGWJlXddyz8ddc=;
        b=OGS7GG7zavOTwBWD0j5UfxYLZ6cW9v7W8ug/V18eNFHzckhaPiRX4JnMj9c4Hpvxlw
         //QnLIpsR+j9Zd+SIUiNtV9u9YA9u1/C52iLoqVXuiJcJCE9s5V3o+fTTMSLaMO4lLbR
         2fQpi9YZxFXiuesqcwa9eIrPGDhDKpQHVoJzyMlTr6Q0p+I/VqcHKDAprLjzovc/KmwE
         7fjHPZ58130AQoJGE8/JZMRq3xkbMEVuqx4Bk8l2CYJ5umg2L8mzEg/hHfMnO7uszf4G
         hjtMm4NOx20mGBmAfhZii5Ri4tjotml+1a23LbBRuWIj/I8yVAbjVHVuNLpeCiUtA3oo
         NlVg==
X-Forwarded-Encrypted: i=1; AJvYcCUwHkUgHtQGgg1Zpm4wWibsfDT1+CI/PfOB5rMZ2oPdB9hSZYG+kll5/LT9e3UV7cr+cFjD8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTf2USygmLzKpPe6yQhs/cX6/3VrtpYqi6nukPLJits2EhxPYU
	/oXZWkolWSL0Z2ZL7Jonaxtq+9958Nj0Ytnuz1RB1r0X/6wIamtmRnrgFWn0X/w=
X-Google-Smtp-Source: AGHT+IEFu0zK/9TF3cCcvEBZ0sen2jyT+GhSIm6vpUBEVskQof02UdUG/LGmK+X/rDmb1iKrzkMzDg==
X-Received: by 2002:a05:6512:b92:b0:539:f922:bd4e with SMTP id 2adb3069b0e04-53a15219231mr3301905e87.23.1729343753896;
        Sat, 19 Oct 2024 06:15:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b90b5sm533532e87.88.2024.10.19.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:15:52 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:15:51 +0300
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
Subject: Re: [PATCH RFC 04/14] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
Message-ID: <bg66uzc7i7bsounvl3vrhweiwbtvsomrt4tfkpojd63zd2ynrn@2pk4pypken5g>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-4-f1f3ca1d88e5@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019-msm8917-v1-4-f1f3ca1d88e5@mainlining.org>

On Sat, Oct 19, 2024 at 01:50:41PM +0200, Barnabás Czémán wrote:
> The PM8937 provides 4 MPPs.
> Add a compatible to support them.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
