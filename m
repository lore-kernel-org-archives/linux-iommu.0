Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE915CB0
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458024; cv=none; b=IcP1jWnKB+bESPEnDW7EOL6oM7cvW9n0Ux7sE6IuDSH4KHVJmfFxeNe96Pw/5+gEeBhPhNskTiVQ8gS/4w7+UtwFsGGoYIq7UlpzeLVi8KDIubWz6EMU86gDdXl7gp3z4wLSkr1xwOxku9u9MqgheXpMYldxpLCyaE2jJJByt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458024; c=relaxed/simple;
	bh=7CVCiHmkWEtjZaOJE+H1yk91VAqzvFxUdjW7LQYfSRc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ddfrj51tAEJQEZGGUxi6O2PI3PEwLrKJIpxpgO6O1GpRDIkYnl+G6iALxpnWDUTSZ1sQMtdWRw+lbSct+m7LwaJEaPR5LCma9NBpOIYlnYkRJVIde5fHfv96hec7NPmvrETFaipGqVzbyYU/QJsIOO/FHs2rAcAEpSwOydK8eIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TzFveDS3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TzFveDS3"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7831b3a48e7so631913385a.3
        for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 18:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705458021; x=1706062821; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYVZPcyXo7q2SktZ2+i1Gh7El+Ql5ZT8EyFJ+5OtVjg=;
        b=TzFveDS3cmBKBlF6PDNjiWvisGhEEYwYijPei/g3h2yUg+EsGSB/eHBLfMwWbapFcr
         8AkNKRSO5hE4CjnTMRgFoMjSlapbzpvfMn4yDYG67anDIgr8UnSgR877+JVYBxJ0+Q3Z
         F8HjAGvhXhKZ/RPD4rJQqA9V/3uu92svSjYHda6fudnkSTQDEm60chkVGA7DHiXf4xUu
         I54KrBLLKiI/TDurptFW8Hn8ndwt36WySmaetZO7s40HEJsWM67hk2ZoHRz9svW46SaW
         dJ94+f0WMYfDRIN7M8jZRqJZzXBNLtKpj/fcd9m1XvztTHDVrwuffQFAtd18yz14M3gJ
         1qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705458021; x=1706062821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYVZPcyXo7q2SktZ2+i1Gh7El+Ql5ZT8EyFJ+5OtVjg=;
        b=OBco11ai17V0+t9T93S/B19LiWkPG1JTN5gX+7KTGSsuXMHT3yBtc1CvgjTfg+Can2
         324H6lxSUZX8XVUcDYL3KZw5tU31bKVPCy8J207bTbGgA0WhMNEKhiGGDRY3lKjKnNvW
         ZtBPaq5/hqRF5dXZKUigzgm/rDyYCxaCAUdz4JOHajdNRtLmgGPMthl3ZtHDcHeVfj1j
         G8k8a8anFEbgWbj0pbOD3SgsoX1uY0eLKOKYBz4bB8T54Ki2dTm3LEbd9vOH0UVO2gOe
         7BEF3PX4GzWcCeHD6i/A5InHP675VTXi7uIfuzK55qYe/CYmjLF9LN5umiZLbvgRPET3
         eYtQ==
X-Gm-Message-State: AOJu0YxotopzVoqxdLa3xnXZfII+MoQIIGoF7DvtvnO2Q8EqwsKvZhrR
	fejz0jDjjwFQPRVO4zko/9KNUIFVgeczUQ==
X-Google-Smtp-Source: AGHT+IFaky36LUNJ0WdGHSeGcJ+zHWWfUOIMulY4AsqbXvuDUu75qz5IBEXI5urAHMTEk+MnU6c9iQ==
X-Received: by 2002:a05:620a:4554:b0:783:539a:f319 with SMTP id u20-20020a05620a455400b00783539af319mr7292948qkp.13.1705458021691;
        Tue, 16 Jan 2024 18:20:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id wa12-20020a05620a4d0c00b0078321f3e7c7sm4172575qkn.114.2024.01.16.18.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:20:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPvXQ-004Zr6-Fb;
	Tue, 16 Jan 2024 22:20:20 -0400
Date: Tue, 16 Jan 2024 22:20:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Eric Badger <ebadger@purestorage.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Message-ID: <20240117022020.GH50608@ziepe.ca>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
 <46a61123-dd22-46cb-8b2a-15431fcc03f1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a61123-dd22-46cb-8b2a-15431fcc03f1@arm.com>

On Wed, Jan 17, 2024 at 01:57:34AM +0000, Robin Murphy wrote:
> > > ---
> > >   drivers/iommu/intel/iommu.c | 10 ++++++----
> > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > Unfortunately this issue is likely systemic in all the drivers.
> 
> All two of the drivers which support deferred attach, that is.

We could call release_device on an unlikely error unwind path with a
NULL domain for all drivers.

> > Something I've been thinking about for a while now is to have the
> > option for the core code release to set the driver to a specific
> > releasing domain (probably a blocking or identity global static)
> > 
> > A lot of drivers are open coding this internally in their release
> > functions, like Intel. But it really doesn't deserve to be special.
> 
> Either way it shouldn't apply in this case, though. Crash kernels *are*
> special. The whole point of deferred attach is that we don't disturb
> anything unless we've got as far as definitely using a given default domain
> (from which we can infer the relevant client device should have been reset
> and quiesced). 

If only it were so simple.. It assumes drivers are structured to reset
their devices using only MMIO before doing anything to setup DMA and
trigger an iommu attach. A lot of drivers aren't and this whole scheme
turns a bit sketchy.

Some devices can't even do it at all. eg mlx5 has the crashing kernel
quiet the device before passing over to the crash kernel because there
is no way beyond FLR to regain control of a mlx5 device.

> Thus regardless of why release might get called, if a
> deferred attach never happened then the release should still avoid touching
> any hardware configuration either.

Interesting point.. Makes sense to me

> I'd suggest using dev->iommu->attach_deferred as the condition rather than a
> NULL domain, to be clear that it's the *only* valid reason to not have a
> domain at this point.

So if we take this release_domain approach and we have the core code
not call it for the defered attach case then the driver's
release_device should just free memory allocated by probe and not
touch the data structures?

Then the idea is that drivers would only manipulate their STE/DTE/etc
under attach and never in probe/release.

Jason
