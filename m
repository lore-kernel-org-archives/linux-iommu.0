Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266341925AC
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476913; cv=none; b=cvNZmKMKwDTRBPcpXXE9HBO6jgiVJoYHC3FrGmTFxmYZEFFcutvjXZ7uggJZFZ1ByAEz0ric1wvsEvqTzEBsHHANOX3yfPAjHwrgV/PBQf7a2ESRCkZtGCJYKkvdbLGXlXgl2PE34+56p6sKp+/Ep6rMmQipKniMqm2B7ysGH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476913; c=relaxed/simple;
	bh=Gzx6Tff6kWJAkjIvdlqgZZEQEP/NO+3/o8Nw1OSn6K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIfqh1f0IcP95INgrvvg4tgE9tmPb1hOPbcHBINWAP8MurzccoBxss5zqlsxZvid9xG0ydK8dO7BQ2MFMUPMNHr0hBOi324eH6aqFRPhdPmC0FNq5rrmHdwtTXwyoCCmInFvo2F7vOvmEOtlcBUnVHzAB4qFUs/RuFsxVrA9ZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M+uHsDxX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M+uHsDxX"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbc7c77c99so8697206d6.3
        for <iommu@lists.linux.dev>; Wed, 09 Oct 2024 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728476911; x=1729081711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKqGDgbkoJQfv2NqdExgjdbBR1Qs6LC6CGaIz0B3LL4=;
        b=M+uHsDxXT7/ausH0k6z8XzTzL8nsmzSZ9HJaehb8TWgkcX7Bu30kwdu9a1L48UEIV6
         V28W6I3qY8fQMKltk98NOAQ+Al2fPXQ2V2hppOhj4DLKLpS7OlOo1tR7L32rl3Cg9DFg
         52nuXNYb+RTJdKdvMgv3Zeevzmr5eWtmr5r0GDnSwI2dXM6AHcZyj9uJthJeD3XOLVo6
         DrwT9GLYMY7aELDVfReFfT/QG6ryTPm/LzGvjxO/+fKBq9iYHZpUo8ppf4qOfVcFnYxO
         VVx8RjNQ+Ta7P2iNPbSD1bPLAqARxVSMFNAYNu5YnjPJrosM2iRXLmcioOwZG3G4jKMN
         WSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476911; x=1729081711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKqGDgbkoJQfv2NqdExgjdbBR1Qs6LC6CGaIz0B3LL4=;
        b=vshjI2naxyzSwAOkMBAYsAWFH6Fh+EAFdaaU9KCmzHGBGYlzNpjugHXprWl0jDTBmf
         3surJhe2o5P8GoswyvnbMCnvjoGeVbOc43aVbJtfF822j+rozexCsGog/NpQOFpCBMe6
         sGKP4RBmKcAvmbiW0zW6fq5fgWbLUqg1IfoCL7w06bUbnj571bTrXZEMgHnKRP7FwV7q
         latS1JrzhSKI5MMxPGaVpHfy0DUK7gqaBYQkwqkXDsTrQDFOVMprYsRMQpP6IT/GiCbo
         1nZ1WyzYCJKgWBTNC0SqMWq5Rp402Hg4zEbfljj3Ilvmy7ZHxVLXsXABwUP0FY3fnqAX
         4MUg==
X-Forwarded-Encrypted: i=1; AJvYcCV1pIoZ5PF5yEch6TX9Glf9GP1Q7qI9Tc/VtN7A9sjKS85Qfct79BSK060BZxajedtT3N1VPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjAq5gf9uROXwuqzrrhXkZ+NhhfBK9DJmNDo3qUDcl5XlQYLyW
	hNbxmL9BpJtSljqqRP2ssepgnII2IuWBPmKlNWxvz6WK9XnWTq/3tiroAuZyF3Y=
X-Google-Smtp-Source: AGHT+IHqDpkY+mRg2Ha5q1sQX6FtYMn1hW0ifNoGKKJt6xh4S+l7ugsqUarGr6URlqQ7kAWTMypwag==
X-Received: by 2002:a05:6214:2b86:b0:6cb:600f:568b with SMTP id 6a1803df08f44-6cbc92af8acmr31847046d6.8.1728476910952;
        Wed, 09 Oct 2024 05:28:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc90a5e15sm7860066d6.98.2024.10.09.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:28:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syVnq-00BKDa-14;
	Wed, 09 Oct 2024 09:28:30 -0300
Date: Wed, 9 Oct 2024 09:28:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"maz@kernel.org" <maz@kernel.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241009122830.GF762027@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
 <e458d48a797043b7efc853fc65b9c4d043b12ed4.camel@infradead.org>
 <1d331c55a299d414e49ba5eb6f46dccb525bf788.camel@amazon.com>
 <20241007150138.GM2456194@ziepe.ca>
 <b76aa005c0fb75199cbb1fa0790858b9c808c90a.camel@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76aa005c0fb75199cbb1fa0790858b9c808c90a.camel@amazon.com>

On Wed, Oct 09, 2024 at 11:44:30AM +0000, Gowans, James wrote:

> Okay, but in general this still means that the page tables must have
> exactly the same translations if we try to switch from one set to
> another. If it is possible to change translations then translation table
> entries could be created at different granularity (PTE, PMD, PUD) level
> which would violate this requirement. 

Yes, but we strive to make page tables consistently and it isn't that
often that we get new features that would chang the layout (contig bit
for instance). I'd suggest in these cases you'd add some creation flag
to the HWPT that can inhibit the new feature and your VMM will deal
with it.

Or you sweep it and manually split/join to deal with BBM < level
2. Generic pt will have code to do all of this so it is not that bad.

If this little issue already scares you then I don't think I want to
see you serialize anything more complex, there are endless scenarios
for compatibility problems :\

> It's also possible for different IOMMU driver versions to set up the the
> same translations, but at different page table levels. Perhaps an older
> version did not coalesce come PTEs, but a newer version does coalesce.
> Would the same translations but at a different size violate BBM?

Yes, that is the only thing that violates BBM.

> If we say that to be safe/correct in the general case then it is
> necessary for the translations to be *exactly* the same before and after
> kexec, is there any benefit to building new translation tables and
> switching to them? We may as well continue to use the exact same page
> tables and construct iommufd objects (IOAS, etc) to match.

The benifit is principally that you did all the machinery to get up to
that point, including re-pinning and so forth all the memory, instead
of trying to magically recover that additional state.

This is the philosophy that you replay instead of de-serialize, so you
have to replay into a page table at some level to make that work.

> There is also a performance consideration here: when doing live update
> every millisecond of down time matters. I'm not sure if this iommufd re-
> initialisation will end up being in the hot path of things that need to
> be done before the VM can start running again. 

As we talked about in the session, your KVM can start running
immediately, you don't need iommufd to be fully setup.

You only need iommufd fully working again if you intend to do certain
operations, like memory hotplug or something that requires an address
map change. So you can operate in a degraded state that is largely
invisible to the guest while recovering this stuff. It shouldn't be on
your critical path.

> then it would be useful to avoid rebuilding identical tables. Maybe it
> ends up being in the "warm" path - the VM can start running but will
> sleep if taking a page fault before IOMMUFD is re-initalised...

I didn't think you'd support page faults? There are bigger issues here
if you expect to have a vIOMMU in the guest.

Jason
