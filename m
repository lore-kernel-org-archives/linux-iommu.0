Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3311422C7
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170757; cv=none; b=Zw/lsN6w/ZT1JszbiMt5RgW7+qiKz39Z8YXFX1OK00Eq/JN6r7c9AkQZUAiiXIcgRIv5+0SWo9/e1ZDsil3rJ8Rym7pHvb/CozCADLlooGyu1qpIUpkDV+qPHqxITVYLyPh0lQsO6MV1lfPrYTbIukcqCTHk1v9UAof35nSUb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170757; c=relaxed/simple;
	bh=mf/yNQbTyBi6//hoU5xYaWDXLqvNOSROMW/L33As/p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD2afkm/7rUioXKUJgWE5ibvFSb8DLDjgZCFvEbX/B1i1Qj+7o6EbMEfj80hkSDPwczohlxcCHAkdBwjc5bMa3n8yCOdeO7/n1KgSbpiLIZpyCoIW/MorPU9akuEd8mDoICALKmL3nizR4H5h96GpVN/+ocCP3lAU3BWk6D2718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCE7RlxK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCE7RlxK"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f7529203ddso59164361fa.0
        for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727170754; x=1727775554; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdePYOwVLhdr7Z5Ai8vXonZrKUMVNJYnj4sOgIcjQV4=;
        b=NCE7RlxKe5Z2pPionkOcIfjMpFgmriWiCint7ihne8ZpBsnHf/m3NcJv5I/+KV+aXS
         uFssO6gk1ClzeQNdvbU0Qy/mu1SzlxlRRbuXnXMEYcgsbJSHGRXBdgSc88yQqmpGmY51
         V5MjJe9OipVE68mq/bMyPI/bUkoq37RntHohAfMrPtYUQKh6RMtCXiSsVpbR8drNc4Cm
         UHFga6jsMHS9WVjGaBqJO7MDvKkG3mU5QuwXE4F3hv+MTshbMJp0WkOK/7irUZ8edESf
         nTiYjCWj85KLKODK7GJ16VgpNBfzSpIPjHxe7mc1dL4V1xAq9k0cwi1v/YAcUInherlA
         iG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170754; x=1727775554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdePYOwVLhdr7Z5Ai8vXonZrKUMVNJYnj4sOgIcjQV4=;
        b=b8xmQFIP8PWr1jU3mrMDEeT2I+z+ZDWUoSfnO7j+5jLByOHFZH672owWmSy1ALOUij
         MzIrc0RUWWv0cumHwsataOM4jxjxYDMw4zFzA2OkXw8YdhLtGXpPTfLywa1iiaYLnQ0K
         QCXpH9rvukEyVsDrpqjs4WmBFF2suQTQeaLi0zofV8CSEk7cEC3Eak25sb7Ho4g5Ldny
         UzllRnCYAtDl0Ra09U0Wt+kzwSuQ8AnjDMu4pE+S5iunq44iE+X3UZmwWF5NLyAyum0H
         OKPIZFP6oZ7rPAbkv3d9xagbkpcTmnmTo7ohY2xHTW9QlK1/iCyT2MIj9pOrhWnCONta
         9KWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh8+w1BV1svSLOHKpU4U/r1ABkMUvg29+t7RphKKxvkPbTweNreNFH6SCG8tg4p1bxaUl7Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxscu5a3OGceAXPC9eyVfq2Y22fbGntbkHGRj0mBYcfuABVRmN
	ekOccVnxd8CS2klkssS+rUEAQZcOwjRdGNG8Ng467EbkqvqSdK45xOYtZbFXSzQ=
X-Google-Smtp-Source: AGHT+IGaSdkWJlPaDdNvVeB10oDjOeL9lA78zLl9tk9InZw6sDjbdJCQLJwiltHxpGb4QESfI1B8mA==
X-Received: by 2002:a2e:801:0:b0:2f7:5ca2:6d10 with SMTP id 38308e7fff4ca-2f8d0b91516mr7459431fa.15.1727170747681;
        Tue, 24 Sep 2024 02:39:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282fd34sm1606521fa.28.2024.09.24.02.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:39:06 -0700 (PDT)
Date: Tue, 24 Sep 2024 12:39:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/5] iommu/arm-smmu: add ACTLR data and support for
 qcom_smmu_500
Message-ID: <jqwm5ddslvpbdp4ngxxyfpeda2qoc2rsnxc5cwo3gy24mpd345@qkyxwggxk77m>
References: <20240920155813.3434021-1-quic_bibekkum@quicinc.com>
 <20240920155813.3434021-6-quic_bibekkum@quicinc.com>
 <xxd74r5zzobcsg6joty4rxxmj4gaiezmj6bqlcdbcyhshchqq2@ljpxtgq2dthg>
 <66af599b-85a7-40fd-b550-346013028394@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66af599b-85a7-40fd-b550-346013028394@quicinc.com>

On Sat, Sep 21, 2024 at 01:29:04AM GMT, Bibek Kumar Patro wrote:
> 
> 
> On 9/20/2024 9:48 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 20, 2024 at 09:28:13PM GMT, Bibek Kumar Patro wrote:
> > > Add ACTLR data table for qcom_smmu_500 including
> > > corresponding data entry and set prefetch value by
> > > way of a list of compatible strings.
> > > 
> > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > index 4ac272d05843..e8f936a446df 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > @@ -25,8 +25,31 @@
> > > 
> > >   #define CPRE			(1 << 1)
> > >   #define CMTLB			(1 << 0)
> > > +#define PREFETCH_SHIFT		8
> > > +#define PREFETCH_DEFAULT	0
> > > +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
> > > +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
> > > +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
> > >   #define GFX_ACTLR_PRR		(1 << 5)
> > > 
> > > +static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
> > > +	{ .compatible = "qcom,adreno",
> > > +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> > > +	{ .compatible = "qcom,adreno-gmu",
> > > +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> > > +	{ .compatible = "qcom,adreno-smmu",
> > > +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> > > +	{ .compatible = "qcom,fastrpc",
> > > +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> > > +	{ .compatible = "qcom,sc7280-mdss",
> > > +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> > > +	{ .compatible = "qcom,sc7280-venus",
> > > +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> > > +	{ .compatible = "qcom,sm8550-mdss",
> > > +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
> > > +	{ }
> > > +};
> > 
> > Wow, this looks really nice now!
> > 
> 
> I am also in favor of this compatible based approach now,
> as it looks to be much cleaner implementation.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> > > +
> > >   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> > >   {
> > >   	return container_of(smmu, struct qcom_smmu, smmu);
> > > @@ -640,6 +663,7 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
> > >   	.impl = &qcom_smmu_500_impl,
> > >   	.adreno_impl = &qcom_adreno_smmu_500_impl,
> > >   	.cfg = &qcom_smmu_impl0_cfg,
> > > +	.client_match = qcom_smmu_actlr_client_of_match,
> > >   };
> > > 
> > >   /*
> > > --
> > > 2.34.1
> > > 
> > 

-- 
With best wishes
Dmitry
