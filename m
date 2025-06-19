Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AF221574
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326565; cv=none; b=Vs5jTRrLMxoiIFRj4SJhdO0BB2VB3X8fMmmB1OyN98zmGRnJsxjMvP8Q7PzgiJV1zGCg9A/5SR1WOZVO5tPgjpol8gUCCfAq9ZbZVdHACoJsqmjFCNZkynIvuXfNSKRJw0p1cDdBqR20LH/0z0sgZIg73oQp0GjDzbrecndCV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326565; c=relaxed/simple;
	bh=3LkyeQl0t9LM+cj52xpO+Ax9lI0k6dCYkCdTOXS+hWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7C2OBZA+k9Lar2EslzUEgHbi402qmXXwyAVs7WYC5MbF23VrsrQZCqT/vWfHpDWrFGHDCwgjN6xK76PHT/qLNSMyqKT1IzW0L49Hsw9BuBsf8mP5ek48R/+utuHysElID6Sk629YFNxixV92dSWFH+n7pQZt+FspZxzzwpH0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGgcvCRf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGgcvCRf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2348ac8e0b4so111115ad.1
        for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750326562; x=1750931362; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=17oxjeeFsHFeG65L770MNpFPAUdse/NuAwqFBcFBF84=;
        b=JGgcvCRfTC4wEkUcctXxlsxIBZXG1zlYPKMy9JqFi7UTwp5+0Hkvu7cIlGZ0UCoelX
         TChjqncu94js1E0fqy+cJiOT82plxZ7uf0zUX5N0OFwCoZDuktmaZ0dre0tkgiNV6Hgp
         PIDyFJzxL6yC3GAQnvhd6dK32EkQjlJ0tcwZ6qAqqtdzgVxiS9ps6tGLlx4AjCZMEZtu
         yXOGXG63Yy1wQmSI6C8qyL/TdPYxvO1AXqfmdw3Iopl61+3fJdYgvBNxtcegLzLnWBMh
         Wvx7e2tNgqZ5ctptECKKYizsguV2RFO7EMKYviVXXIBt/mxsTpdmZZnmWelsSK2R+6Ii
         oqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750326562; x=1750931362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17oxjeeFsHFeG65L770MNpFPAUdse/NuAwqFBcFBF84=;
        b=izWX+T6ayIur02eIFzp+oQ29X9bbqhyU1tdoVbbAuevfSMI5UNwbXLx2Yb0pqf1dBK
         KSOBWGNpsv0r8nc1X+wtqjAnL6AjcnmenXung9uFSB6hF5SzNdF7+gepfHbDlW8SYT33
         3drbHbgoj6LpL5uzJlykvRhdFmpqDSi6HdRDalMI1NbLU3ruAlHrQWT0hLOJbYPcNxS0
         J+rpwBwpWqIG2RiYqKtUUeSNnIkNPQpXpI+CAHpxzNX8v+hZRooVElXa19k/CqzUUzoK
         egPvbEgSPbIZvOeDH0RDS+ii7xKpIoha8EcUl/IqEtMwMfrD55h5VokfJs/ndKl5Pz8v
         A1QA==
X-Forwarded-Encrypted: i=1; AJvYcCWj6hulEcNGlZoCbSWEw4Fv4igGCkvvm79ctY/4J9tpZGlPjfGR670/ab9HQ3yXpfkT9X/Z0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTUTC9XYbBgopcn31fI+KAhSq+oCRDvs/dT7JV7KV3SOqIBWmD
	2ePcjY7xn+KsOomQlqK/qJmE0QZMiOmwqJDSqhJhrvjWMfnmK5LZ0MNM6+boFropxQ==
X-Gm-Gg: ASbGncsnWHIovG2Yf0EbgG6gOdJgyfNclD/ctgNpibVemd/kXmrwlxBmJ5ON/sTikef
	ZN/Ls404GJRLFxZpBavipVJyi33ZflFLmuZ21OAwwE+REg1dW3sDHNzjl36W2TpxLCUkUPJO0EB
	AgLeJCB1cePAPzn7pZf9iMcNf092/yLdrVvBjiOv6igKXtBTMaav16i5tjtKeOkb0PnRGWAUmGG
	WtrkPR2G0i9ewyUmbU4IYiJUZf3D65r4MlAK1oAXB/HkI9bVdqKSp2DNE++vl7pGZwKfWwMmGAq
	BY+4t06NB6o5mw+jVBxOmj8DfT0pIG3W3jkYAgqB7fHwr7/jEzTLl/G3wgTm8TERbRgcBwc5Nt5
	La4xPuk46/cLW7qsHQoFp
X-Google-Smtp-Source: AGHT+IEuCYASVN8j1eZMJIcAvoBEAqstpKSSgGIYZ2iYQuSQhTyrI+a8+/330LWZVAAW9AYW4syqlA==
X-Received: by 2002:a17:902:fc46:b0:234:bcd0:3d6f with SMTP id d9443c01a7336-237cdfe9619mr1746815ad.1.1750326562236;
        Thu, 19 Jun 2025 02:49:22 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb04a6sm116435595ad.178.2025.06.19.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:49:21 -0700 (PDT)
Date: Thu, 19 Jun 2025 09:49:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 07/25] iommufd/access: Add internal APIs for HW queue
 to use
Message-ID: <aFPdFnKvus57cGOU@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <64145b184a0fa7c9b60532c9b475a51625edb77c.1749884998.git.nicolinc@nvidia.com>
 <20250616133719.GC1174925@nvidia.com>
 <aFDSNYOTToFSbFA2@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDSNYOTToFSbFA2@nvidia.com>

On Mon, Jun 16, 2025 at 07:25:57PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 10:37:19AM -0300, Jason Gunthorpe wrote:
> > On Sat, Jun 14, 2025 at 12:14:32AM -0700, Nicolin Chen wrote:
> > > Now, access->ops can be NULL, to support an internal use case for the new
> > > HW queue object. Since an access object in this case will be allocated by
> > > an inernal iommufd object, the refcount on the ictx should be skipped, so
> > > as not to deadlock the release of the ictx as it would otherwise wait for
> > > the release of the access first during the release of the internal object
> > > that could wait for the release of ictx:
> > >     ictx --releases--> hw_queue --releases--> access
> > >       ^                                         |
> > >       |_________________releases________________v
> > > 
> > > Add a set of lightweight internal APIs to unlink access and ictx:
> > >     ictx --releases--> hw_queue --releases--> access
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/iommufd_private.h |  8 ++++
> > >  drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
> > >  2 files changed, 58 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > > index 4a375a8c9216..468717d5e5bc 100644
> > > --- a/drivers/iommu/iommufd/iommufd_private.h
> > > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > > @@ -484,6 +484,14 @@ void iopt_remove_access(struct io_pagetable *iopt,
> > >  			struct iommufd_access *access, u32 iopt_access_list_id);
> > >  void iommufd_access_destroy_object(struct iommufd_object *obj);
> > >  
> > > +/* iommufd_access for internal use */
> > > +struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx);
> > > +#define iommufd_access_destroy_internal(ictx, access) \
> > > +	iommufd_object_destroy_user(ictx, &(access)->obj)
> > 
> > Use a static inline please
> > 
> > > +int iommufd_access_attach_internal(struct iommufd_access *access,
> > > +				   struct iommufd_ioas *ioas);
> > > +#define iommufd_access_detach_internal(access) iommufd_access_detach(access)
> > 
> > 
> > >  struct iommufd_eventq {
> > >  	struct iommufd_object obj;
> > >  	struct iommufd_ctx *ictx;
> > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > index 9293722b9cff..ad33f1e41a24 100644
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
> > >  	if (access->ioas)
> > >  		WARN_ON(iommufd_access_change_ioas(access, NULL));
> > >  	mutex_unlock(&access->ioas_lock);
> > > -	iommufd_ctx_put(access->ictx);
> > > +	if (access->ops)
> > > +		iommufd_ctx_put(access->ictx);
> > 
> > I was hoping we could null the ictx to signal internal? That didn't
> > work out?
> 
> access->ictx should be NULL for internal. It should have been:
> +	if (access->ictx)
> +		iommufd_ctx_put(access->ictx);
> 

Ohh sorry, just saw this. +1, I too believe this is better than relying
on access->ops being NULL.

> > I would at least add a comment here this is filtering internal that
> > doesn't have ictx. Maybe a little inline 'iommufd_access_is_internal'
> > is appropriate. We'll be sad down the road if we need ops for
> > internal.
> 
> Yea, an inline will be cleaner. Will add that.
> 

Ack.

Thanks,
Praan
