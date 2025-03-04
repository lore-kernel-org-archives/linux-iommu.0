Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F2202F92
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098034; cv=none; b=VUafUlBhCK1Rok3rmW0bPbF7bcyrZnieJIH0BpA+Uo7Hq7Kg64v85371p6mexGimIfwwPgwyTVbkz5WLMTX29hn3tgQZDK8iNeQbhnGpgPq87qee7XEStGOpKE82yCoVMXpicOmonLMrvmccz8MH24diG9ABo799J7RcAIOVtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098034; c=relaxed/simple;
	bh=d+9ZVOUjV9hs//gc1vdUqhlQzs2eUUu4jPGyo9UIYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gem1f3NMzzqHzRbTXBtTnuZWbNdVLqNPGJfO37T/65vLIBNZpktlMYS/PMMMk1MNasYSUNk2L70rOPoKDD8sx44OoADJfjxWwylUEVmBmLZ9Nv9YVhRv47nlpMT7o31hFVjJDD25p4RuNA4PGb5/+hZ7Kh8s1s6jEM6rW+4+h0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NGtKh0SZ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NGtKh0SZ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3d0e90c4eso43638385a.1
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741098032; x=1741702832; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nm+A6rvQMVH3wHakrf3T0sraHmyAbjEgCVYcMsl1+ZY=;
        b=NGtKh0SZcD0mtDYspTyldUbYkP+eOJxfkEfKZKeMt/vNyh0IOcnROlifsz7n2HeerM
         oIKQOH5w1rzb10d36mclZw19tqFBC6roAArRQEazqZ49TgrwK/UEWEx9C16NU8O1JbpD
         q/mqIOQNiEPcFRO45kYQRGuplKYKVzXU6oIrlCZgN3IcCJoRDHoaHWI/02gU5SRJkVhR
         Cno3ZXLPRmq/Ye3JccgcHYOX/DJzK4FAVrFR5MCw73APYodRUZkH/MN/xpHC3p/AcTse
         aLszZkDM/c13rAs5NYjr51GT2+sn/Z3lZiyiyIBBZPt7E6xBnpSimjeNcJncYg4Xv7l2
         qXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098032; x=1741702832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm+A6rvQMVH3wHakrf3T0sraHmyAbjEgCVYcMsl1+ZY=;
        b=btxuckutTq3jtNHpYmuWpOugYMXaqBLprhuRuRK7s6nvg/QXRUOhQjCUdhdl6oqm+r
         CxNHuazQDQLBV+DXAogidh2dVXASNI+dCG4SLuWz0z8uXaQpa72nRg+qfIBPQ6T+VEqK
         wb67qdnYNRlpR9cCPT5V16uKDOG+9hr6huXg3bGai4nBn9LSO7gKQIZ7ZRl83SpBx/dD
         choOtOwpgwvwzbckw1Fkx25JRq3zgoBtFD61uvb0yO3B49iEpeKzIlQmCDFhnuU2NarQ
         Ot+fARzPTkCITnb0IDXjJB9MZeZJv8FofKpY6qMvUlGZ15/mJ37ctCiRI0/UVb2Qa1nS
         71rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3ychKJorZHa8E3DL+Ki0G/cR0jnB2LrJpf5o4Iw27eoDI3hebvcLKpePZGP6HyR2T2zH/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4qOqHTLcL7oJTVD9WvMs+UQ1gz8z9W84QmBIfM3MnRwBMlJ2Q
	GjDc+khsZtjilIAzi9BkKw8aEH/+Cx+odyfVMjV1M08EUgXW2jjsQk9FbsG1Ft4=
X-Gm-Gg: ASbGnctrU1GRAJ2CdEuW4R6tSk+y9BUT+fuXv6m78dnkYdOmuj8hWsf9CwU/+60017d
	K4dW+POJUUGRRGElRI+HElHuAuGSy0MjBKacjhC7rx5ku5hvKao0aHj5w7jBy2UzlTeuoZpvIyf
	3e4fD0VHQloleaQpW7GDfse59Q9Ed1OglB7nDBUjmGodCoKr5X9KbXU5tjP5SO5PZzTfxNbngUy
	7yQfLHFziIFhxxvDwdYg/DdP+eg/Hqr32srIvsFrJ8SmLY0qLPe/T8+ZUOx08JGIWc7XfJsq0ay
	fu9lt6Oc/ud+y94u19cZI14RzAcuOLN38zL02xGyqtNcVTEn62Z/HxhNSCkRpqcs3s2wkSkhKbc
	tKRmHBNaW4eevdlgz1g==
X-Google-Smtp-Source: AGHT+IG0H694ys8QOV8jSgoiPZqKkZpzLfdOjm+v/dx9czT7OuW0sTtT7Jx8jGKjifq86VS6az7zng==
X-Received: by 2002:a05:620a:6601:b0:7c2:f39d:d0e0 with SMTP id af79cd13be357-7c3cc2ffe32mr493164585a.3.1741098031838;
        Tue, 04 Mar 2025 06:20:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbefsm66733706d6.85.2025.03.04.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:20:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpT8I-0000000176Z-3IJw;
	Tue, 04 Mar 2025 10:20:30 -0400
Date: Tue, 4 Mar 2025 10:20:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250304142030.GA5011@ziepe.ca>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>

On Tue, Mar 04, 2025 at 02:50:19PM +0800, Yi Liu wrote:

> > ARM enables ATS when a PAGING translation is set on the RID or any
> > PASID is used. Otherwise it is off, eg for RID = IDENTITY
> > 
> > This seems like a reasonable thing to do to me..
> 
> will it affect Baolu's above refactoring [1]? :(

I think no, but when we get some conclusion how ATS should work I'd
expect all IOMMU drivers to align

> >   never
> >   always
> >   paging-only
>
> this can be considered policy to the existing ATS. curious, why paging
> domain is special here?

Using ATS with an IDENTITY translation is not a performance win, so
you'd probably want to turn it off in that case.

Jason
