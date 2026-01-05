Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C652339716
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639267; cv=none; b=Bzq0AFykjbAUW3aPyq8ttC1Aik/1Zxp5XLucVbcDbKmS/hPZt90n3NjS7Vh3sEvMf3pSsxPce/LL6abQuPfIyQeHhj28zq+GI3Kzxt90ak1yDumqaUxSIjgAOgjX04sdvSQT2NlyrZV9nIeuxrQRBVI7VPN0x6ULFJ3H8bI8nAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639267; c=relaxed/simple;
	bh=ye4WgWUCpvD2gGQR0QMsre2IOoSU2Qr1YG9uLKSAPu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eixLvCwz4hFUovc5mPngneAV1x623og4xSYFoEJzY32hkdmHRejqbtcairTXFyI5XBJjKLJgZbgdwx0HQUT9LykfUtio5zzFIAeCLQUVkxq6s+85HDfU5SBNh5DNVNl5CZvnL3KZDYQrYA8GdBUNXGQudLh97oCSXwlEAHUpfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C1ORhoWs; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C1ORhoWs"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2a4b6876fso24610385a.3
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 10:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767639265; x=1768244065; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffKzN1sLhhBqUNkiha1w3dy/564YXw9eASHrYEoDuBI=;
        b=C1ORhoWsyGFhRW28GLGfk2J+U/C9rRZ3IZ3NKTF0Tvayvc3pvYtZSnh2zsfSZdzISG
         MZLMZTJ7mkfaz0BZgvt/pDhYieaS+OfbxSiCtwkShDIj5MrldwVbdq+NSlgWyVtNw8MB
         mMy32d9J9/UpopvRDQBE+oClbCsDhK1U/o09rhHH9YKeiqmSfZ9YOD015SItK7lKvFG/
         2JS+H2LhBHi4cjiGzWJR2Gv+TXWVqBzZ/iIh7yey9YJK8WTA0MighiStYj5fnTSyYV6x
         Cgo+uZqnfVKdDCo37CL/tjjywQEZ4p/9+tVdHoirEFmXsvtj5u2wytv8b5Pcd0hSwGna
         2i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639265; x=1768244065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffKzN1sLhhBqUNkiha1w3dy/564YXw9eASHrYEoDuBI=;
        b=fnLIY0xl5gwlYXh1aLozIvFfb8JWy2djSriNhW3EJg2N81Ro8ezdRdwGURfqjpHiGI
         sMrXHzR7NrCmvq/cmAab8KMJxXDJw8hHKwlLTIDq7bMYW6D5CZ8raxNhQPkTcYOR7qfI
         wEc2ilUVtiWK5EOQt1Q/pkl3GleQVIRd7qzVe26I7mE+cAvUxP9G2oArWWFebqdlw1nV
         ABqK+OGnrWWRkVq3MN3N4tKRJ8nwYrYj4WULlQnZJKOfPE76M2cL90bxhORAu8E3FfEd
         v/ILdkmUggbRs2db5XJaAGuqMjDkiKxvjYcIsZJO89GLI0S61PVFPVPvGIkK7z6PrNLd
         Zvew==
X-Forwarded-Encrypted: i=1; AJvYcCVFaP1dFpTihUYhMnm8QkhfoTNJAUJs4RE28l9XsplU7q+UcoDWrTQXBxi6wVcdSYBv0KncaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyeXWGqdtv1gDk4SGBfh3J0g9SJ0OFjjiCgYZLHBxKUkjKBa2m
	0kUrHLbuqJKwmOXBwWVCihaWbyvmfj6fFr1lCkSXAxeAV2y4btcAY2U4D6ZVq5uLDX0T6Jcuh6H
	o24ol
X-Gm-Gg: AY/fxX6QYe66B5QYzYrv03mHWfhyylbEq6ND7gyWJYKT63nFc4ne4pe3FOYHQBL4GiF
	L1GJRwVNH6AqcJ8oxSCpJW3xqtTyQpESLZmEGvclBERC41CnmUggvWIvliRRpmBHGiTUGHDAeFm
	m7phO8ea/jd1vod+2ze18LltZxpk8qOQ4ggFnjSM+11dfhxn9U9C0V13ujmjUbykt5S5nbtIFRZ
	NzmCHUY82j6PMUeatNWJusUottKe2g5+eZpaPllD+GsOFzog/bWZsqjxw8Sun/E2j1HfUkkPHYO
	VOqADHHd3MXxD6/vxLVX70bxqrmHwD+VUJ3ywVZUNgKkfOQiVAy8llnPdomkc4C2dOOu3AyTiLt
	FT4SzaJ2badpvwrP3qm/8N7d7Mfr2CNBAAEJceYxUBNngDDuAdFKVbB5Jy0Us1CCs/QAOoxeyNc
	zJWoO1eb2Ja7TZVVtHQEIdEb27erGamnmn1gYnCAeV7eZsdem3Mc2YXW6E1rIlnGtahCY=
X-Google-Smtp-Source: AGHT+IFPnEh+/aHLidYNOpkwlSqg6n9Ja4S07lmjAzoYGYdPvIKU/oQn/q1c0tGHGXl/b++dfA2K6Q==
X-Received: by 2002:a05:622a:303:b0:4ed:af59:9df0 with SMTP id d75a77b69052e-4ffa77f5e8fmr6419151cf.40.1767639265008;
        Mon, 05 Jan 2026 10:54:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa71fc4bdsm3676911cf.31.2026.01.05.10.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:54:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcpih-00000001C7Y-21aN;
	Mon, 05 Jan 2026 14:54:23 -0400
Date: Mon, 5 Jan 2026 14:54:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dawei Li <dawei.li@linux.dev>, will@kernel.org, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260105185423.GI125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
 <20260105145321.GD125261@ziepe.ca>
 <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>

On Mon, Jan 05, 2026 at 04:02:34PM +0000, Robin Murphy wrote:

> > It is reasonable that Linux will set the attributes properly based on
> > what it is doing. Setting the wrong attributes and expecting the HW to
> > ignore them seems like a hacky direction.
> 
> Oh, I'm not saying that we *shouldn't* set our attributes more exactly -
> this would still be needed for doing things the "right" way too - I just
> want to be very clear on the reasons why. 

At least I know of HW where the SMMU fetches covered by COHACC:

 * Translation table walks.
 * Fetches of L1STD, STE, L1CD and CD.
 * Command queue, Event queue and PRI queue access.
 * GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported.

Have a mixture of coherency support. The SOC has multiple fabrics, one
non-coherent one specifically for isochronous traffic.  In HW some
SMMU sub-units (like the table walk) been wired to the isochronous
fabric, while others are using the normal coherent fabric.

So when it comes to this statement:

 If either the SMMU or system cannot *fully* support IO-coherent
 access to SMMU structures/queues/translations, this reads as 0.

The HW is "partially" IO-coherent, so COHACC is 0.

It has been lucky that so far the incorrect attributes haven't caused a
problem, but the next spin of this HW may have issue here. I'd like to
see it fixed.

> bug per se, and although it's indeed not 100% robust, the cases where it
> doesn't hold are more often than not for the wrong reason. Therefore I would
> say doing this purely for the sake of working around bad firmware - and
> especially errata - is just as hacky if not more so.

Yeah, maybe, I am also curious what is motivating Dawei to do this work..

> the DMA API aspect I mean is that in
> general we need some sort of DMA_ATTR_NO_SNOOP when mapping/allocating such
> isochronous buffers/pagetables etc., to make the DMA layer still do the
> cache maintenance/non-cacheable remaps despite dev_is_dma_coherent() being
> true.

I have a feeling this missing support underlies some of the reasons
why FW might lie and set COHACC=0 as it resolves "how does the GPU
driver cache flush things" with no effort..

Jason
