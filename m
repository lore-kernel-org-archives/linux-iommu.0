Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986DB18CBE1
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240760; cv=none; b=ALW/AJPQnXU1UCPZt7GWizoxz5wFB7+HmbZ+1HKrucwjuSMIw0oFkABQ+H6pup9jgm5Ir1p9NxWnH9KgCqupOvp1WAQ1lOxDMJMT7CM060XdO4gv19x4k3IU3bRDpl7bCFKP9fNJ8w9x1qvDrJOBqW3QGd/IPS6gkQAGTWhj2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240760; c=relaxed/simple;
	bh=7ZIeyeEBb0qTqoKYPRyQaMzNn6s9dqeEoUQZcEJwHEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXmgtC8Vc0xYf1S0bGpqfc/SAOfb5dPo3HTVuAvOODOChcYWzrhNiAKQwWkNl1338151PJ28miEDtrKz6itmABKxgHoCJeIYeY7mQJPNEBLRPojE0MHSseKO+OUffZ1VWMoGjo1n20ukIdR3DIg3Fi+WgWe6qSlGvrsC1/6PckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KOa1d2hh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KOa1d2hh"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6144314b3a.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759240758; x=1759845558; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjWUtHOtj5aDOxJQNu28PlCHm2FClKEoHbTsTRz97go=;
        b=KOa1d2hhlIxRVtHKr3TgxrFNFfOnLzSjzOqF4qcJd4PcVdutNT3x3KFlujpcVF0uj2
         +kV33MGQV8+oiLPArKGJIC+BS78MESfyouYiVilA1zogVP1oxSE8QNW5kf6PJG/lVzzJ
         xAZiVsqV3Mjw/6YqSkyfVoSGZcywBFhPaUiJDbX/bxRXrYVUJpk9j7wqH76jWNimMufk
         HJ4mwSEsRcrsiEU0+2LsPHAVgFAnf5bWjrZJ4fJhMuNgo9IaD0e8qkMIdHYy4ncgddgH
         +kl5pZTuudEvBGqJaKPB3z+vVyHtdqWfMZoupHF/QhO/do7jBK8XtdQwFzVVyTISKNew
         Mclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240758; x=1759845558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjWUtHOtj5aDOxJQNu28PlCHm2FClKEoHbTsTRz97go=;
        b=RrR6j+2yfw01iUKrOkKPqmh/LXCfvFVaQ9153nExfkTjS57K4WxP7612Plw8uGMa/6
         /+iCpl2rlBdsKxoFlASxEKU8UNC8pigEWF1kV+UJuj9CKpATWvWrKK8a5gYHuZCPgCjT
         ih1wHX/SSQbcftBwKwK5D2P09lgJ4dOqTretuR3CUEdVPXZPp8Gdg4nYnxpgpC5Vqz1o
         Y10k0erSMIPiO7SQFmma0n4FwZO/JJQs+LqAD+mo5u2VQ9eZrgg/ArHr7vL+8Vhz3nNt
         sCQNt2yZSPNuGfuA7WuuRp6C3DRKyNiWN7b3gf71EUrSbywtDrEPwdFT3tKRFM6R71BG
         gZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcavHqNI+DTSLuBWitaC7UMpb9hrVSC6DXB2lNCHUKML5h/Uya3bFLimcuZB4DMTRpKa7oDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlJoWu2n2Q1uQarXTJhGyqLOXv+xKlwOq/syKQvVcH2aa14pjh
	k6yhoYScrvtKXcrnuDff96IExTf3869PFtK2Haw97OvmciEX8TNAU4ThYtEAVZULhcQ=
X-Gm-Gg: ASbGnctuVPy8B+QDdMPncRDWrrpo1MmfOvjW8ZKWDc0SkqZlqQeuI7bKyXd7TOyFm1m
	f0YGbhJJJDs9p7ayYtovGr8Xzzix4FH4AMz2WtK2sblMgHCiHgXaNw8593QesKNXrUrsnlIlfjx
	QoyJR9A6jr2Pop8htjdR2Ew+O2m3gLeEF6bGD2Jln0ClploJpTmttcx1vsmGtRXcr7fnyXWklt+
	wtVIAI5vnZTPrPMl968BCRefr0Eiu2UB7auSK+HqO892EHrQGw7YhF1I5n7621ncZ8Txj5LuDPi
	svClRMH2/bLr/sVIrz/l/Nq6zdmS/mvwnZD2PXUBh2Y7tBXOCOGZcfHoXqFTHAAeuXb7f/Q4+vy
	XgZym5R8wdT6+lGiL/I0CrXl3G9ZTJos=
X-Google-Smtp-Source: AGHT+IEgBdYFmpFsQlLd3igFNhSM2bn5LlcXWT1cbyPcqW/u7eTqHoO1i9rVJ1owB/tgZ5CnEV8DHA==
X-Received: by 2002:a05:6a20:9f9b:b0:30f:7840:2c96 with SMTP id adf61e73a8af0-30f7840af75mr9397829637.47.1759240757873;
        Tue, 30 Sep 2025 06:59:17 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53b9615sm14076293a12.2.2025.09.30.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:59:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3asu-0000000CZmQ-0Zal;
	Tue, 30 Sep 2025 10:59:16 -0300
Date: Tue, 30 Sep 2025 10:59:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250930135916.GN2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:07:48AM -0400, Pasha Tatashin wrote:
> On Mon, Sep 29, 2025 at 12:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > +                          struct iommufd_lu *iommufd_lu)
> > > +{
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_ioas *ioas = NULL;
> > > +     struct iommufd_object *obj;
> > > +     unsigned long index;
> > > +     int rc;
> > > +
> > > +     /* Iterate each ioas. */
> > > +     xa_for_each(&ictx->objects, index, obj) {
> > > +             if (obj->type != IOMMUFD_OBJ_IOAS)
> > > +                     continue;
> >
> > Wrong locking
> >
> > > +
> > > +             ioas = (struct iommufd_ioas *)obj;
> > > +             mutex_lock(&ioas->mutex);
> > > +
> > > +             /*
> > > +              * TODO: Iterate over each device of this iommufd and only save
> > > +              * hwpt/domain if the device is persisted.
> > > +              */
> > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
> > > +                     if (!hwpt_paging->common.domain)
> > > +                             continue;
> >
> > I don't think this should be automatic. The user should directly
> > serialize/unserialize HWPTs by ID.
> 
> Why not?  Live Updated uAPI is handled through FDs, and both iommufd
> and vfiofd have to be preserved; I assume we can automatically
> determine the hwpt to be preserved through dependencies. Why would we
> delegate this to the user?

There are HWPTs outside the IOAS so it is inconsisent.

We are not going to reconstruct the IOAS.

The IDR ids of the HWPT may not be available on restore (we cannot
make this ABI), so without userspace expressly labeling them and
recovering the new IDR ids it doesn't work.

Finally we expect to discard the preserved HWPTs and replace them we
rebuilt ones at least as a first step. Userspace needs to sequence all
of this..

Jason
