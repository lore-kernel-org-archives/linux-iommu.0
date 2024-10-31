Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519319D089
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401972; cv=none; b=mtT51NscpmtMQYZTsjsnWwJ3K1xekylc7JPrjWBWTra2R6dyHTsndd5Lwv/VPSoCoXNJBAOcG7E70+fJmHQOTGH1VvIXnF1oSrWE8BmHrSgm/7BoCu9LzEIc84QaiZ+ppd/FRvE4f/wccYAfMmO8P4wZRbf2B0R1P7FJfYjVLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401972; c=relaxed/simple;
	bh=TYW55Jhp7t0Vd1HnF8KrL/jWsJe3Zk30JNz8WAh27Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzDLipSAxjeFFMaaijBeXyLBt5s/GHxcuKjQ3V6IDdoxDiDT3fqZ2h4xd/85Nj8vBlYfGI8POzGoZGGxssXtZcufQyLkBy39E8aarSM6MwCdRH1njd/fGbVNR186MTqcfV2exoJ0AOn4LnZVJy/q2QzH8EVRSTUKgBLdSmdXzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pyo9or9I; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pyo9or9I"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f72c913aso2067743e87.1
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730401969; x=1731006769; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rD/pY/i638YKtWjS7I89D6wpk5BweHDNRe5Pjk8A2Hc=;
        b=Pyo9or9IdxbX9cz0YzMSgYjUzlOACcgcDhhUHX/VnKGEBwDw3HTBMLHoqitmRhCaOJ
         XkpdWWF7zGnk/EoCBlBjAKbPvmwhMuOcmkBs60jq6ah+eYDouES0P8WOHmAOnag5OBG6
         JArDf/bOJ2K98YA+FV4sDR0RQJ7tTd4KjW21fVxV8qJC9KoR5VoOQDiQHeWH1DUBe4C7
         YLEVT/Byj8PAdddDGGamjSDfkur8Tiue7294wsim2CgO6++ippg7WNsbGwzxzTyY3XB2
         euTfVZkLm2VRoUfcJCcUIVuak8L7gda7A937M5BHi02tidzW73HCYm1yFkam6uAXhz2I
         jrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401969; x=1731006769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD/pY/i638YKtWjS7I89D6wpk5BweHDNRe5Pjk8A2Hc=;
        b=apTY9leb2WuLs+MLq1MBGDfTtXZuQdeH2Ek2R2VcGZxjCRC2VSWFNRDYh9BorncgAG
         Msw9xsArmgKmqvzHXq3bLPiI4u8HMDwhLoEBLq/mw/Hy956tRVw29XKmzBi2DvBVI5Lt
         rI/vJEguHYiXzOkKR6DkZvdI9dohKq8ohDjvZIA8g/dZ4ExH3r3aH3lPx+1Nf2ZJ5dcN
         e1i7X1M+ActUOLPCn8MQQFuw9z3kwrJ2SOYoMTBpsGTwZhJDDP/oMhOnFHQhO5tdT8gq
         dlDMCfZPVmChLdY9DGv9AK/slzw+N2jFFNLmcRFpmL0CGAiLyDZv5iNbz6/vsWnnPtcA
         E3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX+WwTbikEY5xc4mQ+1kuua3QF6ZRbFGsrq6qgILp0GEjhBnKw0M3wixNaKRMuvoQnFvtZVHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqeOQpdFxmAnuMXWp3OGJxmg+tunAlTlz1ZDQFsUCbXdqbi/t6
	sCXEZyFNTtqPOxO5HBOAJilRffDKjJiBrfdvyjKP91BBcr1xn26mmBV/rbK/M3k=
X-Google-Smtp-Source: AGHT+IEHlgrOOPldK5P7S57DuVyfV2iyV8RJOHXDbZ5tbr/99nLsMq1Jtiuo0Qol8RifwvNdY1Zhjg==
X-Received: by 2002:a05:6512:3b25:b0:539:e9b4:7ff6 with SMTP id 2adb3069b0e04-53b34a18f2fmr10168609e87.45.1730401968815;
        Thu, 31 Oct 2024 12:12:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc957aasm302503e87.42.2024.10.31.12.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:12:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:12:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/arm-smmu-qcom: Add SDM670 SMMU v2
Message-ID: <jivvekptfdr5zh6xnzvzgye7oaana6q3dpyge65m4uklfo6ubv@rq5uar3avkdg>
References: <20240730013820.41702-4-mailingradian@gmail.com>
 <ZyFSJjO2fkqCwzWm@radian>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyFSJjO2fkqCwzWm@radian>

On Tue, Oct 29, 2024 at 05:22:46PM -0400, Richard Acayan wrote:
> On Mon, Jul 29, 2024 at 09:38:21PM -0400, Richard Acayan wrote:
> > This adds the SMMU v2 for the Snapdragon 670, used for the Adreno GPU.
> > 
> > Richard Acayan (2):
> >   dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
> >   iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible
> > 
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
> >  2 files changed, 2 insertions(+)
> 
> Hi, I'm wondering if this is still being considered.
> 
> The NAK doesn't really make sense here, as there's a warning/BUG at the
> bottom of the qcom SMMU driver that occurs when the compatible isn't
> added:

Please resend it, adding an explicit note about having no generic
-v2 fallback and that being a correct way. I don't think Krzysztof
reacts to old patches.

> 
> 	/*
> 	 * If you hit this WARN_ON() you are missing an entry in the
> 	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
> 	 * tables will be broken.
> 	 */
> 	WARN(of_device_is_compatible(np, "qcom,adreno-smmu"),
> 	     "Missing qcom_smmu_impl_of_match entry for: %s",
> 	     dev_name(smmu->dev));
> 
> DTS change for context (pending):
> https://lore.kernel.org/linux-arm-msm/20240806214452.16406-10-mailingradian@gmail.com

-- 
With best wishes
Dmitry
