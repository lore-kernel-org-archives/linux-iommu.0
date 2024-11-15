Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F371B6CE0
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677192; cv=none; b=eSjNp8aOMZyVZy7V99nzeOTg0xe9OOaJDsoPvI+wmSjqWl/mzEREtPFq0rYqCvNAP1Ww/mA7jBkrZ7N3A2SGWWAWxwJt2FrDLIgZ2lvQ8y2aKplAxeBG6HSxZJjjzq7a9gIDHKNWLZduNOWL8/7hW715PVauNq9kJOgMPhw9MFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677192; c=relaxed/simple;
	bh=WvSZ9qIe0V6HBDKa04t36QgtqKCUiUZWx8BVuAqOMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jECxzcMlrzVbgvEhxPCIZjrKZI9Y4xrn00nXpXN8r5nXD12SkxduozYB0isNj0LwopXf4rF8SA7q2wplTHoKZwoKqQzIg5aX1CngeVNYTz5GV7oO44lxUWtlNFgqBHi9SYgc6oQ3C5zftFQoNLa6ntF/6wBoSEc9dEmtqPIooZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFChyJoR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFChyJoR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8ac50b79so151805ad.0
        for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731677190; x=1732281990; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+IpTRjoQKJ23nZWZNSiXAfo2Q2yAXDVEaJ87sSiE0c=;
        b=PFChyJoRkqBPKug4T7pjyfHIaQ/QZ+fCeuk3f5IyhcN5FDJENpvDeucvjJin82Qw9Y
         OgtUGWucJShd308kmUl4MBMtk5OT6CciudpxBdeHtzuhugHYOkSGLMWCY+dkd3N5U5/Y
         fO3S7IHdJmT7ASZX2U3gfS2HwdgCSjmuVyy1oqQlQn49Mf7ig41I452/dogwnI0S0w/f
         /6fWYWkDzEI2pfa6cXK6yl7db7KNel98AFmI8ODG6cwlhqXaNAtbXF1fhKGA/5hiFdvO
         wvMgdubvhrRaXtKH4lc6XhYUB6sMXsyFlz4HxjOpmB+SZFax5aFvkJJ27JRv//oy6ar/
         lLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731677190; x=1732281990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+IpTRjoQKJ23nZWZNSiXAfo2Q2yAXDVEaJ87sSiE0c=;
        b=Dr2mz6V2N2XwzXfcCNN6XnbMYkn5ZsV7OU5CT57H6AlMral0wQMubZkEZeO4Z4SPvY
         fgJr3w/VQy0gc1OjEE5FO5myw21HFvrKEO1evdJmscdmcFFo/nstel4wVCYyk3CW8ndx
         DMSoCFhe6IZ0lOfy05MuNWSfDvSDH5ZcBgmF8pBVcdO3fNN3HMIXNEklaqE4oczi6ai6
         rrA3oe24S4ipau8Cm2NRevxTC0giGLJ2LYKxA1FevXxXXBRUIT3JaOZtpli1PDaepIHa
         tXJrY6M+M8tk5Io1qbFL7QNSlNCVZZgGAG6GNMnslo45jHhpXbYR3TLOQK1jPsLBwwr6
         pJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3rpAztDUEjzUQhInZByNdPIdcxWOWNFLMAGNSIXEizRqcX6HZr4YlpdyGWzU7A4EI4j+aHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8TbDO0FCFXyQnGxvCGSSJ72CajUn7KCzY6ParSYSOJenvZz4n
	tMwbgLHwGIJ51fshyyogApCZ6Q95T8S5oYqkx51sifaz3qZf3CvSLDnTfRcWdQ==
X-Gm-Gg: ASbGnctThejLAouBURajtI2rqQBxgEW1NsyzSJSrZusIkafnJ3JYCJSoduSCg5pKFPB
	HfSG7VuUA6sGgLMtnPMQhal2KNlaaQgDE57l0KGmeDnRqLdH/9+BdxEEtKTUYYFCEZf0XkGtCaF
	/KjnpoeU5hjQn+B8D+ij/aesnQF1KicCyjT0PA8oYgpA+Aoxscdfp/C63Q3cOoje/F1rs9RXj8z
	INRQKdqhzUToHIrYl1F/lQiY8tXDUBDyQqm9m6xyInVrpJlQOy6wXo1d3uvZJ2WDRbjhsZnq0rR
	1eLfHntHajk=
X-Google-Smtp-Source: AGHT+IHsTCTbaAXLTo1ugg/sEbevBzLqfaBckxyqR6BfeELrmzx7dC2N8Hreamagd5F0hsBlArTW3A==
X-Received: by 2002:a17:902:d2c3:b0:205:968b:31e9 with SMTP id d9443c01a7336-211d1d94a05mr1898545ad.1.1731677190105;
        Fri, 15 Nov 2024 05:26:30 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dc03fbsm1242510a12.70.2024.11.15.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:26:29 -0800 (PST)
Date: Fri, 15 Nov 2024 13:26:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Avoid redundant master lookup
 in events
Message-ID: <ZzdL_mC7ZiWVjtoQ@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-4-praan@google.com>
 <ZzPqRH57RjNS+lJ8@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzPqRH57RjNS+lJ8@Asurada-Nvidia>

On Tue, Nov 12, 2024 at 03:52:36PM -0800, Nicolin Chen wrote:
> On Tue, Nov 12, 2024 at 08:30:18AM +0000, Pranjal Shrivastava wrote:
> > Remove the call to `arm_smmu_find_master` in `arm_smmu_handle_evt`.
> > 
> > The call was primarily to retrieve `master->dev` ptr for reporting iommu
> > device faults. Since this info is already available in the `event->dev`
> > field, we no longer need to lookup the master to fetch the dev pointer.
> 
> We only protected the "dev" for dev_name() while the streams_mutex
> is still required against arm_smmu_remove_master?
> 

Umm.. as per the code upstream, we were just finding master because we
wanted to pass the master->dev in "iommu_report_device_fault", thus even
if the master is free'd by arm_smmu_remove_master, the struct dev
wouldn't be free'd as we still hold a reference to it here due to the
call to get_device in arm_smmu_decode_event.

> > @@ -1857,17 +1855,14 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
> >                 flt->prm.pasid = event->ssid;
> >         }
> > 
> > -       mutex_lock(&smmu->streams_mutex);
> > -       master = arm_smmu_find_master(smmu, event->sid);
> > -       if (!master) {
> > -               ret = -EINVAL;
> > -               goto out_unlock;
> > -       }
> > +       /*
> > +        * If the master wasn't found while reading the event or
> > +        * get_device() returned NULL, we shouldn't report a fault.
> > +        */
> > +       if (!event->dev)
> > +               return -EINVAL;
> > 
> > -       ret = iommu_report_device_fault(master->dev, &fault_evt);
> > -out_unlock:
> > -       mutex_unlock(&smmu->streams_mutex);
> > -       return ret;
> > +       return iommu_report_device_fault(event->dev, &fault_evt);
> 
> Apart from the question that I asked above, it'd be convenient for
> my vIRQ series to add on top if we can keep the master here:
> https://github.com/nicolinc/iommufd/blob/66b3f9cdb39920880fb052b53f11ceb16af007fe/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#L1782
> 
> Given that your flow is:
> 	arm_smmu_decode_event(...);		// get event->dev
> 	if (arm_smmu_handle_evt(...))		// validate event->dev
> 		arm_smmu_dump_event(...);	// use event->dev 
> 
> Could we just keep the driver as it is, so your flow will be:
> 	arm_smmu_decode_event(...);		// no event->dev
> 	if (arm_smmu_handle_evt(...))		// get event->dev 
> 		arm_smmu_dump_event(...);	// use event->dev
> ?

Hmm.. looking at the vIRQ series it seems like we'd anyways need to call
arm_smmu_find_master here as you're adding more fields to that struct
and plan to use them here. 

In that case, I don't think we need this patch [Patch 3/3] ? 
We can keep the code as is and simply populate the event->dev ptr in
arm_smmu_handle_evt when we lock the streams_mutex as you suggested.

> 
> >  static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
> > @@ -1927,6 +1922,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
> >         }
> >  }
> > 
> > +
> >  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> 
> Should drop this.

Ahh, my bad, will remove that.
Interesting to note that checkpatch didn't crib about it!

> 
> Thanks
> Nicolin

Thanks,
Praan
