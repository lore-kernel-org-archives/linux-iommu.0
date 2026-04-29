Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED8361DAB
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465104; cv=none; b=CAyY1Q77ja/g0zvXyb6nRibtkSiJ2fjIevpzr8u0jKneQzGEDoqGQEvGXrU1DlSpujkg5SEOFG+lEDPVjztbNh7JHuUHya+a/z6p88nrk8upspD1lVzCwB3lVfx3QtkPRRPCX70og26tsp5szMKKQpaIJxoGVwByMaqX9fPpoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465104; c=relaxed/simple;
	bh=wJQo8cWyxesgPH1j4degVgR5bsBDIIyoMutFduCoUzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1WUfEBewgRfk9AS0B8wFR+2oGHf/CvwaNAcejUCsSulr2eksfnOHb+OEqo0/cZ71ISZXK9Qh7OPgqv0ytVljXc6uhvST1K7Zx8fqbpJolSejP67tARqlxLCYEG7RisYxnNwcBewlr1SqtkNbwtw+uLglTyl7Nc63CBXTBUkAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CMEqk5ae; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CMEqk5ae"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d736211595so827040685a.0
        for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777465102; x=1778069902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPHSzoCIyDIC9QP5+spsNloO0c/6uT0t+rTHSV9tUV0=;
        b=CMEqk5ae6OCzcY9ukkiqmLWDXg2ptfObGTgiOd3rli3gT7D7Sr4DLBLdQdhHq9hm/c
         QTTVwnOpX7gXW68/E3rNL6DAZ7AvZl44wlyOkD6xuIFzLJVUlWNZRDp6o1tI2dyvK5t6
         jl0bbof97kKdItkNjf6zgdry/VzcLILskew4DO6mygsAjqNd3zbfHi3OFGqMLWOyg3og
         arpzkWq8j2GrIzNeAblgMgZpwoZviv1PFsPoPCZ5oFFvZdwA00Gdw9Ru/pokA+PPkje8
         2e5/ZGRQAFd2834kPCLB502Nwdt6/yw1bxZXa/wC3vFkeeppxznoQzwCW6t+/iueenmm
         CUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777465102; x=1778069902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPHSzoCIyDIC9QP5+spsNloO0c/6uT0t+rTHSV9tUV0=;
        b=WBqgF2jRtOFAyxjUqb+dVUJxw0ulGbM/Q3i9kCr9haK8McujsUm3Zd0DVNAhrHIE3U
         HJnTj2Xih6j8ixm6hEbGksoiUnV9FAAk6rHYgLbb/H/+YQduH3N8LEKS5aC0a5tjAMMr
         3S6WLjg2OSSDOtj3sX5YWNOrMAoBQLDsG/WPUbAg3FTTUwwTp3YGggJixnsEvQg89Jg+
         hDZBgfgl2OjqiCdJXHlexzNWptnJqOffPz9P36mVn4lG/aU837N9SZHfF0XHPCO8OE9r
         tHPdgfsbRRy2k6Ew4nAGXB/HDvAPBCWJ6+4pHOLYMX2Zn7KszfxxnIO0qH3MnhTWjJT7
         AtSg==
X-Forwarded-Encrypted: i=1; AFNElJ/B/7SE1P3LHv7SZ1DDpT74uq9Ii4zNog6buJPrTheAc539O093M15+f5R9HNf7m1LAYvcyzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHdGaKW3hCCBC8b1XF8EJtrvHJ0t8qlKDXduMcuasXfN4x0Etb
	RO4PMzZ6jjd2hmabzwQGXw7ujOZ2nhiZVpNOgpNwP9vWwfqqzDT5l71HSU1qndsjwsY=
X-Gm-Gg: AeBDiesx6kudJ7Jec5gNaV3mCgDR9d3ysdLZrHMRtvrIy2QRO51ZiaZGkW6ffFy0e/z
	VsZu2IXe7FKyLeo+l6lYSzfNaH6945SJXnjc2/1ukm47ez1boWn8s/v0ssyq9VHL85GlOqlLIsv
	4C7cREabcG/ReRF93RCToj2rIWG1oGISjl1V6DNBBdJCinOAPT5r9ans/z4+ZMJTCNhkaLXO8+Y
	09Iu1P6m0/vH5cuhNP+jbf+5WmGUlxoS/lgY9Ds+o+pEPOofNkAt6hzkOZqhJtMObCT7hmMkWRZ
	AdDt3veIQPiSaoFDEx+SC3CVhdkcF/esW9LYAwRdCzgLX+qiDEbWFd41018R3EvLhq5O9vk+6bi
	B9EhRUbdse72cb1WmMkfC+RJSbgasF+sHy62PrCGFbz+PZjHbYS53iOez/Savz5Tk8vIHPJUeOD
	9ZSGErOaoqszOU2K4guDgV3e4f7PEEjCBf2e2KmR7BVZQABQXu54jWz1SRp1UfVu9Mm9jeHulzZ
	O7/ZexEK19bliOA
X-Received: by 2002:a05:620a:4481:b0:8cf:df8b:1e5e with SMTP id af79cd13be357-8f8f3534220mr552478185a.5.1777465101412;
        Wed, 29 Apr 2026 05:18:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940051f0bsm152785185a.40.2026.04.29.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:18:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wI3rw-0000000HF8A-18yU;
	Wed, 29 Apr 2026 09:18:20 -0300
Date: Wed, 29 Apr 2026 09:18:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, anup@brainfault.org, aou@eecs.berkeley.edu,
	atish.patra@linux.dev, baolu.lu@linux.intel.com, guoren@kernel.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
	skhawaja@google.com, tjeznach@rivosinc.com, vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: Re: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <20260429121820.GL849557@ziepe.ca>
References: <20260428133239.GC849557@ziepe.ca>
 <20260429010650.61646-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429010650.61646-1-fangyu.yu@linux.alibaba.com>

On Wed, Apr 29, 2026 at 09:06:50AM +0800, fangyu.yu@linux.alibaba.com wrote:
> >> @@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
> >>  	case 57:
> >>  		pt_top_set_level(&table->common, 4);
> >>  		break;
> >> +	/*
> >> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
> >> +	 * The top level is the same as for the first-stage counterpart.
> >> +	 */
> >> +	case 41:
> >> +		pt_top_set_level(&table->common, 2);
> >> +		table->second_stage = true;
> >> +		break;
> >
> >Second stage needs to be an explicit PT_FEAT not implicitly deduced
> >based on the vasz.
> 
> Agreed. I will add an explicit PT_FEAT_RISCV_SECOND_STAGE flag and
> stop deriving second-stage semantics from vasz.

PT_FEAT_RISCV_S2 would match what I have for ARM

Jason
