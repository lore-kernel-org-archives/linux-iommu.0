Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F78221FC4
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952185; cv=none; b=GzjtIbMlbcBHebirD+Mtb01HkQ0gmzC+JMvR4ZTS1TtnHUoTZVPqdTRpKcFQES3yhNGsrmVJG+nKEB22hH6VK9u5K/XglgjBP61464CzajXsIwpRxW4/KMkK275Rk8u+CDVGvc+PATRBsvsN/KwOG9hQfHw3F1BQst524MVtJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952185; c=relaxed/simple;
	bh=hMFzAE+u+nASc8Ayen4g5l9uc68xWJVxUvqNMCpeXuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+OCepCwZ+vSqoppKHc/Qd0V380vqdp4n9HZCWC5xA6+04kU0AfuTJeSOz5rcsBhKE63YhgPa7jwszMPF7HpIl2JrGKAkQSETxQGKXYjtH1fmFZq53FtdanSo2EjBI1p8831JlqMZRGX2T+VmFMnGMF40VRFSvV3tGcu03rrLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zcA0ZmsD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcA0ZmsD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso35785165e9.2
        for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760952182; x=1761556982; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdA6CsjifSV/CpZyjz8ziwjcjaEoS8UMM+9gCn6fwe8=;
        b=zcA0ZmsDH5QV7+VDW6FjN9tBoR8kjDgm4xaYQJudTsMUsnCjPuoWYx5JgkLMaBYROs
         aq4srpy9NgW7m+ji0rB1537B805heVpYPmvzf/0Ifhxd/+TZip7e4u/GThh70mQ4KIqK
         zS4IRgL092RXkegHxkurBEWxm7IeXbTi8gtWL5tdNj3HrA0anK0e2Pb/pNsYfhH1okMf
         +Td8bz5aQ8aIFm39HoZoGdS4PR74Iptx5145QGxpGXCGNyG7sFYKOF3ZaSI4aZ4ePDfh
         Wkmy1Tdca36M5DqcWFxpZEi5hcvcwn5bxkYa41UGt8AP+QV4ppTlVhaYwB0nghpUO11W
         85Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952182; x=1761556982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdA6CsjifSV/CpZyjz8ziwjcjaEoS8UMM+9gCn6fwe8=;
        b=VukmY+9mqf8rEnMXkV1l79El13QJtXNBWxNVIK+YwwVEr9MyJd7MInDdMhgRdFIBBZ
         PnQAJfvcuOtEGhqB23xQmCIKwj4MzTQDFZLsDowrNapAZEb80Dl33wkp9tzHq8h/5fUF
         CKAGkMWRYe/67CftxN/TTctJfSTB2ssHcZsYGc72XER2cjFuK8pHmOBfguu3UzCRa9kX
         2j3M/XLH00XoJk0o3qf1p16NM1rgIEt9yhntB3K4wblEnSMBx6IsX/HN6XZ3iqZgFWk0
         9zM8uAY4uTgmRUZkWZpkiaBwFJJq70/uc+zjZo0nXFGUm6Yx84CXkhTIQUcUL0ZkvWox
         mQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5EyqzTwtnw6/m4r9qfh/PkySsnmAaIMdLHBjSkAGLCADXVWFwZD1fffnopPQ1Dl3qSGdY+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoTgMqN8f++oueq/zC7a3kH+qK1fae/2d2cVlA/RGJutmMTGaC
	0IqR5nYxM/j2sYhotS0ncqO4ncitWfZv21pP9PQJ3nEx+Bi0/q4Qb1bynDG4YGpJNZ4=
X-Gm-Gg: ASbGnctx2J3zAZcccxwaFwGkaLMEnt3+Z2DtI/xEg6w2Q2LynS9QICoQ3ffJSCBbz0G
	9yQZa56vgvK3W8ZFxmPMw525r6RziAADbJX1W536EFxdxpue9j5vfREhYOCn+e3kD4GgAJ7pNXY
	ZurMIvQL4lKY0+DBOteLEEJJkZ03mmxQmphwrPua32lPh6SkmLqBLvM6XQnCRD4osySepNmygLy
	da6rlXpqDjiiE4BIZEgh+zc+SXkgMehWSgNYS9xg4et3VhArdYCLFSmaQxadVEB3LHH1WqTszKD
	OKXjRM4IgDfR5y3PBrlPB3Fpb1DLn6DsFMmCjx2upGYf89lEH7zPzOpTvOzzk2eZcGyRhyAZG7Q
	qm04ByQI6AG97qgF8WWN3hlro8fSD+VXfa6mpY097WBhWaH5EF9NqBseGgDNDVxdBznPVNP7pjK
	If0u/yIVZMJjTOOi6w4e9t
X-Google-Smtp-Source: AGHT+IHNJzL0kQawtKy3fF4ivQKWG3FizlSZ82gu6HDNZ3hRrmE0LPQKVq82Mev6dpQnwG8Un0IyIw==
X-Received: by 2002:a05:600c:3b03:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-471179079dfmr98103875e9.22.1760952181601;
        Mon, 20 Oct 2025 02:23:01 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:363f:e987:7dd1:4f47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm139906525e9.6.2025.10.20.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:23:01 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:22:56 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
Message-ID: <aPX_cKtial56AgvU@linaro.org>
References: <20251015-topic-qciommu_bindings_fix-v2-1-a0f3c705d0f3@oss.qualcomm.com>
 <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
 <56fcl2ip6ecu4inig7ecpjt7qrsdt6sehkrzrk6joysbp6tea7@4xdgxhhe3aso>
 <38c3bf97-4b69-4450-9e23-32ece07e38dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c3bf97-4b69-4450-9e23-32ece07e38dc@oss.qualcomm.com>

On Thu, Oct 16, 2025 at 10:09:58AM +0200, Konrad Dybcio wrote:
> On 10/15/25 10:10 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 15, 2025 at 05:48:05PM +0100, Robin Murphy wrote:
> >> On 2025-10-15 5:41 pm, Konrad Dybcio wrote:
> >>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>
> >>> Some IOMMUs on some platforms (there doesn't seem to be a good denominator
> > 
> > It would be nice to provide some examples here.
> > 
> >>> for this) require the presence of a third clock, specifically for
> >>> accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.
> >>
> >> Hmmm, but isn't the only thing that accesses TBUs the consumer of the
> >> qcom,tbu binding, which already has its own clock?
> > 
> > qcom,tbu is only defined for normal arm,mmu-500 platforms. Here Konrad
> > is fixing the older and more obscure Qualcomm virtual MMU device.
> 
> (for context: this touches upon 2014-ish platforms)
> 
> I checked the address map of the physical MMU500 that lies underneath
> this virtual impl and it doesn't fully expose the same registers that
> the modern ones do, I only see PWR_STATUS.
> 
> The BSP kernels for those oldies don't seem to have a notion of a TBU
> either, except for toggling clocks that contain "_TBU" in their name
> at both the IOMMU device and some DMA-capable multimedia blocks, which
> I suppose makes some sense..
> 

On MSM8939 for the &gpu_iommu, the "tbu" clock isn't listed for
accessing the TBU registers, it's necessary to avoid timeouts during TLB
flushes. See Qualcomm Snapdragon 410E Processor (APQ8016E) Technical
Reference Manual, SMMU chapter, section "8.8.3.1.2 Clock gating":

  Clock gating programming guide

    For APPS TCU/TBU (TBU to TCU interface is asynchronous)
    Software should turn ON clock to APPS TCU
      - During APPS TCU register programming sequence

    For GPU TCU/TBU (TBU to TCU interface is synchronous)
    Software should turn ON clock to GPU TBU
      - During GPU TLB invalidation sequence <=====================
    Software should turn ON clock to GPU TCU
      - During GPU TCU register programming sequence
      - While GPU master clock is Active

Might be worth clarifying this in the commit message. It was also
mentioned in commit 5bc1cf1466f6 ("iommu/qcom: add optional 'tbu' clock
for TLB invalidate") (not sure why that commit didn't adjust the
bindings...).

Thanks,
Stephan
