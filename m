Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B01D559
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6Ds73cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698946531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMLk0yasYOMVEo/9IWsVVLaUX7HGzE9lFoE4mYsOa2g=;
	b=M6Ds73cmVqV5BGDIrskIs56H2NJSYPA7pKJiinbx4EitsLCKAFbuDjW4oanQje/n8z+y3R
	A7JdMVXcGzueocEXnDh2TG5P18VOpnN01BTjUptIv6rWnGoMf8FyR8FSSlSHCutfZ79U8X
	TntpDbAoi4940BJZn4wvQARdOnSXm9Y=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-W0tzEGB3Mu261_I-QA--_A-1; Thu, 02 Nov 2023 13:35:29 -0400
X-MC-Unique: W0tzEGB3Mu261_I-QA--_A-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9bc53c828so1583198fac.1
        for <iommu@lists.linux.dev>; Thu, 02 Nov 2023 10:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946529; x=1699551329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMLk0yasYOMVEo/9IWsVVLaUX7HGzE9lFoE4mYsOa2g=;
        b=pRI3cnRDnRCSiFrTwvSF0yEqJFyE+Y1fTAq49kiXpkA41xOdRIinnYOwyFbgWKKR8E
         0iVDn4yEOj2RflYf3YKmIQvbrpW1NEanIMseTx5i37AvjjjdUObLTDp7Et5yu73vporl
         TF1LqJwmrZIUJFx+VbmM8z6Ni6bWt+FVzdCUGwPrngLp2ru2N1thu8LlOnEaNDv+zcgs
         eDXaAdUSaj/Iv8DC9StnDm7mp84EIHnv1EcbKc5laegMio8J1cFH98ALPDTJ/cdUWKkx
         b7V6aYvRgPHOTkvoOs946kgUnWK+Q8jHAFJflpLQGS6ICl/v0tCHaq7zbTqGmSyHCqv8
         0OMg==
X-Gm-Message-State: AOJu0Yz0DA4uaH4kjgPqbuj/ioyM3TpDsPT+xUAqZIejmQ56SLP/REjA
	Z1WSdfodna+t8xWnm/7mT9aeCEvizwyB4aBjGdBBfaERIF3Rxpr3fNJNjd33NFsstX2k64VvoBN
	gXJPt8z9qSKkOc+Y=
X-Received: by 2002:a05:6870:c90c:b0:1ef:c42a:df0c with SMTP id hj12-20020a056870c90c00b001efc42adf0cmr16805343oab.43.1698946529108;
        Thu, 02 Nov 2023 10:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7FnCzdCAVEdOO4DFal9LQAmRo95HXaW2CAmlfk1299XHRYgTysZGA2KrWPLVWLSgNfV5shA==
X-Received: by 2002:a05:6870:c90c:b0:1ef:c42a:df0c with SMTP id hj12-20020a056870c90c00b001efc42adf0cmr16805323oab.43.1698946528846;
        Thu, 02 Nov 2023 10:35:28 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id lg15-20020a056214548f00b006562b70805bsm127739qvb.84.2023.11.02.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:35:28 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:35:26 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Janne Grunau <j@jannau.net>, 
	Joerg Roedel <jroedel@suse.de>, Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <ceoaqgffxlkj2imiggjxvctbsv6yq6e3ju5fvjzl3e3ax4zzft@4sm6fdwpksyo>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
 <20231101231727.GA5675@nvidia.com>
 <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
 <3gvk4gzznjsrqouilcqzq7f3lyhmumrm5l25xqk24uuf7426fr@qivhtqql7d2k>
 <9895fa9b-29f6-493f-b4c3-7e227144bd0b@kadam.mountain>
 <20231102121247.GA4488@nvidia.com>
 <2ae85ba5-5aa5-459a-ace8-b49d12f1ca07@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2ae85ba5-5aa5-459a-ace8-b49d12f1ca07@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2023 at 01:09:50PM +0000, Robin Murphy wrote:
> On 2023-11-02 12:12 pm, Jason Gunthorpe wrote:
> > On Thu, Nov 02, 2023 at 08:22:13AM +0300, Dan Carpenter wrote:
> > > On Wed, Nov 01, 2023 at 10:09:18PM -0700, Jerry Snitselaar wrote:
> > > > On Thu, Nov 02, 2023 at 07:10:57AM +0300, Dan Carpenter wrote:
> > > > > On Wed, Nov 01, 2023 at 08:17:27PM -0300, Jason Gunthorpe wrote:
> > > > > >          /* The driver gave no guidance on what type to use, try the default */
> > > > > >          dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
> > > > > > -       if (dom)
> > > > > > +       if (!IS_ERR(dom))
> > > > > >                  return dom;
> > > > > >          /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
> > > > > >          if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> > > > > > -               return ERR_PTR(-ENODEV);
> > > > > > +               return ERR_PTR(-EINVAL);
> > > > > >          dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
> > > > > > -       if (!dom)
> > > > > > +       if (IS_ERR(dom))
> > > > > >                  return dom;
> > > > > >          pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
> > > > > 
> > > > > Not related to your patch, but we should delete/move this warning as
> > > > > well.  It's on a success path.
> > > > > 
> > > > > regards,
> > > > > dan carpenter
> > > > > 
> > > > 
> > > > It seems worthwhile to note due to the performance implications, if
> > > > nothing else, of having to fall back to the dma domain type from the
> > > > two types mentioned in the comment. I'm not sure where would be a
> > > > better place since this is first spot where it knows that is going to
> > > > be the case.
> > > 
> > > Maybe it should be a pr_info() instead of a pr_warn()?  Maybe I'm just
> > > wrong.
> > 
> > TBH, I'm not entirely sure what it is for, it has been there a long
> > time.. I think it means that kernel config and command line options
> > are incompatible with this iommu driver
> 
> Yes, it's a failure path in the sense that the user has requested something
> (via config or command line) that the IOMMU driver cannot provide. Falling
> back to allocating something different is more "damage limitation" than
> "success".
> 
> > But at this moment there are very few drivers that don't support
> > IDENTITY (s390 notably, I suppose) and the DMA_FQ stuff is no longer
> > driver visible, so it probably never triggers..
> 
> Indeed if we get to the point where any platform/driver combination that
> would support IOMMU_DOMAIN_DMA also supports IOMMU_DOMAIN_IDENTITY anyway,
> then this fallback is no longer useful (and we could consequently also
> simplify some stuff further out), however as things stand I see at least
> apple-dart remaining a thorn in the side of that plan.
> 
> Thanks,
> Robin.

Btw Robin, I was able to verify the PCI SAC change works well in a
case recently.  Went from a drop off of 40Gbps to 1Gbps, to no
noticeable drop off.

Regards,
Jerry

