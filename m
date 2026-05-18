Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6D1C84A2
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125542; cv=none; b=i4PN4psbIZY1qjZHIjTENibPAGWJIozUWklmuCqlf1z66OzcQCyC6E0P4o5g+caghnXvG2ibc+0sYvI3J85LM16YNsDiRYA1gxWpaLROKxCEBwoG923PCVmqmOxNVzcdVAJGJPxwZWJgqrUkxK7B24gT7JMx/VtWpZICNzXet/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125542; c=relaxed/simple;
	bh=Q3cV5SAH4cDTYH2vXZ3VzY3UQDOIWARtFNZRDfTMEpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjaoBDn/EMveGGA8Uq/Z8oUvTaycAukiZ0Q5Dbqn/YxpHb+1Jk/MNylxidna9S060FBWlcWyh/nwTQ+jzK+B/37gj2yySZVcHYVlpmncHYzmZ/TBLnpPj6uC1KDdKUeuveOOHgAbF5uvw+Wil2VmXCxPZSgXEzkltkdAaV8KpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBlmcLxZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBlmcLxZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso805ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779125540; x=1779730340; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtXGNX27t5qmY2uaruNm0Z8Qvs9s1VMC3BIDapVx9XQ=;
        b=UBlmcLxZuy/OySa2OtZQXJ5LVRKz5qsSfL2rYoadMW3acMRUoh0yZb35FXHDP9+Ovx
         2at/VVsViN2xMK/WvWDi08PrwHBJkUo+s1mYUiOaXF/y6vWLrR1fOQPg+IkkMgZJ0HjJ
         OsPiklC9JRPJpobd4A91izhs6mtCZ0thRX34TQkrF3UqbWM9WtviMJOTDFLjcL3PpKcp
         8oWErORlbN0Eob0jlb5B8dukviLf5JLHKmcTdklSSNH0ukO8ZG20yx6sHWpeGNNyVSB9
         L27bEfJrxfmeOfpLsU4nGvl4/uM8INGm4G5GXq17IFngpf2wML3IatCEZIe7cRQNvQoO
         1HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125540; x=1779730340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtXGNX27t5qmY2uaruNm0Z8Qvs9s1VMC3BIDapVx9XQ=;
        b=nUf70ZkI7fauBCCKa1/YF4c0cIr6boAeVtn1NciRTHkuJBZHeFYkX45Bfz9KoMZb35
         5Q2tVI8+r6RSpEycL1ZqJ+CaNPjocAY3Ob5WVIXqAWW8Gf9DgGBn7UdF9o7W+0X2dTLT
         K+pHDQnbnKvPihEeNmULozXA1ZYcYzJvtyWuA5qggOrZeaLmeN2q92h933Xle/svmF41
         ho3zJueeGOfXp+9CqxCXWsYAgHub3pkgPVrBdz3ru2nu5d9do2/WCFdZTJj970PLzeMN
         NhpujnTnVaJ8zjVpEWVI+/tku+gc4cuUOo3SgcLiF9TUBhTOtUyzN0qrjJ2AzloJOHbq
         tjQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p0jCvRRbzF5ngITpxQBxehUL6P/wEi6fLsd5pOD2seJjnyxNWiDdhkFXyM7MHtEGqtNxtpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGAkEjnd1gq6qdkWcQ4ww2vStT/bGESuHFMhy5wuV5Y+Vhyy5q
	FpnC4JjItRqWr07pfL5tleSnY0itoZeHTZrbPJ1jL8zUiT3utx4PjU1QXbe5Sy0ueg==
X-Gm-Gg: Acq92OG1DVC84i3WDTm2LuToEsqHBvUF6iRyt41geXtLGZo07iLmELgew84bW2ho1cf
	KAlJbCQ3dVWoy9Y1GrBXtlpMahLjrkx4vqll78mNt0NAW9YA0pZm4pETyjF4iztXYaDzQQwmCGt
	fsh/qwbxoPBSEjqUyRoMSHDkOUAoGZB9JY00KWEwCVAtSiPvNwS/4bqr8jeWrrDB3yMviVGFD/g
	UqIujWDTb3lWpuBc0jrUCKwOY7rWm7q/zyXrfX05gyhEqFRlHhMGF5Fsu6Xn9ZEW7ZYvQSUqd1m
	hFFERhqeIZ58yY7vTLM9fT4KNgjvYk5rMfKrGM4T8gDklFd5FqlEoSxjIJW7Kt3rrsOE3T3wFcG
	0AAlW2zPAO/HV+JfEvJyLQdGj4aVmpFBrF4UgvuyVtCe6TSNQTHln6GAsJDUKPXoXUUjz3SaYTg
	eIxy+GIzeaAGvHRqX5LqPvdYYKW0eTpZZ7oVKv4rza4NpgNU3RliiAoWMuh8kDEuteSKTs
X-Received: by 2002:a17:903:32c5:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2bdb03a42c2mr3669485ad.4.1779125539725;
        Mon, 18 May 2026 10:32:19 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm159631115ad.14.2026.05.18.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:32:19 -0700 (PDT)
Date: Mon, 18 May 2026 17:32:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Matlack <dmatlack@google.com>,
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
Message-ID: <agtNGieEnxNPxXEe@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agsHFbI_FQEXiZAA@google.com>
 <agtHykqDImuLL6nU@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtHykqDImuLL6nU@google.com>

On Mon, May 18, 2026 at 05:20:40PM +0000, Samiullah Khawaja wrote:
> On Mon, May 18, 2026 at 12:33:25PM +0000, Pranjal Shrivastava wrote:
> > On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> > > On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
[snip]
> > > 
> > > > +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> > > > +{
> > > > +	struct iommu_flb_obj *obj;
> > > > +	struct iommu_flb_ser *ser;
> > > > +
> > > > +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> > > > +	if (!obj)
> > > > +		return -ENOMEM;
> > > 
> > > Should this be considered fatal for the same reason
> > > iommu_liveupdate_restore_array() is considered fatal? If anything in
> > > iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
> > > described in iommu_liveupdate_restore_array() is possible.
> > > 
> > 
> > Righ... Nice catch. I suppose we should BUG_ON() this because
> > luo_flb_file_finish_one [1] returns void. Thus, if we return -ENOMEM
> > here all we get is a WARN_ON without panic.
> 
> The error is propagated by get_flb_incoming(). The finish path has a
> WARN. But that is fine because finish won't be called as can_finish()
> will fail if FLB retrieve fails and restore cannot be done.
> 
> I will add a comment about this here.

Ack. I was looking at the finish path as it doesn't propagate the error.
but it won't be called ig. I assumed that there should be no good 
situation at boot that would cause -ENOMEM. 

In case we're not panicking for an -ENOMEM and letting the user decide,
adding a comment would be great.

Thanks,
Praan
