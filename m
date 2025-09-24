Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDD2DECD3
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718436; cv=none; b=GgBKBGH5BV6S+4FJ2IU+Sy0pGXjhHPE+Q8jKeV/UTdcS7u1GVlH+xu/TOMeHgQwHGZxmZEXvW0C5I/jMgqm8/0a7TTwBXfhr04llMmaMZOiyv1Gm3C2IPavAsYe43DznO+LTgRr4k87UHXkmbiuMELBsAXxjFdHO7ZsaPpM4qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718436; c=relaxed/simple;
	bh=/5MGxigs3J1izem4NaelTC15xYHLUjM3PWiRIBzcSYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGXrr0DYpnKOb4HJuASUItbJhRfX6PjKbV27yc9x9uWPKOY8Yhhly+MTzFdnYYaisF6xwdw9T7HmyN68WdzTSnXnVUiB6h4/r+//UkZ8HfM3xrkgQAJr3SL8W/G09kX/H9SbieWzLLpVI2DfeYLbu78jJ+XpGPGUysQZ+LasQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IlsY85u2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IlsY85u2"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d46af01e95so15656531cf.3
        for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758718434; x=1759323234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLJtOAQYQBrP5x4tORrpG8mOmCxneDKETMlKi1kK3fw=;
        b=IlsY85u2uHc5zQqn0kJykmsIbZIRtqkt8qR2Sii0YMlH5TrT/TSahaq/aXR4NKWE4h
         1J8pz6DfPpylRoqvEjk8y5H0cMYl6w32by3f3qmB0CSW3VtY8EGjYtJGTcGL1YqMryu6
         9MOgBXB2AXx/Ob/Vd/wD6XtXg1AonCGggl62/W7vVVlUt1yS9oWXXyOdfKh8gP8aVt1F
         egVPZk3mBlRS5okWO6RLmHypp4VdX7154sAxfQXhxicf5051xmqby3GxTmaPaGrm+cTG
         GI7q8b8WCt2F7ObSO4I4NKNG/rgy8P8NTfgrkAC1XUNbReCx8n1SBeOmmwdCG6yAw4Ie
         xsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718434; x=1759323234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLJtOAQYQBrP5x4tORrpG8mOmCxneDKETMlKi1kK3fw=;
        b=UXU/DTdVIX0ylrW42XGS6A+7C2uROHES+zAxOPtMeUvjBFnC5vOFmR9BMbftqJ67dK
         F4e3idaGcXLfyI2GRA0Hew7Vbj4IQs30avH4/M2IWzxSrTVPC6UGyOhC3e1dfDcqYekM
         Fw9Ny+DIYsof8m0es0r+r5GnVW0bTCEJ5a7D2ya1CWGOCDeV1y6MxNwlaEYtnDfkIY2X
         0xh7pet0lNTsN4xZtcHHVMN5dEats/357mrP1UR1icPYOMS9gMC/pEFlpknONjtkUvkb
         l5kEkr0S503LceM1kuyb/ZbEHwxHxdJWhoE1IMAQs0xwI/Nwr+Uh6vdUW47/y/MeefoG
         2fWA==
X-Forwarded-Encrypted: i=1; AJvYcCWa/jHRvpKMtju5CczgVCC0+euNSeXy/upoxnZFWHVFVjoEUiLhjsPOtxuhroVcobCdATM1/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCsvihNirW+xaVd8rOfkV4k1801/UwfcFGrZDlK7aVtFs9HYXN
	pM0v/AUjV8LhsH0trVTCMfgIYOQi7QlDYPtIgd9lQjrOMYu6Pr/OCi1WYVApX+FEU5a4JJLRdEl
	crQY6Oec=
X-Gm-Gg: ASbGncuvUijn9ScM3VQbBbuRNjo2r8UHZkH6Oo06TFjdQqRN31Y8ozj0//Hl7U9q6Tp
	CXEG1By8TOXn2lbQ8aB8OuZ03MbEhwSzRvl95BJ5+ZH4alcvA+Fu8vJBG6VV5vA5PadJkood3ai
	TUA/iH5ErpQS3VEZloUms88Lr5qIFbIqRzQaYqiYcY5gnv8r3Zc/UKvIOhmiRNVyHy9OjDSHtPA
	DOQy6uXRhSbHoDL2g5FcX/jkTSUK+ba0SyofiGyyc4lx2Zgqq+6AvFDC4toe3FTgY8DcXVs4K8p
	aGqT1l0uwGv+JujNtZEzlr5sx92q8lcaeTSLzLS36lMLmKonSfwW/bgnNtGl4IGg+XgV93PG
X-Google-Smtp-Source: AGHT+IH4X1m0ozX9VFMidrzI196ZEXlBER0vjDcqpSkizW/TFuizOLRFVxvmByAOOPzfWD0D8lhF6A==
X-Received: by 2002:a05:622a:a11:b0:4d8:afdb:127c with SMTP id d75a77b69052e-4d8afdb193fmr20716651cf.43.1758718433855;
        Wed, 24 Sep 2025 05:53:53 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836305769ecsm1174409785a.42.2025.09.24.05.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:53:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1P0K-0000000B7zT-2WLv;
	Wed, 24 Sep 2025 09:53:52 -0300
Date: Wed, 24 Sep 2025 09:53:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v3] iommu: Fix iommu selftest running test mock domain
 fail
Message-ID: <20250924125352.GI2547959@ziepe.ca>
References: <20250924074359.41510-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924074359.41510-1-kanie@linux.alibaba.com>

On Wed, Sep 24, 2025 at 03:43:59PM +0800, Guixin Liu wrote:
> @@ -1077,6 +1077,7 @@ static void mock_dev_release(struct device *dev)
>  {
>  	struct mock_dev *mdev = to_mock_dev(dev);
>  
> +	iommu_mock_device_abort(&mdev->dev);
>  	ida_free(&mock_dev_ida, mdev->id);
>  	kfree(mdev);
>  }

I don't think this call is necessary? Once device_add() completes the
iommu_bus_notifier() should be active for the device.

BUS_NOTIFY_REMOVED_DEVICE triggers iommu_release_device() which does
dev_iommu_free() and frees the fwspec automatically.

The only unnatural condition is if device_add() fails then the
notifier can't run and the caller has to clean it up.

Yes?

> @@ -1126,6 +1127,10 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>  		goto err_put;
>  	}
>  
> +	rc = iommu_mock_device_init(&mdev->dev, &mock_iommu.iommu_dev);
> +	if (rc)
> +		goto err_put;
> +
>  	rc = device_add(&mdev->dev);
>  	if (rc)
>  		goto err_put;

So I will suggest one further refinement to pull the device_add() into
iommu_mock_device_add() and then it can internally free the fwspec on
error and don't bother with iommu_mock_device_abort().

But other than that little note this looks fine to me.

Jason
