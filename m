Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23942080F4
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098246; cv=none; b=lXZIfxGFxaVdnoPfExgBAguQOqZVSJJJG0ZPgfW6ZY6+c/MskIch24QlwQ/AfUUJ7hEcnryZTx7+uXu/b2TMS1tLRdUyDd6AD+F8DOxtd+oaS1pD+GPDJ4Z3/iFWTAqJGHGFKeEMjwbSoFMa9806GmnT/37EyjlDLT4Jip5JuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098246; c=relaxed/simple;
	bh=NfrvOM3JSjvqZQHaPLKmuVA5RDCX8LPUZHQJfhqbhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZz+SaNhf5+5womKCRtNIgRvmLwG0C2zntlRNHZOl612P/DfXM9UZ/SbYMhw4oL5tYUtfZRe8HdRNl7/CNtBXZw5vtDYV3JwDEeL/GR2mVqgbw1OGmwPG6Hg4kjtujoaJ9pcIjJXr7J+q2WudLK2UryvdDOAXn7+ATrIqvYOom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gLgVeVaD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gLgVeVaD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08f9d0ef3so307629485a.2
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 06:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741098243; x=1741703043; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iU0p2/jZSpnk5i7o9MxVf1ZWl6fXEOixJES6cFrUjaQ=;
        b=gLgVeVaDMne2TbXuqXF6Gr63jl17MLU+H4Rd8Yqe8UURLn2m6BwZ0cCkG0OtwsTJnr
         EprxUKWPd9utVZvxvVZYkVDtsCvmj0cn7NEk8RXspaTS/vcbQTF29HIT1cvCBe8rdgcu
         RRBmcpZOnWRqpvIDGQET/4vIIW/bHRvNP86a5FGOS+68WsumRJh53IcXeXtEt41yXh+g
         T85Y2l8RzJT6IMh5QQ23Vpx7iXvfTywoNLS/d3/NkJr9sX4V4JXZJRzYvl7TzFo+S7Ca
         ejBd/AebYgl0zDXpVSCALaXYS1IEW1uGpE+3GZcLnPWghBpyFvr25ANmtEzeDz7cfxMh
         AUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098243; x=1741703043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU0p2/jZSpnk5i7o9MxVf1ZWl6fXEOixJES6cFrUjaQ=;
        b=TU45c1/Dh/w2qL6gV7Uw7xGKhAwECX5yYotg9CPUAJpggwJ/qx723ADcTh30iI/3Sz
         sYiIfH9Q7L4oaoIe+VvqYheBSTqGPzEMeo/2y1TxbQ6hMQFnrcxRXhIuQzgmpPR+JRm2
         qIeSqEosV+w74K0xkCF+8CjJPi4fQElGQ28pga/6mharcVTNMx+L5l+G5yx3M6vdyfK/
         BYUZRYMzjsL9fI4WoSaXvO/Zz2P7Q36VCbRUTDRxTwd2zqxQ/9Gf/Btj+dn9ia4Gsvyr
         mw+PHfRUlFvkObieK3F+CiDo2SlalRrDFuIEapq2tneENzfGMLjD0YNUcadXYmMz1BjB
         Mj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSRS2E0o1gy6WNBHD+tBZpJmUBeSQ663d9f/1OOUJRs/DhAcIBcYgicXTjwlW0NeATLmdHTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YypX/2eXbxBYkS5WJoJTLB23Yjb/UsW7lbTi38aQ1etpxEzQM6G
	d9+OuSlx9PymgARX9Rdw3YbIsgfdrNKvhbqGanGJ1RMsz5flGnpK5RTPNTjwkSE=
X-Gm-Gg: ASbGncvxENgdpKZBV0EO8oV5hb1ODUR7v60/HxKcYRDZKC/daKgI6+H6ZDfgVoWz8hE
	Y94yITea2sC2gE7rWv5j7MVstn2XHxBsFUbHGwjQxafSuhUHDMRwKoJPya40Qbiz1vKmrXqsFp0
	Z8wzRVxW2WmNUzM4cGYeYshpqk8heEgoChSgb6quIqWZJnihaHhk9sVY9gDrQRN/YGn4NTG5OLl
	M6OF5Kzs6tkarYI1v+XsCeRQCv3nD3x3QV1V8N5WC18f/uYgTzLfVFqsYolzZUV/eNpKfbZmYcU
	hAuH5slGdXalAwfJaC7CP5MuezBMir9QPt/wB6f7jZnj5/FEeyH3vLedIgTTDr7qLC5bzAzOrUW
	0S+OgGeKvEPe1Eek7IA==
X-Google-Smtp-Source: AGHT+IHYQ/yyO+RRSArx4BQKRcY9KQsHE0gb+ob6fhbI9OjQhD3xMdjqMioTe2k/ZlXEWcQ5Mf/3GA==
X-Received: by 2002:a05:620a:8213:b0:7c3:9dd7:99c9 with SMTP id af79cd13be357-7c39dd79e9bmr1851586785a.26.1741098243398;
        Tue, 04 Mar 2025 06:24:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3cc0c20ffsm132915085a.91.2025.03.04.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:24:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpTBi-00000001785-1n8f;
	Tue, 04 Mar 2025 10:24:02 -0400
Date: Tue, 4 Mar 2025 10:24:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250304142402.GB5011@ziepe.ca>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>

On Tue, Mar 04, 2025 at 03:45:54PM +0530, Vasant Hegde wrote:
> >  never
> >  always
> >  paging-only
> >  secure-always
> >  secure-paging-only
> 
> Why not just expose supported modes (No ATS, ATS, Secure ATS) per group and
> allow admin to select within supported modes?  We may have to add more logic in
> sysfs store/show code path. But user will know what is supported and what they
> can pick.

A sysfs type thing is what I'm thinking

Just trying to understand what options we should be providing to
userspace..

I am sensitive that we'd like to disble ATS for identity modes in many
common cases and we get that implicitly today.

> Also sysfs knob needs new domain ops to communicate changes to indivisual
> driver. Like in store path
>   - validate the input
>   - make sure driver is unbond so that its safe to modify the
>   - New ops to communicate to indivisual driver
> 	 something like ops->set_ats_mode(dev, mode)

Yeah this needs to be considered.. I wonder if a flags input to attach
is the right way to go.

That would be convenient for how SMMUv3 is structued now as it can just
switch modes hitlessly with its existing logic. I think all drivers
should have a similar design.

Jason
