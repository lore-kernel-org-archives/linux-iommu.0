Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC26376490
	for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405505; cv=none; b=uxcjn4JlMTTEjLD1LBs2ORQ+ZvsUWYt+2TQHf4HR55uVtcGh/tD6EUORnFVaAc9isfIH9RfjvZ3w0hWmPAYnycW+qCQYtOv4y6hgD2UtYYohEN33tNSExjP0y5vIBDgISEmcY8iHT/cyfPnh81WcJFdsWcDmJpihWCINIlq21RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405505; c=relaxed/simple;
	bh=rsYCqbczMV4w4qUMEvfd3jp4oJxT0/vk7KoPV4tloAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX8KI82pgygY1wxAkZfMxhPSpHl2GUgijgQuI63XKCWlTTc1NbNbY+fTN9CaDGwcAD0hbUyoMoXM8iLeMZAHixVEZmMo4XrGQZj56MwYQjgA5UxK1Ehq6mfDBSxeOIBMrh8WLpRw6XbTEPiXvysyLSfJz+gs1dvYjKJmOQXVse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kArFKDAw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kArFKDAw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495509b08ebso23715e9.1
        for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784405502; x=1785010302; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHFeM/dPfGA4sFtsC9fMsOxlubs1dV+bQ3yag0vQkBw=;
        b=kArFKDAwPriKFOKJgCTpbvdhYIE6ysHZ2L3y7xw4CByFkXro6ipSwJdE0qgvuGMUy6
         bPiSkv47b4kArVcJmIoUz5esuyvykATwLKJu0kAE+rqHHbuA+xH/Ik3i+xhjarwL3Q8V
         +8G0/tf4Dh9Crs7i4+AqbvrohEBztoOrq6BnNhdMJyb44/HeG3FJ2USQyrXNo/LHCOmY
         6R8POPxLfzfWo6LIv0+a/5GgzBFp6+y4WfpDJUblbFC4ks9pg2hMxso+IRniaRAu2MnC
         aJGGfYPq4p4LF5x2yh/qhfifnULfk8uc1kQhV5lsizEOq16pPmVKznQD+cXAzAhJAdOV
         A5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784405502; x=1785010302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHFeM/dPfGA4sFtsC9fMsOxlubs1dV+bQ3yag0vQkBw=;
        b=kScAzDhkDKGRT2WGdS1+PHDNLDnKgJ+1QG+0dgRaYz+VSNkvIxP4QIeyPYYUcDr3qt
         jYCOPuNLg/6Ex5cZEA7VJzI10RSBSo+tEvi4giJCHGAE6ImoGT3azrNGEq0J5mqWyn2P
         h9vabCQn+iWZHPTI4L1rGUYWJwbJly8WoHRyKFzgNgAlvuF7NtHTjBN0ESEttOgYJwFJ
         88Clcl3jUU2Ry0ywdFzaI0q2p0695jDGkcgL2UXmcmviAn2RDaDfXxKB4z0DTBFL8a7Z
         nS88Wb0afnzU9K2hoSlSXfhuzr5zPTDsQPgnqgx0CHug1B/G/pw6eMKeJ6bmXhkolstI
         oo7A==
X-Forwarded-Encrypted: i=1; AHgh+RoLHhueUK74/v8+wD5IJERs/p30npwgqqNKE8oTFZ2pwJyq0lBQMaZtzY5qD1En5R9ynDgeDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPfd79sdRdX/vsH7YipUPyIcVuzU/wyEAoiCKIL1Px2+mT1B5o
	EPTxI46cSWdhvJQaf64Zde5GhC0HBIQ1ToFDHupHYClPnIHpE9Z1WeTeeiXiV3HaqQ==
X-Gm-Gg: AfdE7cnMTRS326H2w9EgB1OzbXq9t1xrnv0n6qRZNY6DldP7STQUJksGNDEvlbWh5mu
	tj9tD8SWaxioUIr8WtatfOQODIebWvQZ5ZVJ4G+Xp8wRsBDNN88CkqMq5ezHQcz99KhxfjAjW2y
	zgJd/rlI/RV9qQkoGtbMcRyNiYFzA2hXTcl915Ppmbclo9iHUht/YqSHwsYDgjwa8hWyFYdV8VG
	iPJDNH4NsnZ5ti3ikGDwZXH1lmDuzotoDBCSXayKnRRO0GTirsX7TeaRUfOkSrr0AV3OOAXo/uI
	5sQQ7leoUIilRRmVo396u/9sdhmZZ1RO7z2Py6nV2iPWaQqrlm5aqQnkBkxkvr9BtkmuMowS1Sc
	CZ4uSvgbAcPiD0BXRl6VCupUog+qMcvIJNf+Y3ijFl2HbFbJbQEz9kVN0X57sv4m4Y2KaKahdb9
	RifXX8Ld1tbuu36QfUIcxraHvrKOJjA58lR8EItw==
X-Received: by 2002:a05:600c:3f0b:b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-49550691e94mr1258705e9.7.1784405501768;
        Sat, 18 Jul 2026 13:11:41 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49558cb8433sm3398395e9.2.2026.07.18.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:11:40 -0700 (PDT)
Date: Sat, 18 Jul 2026 20:11:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
Message-ID: <alvd9zPeXQVQ7l2l@google.com>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <20260703161228.GA1948451@nvidia.com>
 <b7224dff-7e51-49cb-8421-14d090492dfc@oss.qualcomm.com>
 <20260715113913.GA3775915@nvidia.com>
 <ald3CuddY6I7gml1@willie-the-truck>
 <20260715122830.GB3775915@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715122830.GB3775915@nvidia.com>

On Wed, Jul 15, 2026 at 09:28:30AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 15, 2026 at 01:03:22PM +0100, Will Deacon wrote:
> 
> > From what I can tell, the fiddly parts for iommupt will be:
> > 
> >   1. Hardware bugs / quirks. Some of the simpler ones could probably be
> >      handled but for the more invasive stuff like the Mali format
> >      format, io-pgtable will probably need to hang around. Perhaps
> >      it becomes io-pgtable-mali.c?
> 
> I briefly looked at Mali a while back and it didn't seem so bad, but
> that was for a GPU driver not the iommu so a bit different
> issue. Exactly what the GPU drivers should be doing is less clear to
> me, they don't really fit well with the iommu focused interface (eg
> the memory preload issues/etc).
> 
> >   2. The pKVM work from Mostafa. We'll probably end up with something
> >      separate at EL2 for this (ideally, just reusing the CPU page-table
> >      code when it learns about BBML3).
> 
> Yeah, I'm not sure here, it isn't great that is adding another user
> and open coding some of the logic (eg smmu_pgsize_idmap). It would be
> much better if it could just use all the existing flow more directly
> somehow.

I was under the impression that io-pgtable-arm will remain the same,
but if it is going to be removed (or at least the LPAE format) I need
to figure out an alternative for pKVM:
- Compile iommupt for the hypervisor (similar to what we do with
  io-pgtable-arm in the SMMUv3 pKVM series which compiles in both)
  I am not sure how easy is that for iommupt, I have the SMMUv3
  iommupt series on my review list, I will check that.
- Support the hypervisor page table in the IOMMU, that requires some
  extra support changes, I recently posted BBM support, but there is
  more as avoiding lazy mapping when unmapping, TLB hooks...).
  There is another problem with that for android, as we still need
  stage-1 as some SMMUs only support single stage (used with pv)
- Write a small IO page table implementation just for the hypervisor,
  that's not ideal as it would benefit also from features as CONTPTE.

I will look more into this, solution 1) seems the best case if
practical, otherwise, 2) might be reasonable for upstream.

Thanks,
Mostafa

> 
> >   3. Non-coherent walkers, although I think this might actually be fine
> >      because x86 needs it anyway?
> 
> This is done already, the smmuv3 conversion I've posted supports it.
> 
> > So, for now, I wouldn't require new drivers to use iommupt but I'm
> 
> The recently posted broadcom driver used iommupt and I thought it
> turned out very clean, it actually seems like less work to do it this
> way than try to write your own page table like that rockchip driver
> did which required several review rounds.
> 
> Jason
