Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5625A337
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458531; cv=none; b=eTdPnygB5BPEKBa6AWtzggeCAx+GxpxSKiFGxBwBYS/8UJjbqmaAaCMIxMHhv2LOgAeCr/wCKzs+VjNIvnwH5pLowCivoJRGk4vrAxW8HPUXDt47On6EHeOb47WHw0T6mfKkYyBqNcDqQgvqLxlXGk1mvtS0gPvburtOu12SkMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458531; c=relaxed/simple;
	bh=fhabTkcVtgXeuhvENjSq4/Okemt6RfjhHj/xoGpKUSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6/gLzMeM4G9ewxi/S2UhvckAWwMWUhSgy5xIveuw4Steyz+KojlRVQ62VCnd4+kT8Otk7pBb4G/sWUseCcxGjwAAOiyJszF0uuxGKhD59Bnhr186aKJ707a8qVqFelvmbMiqLU8kIDMWfHGjFVfusJfplR2RqNcU+RuPtmTLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQSnkRnR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQSnkRnR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2263428c8baso250465ad.1
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746458529; x=1747063329; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LklaV7kDHiGqwWE3X5vnOYMw72lzfM11dE8EV/VGR+Y=;
        b=NQSnkRnRHQlwYshuZ96Q19aZU6oAJD+o9dMKbsfV9Q3hFUty9J0iepE59wdi3fr/mq
         jcbl0rCXDIEDhqcexDkYlP6Cw73b9SNItWiWpkX7lvVaAiRh7cJ8O6sZUc6c8Uq6BqYj
         aCVvgn//zfx7FOF//XtHO2iC9YOoCkyi/oPavCFMvsOsh37gAOKV5uqZFJvuV+pNS/F7
         tguIMVsx1JCFh7WCfKLcH87R9JqXMEZlmW8+cHoqyYV31Ogd8hAMlQcjLpmJvkZvrHNR
         2d1Vi/ekeZ6U3InHiFcwlSdpjtU7bsotPzWzI8bgjcTDQe9W027aFtHVYh2UnKzKax+F
         X5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458529; x=1747063329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LklaV7kDHiGqwWE3X5vnOYMw72lzfM11dE8EV/VGR+Y=;
        b=aJltm/plix222wujRMqqJQ1QdekpBFjIjbafbB+pBgNLAPAM9oBi2E1nD0h87QunXL
         1Y+Pj1TAJ2iRV/RzzGZNzQ7tKR3MBPgdfhfFfGtSovWkwAP/VqyHM3Wq6oITQ4Gh41Pq
         eyG6Dzz/6ht5iyHzL15VzsHz/iVC/uvxA7waYqlIh+hmOK1883GtSMu5vkgHB9RbYDhZ
         2T/9RFdoiqe249BCQE27kS3zgT951+P1np6SFuPsj/qpIoIvPGIfAcfzgvo0Turt/Q6N
         TfCufD/Vk4kfNMESdBPmMkY2ed2zptCwlkicaEaXs7KngBuLqj6FYiSFN0t12JKEHHUP
         fPNw==
X-Forwarded-Encrypted: i=1; AJvYcCXJVdVclmfRXYc6mOwaldha9rZ9M4qiJ6Bd7Khd66lCGGQHnIqHdA8nCt8hX2yBE9SdorsWzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr5+I6nIVvkm/Y8aO2L8WqnI+ZOa2zdrn4SZy5CORKykqpZCdx
	qopw+YV2rQMZVUhE7EBlSgIcLGiMZS5yUaRKxJ4jv3oAg5Uuv0iJUHWx4a2Q+Q==
X-Gm-Gg: ASbGncsiY9n293q5+huHZtPsGqUD+jGXqqzE/z3NgLG1OvVUUeFcutSnqSOLcUFQqCF
	zqVtndFrpft/YZbJgwoqX6B/xcQJv/6usNYKR/34NjCD6siZq2BMQv5IJF0QPJnRxIXEKURr+4t
	W4MQur7G04yn7jWUsWVtQBne7zi7/AcW27dvOVRSbb0zGfe+/sblkMfpd065WpBgjX5DgCubcOg
	Kxxp3YCsBv0XlK2a3kVWW/2xK+pnff+fPQgohQrHCMmlSKDrkKdwLHYba3cAsD2Av68CoBA7+VE
	+Nf61yXt3itGJskCx2CsuYFYgak+rZMKetQfk5BPNv6AsMQtD2jivaT8LJSvk8HSpncrLp9a
X-Google-Smtp-Source: AGHT+IE+xzR5da1c5fYy3yy/yhasob2GblqxFYHxNvvQwhdLLx9Vba6CUPZi/+K/uJF3ZP10xQrdDA==
X-Received: by 2002:a17:903:2446:b0:21f:4986:c7d5 with SMTP id d9443c01a7336-22e31744dc3mr132125ad.8.1746458528942;
        Mon, 05 May 2025 08:22:08 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059069502sm7115111b3a.133.2025.05.05.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:22:08 -0700 (PDT)
Date: Mon, 5 May 2025 15:22:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v2 05/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aBjXmaHBaXqruN7-@google.com>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-6-praan@google.com>
 <CAE2F3rCs3-Ppoa+y-X9p2HBP50gow+bP-_v+LX0SYc40UmgVLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCs3-Ppoa+y-X9p2HBP50gow+bP-_v+LX0SYc40UmgVLg@mail.gmail.com>

On Sun, May 04, 2025 at 01:29:36PM -0700, Daniel Mentz wrote:
> On Fri, Apr 18, 2025 at 4:35 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +static int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> > +{
> > +       if (pm_runtime_enabled(smmu->dev))
> > +               return pm_runtime_get_if_in_use(smmu->dev);
> 
> You named this function arm_smmu_rpm_get_if_active but then call into
> pm_runtime_get_if_in_use (There's also a pm_runtime_get_if_active).
> Shouldn't this function be called arm_smmu_rpm_get_if_in_use?
> 

Ack, I'll rename the function to arm_smmu_rpm_get_if_in_use to be more
clear.

> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -506,6 +506,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >  #define MSI_IOVA_BASE                  0x8000000
> >  #define MSI_IOVA_LENGTH                        0x100000
> >
> > +#define RPM_AUTOSUSPEND_DELAY_MS       15
> 
> Consider moving this to  "iommu/arm-smmu-v3: Enable pm_runtime and
> setup devlinks" where it's actually used for the first time.

Ack.

Thanks
Praan
