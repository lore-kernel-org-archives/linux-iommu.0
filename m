Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208B47DF98
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583405; cv=none; b=EYuoEjIT1UlnDMqRCvsgWLFOWwlFnkAyr4F1MYFaZtBfQG4BT3x+HiMPr0+cQrh7XsFDq86VbuToEBN3C9W8cx4lEWcAfBNuPXpXOXARw44RGnaoxcDPtW3GWvemzgEgv6vNxj2jfB3O7nKc9ic+G6fwt1274DM1zxevonoMqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583405; c=relaxed/simple;
	bh=uV78Na/cU+RIve0Q1YJ19wLHf0X6yGP9GKIsahjNfAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZR7FjAmmcW/auxUJVxApXngK3uuStXkjhynHK3If+oeGdOtGiN2lsJ3oTiBzEm7XxBQPSzXx8FhyuuCvop5vF5qufdeITFCKyo+jSd7FU4Rz3mb9CB3kJW1s7dxvKcxnO/3rZF04k7NoK+vT9hkNxNMoRxflzQYGH7Z9g9Xa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V6vu/dOs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V6vu/dOs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91550dda53cso111043885a.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583403; x=1781188203; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
        b=V6vu/dOs9iuTES3ccZVTFyyL1vejOso8sMMBoC62tGPdny9Rcia7rbrZW4Pp7WsSNy
         wUxobmtIrijO18K54ddKfro5JL/uTLn184uKit2Ly8ZA3iFROO6UnIODtiTzSPMEr/7H
         PoBh0gVp8mnaDybSBRboi9n6RDPImSl9NhxtlLbIVA8DQyskbvT0BqyLjloLzZeCE5IH
         npmP9ZcIrsuxccjVxdLtaCsWac5BUV5D5kzCCqfzZ7YVU5xhO9Nmu7tBhOuH4WUlmiTv
         dYq4fNODQLwq+VREWz+TuNGFmkP2hvcR2/8MBqUyMZCZaDR4muU+YXp+JOmVMqxohOJ8
         W8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583403; x=1781188203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
        b=pNeFrUGffutiRYx9rNehQ2Figa5LV4Qz4V+7lDC0JARujls5NqzBGiAkt9mfph/2iO
         SnvQlGyGhZOgCCXxbhQKOoiJcEqygLTxyJG12RzvwKHCdfxEQ8A0cxMI3A+tFr3bGNuG
         zIkCbvuwlNAYsBSHdKVU5I+9Jdw4MYP7fwJsGPligzMKrAaWSsbZHos42vGCKCdznAhu
         IMtNTlQ6uQmue/Wih8gXN82IaHXZixGCIRH+UXVt3YHTeKetdO09hyuXtF3GMnvw0LJv
         L+NhL/8orFbPMaYzf/NdDPfk4XD9+Vdqa6xKqurESiW1gy3OH1Ee7hACEOwPF1fqIHtr
         /3fw==
X-Forwarded-Encrypted: i=1; AFNElJ8F19msa+FP6vN1rCeE57j8rX/u/YkJPrFTaO2kYR6uQOI25HFO2dmGnOuAG8gjoBizFxWqjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0k/Hx8EpXOGA8behousl5eBlMHdEwDzEyDseohvjKFJGSFS43
	+44KvXo79wexR4TgnEbK0DfAJ3NX/THb/73qGqAcJ7X4GRvsnXRg7K+2yIb+nAtV+HMNpfBnSv/
	+ol6b
X-Gm-Gg: Acq92OFu9SyjNVQVYKuB0dKMScAvMmAXviNqiS2T/QDk+RIqBfH+F0R6gu0031x0kV6
	TnLzPr0ackbD5bzxiuY+F2PqYGrhkp45rvv+d+zMYq8fEdVWEZrQj3OL5AivMO3AN0CdeE0qrxl
	yY5xJE+WartYpWzZDFN4HEzcFIgbonfWaoh7i1DH/bzTzFYlBnxMsUQfZxJ3W8cKE8zae8FJ48v
	6hvKNzDpIwfoDxh0pwRvAztpCIdRSnBAeuJ0D1rFewM+0EPhxch2SYzGaN22Jau/KXbkt5uIJy8
	+UhT5PtTMWQTlLluj6h/Y4cbyg9+kAbvk1GW5O4+rjkqV+Di4gQAsUkjcd+lcvRZjwR8mvVP6F/
	TEfl3qBswHkwjrty76Kei5bZ0nV9CX5E0/iML1CrOnYpR2u0c/ZGpvTz2M0LvSXS7LzHBqMUMxO
	8hrXzwpYvjRRmNCmqnZOuTO7KiwaY9KGhzZzsc7DdFi27AAD91LrH+b6ybOVNdMu4KvgS346A7S
	N6uBuUBX1BXwuTI
X-Received: by 2002:a05:620a:2544:b0:915:3e46:c44a with SMTP id af79cd13be357-9158a80c3f3mr1387419585a.46.1780583403463;
        Thu, 04 Jun 2026 07:30:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21d2c1sm657350885a.11.2026.06.04.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:30:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV958-00000008IZw-1Hzl;
	Thu, 04 Jun 2026 11:30:02 -0300
Date: Thu, 4 Jun 2026 11:30:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260604143002.GA2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jun 04, 2026 at 02:05:35PM +0000, Michael Kelley wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 PM
> > 
> > On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
> > 
> > > Except that in a normal VM, the "unencrypted" pool attribute does *not*
> > > describe the state of the memory itself.  In a normal VM, the memory is
> > > unencrypted, but the "unencrypted" pool attribute is false. That
> > > contradiction is the essence of my concern.
> > 
> > I would argue no..
> > 
> > When CC is enabled the default state of memory in a Linux environment
> > is "encrypted". You have to take a special action to "decrypt" it.
> > 
> > Thus the default state of memory in a non-CC environment is also
> > paradoxically "encrypted" too. 
> 
> The need to have such an unnatural premise is usually an indication
> of a conceptual problem with the overall model, or perhaps just a
> terminology problem. 

Oh yes I do think the AMD derived terminogy is aweful :(

> Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
> Name the pool attribute "cc_shared" instead of "unencrypted". 

Yeah maybe. I sometimes imagine replacing the encrypted/decrypted
names with cc_shared too just to make it sane.

> "cc_shared" set to false in a normal VM doesn't lead to the non-sensical
> situation of claiming that a normal VM is encrypted.

It seems like a good idea to me

Jason
