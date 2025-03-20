Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC83C2F
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482470; cv=none; b=BL+VH6YY5uTM53bxZ+ebo5j7ld+xgZd/vRR/90m+yNdB79omD3UO3saVm6FxVYIP8DoXTm/SGNUEt2SCcXgfbi2YUNMvNdYuO9bpZPJwfyjTFBeyuyobcp3WDpdZAcCealfGnaVxs0KCrsGTasXDH3EPZNwpfwEXMZTp42CEEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482470; c=relaxed/simple;
	bh=lezkNcagSaQBpcsIAiBCrduV99gkNJv3oN2G2L9vUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3kEZmlc0tyK3rOLjYy1Yf0N8/31ap1GSylIOZ+rbGrLeqJD5EPzHPBwee4ZiA2E5rMY9raakKhr5ls7+21Wcvx4NG+8TkEv4aXOIHIdZ+kQTRPxdzHRO8CE506hIeKL3VKVdVcF1HKFDgJOfxWstChQRYkdEf74c7f6sXBK9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oW9txFHD; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oW9txFHD"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476977848c4so8810411cf.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742482467; x=1743087267; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbI9n8KHB3icRuXhY7gekCV74R5jsXxAGW0TUpnqlMU=;
        b=oW9txFHDGNWvyDeLk6ejq8fle3y7HQr1h2PKnQ9TPdi9p5BcYrB9X9xOaQlTSj3RUh
         vtTegqMCQtwccfuE7iUVp00To0AZRj9Q5nX3HOLV7Jijn9GmdIBSQWV0exsGaCTglIrU
         iYBtcgen9mL6QWTQsb35PO1Ea39wZJ9CiBnCvPFUqfq3+1i+V4UNhlKYcgOgk4eR6CTY
         WG0s0hPi/1nP4MPH6CWFPv7Wul1CtQe94F15b5gUhm9G2Xp3U0VzSgAobLJnt8zwMhdz
         T/T032xy5oOILIQeRiugy6Qm+HphdlD8PbC8NTrDzehULIL6so0wY6lE7PzmkDLQQqRC
         rBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742482467; x=1743087267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbI9n8KHB3icRuXhY7gekCV74R5jsXxAGW0TUpnqlMU=;
        b=qfMb8er8em5n8oSP9y21lavstLy/lD+SPBkrMOGlv6BauVLXjVYO+LHWTpRg9TY+mZ
         Vg4J2DKL1flMKsPvl6StGAlxvOFTjtl8PxjiXcthM1Rkp4H/zh+cMQWIUZOIQnSYUDIy
         tp6jZZ7Y244Pe5uLpkqVc3Ee4Y6/+UaToMi4a8bULduG2wTnpz6QzThWMLRrqXjv9JFu
         Me/oYMQ8VFej+snz6pPu4RYcKIb6itHJcWYH3lTu9CETAqvjoN8gS37psfiFb3kTESwi
         FvGZ2mjB6EamHNk7HQP2h/DEvxewQuPiDq/lvER6uxAZyp5UN+DyUV6oYe2Rj+wcnp6i
         2mJw==
X-Forwarded-Encrypted: i=1; AJvYcCW68iYB+mL/tWLxlcqcuAVQlKvCvnZWpMpLCo7yBCwJx1QUgPAeBfH6/yze+IsuX+4Zw6pMgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5lgQ4u4KhKmflNwb+kuZX7U+f2ClZvnhFbP+pUzqv3clLsABd
	sRF6RU08pCUcImKoDkC/f7hEMpL8CoWHV+WLOGjnFTnEfeWDb+0qbq8GydOlxCA=
X-Gm-Gg: ASbGncvOnCHrluPHJBqXlxkaHyAn21+XGZgiGqnwHjC3kSsZDSL/YeJO4g1V8wgX/Cp
	QmuNXOdZPUYqlQXp+25lNNWoXHK87EVtullsHs7S0YvIIZnIZlZ4zEjooS1qC1i00WXhthy0Pz4
	jU9XOKVINfOy9qXIHmEZ8pXocmJFkJkdX3z9MbqgaNt8StqMpdyhjxJeZkLcF8QIAXqyENF06L/
	OBDnW6kyFumBEjEfyrLpZJPXCleLcaZlVv6zZA8+hlxR4sYL+Jy8fE0p7+VHyBejVhXm/Dmrmzq
	ftUxzp+MWGU/cwQSuT9dlduXFfCIS6+DYbou+n3sDi+laAfmUQaDX26FLNCR4Q1yhwPaO+NdIZC
	wJq9I5GNdDoLH0XEgnL0iCyBtW/4z
X-Google-Smtp-Source: AGHT+IFEtvzxSz88/CM1YIuY/8/S7X+meVdoi7nYABS5aqEH/pQXkSZNJvEMyTtgvOSE4ASs2ufHIw==
X-Received: by 2002:ac8:5d8b:0:b0:476:949b:8c5e with SMTP id d75a77b69052e-47710d0ff25mr56525531cf.27.1742482466892;
        Thu, 20 Mar 2025 07:54:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d19007esm55381cf.43.2025.03.20.07.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:54:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvHHt-00000000r5C-3TA3;
	Thu, 20 Mar 2025 11:54:25 -0300
Date: Thu, 20 Mar 2025 11:54:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250320145425.GK126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <Z9widNEXgJdfQd-G@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9widNEXgJdfQd-G@google.com>

On Thu, Mar 20, 2025 at 02:13:08PM +0000, Pranjal Shrivastava wrote:

> I may be thinking too much here, let me know if this needs to be dropped?

IMHO you are correct to worry about this for security. During power
management the translation should not change to bypass. Either abort
or the attached domain only. I would document this in comments as it
is an important detail.

Eventually this may be operated from a VM and we do not want to see
any hole where the VM could abuse the power management and somehow be
able to DMA into a bypass as a race condition.

> > Draining the command queue shouldn't strictly be necessary it only contains
> > invalidations and syncs, since we know all the cached state they could refer
> > to is going to be thrown away by the time the SMMU has come back anyway. If
> 
> More than just SMMU's TLBIs, I think we'd still need the ATC
> invalidations to go through, right? As the ATC is present in the PCIE_EP
> and if a translation is cached in the ATC, AFAIK, the EP gets to bypass
> the SMMU, which could potentially lead to mis-translations...

Yes, you cannot just loose ATC invalidations unless you have a way to
guarentee that the power management cleaned the PCI device cache.

Jason
