Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96FC23C4EA
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266309; cv=none; b=qGJ4lD7KyJLmDEzlrZQPhRX53nKy7uT//6PVlB7RIxeAKarniX+hpH5n0CBSVKuVuLetiSjtQvUuPuaqFF4EV1L4Opzj85aHRNUu9PMSsqNuktuWcrN8awphvn+FbHhG2t+ZLld9fRps0M3qx1OSH574rWfman8iyXZZGJJgUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266309; c=relaxed/simple;
	bh=lEGDXr0OSsJFsEaYVFe7+rsm4OTGb1tv7ozhbvoTJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awXjgs/BckXMXAIHaz+iVKLuKBL5jnnFLsxITw19DXkb9lIut5gQKw08Apv02unLoEUbGu1VnoJvbIuHmeJJ3XZi7qmOukZh7zsekFJRX5usSU+Blh5Rba/inLYAFSPpM/487m9A2Rd/WhIrh72MzrMt5oSP2ZsQEGa0jhJ+aWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cyDpA/ir; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cyDpA/ir"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so6206316a91.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759266307; x=1759871107; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql1Q7wmWT9QRnmXaB5Vhny8NzT+Ua/Ks+K1EVPAtCvw=;
        b=cyDpA/irVbe+DL6fa2cuxoZ0h1bHCTG+i0b4BHPmZWWx2RVCwXiNsULREKhyuUZNwb
         zIBA3ek4vZom4Olg8cR6MLYmRNsN95ZmAAWH1QDDS/ghVPETLJYjk6Z+/xn1c/TKMMXi
         vD0PSIRhPJnk1gYUzu3pponvb/OglJyBm3XF0hXd6ANPAKI7ynfWY9hcPrdD9vr2BGeU
         6VZ/Zhxxe2henKqCC3XfjtirW8BR7J4oTAcuf74U1P4Yf4yXQFOgyr9hh72xMEqVyeen
         1jwjXpyRhUBJPpYRALa1dxrue5Wuwcf4xhL5TYis+MbPHVNFqeotJmL73swQWJi9RfLk
         b18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759266307; x=1759871107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1Q7wmWT9QRnmXaB5Vhny8NzT+Ua/Ks+K1EVPAtCvw=;
        b=TYEE9k5Xqm/0aAR8Jb5n2uyq+2pxHZmlxACBT9x/Asec8/go7HbWchLIkiN2TyzJ0O
         wDemd799E3Tw1i9yZaX9niDnf/aXjhiXXbzuTvXZ7p+DyVjomkXzmViv5drYI39H5C9t
         ErXBsRmTk+Kty4EpBBTvF5CVuoId6cIdhsIVfy2qctSjJAmSWWVxep4q82MRHdvo/jjl
         lUXfzE4C+dXWb6AuSfV+AnwzkiMmgyerun+o7b+ITyu0Y3lfNnDZXuyBhv73SkPwyjlp
         TDEKWck8MouhpW2/RIWKtfC2glnWr0+AGb0Qtj2VfOY06MVQWdDecS65jnzdWQuShiLZ
         VHAg==
X-Forwarded-Encrypted: i=1; AJvYcCXFBSlIXbmK2zdRX9NlSGyg/r5SR5nvmJz7FP+79OK5TwfPWFsVgwZ89V7lFUSuqeIibnqxzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDANxZO0sc7WIysRWQiLIlv1ZDYmiqi3vxzaTCwxP+ZuvB74ZY
	7R8q4VmBaUKfXkT2UkLju4gcskh2qyPfsga0Ah6Nz39+O4ft2YcD4rkWbi9R5dmgX4Q=
X-Gm-Gg: ASbGncsi2kKck/R35cSC/N2YcFIelT1BDap8D2lioPUvfWaBmeApDzQ5hfHS2oqlEgn
	1HnjSW07idSTYGRZA/B8OgnWQEXaiPdifha7VYMavhLw2QF/V1en1kEwk/j/i+SBzqDIVGLBMjp
	9+xXpRkGg1UNboIK+cfD4Mv4JPZ4C1GFjdwQ/JLOvFYQU4pCIfbIe4PCEBUry9+4GL1fXVk3fFb
	fGU7ts3aCgzlA+1GEbuNaG08km1Cjrib3DQm4VO70PHcoEmOgHH6ufXuE+1g2tfxQ7qB5Hocs8q
	3n6c6gTgTQNClnmYYCyRC1H+y9whqQl94W/Znx2BPK1izGAUyJqflC1ZyaRIZK5HKXzRdvI9MVA
	2Wvd6aLJZFzk46tYnJMrp
X-Google-Smtp-Source: AGHT+IHn9B4YPhcXSlM98kFJ+ee5CCn30TAdf9k2oVDRoOfjvEqnxoeTEITK+r+k1FFQmfJz5mJuvw==
X-Received: by 2002:a17:90b:33ce:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-339a6e9d33fmr988326a91.12.1759266306958;
        Tue, 30 Sep 2025 14:05:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm493824a91.17.2025.09.30.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 14:05:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3hWy-0000000Chej-3Vt2;
	Tue, 30 Sep 2025 18:05:04 -0300
Date: Tue, 30 Sep 2025 18:05:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250930210504.GU2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>

On Tue, Sep 30, 2025 at 01:02:31PM -0700, Samiullah Khawaja wrote:
> > There are HWPTs outside the IOAS so it is inconsisent.
> 
> This makes sense. But if I understand correctly a HWPT should be
> associated one way or another to a preserved device or IOAS. Also the
> nested ones will have parent HWPT. Can we not look at the dependencies
> here and find the HWPTs that need to preserved.

Maybe in some capacity, but I would say more of don't allow preserving
things that depend on things not already preserved somehow.

> > Finally we expect to discard the preserved HWPTs and replace them we
> > rebuilt ones at least as a first step. Userspace needs to sequence all
> > of this..
> 
> But if we discard the old HWPTs and replace them with the new ones, we
> shouldn't need labeling of the old HWPTs? We would definitely need to
> sequence the replacement and discard of the old ones, but that can
> also be inferred through the dependencies between the new HWPTs?

It depends how this ends up being designed and who is responsible to
free the restored iommu_domain.

The iommu core code should be restoring the iommu_domain as soon as
the attached device is plugged in and attaching the preserved domain
instead of something else during the device probe sequence

This logic should not be in drivers.

From there you either put the hwpt back into iommufd and have it free
the iommu_domain when it destroys the hwpt

Or you have the iommu core code free the iommu_domain at some point
after iommufd has replaced the attachment with a new iommu_domain?

I'm not sure which is a better option..

Also there is an interesting behavior to note that if the iommu driver
restores a domain then it will also prevent a non-vfio driver from
binding to that device.

Jason
