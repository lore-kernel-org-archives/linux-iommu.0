Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636F1C27
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326675; cv=none; b=W3UAywhBe1i9UUgKkqlUelfL7lbccOnQ3QkXoZg1sVHmHja2M8Ao7qBDovgeQkP4iAWXlr8zAMo+ljTtR+0VJi8tOhwixIhdXl/3Ndr+s3SDjllog8PzfyaT4hJn9zI//GzYksdVox6BmJ9GiE28ePxfTY97/JYG5t1wMST9F8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326675; c=relaxed/simple;
	bh=i0+vWPXN2cdkzD1NTQZZWBolbNXz27fwbs3BiMXdQ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWr/4FQBtqjA0dsYcX2t5gJPKVBaCPLLPa5m+LwFfNEIGK4CWG/24A41eJmFkFNwUkkMiGwfh677mEYfO5xHzOMAPsh70UnHQpriudJEG7P+8Rvla3InEK08jOFumQV+XnBm7+HGQPo8ealdWHiIiuw7dWpV45slykrNA5YJe4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQWaJtlM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQWaJtlM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30797730cbdso13909601fa.3
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326672; x=1741931472; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXmSK8/WMVoYp/YH6Up96+HRQthxxadTxRUuQDlSb80=;
        b=nQWaJtlMlSdn5CQJ0H/NjxwIhRaWXkWwgJhBRd+GdFmmtnE1XzVJdY9bxjuemQIdS7
         LZZtE7yShG6mdSn7iRahg6SG+9mY4pN9skhRZ2v3nrNNvmVtu7jWJENAKcFtRaQWKkpL
         uulqwXREslZqb1iBnFzaeCvuBamVN+/3flP9FkGcmMFQ2l3F+tw9sCat9v0Cs0/s704q
         kw3d4ys2ZXHlzpBwEp/COKA18TZjxJRQO8QU/He4F8vuv5gdSwj03qjrgeji9cCrGaib
         /FWOt42lEiHb0dNuRyikifecoZ+iWoJadi46k057vI7rlFMi+MwC1dl/2/u4UQRypVTR
         a8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326672; x=1741931472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXmSK8/WMVoYp/YH6Up96+HRQthxxadTxRUuQDlSb80=;
        b=bvPSZV7XOTqLB2T7ELvyDf1pBrKUkahtLdc5K63i0KQInF2FcVamfX4xWS0j/vnLPq
         1FvcgA50/t0XQsseYQyRBSvS6i1tTxcZRhckbcmGEVQorSY90NDETI2BajlBopdzQOAO
         Wfvx22I+IjIx0bKPb8GkC4tI9sfb7d7bVLWui0KzrVvr0X6b4+WCrGS8T9hdp7IrtXxB
         yQ2clH/ZOuygYsBzJoG78pEFPimmHIJbgcYW6oHoHGv69OJ10AVlpm7Q0+lhgLXEJKZ2
         bZkkx/3Szs7wH38vus6kqNNo5mh8gAmUtmRGEMR+L+nSt67v9Q2WaSkP4GiCsccIbT9V
         EkCw==
X-Forwarded-Encrypted: i=1; AJvYcCVBjyrETi/ZCqD1j9Rs6H1eYfW6FSH4or9t8g5X5v6NvlnrUT/L7YMZLRP7+tRPQNVeNVXcqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZEtROMWyPqX14n504V8/79Cd+kNtj57nP8V1SAJpuV30qOx/T
	cm/+iCFbqXSvPhLuV00iux+Eio5egtZDHCcq4D01OtuzFlqzKogZCcXSo4CqSqA=
X-Gm-Gg: ASbGnctFNlIOehRcGi+sRC2WfQV78B7uHNwynVtOjwv2SmlcTtDaJ8VrRbiMGcSImys
	IgWt4d66fEJ8uxuELx6IMxdO3DnLvxEcPq3T9rlG4SP9KHGh3E6m6JTDm4tf+ZUPN7Vwo6f+2Pu
	Di0i9N5TnxNoxDUCaU2wYyTL+hcLpi457G8NwZotkEV4N6jODJyJ+nkEFEZTrajXK961Qmv0ZFF
	2PN5nnr1jh9vvOAXyQR0NRsQOq0AiEmUGCNtJOa7/i05B7Ae7tnIApNXedwrLYqlER2afWHASKp
	L2naQIB6PXa7Q4Oe83xa+5o5GNotMCSR+6prmUZ/B8PS4JPWOYaG9y+A9dOtvBvgyvhPOibmooW
	RurLG9+0jJJNTu/JwMp1ZzXfR
X-Google-Smtp-Source: AGHT+IGZcu2fypEgK7clxXmR93TzJ7unEXU/+kahsKp0+Qev+odXPrrlaC4iINRI4Yd2AzKHpypLwQ==
X-Received: by 2002:a2e:330e:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30bf45360acmr4804561fa.17.1741326672025;
        Thu, 06 Mar 2025 21:51:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9a073d0sm4291591fa.112.2025.03.06.21.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:51:10 -0800 (PST)
Date: Fri, 7 Mar 2025 07:51:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>, g@eriador.lumag.spb.ru
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
Subject: Re: [PATCH 09/11] arm64: dts: qcom: x1e80100-dell-xps13-9345: Drop
 clock-names from PS8830
Message-ID: <bth4rfqqu2bat24avosimvxuqmruc52taues4wljnhfcmxnx7m@zkjvf32oiogt>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-9-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-9-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:21PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The preemptively-merged node contains a property absent from the final
> bindings. Remove it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 2 --
>  1 file changed, 2 deletions(-)
> 

Fixes: bd2dbbb1f35a ("arm64: dts: qcom: x1e80100-dell-xps13-9345: Introduce retimer support")


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
