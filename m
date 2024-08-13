Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816146BFC0
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533628; cv=none; b=rIoR46QGl9AjTIA/ExrcdvhlmzbkOJpiMcRbXemJU0ZjCsNIU9BeOiN298m/WSqf/OVXDJ1H7MhpaJWQjE5pG1FTvnUOOMXZkfdMWeOtxuutfi9Ce4bbS72s6RXCxInbAfDwNEMijDKSNjXRUe7jHe4JV+tR+FDC6W5jN8LjhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533628; c=relaxed/simple;
	bh=UN0ZpGxw47ixND5peqiv9fX6/ccnQ6AxWsy9hjTfGfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc3TqlGneduHPBAV2+s04j1pspv7RdTiLGFBHMT+f4VUwcaz/tRUsyIqXcGAk1u8iNnenElLjDsYDDz1NMuG3oOGg9qnk6bdcxUuvyHaTbSiTW6ubZuGUv322MlMXUrR4I4VUuFSluy5EZwwWM6Nx4WS8SONWyZlac/rZT6+utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xv6JXucX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xv6JXucX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd7509397bso63455ad.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723533625; x=1724138425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRqfFafHF5XewBUoy5tZuHbvr8oDZuevEuG5wBULNKA=;
        b=xv6JXucXoeNF8zAeNtIAd93YEhNXaaEsfjsY00gI73AYgGTB+Hkp/AdCNFccxbYDT0
         11parQnK9W8nAClSXgFO2uD0rMv1EqeCiV8I9f+hSi0PEd5ernC8Rb6e0D7m4gXr914A
         tGdM/FhUctJ1Wbp93Qryy4YsC+WdyB+HueJ48AWVbknKlRoRhZMVSOyJzcMf8MtqsYn3
         p8632ja0CUn0/I/gSznl2gnBMVE9wR8UJCQZvBTxuNh7CoWhXQNmBs6GmeC6X1bbZZXm
         q3z6p7kk18kfmlcT0Y80Zz59zM53V3BTtQymadIF/PgB9upHXVC4pGUKpt+SPldGuepb
         FuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723533625; x=1724138425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRqfFafHF5XewBUoy5tZuHbvr8oDZuevEuG5wBULNKA=;
        b=Taes/0fKjPl867LZafYenI5+vGVKPGSjojaWSAOELGxi742nBGQ5t2Azf9Gm7VdjpE
         6eXc/tjzsSX5X+qJ8ypARXl+BQqnkCeQcXaC1Icx+y5ABoN/13SDgTdpOEohd0U0FikJ
         pJKcJP5Zc7phl9UWXUZxj+vIIh9g6nSLpZONxGv1w0rlAuU7Idj+pCTY0/FbTQmqYRIp
         B+ywS9DBpsK/Qb1N5Nm2weFfLx1wSTL1eqbgBMYJCtlAKwfWCjYz6bQYiUIrELG3Rq7o
         fHiHVhvNTlWrNs2tulIm3FoMf6DrHDzFtd6onGos+TWjKHOmuc7CeQV2Ht+Li4F9eZCD
         GMqg==
X-Forwarded-Encrypted: i=1; AJvYcCX84FRVTfYcZHUbz4xAR9PciTnV0cY5gIK4xwouuMymcgzinCSqiTtiUnLboF+MAZ/Q0sVl8wZtARVsT8psoNDZXquZeRU=
X-Gm-Message-State: AOJu0YwDImHx66nsHoSC2GiTpdG1FdtwsGPV75v9W5BvicWNRQbHoiVW
	i4KGG0W4Tyqp/jpBwGZsE2XS/ER673GdvcUNmpf/TawNL25U4lu8gQ8r1HFrLA==
X-Google-Smtp-Source: AGHT+IH3c19ieOFuxpG9Od28VUkUNWd5p7w4JT1Tcj/IJODP0Cw03Yuz3owloBqLlS4SpQoR2wasig==
X-Received: by 2002:a17:903:646:b0:1f9:d111:8a1e with SMTP id d9443c01a7336-201ccbc957emr1049735ad.26.1723533624423;
        Tue, 13 Aug 2024 00:20:24 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd12f5d5sm7442055ad.19.2024.08.13.00.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 00:20:23 -0700 (PDT)
Date: Tue, 13 Aug 2024 07:20:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: remove runtime pm enabling for
 TBU driver
Message-ID: <ZrsJLqTnq6tG2xp4@google.com>
References: <1722335443-30080-1-git-send-email-quic_zhenhuah@quicinc.com>
 <ZroNUGkKuC1L7Qfr@google.com>
 <cca690c3-916e-43b6-b2a5-eca4f2eb838e@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca690c3-916e-43b6-b2a5-eca4f2eb838e@quicinc.com>

On Tue, Aug 13, 2024 at 10:37:33AM +0800, Zhenhua Huang wrote:
> 
> 
> On 2024/8/12 21:25, Pranjal Shrivastava wrote:
> > On Tue, Jul 30, 2024 at 06:30:43PM +0800, Zhenhua Huang wrote:
> > > TBU driver has no runtime pm support now, adding pm_runtime_enable()
> > > seems to be useless. Remove it.
> > > 
> > > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ------
> > >   1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > index 36c6b36ad4ff..aff2fe1fda13 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > @@ -566,7 +566,6 @@ static struct acpi_platform_list qcom_acpi_platlist[] = {
> > >   static int qcom_smmu_tbu_probe(struct platform_device *pdev)
> > >   {
> > > -	struct device *dev = &pdev->dev;
> > >   	int ret;
> > >   	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM_DEBUG)) {
> > > @@ -575,11 +574,6 @@ static int qcom_smmu_tbu_probe(struct platform_device *pdev)
> > >   			return ret;
> > >   	}
> > > -	if (dev->pm_domain) {
> > > -		pm_runtime_set_active(dev);
> > > -		pm_runtime_enable(dev);
> > 
> > I assumed that this was required to avoid the TBU from being powered
> > down? If so, then I think we shall move it under the
> 
> Hi Pranjal,
> 
> In my sense, this was giving the TBU ability to power down when
> necessary(through pm callbacks)? While I haven't seen any RPM impl for TBU
> device.. hence having the doubt..
> 
> Thanks,
> Zhenhua

Apologies for being unclear. I just meant to ask if there was a reason
to add pm_runtime_set_active & enable in the tbu probe previously? And I
*assumed* that it was to set the device state as RPM_ACTIVE to avoid it
being RPM_SUSPENDED after enabling pm_runtime. 

I agree that there are no pm_runtime_suspend/resume calls within the TBU
driver. I'm just trying to understand why was pm_runtime enabled here
earlier (since it's not implemented) in order to ensure that removing it
doesn't cause further troubles?

I see Georgi added it as a part of
https://lore.kernel.org/all/20240704010759.507798-1-quic_c_gdjako@quicinc.com/

But I'm unsure why was it required to fix that bug?

> 
> > previous if condition, i.e. CONFIG_ARM_SMMU_QCOM_DEBUG?
> > 
> > If not, we can remove it give that the TBU would be powered ON as needed
> > 
> > > -	}
> > > -
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > 
> > Thanks,
> > Pranjal

Thanks,
Pranjal
