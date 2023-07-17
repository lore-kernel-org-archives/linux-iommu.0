Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF869AD46
	for <iommu@lists.linux.dev>; Mon, 17 Jul 2023 12:23:45 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso2894539b3a.2
        for <iommu@lists.linux.dev>; Mon, 17 Jul 2023 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689596625; x=1692188625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoQfk5mLbjS2qrgvVaEMuSsDkviwjZL3AdX+fjITims=;
        b=EfbshxCRB1hM4WCcqCzRPPKc4zfyIwjYERZs09xwwI1TIYe6+NnmNL8USV2EZksioo
         EM9yJ37OyGZtPxIp7hSCjbx9wtWZaWtrOTzmRqAOE7U2g55LKMTq6WbNPDkYQIxOTUt5
         Hyviy6Pc3cdLhneqLtNK3hTDRIszCFkHUQfmESaNWiMC5ZlyBjzKhILY6lp3eVlolhBj
         ablqVWYoSk460Gf2XpyjS1acT1ixGOnobtfodQGh9IOFPreXiWc18cpnGuz4GXfTA65l
         vneiitSh8DtXQ2WI0niVrN2VoV65E7b+Nz74QQhSPFZ3JPvBlFgeeBYwXc3RktpEp/hM
         FVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596625; x=1692188625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoQfk5mLbjS2qrgvVaEMuSsDkviwjZL3AdX+fjITims=;
        b=MrYWkzlnak5tVki6O+hSRzr/J46zh3uMPV88MELQZr7e/yd1iZf+rYjK+/V1agYqta
         7PlqC3NRBumpr1A+DA7Ss3kukpuTLYPxQps1CnxrRuPEoyt3mtdf7D78BoXfhJ5RHHdP
         RHT5qkVyTdzZLTFV3AB3gauEUCcqBwtCbQD6Ei6jJKG84I7NVAxLOfeMuARLdcSPzdXW
         frVIABSm02pAGV/ju6L/tEW9p9bchk91V+M10Z/aKmsCcoIvw0pr90jT/Sw5UxoQKrps
         6qvP4tVeWLLdwtECWfsljprt5zDOKrk3CK0giBaIsL5Wr/g5+KN4gw5zpiVY9/4YQSbU
         7edQ==
X-Gm-Message-State: ABy/qLZ4fr2sANv2Kc0BKpl4wdUueQJwlCteMHKohfN0mQnHeBH6iC1W
	mNJttfRKu6K5Y1bXaM4QLNk88g==
X-Google-Smtp-Source: APBJJlHjuJJUxUf9kzNEFy7QRnZTf+EOCsAS+eRglkMdtl8LHRz4cgbK/aFw3qUeYTR4piPvmxdvDg==
X-Received: by 2002:a05:6a20:510:b0:133:d15c:b661 with SMTP id 16-20020a056a20051000b00133d15cb661mr7811361pzp.60.1689596624894;
        Mon, 17 Jul 2023 05:23:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709029a8100b001b06c106844sm12597845plp.151.2023.07.17.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:23:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qLNGQ-001srZ-Af;
	Mon, 17 Jul 2023 09:23:42 -0300
Date: Mon, 17 Jul 2023 09:23:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org
Subject: Re: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain
 flags
Message-ID: <ZLUyzrmRKhz4wwQ0@ziepe.ca>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-12-vasant.hegde@amd.com>
 <ZLGFH6qERiRbD6cd@ziepe.ca>
 <db7fe0f7-77d9-f898-0503-d6da58cf25c6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7fe0f7-77d9-f898-0503-d6da58cf25c6@amd.com>

On Sun, Jul 16, 2023 at 08:22:37PM -0500, Suthikulpanit, Suravee wrote:
> Jason,
> 
> On 7/14/2023 12:25 PM, Jason Gunthorpe wrote:
> > On Wed, Jul 12, 2023 at 02:15:06PM +0000, Vasant Hegde wrote:
> > > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > 
> > > With IOMMU v1 and v2 page tables per domain, and the v2 table can
> > > be used in various modes, keeping track of how a particular domain
> > > is configured becoming cumbersome.
> > > 
> > > Enhance protection_domain.flags to keep track of how a domain is
> > > configured. Also Remove unused flags, and rename them accordingly.
> > > 
> > > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> > > Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> > > ---
> > >   drivers/iommu/amd/amd_iommu_types.h | 14 +++++---------
> > >   drivers/iommu/amd/io_pgtable_v2.c   |  2 +-
> > >   drivers/iommu/amd/iommu.c           | 21 ++++++++++++---------
> > >   3 files changed, 18 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> > > index 346c32343417..907af6e41ae9 100644
> > > --- a/drivers/iommu/amd/amd_iommu_types.h
> > > +++ b/drivers/iommu/amd/amd_iommu_types.h
> > > @@ -443,13 +443,11 @@
> > >   #define MAX_DOMAIN_ID 65536
> > >   /* Protection domain flags */
> > > -#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
> > > -#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
> > > -					      domain for an IOMMU */
> > > -#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
> > > -					      translation */
> > > -#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
> > > -#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
> > 
> > > +#define PD_FLAG_V1DMA		BIT(1) /* DMA-API mode w/ v1 page table */
> > > +#define PD_FLAG_V2DMA		BIT(2) /* DMA-API mode w/ v2 page table */
> > 
> > "DMA-API" should not be part of the driver vocabulary. Does this have
> > anything to do with DMA-API?
> > 
> > Only "paging" domains should have IO page tables and an IO page table
> > type.
> > 
> > Maybe this is just misnamed?
> 
> These flags are for struct protection_domain in AMD IOMMU driver, and not
> for the struct iommu_domain.

I understand that

> PD_FLAG_V[1|2]DMA flags are used to signify that the domain is using v1 or
> v2 page table to implement IOMMU_DOMAIN_DMA (which has __IOMMU_DOMAIN_PAGING
> | __IOMMU_DOMAIN_DMA_API).

Again, no, drivers should have no sensitivity to
__IOMMU_DOMAIN_DMA_API, we are trying to get rid of this. Please don't
add more to the driver.

> > Also, shouldn't it be an enum not flags?
> 
> We use flags instead of enum because we exepect to have combination of the
> flags. For example
> * IOMMU_DOMAIN_DMA + amd_iommu=pgtbl_v1 = (PD_FLAG_V1DMA)
> * IOMMU_DOMAIN_DMA + amd_iommu=pgtbl_v2 = (PD_FLAG_V2DMA | PD_FLAG_GIOV)
> * IOMMU_DOMAIN_SVA = (PD_FLAG_SVA | PD_FLAG_GCR3)
> * Domain for v2API = (PD_FLAG_V2API | PD_FLAG_GCR3)

You shouldn't have these distinctions. There should only be one enum
that specifies that format the IOPTEs are, and the rest is implied.

GCR3 is the "PASID table" right? it should not be part of the
iommu_domain struct either, SMMUv3 is busy undoing this mistake in
their design right now.

> It helps keeping track of how the IOMMU driver needs to setup DTEs for
> device in a particular domain.

Yes, I understand what it is for. It is important that the right data
be stored in the right places or you will have to redo it all. If it
does not directly related to describing the format of the IOPTEs then
it has no buisness being in the iommu_domain struct or it's driver
varients like protection_domain. It belongs someplace else.

> > > +#define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */
> > 
> > This really shouldn't be a iommu_domain flag, this should be computed
> > based on what domains are attached where
> > 
> > Eg this seems like it should be triggered by attaching identity to the
> > RID with PASID enabled or something like that.
> > 
> > Why do you need to set it for the legacy GPU path?
> 
> The PD_FLAG_GIOV is necessary for when we setup the v2 page table for
> devices, which cannot support PASID. With the DTE[GIOV] bit set, IOMMU
> hardware would treat the request from these devices as if it use PASID 0.

I understand that, but you are supposed to deduce this from having a
RID bound page table installed into a PASID 0 slot but other logic, it
is very much not part of the domain itself.

(as we all the other variations of this flag when you set an IDENTITY
domain on the RID while having PASID operating)

Jason
