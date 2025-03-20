Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEE212FB3
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473644; cv=none; b=X9Gtc4sqKqG2YtC9BEFGSQ6tHpFSQFudMbJ0sW7etLPT7LalSZMyzriZqwyqzx/2ajCcMvzJBsFmmfJfTPT0jJ/Ew7oG1nYv2N4RcdZuyXhggDM9HfXIlDRxwlPDB2jQdd/JBu8wsgOzfOSwpa7SOUhm379MvpkJpnqPxPisjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473644; c=relaxed/simple;
	bh=0KqmKcwnP2ZM8J1oayLgNQo1WGTmWgXX7O7nQamUJHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3H01uFLcI0w6vMRo23QLbeB3n7kVmKUO35sD1AS0UCrtzyZZEnel6NkxtO8CnfhbiZ+Z1ViMsnONNhLhVcT/Z4wMFAiCXsd02ect02N64DkjMYgG9M5ydoH6s9YXKT281sczbzfyCmMDXryZ/AMrS9gRrAkWkpX2PLmBil2CQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ST7+zYFO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ST7+zYFO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c592764e24so63084785a.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742473641; x=1743078441; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owuoEKLJ8GyqS05+WPOOz/9ttskeFhIAhs7NlVT92ic=;
        b=ST7+zYFO/g37JmXNxXjsFDmBAZJwSFDPQ9K7VTua+3+rrnygBvC2roTjbDG23fx0Q4
         G2CCU0e2fwgRleAMInvsKMBrrxOGdlDB7XDbDnUcC7qZ/zfFqLdFMU4cg/5XlxIfDBF+
         WFr9QFHplM99xRSzC9mK9QLpJMtyU/OVlCs2xR+0D75ulDk5OlIVGpmUAjBP1N8hEdrx
         WO17oRbmQTqJL8ebY0g0Hqk6VYr3bq7FWRaK7Ry9MnhaPuCE4OUWJHeG06H7PU/9wy4+
         FXbSCrqxB+RFeu+aZhkSqObozpTaKweb8J9pkVrA5b/sJQes1iakfA9XyHcXwc/jMzm3
         +zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742473641; x=1743078441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owuoEKLJ8GyqS05+WPOOz/9ttskeFhIAhs7NlVT92ic=;
        b=ExOM8ulRX7gPLLWatVXhWCG4KqW7JXMyzupu8+aOgnEcSpv713RVVQYYuaBiPqHQSg
         6+uk1jl82ZR90wjYK6vwLRNJcLI9AFw+FVPahl4JZIPNU5/JI9QFF9zrARt1fxUYEbF7
         XBWI16FuMw2NEHLpNof4jSFQ6F3lDZZD8A9yTiZ4WBu2fCU1T35LfOHs0j/8P56Q2JlW
         uI5+69QghmQS7Tu1AtjICfRL0bOreKjSGkcy84zQ3xgRo9jrZycP2VjW1n2xEpkw8pBK
         fiFlxAAoPQefkLQKycAVWYJuuDOIClD00qzE7fv1dSuIEpMRo1w+IlxT8jaxjTg9da72
         I6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXL2GSR9fFobfqeLYAy3yNb7ZTGNqmAl8PPoDnMQtVStmat2xSwSKFIULMvkpVEWc1v+FVRXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFV7Fl6/G3IdldzNi8D308HjckyqhHPPAMpoXlyLiukeuHYYDh
	9jQV8go1GVV18UFrRF8i4obORG+d/iDUH0UHHa874ZcBEgohH0L6FBU2xTtP0os=
X-Gm-Gg: ASbGncvDhYwDFRMIJ+KoNTqrm/PJ1uohEYdKQiLCwAKY7bkLhZfpyQTzJDzyvOaT9Xg
	bwPqAR+mydxW1hu24Hgqf095ZnH716bTmaciqiASOD6XNrpWuqm38mHVBPyBmbCnlscbXONfTsr
	L4XFBlXGqFVmgq73TrGuXQztRlE1bUF2vn1VCVLB9mv4L/DOBV9WT62jrkhrcJgtYxp2bYjMGmG
	f7uJpKxikEOhy2HN61haaFJeGDs4QjrGxhBihaQEVCc5+kz3UVg0oMTQFqei3CKSkTakl0QHQ+i
	lLsIyya9WYvXk0ZxLPOsnnyvsTjMn/wmhdLUOab5ZamOKQxFugQ9X5xTnupIwBJ1t0XZOx2zG67
	BlGAPpzgULAqoqCMbzA==
X-Google-Smtp-Source: AGHT+IHBPIN78tejYWs7VfIlk4YaIqTbv/OkaggJ7vH5SMoIZQdAyhpfUCC8gDblTwanJpuz9ATgQQ==
X-Received: by 2002:a05:620a:f02:b0:7c0:ad47:db3d with SMTP id af79cd13be357-7c5b0550e7bmr538847685a.21.1742473641194;
        Thu, 20 Mar 2025 05:27:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7859bsm999375685a.34.2025.03.20.05.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 05:27:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvEzX-00000000hOS-1nJZ;
	Thu, 20 Mar 2025 09:27:19 -0300
Date: Thu, 20 Mar 2025 09:27:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Linuxarm <linuxarm@huawei.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [RFC PATCH v3 4/5] iommu/arm-smmu-v3-iommufd: Use KVM VMID for
 s2 stage
Message-ID: <20250320122719.GI126678@ziepe.ca>
References: <20250319173202.78988-1-shameerali.kolothum.thodi@huawei.com>
 <20250319173202.78988-5-shameerali.kolothum.thodi@huawei.com>
 <20250319233946.GF126678@ziepe.ca>
 <f654ae10e55e4142acb83eb926bb80b2@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f654ae10e55e4142acb83eb926bb80b2@huawei.com>

On Thu, Mar 20, 2025 at 09:30:45AM +0000, Shameerali Kolothum Thodi wrote:
> > Isn't kvm_get_kvm_safe() in modular KVM code most of the time? You can't
> > call it like this right?
> 
> I think it is safe since KVM is not modular for ARM64. And that is one of the
> reasons I thought I will hold the KVM reference here as we don't have to go
> through the symbol_get/put calls here. Also IOMMUFD is not using the kvm
> pointer at the moment. Probably I should add some comments in IOMMUFD
> to make it clear.

Oh I didn't know that.. Interesting simplification

> > That more closely matches how this will eventually work when the VMID
> > allocation is properly made to be local to the viommu.
> 
> Ok. Will update.

You should also block creating a VIOMMU without a KVM for the same
reason.. Really isolate the S2 to only being usable with the KVM
shared VMID.

Jason
