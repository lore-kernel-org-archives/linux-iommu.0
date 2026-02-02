Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF92D7DD4
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072355; cv=none; b=uxqhfMLWh3RKSPztTo5tSQhpwwMrYSkRsPtMgl9GHl4lIz9g6r0LUBi/0cn+5RF1AtViQsMPMmALL82j/KD42o2tSj/vTbGIpO4gIN+wrMWORHPKKYHCN9C/4o03c56PYjS6Xtx2FVUbkiIk5R64DurqzL3/I5Qrxscv/BGMr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072355; c=relaxed/simple;
	bh=kt1kxM3BSgQyPyqxHxrlZ5kiHxGXcchR2RRLThbxTRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvhicv6i0ZMzKXcPRu3a7eW8ZdVepO9QALyJCYfVDsr89YH3wKHq7Y6LEsK4TcQqWrA85rNA+jgkk+1oTQKqBj1zfrBN0FR4kdlDfafOu7bdspKeSy6LwC2ZudQdMqUPYFNh6MJrIOvj3A3lSYyoOZXmaXliOE+P2hLsjH05jGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vyd+lAT7; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vyd+lAT7"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29f102b013fso52250025ad.2
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770072354; x=1770677154; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rj3GwaQW0XjYZJgJrGaZFtCOevhoZc0zDzsN9FQg3qw=;
        b=Vyd+lAT7uxusMhAJhGht4b6cJiTAtGgOuQWyJRhwvgmFdlGSceGxpLH3hBHWQW0j06
         OM6Y8o2cb/IR0M9bz8SzMu+UocO7e3t4Nfrl6JtCWvt3xDMOnGVSIp1dQPICL3BmmR1x
         AsbthvE9DkxF86IFD4NRLTnHtBxtoxolpO2wOY3VnnigC32BkYvrTMWlfoCIzGx9J8nR
         Ts0dewY0QH2KsnJJIsS7+HOc7TD3E2xQ1N+2vJG+bBKbFfS90/u6z6zIRQkEXWhU9qlk
         LKMTUbzmlmgMoCEbEUG2NBPBO2p9ueIhRkPWnhrgIZyULBFJuc6sFu+a5bFQUYePcPMc
         H6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770072354; x=1770677154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj3GwaQW0XjYZJgJrGaZFtCOevhoZc0zDzsN9FQg3qw=;
        b=jaq7oBVxgLT7NabVOaaIVnXkMBq0VJyILBJKCREAKiA6Br6tTvTuDebxQREs/ANuQY
         UEOwb+tN00dvrLm0kQyjRi6K0fFQLiVzA8T3GbdE8mX65o5UGxdq+jGGXMJ+PZJ7yjr2
         l88rRKnuJSjlC9aE+jq8mVqoDfEulFWzUEqW11lsOhbqdHIelzM2WIs/Wg5inEHpNOhb
         NvPmz0ESfkg1aILbbIpuWkE8tvP0TEUPxWAm77uTGH8GgxvMCOIqKfL+SUmxI7vrsc/4
         wijcxc45SVwhFNb1XOHT/QWLRN3oUl8ruLHCxKuRhiLt60fzIu1t9IbP6Ar0VoJ9QD60
         p+yg==
X-Forwarded-Encrypted: i=1; AJvYcCV/DZVioeLZxBCqVEl9mhDbPV9WED2LUJinaD+BEI9XURCOIyK5XXJ8RSdjwRjp+3P2A/dDKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh0w4pcvqYoSCYRM7sSW9zTyOlDxtBYg9N4RUeFyzjoVFue9cr
	NcB963XEX1x0+cglHZG10pKrI2eNbvedzYKMpcehVsX9mYj8WWZImCPM+ERqWnmvNQ==
X-Gm-Gg: AZuq6aKKFNvdueZX2eTWkRmwm04dy2RN2Zg8eDHY3a4CB08bbOB+NZOO7GcYMO/an2r
	ZsKVU1Gm3AJ/zXiGvHulbdC1jAkPjjHLlfvB/e3aJQs1SK72qTEfUvq8Cquj9p3eulv5S+JzdbT
	nqU7RZv6umbYlLnqARZmet3hV0ZdJ4aKPgzl6JpOT+RrNAxVKUbK+Gc291elNaL2ydunt5DlXsH
	WHWY8l18aRHU2dEoFM203IrUk8Ctzkv/QqNiOxjzIN3KuzzQPJeb2W5MDxA3RJNCA990G6Glb/M
	e+t/0eADV7zPu9yWNlklshOcamaM583t+zR9TGHQl8ppIvhQquEaNdoFHeGZxGxKPo5ejhgKnxZ
	pHREuW0s6dEFmU8r2i88N5yzeiKraW5I6tBclciXo0+Wn+Ooc9/Yi/GIR81o/8HiIMIYZ06c8CZ
	CofLXD3AYNJ5okvyCCxsqOD9MD1qfo1VitYuRkKb7pUDIgd+97vQ==
X-Received: by 2002:a17:903:3204:b0:2a0:d6d5:b342 with SMTP id d9443c01a7336-2a8d9912e35mr114794325ad.37.1770072353404;
        Mon, 02 Feb 2026 14:45:53 -0800 (PST)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eec76sm159008945ad.19.2026.02.02.14.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:45:52 -0800 (PST)
Date: Mon, 2 Feb 2026 22:45:48 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH v2 00/32] Add live update state preservation
Message-ID: <aYEpHBYxlQxhXrwl@google.com>
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20260128195943.GY1641016@ziepe.ca>
 <CAAywjhRXwRD7rmZ2DjN2roDMvWCV2772KhM2hox5RE8Prt4nxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhRXwRD7rmZ2DjN2roDMvWCV2772KhM2hox5RE8Prt4nxw@mail.gmail.com>

On 2026-01-28 05:11 PM, Samiullah Khawaja wrote:
> On Wed, Jan 28, 2026 at 11:59 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Tue, Dec 02, 2025 at 11:02:30PM +0000, Samiullah Khawaja wrote:

> > Start off by just making the successor kernel fail to accept any
> > drivers at all because the iommu_domain was preserved. ie restore the
> > domain and set it as the default_domain and then fail in
> > iommu_device_use_default_domain() and related functions.
> 
> Right. In this model, the device would remain unusable after
> liveupdate as you cannot do session finish. So the only way to recover
> would be to do a proper reboot. But I think this is a great
> intermediate step.

This will break the new selftest vfio_pci_liveupdate_kexec_test that is
added in the vfio cdev series:

  https://lore.kernel.org/kvm/20260129212510.967611-19-dmatlack@google.com/
  https://lore.kernel.org/kvm/20260129212510.967611-23-dmatlack@google.com/

And having to reboot a machine back to life after every Live Update will
be a painful for everyone working on VFIO, PCI, and IOMMU Live Update
support.

I agree with wanting to do incremental steps, but can we target that the
intial iommufd series supports an e2e scenario that doesn't leave the
host (or its devices) in an unusable state?
