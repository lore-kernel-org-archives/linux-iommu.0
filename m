Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C615383A
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097897; cv=none; b=Sh4KcXahIpJk7MZ/Bij76MtsS083F89QRiYkv1cxm2ceIiwI3x1zKrfiwWiKwoKlPa0vMchyBOw+h1NpoYy8+SdYC+12oLS5tgUL+rwD+HVaSTWOdVY6g33eraSN4XrciQLdHqrmMxS4ExgvH9ACFks6WdOcw2/DD6YkumROJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097897; c=relaxed/simple;
	bh=hn39J7mpiKrbcuSWj2opT1u906/Zri0Hi3CAHZw/ACM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMbkx24I3mdudeGawr57LSUIdt+mFjyioYU8vbdfkuQ+cyOgOWPhXnT2BWBw/drU/SQeHMW4ARtFhU8AWvameOToeTPQBhmsJp0Y6hFubf0EUbMHNpxFSVqdWQdN8mvcT9vNkW/K2LZlczs9kkyzVv3aTlPQVDU2puskox39h40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IpHkjDPQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IpHkjDPQ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-472242b0da5so51721831cf.1
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 06:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741097894; x=1741702694; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jEMqR9ouIkXa0LzqPpheq283iJUSTP4dD6U0LbfcqwU=;
        b=IpHkjDPQKsaSKzSJYb1Ioh/oHUkKZUbNbCAA5UyB59JMACFJaB/48VNccH1Jr6GuRX
         covVdf9Hr86aBztmCbC3AqTeZ+J2nHCDfPV6QrlIHc5N+z1IyjYAmLYT2jvCQe5sGeM0
         MgdGGlGGVg/yA6FMjwX7cZXhg2aw4trd5ikfQki84gXrK2MWdAV47yGYuTDMTzt8S4W5
         IE9wHUu86fGtofqV6Ikc1KsYBY4Uo1U4rQrRysuNQ1TYXkLjtT4dzdyugfZsGIyamzvC
         ytK5LOxjkcdatOnFpFpi+DJXPYAlej9b5DX0TBqcjuaJGy5U7elJrP5V7MQD7gCq4dmv
         GAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097894; x=1741702694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEMqR9ouIkXa0LzqPpheq283iJUSTP4dD6U0LbfcqwU=;
        b=AZCwyuNkWnVGrHm73kYnx2w14vLD+PBvM9+nCRSn7Vihmo6Zo8ytUViJLyBpq0KFw3
         2/N0b47acN2wUBz5MLQiQtJnXKf99V5zLkIHaUe9xC1mvG1eShgN1AuwTsJxUfMkFrGa
         Ug6hV+CG0bin3xrK/l/u2f4S+TDpkZoTqr5EKqxu9IOraYUcwmWGUKGeOTIRL/e/dTDY
         b88D28/daJ139hTZ+CBchuqsc9884nde7BMQ0j2UQfj7k0hCBDI4KTyPQtJ2r3fkUBBI
         JBnW+JDVMdL5BS4DzPszLhzN/d9u7y9arWzNwwwdwF66ZPoxd6iAV4QKmCFifTJh3K9u
         /j8A==
X-Forwarded-Encrypted: i=1; AJvYcCWp2Lcz5kdpM44Az6fohUbZ5LQIMIffmTf/9AZH87COTTEMYFFx2LFMLspM9UuiYa0CLjWYuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl0Va/oy1vlMIgtaECpGsKOEWrNs7SAHAJLgzc63doGAuSPufE
	4Lj5ZW58dVYENeZVfXUaf1wSeTtj7fnkNjfucF/ODUueQ5B9VH/5RXUvewoTrm4=
X-Gm-Gg: ASbGncsdkGft/OhEJFMtMo0ps1SO7ZLf/Gd/9ENxuiyUyxrCzVZEsa9VjGn3oEWILQh
	5i3XWmJclnSjnt++cOD1ADFqXhs1fZdJv40qrYI9NlhOoh6djOAvhs/DMGz2W/SEITy8PTr7ndA
	M6JLY5Yz/mwTo8JbiHAO2gylooYoczATMSA24yWqvahvsoL16lhELOHo72TsazQB60BYXKrE8pN
	OLN0Z6MWtTe+JxoLWY2VE10JFxFWB2XB9S2Q7CIa8a6B2aq0F3PRJ1z2q6a/4Os+ybrE2cNjGh3
	6mU1mjyOElJWDyePK5dJp8iSC5zvNGBjpOjIZ9y9gUUSezJX4UHP61Erp522hL3jtpgeblvxVpf
	yZnj15f/Icba9oU4k7Q==
X-Google-Smtp-Source: AGHT+IGXJxUBDb3ZPSkAc2mMWxuUfG2JjrZ87ln6PhpxgivXw7hNVTM4FYweZmSGzUEsf65Ly6IVXg==
X-Received: by 2002:a05:622a:7281:b0:474:dc97:2108 with SMTP id d75a77b69052e-474dc97240dmr87034811cf.30.1741097893673;
        Tue, 04 Mar 2025 06:18:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e817b59dsm28630641cf.22.2025.03.04.06.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:18:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpT64-0000000175Y-2goY;
	Tue, 04 Mar 2025 10:18:12 -0400
Date: Tue, 4 Mar 2025 10:18:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250304141812.GZ5011@ziepe.ca>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <24d8234b-ad59-4b7f-b210-b97d7b5dd998@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d8234b-ad59-4b7f-b210-b97d7b5dd998@linux.intel.com>

On Tue, Mar 04, 2025 at 10:16:45AM +0800, Baolu Lu wrote:
> For ATS enablement, I believe we have already reached some agreement
> that ATS enablement is in an on-demand manner. ATS is enabled when the
> first domain that requires ATS is attached and disabled when the last
> domain is detached. That matches what we are doing for PRI.

It is not quite so simple, we need ATS in some virtualization cases
for VFIO even though it is not "using" ATS for PRI.

Today the iommu drivers always enable ATS for paging domains if ATS is
supported. This is what I'm wondering if it should be made optional

> When a domain attachment triggers ATS to be on, there might be some
> cases:
> 
> - ATS does not impact functionality. For example, ATS could be enabled
>   for the DMA domain for better performance. In this case, it's a
>   successful case if the device supports ATS but the platform can't
>   provide the secure ATS that is demanded by the user's ATS security
>   level. ATS will not be enabled but attach returns success.
> 
> - ATS impacts functionality. For example, the domain requires PRI. In
>   this case, it's a failure case when the device does not support ATS or
>   the ATS security is insufficient.
> 
> - ATS compatibility should also be checked in domain attach path. If ATS
>   policy between attaching domain and the device does not match, an
>   -EINVAL should be returned to inform the caller that "domain is not
>   compatible, suggest to allocate a dedicated domain for this device".

But this philosophy makes sense

Jason
