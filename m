Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186CE3F787A
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105166; cv=none; b=s5oIwwbTZPvw78WfzRFQOzozGxVo0piggZB4A+wbcSFe8OvpJ0dyRnrzgoGmdFHP6K+1S77uF2wlUVvogyo72bGjrj2c6Kg12FHvPEFgVqgxkkLya28tA8wBxueifjefumNrB6NcbMaZX5yOcGubI+xvyRkUnNscJjyG/t1GFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105166; c=relaxed/simple;
	bh=TSOB6Vbocoq6beDn4FEEEYUinkclZ6btSniPfWEeNtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH+Zk+r3IMrOyqMUySCAbH8csu5eHAYpk6JlhOY4vMJwyTBi7bEp5qjmV+IhBBDhE47K/u1bWBLL4OfH4tCkC/Yy49LfNVOMk3dmVupYZJlUeFQrNhuHUHSKvj8X07v3OZbZ09nh/lthzLnRJFWRBEEShsdb31XNFnhWFUAxS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrRrKHQN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrRrKHQN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba180a022dso985ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779105164; x=1779709964; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yLlmjF/IblV5lnEQi8qY+GyBL0qWeQ1d8R8yUsdmKQ=;
        b=VrRrKHQNpZ7by6c4phD4TRCUo0KPv+Q26O89PNKer2Xr4kDtJNM0d0jhy0tsxBqg5b
         ksZ4VaYBYyDnac/AYU7UccNhubTE6eymS0xXe+Rd54RFEmmAWg5vm51Hof3i5qZiDLvd
         UxN8I92Jwl5OzjS/S1TlhwfHjdpmgJxR+2vNIrnE2CQ8X8mz8XBYgO63hODrYr45jE4Y
         Jys6wCDgoohIyosvaEOkXqThgKbS94AapjczHWid3noaulL+Bui/a5r7bAf2fo0vRjUN
         0h0bgphgwYFlX0muu/aYIW1Gq79+/7jfkZ1iCt+EMh9dEtRQ+i3A4p7vURXEiK0ZMBzV
         17+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779105164; x=1779709964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yLlmjF/IblV5lnEQi8qY+GyBL0qWeQ1d8R8yUsdmKQ=;
        b=AkcSPZq9lEamMz7JeBmUKUjQ5pB5gcVhgFABv8BcEe5BdfUIIQL4PySXzvcWYLRvEj
         rY7q1S/ZjgFW9dpKXeAAeYnuh6ikEjtOA9Px43uCBH5q/SKtNAaHx/qZKUSLn2jOQG0E
         PlHjXoOotqwTrEOXcl+fikkI6tsuog8sDH5duCWBU6Ll0Ykuq9rWgjXpxI3WjQjxzM8j
         5ng3j/P5F+J8KBYO1QbVExdcllWsP64BdLmtbcwwZ9ROGrmEqxPC1PDrNIeuu2gc6qD/
         mgsnN8/CdJAQkgyaRjt1SFGD8LFveh5Pfr4gTVJzxOKzGH9tqQJyaJQsMAZP0hDPG+Fd
         xijw==
X-Forwarded-Encrypted: i=1; AFNElJ+9vda4Yzkt8BkiH3R0Hk3D45+CadNrV39cVo3FRH5iDcdjyXzjz0B2OmmAKwEZjLpbDmmgQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyIctkoUo/KxhIjjC6sxD9TOVxmakApEa+6X3uY/E/RojQYywA
	jRLSqES5+gq8WXltMwdFzl15yPzE8tZhhBaVIQvwPDiugu2ps5hKanJrWP8SQJxy1A==
X-Gm-Gg: Acq92OFOCTHPDO5u2ekKi9yeV8uOVOek5JHGlJQOjBl+2MzsTz+5wLHBE50ETnnlI5L
	TwMSk+CQ0wb86fUC1ueX6o4+niY2V56rIKr18LkpMdDE8q2cb90CD7tieb6VeTS6RSk2wLzBGIl
	JD+/aBl/SwUgsMFnEr6xaXd+c/lo0jhDi2liOUkruUgDI+58sM5mka9Z/aHOcXzGCTe0CVSGAA5
	A/salV1aByicHvDkVxKAAtgstbBe2IT8YZMqw3fmaSq4+T1b2I/idB7HzXbxBcYxdPgXilRSJYV
	26t9cdHgAxxKwQ5cCW1ODlycehQm8LaHhmgrn8VolfH5N+kiRWxEH4goiTBC0Yzb0wph5AwRq6F
	98GJjKFUHLQBUyuYje92c8rTEcCtuXEmpI0S9iH1KO5KxTrG9B/3J0KC4EU49rCIzC4XEkcIndG
	EI3OrCRLJrDNey30suusR/LjzM4UIjWwp7LR9wvlVxTquJXJBSx+e3Z/+JAsyICpL5UHsf
X-Received: by 2002:a17:903:1b67:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2bdb0416740mr2770155ad.22.1779105163837;
        Mon, 18 May 2026 04:52:43 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ceb3sm14293391b3a.34.2026.05.18.04.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:52:43 -0700 (PDT)
Date: Mon, 18 May 2026 11:52:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <agr9ggdY3GYltteV@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUe71D8JfgmA0BG@google.com>

On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:

[...]

> > +
> > +/**
> > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> > + * @ref_count: Reference count for the object
> > + * @deleted: Flag indicating if the object is deleted
> > + * @incoming: Flag indicating if the object was preserved in previous kernel
> > + */
> > +struct iommu_hdr_ser {
> > +	u32 ref_count;
> > +	u32 deleted:1;
> > +	u32 incoming:1;
> 
> Are C bitfields safe to use in Live Update ABI?
> 

AFAIU, they aren't. The C standard does not dictate how bitfields are
packed into their underlying types (e.g., whether they are packed MSB to
LSB or vice-versa), making them highly dependent on the compiler and arch
endianness.

I agree that we cannot rely on bitfields. Let's convert this to something
like u32 flags; field and define explicit bitmasks.

> > +} __packed;
> 
> > +/**
> > + * struct iommu_flb_obj - FLB object allocated in current kernel pointing to
> > + *			  preserved state in FLB
> > + * @lock: Mutex protecting the object
> > + * @ser: Pointer to the serialized state in FLB
> > + * @curr_iommu_array: Pointer to the current array of IOMMU instances
> > + * @curr_domain_array: Pointer to the current array of domains
> > + * @curr_device_array: Pointer to the current array of devices
> > + */
> > +struct iommu_flb_obj {
> > +	/* @lock: Protects the serialized objects during concurrent preservation */
> > +	struct mutex lock;
> > +	struct iommu_flb_ser *ser;
> > +
> > +	struct iommu_hw_array_ser *curr_iommu_array;
> > +	struct iommu_domain_array_ser *curr_domain_array;
> > +	struct iommu_device_array_ser *curr_device_array;
> > +} __packed;
> 
> This struct is not ABI so it should not be __packed nor defined in this
> file. I haven't read the whole series yet but this definition can
> probably go in drivers/iommu/liveupdate.c.

+1. 

Thanks,
Praan
