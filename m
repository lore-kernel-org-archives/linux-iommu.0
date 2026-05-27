Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E96283FF5
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886308; cv=none; b=hjbGt7eynAxJmWftnHZL36BL7pNtwZYm5+PHphK5lqloZOwipe4MYJf/TsBdGPFyH8zzRNdh6wvxXoFLFXFfieWZ2ccR/OHv2mdkWkG6+iv0Pcb+rlfSosxGppYlbZk9FPShpDF/GjMUnjZ4ZDiOXmd9vn7WP/JZuwN3dajoAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886308; c=relaxed/simple;
	bh=3YV519fCLQr/dcnqiYK/3hUmKBEJM/JaljBjBD9SBqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSZVyIBmHjNUs4Oy8pFMTH+wM5WH4eOztDUaolsun/kWtR7OqxKAjNbevD2Sdn0Uo+ftL6LZLuFFxKgGJhLj5M04Uq0pOXlC15s1O33TwehULZqmOA8I4ObihADEy7IobiBDZz0RFnEHXu3CmxchRSyR9rHe3JtTrjDnZDAiv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZrSdpOQL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZrSdpOQL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516e1525aa3so47207041cf.3
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779886306; x=1780491106; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4NRS1K5QNG7yp7e4rqW6uFiLphCUgs0ec2fYNP5HFo=;
        b=ZrSdpOQL/RgfO2XJCSZwbDeXmpZubB7/KoOzhbZJKmmIXxf2BGHdfgt5Fj+jRlWtp1
         SpgqCpc2nhJv8SEZa/n4/+HB8IHGnbQxG1AEfgI1cTstf+0WJGnkau6pr9v4kDy9eMCN
         Pdr3QnGlpHsvMNhA2ScRslp9kHj+HYLwcpgfxFOw6KXli8CUFknTYHdrNavjETtSalsw
         QoM/GuPKFsLdyEnlCTCzBq9yMBRKphC7vDSc/nmhvIH1FV7u19QfBz2TsoRYg6gMP/yt
         C3ggvaE/InK4KWgeV/6mcy79EA9OKQGinHbyxoWpg5f2z+2Sd2VN0oOCYjbWUAuVoSCN
         sN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886306; x=1780491106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4NRS1K5QNG7yp7e4rqW6uFiLphCUgs0ec2fYNP5HFo=;
        b=dJEvqaaeWzNTAuky9d36uqSanf6GolXfxs/wwcKsn9TESxkGM2wfM5cN5UWKdTn5aK
         iDNO3BcCAAB5IIky2VneEXdNSiYNofVMcKSUMtgtL865quTtr9+sG6Da3uGjOOg6i7Er
         HiwttUQGpI6jpzyLlq7iQVQ6CodOFtNXvaiU+lOAzvLUb6ISlvYqo/qDjl0nwg0xLjAf
         FVDg9+TdJGAsM6nwUtD1PhgIPHyVQzCwDiZr9cncUNDKCMRKEtg/VtURLWaPnLTAXGQD
         xtjuIUJ4nfykmTf3+T/00xycDSC0RMRvz3ZwcwvQEYqxzy65XjoHYFstotiWO/O+wQLW
         9HOg==
X-Forwarded-Encrypted: i=1; AFNElJ+bzawQ8XRvjrruql80yX5bfxdLYwoXDmxWP3ZXvzLC6x2Q4qRU+DExhlGtu1WLtgtPtqXScQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKWAE49GIC4P1oGl9QP8e6+S4aFGjGqrsus7sGyhAaJmppFJA/
	YKCUrgzzNJsWjqzgVNEZkZ07ouvcSuH9omAAX/dHPlrENFzFSEAsoU4vf0/tXsoXNx0=
X-Gm-Gg: Acq92OF5HCvEpDMjX9C6xgcrYxsZWLM0KsQChQ1gUnDwCB0S+dq/PXWkEY19ZmfiZvh
	ScF7a0C4ysfzOEbE8OxpW1dX0UBYadtkAAI1aQ+oRT5IZx7XeI1yjsXkaGDMIg5YoMscrmJN3zl
	RFmkMWHeS+IiW34kZjG92n0CTmqZ91lI4T2cUJapu1nwBflbMcmCwzePf5MoDkIacywz+nofIKZ
	sEbtdPjDz2YmRK0u//ivE22uT0hJ0ngAYmqwdCCPE4o4tcW+BSMgDZUbONVaFeW7PX1c1nBqguh
	2ptnxY+FjImm5Sa7w4RneSaLdJ7YRBrNNHEbagz104RZ3W44n7U74EvqaBU3m8sgHzWB+flFgZN
	368zQFcCOSJeIqvsZfcS0C48Roa9BQpb9plfmbcQcgpQHyHNSpz6+mqvd2cZ+qVcY8v2HjFoese
	LCMk7bn9OkyZ3M3zyxn1t4WVqY3290i9Af19VRSZS3dVT1a2bmenNQHUiCdhbmTBIHMLSCT1nzE
	ZSnOXpjHAGl62JV
X-Received: by 2002:a05:622a:1809:b0:517:1481:54a with SMTP id d75a77b69052e-51714810844mr23315551cf.53.1779886301081;
        Wed, 27 May 2026 05:51:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2464sm41772341cf.2.2026.05.27.05.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:51:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSDjX-0000000EOpm-3BXO;
	Wed, 27 May 2026 09:51:39 -0300
Date: Wed, 27 May 2026 09:51:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Message-ID: <20260527125139.GL2487554@ziepe.ca>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>

On Tue, May 26, 2026 at 11:17:50PM -0700, Dan Williams (nvidia) wrote:

> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
> 
> TSM_REQ_TYPE_CCA
> TSM_REQ_TYPE_SEV
> TSM_REQ_TYPE_TDX
> 
> I am leaning towards the latter at this point.

Yeah, this sounds good. I would also include an common op field that
can be decoded by the TSM driver based on the TYPE above, and the
usual in/out message buffers.

Jason
