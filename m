Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AB15B103
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918527; cv=none; b=Z+Chg78A2kV6dPQj+xtAEabgrEe8hPG6fA0yqfm5t39R4Lxo90NIWi+HXNO10/g/YaXFClfS28MvTT1hCei8UlnGrlSWZH+2XaGcinhLcS5Q/pqslXMfGdduU2kBoz11U8BV1iyYUxMExBgAhmhc48+KtkhxnYD8RTYWCLWim60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918527; c=relaxed/simple;
	bh=rkLpdMgiJZFVhnB8hgL0AQQ81N+bITs8qz59JOchlCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovrZ7V8S89R0k/Wgc0Ht46pK+ZdTnZ2/ajO8fLWP8rpZIKAFRXycUh7rHmIFGvRZ24TTyOXq5ME7Yn0bSPslBdFeDgfoIiYqzSBkLWv8/OtDJ5WnslkiCRrPq09E4DXBja8TAlyDXyjdSkH30z49vZz3SlXbHb0YKaFZQ+hJ5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qDAMLEpk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDAMLEpk"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec58040f39so38950031fa.2
        for <iommu@lists.linux.dev>; Tue, 02 Jul 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719918522; x=1720523322; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BetJ1UFbBIbWuWtZ702eQZdFCcSKSw0NShAWxEnl87w=;
        b=qDAMLEpkZNHAYGBlaHcLhr7gC1QZX3YnK8TasQesZ8oqYjbnrNjVhI+lmHEhaZ8V78
         x7dQit6pS+VK1Z93KfsvJRgydEsb0uBjXjL8kRFgJgin5A26DgOQCj6G13ZtALllCCS/
         HlhcPC0PGTL2kY3rJsgCS4yapblr/oWTgSHqW6op9NBy41xS8N7ZQFJS3Zoa5W+do5Kd
         n0uRvTYPJxRSTRfNUWaNfgOpjwS8Gw77PGsmQsRrWqDVe6S1rDsqCEuNVgS9LY4D8hMW
         9iy3vYTPmL8/2sIrD7nLwhoQ/r8EUbIhLNlm624Ky1D9yYbU4QOW13JOYVf+tJivR7yH
         karA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918522; x=1720523322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BetJ1UFbBIbWuWtZ702eQZdFCcSKSw0NShAWxEnl87w=;
        b=f3jd2hSc9iOC3I4Wt4RVXyLfKPYadPVWLUzvt488QlgHsc3cXOxBPbMZ7UFD2Vckky
         Y+9RrBqJ1+Gjw8BBx6TQTfP/hDjvi74vEin9hYZ5APjX2zlfAOVQk9Ae/dyI3BPLmdvC
         y9Fu4q29r4tUXlesm8PO64RcJ7II+/jZIWy2KnbiIoK6l/k8bk77m1aO4qCwOu1iLRgn
         h2akQTCMbca1HpUOappP1/V3uk6fNhgK1zzRvBQdBTSCsHumgKEPYd4Vx1geJaZUIlOa
         zyrCVphRChKX5XuBiIlBOCVsqbQZaOIsecqe0ikc6nkK1ZHUac4vffY3OMAO2lWIq6Fr
         o0sg==
X-Forwarded-Encrypted: i=1; AJvYcCXe4KWHKLPy3eqYB0iHvQKsowDrv2lpXjLTAT8yB53RHSE6jl+0oITTVakZTZPVkGTu5aqMOhObflZHirX50K2SR+My6p4=
X-Gm-Message-State: AOJu0Yye23zPbc4iUgfbE728YoLHqX7zgpabCvBBfAl1bgRYMq6IuVhX
	QJyYA930nhSae8s8qMdYEahtfrw/X+reAUYnxTg8FvylghYC7jNouDsUS19lmUY=
X-Google-Smtp-Source: AGHT+IG9yoIyOpavgSvp8xHwWJUEv9GqMHuoWpEObJoubi3aQFctTwmkcSut9eRF8p0IN+IsXf9WjA==
X-Received: by 2002:a05:651c:198b:b0:2ec:5843:2fbd with SMTP id 38308e7fff4ca-2ee5e6cd69cmr61059341fa.41.1719918522391;
        Tue, 02 Jul 2024 04:08:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee55fa9c47sm14955721fa.15.2024.07.02.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:08:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:08:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: record reason for deferring probe
Message-ID: <ecomdlciigigng36ao6j4sj25dmbkoy6j5qun6nje3ok4rp6ld@n7cwb7v2ynbt>
References: <1719910870-25079-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719910870-25079-1-git-send-email-quic_zhenhuah@quicinc.com>

On Tue, Jul 02, 2024 at 05:01:10PM GMT, Zhenhua Huang wrote:
> To avoid deferring probe smmu driver silently, record reason for it.
> It can be checked through ../debugfs/devices_deferred as well:
> /sys/kernel/debug# cat devices_deferred
> 15000000.iommu  arm-smmu: qcom_scm not ready
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
