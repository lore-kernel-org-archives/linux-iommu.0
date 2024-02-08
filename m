Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CB80C05
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413523; cv=none; b=BfpiNy71Gj2NimiteqSYjQ+6BQRijN+vUg74U8Z2xOpsY/zZSvbSnIcDVErdMaFerWdt1y2EKMhPERVWZSXo2OTxW03fbAw0pVti0iERJjjHq4waAXUiApnzKJyiEj4vsXsQgU2c9QMaCoFgG8nTDIIeW0mONHz+3/I4Qa9H0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413523; c=relaxed/simple;
	bh=LTmmotqQaoHcOFApxldsf066T27L19TTOIxx92CLNt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpE93qMsnRDZBNN0hqiYK98MfPZdWBhg05Oh7BMGzoMezGkjgWo/+YuveMv4CNbgUp813Zzkxz2+cbFqtMSlkf1v0h9Rbs9364PhIaXqzRrjr/ErwHFLcRsPoluUCScz+7ORU1oKo7HST2vTGm51flIV9erf1RPHazcPavuNw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=apOYa5I0; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="apOYa5I0"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a8ee08c23so24848eaf.2
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 09:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707413520; x=1708018320; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MR0JRS40HKdom9tNZKMWCVsQ5yf03tHHzR9rGruIcg8=;
        b=apOYa5I0+zMbfEtPDi/DPqgHGl3uITbLXnTbW9U/NfhB4M8xn97BkQe0awedh7D6St
         RC7U0voRqaXR34SdB0liSahDkNV/DhEscBpcrCTm98jp4puX2hVuZgjPwztfvK0dOPIZ
         FvyZ/koLMjH4x4CBWvqq05KVIef3/2M/QF4sOZmDZsmPwNDUVRis1BxkQ0MH5VL6YXAt
         5I22E2+taxMZaFv3/DEQbcuEk684jDJyORs6/hTW1eeR2zIsbWk8UmJv3D3XOuT0T7TG
         GkLY27J/AFQihl8C5DcR9kVmgsYOBSPN3ZUxCvQaDc9l+eu7J2WomUxpLMNYe7AGTiYu
         qlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413520; x=1708018320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR0JRS40HKdom9tNZKMWCVsQ5yf03tHHzR9rGruIcg8=;
        b=g3+rhANjw3r7XKHxVlw09Zeoqcao9e4vTGdfp9wKEEjoeulOEcUDzpL+ulVWuwyJXg
         LqM78xQt8CKYPaeyBkgGAtQsL/cR5tNqoB6//4ci65M18D1JAQVtSAENnRwwKXGAEgxV
         gCPLBXmtuVcx3H++GuieSMHAPIPgn8RtU2pWOwXIL2ZzIBY2y+I+Z4aY0S//utju37cV
         Oigv/VBf7051n0JlzgWm+n9rGhi15AtBPu49Hm6YJv88zDTjCF33hImhy7dnPj7EBrUH
         VJNsKW1c+/2FgvQ+UKUG28MYmG9qXi7HZeHVLPLcU0EOWXut4MFWZQ56JxWfuqWtJipC
         /2Pw==
X-Gm-Message-State: AOJu0YwV94mfXt9cxy0OZB0N6pxY2dgINcK7vEMMvPBxcfcylSVWCIIE
	rBeKTi4TGTNqM/SyptidV6MdVgAlL2enoW1Cb2lXfK0jzRAWJ9S6JevxHJB9Rzc=
X-Google-Smtp-Source: AGHT+IHMnSf1/P89Rc3sFg2kuYGhuDSgp518IdZtyAl0Go1kwqtrGsjHSjYgM7oRtpr8lx4aaymRpw==
X-Received: by 2002:a4a:3005:0:b0:59a:e43f:f209 with SMTP id q5-20020a4a3005000000b0059ae43ff209mr232827oof.9.1707413519862;
        Thu, 08 Feb 2024 09:31:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdcySCc46xnt3EbuFI8PZjOCVW5IL5TdZO4PLMknRZxc3CF3lxZBBirQoTvAj7QSTkS9r96/qxtc9umcxfgFmbp0p9i506XU//Qmnve+gnLwA+kPSWKrKI+mde7rj40wkPvUyf+xL72LuehSScvC4n2SUup1RoEGNNJqth5duD/C4hE5L8ZtY=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id m14-20020a4a844e000000b0059ceb8bb157sm655041oog.20.2024.02.08.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:31:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY8Fi-00FHVx-9A;
	Thu, 08 Feb 2024 13:31:58 -0400
Date: Thu, 8 Feb 2024 13:31:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20240208173158.GV31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
 <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
 <20240206175824.GI31743@ziepe.ca>
 <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>

On Wed, Feb 07, 2024 at 02:28:08PM +0530, Vasant Hegde wrote:

> > You already know what is going to happen at the very start of attach,
> > you don't need to "enable it after" just do it right the first time
> > through.
> 
> First time we will not know whether device will actually use fault handler or
> not. All we will know is whether IOMMU and device is capable of PRI or not.

I don't understand this, you should know all of this before you get to
setting the DTE. What is missing?

> > The situation where attach fails and leaves the HW in an unknown state
> > is really hard to deal with - and without the reliable global blocked
> > domain the core code can't 100% rescue it either.
> 
> If attach fails we throw error message and skip updating DTE. I believe core
> layer understands that driver failed to attach device and puts device/group to
> its original domain. So things should work fine.

It is not just the DTE, the whole thing including changing PCIE config
space and so forth has to be kept correct.

> > This also means, broadly, you can't allow the DTE to evolve during the
> > operation of attach/detach as the in-between states may become
> > userspace visible and may be harmful in some way.
> 
> We make DTE changes in set_dte() function only (except dirty bit change that
> will be consolidated).

Sure, but set_dte doesn't take care to sequence the update.

> >>> security issue is solved. Especially if the more stuff is drifting
> >>> further from being correct. If you can keep the updates in set_dte
> >>> then maybe with some reluctance. But not like this with random touches
> >>> to the DTE all over the place.
> >>
> >> Currently all DTE update is happening inside set_dte only (dirty bit enable is
> >> an exception that may need to moved inside set_dte). This patch just invokes
> >> that set_dte and invalidates cache.
> > 
> > So then why all this strangeness?? Just set dev_data->ppr earlier in
> > attach and order the handler setup properly.
> > 
> > It should be really simple:
> > 
> >  // All protected by the core's group mutex
> > 
> >  if (domain->needs_pri)  {
> >      dev_data->ppr = true;
> >      if (!dev_data->num_pri_domains)
> 
> What is PRI domain?

Right now it is only a SVA domain, it is a domain that wishes to use
PRI. Quite soon we are going to expand this to PAGING domains as well.

> If I have to enable PRI in attach path then I don't need to track number of
> domain stuff. I can simply do something like
> 	if (pdom_is_sva_capable(pdom))
> 		// enable PRI in IOMMU
> 		// enable device PRI
> 
> and in detach path,
> 	if (PRI is enabled)
> 		// disable IOMMU/device PRI stuff

Each PASID can have PRI on or not, so you need to keep track of how
many PASIDs are using PRI at any moment and keep things in sync that
way.

If there are no PRI handlers installed then the PCI config space
should disable PRI and all the PRI bits flushed and disabled.

At some point you need to determine if any PASIDs have domains that
need PRI. A counter is a simple solution.

Jason
