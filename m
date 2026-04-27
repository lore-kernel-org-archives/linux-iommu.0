Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC73D1CAA
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298743; cv=none; b=C7YyKw1Jzk54fROARuR3umSRB2dAAx9AtMNAd32WMfyDFPtYF7BmPcS/6CQojZiyAwv7CdMmWsPK26H7zZZZdPqgYqXPrDfQGmintR+wfOfQ387N0Q1q8af+PN1WNh5FtqHcc4AwABiHuhv/C4y7vChkJK5kLsiaNqgNk1yb8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298743; c=relaxed/simple;
	bh=iGS050Vh31Rx6ADQYBwC5U1aYufsbvINEeiUPc1swZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJyY6/XdteZ+QSlROieKJ8yXefLm91WO+ST4nELf0iUn02D3O5qytAzp8PuC46VD34DvU7yO6ATtB+1hZdsbfbtvWlfsftwS97Xt6vhWSDpwQNPoO2lrIJ9zcj+PZbvHz0xE5O1OHpMgH5isuRUJT/5aEY0nuHfA45ZBfs8LZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Nc1a1bIN; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nc1a1bIN"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a210c813f8so65837646d6.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298741; x=1777903541; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGS050Vh31Rx6ADQYBwC5U1aYufsbvINEeiUPc1swZo=;
        b=Nc1a1bINPsA4P83iQoDWYVtguEHt84F71OhQLklT25BxabyAxQAPcvVJ23W6rwbcZ7
         GgcoVfpMvjUSykZ6AdDp/SCx02pqAsV4gLKpgfX86qn5n1bkMaHo0ESNHozC5uBLPdY2
         C6k29wxCcTBMv1c7CIvT9jkhPJj0KxJGU9xM2MauIe/ej5smKKr2dkkVS2tSj+/FzEJY
         tJdef0Q5bOkVTvu/aFUoTmLCLz9qimuyUja0dl4FbbmyfHMp9v1cCR20t5wqi40qj7nV
         IqTH7ADKFZj3X7dVKWVG2G+L/P0u8dsBVrHiuv0Y906VDY3xU3N+EZnXKAPjpzxUVps+
         9FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298741; x=1777903541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGS050Vh31Rx6ADQYBwC5U1aYufsbvINEeiUPc1swZo=;
        b=NX3qCWnknL/FYvld8qgFSgyZlPQodDToq19g7olo9VELhUJca+56VcMnd/tocvE5Wu
         vefcPP09X1x4ZgpYBvVTE6I4PlYJ1j3dwZQA0uGSHgqxv6/J1q29rlJVtUG0CBDjUlwp
         koy3SUb59gDTkZtHRA46Co7e58Bc2/GBulX/qkjw2e+ceKFEpnD7vwDtuY/XFwwBvibL
         ibjkxjYBfkypgyA346D77cqJ5RdffZUR/1a+PkXG6GLl8OeBIvOguFIVnj2bkidGRzGx
         mhStant0pt3LQL0ic/DCavMp996A4eQUqQH0yKnouC/hR1K5BTQ7nbQhWbVaxQVbKXaM
         wePw==
X-Gm-Message-State: AOJu0YwLULqth82qMRrxaT3C3QlsQ4ueerb2l7OdI1r0zKBZH+YxpTxV
	NEkBUyilmL3CWSXxuxI5LAjhdqbFOZSMWhVKxlFkRd8s4PgOdBuRsLlFTkKIm4CBaVc=
X-Gm-Gg: AeBDiesfxlHzyxXH4g1ZuPgesPo5QyQjgAeXAu8xs0x+5dU1rXtsmvXhz6O5MH21BB1
	qndHLMaBQQg6oHzPtJkzZbf+GZRkXwAtopmRyyGM51GjSpTbzyxWVulNcrCrj/X8Z1d+j0uVr8a
	7otiXC9zc1gj++S1lk2Vm0j+pqi298ExtC89YPpTQdn36pV1kX0oqQ5pAO1UNqSCiGlzg5qAtYq
	9ekCidXmAOq3bI8c/bLSDSIA49GjjjjRHKzZg0r9DSou3plVbUn8QPuC/Chrd9XKc00kK8bGzGq
	gLtuyrv5yfeC70p31eTEn69+i/ra4ZAlPSeF4hztUVv4K1l40WquiFPOgTD/FDbhYPevJVVdbIB
	Zy1gxDoPUfEfZEUCUGAASlr9lvHRkyBAIjstd2+3oG9J9Dlz0T7whARBxa5WuVblfOhyN5GuWLr
	gA4m96MPB6y1T5l5JoQh9o8KPceIvpKC5SzGlqrTU0Sw/R5flEWaZEBAz2fJmDdqaff/KK5wFrn
	BAtQqJZ0nrwsGWVTAa6zDgtXfY=
X-Received: by 2002:a05:6214:489:b0:8b1:f3e1:5e12 with SMTP id 6a1803df08f44-8b1f3e16020mr426493366d6.14.1777298740980;
        Mon, 27 Apr 2026 07:05:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm260265136d6.4.2026.04.27.07.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:05:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMah-00000003YNw-36NU;
	Mon, 27 Apr 2026 11:05:39 -0300
Date: Mon, 27 Apr 2026 11:05:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260427140539.GE740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427061005.901854-5-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm) wrote:
> +/**
> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @scope: Bus-specific scope classification for the guest request
> + * @req_len: Size in bytes of the input payload at @req_uptr
> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> + * @__reserved: Must be 0
> + * @req_uptr: Userspace pointer to the guest-provided request payload
> + * @resp_uptr: Userspace pointer to the guest response buffer
> + *
> + * Forward a guest request to the TSM bound vDevice. This is intended for
> + * guest TSM/TDISP message transport where the host kernel only marshals
> + * bytes between userspace and the TSM implementation.
> + *
> + * The meaning and valid values of @scope are defined by the TSM backend for
> + * the device bus type.

If you want to do this then you have to also provide a way to discover
what the TSM backend is so userspace can form the correct numbers.

Also, since scope is now a uapi whatever in tsm is defining the values
must be moved to the uapi headers.

Probably this is not a good idea and iommufd should just have its own
enum with unique numbers for every bus and do the validation and
translation.

Jason
