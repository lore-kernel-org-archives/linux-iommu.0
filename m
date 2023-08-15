Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD315C9D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:57:05 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-76ad842d12fso359961685a.3
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692100624; x=1692705424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRvRRxLOqDPPdxllDaD73CkYrf90+ZgiJLYkKJQz6HI=;
        b=QJ1EWq1Mb65DdW0+kHqrDPZLDOBMyGQMTQflKivBoTWiqR2b1WFeiQmh1FsQ2mdSQL
         LdI91EiiqukrlKmJ3in4daVamLLjuRTPJxPqNcOOCqGQRxAARtojOxTigoGXHpqffZ6b
         Y7nEo564jOoeDtd4hBD+ZUhH/51iuFNFZqQD0VDCaLsNWeARq8bqhSvIGEUM8qRPyYIp
         2yfdnhUoXXkGlyEVN9PYqNkLgXRQkK0ICXwhNDOOc6qY73noQYC1o1SPdPExHKVI9+Ih
         aKCaQZZ2VTerc5TesKRWgke0w0BmQfN2mPmsgWqvVOJ5w9j8EoYc9JXIuW8iBzRpbg6j
         76wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100624; x=1692705424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRvRRxLOqDPPdxllDaD73CkYrf90+ZgiJLYkKJQz6HI=;
        b=UCTBHylTaeMTwVaZ2XtyQK5w0X+G7NxJ+w3ziDN5mDKQpVCy6u1jL/rWLWPeureqPO
         6/4F5zwUOlw+7di6QKSoiyvg20bn9p1sueCVQweU0qZm2+Q2Q5S051rkZyvys7Hb6bnZ
         ficqa6CgvYORkZuEPBOL8Nd6xQGFxEDqDavfZ4J0tOsiYlrQC4u+wiBW0+5DwuJSVpVY
         Dxcc+MnC0iAFX+kpd6bt9nvfrxkn2BHLbOiql7shMVmIOA7eulWd347Xx40IuFQBG/Yw
         Dn3wjUxbv1bjGsyodcaQ3cQ1w9VbxGLSwa1lcB3u+HBTz6p5lN8AGbtNYnNSDs2B3bDU
         XTFA==
X-Gm-Message-State: AOJu0YyLBIxHIr9E67B+XgQhe1S4fyFw2vMTM2wNaIqy8oOseYmH5hYw
	LL6qLtclz++hQ7D+1RPLPiIgIA==
X-Google-Smtp-Source: AGHT+IHMSz6UAAfNwE8KZWq1lZN3uaDML8wVTMbwaZQQmOJMGnlQQh2imeKv1y6SO0t+2WF4Zp0OSQ==
X-Received: by 2002:a05:620a:1a09:b0:768:10dc:e578 with SMTP id bk9-20020a05620a1a0900b0076810dce578mr16178324qkb.48.1692100624199;
        Tue, 15 Aug 2023 04:57:04 -0700 (PDT)
Received: from ziepe.ca ([24.114.95.117])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a130c00b00767cd2dbd82sm3687515qkj.15.2023.08.15.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 04:57:03 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3. with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVsRd-0000Al-02;
	Tue, 15 Aug 2023 08:42:41 -0300
Date: Tue, 15 Aug 2023 08:42:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching
 / detaching device
Message-ID: <ZNtksPXaWjsdSBxd@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com>
 <ZNJhw8RRvJZ+R61y@ziepe.ca>
 <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com>
 <ZNY1ligeAdFmILoT@ziepe.ca>
 <36a5f7ad-7d67-a818-2b0d-366722592887@amd.com>
 <ZNbJTiolSya/3/Nu@ziepe.ca>
 <57810db9-9a85-ca4e-0fc8-24dcaeb77fa3@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57810db9-9a85-ca4e-0fc8-24dcaeb77fa3@amd.com>

On Mon, Aug 14, 2023 at 10:33:08PM -0700, Suthikulpanit, Suravee wrote:
> Jason,
> 
> On 8/11/2023 4:50 PM, Jason Gunthorpe wrote:
> > On Fri, Aug 11, 2023 at 10:20:56PM +0530, Vasant Hegde wrote:
> > 
> > > Our hardware is capable to boot with either V1 or V2 page table. By default
> > > driver decides what is the best mode.
> > > But if user wants he has a flexibility to choose V1 vs V2 page table. In that
> > > mode we will adhere to user provided option and all devices will be put in that
> > > mode.
> > 
> > There is no valid reason for the user to override the kernel. If we do
> > this for AMD we have to do it for every single driver that supports
> > two formats. It makes no sense
> > 
> > Jason
> 
> The amd_iommu=pgtbl_v2 was first introduced to enable nested IOMMU
> translation w/ HW-vIOMMU support. This option is necessary for the guest
> kernel since we need guest kernel to use IOMMU v2 page table for DMA-API but
> the IOMMU driver is currently default to use pgtbl_v1 for DMA-API.
> Currently, there is no good way to auto detect this use case.

I will say it again - upstream kernel does not support nested IOMMU,
please stop adding junk to your driver to support out of tree patch
sets.

iommufd has an automatic solution to this problem.

> * There is an upcoming feature (e.g. TMPM :
> https://www.amd.com/system/files/TechDocs/58151_0.51-PUB.pdf), which
> requires devices to be setup w/ pgtbl_v1. However, the TMPM driver is loaded
> after devices are probed. Therefore, this would require Linux to boot with
> option amd_iommu=pgtbl_v1.

That is horrible, and it is even worse that you plan to support this
with a command line option. You need a proper fix.

> * IOMMU pgtbl_v1 and pgtbl_v2 are different from HW perspective, which could
> yield different performance depending on the workload and end-point devices.
> Therefore, the kernel option amd_iommu=pgtbl_v1|pgtbl_v2 adds flexibility
> and give users additional control if needed.

Maybe, but I'd want to see actual data on this. I'm skeptical.
 
> For SVA, we need to ensure that the iommu group is using pgtbl_v2 or in
> pass-through mode (no page table setup) prior to enabling SVA for the
> device. Currently, this would require the pgtbl_v2 option. However, we could
> consider default to using v2 table for an IOMMU group if it contains an
> PASID-capable device.

It cannot continue to require the command line option - we expect that
all the iommu drivers will support SVA without admin
intervention. This will likel have to happen via some kind of 'is
pasid possible' core call which will make the distinction based on the
composition of the group regarding pasid support of the devices in it.

Jason
