Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0011598E3
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964133; cv=none; b=R22lpEBV224mGiK91ULovZR+me6/aHZvCSTwRBHOkCUus5WFEinshsS3epnkwFX7rPpnbHieHHRb7hzo5sfyQmUMPz76k+Marav7CWC8kQHZCYIjxHPeHMLJ2GDiLFd/0WtcAUTMo8Hh6+17bE+9q/L7jsuX1DoE99eSSwaR7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964133; c=relaxed/simple;
	bh=MLqG/ayz9pHHmYWBcJHvF3/ul3z6kDZGVuyyMmkOEPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxAcUCEN6n1ttMOWXFZdHSDp+3Wa2Ikk01+gM9hX8oii22Eqvg5sLuQKdaqtrbX/kDVzg2UykoAk6PdJd4TdUniuMnq1eXw58ENKyzkVbHkFh/E1eah3JtZHm3s28Zin9BczFHFb6Weh+mSGb/UPL0LqXh8eU5FSlRd396LYlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WTLiuDK3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WTLiuDK3"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb75c202dbso3606073a34.2
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713964131; x=1714568931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaGiR6whDixYKUk+u+/VLyz5W91RnPjldFm+jW5pc40=;
        b=WTLiuDK3oIHQctLDsnTPHRgBTvtgM1kxs2t6AuLY/7Eh7+m9fpHQ6XV8sqFb8Uk9yB
         S/mJ22KA0DNmncWBZDiLOiE9Nc4E+GLjGmGGtCM6G2a31syq9E0NDbyZvlEKDzweWDkW
         pCC9fPpmf30lbeoow4cpnWLemsn5Hhh7jqtoKEzUbvtzKiAXyLTLpyJYTM2bNipqc/IM
         nqPjmZ7JtCfCZ97rqFk8/CPIbTCKAthTL54VvZVgmr8eySkHSDijs9bDQzOOF0el5aiK
         Zfuzcf5BJwMPwa+UNIvWBv5md/cS9g+vb8xDTF3fcPTSFJXZn33xyda112y6xYgQZ2jD
         FPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964131; x=1714568931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaGiR6whDixYKUk+u+/VLyz5W91RnPjldFm+jW5pc40=;
        b=a560NppH81wtlc295RxwbMRn8UoRYTIBQnnxd7xl1etk+PSI15bOQae/RWIqae7KnV
         J2a1aeXhL5cS/L0V3zRTc+0gbE8boP2CLGLHG5SAueDiJ2teRKqAgBlNqkTinvixdt7m
         oONeWncCb8jz+z+UILZhWuSNZz6fEIeTRmy4SSJJhvlxh1XwBJ93fzQcnmxnF9cmsUhl
         KIv8PNhn9hW5pNlH57QHA9WFV4oQAAzKitS6FtNxwtpVRhJT5E00CWWNnHnzXfKmcWYp
         ywPxReGGRFAp15SbOcTjCh7rhZsQxNhCUtSBqHPK5dnKrzvT5EzdR+3uE/i73UcBVKlH
         /1dw==
X-Forwarded-Encrypted: i=1; AJvYcCXLKkquSvTeFBPz3T420gLVcfqdk5VL/eSMtb2ys0SUZABfhORbHajejNs6a7/vfZtWUPQa+BDE+w6etNEuanoqUef9kFk=
X-Gm-Message-State: AOJu0YzDuw/MbMR1mE5x70moSClzIQMyjgGwX/S0B9asvcG0dxTrpqkc
	hQbFsG6xknyMIy+rxlU2/VKuAu7VM2gvvMWDkbmo3K6Nls2QF1p8EG5TUlqFKHE=
X-Google-Smtp-Source: AGHT+IGweXbyKwjZYdG0QH0zyCcjP72EDqRD1FL9MQKqbJ4LjEfM8xBfHSBXgRJ48yw5Q81FM+m3aQ==
X-Received: by 2002:a05:6830:1106:b0:6ea:1bf3:9854 with SMTP id w6-20020a056830110600b006ea1bf39854mr2716615otq.12.1713964131462;
        Wed, 24 Apr 2024 06:08:51 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d6442000000b006ea1e0fec59sm2369684otl.10.2024.04.24.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:08:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzcMj-007vEl-Tf;
	Wed, 24 Apr 2024 10:08:49 -0300
Date: Wed, 24 Apr 2024 10:08:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vashegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	alexander.deucher@amd.com, baolu.lu@linux.intel.com,
	Eric Wagner <ewagner12@gmail.com>, stable@kernel.org
Subject: Re: [PATCH v2] iommu/amd: Enhance def_domain_type to handle
 untrusted device
Message-ID: <20240424130849.GG231144@ziepe.ca>
References: <20240423111725.5813-1-vasant.hegde@amd.com>
 <6552a5bb-0481-4a0c-a587-84275ab3a179@arm.com>
 <c255ccb1-68ac-485b-807e-a4c38786f116@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c255ccb1-68ac-485b-807e-a4c38786f116@amd.com>

On Wed, Apr 24, 2024 at 01:41:57PM +0530, Vasant Hegde wrote:
> Hi Robin,
> 
> 
> On 4/23/2024 4:56 PM, Robin Murphy wrote:
> > On 23/04/2024 12:17 pm, Vasant Hegde wrote:
> >> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
> >> untrusted device. This always took precedence over driver's
> >> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
> >> iommu_get_default_domain_type() to respect def_domain_type()") changed
> >> the behaviour. Current code calls def_domain_type() but if it doesn't
> >> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
> >> results in IOMMU group (and potentially IOMMU itself) in undetermined
> >> state.
> >>
> >> This patch adds untrusted check in AMD IOMMU driver code. So that it
> >> allows eGPUs behind Thunderbolt work again.
> > 
> > Sorry, but I firmly disagree with this approach - regardless of what the AMD
> > driver is currently doing and how appropriate it may or may not be, we should
> > not be duplicating core code policy in drivers, 

Then AMD should remove the PASID stuff from def_domain_type and we
need to fix it with properly designed core support for this limitation
before merging the SVA support.

> > and we certainly shouldn't be
> > doing so to bodge around a breakage in how the core code implements said policy.

It isn't breakage. It is evolution of the API.

Hacking in the AMD driver is temprary and Vasant will eventually fix
it. Regressing the core code to go back to allowing drivers to inform
policy is much harder to undo.

Jason
