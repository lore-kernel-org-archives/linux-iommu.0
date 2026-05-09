Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB43AE189
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346895; cv=none; b=mUquBxWgO8mWzxBLajqSdXpDNOFsiNA4r7hUJqPxmwsYbsTfWBzscB/I9IDWkuIBRtcFB4fzMjI6H4SkaABW5dcJ8StVwtQ879+Nvp/dz5Uq5IlsHDzwWm1sQeVYS/VWirR7EypR3z+OoUEvTBLdJO6t179pmeZmWI2rGDIJNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346895; c=relaxed/simple;
	bh=NUlcG7G8zv+4xg3w7cQINICjBlhkrosqjAYvpj/xr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV7mfrjHJcFtupEmdF4JOZ2M2EF9uEcectKpaUTGyzc+JjUc7GN2MO8Bf1xh+g81qrvlJNhpCpDkEUnvvK1lQWtmswtL4xZYDq8mdTLb2eN/LZzGQXDvbvvQoDfhqeedfyQAzj0nIs+xnanCf+QcmDUWFQiifysuO2wLGuhpmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ab05WXQC; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ab05WXQC"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cbc593a67aso276859485a.2
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778346894; x=1778951694; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUlcG7G8zv+4xg3w7cQINICjBlhkrosqjAYvpj/xr+Y=;
        b=Ab05WXQCqljh7dB9m9hd3GCwHqyTDqnD6pYuTE+lX2RM57BkhWLZUeqMH8Tx8OsfL3
         O0VVBmZoVgywAc6xm2y17J9zaxOZN+N2ImxY0SyV92lgNMElcTWVNx49aFKUw+HSap4s
         dRJVQFSdDhAEUsU0Epr54uL9FkqZY//21QCTcSBpHGZBB7KDkuq63rUjN2CSQToI1nnx
         EE50mKuPgttYHKdbNHT/YHEvEO+Gtqm2FiTbNqDi8TGHQjw5L9uaV0IGHsb6Yf573I8X
         2fKqyxDZNUEKrSJ1DK4Q1jU6MGSx5/ii8CS5qjE9849YMxAsNrPLEvfc3e2PdRHMJikM
         NLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346894; x=1778951694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUlcG7G8zv+4xg3w7cQINICjBlhkrosqjAYvpj/xr+Y=;
        b=s6/U+EXBCToCjyR78tF9Vg0zYhDbsG2SNfxtyOG8RD+n7kCK3lXdWmWEQ6PvHkxp3w
         JT4sM7hus+sSrxLQNg+ZFmjj7/3EP6/xkM3+5333eQNXObyAp2qPKmtqmvgFARo64biL
         STS9MKmDWB+wYbMVRzb3oJu7X+zswrx4HOTrwh+RPtqqB4qFUjwB7nFlHO+YONSk83DR
         ncEEevkTA0NlUpJ64XRxYetrcz2L/1X4o5Ph49gI5hDGLZYhgwIRTjUiwh+yt5vIagUF
         RjeGzpwc4mEyhSN+T3dVl5zyu/4PRTz1WXY24xw7/3sp9wyqy2gGPUc6WebKF9OjC0AF
         2DtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SOrJsuVTClBOKQri0Rm+P4ir/kFkS9+pO6A/xPKG53Z0g7oA3lBRRtnqytN2/NxM8cZpNvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOn0aUxwiV1MEHRx1hFgXS9ZRDX27wygkPlU1ChSIiNOBTNn8M
	Effdxbqdw87nxhbFSwLyLeiYHB8UqDP9U0lyVPMxAsh0dzyHclwvWSgc02gFlgnj/qY=
X-Gm-Gg: Acq92OFBsdlPiJXSfpBjk1cKN7BE8n6JdKr97V+4URS6oKcBFhGqerl3m6jxwhz8hxr
	XIfEdo+JyJPHkzvu43wgwGfEu2B5VtfY9mtTrjli6TLVVGOW5ueRnPbWbdnQH10cMKpjaD3P6vM
	daEx+lqJ2YGw5LBvnxAuBBBmhQ5VybKGFI6T6n3271x5O4ejMSwKtC8KCD5eqCDnv6oyCwl7V8W
	bJAXz0/eRty5bi/DUbvD7wjFT1sVPejBay98y/NSAb2GHwBjQTU7IpgfkEffrq2h613TfHSCK8K
	mw8i2xAjZg37GBD3A7afwhLaSop6Nl73Pz/ir4cS2xT445qOCKpcdT3Fd3QEkEJK8WFYhUgkU89
	ufqFRBJZmSn7EAbxexj901va6+nS7XsUekEWDM9L9Slt+Ownn4jJ6jiFbQMUoT2TBwh2rS9uBq7
	rpnVvfgjowFsiPpAaHVpjGvqSWOr3g13a5nHxEk8os08Gm3OYCuTW/c7ybb9T1G23PIA2H5a05U
	pHMGOPqZx0e9JI+
X-Received: by 2002:a05:620a:1a15:b0:8db:86d:3cf5 with SMTP id af79cd13be357-9090dfffca7mr451112085a.6.1778346893535;
        Sat, 09 May 2026 10:14:53 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm2639261485a.39.2026.05.09.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:14:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLlGN-00000001r6v-1yQs;
	Sat, 09 May 2026 14:14:51 -0300
Date: Sat, 9 May 2026 14:14:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <20260509171451.GG9285@ziepe.ca>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu69hAtkRlI1GJd@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afu69hAtkRlI1GJd@google.com>

On Wed, May 06, 2026 at 10:04:38PM +0000, Pranjal Shrivastava wrote:

> [1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/pci/quirks.c#L5703

The quirk is broken. It clearly says the device has mis-implemented
the ATS invalidation message so ATS must *NEVER* be enabled.

Thus the quirk should cover the VFs too and also disable ATS there.

So I still think my original suggestion is appropriate, fail to probe
the iommu device if ats prepare fails (serious PCI layer bug, like
broken quirks) and fail to attach the domain of ats enable fails
(serious internal kernel malfunction since enable must succeed if
prepare succeeded)

Jason
