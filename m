Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82B1C2443
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397199; cv=none; b=SEMeLDal01jHKeuBGWvjScu2pxrUFkGBKEUwd9ZWACt9gy6q2vdU0HQcebrvVYXEYdBqtXuTuWGupO5U2sl2IakTOXllE02UwGxZEKeB0WVT7Fdg/HCZ/PciBw49KC809nrNL0702/GVGMAuUxZDKCzrmSdJijKCkTtXz/so5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397199; c=relaxed/simple;
	bh=16heonn6bCASaqUGb0FQp5zbeBvs9p0wRP4nLfuzvgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpwlvrB6MsJehm4+h0SsI8z4X9aBTCUnqPE5JClic/KhoFF441OjgMr7tsxdFLGkT0MrQllAx4Hb5wSG1UlCX+uBYUzBnodjxyLC35SG8FcbibF56IQUDHfeljb3KTZA3srZlrYbd5g1GVMcfpf28kmG929htjYrWx67wbBPdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e7W26Vlq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7W26Vlq"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so12113371fa.3
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730397195; x=1731001995; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a1fXJfoBuk9F3isji/b29JProAzLl9eviUjDe1dQzEw=;
        b=e7W26VlqYQB6mKk/8CdwKKxtHJQBjnfTRjXhJP/WmI0x4MQErr+U1tXtmsTlCP2owV
         ezcma7/8RWw8iO15kEtT0QcA9ZM9RPPsuV6DWqFYnyWFamNKvjDG22LrpjgMLYtFwpP/
         GhjHksPAfrubtoKUCJSk3sODkYl7njuxJKUkJwIrzNvXtOYpfTFcwid2/RYNhOsovdyi
         7fppBvQG79ch/ts74x8wxmWh7L98SjHY24WkpGJJ4ZQoXyQmV0prkzk1s3NYk6NrtGNx
         AfIAgj9Q9Bt+B6plK80S1eXhtPie5m1CYMRQk0r2OIdm9QWZ7MaLQ5Ns12Hz+t7BnDOm
         7K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397195; x=1731001995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1fXJfoBuk9F3isji/b29JProAzLl9eviUjDe1dQzEw=;
        b=XOi5atlkZQ3VXltJCEeOzgtQAUbMi18cxd3ApKRhLnoradoajHGEHIhwXsAYmKKZO5
         XQVr+3rWbsTC/9MVgmVIl68DN2D5Ct0jvkwp9kWJD2s3Ssyjxx/S241nc4pfFEEfwszb
         zI+tze2TQRuZdYxLJqPazDDgaszM5dPctNUEIdwj3lDax+LWnIbzWu26Tj9Z81cXVsnr
         i9gdL21YqRwnJGmeLu8Yeq1TarL3Ym/d0qNlQG2HpjfkFMmfPSKCUFfOY7FE2TacItTm
         rogK5bQ3ct9KBxGTurC8RwOCMLbeVjxVRTFJ0VIZ8gjMJtRQVeXOUyt/JAZOI6Sa/26/
         6r3w==
X-Forwarded-Encrypted: i=1; AJvYcCUvCXFZ5wfT+4Qx32vppB2Y3jLsgjSNfc3YaU2VFIsKc9G10C7UnOF/vcDXRAMJzY0cF/a2iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyp91vM8AnCP+o/slLk7mfFOWEjGJz9VZm5K1kINdfgNkadgLF
	JhsHjeiIBo9cVGc0/wO2VWlIIlophHLSpm/GEERgr0Rcz9S6QtuQDl56KSJ4n/Q=
X-Google-Smtp-Source: AGHT+IFk+AxdkKYlXoXc02MYAfV8BR2Zt3Gl084Fy5JnF8f0wBqkE9kj0nXJrHlcrTNrRoRUVok2sQ==
X-Received: by 2002:a05:651c:210a:b0:2fb:266b:e3b2 with SMTP id 38308e7fff4ca-2fdecc3051dmr24108801fa.36.1730397195143;
        Thu, 31 Oct 2024 10:53:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3bbea1sm2883421fa.24.2024.10.31.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:53:13 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:53:11 +0200
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
Subject: Re: [PATCH v2 10/15] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
Message-ID: <dtmmxkolciktgedsrddp2m6fvd4v5mobtg3tq7bq3564buxitj@7vphzljzey36>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-10-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-msm8917-v2-10-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:51AM +0100, Barnabás Czémán wrote:
> Add support for tsens v1.4 block what can be found in
> MSM8937 and MSM8917.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 13 +++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
