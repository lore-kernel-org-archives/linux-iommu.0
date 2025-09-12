Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94391DDC1E
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701930; cv=none; b=qiO5T6v0peXVWNPmSOX3GzoJkbA+/BnF4uh6opJOUcVpqcYrLAJJZOzHJEJd9PN+zTEYRGEVR2EvoNP0377gnab4hYyZXdWOnOSKWmK46kRtgdswullwUH9/US7oYNaycodwt006BOF0rhkdCVA1pbQ7IuiiSQGw+kG59Nmt2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701930; c=relaxed/simple;
	bh=i6r5BnwccM40MN1CW61UawFe6hxRBJLKBNylPutF2lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0ZKErilhe4m9DJaA5N6MomsPFMGOXbjp1gfAiTjgxibqLrRqK2qgylIRARuEYmBxW/BcgIIL75i8j77FjyDjqHuG2L/xTKQjr45YZRRMtUeFFdKa1tU0ZzsNCzERi3mHWEu0wvSm/byyJDuI/ZVpMCHK8EbZxobdL0EfW2xCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VTBDuGtp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VTBDuGtp"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so22649481cf.0
        for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757701928; x=1758306728; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6r5BnwccM40MN1CW61UawFe6hxRBJLKBNylPutF2lE=;
        b=VTBDuGtpjCuF3CJrpLHqC6EUrKkjf5kcBZOZrS9AghOh0JY76c2PwbZKMAsBO4GqfS
         bRCYTqe0fc+W9sjPQfPQ5lpcUzsXzv5htvtAqDA3vF2EKkoL4Ok2ksdPHAaLWlPuz9Ie
         D/gxcjpXYNBQvc+mfz5TvuAO93VFxJzxGIw9f7lCPKq5r0DOeXrmgpEtY6hw2tKABuX8
         MaQMEk8OgV27Q/5COjnGwZwN86w9gMuoMu0By+Boult8wtCBRJtSu4w4ErhEaMGZbh5q
         CkFnpWsNYXWTCqQ5nzuqpqOYLGe0TO/wzSPzvuOgJQbH4R5VX/8zyPEXMhiT8QWF/a9W
         wwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757701928; x=1758306728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6r5BnwccM40MN1CW61UawFe6hxRBJLKBNylPutF2lE=;
        b=o2tCIuMCnIW7wk7bVnDam58NTQdneqVnfedQHrF+5ytEj/RPVPkLJTD7fchb4xcJmJ
         /rNEKdr1oQVqLK1ZWXk2kd0ObKwPfDDCPMiMKeWw2DPuSNRC1l3Dwabau7dW0hFFAzJn
         7Cb75CnOaESE/V2iLGPhpLnlrTuT14xELW9woFIJVeffAD7IkGpiNmY8eoAkGVf1qeAF
         3GcGMXCQE7xi/NOoOMx5ALjySgLdNG8zVDP6dIWB3XeuJ6grHlFR0I7xVBJOAEDwqF/V
         HbWnctAkR0NSAKnjmp73SE/IvhtxxlqAwnl/8rPrOz65MQ4BOe7cYvsbCt5t2ExrRDnX
         mf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVsqY4KNmGol/4wVivPvz+PaqcxnXFjF+8Q+Xn7LyMh1WCyWhD/M6O7+1dWV5C3Yv8pf9OlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZOl5N+KNdOHvPODq63sgLfeFJVu6E7xEdtt2EByQ3TIcv2OTo
	grsyZ80KJ6Z3Elm9c6Dn7p9ohgZUahoSk71kyGcQR/QjV+Yf+qaERXuo27fxewKRSGw=
X-Gm-Gg: ASbGnct4egysa9jQ3Z1TEJeCEgT9p82+GZF+kK7XN1Gd7lb9s3qkYD89y1jt+eG93eG
	zUTmIE9kczXwFs4Ircsv9EuQ62DpYSbpA/OK4BEe+RvcJayaXHKN+ByxpFVNGBTTh1Qs3T8Gfp0
	HEyoewBegE3JtThK+jrODN8yq3I+2LMWDtY/yIKh8CVVdT6wNRWGkDMiUkx13FgPFF4zKb9xjL8
	KItmIEmrXr4yc+qCBJNTPl3knZgKmXxlncGKvxA5b5StF28EcviysuNo+iWFzmOpsllRR7Q0/Q+
	AFZlbSLfldq8yLHvmIppSzBvbHpqmiJw90dzrinrGLvp96EJpwIqFcbKTJHgkp2DV9rR9TCqz60
	sdjSbrN5Xew7WEt+u8SKCMz8yPGDx/R47l/cJZh6osHePgJBnY7tamE0YK7obb5ILFV03RpfbxZ
	j02kA=
X-Google-Smtp-Source: AGHT+IHZhwwJ1GAAakUbDyWBchcEmOdwvmn5VpYqCpYR267goBUbd6qsiAamIt0D50PzjBgabwMTEA==
X-Received: by 2002:a05:622a:2c7:b0:4b5:d6db:eea1 with SMTP id d75a77b69052e-4b6348bd37dmr127954271cf.39.1757701927559;
        Fri, 12 Sep 2025 11:32:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c8ac45a3sm313988985a.5.2025.09.12.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:32:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ux8Z4-000000047N0-0oCq;
	Fri, 12 Sep 2025 15:32:06 -0300
Date: Fri, 12 Sep 2025 15:32:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu: Add verisilicon IOMMU driver
Message-ID: <20250912183206.GH882933@ziepe.ca>
References: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
 <20250911155720.180465-4-benjamin.gaignard@collabora.com>
 <vrngq76nnms3jyl5hnxqnkimjc6kil66o6fdyqn5vm3fpovmja@cfynipjw7ktp>
 <694b9ba15cd67f41a38f4a65a3811f035cf8e99d.camel@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694b9ba15cd67f41a38f4a65a3811f035cf8e99d.camel@collabora.com>

On Fri, Sep 12, 2025 at 01:37:11PM -0400, Nicolas Dufresne wrote:

> To me this rejection isn't about Benjamin's driver, all iommu seems to look
> alike, so anyone else that would have sent new driver would have face the same
> issue.

Yes, many drivers looks approximately alike.. To the extent possible
we should be making more helpers and tools to lift common patterns out
of the drivers. I don't know how much of that applies to rockchip vs
verisilicon though. Obviously I'm tackling the page table stuff.

Much of the other common code is tracking attachments and invalidation
requirements. I'm hopeful the general method Nicolin is working on can
be lifted and shared. Certainly it is better than what is in any of
the three server focused drivers. But I don't know how much this
brings to these simpler drivers.

It seems strange to be talking about merging drivers that don't share
a common IP supplier or register programming model.

Jason
