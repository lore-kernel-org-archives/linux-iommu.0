Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2827B349
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349672; cv=none; b=ppOXUpxNEsf4yf9R8J078XBtojbPnJqoSG/Wo0Pv+hkH6ncYORU516PENkfFi06BjvZmq3f6iOvNNCDRrySReBKRqEgUjiwsI9yWTlTSksir0HIVdi0t1W+E0r3f454nDixR8Zuy3fOH+PuPMuxvlmbT0PSFeuDeUJ4ewTM2Ib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349672; c=relaxed/simple;
	bh=NRL9sAARvi/aqf7xiJ0E3HbCoDq1SW0ZCEwd0O27LBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3Y6ifthhai/DCZSHKwhAzIPqnjt7MDLhnuWmne2jLbuirEYRu56z1Pw0QqunRCCJTqhM12vJKYDF0P3Yzej0eFNBNh7IGxH4vP/W6EHpFpZxplkpqUKfXEFm6LUNDlYzXp30MO46RGX86D+whCoAH0Jkjx/xrAWMooQ6XBEf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gPPQoiro; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gPPQoiro"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b22b1d3e7fso187123085a.3
        for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 09:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764349670; x=1764954470; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcUIGeln3xRDoGBvCez/U/OJM3j8EXaZabhV7We/sH8=;
        b=gPPQoirod6D4jd5XPa8k2T+vxK/ZuM4wJUExMn4y5fFUmYY0rIDrALcTUnhIaT1FfJ
         Ac6UsQSxnkxl4jUWexhF2+QpVVjvxvJEpalvSZBFiUVDJtMd3kkeEeN/giMudj1QGdFA
         OYTUl8mrpVDbaliy2ywnPgnN4rUhXwSWl74bLfTtNGKWTQnY1mjwpaer31nTLs/AqWlY
         hW1bIJEpBsxsRNlcY9RV87erMxxCxF3BF543XtQyGxmVi3/9qgig697VsCt+xAL9d4TK
         vF8M9Z6vZIXoFk23TTqOmk2AM2Hm3SbDPT+4O/AHxHVBiv5xniwehQhaiJatr4zmA73N
         yMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349670; x=1764954470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcUIGeln3xRDoGBvCez/U/OJM3j8EXaZabhV7We/sH8=;
        b=NvjLTWiZP68HuCB4gCvOIAh57irXOxrtU6yiID8r4z9mVgHf5nH0RIFnObI+IZz55t
         H4kLq6aKfOINtfGoLPQK8NmmCcGCBAm1/OyYjbCObj4KmX4HBKwwMlT2LoBISdnS1AU9
         +vkIZRJ96LPSHBDqnT6AYV9mq12l6x5VEQWDZ1YfdPrPQkZEN6DZ9dZ1v++fG3K2i1h0
         KKvaRJhG/PgdW3eAVzfXsbM5ybKdO0G1DybrFlgDmayi3SnTLE0zOOfxklf7VldNBY58
         QMdeylvN3TMi6Qy5FxhxiMOs7ADZIXBbAWppnfG0AlYwpXD9SlzHBISa6G9hsR+8WWbD
         jD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6DXrr8u+S9fiZZhQfgxxxv68ibAm59ewqpn4v2DSlK3SS95okeH2/JorIgu7GGFuEdhMVfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjo4PMfdbmfNQqSgEzoBLbQIkuLbtFxUYnGbviIt1/vdSWleS8
	EAmLF2HlK8UZuPFOKMGEJMV2PT1jTHw/71/E4H/tJIFPZBHE2vOdRL6kFxS2OsVKpJ4=
X-Gm-Gg: ASbGnctpknbLw4kDReKA2dVqJefexvrX/NAJQD+W5oIoJ3F0orYZKrgkUnwcxvpf2gW
	GgAeGe6J/BrSsgSMFXndgQWuvqYFXSyxcuAIpOFRRVVDl1bu7zAT5mx0ywiGogemgq8zY9DlSiA
	U2fQXJcnO4iB7XYrifHVODRdqsYzDW8tyR/k5g7LNm2ZhAh+9Xq5LZZSOE9cgI+A/e6gHY9Q8cH
	W44nvgDZhZq55Vb+9O3jpZwX8ojVO7DbNvrWPohi3vf4Jf52Pk3F5Oigh+LYqYgAURFIYf/+xq5
	BvGV1vbtODgMzi779KP52j0jxaFFM8IaiiKDngNyodmudwGQns0I2NA4AkD3Brsz7ZARIoYM20u
	PaHsb6TmiLtZQFpXMCRiJOxy+81uBeH34nXsGy3MxPKqsEdrNr6srH9E6iYa3OmiTTnN0ZBuDxq
	qvEdTRdHx+SgsK7iLyDuRPpx4fubCPojgbRcEwbOjYgw5kTJNnnpxaqpqNk9mehpthc38=
X-Google-Smtp-Source: AGHT+IFbx9IVrRQnr08bZ25S6T/6GTAT6maBFJIZM+QU3ERFbdXAlH12nWX3gx47Z9oyfN+s9pa16A==
X-Received: by 2002:a05:620a:4509:b0:892:eeb9:4def with SMTP id af79cd13be357-8b33d4cf9d0mr3923929185a.49.1764349669847;
        Fri, 28 Nov 2025 09:07:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299a5f1dsm338261485a.13.2025.11.28.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:07:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vP1wi-00000003Q7z-2Cdq;
	Fri, 28 Nov 2025 13:07:48 -0400
Date: Fri, 28 Nov 2025 13:07:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 17/27] iommu/arm-smmu-v3-kvm: Probe SMMU HW
Message-ID: <20251128170748.GE812105@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-18-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184815.1027271-18-smostafa@google.com>

On Mon, Nov 17, 2025 at 06:48:04PM +0000, Mostafa Saleh wrote:

> +/*
> + * Mini-probe and validation for the hypervisor.
> + */
> +static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
> +{
> +	u32 reg;
> +
> +	/* IDR0 */
> +	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> +	smmu->features = smmu_idr0_features(reg);
> +
> +	/*
> +	 * Some MMU600 and MMU700 have errata that prevent them from using nesting,
> +	 * not sure how can we identify those, so it's recommended not to enable this
> +	 * drivers on such systems.
> +	 * And preventing any of those will be too restrictive
> +	 */

This driver is doing nesting though ??

Shouldn't you detect those IPs and not support a S1 at all so there is
no nesting? Identity only?

Jason
