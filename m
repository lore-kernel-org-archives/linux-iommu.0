Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DC1860
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147170; cv=none; b=SoMNflkLZTBIr2/fn7bT75TJ8icDTpKlEo6+h2UQu4OMcBDQArFQO+6lNDMqtIGO4R3sVA7WTruW9U4e2eo8OkwAD88jT+X4+Ann2WbWDU9YszgH/j4IGmzOIsjIVO7qEXG+pGgxVsaoOv6poqq7DaEBzabrWrvityCn5jZdr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147170; c=relaxed/simple;
	bh=4lM60jPT/OefbEJ9bbxpuUQefXgv/u9YcirM0hZHG9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1KTHlY1zucryatk5lwHwKS8TwN3+NhdNyBwZSeFxJBNWzYsj0FHKPctGG3J7sVQqeM8O2TUzaj77LOpgqzKMd8NczmHhFY0r9Z251Y36c9gxXibetvgPN4ewDkQFmqqHbb0nMAbF5lAhRt+Uvgi6tcEqeC7AOliJWZdupzDgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e3afGgoF; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e3afGgoF"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-214410e969cso141702fac.0
        for <iommu@lists.linux.dev>; Wed, 24 Jan 2024 17:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706147167; x=1706751967; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDAX7XN2uAvHaqEk/CC4W9XWTCA8MJcNjm55+tBcST4=;
        b=e3afGgoFpkWP5ohNQ6pb+bGcdFLB5XJo2Maoe82SPuvq+cU6pjuINaDnpMZstnlL30
         7VvToHZFq1Fc8eRS7vGSZTVkaVoI/bf/VBq0/2ifOxT4DaKWjFvLat3pyoX072L2LX6W
         C191jIo5Au7DrYnUfeYehIC29Edogv8Vm7gTISfmtKt+mFNaNNPaOKaHUepBRyskcp4q
         R5Fwqyz4KjmQfEuUT3tHmg605sWyfxMFwWUVVWD3L4jKPs/LTddMicVeCxghAg4j8WO1
         DO7zDoXFbmoTcmaZQX3UfNBLMkIP0WK7VJ1CsFn+iE6bDj8SybJXZW77GVkcpRpfAFIO
         L59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706147167; x=1706751967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDAX7XN2uAvHaqEk/CC4W9XWTCA8MJcNjm55+tBcST4=;
        b=avbxCY05C672MgxTAoNYOJgfBvAOxQ8nlYM64UZocFxRJeerzG6Vw8u5pP1vL39Wes
         rDspyRHqxvGRm/UTgEFIi9XsKOnSINzNCZjlwVzljiWlRNdSACmlTSDLptDmwV5ZHbUR
         MbKXQbe/Z4KWb1d+bqxFkr8QW8hgsMgtDvQxAQEBIEvRRV5XfUwtpKR0EWGAbEpWIMFx
         3y0VLISG4utvVf8jmH8ZgNrtK+vVwRkz3mwM50YAC1qHdgB8a9ynuPD3aWccElCNfKBE
         n+zzIFEwznlg5oQqUeqk4JndBqtYQtsnJ929QYykBmvlwF8fVBKNTCjfsbgU6pd/jSPH
         11hQ==
X-Gm-Message-State: AOJu0YxAv26SMWe8mRTnuG+0bRcGoh/SDC0opF8FNjivtButSIo2+hAO
	1Gd9AnL2QtNu4GytOYqZA6nbRUDpcsgBJyAfOAQSOiS2BUjY2H/emuCAOg66gP4=
X-Google-Smtp-Source: AGHT+IFJR/lpspLYTpJcZBHTzNBhxl1RhE4S+uSURRqi58MnkqGyjJ+IcrPoAScVjGRc73XdNTCIQg==
X-Received: by 2002:a05:6870:430d:b0:210:da5d:67fe with SMTP id w13-20020a056870430d00b00210da5d67femr195535oah.42.1706147167256;
        Wed, 24 Jan 2024 17:46:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gc10-20020a056870678a00b002142a551914sm2459093oab.0.2024.01.24.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:46:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rSoof-008xfR-PC;
	Wed, 24 Jan 2024 21:46:05 -0400
Date: Wed, 24 Jan 2024 21:46:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20240125014605.GV50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-15-vasant.hegde@amd.com>
 <20240119195907.GN50608@ziepe.ca>
 <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>
 <20240122182607.GP50608@ziepe.ca>
 <c60ed34e-063a-b9fb-9255-365d3662f076@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60ed34e-063a-b9fb-9255-365d3662f076@amd.com>

On Tue, Jan 23, 2024 at 02:24:51PM +0530, Vasant Hegde wrote:

> domain_id_is_per_dev() decides how to allocate domain ID. Right now for V2 and
> pass through mode we allocate per-device-domain-ID as they can switch to SVA.

That makes no sense. You don't need a domain id for passthrough mode
unless you are also installing a gcr3 table. You don't need to install
a gcr3 table unless there is a PASID being attached too.

Pre-setting the domain ID to avoid setting it when the GCR3 is later
loaded is spaghetti logic.

> > All this logic should be shared between the pasid and rid attach
> > paths.>
> > The passthrough thing is only an issue of DTE construction.
> > 
> > If you build a DTE with a GCR3 table and RID=IDENTITY then you set
> > some bits, and that is it. Detect that case directly when you build
> > the DTE. It should have no effect on what domain ID is used to tag
> > translations retrived from a GCR3 table.
> 
> We build DTE as soon as we attach device to domain.
> 
> Now moving domain ID allocation to setup_gcr3_table complicates things.
>   - In attach_device() path we want to allocate domain ID but not GCR3 table
>     We can allocate GCR3 table, but if we don't use it its waste of memory.

It is a waste to allocate the domain id for identity too.

>   - In SVA enablement path we want to allocate GCR3 table
>     But by then domain ID should have been allocated. We don't want to allocate
> another domain_ID and change ID in SVA enablement path as our domain ID is not
> specific to GCR3.

Again, this seems to be a complication that is being created by the
DTE construction. You shouldn't need the caller to carefully sequence
what it is doing. The DTE programming should just install the correct
DTE for the *current state*.

A RID only identity/passthrough DTE does not have a GCR3 table and
does not need a unique domain ID.

> >> We need to handle passthrough as well. It doesn't make sense to allocate and
> >> keep GCR3 table when we are not going to use it.
> > 
> > Then don't, and my diff didn't - but check for the passthrough case
> > directly against the attached domain as identity.
> 
> We don't want to add condition check that depends on code path:
>   like attach_device : allocate domain ID but not GCR3
>   SVA path : Allocate GCR3 but not domain ID.

I'm not saying you should do that, I'm actively saying you should not
do that! All paths should be symmetric.

This matters, if you hope to implement the full driver functionality
the DTE construction must be clean, thare are too many cases
otherwise..

Jason
