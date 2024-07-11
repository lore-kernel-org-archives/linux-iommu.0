Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C96EB7C
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741761; cv=none; b=gj/G2qehufjiGKTHacjl7Mor1X0ntCLz9NK49PigYtF9dlq2GEPiXX2dBMPAEbSt34DmuGZESz2weTbtX8Fn3VRLjEnyM5TGS4ITTZy1p1DXUjw4FhJD830zueY8DSy3YUTjOr5pmG9MAMngwfyOvm0JgmWyYFd/vvDrNf52LN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741761; c=relaxed/simple;
	bh=yflJrTPNtQdPDImQgWjrKF7ETVP8KVKHTksojBDRwYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVsIBwuxYE2uI69zc4Sb7wIYDDVYdqeYb0/uMyZym0jJUnRuJW1VZyW/UKsmYHqd4IuMg21zRWLzcUzwczUFCH53L+jNOOMl9nrD4Ml3OEH80sPqDmyK+S6s8+5+MdsLe0VKUcsvRYd+usvCgxlpFTySXDRr6SxrCSj+L4SNj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OL+fzKYT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OL+fzKYT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-650b8e0a6ceso14929637b3.3
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741759; x=1721346559; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9AXOzQtcLBnv3CE23W1y5O5uveHPm8Sb2rQ0pJVoPMA=;
        b=OL+fzKYTi5/4tvaL+HYn/ZPV6lCxK25m2A0sgcb7ngOBz0x3fgMgg877jNnEG2qRyC
         FQUUoy0JL3lpOLgDHIU089JOJ0WcqL5Elw9JWjzqb1RrBIu/RkjQBM6M2qbKPIy6/RoN
         6AqQu4EgqUepg1GQF7avueOW6GyoyFVrjXvO8jrl+Su6qec/1wEdyLitTySWO9aDrLJH
         Yvuup36PQZXuV/9p2Qjr7nbbNctHyhYrC0W1m57vBCKOupBHmECGYhplan9i6GuyW26N
         KZFxdeXtcos5whq9Vfxlmz+YHEsqsWFp4mWOaK/Rbp9fX0rx1Zyne+5noXGwN+7O3nFa
         a6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741759; x=1721346559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AXOzQtcLBnv3CE23W1y5O5uveHPm8Sb2rQ0pJVoPMA=;
        b=E5lnylbCPiI151tdDUnN95iy0hn/mf6Hoqu7Gtry/Pv3eTn87Gd8WXz3gWtPyUf+DT
         CpMy7nNFtBRdWg4mjTt1vg3Im/hGHeZ8dcLZiBAiVFVKq2mqg6CgWpbJFzreO/GpCNkS
         152bA8yzusx/U2aUCsiDXbW0w3EcxyAF3CxNmisije+hO+a10qL81/ulftEOGLtnpEqd
         ndkmvTPDvvZ6cAsa5roT+Y0lvUXhT6F0C5fWycwnJvSC6hlEshy1JK0v8few1SaE3N5a
         TChBYIL+NL2gdnr7GJ4CixcFafY5HYDmXS0XUxsiE+lsg7tJqYCVFUNLPxra1UZS7HVQ
         9goQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl8Icq9J7Q65yeaeNAvHwSxdVIZJbbgtjNLJz+V/47rNwazyiU+PLyFBp2uflOq1hjxb7rMkbD9qvbpwSDjFE/+edDIf8=
X-Gm-Message-State: AOJu0YwdBisJZgzgCM8jSS747RciP6CVLEoM5hrBYZDuhO37H5pha+bN
	BoEHBHfP67+3UwYDLYyVE/9+qRubogtgISJefM5wFs0zM+TCfZ9YqyZNsp7Aw/0=
X-Google-Smtp-Source: AGHT+IH8whvSBhf/EGdVzZrVXHgkfB5YzWzgNT2lVbzAFhydojH23a7tRwBGTJDWUeGLDrlAndSVJg==
X-Received: by 2002:a0d:ff04:0:b0:646:7b75:5c2c with SMTP id 00721157ae682-658eec68cedmr105264187b3.16.1720741759059;
        Thu, 11 Jul 2024 16:49:19 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1909aca3sm343169485a.102.2024.07.11.16.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:49:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3XJ-00FVBa-E7;
	Thu, 11 Jul 2024 20:49:17 -0300
Date: Thu, 11 Jul 2024 20:49:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240711234917.GW14050@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com>
 <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
 <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
 <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>

On Wed, Jul 10, 2024 at 12:17:17PM +0800, Yi Liu wrote:
> On 2024/7/10 02:23, Jason Gunthorpe wrote:
> > On Wed, Jul 03, 2024 at 02:57:51PM +0800, Yi Liu wrote:
> > 
> > > BTW. For AMD, can a single device be attached to multiple V1 page table?
> > > IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
> > > is a PASID table which has multiple cr3 page table pointers.
> > 
> > Yes, ARM and AMD both have kinds of iommu_domains that cannot be
> > attached to a PASID.
> 
> I see. VT-d does not have such a limitation AFAIK. 

Yeah, it is nice for software that VT-d put the right bits in to let
all paths select either format.

> BTW. SVA domain shall not be attached to RID I suppose. This should
> be a common restriction across vendors. Do you think it is valuable
> to let iommu core block such an attempt?

Yeah, maybe.

Jason
