Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D12AE90
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335896; cv=none; b=B0F7s/S9P/zJI2y9ufu0auASxkRonBGt6I8INiFjQfdp4r+y75CIUkvg3jkQ/yDK4w2fdlsKZZbGjSYbaOh9G96F5cHxkAr9qzw7dkB1rZJZLvySiZd8+iKiPluIRXoNVAyi3bWO3xsHz3fm3sDIcyZhBkgGmgqv7zlkTaAnMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335896; c=relaxed/simple;
	bh=e9nHpwMBjaoFqUkoyryIoEFTX/TGNX1aD1pPnnHMG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLs78Koybc+N7HHBp0ITDawAuHkff0qnkZioZg87DzPK9TlwbQLmrA7a/BqCR8RyQe+9S2m+ehsJbLeuKEr4gHnMF1W6GikvWHuNTBqHf+Q3Wr/lUFEoJn8SP2xHyk0YtG5vzCxHQfWbBT5cUN6iCcLeJM8hBbR97XH0PgwJnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uav7UpFy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uav7UpFy"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so30761791fa.2
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 20:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732335892; x=1732940692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRhFfCU54K+2vGl9KCGpU43DH6Z3TBwkPWpTyROlHtc=;
        b=uav7UpFyOUGZF92K2RzkxDcqLNxYRprJMVhh4MpnVmQFemlaRAKD8w+gGE95XbOpLJ
         wTxbIluWxb8h0kfvcap16qrkgelgie47yh7p2QwAJ7+rJIKtnXkfdqwwY8EEGGyVA6NF
         0g4USCnyQeka7dRldtnvmZFhibVwS8yEyIiBmv039+bxs92z2wzG5D3stXQH4banoLUF
         dUcE+x+HN26HPT4zKvl36vs4n5G+F2K0VB9l4BI21/ssaoaQw+RVJnsPMTDZr9GLkX/R
         L0n0wRqw5R/gawzrQRXJZ7zd4Htsksd5ENKWBpk1NrEaPvlRGq6gTb69NHxugQjkirrS
         lzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732335892; x=1732940692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRhFfCU54K+2vGl9KCGpU43DH6Z3TBwkPWpTyROlHtc=;
        b=GMLirD5JMTA5XYIwJ7uFrlh+oXP/+eSh+EiQ52InSjvHuWGZkmHEklMvtp0U1FiE+r
         jFIsb2mZNCg4e1qIz++yBUC4QiB6yj4Y6d5w+eSqzWZSMRJ0OX3+dHUPnmjW6lztFMbr
         dweHgDuQrAj4o0zzykkWwZ6S/FtSanA4roFjDNS8tgm7x2tYb7jkkPT4mCYhqP2XYvKz
         87VgTrpb834MIIUttadMxF3Lz467rQ/rQVYU8+toiNWtXNS9Cv3zFN8TIcW+c8/NmpcS
         LI0OJNtjqJ9XIThluo2mN2km8e4t7OQ4vxeRGYtsAxAeGjYNT+rYEO28KC6mKOg6KWgN
         judA==
X-Forwarded-Encrypted: i=1; AJvYcCXaI6cSq0/JwKkD+OT1PEiB2GAZn/CHoK8cSLSIfBxdcu7+VdvsAHqysVWQoOuuad/rzSzOZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjs7PQ8d2rJvr1v5Kkz+WHIaBlNBzwQlyXWIDuVL9dS4ZR3o7d
	fxPGY6jkEANk2IPimWHNi3iQ31K5Aw0PAIJNIl0huGzMqKXt6EQrduEnEj9McdM=
X-Gm-Gg: ASbGncu45vjO0tukyFsbx8BzzL0SpALKwEyAPvJuwBU5dK9FCBFHJK2fvfee0tOqcgB
	UPjefQpFJqDI2ZQ6CzJp2n8RSYwVJ/gzJQW3bc81IbL/VJVazr3VK7gGANPqPLTWZo8MIfCBe2H
	YtN7eDiPxDMHTYDEH5Cf/RYV9boOvgzuJAukdYQ99YcEgVoiSrZiuXEPXIY+nrBzilQ+TsTom84
	M1QLWwNW/wg5h5IGBm1xGYMuRuDD0afEX3eO8Nvco9rjhBgCeeIlBqFL6/GWd8E6+RlGUzTkbSa
	KmZ8fvin5YXN6GK4rIvBrLbdz+8tAw==
X-Google-Smtp-Source: AGHT+IFdByuwlVrForEzT8tv23srj0gnAIFOKpmn1yRMnyw6GbJuVEjWF46wgEUprlaX5HOFYnyPnA==
X-Received: by 2002:a05:651c:1594:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-2ffa71c4f76mr33073991fa.37.1732335892280;
        Fri, 22 Nov 2024 20:24:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa5375d8esm6320591fa.89.2024.11.22.20.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 20:24:51 -0800 (PST)
Date: Sat, 23 Nov 2024 06:24:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v17 4/5] iommu/arm-smmu: introduction of ACTLR for
 custom prefetcher settings
Message-ID: <w3rqdjygedgwsacn4ybajvv3fwuhhaaazo5x7zqcip7xdtf4lo@shwsl5acgqzk>
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114160721.1527934-5-quic_bibekkum@quicinc.com>

On Thu, Nov 14, 2024 at 09:37:20PM +0530, Bibek Kumar Patro wrote:
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
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  1 +
>  2 files changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
