Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D25227
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366873; cv=none; b=n6v796UqOlmMeQnziQQA8uKHGst9LD0MX67ptuSmFDFTaL1WNckdqSUBhv3lfaektVqnhSABXpKW/HBH2i6tvYkZahsqny0wVY2Pf0TUsB5aoRXlDfPwN+pgg4Tb7EurLsJ1Xxr3xzWT/JocRG56xbTrklPDHRqNY6dZWXYJkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366873; c=relaxed/simple;
	bh=TIu7h1xeIgBHKKl2I6wLR7XEqYt0J6cvSYGxq+2z8nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGsBch4k8iC93KENKEs3oB3MjbXYHVMMhRA8txZ7rV1y8rvHzw0qcQ+Rk5c7g4+yoK2ZDksL8qXJMOMUzKoDOhvsZpgwKXFp4SDLrr0nD0BG+C2IqswVX0S/waJq9lAGaYIi5e28GAZMWKCIumPmzpja7dhdZ29CXGWdja+WfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUcybF5u; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUcybF5u"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de66881569so230341cf.0
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 18:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759366871; x=1759971671; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIu7h1xeIgBHKKl2I6wLR7XEqYt0J6cvSYGxq+2z8nQ=;
        b=vUcybF5u667i3ixQY7rXBbDVuQB9vxx6EYvI/wmUaVK9d1kGJluW1/hJJ3McdM0LQB
         mUetVOrY+rJjZtHXPwTZ53bubBM/btWDl/7m16BDHBJx5QWlMdvNgcKB9R6rIw9BPizc
         vjVPBrU190rjUx5O55K8oSqJaNPvQBtU7scKZ/3rnnyk+fVt3QmKnuFNYhgtB0CEU8LM
         ho5+JZzSQWeIty7SKw+Sm3YFALkBYg8WoWmy795Wd2qzqQaxT97Zfo0cJ5qAhYS0s4ME
         oCAROpSXI8RbxSVwirI/G+F23mrfG0hxN5yiTr+Ou8R05tFPeobN5T26UulSHV/nl2aI
         qjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366871; x=1759971671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIu7h1xeIgBHKKl2I6wLR7XEqYt0J6cvSYGxq+2z8nQ=;
        b=BIU7i1J5cDUUlobA7aIvqgOC81NaOVSpwnf87TNPVRAF7N2vTPJEXx6hfE6pXcfhgA
         eD5OTfNVxhe1X9c9jSfMzYIRh6HhB0vVgppuhkyLFFUyCSFUkh6HATAI42dXwKX+8t5z
         3Sv/P0DJUcEFxBX3x2XuQXVhZnqdm60DHGVAWQ20cYvSrRZOBrMQZ3gdaFdnN2E47JIT
         pNOlBGM/mHtrpJpZhCD8XP9NAtq01TTuQ7bNd7DgW6WHTr+A/5khnn7ie3/HjcZj17uA
         w3oluMzFxx+6dxzZ2YSYLHGR2UzXalO6uQu8HB9YKuINKo7i9E2GBYF8Krez6XCHVSgd
         74kg==
X-Forwarded-Encrypted: i=1; AJvYcCXwlGV++UM1hXYyxgZyx0Q7adngU/Z0JVxW7pwlDff2nRPyt+OKJ20SY1rVptS6yluuQB6Hsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKihlgy4gPqLlfOzKj0wLtU7ckQ92ZeFHG4oR79nIHBmWY5lmJ
	ZYSyvdrBPcGWWVzIbAOMWXKZhuEm9Ctj8jNKSkPwtPwADj5uQJIfB78tA5OyUYX3pTbqPrmeskG
	J9RLXgw3XMSQ/96VrO9aoO5EmVBjiLGP94Cr9itFo
X-Gm-Gg: ASbGncsKDccyBy2JqQGaDOpKuv5BOSqfknhzjet64SWtlrKsjpYs7JNg8LjQjvxYo4e
	g19EiVKkKlOdIFJaw4Ou+6EBfJO7bOM0Gur20W+xksGpqgTD137Ssj+OQbXILk555tC9SdC10Mm
	/BVpW4IAfBs33e2MpumL+BY025zk5kmKKGOyGDvPeMKfbmWk4zAtixFhA7z/VaHZ76PPn7s1XNP
	9Y8ze9m/xMFBoTJegWm9jeUWU8tumt58tIu0QoS8PAp37TmwnA37D/3hWKkDd1UGFRZoWc=
X-Google-Smtp-Source: AGHT+IEv1WzjEquiM1NfLv5QPI43hNJpK4KVIQfGAHhJ/qmStxnbo/qPo29TIZNVNN+eisyz+YCW0ZgCCimLjJZMX94=
X-Received: by 2002:a05:622a:1817:b0:4e0:ba0b:6f2a with SMTP id
 d75a77b69052e-4e56b1c363dmr2533731cf.14.1759366870490; Wed, 01 Oct 2025
 18:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
In-Reply-To: <20251001114742.GV2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 1 Oct 2025 18:00:58 -0700
X-Gm-Features: AS18NWClc2AUSNQhBbZ9vE_PU_Z8tSuRXnmyJUXgj81sp5NS2cvTVsg3RJFphCw
Message-ID: <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
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

On Wed, Oct 1, 2025 at 4:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Sep 30, 2025 at 04:15:43PM -0700, Samiullah Khawaja wrote:
>
> > > The iommu core code should be restoring the iommu_domain as soon as
> > > the attached device is plugged in and attaching the preserved domain
> > > instead of something else during the device probe sequence
> > >
> > > This logic should not be in drivers.
> > >
> > > From there you either put the hwpt back into iommufd and have it free
> > > the iommu_domain when it destroys the hwpt
> > >
> > > Or you have the iommu core code free the iommu_domain at some point
> > > after iommufd has replaced the attachment with a new iommu_domain?
> >
> > But we cannot do the replacement during domain attachment because
> > userspace might not have fully prepared the new domain with all the
> > required DMA mappings. Replace during LUO finish?
>
> The idea is the kernel will restore the iommu_domain during early boot
> in the iommu_core and then attach it. This should "rewrite" the IOMMU
> HW context for that device with identical content. Drivers must be
> enhanced to support this hitless rewrite (AMD and ARM are already
> done).
>
> At this point the kernel is operating normally with a normal domain
> and a normal driver, no special luo stuff.
>
> Later iommufd will come along and establish a HWPT that has an
> identical translation. Then we replace the luo domain with the new
> HWPT and free the luo domain.
>
> > 1. During boot, the IOMMU core sets up a default domain but doesn't
> > program the context entries for the preserved device. The hardware
> > keeps on using the old preserved tables.
>
> When the iommu driver first starts up it can take over the context
> memory from the predecessor kernel. But it has to go through it and
> clear out most of the context entries.
>
> Only context entries belonging to devices marked for preservation
> should be kept unchanged.

Agreed. We have to sanitize these and remove unused entries. I think
the same goes for any PASID tables.
>
> Later we probe the struct device to the iommu and do as I said above
> to restore consistency.
>
> > 2. Userspace restores the iommufd, creates a new HWPT/domain and
> > populates mappings.
>
> Yes
>
> > 3. On FINISH, the IOMMU core updates the context entries of preserved
> > devices to point to the new domain.
>
> No, finish should never do anything on the restore path, IMHO. User
> should directly attach the newly created HWPT when it is ready.

Makes sense. But if the user never replaces the restored iommu_domain
with a new HWPT, we will have to discard the old (restored) domain on
finish since it doesn't have any associated HWPT. I see you already
hinted at this below. This needs to be handled carefully considering
the vfio cdev FD state also. Discussed further below.
>
> > I understand the desire to have the preserved iommu domain be restored
> > during boot so the device has a default domain and there is an owner
> > of the attached restored domain, but that would prevent the iommfud
> > from cooking a clean new domain.
>
> The "default domain" is the "DMA API domain" and it has to be created
> and setup always. The change here is instead of attaching the default
> domain we attach the luo restored domain at early boot.

Oh... I meant the group->domain instead of group->default_domain.
Should have written active domain instead of default domain.
>
> This sets the device into an "owned" mode but vfio can still attach
> and nothing prevents iommufd from building a new hwpt and attaching
> it.

This is the part that I was concerned about since I was looking into
the auto_domain. Users that attach to ioas directly and use
auto_domain would not be able to restore the mappings before attaching
to the device. But users that use HWPT directly should be able to
prepare a new domain and hotswap when ready. But I think a new
interface can be built to support IOAS only use cases also. We can
revisit this later.
>
> > Maybe we can refine the "Hotswap" model I had in mind. Basically on
> > boot the core restores the preserved iommu domain, but core lets
> > iommufd attach a new domain with preserved devices without replacing
> > the underlying context entries?
>
> Replace the context entries. If everything is working properly the
> preserved domain should compute an identical context entry, so no
> reason to not just "replace" it which should be a NOP.
>
> > > Also there is an interesting behavior to note that if the iommu drive=
r
> > > restores a domain then it will also prevent a non-vfio driver from
> > > binding to that device.
> >
> > Agreed. I think in the "Hotswap" approach I discussed above, if we
> > don't restore the domain, the core can just commit the context entries
> > of the new default domain if a non-vfio driver is bound to the device.
>
> As I said, the owned nature of the device will prevent attaching a
> non-vfio driver in the first place.
>
> So the only path forward for userspace is to attach vfio, and then
> iommufd should take over that luo restored iommu_domain and eventually
> free it.
>
> You might consider that finish should de-own the device if vfio didn't
> claim it. But that is a bit tricky since it needs a FLR before the
> domains can be switched around.

That's a good point. But it might be tricky since the ownership of the
device is with the vfio cdev FD. So if vfio cdev FD is never
restored/reclaimed the device can be FLR'd. iommufd will follow along
and discard the domain.

The more interesting case might be where cdev is restored and bound to
iommufd but the user never recreates and hotswaps a new HWPT. In this
case we can discard the restored iommu_domain and replace it with the
blocking domain as it should have been if the device was not
preserved.
>
> Jason
