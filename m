Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D411279359
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954343; cv=none; b=F2xsAFm3lpE379KXn1PylcM8OaDbE0qNfUL1z9X4pz33UqbAsnQAaf5hWDUCxL2BMmxxwIu5/rUMBtauuYik5VDad75m6mOIz4wXCrwgHlpI0MjRqIbXgx8b+n2x1eOqu3FGLzTtEvjEpnGSbYy9YfRO62ir9RDRo3qNHSMpP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954343; c=relaxed/simple;
	bh=QEs4pZ5z6UV6DIBPa4q4aPt9EKdlHVU1+3WYy5ax+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGvTCzORWy4x+hHlZuvaCawI5DQMNrdRzitRaU/0ctkEF97kC7kC6E+XDSVTXCcF2jIQZeZiDhxPqBvFURwRd53OJ6+pDJjQXERdrg+XzrBgGmugbWv1cpboJkWVIEVn9+QLL1gbYwed8MvnZ9UZfanOzRJYhJ1OiL33esgtzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N2EKYqjM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N2EKYqjM"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77287fb79d3so3367882b3a.1
        for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757954341; x=1758559141; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEs4pZ5z6UV6DIBPa4q4aPt9EKdlHVU1+3WYy5ax+Bk=;
        b=N2EKYqjMhq5XQtOXanDvDl3UeHd3bNx2ykPfeavaCZM+oStmD03pLHILRXdHxjLqoa
         nnG6cT2gNArk0opr5mmG6kJLAXwKjY3o8ZJrxUHfF/jsNTRE5kw442cJww46I2+1T60H
         o5081iKoU9mS1IZ4IrHbX0xfizmk+WB3o5MoGKCVgFWq1/IjIXB5Sf1NSJqPSRpTTv0D
         j8hDu5RpIh7zjBnoEZp+5KLDk0e1+1LwYJyzc3BV4TBsqgEuNLRAa47waO9wPt9LcWpc
         lhPEEmBXTho2iasGQYPcJ8eu2AYKyJMxTpjOk32mYGeDN8x+qAwNB3PBTiQnsGqvVlrb
         oM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954341; x=1758559141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEs4pZ5z6UV6DIBPa4q4aPt9EKdlHVU1+3WYy5ax+Bk=;
        b=oEFz8vGRi6BP77zEbUcsglOhH27iBxHKTvrlgirumGAWqc5DJq1+r+x7yrDxItSMgX
         3JAgepi32wN9WYBLHB1Gun8YWZj5g56bON8MUeowDp0PV24brWwVqmRLQwP3FmblJN5R
         IgHfMPmTiAA3V9ujb+qxXHV+t5K35a7AC+3wHQaDydlPsLY/7ImrUO+j598IwS1/+lt6
         EI88Ju0tuyZFBsO3l+KYl9z7SWvglW+8D5E1FRzJ444TanNLHShrIAHJ9U+5m7jI0CgP
         de740/21UQf8e6tQzkqBaOY0borV/twgZfar4TW15/x/+Pf5qh8S0AEAtFo/kC5DVR0Y
         MQVw==
X-Forwarded-Encrypted: i=1; AJvYcCWhptj1Pau8JLuXqZEsFCXJbY570GDlVBGqNYPAMw0bOOodIPYD1nfR0aFjOrOBzz0MRzb2lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGM429kO4d3PRV/45Yx5J6vbOImk/jtOqrvluxnl0cgTWCqKTQ
	EzTPKJvN0Yf2PLvrpAT/xkEBVJLF7rbSurPMVoITtzeOV4MM3KQi03hN6Vmq3IK89PU=
X-Gm-Gg: ASbGnctTgt4EatyGdskMyjSQ/Nq8QAv5Uz1h4UbFzc0qDn1yEO5PR0CgRn8jX4SJA+E
	MtDDAvbvj/hXLwBK9NNHlmATOmrUyo7Qlx2TBky8U+cQnPNI7d3uQACLB3rQH1borZQ++4mYY2t
	jtVhTC0nvi55809uZ64ALOyr7suq81LtQXokm9oZrl2GSm723ntjuq/5FOCsLgLJBVjX+2pf6mo
	VshZIryxZWjIJ7G9d4t5Uo/ZKzJ89pHXIrfDRHlPDG/ADSxrDHaFDqY1bPqF/j7iwk/mBI+muj2
	3MFcPiDgVqUPzdTUwAwn5H4FdXr068niLAI4B2hgjkweoPoNoYpqOLlrunhlJxvNGESuF59p
X-Google-Smtp-Source: AGHT+IEq+05CDclx85E3rLT3itHmH/cfmy9YNLof0QbJTkKIbzLS8n6ulerDKoJUcV6j36ozIpBilw==
X-Received: by 2002:a17:902:f693:b0:24c:e232:f92a with SMTP id d9443c01a7336-25d26e47c1fmr168980405ad.44.1757954340679;
        Mon, 15 Sep 2025 09:39:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a61besm43370025ad.53.2025.09.15.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:39:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyCEE-00000004THo-3rBl;
	Mon, 15 Sep 2025 13:38:58 -0300
Date: Mon, 15 Sep 2025 13:38:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250915163858.GK882933@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQroI4NDu74PDGT@willie-the-truck>

On Fri, Sep 12, 2025 at 03:18:08PM +0100, Will Deacon wrote:
> Ideally, the data structures that are shadowed by the hypervisor would
> be mapped as normal-WB cacheable in both the host and the hypervisor so
> we don't have to worry about coherency and we get the performance
> benefits from the caches. Indeed, I think that's how you've mapped
> 'host_cmdq' above _however_ I sadly don't think we can do that if the
> actual SMMU hardware isn't coherent.

That seems like the right conclusion to me, pkvm should not be mapping
as cachable unless it knows the IORT/IDR is marked as coherent.

This is actually something I want to fix in the SMMU driver, it should
always be allocating cachable memory and using
dma_sync_single_for_device() instead of non-cachable DMA coherent
allocations. (Or perhaps better is to use
iommu_pages_flush_incoherent())

I'm hearing about an interesting use case where we'd want to tell the
SMMU to walk STEs non-cachable even if the HW is capable to do
cachable. Apparently in some SOCs it gives better isochronous
properties for realtime DMA.

IMHO for this series at this point pkvm should just require a coherent
SMMU until the above revisions happen.

Jason
