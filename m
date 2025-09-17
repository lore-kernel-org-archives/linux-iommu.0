Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009F18BBAE
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112566; cv=none; b=rDkf97+4pEEVO2C3RvG6h1QbUE8kynI53/x6mQLlsfIjl9BQ1pSuwujbUgt4krHa0yesxVbBb6MyDrSxTANXOQXVipgNS1G5xFQPp9+b9NMufIJcVuHb0G87oYkWIAJhCeU9dhYMJFYK62Jvc4dxumtpuQpZ5mDY7RMFP/VlvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112566; c=relaxed/simple;
	bh=vh4D3lz4qinchk1hC/kj6LCnkyHCrjcf/nEQajAoip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7O3jPPPnLrxi3D6Wf9oWc+R0Qcvl+CC3cyetyQtQgr2m0wfnr/mVRn/tN4h69rqv0/nucq7kQV35hKvuN+AM+MtZ04o9rN5BvTF9euiP4jU66xR1dL2UiAMWTVe0Pq5HFkI7/4SgBaxNsdaenogexGWopnVrR0hLSHFwBK38w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dutdVzjG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dutdVzjG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b38d4de61aso65179841cf.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758112564; x=1758717364; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vh4D3lz4qinchk1hC/kj6LCnkyHCrjcf/nEQajAoip8=;
        b=dutdVzjG1TIfQ139T6XjHtvHosdalvLuPUbkJVha9Q+fSZ7xULF3ilaNUuBaGwGkLe
         q5XHzxpHzXDCSEjFUx0PWBc0AttSqPKvLr7McQJYPunlikBGNx55jsLJ+T3cvd2IuMvW
         FMRZBU0HoOy0SUlbvBfiphOfJzkvAI6rsPIPclIXKPTGJ3OBRDb4dealIqDGaH4WKJj3
         aJ8Zn5mgvznhwBewP4m9xctXMEYYCECNb9Mu1XAbNOs8bZ+RIaE4jFsEqPeL48s2hVj0
         KJNdB7AEMeUuOig+Nq/50cunwfWoFqLYAnLWtARIVVrozu3tp6rWfXrY442GHlkOeMt8
         z96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112564; x=1758717364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh4D3lz4qinchk1hC/kj6LCnkyHCrjcf/nEQajAoip8=;
        b=fsruixH1pLSetNCDJmk4bxpLjw0HhUfbhVlqui2e5r/SiVCL6vOEvwPNJNpLhQIJqV
         AzEGwBWjwo+M/fgo6OJ7+du/WR3//Z6cG3bedLBE7tOc2qcY7AaL3hi1HlUrUAYnBUpr
         yeKXljdlILf3tqx/ZYzH5PSFJil91r0LqPbc09Xy4Am5qrKOVi/XmTIB04mqsTxOaAGU
         9MGsE2O53ToL1yJJp1bBuMWEp0IdjUij0AUiDNSSOLsn5YOHbYsE+AXPj3Vg2ce1wBAm
         CyWiH3ByWEKiBJZ1zELbh22/N6lTtr8X02hbxtULHJ04OD4LVXQFOEIM3BQK597ps1gh
         QK7A==
X-Forwarded-Encrypted: i=1; AJvYcCXg1SFDkI0Pmn6zZFEqYhWyoXxaekYQGx/nct0i+LxRDKZJietNXlprEkFGn4WkdebiLctt+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdtzFvJ73TRIgsTSwODFccKo3yelwkTLPM91R4wxKizPwO2GDm
	CWMniGhz+R8OeCJ6jwKyc+9saEzQoXs5mXBuZjCpMm+lHMMsevkKTL4XuZlh46UURyA=
X-Gm-Gg: ASbGncua5VImxcEvrbJBWAELlNcrAUowEQZDJkg8jWLDfCC1qJamAxrvxePYWt0iplU
	rH0WYrXJywNdJCFDMp++rCaqheZyy25yTK1mYJG0hJz4IlJV53LHnJ2BfB5LpUx/CyETiJwiXW/
	xgQ59oVp+wRX+aoT6wxmsb1ltH49tc4V3cCP6OYv9bzcRT/vVdslP7tSsQOeGxvT1f2BXMXxNwK
	xyNpjsm4XoRBcEOGFV+q+/58fSzWsKV1KtPO8fE8jhdo6uZaQaawM6pBiIWlFPN9RZ14plRCv3u
	szJ2voc4wCwL2/3a05r2ZQcyMdrKGvkar5EancoKFDEcpmTdHavmAN2/+ZkJa6lrCjI3nFLL
X-Google-Smtp-Source: AGHT+IEGvkvScyo54tTHL6/SrnC/aHIWG/EkopD8ichGedBCY62w/oSm7uSdoqmasg8xw4ohjLSyZw==
X-Received: by 2002:a05:622a:4:b0:4b6:2ca5:2035 with SMTP id d75a77b69052e-4ba6c6b4280mr24104781cf.81.1758112563531;
        Wed, 17 Sep 2025 05:36:03 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7af2426a3sm34649061cf.37.2025.09.17.05.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:36:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyrOD-00000005jqq-480E;
	Wed, 17 Sep 2025 09:36:01 -0300
Date: Wed, 17 Sep 2025 09:36:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250917123601.GA1326709@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMl_5j8G3IGulAC6@google.com>

On Tue, Sep 16, 2025 at 03:19:02PM +0000, Mostafa Saleh wrote:

> I think the fix for the problem Will mentioned is to just use CMOs
> before accessing the host structures, so that should be simple.
> If it turns to be more complicated, I am happy to drop the support
> for non-coherent devices from this series and we can add it later.

I feel like it is easier/better to fix the driver to use cachable
memory than to add CMOs to the pkvm side..

This way it will help qemu/etc as well.

Jason
