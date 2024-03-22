Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C570604D4
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127177; cv=none; b=IZcVYdEp7Got/M+DoOriCpRMnAdZbraDgyZBKx2oXVv/Ax4Fk5UzchkjNAR9G3OwRMBFQEcKLcRUi85S62hJA+s2d84WpBHn4kngutIt5ERGs1FS/Buqr9jR7J63QmLby5wt37S9UuxB8ZOeOd1A3anIxER7HTFzd5gh8lXFkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127177; c=relaxed/simple;
	bh=jT967HD0NkVb4sBMYdepySf5iZRznTV4xbYQBqhu4p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T721VD3AP44UmkgLcHNApKuR3hvhd7WjXbsqa0h2d+V6bcPq2Qb31liI3c47XUI73GRDZw+yVQ25Zh9rwJavzaT7xo3hdVbzvEbCvlIfserQQznFYsDtqYzRcXg7hNHClDYJ0nWdocNduvZHlXa+NwztMMFPcBL4sIwYx7/+s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IdDWWNFn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IdDWWNFn"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789db18e24eso155511485a.1
        for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127174; x=1711731974; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIw9kOrgrH/Oi2+Nn2/myUDrH5PEiTKiNi9APpbGWJQ=;
        b=IdDWWNFn2YFB5Mbfn60ahc6yXQyt1pDsRCNjzE748fral84/Wy2h3e7tIxJxDnUpXi
         WY7LwjRYM4zI6g31jcoY6F02sRTfWOwKc+ET2loUHAPJs35xnM9mKxh7EuUdUHz3lw54
         qiQq8+OTX8SRDxKnihNB4QoamaRPB1qV5ZTe5rQ/XOjlP4Y2WpU1ZuT8SO8SASKEQFks
         2r5Ei3Foa2AniGecDEaV4i0N2FiWMRxY2AI+jgMlqOmbIJ0NOl5GLqbq7P2gpe3YEYHp
         HGFyhz+5G845oTU6DnIyjbxJ1Vxb0Qc6uZkY7QzcA0MK52naNZgVg+58KMHiAtGlwLnO
         JpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127174; x=1711731974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIw9kOrgrH/Oi2+Nn2/myUDrH5PEiTKiNi9APpbGWJQ=;
        b=KML7kvxXdAxUDZAEJEogvYd4T6m0giy8cmOBTz4mHKgezv+SZcUXMHDCGzdk+5nlmV
         Pn8VL1m2qiICUWsKFByuenCWDSRm1r3YB7vU3jgwJ1Qbx9sLP0u5PbLA1TEKk/mpvi/p
         hCVnRrgcCdX5tKTav2/ekpJSQAEAWYNgqVkgnIuL5UvUpdD84fIywOJz9dKoc7Ko1EcI
         1d5PmRaUArtY4z9BOErsJ9RLAQmJpE56gfJ7gfbHsuq4ozepsr2Q5Gy/RNTg4lJfbzGq
         QOhgnVQnssy6sc/XdBT9m4+Oefv1YEyb3xsbP/hL+Oc0t51RR8lRQsYVnfZ342ImHoB8
         dwVg==
X-Forwarded-Encrypted: i=1; AJvYcCXYEmH6P0OVw+dqsGq8n65Klmr+k4xazV6F5CdM9WqapG1sBCgTMThzVd3UoVaPeIRsdlJiAMju2KSt5ttxaJ1fBfPri6s=
X-Gm-Message-State: AOJu0YwE9SnQjbCSZQCnxmYT7aCLL4u04u4bDp65GrW/x/db/JYZLEAA
	oxpCRv5Ic7cblnaWLCPtHk29fGUdoU5feb/fM5U/uLtsRpTG2aBLF/jAHtr9boM=
X-Google-Smtp-Source: AGHT+IEHFGKv/VWM3Yg4smu9N1G/2nFTpEK73dYxyEMKGfCzZHq73AEibapXcw3+Qlp7ej5p7M2doQ==
X-Received: by 2002:a05:620a:27c7:b0:789:f0ac:1b4b with SMTP id i7-20020a05620a27c700b00789f0ac1b4bmr34471qkp.58.1711127174318;
        Fri, 22 Mar 2024 10:06:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g12-20020a37e20c000000b007882fe32acasm926378qki.3.2024.03.22.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:06:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniLN-00CSJq-BV;
	Fri, 22 Mar 2024 14:06:13 -0300
Date: Fri, 22 Mar 2024 14:06:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240322170613.GI66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <20240308190539.GY9225@ziepe.ca>
 <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>

On Fri, Mar 15, 2024 at 09:16:43AM +0800, Baolu Lu wrote:
> On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
> > 
> > > @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
> > >    * @__reserved: Must be 0
> > >    * @data_type: One of enum iommu_hwpt_data_type
> > >    * @data_len: Length of the type specific data
> > > + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> > > + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> > >    * @data_uptr: User pointer to the type specific data
> > >    *
> > >    * Explicitly allocate a hardware page table object. This is the same object
> > > @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
> > >   	__u32 __reserved;
> > >   	__u32 data_type;
> > >   	__u32 data_len;
> > > +	__u32 fault_id;
> > >   	__aligned_u64 data_uptr;
> > >   };
> > 
> > ?? We can't add fault_id in the middle of the struct??
> 
> Yes. I should add the new field at the end.
> 
> By the way, with a __u32 added, this data structure is not 64-byte-
> aligned anymore. Do we need to add another unused u32 entry, or just let
> the compiler handle it?

Yes, add a reserved u32 to ensure the structs is always without
implicit padding.

> > 
> > > +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > > +		struct iommufd_fault *fault;
> > > +
> > > +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> > > +		if (IS_ERR(fault)) {
> > > +			rc = PTR_ERR(fault);
> > > +			goto out_hwpt;
> > > +		}
> > > +		hwpt->fault = fault;
> > > +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > > +		hwpt->domain->fault_data = hwpt;
> > > +		hwpt->fault_capable = true;
> > 
> > I wonder if there should be an iommu API to make a domain fault
> > capable?
> 
> The iommu core identifies a fault-capable domain by checking its
> domain->iopf_handler. Anyway, what's the difference between a fault or
> non-fault capable domain from iommu core's point of view?

From the core? Nothing. I'm just wondering from an API perspective if
we should have a little inline to indicate it.

Jason
