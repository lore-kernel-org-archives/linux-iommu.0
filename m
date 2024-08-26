Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B0187868
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680579; cv=none; b=c9o+obHvlDQN1bdC+rNlDBtLtrnM9aoFDwTGrbnPKBiOvsi6pzaoBOKGScuTAkpFVlkmjynfHl7CqpvILVu4EC1CGDnjJq1f6J2GoKLrt83vfdeMHHq53iQmb/WrzG0+jN3Vyy0eEiUC6wvp2oUoAS/C3elfjcFet2TjPv0pjts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680579; c=relaxed/simple;
	bh=4L+x6xlPiKN4o9DedL/WokkxAkOee0tvAtkAVanYorY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2eWpuqBdY78UgPEddVs3XUfN7uHZVc1N+SRiN3WHq4ctinUmXbY+NNEw1vGkYbn3epI4dbjl7owQhSYvJnELeB+LeVAuRV71D8fW2mHrzKjQcHdkXV3bFc7DXq54cSW2YF3KuWziuxLWErNK8NlNWbFgWYFcE32gKCowNivnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SjhWEYdd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SjhWEYdd"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c159150ff4so23471586d6.2
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724680576; x=1725285376; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYexcUtKg8OR6Vr90jcbIcOz6479CY7bxZJFZVVFbUA=;
        b=SjhWEYddhldgt1FX9cqikcqmuYOhAVf1Ujqbaw5TmW8usrh5hHK209rzUszNc4580C
         EuYhlarAeVV9GLLgtM+/Id+4ODPLicy0hGJbcgyQ4ReV9KyEaXLtQeRTT4exExpt0iKp
         twp5Lbh8iWhfLUI4t3AsDz/N8ISvxuZUbhiUwhgiRDwI9r/CuX/DwlCRjin5x85H/wsH
         zsJj/iKBVQCAro3KXLksTxiHycacz0IY+gE3OuS9WNF3ZXlPP1O8U9VScSgPDSGWVFig
         N1SKvsKO81/EqiG0Auamj66XJhX+w0Ozoq4uWf68mf/Gji4l8pdjOVmVmZezytsoh2R8
         v24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680576; x=1725285376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYexcUtKg8OR6Vr90jcbIcOz6479CY7bxZJFZVVFbUA=;
        b=BPAhDHwOQjtXp92GySn+JYVZiH9kUEHfLx1jfk8XXIaIdkAHuTAETn3yapQulgivWl
         O50BL8rPzjV44ZBk4cfGSUgLHq3ftYajvJTYzU8uKKUy2VBwppKs4HxeVYS1XoI1FRHg
         K3vQSMUBDh9LP0whxUCbwJbnjydxY0uM0wYpOAxM/PUvUgdXaparQ+NCunZZbYjL9ms/
         z9zBX9hfdWNWev3FRl3oeubgIPRuvkU3uBU/oKa6JUIoHQEQlmrO2VSAwEp1oD/SXNPY
         XNk42jU/yCxfI8voOs0pzf4H6APWSOtm2JsZB9g+zfX6Q2GVC07JBHjObKFwuca5hs3J
         lVRg==
X-Gm-Message-State: AOJu0YwaYJK6jqpyDk+NIOaFQcU4eWR6R1SuNwSFG40fcDW/45x6c5ju
	pHkAj1t8nZTA6zN1WumNtmXCGNomHU/uxaIFRFIJACsBv/esYLfOuxdx86rKD/o=
X-Google-Smtp-Source: AGHT+IG8YiMCi+/oBDehobCRdHqQNDOZmcnQq+cWN3ZxsnYWhT6xpzLu5hTeG5c0Jr3hZBVNPpOk+A==
X-Received: by 2002:a05:6214:5345:b0:6b5:4338:e029 with SMTP id 6a1803df08f44-6c16dc88e38mr118802076d6.28.1724680576566;
        Mon, 26 Aug 2024 06:56:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd0afsm46698676d6.120.2024.08.26.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:56:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1siaCd-00Bw6u-Hi;
	Mon, 26 Aug 2024 10:56:15 -0300
Date: Mon, 26 Aug 2024 10:56:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240826135615.GH3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <5fd22a04-ff5f-4763-a93f-268fefabaf7b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd22a04-ff5f-4763-a93f-268fefabaf7b@amd.com>

On Mon, Aug 26, 2024 at 02:06:27PM +0530, Vasant Hegde wrote:
> >> @Jason,
> >>   Notice that I have added __iommu_paging_domain_alloc_flags() so that
> >>   it can call iommu_domain_init() with appropriate domain type.
> > 
> > It is okay, but also the type could be fixed in
> > __iommu_group_alloc_default_domain() using something like:
> > 
> > 		ret->type |= req_type;
> 
> Sorry. I didn't get it. You mean domain->type? 

Sorry, yes. I mean the path that knows it is allocating for the DMA
API can or in the DMA API flags after allocation succeeds and we don't
have to muddle lower levels by passing them all around.

> >>   I think instead of having separate function it may be better to
> >>   enhance __iommu_domain_alloc() such that:
> >>     - Keep below changes from this patch
> >>       - iommu_domain_init()
> >>       - iommu_get_dma_cookie call inside iommu_setup_default_domain()
> >>     - modify __iommu_domain_alloc() to additional param (flags)
> >>     - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
> > 
> > My expectation was to basically remove iommu_domain_alloc() entirely
> > once Lu's work is merged.
> > 
> > Instead we'd have these direct APIs:
> >   iommu_domain_alloc_paging_flags()
> >   iommu_group_alloc_blocking_domain()
> >   iommu_group_alloc_identity_domain()
> 
> Sure (For AMD driver, we may have to tweak a bit to allocate_identity domain,
> but doable).

Why does it need to allocate_identity ?

> > I think the series looks OK. The naming of domain_alloc_user() is now
> > a little bit weird, it has now turned into
> > domain_alloc_paging_extended().
> 
> Ack. Do you want me to do it now -OR- May be wait until all changes settles down
> (above described group() related changes, this series, Baolu's series, etc)?

I think if we rename things it will clash with the smmu nesting
series, lets live with it for now.

Jason
