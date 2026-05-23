Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F12744F
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543241; cv=none; b=lk/3Emry+wT2jfiFo8o1XHQwPpOc2+Runc7p5vK45Mgr9nb8TsEwhWLCxAFQZCEn9R+74ZauA5dMSY8A9QO7aRJzCMLKScupJw4/J9A0iA0KpyB7oDmpYKpmyx38X3ShOn6vA6tC+gW6DtTBspSJplxKc92oIOtXuJ9pIssp7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543241; c=relaxed/simple;
	bh=5iCgyzuUNoEV0PAomPH6D8+BcG7Zu6jTnS9GnfIcS78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBM7Ui63AyQFJkRg/p++GK7wJkAxuNRxYsCGdbzpaObf5VdLSy0iiSm9SBWoaFMDkJDt0vBgmKIsMIq8XyDuN6b+3PAyqkrGr08vIW22bTt8/dXOwY1hTx2kcDvmo8jhK9LngzYe8hQCcp/NpASMzPz5/EGM6pdXVymCeR5NRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ni+C9DR7; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ni+C9DR7"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-514ae601e01so85852171cf.1
        for <iommu@lists.linux.dev>; Sat, 23 May 2026 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779543239; x=1780148039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScTPfMS4uBwckQ+rbDYkW0EYBsK6B7QnfP4yXtD8oFM=;
        b=Ni+C9DR76vgPbCahkajx91559dLXYT4xw3jbrsl9F1YRmQeHpwp6SbajUNRnFaxmxv
         F5k7kyJvY610VEEGCNHocgktWtVq+SnTix5aKXPOLTi2fxQmpQo5Gh+dS+AtT1WrsfZe
         8b3lS6NepbW8UYlEuzm4z9TRmdLkQdlNaPrDxEYDBCyoqrqpV4Y9IpXGw1Hzz6PfSzX4
         kxiHDDlP690PLzr71VeNmrPKK4eRXbRQwfuED4TdVdDVFmEVxG54LYf+37I/yertS2VI
         gW1/KlB4d7sPhus3XTvmd7fvd7DDIwg5D3OQQjl9+MYrAWOWy2OOSVHBDtlPc/1HF+HV
         /PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779543239; x=1780148039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScTPfMS4uBwckQ+rbDYkW0EYBsK6B7QnfP4yXtD8oFM=;
        b=T1TCi6DT4CBR2Wwf5seIyFCvC8Io+ppgSXecGRRyIyjnWcQmdL2PO5U4YE/+0z7SFg
         r4QzVKCxXCO8KZSfShnuY+mqTQ71XCWCxsfTbLFZxKpZsT14TALOhVcI6MANRvCyKDeG
         gW+XqzKcA69GpOooi9CM10fgGOX1uQs798H0XCxq2gDEtzgYEdOKWtTwdz/eOBe5eXMy
         +FNnXw+NbppZATTido3osM3ftwI8ID7hxawj3vRqTc/w7zNH0BxvwA7gH02FWaR9L/84
         pD78AfObfrizQKSGKlqePe8JOuj4gHk1vsyhb7I7TOH1bsSth+V++j/EW3R5EoFC1Bai
         JEmw==
X-Forwarded-Encrypted: i=1; AFNElJ/Oa9Bf6XPsReUo0eY1CqjPNxl2ZS0Ho03AGVsZ69YcIblIAfY1O+VDbuhAMEt2bkqLzvAjlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxssJoh5lbmMtkJYM49xsY7OhShAv7KarpvE1nkfetMC6A8fa2V
	U4jV3aCRybRLxVs+50iQgXlyUO3Rx50rTXdhBkV342f8MJZS9jIzeiwKyZlbXlf+BQI=
X-Gm-Gg: Acq92OFlzBfiI40qpJ8V58yiEcotR2NtoEK8R3LYjPOr7I6VR0hRyFC1cc2WoRLCJg6
	U11JoA8WG8LfOYnk8mF+TbXM0mWqCIkuXeLzzrQ5HVEUmyjvcybqS6cvcfKo5zobgCbSqrII7bO
	9ILeyxHcFZ5oC+kOhppk9aedWxfbCsbiehmfyadLAdgkJKn/tqEVx0ufOAsR8EI5t/MIx21Kxrm
	NrKDGRdDFaEdl7Cpy1okTZ8fSg/72mBFeMdzS+j6SoPrS6FPpEnBw2LPoqSiJNrVk4l0zJXNBb2
	uLr/6Us9r4yojTqDJ5PIoBTq0OOKx90e+SHgecDZvk97o4070yUjsmvy8juFtX6v7qu5RqZhnKl
	5V5Tml9NVBK3CLvEeyjT/OzsFlDLPZCc1mOQhuMAcEckUuFZXJapn1hqKI7vhd1IJKvAHse3fT5
	BNFqfJrdsXQ44a4NG+e/CGZ1rgjKpdGI6au+2OddH4D/f8qbEDRS8rBle2StkRzzTp4cfZt8ZNg
	dULeo8CPlEGTLXC
X-Received: by 2002:a05:622a:588c:b0:516:e9ea:1c32 with SMTP id d75a77b69052e-516e9ea1f17mr7464221cf.9.1779543239413;
        Sat, 23 May 2026 06:33:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131524esm46180116d6.40.2026.05.23.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:33:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQmUH-00000006Hta-3suz;
	Sat, 23 May 2026 10:33:57 -0300
Date: Sat, 23 May 2026 10:33:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260523133357.GH7702@ziepe.ca>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-7-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
> @@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>  	};                              \
>  	IOMMU_PROTOTYPES(fmt)
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
> +	, .preserve = &pt_iommu_##fmt##_preserve,	\
> +	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
> +	.restore = &pt_iommu_##fmt##_restore
> +#else
> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
> +#endif

Don't do it like this at all, new iommupt unique ops should be routed
through struct pt_iommu_ops

See how map_range/unmap_range now work

Jason
