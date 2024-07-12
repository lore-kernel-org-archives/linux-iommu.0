Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0816F856
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789241; cv=none; b=jkuiE/hgVgaQyU2ctdVbFcPpVGAcvXdt158SXZppdJYSRWGo3bA6We+rNqWT2oHTcsu7QzTGp8WL5vR3PYeugVhxjsdwUwTZTFpXgOIwyOFMPN46MSnY+jS4ktJKmMn66uIKfcKS4jbUW16RBnpXIj/ap8tqglAaCGPUS6sCcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789241; c=relaxed/simple;
	bh=4vaan9lVCWHn6tCkQmfCAQNwBS43BDI/yL/E404vsrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGRQElcA7ci0//YKhazGcBk57L+K02Moki/kHIfD3lJevbdWCS2vpIp5VvEP5XqwIZZuGYJ6V6McD6kZ80ggxV0OZ9wHcyPzncbte9GsHUYOJX6edHYvGQKA02OE4RI0EQoh6O+KpAK66g6x4rVpR3qLTpY30v+feC+WkPwT//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PzxA5C3G; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PzxA5C3G"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e04289a2536so2244400276.1
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720789239; x=1721394039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/w0zwGhNPKt9SyZTMl06PaCMjOKZYwYdrSeXLeSiM4=;
        b=PzxA5C3GdWxu6maKT5pJciGWzXvug2rOdaq74j278zpTfcEJruSr004aIU8N1hxbOP
         yYVcW0oXzomND4oGFWPGhtFyK0mr/6wyM42rj4tz/iI3ZxAWcZRMldxaVjiqvybvw+O6
         CjP/G048CKwqYNDmj0Tj94I4wM3JBwcwxzrjlzUTDqXX2NNwulrkP+CArtc9F76kKPhO
         JAge/5ZKcoRZRV4WIzTfM9YE0L+AUE3aH6WmnFiH5OV+1q1BF2H/etOmbtbSQ9PIs3Rk
         Gl19lhQJBVsSmdGDmauFesj2tikz+efuizlyxRD3eYcID+dCm0vpHHp+VwXA9fpSj9OK
         uMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720789239; x=1721394039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/w0zwGhNPKt9SyZTMl06PaCMjOKZYwYdrSeXLeSiM4=;
        b=iOlQRG6cljyRps1Xv5fvVNgJ3VeQGzXfN78/TYN5PVjL2wFP4EM22q7k1jrByYa3XH
         SXJYh+0neikEu4CzsDwie/pxXLh0LM8cOZeNnJ80SflB9upK2O0mfpwsECRHI3jATUzb
         Iy8WpiHnSlluiE4nTi9ow0de0OMKbOEU0OmdXuqTAMW55GSCsdN42xknWd38bSs9YImk
         XB8asE7tblnlms8Gk6jw06LmzUh1v4VsSo6oGuuNOrM5kDQ7Zef54c4w4/8fNeB3UZoB
         gCgFc4YX26Ah76ijsc3pHrEFRQ2So/dwigUnulNRqPsy8XdNWWo0SvmpJbS75U+KhcIi
         mtJA==
X-Forwarded-Encrypted: i=1; AJvYcCUlDRNj95ZDKlxfd4J7VJCAnYE7xsG7JWX6XSgLs4hh1fkUrRhdXpOJ4ho3gprgL9ubEwQz+6I921mVM4ELbxvuccYKA/I=
X-Gm-Message-State: AOJu0YyGaN31n7ncv5mnxXLf01rg5qqw8Z/5Sd45BHO1+JInaEHvZfxu
	houfDKwQ40GEFduIXH8zvthHKy5JlsZKBj7Oo7Sy3VGcl4i9CivbcTsGTVGtDuo=
X-Google-Smtp-Source: AGHT+IGrtfbkVyeqhWaqWAqPeH9PGe1fIAllaalk3hPaJxwrAsvjR5TxMPnud6p1klxpbKWWS6qKSA==
X-Received: by 2002:a25:69ca:0:b0:dff:2b97:b06b with SMTP id 3f1490d57ef6-e058a4eb6c3mr1874869276.18.1720789238613;
        Fri, 12 Jul 2024 06:00:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd25d2sm40132481cf.61.2024.07.12.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:00:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFt7-000J4s-JG;
	Fri, 12 Jul 2024 10:00:37 -0300
Date: Fri, 12 Jul 2024 10:00:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240712130037.GA14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
 <20240709170038.GG14050@ziepe.ca>
 <Zo10duoguPCADKSY@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo10duoguPCADKSY@Asurada-Nvidia>

On Tue, Jul 09, 2024 at 10:33:42AM -0700, Nicolin Chen wrote:

> > We are potentially talking about 5-10 physical smmus and 2-3 FDs per
> > physical? Does that scare anyone?
> 
> I think we can share the same FD by adding a viommu_id somewhere
> to indicate what the data/event belongs to. Yet, it seemed that
> you had a counter-argument that a shared FD (queue) might have a
> security concern as well?
> https://lore.kernel.org/linux-iommu/20240522232833.GH20229@nvidia.com/

That was for the physical HW queue not so much the FD.

We need to be mindful that these events can't DOS the hypervisor, that
constrains how we track pending events in the kernel, not how they get
marshaled to FDs to deliver to user space.

Thinking more, it makes sense that a FD would tie 1:1 with a queue in
the VM.

That way backpressure on a queue will not cause head of line blocking
to other queues because they multiplex onto a single FD.

Jason
