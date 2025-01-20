Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817B1E25F4
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381577; cv=none; b=R4XqM6zIsaSwVzxhasg3007BLxsd1a42yvhCGLgaR7DsqYfH2xr+V1jgzMfalkW82sMxDHTn2XCS4AlBDTyl9bphf3f87FKpyGSObXc95okkV1F9TvA6Z1sgSOdIVDiEpuwjTHaVR4l7Lr+NUadXuIIs/RQvJ3IlFUd5ftwZqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381577; c=relaxed/simple;
	bh=R9UuZ10091tIn/30XWCOiokJdfB+dwU6cOauDpgnyh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/eon2qgaFXg3uZfMF5Tly9UgmvN7X++aHqk3ZFhva+3/2tpcIfAGUazyf3JyZ57T+4/N92PQXT5RFLIZ5ufkMySPCqRLYvIpMiQgB9MREIuCRftfTtFkKFIqUttVPiZ5jGBBbSlSaPgtzBmbj/lqhDxyCpTPRvcdqx3t/reRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OHY5Fkp7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OHY5Fkp7"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6e8fe401eso422623885a.2
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737381574; x=1737986374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9UuZ10091tIn/30XWCOiokJdfB+dwU6cOauDpgnyh8=;
        b=OHY5Fkp7VHFg33Q4RUU5sb8Rv/I8NTzqPAuOgMXq1H9eLXGP4pG/rRmeKdAzYnRF97
         l31kiLsr4HIHUGi974KM4WiwmU/b+AxpCOQPu/6helLagyNCNu0e43uz8I44RdiqbIq3
         YXTVBV7kYydq3g1BiGFRCCwTUVxPqGanNA19YjmUkBtFIbneE1Rb/ZEqIPM/w7TqqLms
         zN310KoW40iY7S9sm82X6Pew6ZNTU+V0RBmrdmfLqdS+tN0IIWDrsAyR4RP5tkFPfnNe
         jRHPs222a7pmx2utTyHsspMt0qwSz08t2VtYjmR7VEaIwfc231Hk9XNV68ch68ZFTIaE
         +jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737381574; x=1737986374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9UuZ10091tIn/30XWCOiokJdfB+dwU6cOauDpgnyh8=;
        b=f9GE+9PyF9kyYS8vjcNG6bCjBY3rC/nlsn1Sr8nmxf/yNeBk6J5ENzhLBHSa/kKsn2
         cX1zuyCfv/GOXtCzhUjVi+Q7h1a7HBO8dsXqoHnl/Y0kgkl65/ElxyIvKTDGaU+k4exA
         UOhp9lBnDGfiQAnILMrI+oRdi+OpII4YzVSQ4PK+T46M1XUshz7S93SuIJG+H7LDpV/C
         irAreut6YglgFe7LQFqvexOJTJoTDiCeWjcH1H0w0LR2jP49yc5dsJQ8P3e3M/ArWTY/
         wJfTA5VMIwyMEzWaLXT0TOPRMlh83Hs3nc9Iipk+IKoAotb3s9QQfvdemMmfwj1ZJSRk
         gzSw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZnyuWXlNKwUPLYEQLYmAoCjFgPvsjhrbyvCjSkzyeNE/X99sHODKAIluQ+NM/jGGzPOPwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgtdAQdp3GFzNUSY0P8ApBJXHINgsuLpstoaUz7eZ8BpMBnewQ
	xtgBMWXIOvnUklB08ttT6+5A3knDnIWJmjeWDseEqrURnupdolnqZo+DvswnG78z9dxaV+e1MuN
	c
X-Gm-Gg: ASbGncugw+zFcIeJFjyvNScE+1kqtBSrQUwz3Hv0EwQpdtxdlZVLS8QVhALtfdDJ6hH
	ib88a0cQCLdwxL5wbzQNsbPCaqtUPnFAEadimqzyIY+VrBt64qFVtRtvLDuE/tRi0oH0/0ykP9d
	i4ny1qkGKAi5dpLIL7V1GI98NDdEsyp9sqPYGlVGMQxJEle6xt5IxNdpqeMAc/1NzjJnzlB4GEP
	tWFi7IkEWvAJ4KvCK/dYAxqjGsaSiIPytLkX6RbWcnrLrpyoacJ/xCGYno4CddB3DQy3jiLKwIe
	hkdlbWdXZcyiDMp3suyA5jRUNcupVLKjlXVwDKPlbYk=
X-Google-Smtp-Source: AGHT+IHXw5XwlAOVQM5DmvsT9Jphrpd/TgpL5J7UWvahF7YSM4NY2jfkZTX/ettpphOLDZrPgY8dFw==
X-Received: by 2002:a05:620a:2849:b0:7b6:c2bf:3eeb with SMTP id af79cd13be357-7be6318021bmr2068444285a.0.1737381574398;
        Mon, 20 Jan 2025 05:59:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102fc99asm43201701cf.29.2025.01.20.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:59:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZsJR-00000003PaH-1oaY;
	Mon, 20 Jan 2025 09:59:33 -0400
Date: Mon, 20 Jan 2025 09:59:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] drviers/iommu/amd: support P2P access through IOMMU
 when SME is enabled
Message-ID: <20250120135933.GJ674319@ziepe.ca>
References: <20250117071423.469880-1-east.moutain.yang@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117071423.469880-1-east.moutain.yang@gmail.com>

On Fri, Jan 17, 2025 at 03:14:18PM +0800, Wencheng Yang wrote:
> When SME is enabled, memory encryption bit is set in IOMMU page table
> pte entry, it works fine if the pfn of the pte entry is memory.
> However, if the pfn is MMIO address, for example, map other device's mmio
> space to its io page table, in such situation, setting memory encryption
> bit in pte would cause P2P failure.

This doesn't seem entirely right to me, the encrypted bit should flow
in from the entity doing the map and be based on more detailed
knowledge about what is happening.

Not be guessed at inside the iommu.

We have non-encrpyted CPU memory, and (someday) encrypted MMIO.

Jason
