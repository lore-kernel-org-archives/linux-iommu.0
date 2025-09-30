Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EB145B16
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274158; cv=none; b=Mo1BrGSEuVxwfSCQ7zreWGpX0vgYtaeF5UT+Yr8K2JfsyiiroH4XuTQJJNCYEqzqH7krdElPacOQQIZCi3GgPO0cSOPQzD4GGHFCUYvMVtzlO8dFIi4OTvTl/lUQcyVR3JEb1LqsYapj8y16eOJ60u/4R1fL2vvUjF9KM5zfjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274158; c=relaxed/simple;
	bh=avL1rWBunFTgSKQhZqowxnKhVr1RP4S9GV/sye2EIP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5f7aHTcn4XYp+yIhmnA+LbZMnI3dby8Q5pIsnMxAmvME2ytoP3BSt611ixhVDNt8OxKitnsvicUMiHIbS29mk9GGQj0N6cwoS59faiXPQwWzMvtxTiMvA+SR+p7KtmlB3bp6NE35uIWiPf6Owpm3te4QCurhChE/t9e1ErJ+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4S3I/KI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4S3I/KI"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4df3fabe9c2so51331cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759274155; x=1759878955; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avL1rWBunFTgSKQhZqowxnKhVr1RP4S9GV/sye2EIP4=;
        b=J4S3I/KIGogXFAq25XubB7WAt+9doxqsASLPuMbpTotCHt1QmzOo3GVPog2aIOcfqi
         j/Io2loBhye5L5ZFfD6NKcHmnJuRqcpK2aLnU2J5F3Wq34hCGx4IRgJhzc1Q6fnINiyN
         hN6DoXC41QOvOS8lXy8ZvKkRc3hkjzKZrt54WcWo2bHNBRFMoAMuAcnI70SKWZuuJ76v
         M06x9NHNAr4dYW1EkBmVHEBSquPcLhzV1jrLabQ23VFQhDFIbWQgeCwea3llMbzzIb08
         ZaHucnR4c5KBp6ZAKZZFkiOsT9VsytDLH44Y4il58cXOK9aWMmpGLZeHbdsS1hyL7Qw2
         UVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759274155; x=1759878955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avL1rWBunFTgSKQhZqowxnKhVr1RP4S9GV/sye2EIP4=;
        b=gHCqhJSCjT1LmWPrsDxvohLZ6BQAbKw49upJGxE3rP405GwEL8g7nJg1MDYBQR8VVK
         77vLqioxRdV33mk1llUduLDyaVgEfaL8txwbUVueyHrRC346XgeVUhrjaW+enI+zIz2g
         7XnrMoaiwIYQJRe8nKZLYOHfmhNyyBxHsvQsGJP8s6qdEUrEE965xN0Bhjo0ZSjZlNxF
         ES3hbRSPw03kQ7vfDQFijFa2Q0TLH3Dyp3/FwyWcsG/0+t+PGfpPSC7I6FKoDd7QszvR
         NA3sS/QA7k5vEdpYM2L795JBu1Gaxk2OR4yVogQrbzUsdY9jUY8hCaUdkz7ywoxyi39L
         EagQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSrof+5REdIz892mVn0TaRwtMU3DT2k11DlErf8KSXhHa26MaVU8ok84c7kPPmmrAUBS8kxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWo03rxrv9mklFWr3mUqzyfrWaSAJqrOKUudA8jF2dV+F9smAS
	ccwwagRVABiiNT4V5sMFRirg9GpPDxc4fGyh9XE0viDPAMlczUQulGDv/bMynQaMaVHUAHnwuLM
	nA1/zTAfDyy8Ov/HEWNPI8JGvRsM7jkD046WDyf/0
X-Gm-Gg: ASbGncsR9eqU+0pnr/umMcEhRbrRoqNmNNPhIT1026l62zeGp+N9f7BG2XmC3yc3TZQ
	gzV/uB5wRQXUM07EvvpyjNsvsjSY5TixAI97QNCx4ns9gKAIdjhRNnVKPVo8UBCMFA67uxa8nBo
	n5dmBMsFK/rUIxvRPdE1xRtLGobYbSXFXlQ0lsJ2j25BjdGZ0HPFwY4G2mLfd2UvqSW/YaEkKug
	hN2taVYC6zpkaf1b49zY5bXohaGHtdeFDlCRyGOHUkgFr8T+LrtxXvNDAGeoMlIIM3q6uatH8fc
	KhE=
X-Google-Smtp-Source: AGHT+IGPIoxnc9wl9XoB03dKZCaUowW6vVnO/ky57WoBHCiNTAZb+mWCRVcb+zmztZVZ9ReoYArCalm5QPGFPsWdPdY=
X-Received: by 2002:a05:622a:30a:b0:4ca:c49a:549d with SMTP id
 d75a77b69052e-4e45111f774mr1258111cf.9.1759274155027; Tue, 30 Sep 2025
 16:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
In-Reply-To: <20250930210504.GU2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 30 Sep 2025 16:15:43 -0700
X-Gm-Features: AS18NWBnk-42w8cdejF4xgnkLcF9Jd68pR7aYC-MmhJCljNRDOOGNN7hUI9RPdo
Message-ID: <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:05=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Sep 30, 2025 at 01:02:31PM -0700, Samiullah Khawaja wrote:
> > > There are HWPTs outside the IOAS so it is inconsisent.
> >
> > This makes sense. But if I understand correctly a HWPT should be
> > associated one way or another to a preserved device or IOAS. Also the
> > nested ones will have parent HWPT. Can we not look at the dependencies
> > here and find the HWPTs that need to preserved.
>
> Maybe in some capacity, but I would say more of don't allow preserving
> things that depend on things not already preserved somehow.

I agree. I think this makes sense. Users can explicitly indicate that
they want to preserve HWPTs and iommufd can enforce the dependencies.
>
> > > Finally we expect to discard the preserved HWPTs and replace them we
> > > rebuilt ones at least as a first step. Userspace needs to sequence al=
l
> > > of this..
> >
> > But if we discard the old HWPTs and replace them with the new ones, we
> > shouldn't need labeling of the old HWPTs? We would definitely need to
> > sequence the replacement and discard of the old ones, but that can
> > also be inferred through the dependencies between the new HWPTs?
>
> It depends how this ends up being designed and who is responsible to
> free the restored iommu_domain.

Agreed. I think it depends on how much is restored from the previous
kernel. Discussed further below inline.
>
> The iommu core code should be restoring the iommu_domain as soon as
> the attached device is plugged in and attaching the preserved domain
> instead of something else during the device probe sequence
>
> This logic should not be in drivers.
>
> From there you either put the hwpt back into iommufd and have it free
> the iommu_domain when it destroys the hwpt
>
> Or you have the iommu core code free the iommu_domain at some point
> after iommufd has replaced the attachment with a new iommu_domain?

But we cannot do the replacement during domain attachment because
userspace might not have fully prepared the new domain with all the
required DMA mappings. Replace during LUO finish?

This is actually very close to what I had in mind for the "Hotswap"
model. My thought was:

1. During boot, the IOMMU core sets up a default domain but doesn't
program the context entries for the preserved device. The hardware
keeps on using the old preserved tables.
2. Userspace restores the iommufd, creates a new HWPT/domain and
populates mappings.
3. On FINISH, the IOMMU core updates the context entries of preserved
devices to point to the new domain.

I have a sequence diagram for this in the cover letter also.

I understand the desire to have the preserved iommu domain be restored
during boot so the device has a default domain and there is an owner
of the attached restored domain, but that would prevent the iommfud
from cooking a clean new domain.

Maybe we can refine the "Hotswap" model I had in mind. Basically on
boot the core restores the preserved iommu domain, but core lets
iommufd attach a new domain with preserved devices without replacing
the underlying context entries? The core replaces the context entries
when the iommufd indicates that the domain is fully prepared (during
luo finish).
>
> I'm not sure which is a better option..
>
> Also there is an interesting behavior to note that if the iommu driver
> restores a domain then it will also prevent a non-vfio driver from
> binding to that device.

Agreed. I think in the "Hotswap" approach I discussed above, if we
don't restore the domain, the core can just commit the context entries
of the new default domain if a non-vfio driver is bound to the device.
>
> Jason
