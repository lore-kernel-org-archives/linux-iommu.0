Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323934;
	b=IJmC7ZWYmklB8HEWGcJoZEl2dFlJTfkAJMx5Oq5njJb4Kz5G9QDbH9NQucZSw1sQFRfe
	 bZwQcQ3c3gGhkZuOxZ/1awLF0axmSswdiLUyTRgCOz9TH91AMpm3NMHUbq8QVhczXQqfE
	 oCsaP1oCgAYbQaimFq06ut477LbnTi/0C5J/rmvVc9ziXM7A6yJplzhLCNF3peWgf7Ppg
	 r5AwHr8vVOtk7wz6Tq19Ya+UvjcGW1Sh3z5fUXYeDa+ZVfOeztzwjK0fzjw0Kxl/pYqXw
	 igxNlntpoD6pn6+2j5JVNdHVvJC9qiEIHvwGEAe9yvSorkGQpgt/I2BPvxjK2ml7Psg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O2sQ0ppPahwiNKXBETtZDPbw3npwpVnR3zhVdoKxb8A=;
	b=ZbNO13WUdJwtjWPaP6uD1Qsr0JEV3KXB1zi5enUwKDU0itGJ6ZvbCYtS/X+bXn/KREcd
	 1qwog5KC1qZ5fufw7OH5WaI9mOZLCtNnUtimZdNr5Pl/1onT4kjS7nyY91xdEEKCdsZWo
	 ELC7rGBtp+B5vDwICRrp0n3SEAzQp75qVd1oSy8NSIyrffFiYY9VmIuBD55XuofLWXUMC
	 lXdWEccSTsKJmH9Sl0dj47uA3CuHxmVFVHomXhYZsNKpVWoSn/bwwFAsL9tY/GrH1YCCK
	 9C6xTIf+rBA57Yu4JR202cHvBTTzlsDcmtM0BBhxxBfIYa5HY2iGtmgGIfggu1E2nnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=g4RrRYQr;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE37606A321
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 15:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEE37606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=g4RrRYQr
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e64d52949so188186785a.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794323933; x=1794928733; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O2sQ0ppPahwiNKXBETtZDPbw3npwpVnR3zhVdoKxb8A=;
        b=g4RrRYQrtsYt+p2PosYQ9C+3i6RGKZMiYDO+NmpsSGl98s/Qspt3vRPbpEt4U73FK5
         o5tQtwJOb1yDRNIpgFQWsv42vcMOUCPsJOK3iDy757uzBx9RULNm/8CKdvxZYFwTu7vu
         RoPQL7eSAImgufGeqCxEa66W3r/NIa26NOymK9J4iiACSbmueBYrzIS6Um9RH2Oopm+s
         ZY/Rqt0YGr60TMYfbmJI2orQocLFlxNW9zFXyBnS6bic/t0eqWIcSgxny/8XbDuforfQ
         a1FrGsnqme6aJMstNMZLczCb3AVmoptRBEbtZeGIlms54J7hJyZeH/tHXVI/a7GP+ySj
         CULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323933; x=1794928733;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2sQ0ppPahwiNKXBETtZDPbw3npwpVnR3zhVdoKxb8A=;
        b=QgDELMxylGtphWRmKG8qf+Dj4pCHCMu698OgFnPQl1D7FPoaDQsepyOnxJPAewdTm+
         GG9sFR7ZXFBsmhlvAivwkHigOQmGKmS63LTcuqNTJ1OoPbLB+f6guM3MPOnvfxktBrO5
         jHQsjnGmOhjJ1eA+e5Tj/xsh+4wBaYvhaIJNO+sgvqNpVSreUqk72t9ubNJqIvq5yy/b
         nZJwjXVosZkiNPnlPV+bg5sJw4/U+0QkZ+ZG1xsYgmvw1OrdcI7Ago7umcc2JsCFWQUv
         tKt/M7FBQ4jXw49KO/LgiT20oRlr/Oy2+2ovvf6YU1cf1xkGUIPYjmjvsyQBor4m/eBj
         R0gQ==
X-Forwarded-Encrypted: i=1; AL+hErGb15XQYSjGB4y4zmVTg4sWJznsflCPigjWAE7IsqJr6RsaMTXVwZKWHMCBIToFiVB8KhcRGA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8YEgaa+rhbZO6OP6DRQeQq2qUHoJ+CNPasEiLqheGgYoDPt/Wf
	9LTBxOjsxpkt9kwc0oWd3tmPxkMMc0KE1LqmUv5ii5uL2IxZwkezjg+JE+tnUfJB4wA=
X-Gm-Gg: AYBFou0QDOwO3Wc+P3vNmqE1jNbTl8two5O/fxalUHWewubWA48KBqZ9dsAEtHhQ1Ug
	Ar6sIgBcP4Q0iSdppP8k8QpJKj92K3IMAZrXryirCsaXo8/GYWwC61G5OqgSvmuI/2eX+WTJRTD
	yoDx10WFTpO7F1gwOU4wjOY45L0zpvV3qPWCOPLoJZ9wjw9J3nkKOXSECUwUJr1zgMiaS3Oowps
	uOv8T9pNc/bcyVVvCl2TsjMjndIOzLIuo6s0nFEheET9Beeuv/qOG9Eg68C9fR+vDl7jKj9UlxD
	irISz/5RGWfpxvWJR3hLd9t87YPTYESjw9CQ7/Twp5kdrCUS5yK73UcJmI1oxA5NG/Xn9VNNHEO
	AnwJYL9c//vwvP5OYgk+jsLaePEQ94vmaTb+5gg0o9C0az11yrCLw9ylN1vkGcGq83FCGaSq+9H
	KjVP4h9qoXbFj8ST6pc5/JUZQHDEtAM5cpw6gv4estZvQzn17FqfvgMjUT1O2gHynPAq9RYRhHT
	uxtJRic50elhxzC7vMSHdgIbSiu7UiRGq2RehIJ6ZZgc6aJff21MOSbG7lvYBkpZjqX6fICZsYS
	4gj+91PeTMbOecL43oNOKmNge6RA+Rrb9EGQAanHfcr3GLvAbRKtBS4GNuGTaanIWZu/xgFn2uC
	AB2nAS/VRe5A=
X-Received: by 2002:a05:620a:461f:b0:946:6:1298 with SMTP id af79cd13be357-9479f323170mr465893185a.52.1794323932611;
        Tue, 10 Nov 2026 07:18:52 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm22998676d6.23.2026.11.10.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:18:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQncX-000000063UD-2Q7t;
	Tue, 10 Nov 2026 11:18:49 -0400
Date: Tue, 10 Nov 2026 11:18:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: xuheng@cs.columbia.edu, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Invalidate a new level-1 stream table
 descriptor
Message-ID: <20261110151849.GZ663069@ziepe.ca>
References: <20261109-smmu-l1std-cfgi-v1-1-65e5203a6516@cs.columbia.edu>
 <avMxDbv6JE0dg93E@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avMxDbv6JE0dg93E@google.com>

On Tue, Nov 10, 2026 at 02:58:21PM +0000, Mostafa Saleh wrote:
> On Mon, Nov 09, 2026 at 09:36:54PM +0000, Xuheng Li via B4 Relay wrote:
> > From: Xuheng Li <xuheng@cs.columbia.edu>
> > 
> > arm_smmu_init_l2_strtab() allocates a level-2 stream table when the first
> > master in its range is added, and makes the level-1 descriptor valid. It
> > issues no invalidation, and the attach that follows sends only the leaf
> > form of CMD_CFGI_STE.
> > 
> > IHI 0070 5.1.1 requires the non-leaf form of CMD_CFGI_STE when an L1STD
> > changes, including when an inactive descriptor with Span == 0 becomes
> > active. An SMMU that cached the inactive descriptor can keep terminating
> > the master's transactions as if its StreamID were invalid.
> > 
> 
> Looking at the spec it says:
> 	An STE or L1STD that is successfully fetched might be cached by the
> 	SMMU in any state, therefore any modification, commissioning or
> 	decommissioning of an STE must be followed by a CMD_CFGI_STE command.

I think the patch is pointing at this:

* Changing an inactive L1STD with Span == 0 to a non-zero active Span
  (introducing a new section of level-2 Stream table) requires an
  invalidation of the L1STD only. As no STEs were reachable for
  StreamIDs within the span, none require invalidation.

Which is really explicit what to do..

> Which checks out. However, I am curious why this was not seen for
> over 10 years with the current behaviour as I doubt any existing
> implementation will do negative caching. Is that something that was
> observed or found by inspection?

Honestly I don't think there is much value in negatively caching table
structure. Negatively caching the resulting leaf is good enough.

> > @@ -2053,6 +2054,14 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
> >  				   ARRAY_SIZE((*l2table)->stes));
> >  	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
> >  				      l2ptr_dma);
> > +
> > +	/*
> > +	 * The SMMU may have cached the old, invalid L1 descriptor. Making it
> > +	 * valid needs the non-leaf form of CMD_CFGI_STE (IHI 0070 5.1.1).
> > +	 */

All the versions are 0070, you should specify rev H.a if citing the spec

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
