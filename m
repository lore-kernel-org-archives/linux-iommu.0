Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE72DA76A
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122178; cv=none; b=JMTIS1yAB2wzuToQZoBgehmdrNbE+84EbIgNDKi0mLlrwvfrQ5kz6SDhmbDQGqyzyE7kn9Yjb0wOz3jnkQzOctVW67OD03VeoqgS3/xTM/lARifr2GRn0sHMEKjDL7fVePTPPu1iJlLJZWp8IbD+zSAyx+mQXlU0Nw8gBcWpL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122178; c=relaxed/simple;
	bh=vr6s4p5RDrOlpzEnsFxEhXbnKDJ/Ny2Q/csoaU7WttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHmGCaDPvWHjac9DFnfSTb/krksZWZwMrs27vWJynTqP3E3wlj870WpKFwIVmcNbCc3ytoVe7wfL+VuRtA3keLS8bFi4nkdHql3x3Z2pRJUh3/FqK19MD1bnVtnKxTwvmRo2apcorolP87OhvKvGUDPrQ7C0Y6DgsdLgthAcgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BPHcTlHO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BPHcTlHO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32e34f4735eso4127299a91.3
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758122174; x=1758726974; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5mwCMXZll74MsKobdLnh2paEF22CAKr4juHWA93w7A=;
        b=BPHcTlHO565R3xoiaGIyqYdhafe5BhruK2lsEiWhKwSVfn36B60bHwY1cXHenNbMF/
         WxkoUrfOGLkLGBytjgWFvKvFhIfF+isg3oXLVdkriLUNFcFp01isuRm4ABy9Mn+axD4J
         KhHry3DuXARRdLIYXlcpRYEhCeBHnBkCM3TlTReJD8a8Zjt8qC7Gl5a4rmAJmQWpgxUO
         fQ1n7SXMD5tG+CKfUCDJg1DjOr5RXzxeb/h3ZSwa78Kkw82fc4ix+5eibgivt4vN8wbT
         SL5ypP4x1iQwgNUCdBWduvQuJH2lb0/vPPVsoQIZbtPqg0aIsIhr1/w0vOzkRN6N0FPe
         UmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122174; x=1758726974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5mwCMXZll74MsKobdLnh2paEF22CAKr4juHWA93w7A=;
        b=MBaAGzPy/cXNJKA3EA7b/ICqYT7dVv4InPNZqS1EkHFNSfcT1kE+VlVxvPj9d0eRtc
         dv5tAdgwonQztJfb4E80blCs0Z9Y1196riBb75aQCHLobmxsva+6fVHnk/+eu4RjqNFN
         YBEGEeLeeRvTXwPw2dwp0QmuKFrF6L1ls5jkCykrzo938mc4lriNaDd0NOo7Hr7gn8Ol
         9w5qPvdUFvyT+pxO7uQeuGXg1mW1SBJAMTZTsy1IFtYdewV+mqcgx3kKk1O9L5x5+mSD
         1W9fU/JhTeFxad3Xyx0NFSr5lp/HGzX8G5CuVqL90pgNO+9OYRQTViKjHJaU4GtF1qDc
         26Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWkRB1/LpPV3vMpVfK9QLBuE0mawWM9J8PiPdyT9Toc4RTU3pBrO66ZUP5WENh1dempUyfKug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzks1m5Q8bAD/eZMmMPYrAbfIt0w9Z5gL92oDtxXys81LMkrp32
	jezf5B2u/zRKqtCq+OM7oFk4ruvP8rVHin5LZ+Pc3I8Vb4Ir5I4zxj/aKPbSG+pgVira8cQOiML
	CwudIZTo=
X-Gm-Gg: ASbGncul4c6NdxKuiIaVXvhg0lTYSpZ7ATw4g7OeWKk9nsCI0AayGJ6P9i9gnMCykQ7
	YplwBm4gVRXFrIifp6K+N2haL50ajVtJU1yqr8VLKc36geYofeWwaImn9dDfa3tESgh8ESk3XML
	ByWJpKkMXjrZ4SaYZNV5R0z4pdolqS+BC8/K9UccQCvYQ554MhUp/NyxGvuxxRxdFluPB/zgdvU
	ml8v0KWuY5S0LbncJVVp0eVDU5Ow4megD/8/zYoxat5g6ZK8byYnGq8guO8bovixms/4yc7kAWK
	kDv/JH/vVhYlHDeQJ0eqISvHymk1UAe7jX1TOhICBLBLyTdI0OJ3kZKI12lq12U6Lv3nO6zM
X-Google-Smtp-Source: AGHT+IFT1177fnGaDPrsJvXBzm9YkFBr+A6b67xfQf6j5GBKuYGPXR9WdIUZ96yP+o/Tmx5sDbBqfQ==
X-Received: by 2002:a17:90a:d44b:b0:330:3fb8:3884 with SMTP id 98e67ed59e1d1-3303fb83a3dmr2234532a91.16.1758122173999;
        Wed, 17 Sep 2025 08:16:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff1a22fdsm28695a12.0.2025.09.17.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:16:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyttE-00000008NhG-2B33;
	Wed, 17 Sep 2025 12:16:12 -0300
Date: Wed, 17 Sep 2025 12:16:12 -0300
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
Message-ID: <20250917151612.GH1326709@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
 <20250917123601.GA1326709@ziepe.ca>
 <aMrNTny9jgZJd_Ef@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrNTny9jgZJd_Ef@willie-the-truck>

On Wed, Sep 17, 2025 at 04:01:34PM +0100, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 09:36:01AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 16, 2025 at 03:19:02PM +0000, Mostafa Saleh wrote:
> > 
> > > I think the fix for the problem Will mentioned is to just use CMOs
> > > before accessing the host structures, so that should be simple.
> > > If it turns to be more complicated, I am happy to drop the support
> > > for non-coherent devices from this series and we can add it later.
> > 
> > I feel like it is easier/better to fix the driver to use cachable
> > memory than to add CMOs to the pkvm side..
> 
> Hmm, but for non-coherent SMMU hardware (which sadly exists in
> production), I don't think there's a way for firmware to tell the driver
> that it needs to issue CMOs for the page-tables and the CDs but not the
> other in-memory data structures (e.g. STEs). I suppose we could do it in
> some pKVM-specific way, but then that's not really helping anybody else.

Not sure I understand?

I mean to issue CMOs in the smmu driver consistently for everthing,
page table, CD entry, STE, etc. Today it only does it for page table.

Make the driver consistently use cachable memory for everything
instead of having two different ways to deal with incoherent HW.

Jason
