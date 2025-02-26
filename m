Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DE258CD1
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574634; cv=none; b=JoyjYwhwKA2Yrz5XDff3Jxl6CLhaBhO07JE9yKeIp3bH4yNc5R7c+K5lvXtKBaAk8BzBoDZ6E+hOjRUHDyMk4BuKWSh12/l/g3dzAUe6D7JxPKWySINSzs6QL0NG33IODHJmtWmcBiv5ieXSLfuaeXxIc112Yed5qPxw56mEiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574634; c=relaxed/simple;
	bh=e6N1kqBBB03/a7RSy4itFy2VWC8aQrb3QZgFv6Ka0EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr5fqHVQXh6ZCGvD19w6luFzv5MvPc85DU7+h1UYC7kZWExfTqpzrQMARt4LjVZCSQHNbALJBu00+kWE1Urp7uIioB2fch705hpmcRjCTxJUmAkaQZQaCt8vxPaGJfSK3WEOhgu4Nl43rfgL3jBPt3hWLCui9KMjaDdjgbT025c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MIJ6205Q; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MIJ6205Q"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e6846bcde2so53024196d6.1
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740574631; x=1741179431; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOwFrRPYSumuOWhH0i7DGjm7VkpC1RlcluvHuhl9kV8=;
        b=MIJ6205QY6oXXU1xRonX1QiOhkjdR0HPbxqgAzeEi/KCp6Er20UjXhx0xyY476JU+r
         BNMEiobfqg5PkiJNaaP8xOfaPz3w246S7a83XzNNXYZIDFCJDw8pYIq7bU36fBd+iaGF
         SpbWCucwW6ZlZV7tmPzLP7s4716z8g5XJ4KKkktRJC9gku/5d21mLRvW5LMgokRH2Ybp
         p2+s3NiwLTtvam5wKmxOhpI6XOGxyf94Dgq6u+gEz73VBu6oFpvBVuoG7mEGz+nrJVH9
         MhPy88t32VRxeEhjzln1GKBCvtQdlvzkvY8nKfJ3/RQI/34u7IykSwuTsGEp6zj/fX7u
         Q+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574631; x=1741179431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOwFrRPYSumuOWhH0i7DGjm7VkpC1RlcluvHuhl9kV8=;
        b=Sn3OlPLnuwZGXvfOVW7I3Ep16fbF3uX4N3IaBxGgGTiJ3bODXwC9OCZ5dTKJjxgFEA
         q16rHg7E222Y73ZFgeTqTYTXrjNJ9z3n2phV+iPQDJHeqwswbjMkFRPw7U5XYSnUT22p
         4uZIr9+rDqZI6cUSjAVcYRvgkRATKOaILsoTQD6OZbvdOaqmT5lNDruRNobTgpZUwfSP
         2j7evASzw9UwdALx+QLpVvd/Q/9u/NLEsWJzUs2J4chjrK+vgB79SKTpU3caD5EoRpWL
         4rjiIpkK//Eq0B2XirllyUhV4sqiiXU7as8SFYCIrJl/Ca1oWmX8x7gaqKad8C/1qAfp
         R6gA==
X-Forwarded-Encrypted: i=1; AJvYcCXAOTVtURxhhxjpt/6ovF6M09eqQaGudr51ZzirUX9uapvETUqkCxyw62w89hXps1nNbhy8WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh8tLHt8IVQFI5hGeqR/nZ2hJRMMipBZFm5XND660rd4HXuCdl
	fDJC/F5azT7/gY0OotaZfKm8t2OBwViydoKsUHMLBBot4YRDE0otV4XmNk4fQ/E=
X-Gm-Gg: ASbGncszYtsn1+Bk1oOE5fWBenkzh502jowpCCQlMWf4Ueog1/nNOztXezA2Iwk9hBC
	Be+1kQVBdG68/dOTrDeNH6tnWbpmpzC5ptQvKYCPHYuFzVZunAZh6uWT70r/KOOExEvmFU54d2X
	trQQteoa+TMwLgzzf/eS0f+eIq+oN/uB4X1u7vZoYxtNgQYp7RQ6rcXsv3Ol9TuBnh9BGA/U1vr
	Vghvt496aDRLvd7enODzIlSp248bvuGSXMHMol7qU3cGnqYRU4NwoKOB1wg3gtNdFlfAajb1RtP
	9uzuE7D3IdBQ1QkyNqktCqYryCNeivIrBh5hC9zSi9LZk0CQ6zZHn+mUzZBDorAiVvIQAZhr7L4
	=
X-Google-Smtp-Source: AGHT+IEJ7sLncHIpIXgTAx+IOx8NnCEC7G9sEdO1RRJXJoDmgqZJft89zwy+s0ue6Cf0SqVHKj6FsA==
X-Received: by 2002:a05:6214:2261:b0:6e4:3fa5:46b with SMTP id 6a1803df08f44-6e87abace9bmr109048786d6.35.1740574630979;
        Wed, 26 Feb 2025 04:57:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b153fcesm21581766d6.88.2025.02.26.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:57:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnGyL-000000007Ei-2Ic4;
	Wed, 26 Feb 2025 08:57:09 -0400
Date: Wed, 26 Feb 2025 08:57:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250226125709.GC5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B36ED43DF6289EE6C3C38CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B36ED43DF6289EE6C3C38CC22@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 02:50:57AM +0000, Tian, Kevin wrote:
> > Maybe it is both 2 and 3 if the GCR3 PASID 0 is setup to not translate
> > but do identity?
> 
> yes but conceptually it's still more a #2 thing from host p.o.v. The host
> still sees a nested configuration no matter how the guest configures
> each GCR3 entry.

AMD doesn't even support nesting now, so if this patch works it means
it is scenario #2.

> Not exactly. They are functionally different but serving the same purpose
> to the user. From user p.o.v. it's sufficient to have a general flag for sats
> when allocating a domain. The underlying driver decides whether such
> flag is supported based on the domain type and the associated device,
> just like checks on other existing flags.

We already discussed that #4 works with CXL and #2/#3 don't. They also
tolerate different PCI topology settings. The core code needs to know
what it is getting into and in the case of ARM it needs to instruct
the driver which of the two options to use.

#2/#3 seems to be prefered when possible because it uses less memory,
has less invalidation overhead, and apparently about the same
performance according to the SMMU spec.

So I think two flags is the right starting point..

Jason
