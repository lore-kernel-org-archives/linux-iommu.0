Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BA1D2B3E
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718620; cv=none; b=vE2yLHHmDIidr5YBXBYwpQVMvFNPYw6G3yWRQBfSQi9YGhv6q/ZOJ9TqeZ4ZKULdA5AEYqWZ8nDQjDDjyALrV8sJ9RvVhX0NQ7yszX4kdyMSzLxdIZGtDwtcF8UE4ULpg3tqBOYZzXJ7qJ1fEenv54FUiVPbIhJ+T+iYK3T/Tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718620; c=relaxed/simple;
	bh=xCmzKCV7gN0Ttl8kSMcuqSTMDAZYGpuQ2h38YpKLMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg0fsjwm/pvonnnym1QPzPyXqNpfvtyKZ6u2V34jggXmT2fJhf4x2wiNnLsVJZpTAqiG/Rmy4yPUG2aAJaRZQv3hHSvFdOQAmaOwhCpUfSrcfXZm5q1vvlIIPRHv/4kDntSqDf2y0Le6kDNrbAERGqZgukJY2IicjRpBxClHSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lUoLmDsj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUoLmDsj"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e63c8678so4512199e87.0
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730718615; x=1731323415; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdH9jagT/8S5NPF4fTku+zGDNqYYEhhoFHFFqWBZ6As=;
        b=lUoLmDsjWj4Y5W3WrlB8EtxE6vBQAkXGPbZuLWsMvDCKMzs9DhfF1K1HqxNt/QUjgI
         4YNirNvT8zUNU/Vs5ZPTJW8fTG/uLkolaUGg/nNuVlJnLcbVzoIodtzTCNupX6aSSJ2o
         pqz5/bRU9mpYpuSZVXQ81CRedpUESUW1Vi0QCbKQAiTGNcqXQTiE7SoCv9Q5q4bR5a3i
         hFNmxw0Uw1xTwG0IJgyLRH9MOefdwCJYIB0/VUfmyjidVMPLJSEAhn0apOU5H95lyop6
         eLIKgD29yHfHOY9p4ur6EM3qhN1rtZ1+DKO4clcNOKoIhyOoziIC6s6oQh3xjCioX2/w
         RkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718615; x=1731323415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdH9jagT/8S5NPF4fTku+zGDNqYYEhhoFHFFqWBZ6As=;
        b=caN6wmFclmx+DPiW8+61xqDB9nJfMJWwJFo+igYzBcFyrcAnfzLMn6XYIGpI0M2OeD
         ONIXvsX8Z88fyOQqSqzu2z6nBybsGt+w3AddBJpKEbWP1Q1CkNYu5pNSzmKOmflJBb1O
         bPDP1N+pu8kUs0SQzscZGyU27wMJvcuC6/lZdrkytImm6WBeUdPxaGRuu6W5NDj5kGKA
         CsmhHX3PQe0mLgapLrOPdPVaxz8uCftuBoVphn99q/+PF4VDSZcasmAXWxTYmRzAWgH+
         Dl49DxuVBBsOJjLPOvWVzg/PSXwnLz3pOPDpe4pWmT4FzBzDfihjigDSFeHtjTA8SqMr
         oqag==
X-Forwarded-Encrypted: i=1; AJvYcCXBIVbMdaWHlvazoleOxZAG+wfAEA1ELiQgkB4bksQTwgdpAHkCh/MLUVu7gqoFNOCsToohkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZxakalS4PoAWGM1wfAUDlqqdcZRLzg9BhG7BBKbEiEt6dFihL
	CbgNxsAjs53TI9wHDFlqfWQc/AzHiVXJ6kWIZZjBrCwwWUY1JWWmCb00VVW1ioo=
X-Google-Smtp-Source: AGHT+IEQUhS4emFgL3X45Om3GNfU0TsJqApFtwGEHEcfNMJnwL431cR9bOTneTsVxJQJXash7yfV5Q==
X-Received: by 2002:a05:6512:39c4:b0:539:8d2c:c01c with SMTP id 2adb3069b0e04-53d65e11aaemr5273106e87.41.1730718615371;
        Mon, 04 Nov 2024 03:10:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbfbcsm1639983e87.199.2024.11.04.03.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:10:14 -0800 (PST)
Date: Mon, 4 Nov 2024 13:10:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, robdclark@gmail.com, 
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, 
	robh@kernel.org, krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: re-enable context caching in
 smmu reset operation
Message-ID: <ygd6bryp73jgsm5zggy2jz4uc42dehht2e6ht5f6yowf74c6ns@u6dul4rnybt6>
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-2-quic_bibekkum@quicinc.com>
 <20241024125241.GD30704@willie-the-truck>
 <092db44e-f254-4abd-abea-e9a64e70df12@quicinc.com>
 <20241029124708.GA4241@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029124708.GA4241@willie-the-truck>

On Tue, Oct 29, 2024 at 12:47:09PM +0000, Will Deacon wrote:
> On Fri, Oct 25, 2024 at 07:51:22PM +0530, Bibek Kumar Patro wrote:
> > 
> > 
> > On 10/24/2024 6:22 PM, Will Deacon wrote:
> > > On Tue, Oct 08, 2024 at 06:24:06PM +0530, Bibek Kumar Patro wrote:
> > > > Default MMU-500 reset operation disables context caching in
> > > > prefetch buffer. It is however expected for context banks using
> > > > the ACTLR register to retain their prefetch value during reset
> > > > and runtime suspend.
> > > > 
> > > > Replace default MMU-500 reset operation with Qualcomm specific reset
> > > > operation which envelope the default reset operation and re-enables
> > > > context caching in prefetch buffer for Qualcomm SoCs.
> > > > 
> > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > > ---
> > > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++--
> > > >   1 file changed, 42 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > index 087fb4f6f4d3..0cb10b354802 100644
> > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > @@ -16,6 +16,16 @@
> > > > 
> > > >   #define QCOM_DUMMY_VAL	-1
> > > > 
> > > > +/*
> > > > + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> > > > + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> > > > + * buffer). The remaining bits are implementation defined and vary across
> > > > + * SoCs.
> > > > + */
> > > > +
> > > > +#define CPRE			(1 << 1)
> > > > +#define CMTLB			(1 << 0)
> > > > +
> > > >   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> > > >   {
> > > >   	return container_of(smmu, struct qcom_smmu, smmu);
> > > > @@ -396,11 +406,40 @@ static int qcom_smmu_def_domain_type(struct device *dev)
> > > >   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
> > > >   }
> > > > 
> > > > +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> > > > +{
> > > > +	int ret;
> > > > +	u32 val;
> > > > +	int i;
> > > > +
> > > > +	ret = arm_mmu500_reset(smmu);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/*
> > > > +	 * arm_mmu500_reset() disables CPRE which is re-enabled here.
> > > > +	 * The errata for MMU-500 before the r2p2 revision requires CPRE to be
> > > > +	 * disabled. The arm_mmu500_reset function disables CPRE to accommodate all
> > > > +	 * RTL revisions. Since all Qualcomm SoCs are on the r2p4 revision, where
> > > > +	 * the CPRE bit can be enabled, the qcom_smmu500_reset function re-enables
> > > > +	 * the CPRE bit for the next-page prefetcher to retain the prefetch value
> > > > +	 * during reset and runtime suspend operations.
> > > > +	 */
> > > > +
> > > > +	for (i = 0; i < smmu->num_context_banks; ++i) {
> > > > +		val = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> > > > +		val |= CPRE;
> > > > +		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
> > > > +	}
> > > 
> > > If CPRE only needs to be disabled prior to r2p2, then please teach the
> > > MMU-500 code about that instead of adding qualcomm-specific logic here.
> > > 
> > 
> > Doing this on MMU-500 code would make it generic and reflect for SoC of all
> > the vendors on this platform.
> > We can make sure that it won't cause any problems in Qualcomm SoCs as we
> > have been enabling this since for some years now and could not
> > observe/reproduce any issues around these errata.
> 
> Unless you can explain definitively hy that's the case, I still don't
> think we should be second-guessing the core SMMU driver code in the
> Qualcomm backend.
> 
> > But we won't be able to guarantee the same behavior in SoC for other vendors
> > where these errata might still be applicable as per [1] and [2].
> > So as per my understanding it's safe to include in Qualcomm specific
> > implementation and not changing the default behavior in all other vendors'
> > SoC even if they are not prior to r2p2 revision [3].
> 
> If you want to gate the errata workarounds on policy, then please follow
> what we do for the CPU: add a Kconfig option (e.g.
> ARM_SMMU_WORKAROUND_BROKEN_CPRE) which defaults to "on" (assuming that
> the relevant errata aren't all "rare") and update silicon-errata.rst
> accordingly.
> 
> Then you can choose to disable them in your .config if you're happy to
> pick up the pieces.

Is it actually going to work? For most of the CPU errata we can detect
and limit the workarounds to some class of CPUs. For SMMU, if I'm not
misunderstanding something, the errata will be enabled by default for
all SMMU-500 implementation, so only very few kernels, targeting only
the Qualcomm hardware, can get that disabled.

> As an aside, I'm happy with the rest of the series now.
> 
> Will

-- 
With best wishes
Dmitry
