Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0413258F
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 14:32:37 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-39a505b901dso1841696b6e.0
        for <iommu@lists.linux.dev>; Fri, 02 Jun 2023 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685716357; x=1688308357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NwA907vGnrNpaOFyWDRDxSy5v1vFxmBWhlUfMES2kw=;
        b=EauV+zfSnBg6r0ozgcM9FVLsm5gQCUXgiYyfYePz+nQ/L81vRnwKSIX3WIdM4BmfS2
         Y6Q0se655hmMB+A2zm5Ipm6ukstFJH/l3WWIKs6vgRvCR18zZL6inolAzhr0+/y2NZGd
         wLDgV6XS3o9gg12dJMji52ozOCvPoJ1oejgSpyUaETeJQtItQiIplDI7sgX65PF7k5G4
         6CGEq9XCateFJruI6vXJDAEmQOFsSgegr4aLlAXyQ/0o/BOZtRDufrYSj2nRrD0gd/Ip
         HkDVzLSDdWPCV3pG3MTk58ed9yYqeyz8j4tvKpboWViVkZaPjy84wwHmnWt93wpu6fLU
         6WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716357; x=1688308357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NwA907vGnrNpaOFyWDRDxSy5v1vFxmBWhlUfMES2kw=;
        b=FT99PmUCfnAW0nHr30IOGkX2Hps9+e6YNR3Nv0Y1IdIIgiia5pBMdv7OkUOIuJEhSC
         iE5Wqu5i1mIOXy5z4FkWIBsyXHAKBeK2/K29ZKp3H8vx1f9ikD/OE5aKXDOcE9zm7vSv
         qhJASJev1FNkyZCtYUz8WjX79ZMIWuvACSa3aQE5IysTOjAdj6s2KrtSx8x+QIfRBu+L
         38rNcMgsLUGDy54+955OuYig38zKpEfCXh2qj5AaQE7OMaH0twYvEL5Rr+NLDzMqglXr
         oZUGoEcFbNa0OPb0gWSK++vvUsCRptQYcvrS+h8PmIXqdWO6YMJFnpr3kWu+JLHCsBvW
         g87Q==
X-Gm-Message-State: AC+VfDzPUa0kpCwFLKVh1UqEl7rdhTSaOlvEI9qq9bKXQ7KeFhWkeSrI
	yvzdELzhrdIHYdsDQz7rKXDTKA==
X-Google-Smtp-Source: ACHHUZ4V0UzJXmOaS27pn0qGqFdFCh76Hfz2jr/a0CAePlRB6y4q8OwnVaD7Jbl2aB8HCK25aVZeqQ==
X-Received: by 2002:a54:408b:0:b0:39a:748f:4bbd with SMTP id i11-20020a54408b000000b0039a748f4bbdmr132133oii.15.1685716356815;
        Fri, 02 Jun 2023 07:32:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id j18-20020a0ceb12000000b0061b5dbf1994sm839858qvp.146.2023.06.02.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:32:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1q55pT-001vhW-EA;
	Fri, 02 Jun 2023 11:32:35 -0300
Date: Fri, 2 Jun 2023 11:32:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Message-ID: <ZHn9g6QoMUo3ZPog@ziepe.ca>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
 <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>

On Wed, May 31, 2023 at 11:26:55AM +0800, Baolu Lu wrote:
> On 5/30/23 5:25 PM, Yanfei Xu wrote:
> > Checking NULL value of 'table' variable deserves a BUG_ON as the
> > following code will trigger a crash by dereferencing the NULL
> > 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
> > plus NULL pointer dereferencing can simplify the crash log.
> > 
> > Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index e98f1b122b49..8aa3bfdb7f95 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
> >   	if (sm_supported(iommu)) {
> >   		unsigned long pds;
> > -		WARN_ON(!table);
> > +		BUG_ON(!table);
> 
> BUG_ON() is not recommended. Perhaps,
> 
> 		if (!table)
> 			-ENODEV;
> 
> ?

If it is not something you think needs active debugging then just let
it crash on the NULL pointer deref. You get a nice backtrace from that
already.

The additional value of the WARN is it gives you a line number, a
prettier print and it might recover more cleanly (or not, it might
just crash somewhere else).

Jason
