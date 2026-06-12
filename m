Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800337C927
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285490; cv=none; b=Q1+NDghZzGyq9eTPwG4KuLkM/Hw55OHjBbJNMVjvVhIumAxAprIFPwEZ9oiDfpClTEhtCjS9uC2b8qBD7agpsW2tFwjWA1/b/KEePNrqW6pCpapZ9Ytnn3WkESp/8OCH2xtRIriNpuIU1qIahxQskkz+qgcE8Qw4UqscCJAm3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285490; c=relaxed/simple;
	bh=s1uCSJlrOQlubB9uNonltXnNviPAjZLUm3vums7MWf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFqT3qcA/s1Y6+fB2CNd3WnJHDQkibth62Ii+CU9xiwkrW0Csl2+hcLzJKQu5rntyqF2G7YKTJCCyNAHg40jShb+4wnKb33d3CD75DSU6xKQCT18vLiqMtIie99iFUO6oYWvMlLQ8UFi+OQ6FtwJtP4LvV/D11e59T+6Vo26+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YV1rJqDb; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YV1rJqDb"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59e23d70dfaso533741e0c.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781285488; x=1781890288; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1uCSJlrOQlubB9uNonltXnNviPAjZLUm3vums7MWf4=;
        b=YV1rJqDbBOkOs3EDenZ6V41ubbgIpvIYIEm55Le84E3LHwCBG+MmIqt5FVDNuz8ATt
         PDB6y9t56wmzr5zuatyRRwFayqhfPbCqcJ6r5XcxUHvGt1cS22erFJlHhLZdMPtIoFVX
         qEfyBDXdzizj1dGVmpqDmlnUVEOCjVwnZT+ApsF7Gk/CpXfarSzknUC3rtMCC7koLNxD
         X2TdYf+RfIceGkHy1aVEnEH4mxq8D5nM7F1zQf4qg+8RIIjNIqT4PS+aQUF2Yn9EF3ik
         wbRwCXL5qCSCnLgwAWUxMn9HesElfYkwgMsD7nEMSx0Q5kjddoE1dqjA+5s4ojP4SZFg
         kscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285488; x=1781890288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1uCSJlrOQlubB9uNonltXnNviPAjZLUm3vums7MWf4=;
        b=O0wmP5Xnp2nzhjLN2FyiphjE1GZMQ10zSpL22EBqyXm86ooQTcEeX8eFXdfkcj0hkL
         PgjWGBNTwZrBXYHLpX3ocRO3MZnfYtzweQvTH/wwf1ygQh+P4GJYClUyP0I2Hyeaprsg
         KHS+ULSd8jD/60MDksAGWAwSqw1VMrmOY+k1VMpWzVu0gR6RwUqW9R5eJBLvCQEjUoTE
         +DOGIDGq//gHLIZIr3C3t9jdxWLYXxVGaEDxDPJ1hAuPHOUabc455hi7pm059ENqO1Au
         3UQfilqZ66v+gW69LeKY8JP/SW14tzGolPAbdqm8r5cIEueOVX5kghqDLLYLgrybKIUk
         3vyA==
X-Forwarded-Encrypted: i=1; AFNElJ9g0GOse84dYUwRr1wRCQjz7Q7H474FXz56KQAS4O2BwT4tVdiI4zvg6Jt9wTADU50qKjRO8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0S2jOihrYC18bMaXEoFXbdW5Juy1Cfb1G4xUv0BKj3abEZPG/
	xU+ETxOOEYkaTYTPh56tmq1vmlYcKdO3cyIEG7B1nvdV5XacsdXTWJjJRbZAy8sT4MY=
X-Gm-Gg: Acq92OE2HJMBdSyJrlgDNF+YVzTcsPflQyxduT43iuTr0tR/Tn1rgrxYShHzQ6e5uCp
	3sc1u/+TxU9llUcrlOtwqhcF5cYHtr6K69Uo9rPMuypx4HWK//HGFgXrrWOPrguHD9TWII9z5EE
	M68H5psBYub8PKrepwwyjBgi+HeqHk/tQbnAYinsHeXhisqMpAZ7x5yoMOI2fsrMQP1qgqbcFsX
	yYDIursjiSTJm/ktZshCWa0VpNw+oyl2jBqXUStb4SNwlPeQqi/tjPlvJ1Tm0O39OYKRUTVeUj2
	CvOPTXuRq5vV7NzNrhQvXI6V2d9EozAZsgV72H7MrOwp6nQpj8NKAAg7wY83mBUelnUCHSGjztK
	dtN2wfrwE2c8YjR2L/a+01m4zwv6xydL5MV1d3M27LLFUxafiWjKOV9AyBO7smcrQWNHWBwSWNa
	CZ4Kc/0d3RqVsiAbUB7SXE9NaJc+RgfMh0c70KVeBt5GvFFxtvK/hEEcj8D/GJVapm7722bvJx0
	YYRP547mr9vqF+t
X-Received: by 2002:a05:6102:6115:10b0:6d3:aad5:6d2d with SMTP id ada2fe7eead31-71e88c3d33fmr1963086137.18.1781285488502;
        Fri, 12 Jun 2026 10:31:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a074850sm268102985a.47.2026.06.12.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:31:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY5j5-000000089sX-23vR;
	Fri, 12 Jun 2026 14:31:27 -0300
Date: Fri, 12 Jun 2026 14:31:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	suravee.suthikulpanit@amd.com, Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev
Subject: Re: AMD iopt levels question
Message-ID: <20260612173127.GN1066031@ziepe.ca>
References: <airgbnJLPm3tnNig@jsnitsel-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airgbnJLPm3tnNig@jsnitsel-thinkpadt14sgen2i.remote.csb>

On Thu, Jun 11, 2026 at 10:41:31AM -0700, Jerry Snitselaar wrote:

> I didn't have a system where I could reproduce with bonded group of
> them, but I could induce the behavior of the i40e generating the dma
> requests by doing horrible things like throwing a bunch of io at it
> from a remote system, and then mess with ring buffer sizes for the
> device. I was able to capture a vmcore, and near as I could tell it is
> during a window where the DTE gets updated as part of increasing the
> io page table levels, a UR would be sent back to the i40e in response
> to a request, and the controller would start sending these dma
> requests.

IIRC there were some bugs around this flow that were races with the
DTE/IOPTE changes and concurrent DMA. I belive the current upstream
kernel has fixed them all.

You shouldn't get an kind of UR during the increasing process for any
in-use valid dma_addr_t.

Jason
