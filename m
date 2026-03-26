Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D03334374
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562716; cv=none; b=owQ0ezY//YblWfzDIiU8SyGACSRlO0wTUEuBGleD8yNecbARNZLFPNh/dOfsQRLr9792GrF2Ys/6l98jjDqxra+p17xrriTuio1A/KA5oLEEk19oU8pOvViOkT6Z4cQovYAIRR01zF6ZXTnYUVtJYIB64OG5P2bPCTy6st3InSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562716; c=relaxed/simple;
	bh=u684RyFUCmg8ujTk2N6tNVsPJBod1PTom9yEeQrkutU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcmjVh3WfeDIR+auzipUoEHNtWYRJfwdTjltkXnmS4+98iFs4bXQ1xFxmxEwNN2yZdU8p0Lvx+QOGQ/IqNRe/eaBGe1GmxjgTgq0H5jQVDbjQu1YZZaVHZPNbITp4mlt253E99ZD4j20fQWPxAYZ8JGLQWNy05k4aK6cPAJ5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hZ5E3D+/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hZ5E3D+/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506bcb23a78so12970551cf.3
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774562713; x=1775167513; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qt4Bouy7zFS2Ghg5Ne8+cryR/mFwEWJzdsa/JCE70NE=;
        b=hZ5E3D+/iD0LRssSS+Q37ZP3heBM2e2TdpXr+1XaU6Qqsqv3nNc0+t4ytEQIGDkL3T
         sC3hSahvYmEAiLhzH7FVxY5YZhHM8YLLe9SZSx9aCsH7JoCfBwDFPDifzJcfR6DuYIVr
         kdq3DFjlj5bIYvQ6HSa4W0ar/0Ap7StQbOKDj3pqcz8ziQEeecs8CWKchKSH9cxcAiy8
         jnkuh7YxH3Y8RrIo0yCGSaR4BKXEfICzC5FwfSFas/+2C+94b2a8ar9sL8mo/DUTnTdr
         qj0VplQ7gb1P/EAaVscYwGVhR2JhJbNESwcDsfmBNFY7hx9r6q3D0oUoIz1tZbyVUwbe
         l/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562713; x=1775167513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt4Bouy7zFS2Ghg5Ne8+cryR/mFwEWJzdsa/JCE70NE=;
        b=WXjbRnlSKyCdVPx9VwJGXkoC08Eewjrnhf1mdZrx5ZT23oHzDUq0LMK0mQnBSG6Y3U
         je4446p1g/zfh/NNmEq/uSwSOPFOuVQnfi/f38fchXzK47dYHa87Cto+TGU3l2kXaVtq
         bX8b8aa9G2KILl659XOkyHTXYN8A8it3KJ9dhnBOF80t0DqbqD9xPJYJ2ViZFThUbDYj
         mhk4FmDCFcMSOTfy+KZSX65neaPdSg6RIoQMbPEtyqQIK1DoWAzwJSw//JnuLKzLHu1H
         zCowJVSBylW4l3Aqk17yZWYodGaUO5bZkjFh39HnrxH4piqj31zlXBGpATzkPCrFi+65
         i47g==
X-Forwarded-Encrypted: i=1; AJvYcCXzlQuBAFUiKyiG/U5ySXnIFravKv1iO1TPRnwGJmxunOAZuUTEZg+Ou5hFy5jyM28QVPjzUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHfh0Zugw2R6znDswAK5rPVD3Ld1XtJbSg/skGQs9UmAv5B9gp
	xn6DYn797DV/HAOPTckNKJbEmcvYemqOjfXeup656Lss8Ovlva7jH3HnOo1cjh2oYVU=
X-Gm-Gg: ATEYQzxkeVvpiV3X91myBxeOKp2cWQOQj2/x7+O7ByUPGJdBoiPm1u+3G/iSJeblesa
	lyy1zv6O7qKsyYzF86bbI7k1359OeXi3HiHY9PluVRqYLLnTTj/oGOB4Ko5lvpX50Lrzf56gg/o
	uFPLrHqx415yY/R238J2INRaQ1pkix5zPubW6EPjmIcij2zsdf6h+2SJ9FtQ/wW03XZxpW7AFCR
	b4CDbi7mNLkC+Zi4mS2EtuY/i24NlZr0WCkIDbxD3+jOe7LsRXAxcX24pyspv+jTNvYeG98uZYl
	sVg+RjeQD6Y+ARvgR/EsY5Qtx6qVG5cGXgeUdkGFeOfgC5zau4Dva0ciigMjBHLHV2ayidISM44
	x2zVDsf1XVWkloZ9jLMhYuMZwk1rfDoC2nRNki6IkP0fwKGZlYgR+/YBec+X/LU8QV6NCzBgbXY
	DXz/VZ57i8pl0DeQtMFK+NVXR+kjHLkZAz7F8vNF526HguNsLy+axFJU26NKZ/9HbwqiccYg==
X-Received: by 2002:a05:622a:112:b0:509:348f:bc1a with SMTP id d75a77b69052e-50ba380a83cmr3922441cf.26.1774562713431;
        Thu, 26 Mar 2026 15:05:13 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd58d3756sm33752176d6.22.2026.03.26.15.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:05:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w5spE-0000000120i-0TvX;
	Thu, 26 Mar 2026 19:05:12 -0300
Date: Thu, 26 Mar 2026 19:05:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Josef Bacik <josef@toxicpanda.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260326220512.GA245789@ziepe.ca>
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
 <20260312134025.GJ1469476@ziepe.ca>
 <CAEzrpqeO68eg1dFr2fm8FNXSodJWSxT_9Gk0EHSK=hzRAQgJHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzrpqeO68eg1dFr2fm8FNXSodJWSxT_9Gk0EHSK=hzRAQgJHQ@mail.gmail.com>

On Sat, Mar 14, 2026 at 02:24:11PM -0400, Josef Bacik wrote:
> On Thu, Mar 12, 2026 at 9:40 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > > We are hitting the following soft lockup in production on v6.6 and
> > > v6.12, but the bug exists in all versions
> > >
> > > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
> > > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > > Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
> > > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > > Call Trace:
> > >  <TASK>
> > >  amd_iommu_attach_device+0x69/0x450
> > >  __iommu_device_set_domain+0x7b/0x190
> > >  __iommu_group_set_core_domain+0x61/0xd0
> > >  iommu_detatch_group+0x27/0x40
> > >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> > >  vfio_group_detach_container+0x59/0x160 [vfio]
> > >  vfio_group_fops_release+0x4d/0x90 [vfio]
> > >  __fput+0x95/0x2a0
> > >  task_work_run+0x93/0xc0
> > >  do_exit+0x321/0x950
> > >  do_group_exit+0x7f/0xa0
> > >  get_signal_0x77d/0x780
> > >  </TASK>
> > >
> > > This occurs because we're a VM and we're splitting up the size
> > > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
> >
> > This function doesn't exist in the upstream kernel anymore, and the
> > new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> > all, AFAIK.
> 
> This was based on linus/master as of March 4th, and we get here via
> amd_iommu_flush_tlb_all, which definitely still exists, so what
> specifically are you talking about? Thanks,

$ git grep amd_iommu_domain_flush_tlb_pde | wc -l
0

The entire page table logic was rewritten. The stuff that caused these
issues is gone and the new stuff doesn't appear to have this bug of
passing size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS.

If it does please explain it in terms of the new stuff without
referencing deleted functions.

I don't know how you get something like this into -stable.

Jason
