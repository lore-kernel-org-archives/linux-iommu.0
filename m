Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43131D9334
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313866; cv=none; b=GdHufz/zUNktB5tSFGVzI/dh9MAicukvNLevCSZwET2ZYzj9hhDD7c9sUqPKg/ew8W/4R2LhWfOy8ARkN+PyOithbhEbqz7qLnIN9opCCZI5mjSd92tVq7tKLyVxxBYOSCX3L2HXa9jMsDRz8JiIJhoDkBPrYGiMa0UvjBGtSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313866; c=relaxed/simple;
	bh=7sRwQOu6EuU7X4TK7vsW/hz6zSDAVaacvkEkJknd0C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdgdKuklyjS3mNFPFcqAh2H7am72cxK4Lc11+SMh+qxcEc6fJblLU1KqB/bVz2M/QR68wali2a59T8P9jGdC0wHRzcF5zZLBeBA5IQKY/pkFGgQF/ebKpkUyh5y8YBY/IVDCfuZCp4cB137jKmNAUVDx2ukT8onLIIcriKYeJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ThQMwCp4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ThQMwCp4"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a23fc16fso410513085a.2
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728313864; x=1728918664; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHmDKz6VoCoOWhFGRrnQD6b1xtdA1wt9ENap+Algfjk=;
        b=ThQMwCp4bkr5mLWMuFgktzCq9nBXCBqQywXZTI+gAemdyrIOOf7Z8dTjZQI1MFW/c/
         4DZ+p4N/2KCAjxJF+v5t2cxUfXc2n0CSY3HxZ88VCWjcQFZGmOweo7iST/UKbzOlSIIg
         PoN8qkulGa9QRNhwzNBtbRNBvyutnqhJmSqV7wlTBzklFe2EWZl6Yv77vWk/ITTcJbq1
         dI08+KlLfksQGs3n3CU4ogy+EuoxbymygYNGjL/A5BWGqmC0ZBoYk8QkdEDWf3iXf0cw
         kg59r+PeMV672BBgvr8iT4Sd5Uh1Yp9/ZMgQSsyMgHEeFm13M69E5i52EcvzkqffBs4r
         dodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313864; x=1728918664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHmDKz6VoCoOWhFGRrnQD6b1xtdA1wt9ENap+Algfjk=;
        b=Lyv3IU6zBlI8TeFXpcblMUp9RqkZVj6v3tbQUtDXtzetJH2eBwOu86krj4yilULhEA
         D4oIeTYb5sc3KeWFDmt4YPsP3IeyT1usm+ckVnJfWK8lFgP9LuKkUAO1ChQUNZhRfr+b
         MiYslaf4qjlI6qRQU7aJF3IqFzR4BYBq2ZO4p0WaA9LaGksF1Delsdf9nc+mYWDs+nOT
         bdZUjQ90984ckUknaQqhnlfJaKgHs1urnzXCOxSjj1x2ItJD4mbxmchTQ8KcqfjgEN35
         f5D1R73XGiKJSsusC7PalVBfjJrS6+ZMgczfXmLZD6FCaG9ysbx8PmJYELDknjB22OS5
         dK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU4+0iOgEtHgDF+ytuT7DwvK8oQalxSkjpDDAWFD1vT6f9e2SY8VroOmIJ31OSlNSKm4aPVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmGfxGO+fyQi5sdDGnpMLJhdLEGfjW9NmFM9o/hs0NW6OCurTD
	CfY47XCH94WKg3Mk7QfLpwmjDlbU5s4Vxz9rN1TOdJc2PT23h9ltE1LnrKr7QG0=
X-Google-Smtp-Source: AGHT+IG9gun4r5qe4Piv/4D/AVhBJRCFK/ZGEgynw3hqWzjEFdyFae9aEowZ/wsmNcBJlrHvcbyaVw==
X-Received: by 2002:a05:620a:f0e:b0:7ab:3511:4eda with SMTP id af79cd13be357-7ae6f458964mr1726379885a.34.1728313863822;
        Mon, 07 Oct 2024 08:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74ef1c0sm27187531cf.35.2024.10.07.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:11:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sxpO2-002ZKU-Cr;
	Mon, 07 Oct 2024 12:11:02 -0300
Date: Mon, 7 Oct 2024 12:11:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Gowans, James" <jgowans@amazon.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241007151102.GN2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
 <e458d48a797043b7efc853fc65b9c4d043b12ed4.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e458d48a797043b7efc853fc65b9c4d043b12ed4.camel@infradead.org>

On Mon, Oct 07, 2024 at 09:47:53AM +0100, David Woodhouse wrote:
> On Mon, 2024-10-07 at 08:39 +0000, Gowans, James wrote:
> > 
> > I think we have two other possible approaches here:
> > 
> > 1. What this RFC is sketching out, serialising fields from the structs
> > and setting those fields again on deserialise. As you point out this
> > will be complicated.
> > 
> > 2. Get userspace to do the work: userspace needs to re-do the ioctls
> > after kexec to reconstruct the objects. My main issue with this approach
> > is that the kernel needs to do some sort of trust but verify approach to
> > ensure that userspace constructs everything the same way after kexec as
> > it was before kexec. We don't want to end up in a state where the
> > iommufd objects don't match the persisted page tables.
> 
> To what extent does the kernel really need to trust or verify? 

If iommufd is going to adopt an existing iommu_domain then that
iommu_domain must have exactly the IOPTEs it expects it to have
otherwise there will be functional problems in iommufd.

So, IMHO, some kind of validation would be needed to ensure that
userspace has created the same structure as the old kernel had.

 >At LPC we seemed to speak of a model where userspace builds a "new"
> address space for each device and then atomically switches to the
> new page tables instead of the original ones inherited from the
> previous kernel.

The hitless replace model would leave the old translation in place
while userspace builds up a replacement translation that is
equivalent. Then hitless replace would adopt the new translation and
we discard the old ones memory.

IMHO this is easiest to make correct and least maintenance burden
because the only kernel thing you are asking for in iommufd is hitless
iommu_domain replace, which we already want to add to the drivers
anyhow. (ARM already has it)

Jason
