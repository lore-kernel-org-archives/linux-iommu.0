Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3027703C
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319266; cv=none; b=IBmYvrcrj+2Jyx51HilxB8PuBC5BfQ3qfrH69olZwb2DwvOdIK6kKa+i5eLBQHXuvly9o0gFhWcQRjX4wmf4wHpB5+4VtZqZGfbAKwMZmhd6mw/bUfjy3pKtDmXC6TunRUmRPhqmvuND5eGzwprLyVWY4JO9+IugV2dZy0nb7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319266; c=relaxed/simple;
	bh=Kym2K7zv6YgSbvtfYDjPoU8YAALp29UxTohwMy3Spj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kokZBNOOv0KZA7fehRQ/ghW9mec6c/59ZKwqX82Sv4Qbn7uN90KoyrJSpa8HKrApD+11JvLDvTzcjdp+BM5kUEwxw8Hax36OXBsDrkAr4OAe/kTDbtCpKwLa+uCAPv0CDFbFbhUtFMrBYqFvNPoFd8Ijeb8ugNCr+fu5scrkfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mpff+tlP; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mpff+tlP"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4dfd1f48d4cso31022081cf.0
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759319263; x=1759924063; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjfKbtWhsLucd83rhK1I64ABwmN4n30TmWSDIMpSYU4=;
        b=mpff+tlPcN1j6KUYpotlikAOalSonSsH5avQWk8PP69JVhD1ibtZg4BFnCTz9nD0Ia
         PLX+WZwHqkng9NcihhwmFKoGJuhrnKW6aAOB/ymbYogfP914ilNnzTGuKyL4S52laUPY
         DjiWmWADpLj4u1KR0tjjOOuZFoCNWLK7vmmq9W5yoXFtuwrcJQTVLr+MaWsFN28qk3Yf
         eEluJSAMIz2rElCXgy/WiaOmh6RasjyU1undnv5Ljhux8Eh77SjFJr5AXoTZF4g71fFx
         zPF9yNbQMf4xg/C9le3rwjNPd9UL20azEjiOajMmPFJncXxyu3aj+mMZYf8TnBRHtuQX
         CUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319263; x=1759924063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjfKbtWhsLucd83rhK1I64ABwmN4n30TmWSDIMpSYU4=;
        b=Y0mIbtWAjplphDi6+OYfWvrfFggVrlFH0GTmHSO14HabEYO8xsghx2H/eSYidZ3K/g
         Fte7TifHKjarP6TiOcUCUlshQq6tpMuYxCkIBTArb7mku+fNWCjEdh5d1R0xBUXy8y+1
         vscqpnmMkXuaj9qEPZ7N+NgYeRGORo+q9Zjn/bSA9JnSHow2H7qVlotLWMheXIrcbCZC
         jYKbIxeb6BHd4zdDOSPAxPKZutHxicyXtLK6F+/JNSk3nf3GeBhnGz+xh+Tuw2LREUxU
         HVs94VUlLWLC9G88EtytEEx2gtx0gho9EZ6TuNpIfU5zAL849ONoYOfm+Vn7mdRzhViF
         Kpmg==
X-Forwarded-Encrypted: i=1; AJvYcCXU2jsJ5aMmRksRYFgKFYiiH9M/VB+lN85sm1oi1iOcGACdvYKaVqe73+68HnN0jr55cFRkzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yykr5nd3mhsfop44CB5WSH45X2dH6Qb+JtgE6GHdNN4w/TGakOu
	9SeRKProi7PNUMr9aGeaeoP5YycxMdgZzOpsvXF239j8Lhv6ZkpBKa+QGmI32sSRZAQ=
X-Gm-Gg: ASbGnctoIbPjP6e6Deh2ZIfmWAdl0u+/2BuDf5/rIOc/jbBKX0GmyP+CblxRVxHsDxs
	QnS7xA/NcDaGsWGM2y0YFD8+Qnx+VI7eq8CLtLqp7Jr0j5r2h3dfahPx/jqviV5OkEo2B7Fr8oT
	GiiUNSCC804SP3BQCvUkHwkk++RO1yQ0LjNIPCm1f6m+0H3dVEv7ieT6z2kNjY5Y3ZeTwdSM//E
	7d8PVTQXZCpRo5hnDDo9O8lqNUa1/RUxadxdLMIeEknNHb9hhNRA7sY/+FkMcO534kF2dcCBRcb
	DEl7JK+WphSV3Qi1Ksvu8qOzewVpKaMu3Hs3B6tx1yU+9nCDLyZTjL8AqxZkSaFxL2f/0EKxRI5
	YvH/2dtQZypZ9Qqd0VB4e
X-Google-Smtp-Source: AGHT+IExJR6eyJW/ikE5CVaFn5cEfc1pD9t1SxPLHxqTb+4f95a8pqcY5akCVVkUlNL9iNQo56Ln/g==
X-Received: by 2002:a05:622a:411b:b0:4b3:214:1eb2 with SMTP id d75a77b69052e-4e41de72e4fmr41343891cf.47.1759319263539;
        Wed, 01 Oct 2025 04:47:43 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm113778621cf.16.2025.10.01.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:47:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3vJ8-0000000Co9H-0LuM;
	Wed, 01 Oct 2025 08:47:42 -0300
Date: Wed, 1 Oct 2025 08:47:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251001114742.GV2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>

On Tue, Sep 30, 2025 at 04:15:43PM -0700, Samiullah Khawaja wrote:

> > The iommu core code should be restoring the iommu_domain as soon as
> > the attached device is plugged in and attaching the preserved domain
> > instead of something else during the device probe sequence
> >
> > This logic should not be in drivers.
> >
> > From there you either put the hwpt back into iommufd and have it free
> > the iommu_domain when it destroys the hwpt
> >
> > Or you have the iommu core code free the iommu_domain at some point
> > after iommufd has replaced the attachment with a new iommu_domain?
> 
> But we cannot do the replacement during domain attachment because
> userspace might not have fully prepared the new domain with all the
> required DMA mappings. Replace during LUO finish?

The idea is the kernel will restore the iommu_domain during early boot
in the iommu_core and then attach it. This should "rewrite" the IOMMU
HW context for that device with identical content. Drivers must be
enhanced to support this hitless rewrite (AMD and ARM are already
done).

At this point the kernel is operating normally with a normal domain
and a normal driver, no special luo stuff.

Later iommufd will come along and establish a HWPT that has an
identical translation. Then we replace the luo domain with the new
HWPT and free the luo domain.

> 1. During boot, the IOMMU core sets up a default domain but doesn't
> program the context entries for the preserved device. The hardware
> keeps on using the old preserved tables.

When the iommu driver first starts up it can take over the context
memory from the predecessor kernel. But it has to go through it and
clear out most of the context entries.

Only context entries belonging to devices marked for preservation
should be kept unchanged.

Later we probe the struct device to the iommu and do as I said above
to restore consistency.

> 2. Userspace restores the iommufd, creates a new HWPT/domain and
> populates mappings.

Yes

> 3. On FINISH, the IOMMU core updates the context entries of preserved
> devices to point to the new domain.

No, finish should never do anything on the restore path, IMHO. User
should directly attach the newly created HWPT when it is ready.

> I understand the desire to have the preserved iommu domain be restored
> during boot so the device has a default domain and there is an owner
> of the attached restored domain, but that would prevent the iommfud
> from cooking a clean new domain.

The "default domain" is the "DMA API domain" and it has to be created
and setup always. The change here is instead of attaching the default
domain we attach the luo restored domain at early boot.

This sets the device into an "owned" mode but vfio can still attach
and nothing prevents iommufd from building a new hwpt and attaching
it.

> Maybe we can refine the "Hotswap" model I had in mind. Basically on
> boot the core restores the preserved iommu domain, but core lets
> iommufd attach a new domain with preserved devices without replacing
> the underlying context entries? 

Replace the context entries. If everything is working properly the
preserved domain should compute an identical context entry, so no
reason to not just "replace" it which should be a NOP.

> > Also there is an interesting behavior to note that if the iommu driver
> > restores a domain then it will also prevent a non-vfio driver from
> > binding to that device.
> 
> Agreed. I think in the "Hotswap" approach I discussed above, if we
> don't restore the domain, the core can just commit the context entries
> of the new default domain if a non-vfio driver is bound to the device.

As I said, the owned nature of the device will prevent attaching a
non-vfio driver in the first place.

So the only path forward for userspace is to attach vfio, and then
iommufd should take over that luo restored iommu_domain and eventually
free it.

You might consider that finish should de-own the device if vfio didn't
claim it. But that is a bit tricky since it needs a FLR before the
domains can be switched around.

Jason
