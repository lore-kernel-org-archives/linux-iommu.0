Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085C6FC2
	for <iommu@lists.linux.dev>; Sat,  6 Jul 2024 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236275; cv=none; b=DRLjP8vBCFLVCbSB2lUOj+GA3zX+Q198bB6Uoe0Ey/bUTz1SVwcEhj9iI35RmKOn0N25W+am8Zwc6EjiOzdoSg2NEFfSIq38e0TPMb+zs2BBLEsrpliROYjikZtLPWNnB5htP1Ve8twJb4Jai54VHRMyWEYlGjnwc9Tmj/zFJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236275; c=relaxed/simple;
	bh=Hb5PgMHh9aLvQi1yuVN4GWqNjsdDKqaYmaMQZ/b+tiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtL7SxBXQrEKlXAGrsxofzGCTaURQ7tV4aS4ULdZN3RqY/whhoEXbgaQvBDeXhWGuBPPaGtTQenENUjydfPRPiP2LdhVTDTThL4DT7zHw6u9kYmjyAlMf2E1BggDxj1pIiv83hKAQphTYi269lVqjpTH09QXjEOtUQ2wfyZUiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1715945b3a.0
        for <iommu@lists.linux.dev>; Fri, 05 Jul 2024 20:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720236274; x=1720841074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Pb7EbDUVGH98ibgR3s40PMLBJFydYTcIKO50p0umcU=;
        b=ryTfiQcG2wECQeRFECG3edD1Ycz+Vh2l5tBSpbhr7v+6s3rPD62vXIOVvK2dkqOg5m
         XHGs72QgFlUtG/Ta4j/VHp3hR+JV3jDwIPhKqEkDY8rpXbcHW1UEwmpajrPNma6+kWkN
         aoDZRsS9b1Dg6N6+BHHTwEUJfd8LZBrmk5Qu1noycwM7JN7YZKLfwJ7zHjammn8CLW3v
         UcdNM5exJJSr4+2B3bczmcIBjenraBHhc90XDCB/RAIRpks+Q/9H/bsPzVZ5FHO9G987
         kOBIoMR7t7ug6E3ybv05qaPWcsIdzzHtNv2qzGNMiqP44BkJLFHxVvNjs4R6ZGXvQObP
         ZLCA==
X-Forwarded-Encrypted: i=1; AJvYcCUn9uXuMLukV9KCG1/9Sb3eJyROImOCXpGuuAdEW9OrxRv7Mohx1b514y5dsvcdxCNKa/6ztw/Q9vJsun+xzn+wvSiwstc=
X-Gm-Message-State: AOJu0YwI6GYQmbbzxidPMjisgoBhrs9efDxqXFGz+7dXCdI6MlXc5llg
	WlwNKODrSamYA38spMbFr12P3INA6RFvi4CT1Zwxc2mj4gA6enj2
X-Google-Smtp-Source: AGHT+IFURMNMv3i2QDNgjzV+meNyec/XNEWMDIioYfNtMKTQgCJfyraBJJkOdc75XnBjTu8O+vWrCQ==
X-Received: by 2002:a05:6a00:170d:b0:704:24fb:11c6 with SMTP id d2e1a72fcca58-70b0094a6c0mr6154295b3a.12.1720236273403;
        Fri, 05 Jul 2024 20:24:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70afeb4186esm3967297b3a.41.2024.07.05.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:24:33 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:24:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	liviu.dudau@arm.com, sudeep.holla@arm.com, joro@8bytes.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, ketanp@nvidia.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: generic: Add ats-supported
 property
Message-ID: <20240706032431.GH1195499@rocinante>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
 <20240607105415.2501934-3-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607105415.2501934-3-jean-philippe@linaro.org>

Hello,

> Add a way for firmware to tell the OS that ATS is supported by the PCI
> root complex. An endpoint with ATS enabled may send Translation Requests
> and Translated Memory Requests, which look just like Normal Memory
> Requests with a non-zero AT field. So a root controller that ignores the
> AT field may simply forward the request to the IOMMU as a Normal Memory
> Request, which could end badly. In any case, the endpoint will be
> unusable.
> 
> The ats-supported property allows the OS to only enable ATS in endpoints
> if the root controller can handle ATS requests. Only add the property to
> pcie-host-ecam-generic for the moment. For non-generic root controllers,
> availability of ATS can be inferred from the compatible string.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: generic: Add ats-supported property
      https://git.kernel.org/pci/pci/c/631b2e7318d45

	Krzysztof
