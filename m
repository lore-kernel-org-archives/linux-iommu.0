Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA914AB5
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 14:18:57 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-668709767b1so3293617b3a.2
        for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689085137; x=1691677137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv6dpDGQjr71q1bN/lbW9GuGtuBzZo7bmAZPkqqGTBo=;
        b=gmJTHGcXpbnuUZLGkDrhJQ47+LLzkVlh8slDsu3vUaO+hfYUiC9aXipQJc59x6IglI
         Ogg8RfX1gi3hSz4XZW00bsahw7U4DsKpZTUCSs2UN4wGAh4P7b0WWKQvAGTVr+7Kiqbt
         rzQO4aObFvDM0HcoFETQ7EZ32BIgDahJSpCx+mVXrMS5G//6MyT/3EuQNFLbzRUPelvf
         dnxunj59WVK/TSTp/2lqac81bxyaYdbjuq9R53PmJFG/VKB8DCMfOcSSTVJszFjrGEn3
         HoWEf1ggbzV7mW3YBVPff6FKScIXb84lETn/LFJ9SctBxkhBIhVEkBRsgfCxfAqPcS0q
         9LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085137; x=1691677137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv6dpDGQjr71q1bN/lbW9GuGtuBzZo7bmAZPkqqGTBo=;
        b=HGyDlvn7gBBZGPyYzDGSafj+Ors/wP8OYNa6I3doZsB0YnqnyoHl3vJ7cE8pZ3YoXF
         F4l9NJ1Yo04EQx810TilrF6Sn8khtNur7RDS/eDW+i8YdN00jm+n/kXDelgFRPvy5G1e
         IIpQjECrIOwtS4CY2xX2Ak6PL6hCe1MZ5wdmuhhlkOLEanJWc2nRZfyfUZkpN56vyCgA
         FEx1oBjXOe5cicN3wrNtWNa9eyPOLI0AETn6fZjaT13BS8G4yJ+mCJv7N5PJ/2n6MBvt
         n9OlaUXGPrjT8NbSR81IdC93xNOFGwL2h/2dkYb0+JgWkrlpP59vZJtW/UxZpU4/gOfx
         hVyg==
X-Gm-Message-State: ABy/qLb4bEzIKfXEcZOGkOyLf0Bnj8+aloODH2i72RvE+Y3Fl2YPDkXb
	rNvgsW8s7hol//qI6YV8GF9omw==
X-Google-Smtp-Source: APBJJlECZpsM7dUkJEiPSoM9Sbh/e5i6HlXOsuPwcIZztMyqTFWCyi9iFfM0i97yLHg+jHZgnctPlg==
X-Received: by 2002:a05:6a20:7da7:b0:132:7d4a:34b5 with SMTP id v39-20020a056a207da700b001327d4a34b5mr1028671pzj.37.1689085136930;
        Tue, 11 Jul 2023 07:18:56 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i23-20020aa78b57000000b00662610cf7a8sm1798466pfd.172.2023.07.11.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:18:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qJECc-000AW6-Pr;
	Tue, 11 Jul 2023 11:18:54 -0300
Date: Tue, 11 Jul 2023 11:18:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Message-ID: <ZK1kzlAoGg8qayrT@ziepe.ca>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com>
 <ZKw/xS7wOoRvNfnH@ziepe.ca>
 <6e88db76-6903-cb7b-b608-811a97986592@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e88db76-6903-cb7b-b608-811a97986592@linux.intel.com>

On Tue, Jul 11, 2023 at 10:43:43AM +0800, Baolu Lu wrote:
> On 2023/7/11 1:28, Jason Gunthorpe wrote:
> > > @@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> > >   		goto out_unlock;
> > >   	}
> > > -	if (domain) {
> > > -		domain->users++;
> > > -		goto out;
> > > +	if (unlikely(domain)) {
> > > +		/* Re-attach the device to the same domain? */
> > > +		if (domain == sva_domain) {
> > > +			goto out;
> > > +		} else {
> > > +			/* Didn't get detached from the previous domain? */
> > > +			ret = -EBUSY;
> > > +			goto out_unlock;
> > > +		}
> > >   	}
> > And if we do all of this we should just get rid of the horrible
> > iommu_get_domain_for_dev_pasid() entirely.
> 
> At the core level, we have no idea about whether an sva domain allocated
> for one device is compatible with another device. Hence, we should loop
> the sva domains in the list and if the attach interface feeds back
> -EINVAL's (not compatible), we should allocate a new domain for the
> attached device and put it in the list if the new attachment is
> successful.

Yes, generally.

It would be good to undertand if the drivers desire one sva domain per
instance or one sva domain per driver - but with this approach it
becomes a driver choice which to use. I would guess that one sva
domain per instance is slightly simpler in the drivers..

iommu_get_domain_for_dev_pasid() turns into a check if the group
already has a SVA domain bound from a list, ie we turn it upside down
and have it search the list under the xa_lock instead of trying to
return a domain pointer back out.

Jason
