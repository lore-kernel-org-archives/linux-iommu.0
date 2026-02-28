Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E613B3BF3
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772303348; cv=none; b=COP9Cz08cf2gZbx3iUxenebk5OfezDsLfxSOddQttPmvOsT6G3nNGsEvo9E1+pncsnxxfP68jVB0NHq2hzFAy4M0uCfzGqWYNa0PRkDmPUT8Jb4vZfrUGolr41pBb3uXKxVu27jrvbus5w4nqe1fSyxXQBfTmHg9nY6kUaYd0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772303348; c=relaxed/simple;
	bh=rkzmltbCB7oYdQAHuLM1PEc4LQu8jhDMt38DwB5M/W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgu+z5OMp8WSQC387CfYbrwyJ3uLXoYkWY6watTJiLF++8oVxn9oaReDD2U2i5H4XloZG7IkwK6/bVo9lPS5MpORVIoHASYixGa1sgPZRHN4VqiRxo1xo42IgOPiol946eV2SVP5fOtVlxk85U3aTXPzfRDrYW9uDXIvD1g4zkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WVPUnm+m; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WVPUnm+m"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899ee491af3so1994666d6.1
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772303346; x=1772908146; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htHav7RfCL20FBhzRA0W1wS3HhKQenwSmiA0/DmxMnY=;
        b=WVPUnm+m1agX39uFZ6UZe4/7wZmebjJKqZt4htUqKvmu7D3/nNQlTVblpskiZ/4e/Y
         6a7PaukP5+SdbxLKWedUbk73V9nur7HOz/fg1prm51Oj5DGZzv2WMpAogwN3SXWK3esN
         EfGFzZKVdTYQfLVh6/RjA0W/GC+0shU169goTvOhcHa4SNGA01k4so9vKijP0Bc41b0i
         gWaCXSllThg0yixgbzmlEuEAGjdEhxzkyzA62titoOlZxm1FdyjD/5O64Geo4vy04EJX
         9tB5Fs5bPzZp29o6JxpSWC/2Bc2BpoDN9qmgM1pVuFyLiJHInqU7XSAcdMTYX7cVRyxn
         hAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772303346; x=1772908146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htHav7RfCL20FBhzRA0W1wS3HhKQenwSmiA0/DmxMnY=;
        b=cCw1b5OPb2yvDdQ2hbt46IVyNRayuW07yad57YwD4IeJlhTwdzKQfnmfEVjt3jD0Mf
         JB6jibctC2HdN9WvsmQSTTliMwHJi5P27u3X+5xH56nRdFe1VY9KHdbZf9RHBn8nIoFL
         sZPdXJKVQcwwRYY8jGm9UiwyiCeBp+TmUpys6hSNOPKKEf3Ua6dJG5Do5A3RWrC25NOp
         LO8Ohd76zk4F8lg1odwfPUxNxZTNbxgrlrBoUug9AsTNVJ+GqpApnaX9DzJ73AXqlwPN
         aZYRL5qrr88tIck95ERG/J0QGyj7FN2l+g3hpjnKVjVo9tMLU0U80MivAhOtNJVaAkeA
         k3gg==
X-Forwarded-Encrypted: i=1; AJvYcCVQYTbHfx32P9rTrV61FMKLWyPTDyrPGdYm9GJJWeHEk3u2aXJztwZv837/ppAa3SJwhmvMKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgqI0P18j6GTeV+bWy+b+McClKd3O9r8cOmp60hbrRMAQ4QHey
	rGaY+tZK2gyqBRx0d7oDYeeXw0P9WWvm2o9JiWb9P22v393fSQ6VjsAN1qccp2HchyU=
X-Gm-Gg: ATEYQzxmX8D3/h60JA9ktvzwsD0FKrIX6gVj7MAwaUY7M7u/YrKH0g/dVuHEdBcjJdn
	3Iiphm4+eDwrdmhn/nv986J2xNJOk7e8NZYq0MxOSeblbd8qEPUTeuK7qEjydps7gK+xScgDL8y
	VqOOlVF9URhnDJEpquws+Fo066ssvjlBrQfAS6LIrddo6nAAo/p/boBz/a/4WO5cFkKA3zvfZHf
	s2auqNXvSstG5+Ah/aqGp26UNeKHECVAUn0uTN1ITVqbvDtc+FF9JrDAXZRURZSz7+malwwM7X+
	E7YyDX5LMY9TzaOnCGBb9hJ41+JXIVMQRAOnzkq5AUOJlaHH/cZIGTusPIdD0RV2wX30bt/phXZ
	3cj2INveAbQikVj0A8079fiU3HMOAL6iJvspjHJ+YxFvlZKsTeDdi14SctDfXrQNXZ7P7nITLpI
	daBSSI+ZBv542ejND8ah+LB6CkUmLeFfpGE94oO0uAXEafjlfgO4MwIZcJTdEnA6l6Sns+9YqmE
	/QZcaik
X-Received: by 2002:a05:6214:1943:b0:896:fe42:e8a0 with SMTP id 6a1803df08f44-899d1e8b1camr101368936d6.63.1772303346029;
        Sat, 28 Feb 2026 10:29:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7376847sm71654726d6.28.2026.02.28.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:29:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vwP3o-0000000250x-2vIE;
	Sat, 28 Feb 2026 14:29:04 -0400
Date: Sat, 28 Feb 2026 14:29:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Fuad Tabba <tabba@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <20260228182904.GR44359@ziepe.ca>
References: <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca>
 <aaDL8tYrVCWlQg79@google.com>
 <20260227002105.GC44359@ziepe.ca>
 <aaDlRdnhIqRXEbPZ@google.com>
 <20260227010902.GE44359@ziepe.ca>
 <aaFzgGTpZI0eZWdD@yilunxu-OptiPlex-7050>
 <20260227131815.GG44359@ziepe.ca>
 <aaJroUzTZXZfbRAl@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaJroUzTZXZfbRAl@yilunxu-OptiPlex-7050>

On Sat, Feb 28, 2026 at 12:14:25PM +0800, Xu Yilun wrote:
> On Fri, Feb 27, 2026 at 09:18:15AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 27, 2026 at 06:35:44PM +0800, Xu Yilun wrote:
> > 
> > > Will cause host machine check and host restart, same as host CPU
> > > accessing encrypted memory. Intel TDX has no lower level privilege
> > > protection table so the wrong accessing will actually impact the
> > > memory encryption engine.
> > 
> > Blah, of course it does.
> > 
> > So Intel needs a two step synchronization to wipe the IOPTEs before
> > any shared private conversions and restore the right ones after.
> 
> Mainly about shared IOPTE (for both T=0 table & T=1 table): "unmap
> before conversion to private" & "map after conversion to shared"
> 
> I see there are already some consideration in QEMU to support in-place
> conversion + shared passthrough [*], using uptr, but seems that's
> exactly what you are objecting to

There is some ugly stuff in qemu trying to make this work with VFIO..

> Further more, I think "unmap shared IOPTE before conversion to private"
> may be the only concern to ensure kernel safety, other steps could be
> fully left to userspace. Hope the downgrading from "remap" to
> "invalidate" simplifies the notification.

Maybe, but there is still the large issue of how to deal with
fragmenting the mapping and breaking/re-consolidating huge pages,
which is not trivial..

To really make this work well we may need iommufd to actively mirror
the guestmemfd into IOPTEs and dynamically track changes.

I will think about it..

Jason
