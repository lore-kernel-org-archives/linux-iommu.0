Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1E292B2C
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079355; cv=none; b=BPao1wzR3Y8R2FgCVZkJI7r/baluBU4s3tF8nIxLSAGEkyOfG/JTEW7fwkMHRHMIstqXlOPvGOg0nYHnvzZgHyAvitlh3Gn4ayzB/uX+FWKHY197WITRkYYniDwfPoQ6z9/7M7gfdauRv4JIP5KE3X82QQKW346ZczAz/3P28ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079355; c=relaxed/simple;
	bh=mbyl5OXkWqYUPxXU7YEwGwzWceS42PNsUXDiLKdjHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONAYLINeL2E7Rzx5ryUiR321Me4tV6r5lWP4y/gelSKXsVXkLdIasttxvBQmwmxutefdC6/thSPuHbO/ld2MXYS3Mcm5J8BUVWcHhex+MmLp8Ih1T+MRwai6ptH4nBtz2GOsULaxL86e8U8ZOc9pyDNSqXEi9wYFxNeS8ijC6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YiQZrE86; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YiQZrE86"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fabb948e5aso48705026d6.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750079353; x=1750684153; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlPt6HGrhBZHmQKdGeykmC3k0brj4QqdFhzAJiZkO8k=;
        b=YiQZrE86rpJav95S9hsTOgMg7MDv+SCJCVIt/6kJTmvoftCAV3jtt2XRjjy57LwAUT
         B0N8d//ZLt6VEi6qn+C/S+ChAdQgm65eqVe2oIR4isWyPbvoERSTEbO8FYQ/fSfy3+VJ
         wBTeNadIfah52SbQvKN2mb2KKxh696KTj0jH9tuq5yC9Vzee0n5EpkxiYLbPbUBpj/yp
         i5E859Ic9AHtnYIzVQVmqQbHHC48fXf4OQs8Pqb/woQamSLkS0tyGGltXY32BkRX/tX4
         k5lFmiOicvP2k5PryGWvvokBcqaIIbb3PEb4/LvtOvgB5JnzuD7G4I++OHxjTM5Ih4Gc
         c7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750079353; x=1750684153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlPt6HGrhBZHmQKdGeykmC3k0brj4QqdFhzAJiZkO8k=;
        b=kMpK76GdJBY+5q5OLUm//+MIfqtiUDh7FvDKs4MrMJmiqoUEK+plhgsA/YY77k8T4m
         kCS/2ivd2UYFq29n93Vqy6SxRGmfc+aKd8TgExUJjjOE64DbhYKLAeIaIshyZ7xLlwqH
         Psbw+65zySlPOz3fA00xFW6UoJgL463aqpaRqmhfZg9zK8BRzM1LAM5khqxbL6I5v47g
         Y64XW27Z0g1Dh2XmcPA3lqwiD3G9xz0BKkpqHELyAKRCFjHCJJg7FSTCkB4EUSP4IKTz
         RvAZqjrGllyiCookplZ3tlblYMJFdsS4CyKEn3I85M8CI7v6/qU8dI7V3QRtduFaYMqs
         M7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Zzj6i9cglERlhe3zg+P5C0jkKeYOAc0QJ0NhvvuxFEj11RC4WyGw29FMS+hnOirFVSP3Uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYrN6APBl1wtg4dHGLa6OFi9to201AlOlPLsu6Y+jR7ZRSPnck
	LK9iNEf6zgN/wCV8ozisCJWXTMUt93x1+YFc54p+YkruIJYwjUWNBMLPDC5VIqXOtnQ=
X-Gm-Gg: ASbGnctcOd6dl4B5qoC5El1rn/dgOZes80DoUt32ysFWAVevik6z7uMRvGy2AzXruO0
	x+0sTflye87J3VaNOTCNiS21bvHExRxMRrB5GQJqoF1uygC9lHGaczus/NZ47Co0rBkRPcQzpbi
	KwW7NETmuSYLOWR5HCeMten4qhw5fUKX0GO0pVkBWbm/Hh1j8SrhfJcJFuqJ/X9bpmf4eWEjOPr
	UIrT1g9+5oDs1/xXWf6d+Almat487nEhU8EfaXCWmia6xSEgIl8zaq4vrxaTuzjtikUdQviembf
	5N6IwoKvnVCDj3um2HYPVGD7utcFZ+Ca/uVGBo0Lat35oJEpgmRwxBkgE0ZW23LAj5n3y6r7WCV
	O4D3zbMJ5hqUfsvBQet71hzBezZZvSnbdjHCqPw==
X-Google-Smtp-Source: AGHT+IFYwnfrlyEOgdj8TrGnzF9X6IlaZQJ38GRIzTE1wgTjrgnCanKObhnDaStP1HkHOZyR/IYWjw==
X-Received: by 2002:ad4:5d6f:0:b0:6fa:d8bb:294c with SMTP id 6a1803df08f44-6fb47726e99mr137566516d6.14.1750079352531;
        Mon, 16 Jun 2025 06:09:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20f67sm50759076d6.16.2025.06.16.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:09:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uR9aJ-00000005gPp-17Iv;
	Mon, 16 Jun 2025 10:09:11 -0300
Date: Mon, 16 Jun 2025 10:09:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <20250616130911.GA1354058@ziepe.ca>
References: <20250610163045.GI543171@nvidia.com>
 <20250613192709.GA971579@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613192709.GA971579@bhelgaas>

On Fri, Jun 13, 2025 at 02:27:09PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 01:30:45PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 04:37:58PM +0100, Robin Murphy wrote:
> > > On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> > > > Hi all,
> > > > 
> > > > Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> > > > before initiating a Function Level Reset, and then ensure no invalidation
> > > > requests being issued to a device when its ATS capability is disabled.
> > > 
> > > Not really - what it says is that software should not expect to receive
> > > invalidate completions from a function which is in the process of being
> > > reset or powered off, and if software doesn't want to be confused by that
> > > then it should take care to wait for completion or timeout of all
> > > outstanding requests, and avoid issuing new requests, before initiating such
> > > a reset or power transition.
> > 
> > The commit message can be more precise, but I agree with the
> > conclusion that the right direction for Linux is to disable and block
> > ATS, instead of trying to ignore completion time out events, or trying
> > to block page table mutations. Ie do what the implementation note
> > says..
> > 
> > Maybe:
> > 
> > PCIe permits a device to ignore ATS invalidation TLPs while it is
> > processing FLR. This creates a problem visible to the OS where ATS
> > invalidation commands will time out. For instance a SVA domain will
> > have no coordination with a FLR event and can racily issue ATC
> > invalidations into a resetting device.
> 
> The sec 10.3.1 implementation note mentions FLR specifically, but it
> seems like *any* kind of reset would be vulnerable, e.g., SBR,
> external PERST# assert, etc?

Yes, there are a bunch of states where a PCI devices is permitted to
ignore ATC invalidation TLPs.. Aside from all the resets power
management is also a problem.

Jason
