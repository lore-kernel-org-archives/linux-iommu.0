Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4683A8742
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346055; cv=none; b=uURrDRC1TxAr9FEie2+RSuIlCFKQ5VsGp7DDAlIhjRrHiRyLN4BJbaHgSTO24XiioM1pRTXYkBB3YnZG/Y7QRCvw7Odp0lNlEVPWaouVak6kgrhqx0VEiUwkAnelm1d2qGZAajbuxG6BPilA4VWBE54kHypyzGZO+Zcnn0/I9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346055; c=relaxed/simple;
	bh=WPZ0FMMKphUFt/o8yexGkUjGZtyGZuEFdu0coALbpL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/ur+YRZj0DwKGsdNDIJLcJGQUdK9eqIJkO3/NkFoc8cNOU+JImtjDL21l5oanBbzoBa2B5jPSt4zn+Esv8zJAgZwZ9qcY8pPUYtNH1JTrqcxdypebjKhgAmonxXtO5z0uSOa2EEntJQVfVvdm7atnABrxEohPc4XpaPo7lcOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JnR6S8U8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JnR6S8U8"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8dbbc6c16b2so404700485a.0
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778346053; x=1778950853; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRop8m7XaImUSxbpG/XbxbRCDh4G22WGRyOV4N0sJrU=;
        b=JnR6S8U8vadc/4s3/pUs6PexFp3PRNZTLOXxM5/2lDvMam4WnRkqz6QcataH7fuLzo
         DVJmRPF7pbJI9OsgkhCWCwfQrMaOF/ZSr9Hsguwo6WHFcYhkztfCVU7YJkvRPJUSkekw
         kPv1e1zjRtrjXtdzzwp2FIDDrwFqx4YyTFlNV0P5RPrMwSU551oa82UEHykWhT/hy9+k
         MdB/rYXi4m/7GSFelqJ4rhwq2Sa8WZqV07GvjveJlxRL6jlx8eh9ldgumMQL2c8XSgSW
         0QP0ZGz13XQgWBJVh6dxvF5feUMFQQP0OZ1U97IRbhEtjjr/JyUyGsJPxn4kDLR8qQYm
         oFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346053; x=1778950853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRop8m7XaImUSxbpG/XbxbRCDh4G22WGRyOV4N0sJrU=;
        b=IKRCX/0QkUQ27icQG3P5i9vexr1ec0aWuqCtqjBHmjEEJ0AMS99vDoJDgJG1bd59zV
         8bZu2GARlbiUnyAsGXCjaOah2KdNc/jgZfJbi3C2Kvo7QNDTYJIZMjHFKZ+zJeYk8OUx
         DIw6Hk6STeEVSPVnAAlrmxWFLW+VH/DuammhUiION5mgBQTXWPzin8a7e0s0C+5l8P8z
         WmWNkWYHuBIONr/QCv/HHDyXVzBRjXCtvTnJn7pj2/ELAe3Rds2tmJiqAj3SuRCfPFIp
         xJnqgqeVcR569vNsS2sMqizlQn7wgKZx9gKKZlmYYpgILR1dv2zd9eMWWlH0yOSi84bT
         FOYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QtaDZqARAMQJskfL4mgvDaJuHeXUVIV77aBemYNu5dd4Zce/XYKNvtbocTjgxnmzOcAP3lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyf2bIxry1KsxQ/6/ybd9sGX7Cn48+LmvJRa8lqzIHiAjqbbYl
	XqPcVOQDweFddS5Wj7loVoU+lQuBGTFDdb3x636URaE7zZo/107SSv4IJ9dtPruElk8=
X-Gm-Gg: Acq92OHjZv+s5v5DXQMBnqnQvQ8RQKOeQ35uUbl/zTvhE7DA8Uy+qY93bbebD/204xl
	AN/pHOMbFp7VJiPr22fzRMS1xRs/NmWrbGExeIOvRAw0z1F/qg+KGyJFTn54658C/rYgITEPLOE
	Gg43Hx6VR76Ct128RhqNdMO1Z+DjBV3ccHlf4NvQJhhcqyC1othork3wIlLI9a1YJCjqmq/mcvE
	olwDym3Owa93r2QfSjoi2ZaDbKxpCXLzdf294qT0YQs+xs+MRk0Gv9daPjR15PX1M5m4h/rThyN
	z09UAOj2k+rV3meLDPQ8bin2tozFXgs1YGHJ+Ja1cFxHdHYc1Si1v+vGFXflB1L+Ppq7fapV/ma
	/6wQooRXAy+3+sRTqgCG6BLadLpy6jNhazzfzds5KdBtMxLJXXsrbLUiq/BxQhbrR4WdUpASC1e
	W8tYmzyAXG52xxfbhDCYvFWOUV6PyV++UNiZCbZCiemrFUkb1/se0fXpV8u+twzRUfnWAUeuyVc
	6A5Kw==
X-Received: by 2002:a05:620a:45a6:b0:8d6:6db0:88de with SMTP id af79cd13be357-90653728e7emr1667325985a.44.1778346053103;
        Sat, 09 May 2026 10:00:53 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c807sm2841885185a.32.2026.05.09.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:00:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLl2p-00000001ptR-0bDu;
	Sat, 09 May 2026 14:00:51 -0300
Date: Sat, 9 May 2026 14:00:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Teddy Astie <teddy.astie@vates.tech>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: How to express "externally managed" IOMMU domains for
 VFIO/IOMMUFD ?
Message-ID: <20260509170051.GD9285@ziepe.ca>
References: <1776873531.8631fc262581453bbf619ec5b2062170.19db5ea67ab000f373@vates.tech>
 <BN9PR11MB5276B3A829AD624A7E1AB4408C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260426133027.GB3501894@ziepe.ca>
 <BN9PR11MB52768B5170F6CE558B0AC8AA8C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768B5170F6CE558B0AC8AA8C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, May 07, 2026 at 08:02:40AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Sunday, April 26, 2026 9:30 PM
> > 
> > On Thu, Apr 23, 2026 at 08:01:50AM +0000, Tian, Kevin wrote:
> > > > On Xen, we have a dedicated hypercalls for moving a device into another
> > > > guest (so it no longer belongs in Dom0, at far as DMA is concerned).
> > > >
> > > > But it looks like there are no way to describe that idea of "attach that
> > > > device to this VM" nor "the device is in a VM"; which makes that
> > > > impracticable.
> > > >
> > > > There may be things that could be done with the vIOMMU objects, but
> > > > there would be no "parent domain" in such case, as said earlier it
> > > > doesn't exist in the IOMMU subsystem.
> > > >
> > > > What is expected to be done instead ?
> > > >
> > > > Teddy
> > > >
> > > > [1] https://www.youtube.com/watch?v=pLMGRgEJ-Eg
> > > >
> > >
> > > It'd be much easier to collect comments if you can put plain words
> > > to explain the problem rather than expecting other folks to watch
> > > the video first...
> > 
> > It sounds like CC and pkvm to me so I think it should re-use those
> > mechanisms..
> > 
> 
> for CC and pkvm the guest memory is still allocated from host.

From an iommu perspective that doesn't entirely matter, what it sees
is that the translation is controlled by some secure world and it
only needs a way to associate the kvm handle for the secure world with
any required call for configuring the viommu.

It is not very different from KVM installing encrypted pages that have
been completed unmapped from all page tables in the hypervisor into
the VM's secure EPT through TDX calls and then iommufd creating a
viommu that re-uses the secure EPT.

The only thing dealing with the memory map is KVM. I'd expect Xen to
work the same, however the invisible memory was affiliated with the VM
through KVM the iommu side should pick up the KVM and then request a
VIOMMU to be setup for the VFIO device on the target KVM and that
should trigger the hypercalls to move the device into the selected
guest.

Jason
