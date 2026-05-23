Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF4384230
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543000; cv=none; b=MUpqn1bqTHOf9E9ioUawCVNwzL/PFSLaYHK0AtXinJ35sihTXwbE+JVPSbUe4bk0CzhHj/Gc6TMbj3S5ytQa2wG7X/dFzHXg7E/5yrLzHM9FHAb0HHGSnzmxUTmUixAGAVmfXkPoi65LDGB4AkMxjE+niqb0O7ZL1praG4i38kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543000; c=relaxed/simple;
	bh=RgYvcoPplhdqI9CdTTZ6C7ti/+tt7zM/oaJIqfNBkWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM9YXazyOIYIKtPp0N5NHqc3dY33qa9ANPaCf5srpdHpO6jRHvtfvZ7k9OAm7obGf5sI6fq0C6KB+oEPF9xe14Fu0CfrjsfsV/nUGTDq9uVndLnygTmysknvj+sugeqKA1uXriQvOlCdTUMP9aNpqh8BSYrBTe+CG7+9g97BRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FfPctrel; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FfPctrel"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so111136246d6.1
        for <iommu@lists.linux.dev>; Sat, 23 May 2026 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779542998; x=1780147798; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mynkKK2hhJL7CehQlWlPJPsBrNct9+41+jY7GnTD+Ds=;
        b=FfPctrelvn205WmBRWMkapzfAqiORMNeRCh6PEVbmRSAgFywdRZJnhc59CRvcOw7xx
         RNU+RpEkJsHYMbu80IQ9L1sQ+lCv7FK/luutBk6UEnVPtnpDG6GDr+CWnhUnDQgLddZV
         uYzK09kOETtfSve9chChLQJSxvRqgLZeBtbz7chftJXuTVl1t37Dz+mIwWWunOutxnGo
         piCMir5g7o4zE/aGPiDBV3A3z9vAbq/Ar+TinPjsbqez6GmfhR0s+WC3Wc509zi9Yu1d
         dEql0P79BJ90Q7nbr06ADHfyug7WWQ0+T8MBgvimawqzViAqRqAa/VuowBQXGeOJyvlZ
         IfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779542998; x=1780147798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mynkKK2hhJL7CehQlWlPJPsBrNct9+41+jY7GnTD+Ds=;
        b=PeSeuXK5lcwd418/f1fVPPBl6Sb00Ihdrsp5GGDcQWbrBOQTvqwmA1BT/ycpaTfC7k
         kN7ClPRAUH6QV9bS1gjYaM0g3hgKkGwFDqVBOJhJaYWDjbm06+/0pP8PADSAJeHGOCu5
         mJ8Yct8KOLJyid39+4T4w9h2j+ArHpz8p4D0NXePbZXstaha5y/7Gl8ydCG0dKAnzf04
         /hh+WqzgOpf1PWQJ5YfhA13UVlJSWn3PJ0SaunOSHGh4jnO9AlmZmCM2m64vr0y2GTQm
         3kNZrxAwPC+LJYPuF1B7hRULuVlBMLFkVwWA8+c2JPvNhwv+TlCVhV/+aBGqvcVn0C61
         ecLw==
X-Forwarded-Encrypted: i=1; AFNElJ9WBZbTbfsi5D5vOJU59QdTb+FozrAU/2f/wN57+AXLp+GhR6weOldxS7YuM69uLSQegqOP7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUAVrQ8zAuR+KM5zc3T4FqW48x7gamM6IFdE8QlyEECkttMUKL
	hH1dIxrrrxCdQxxprFut0mnKg1MmiGUe8uTODoBd1EfrK+vp7/XXyP3IOk05RrVXEUU=
X-Gm-Gg: Acq92OFn6E1d+AF+5239GyEyC6KOw50mclSKhvet7/N+VVAp0ZAuIxS56zBB67sXEZ0
	SfB7DKrtGvyFpsEKVeRtneZ/YqkOqso8vEeozcBiYTgS7DP8RfXRq7H3h3bKDXQYnJY52uuuAP8
	VM1GV6W0IaSV6t7n1/0y/TBxNRkzP884K1hvMLfTHRahEMBqGOrMHxz5Yz4Yi3m5fn0Qv9uTL3n
	6ruQ3fiZopFgN0Sgjmj28XOHWkxjXmJpoKniv3SerxqVS3deeGojrWay2wzY9t06RvaE7+WDjNE
	kjNnEuTOQeegmVaqB35pZrjvMhQ484a3sdUg7u4Gt4l+G9wgvv7wioGWaLAuIfly6EVCVkrJ8B9
	V7vzzMGoAq+kVM6Z/UfuueWBISo/Z+19tZV6eXWF47JBw7hLWsubT3qBaVuQKAHtmPHPHF7ri3J
	EC1KLxC+OUK5jn7oTtiZR4za1toH92wx1IQ4Q2U0Rkx5QHarGcUmb6zCOhzihfFZ/oiMYnnBf04
	I0Vjg==
X-Received: by 2002:a05:6214:1c43:b0:8b5:84:aa1b with SMTP id 6a1803df08f44-8cc7b50024dmr122990516d6.9.1779542998086;
        Sat, 23 May 2026 06:29:58 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80deae74sm46895946d6.11.2026.05.23.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:29:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQmQO-00000006HXM-46jw;
	Sat, 23 May 2026 10:29:56 -0300
Date: Sat, 23 May 2026 10:29:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <20260523132956.GG7702@ziepe.ca>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agr9ggdY3GYltteV@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agr9ggdY3GYltteV@google.com>

On Mon, May 18, 2026 at 11:52:34AM +0000, Pranjal Shrivastava wrote:
> On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> 
> [...]
> 
> > > +
> > > +/**
> > > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> > > + * @ref_count: Reference count for the object
> > > + * @deleted: Flag indicating if the object is deleted
> > > + * @incoming: Flag indicating if the object was preserved in previous kernel
> > > + */
> > > +struct iommu_hdr_ser {
> > > +	u32 ref_count;
> > > +	u32 deleted:1;
> > > +	u32 incoming:1;
> > 
> > Are C bitfields safe to use in Live Update ABI?
> > 
> 
> AFAIU, they aren't. The C standard does not dictate how bitfields are
> packed into their underlying types (e.g., whether they are packed MSB to
> LSB or vice-versa), making them highly dependent on the compiler and arch
> endianness.

Bitfield are defined in the SYSV UNIX ELF ABIs, they are stable for
kexec, but variable across arches how they lay out in memory.

Jason
