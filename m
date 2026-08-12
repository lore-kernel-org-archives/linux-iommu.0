Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4142F6FD
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556582; cv=none; b=ma4oFNxEGvKuVCn1FPTweJiHSzBOG6U9c1pEieiJC68kM3F0Dv/5RAEVtjnHgywirVd2WGBS/z7t0wRaGXbtQn6NHv88oPrLDw+DCmnLnq9xyvcH2qL8LLYdC5GT32s8ltV6QYcKhTA4zSsuAsPwenQGJZDKA9O0j6WTgJyn1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556582; c=relaxed/simple;
	bh=R8K4AhpTTGabp/TpyA1fPLTe5/En+9HZcWa+J+NqaoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeSi58c8MQW4WCrOHsSMKM987cJ+1Wwb3qQ+hpkB8VoRpaUTV7Oi6+YnMmDH/38iyamGPW2eILR9Ep9Kq1nuolA7dkkzUB5ij363xKvy131WrZ11fa86pF2qFyjS/7is/w3e7zd/C6eZhM6E0BkgIeFPQn6SDLYSybG02iDKOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h7iBqkTY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h7iBqkTY"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c08df8513so9160351cf.3
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786556580; x=1787161380; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
        b=h7iBqkTYfGutRLMFliwlxru44k3I/f62FEmk+Xa73AMKWevU4eRvePb79Hr6QKXD9p
         MACy8KwrA9oSCGTkfo0V4t/Fqg1GnYsOJd6dJKsxPXGm7o40GFDWHsunSltVuJJFf4xa
         nBPJK1TleAFCb5z8Gg99hLpJaVzmx4+pKN694GHLwwEVL2Wpq4HM/uFRw81+2+U/r8yA
         TG5vuR78vnclhJaWQ9hbb+uhuMrxTDGvKEhxJsFsMmChaclezK2o9C5egCif8oZ3nhyL
         +fXUb+ba5Mw/jHtrLA3y+iBiIQCe3dqhcRF3lIsNkFlRFz/TrMR+Hms6XjI/tfCTCcb1
         /mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556580; x=1787161380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
        b=RfSPzuaM/qUbKpjmByQj/TEt02tWAl8fUD7LBzV3dtGFTpMnqRl80v+yFWVoR4Kd7n
         I5AgCW6q82MOmhBs/op/XxKvQIWl5PSY24cyzlL35I1F+0N6/NT/mtCLGZmFbIO3BiFq
         nlFRGR2Zezl0Q24GLrGXol4gLPV5/PiUKdd2piAxq1TUY0eujHjQA1MRruk11luV+oX3
         hMxjUfU1hSaqJjx3cppzinb6rNCn5kvrXLRxWHP64oLo95pQHhxa6SREVOUWi1EraG/3
         N5jW1RTb5UsCAzjvTQuaqo/7zY14cjU40zqToTlgDZTPw9jLjFMJpOflCE7H8BOUkRFp
         qoFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqe9nQK/2+RGZqvom0r4ry5VDMX4vEjjp2qRugaPbzmIu8nqT2zxdjhHZZkdg+9zH6Gtq05EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqUVszqEgwi8T7UUgzUECjLLk0K7+fsi1LKSPdikdQfZmWK5G3
	GU4qNJHiCD0/u1uIHvdFBv/EUMhg2AH4xXibHAKXifZsxksGobCaXg/4zn0MujCxf4M=
X-Gm-Gg: AR+sD11pz6aw/EDJ0M11Satkwfc2I+1aQ9QXuWoRFmNpmzXLCPJKhqhc9MdhRmaYcrU
	4mKiysWmFUS95tozOfyWKDOs/BC51T3ehhWkJrEylyt84PefxX7arYG2oDnkt0QwcZ+h20MyFo/
	I7+4r4AxRRdSfq6DIKGoJSeTR6GhsK9Zz4s93hTOs+WxOhhinnLeq7lxn7iuP03KV5jefHfpVC4
	3JbHqmxs6yiFdZH+b3hUSGOaZ0ab1N3gS17yBwpSiKiSLFM6x8mZvUJ7s8kfSrOzD8bq7dL9WY0
	0wK7lNgx8AN4Ei/BwvP2g6g+UfuFKmwsWbFmrgffVwmvEvcVYeUGxpeZ5jKGTLIbndr2pegMbvV
	i773upupHMcIZ6w3mk5FT3yv7ND79aYp6TUK1rJzQxpQd+WEfEsRCyZYFjGbN5yu9Zc917uex9B
	uV7dzvBCmFGmNvi/8TudXyHMIRbKCkD5mnuq815Q==
X-Received: by 2002:a05:622a:145:b0:528:38b1:b54c with SMTP id d75a77b69052e-52d646a004amr57067221cf.2.1786556579927;
        Wed, 12 Aug 2026 10:42:59 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61d91199sm22262711cf.14.2026.08.12.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:42:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuCyg-00000003IL0-2V6p;
	Wed, 12 Aug 2026 14:42:58 -0300
Date: Wed, 12 Aug 2026 14:42:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
Message-ID: <20260812174258.GF662699@ziepe.ca>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
 <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anysnQFVTO_RAYxp@arm.com>

On Wed, Aug 12, 2026 at 06:25:49PM +0100, Catalin Marinas wrote:
> > > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> > > option in realms?
> 
> It's still not clear to me why we went for CC_ATTR_MEM_ENCRYPT instead
> of CC_ATTR_GUEST_MEM_ENCRYPT.

Yeah, this tune should be only for CC guests that have the
shared/private issue.

The AMD SME issue with the address width on bare metal is an entirely
different problem that would need a different kind of tuning.

Jason
