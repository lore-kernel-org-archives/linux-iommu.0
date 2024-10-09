Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD21E1A34
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500528; cv=none; b=WRgG8KIHA7B0qtGeUqJrIbLWl8xSUED75wQMYgdv9CQJ0rzZ3bae7CNP5C15n2Y8vIm/KekLyLpxJDIntf6cKMHqy21diGKwh2Ftv8FU6uxULTbez3pQW0BF3+v0XwNhGlxVsttFwW7ew1jaMcma/mvsCOmHIMMm8uo3RL3+5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500528; c=relaxed/simple;
	bh=Y9AhP4Ij9yYbpvP42cTvVt9kdtqB5fM50/MgwEp4SyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGvLDDShnlC+22vGTA+w5XhjR1fF+JSTiwry8uKWz/ngmkLpnk0WeNUiiUSm825AjLkI8MKY+GnEfp+uhXkk8gkfE7xjao9pF7BvMXMQzc8sxg1LcHu258VSKGEz0VYSwqI0pWTzW9c6XMns7z7gsJzg47MPApj5IeKKjR0xYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSivFh7j; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSivFh7j"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398a26b64fso55442e87.3
        for <iommu@lists.linux.dev>; Wed, 09 Oct 2024 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728500525; x=1729105325; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ5+ACbZx+UOJv09QvSfDOymcofkqLkZcQ+uGiaQiAI=;
        b=WSivFh7jRtHCN0boj2Zi6oIE8flbIkaBIX15XKKeNSVMM0w8/jJrFeLLS5qJPuXPJT
         S0HFl8QD6Pm8b5tK7UvR0QLgs1KZM97Ynwlp7qnIlMoKVTOQPt4kC0uWJin8XWtKmNOk
         au7e+tWr9JZt5rPdu0WTrOH6vVat6FlzRRyCygFrkHwcw6YLf02yM9xSSslKVRXmV8DE
         7+Q/rWmL9u+/Z9oSl3dqkfjHddIT+mK5eWkE19dH7ZRYcoFLgsVe7qBk6efs9yiQgB69
         lnWN1sIye2hPkk0+5HkWEwXr+OiNgjNKsp/qi1LerVTa16ANxpP1TgLjxy2dZg62GuSf
         7UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500525; x=1729105325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ5+ACbZx+UOJv09QvSfDOymcofkqLkZcQ+uGiaQiAI=;
        b=l13w/ewyjAo5Ivd+zqN2I2xcu5BSan4z46FcKzcbLbBPKkainijaQ0X3ZFEVq9IY0D
         dD5dx1EWueemxbqCaERM1GHWmGCWmaMUZYFeqMTq70NKeWyUyoyty2r1xzOdtBZjHhsx
         L5pN5nmQsY2+uqPyfmsFBVPXEe2z++7DfqlM4rQybykD4NyU7s8f263uJT27Ba0Ic3Kx
         CJO2hFGYVBQCmxJuaxMLGt/jHD9C4WNhkJfGhHFW76a6HolzHSQGZuriMvAHDECCuoGG
         /IjyVD1mdL1OtGsUhYWMvPSOtFk06MWmRVSWeIM/98LsINEeDpd5qgh8UFOwVw15G/4n
         qeiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Xd8bqOZUNa12PSb6otY6EXYyfyOsEwdeuSJmlkx69AmRnmA7pkWafzxNK2WfGUUfpF0VTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEsOIWtMx4gcGQ1BjUvzSGO5YbPelyrSyVfiXI/5jBqHkMoTEG
	GdY/6dlwGaltzqGl2n7mMzwFh7oN/dAaOzJBEod8EwV04cXZVoRoFGWreuMtEYU=
X-Google-Smtp-Source: AGHT+IEekgkxN0FoqtvPj+djHpCzoAdpqcQVG0lO0MMFyXD4siMsEcttXGyf6xKYoA9aRSDcmj33Jg==
X-Received: by 2002:a05:6512:3ca7:b0:538:9e40:94b with SMTP id 2adb3069b0e04-539c489754fmr2427993e87.19.1728500525147;
        Wed, 09 Oct 2024 12:02:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff28034sm1594268e87.250.2024.10.09.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 12:02:03 -0700 (PDT)
Date: Wed, 9 Oct 2024 22:02:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 4/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Message-ID: <qfglrrksmb5674fxwtnqs7osku4wqri7nxrymju6fa4ey6zrto@e7ww725n3cfc>
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008125410.3422512-5-quic_bibekkum@quicinc.com>

On Tue, Oct 08, 2024 at 06:24:09PM GMT, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  1 +
>  2 files changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
