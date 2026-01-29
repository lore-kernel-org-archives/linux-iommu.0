Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58C23E356
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649099; cv=pass; b=QFtG+4LggZQvv9ir86hwMIFWmE57ywudXsBsgLeiKlbXmeQ71SDik3sx167Et8i+ALCsbo2VyF/1B2R0AA2POnQ/LYGSIoYGyBgcG17Oev+Iq4FngjdE86163EfmIt0k23dtyepjCYIKtHEaWQHBqN3XhuFIydhbxbtsW9nnAkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649099; c=relaxed/simple;
	bh=waLrhpvh/frM8oNLEkJ2UwKy5n4NvgCqoMT4unJ/UT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLT5osflSpd/rVtxm8+SZrRLA04qfYyuuJVXu2XugAqToGF1rQYN9cMcrKx1XgGiWOxC5lJi5/E7QBb/85DUpStlU9LOs8AV9XxQvk5iNXmz6LTMiyQ6pB4Ij6nVSP2k/JXCbVv5t+Vp6u/nc6EMIoRS68CtFrLso52ryfds0oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpx9YNGh; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpx9YNGh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50299648ae9so120471cf.1
        for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 17:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769649097; cv=none;
        d=google.com; s=arc-20240605;
        b=L4KwT/q/1gVhWIEzNmNtI8D9lQ3GgB/wh33DWhZrq1nQHVIrB3Me+LcVgrmhnriPk9
         mHBnzhLsSoH5eFH3InmaVCUp3iE+zJRNjfobegaaQk0ABAsW0lfGacBkXeFsTmGnLhgT
         JvxLoIAcjL+otSALjGYano1d3oZeImSsTPbbCYD/BOt/tdRkyLlyZEiWBZ5u/mMHdb3+
         JUV/3lBqFBpUtQOZKF8REsvVj+OVR8WlJVTFz1DZCeLvnCtEeXO2f7Q6q5fPJwnD335V
         wxhfx6WUwgb/9kttXFxXCdGbE2SYoA94xHKGXbhp2CDNcJRHVVfaNe2a7+pytuHzNsvl
         6OVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XSVGt8as8LEYmgDu9c9BmAOwcIDQvoR+ttqvLRbhmSk=;
        fh=npzNL/j6Tiumh8yD2XHkQpMkkxoNDWE0BkBe7ze3Cj8=;
        b=VRbb2ab2Dt2Ec4Q3SLONycfyoCO4vy2wRZFtLt+CcOAZwyhNzOw92PRE4WR6XufNL4
         OPgbHedA5fOxg3THhrJNnwm7nFIRladw4VH7+i7tQHon3GnHHCIOSld4SLAT/capw421
         I1K7L7ppg4oLUvIm+yb3/DZt/AbTbgr07rPxldVocDFwH3b7V59lzji/xnxwot1An90G
         Sl5t1y1VcJcqvYlLq/A7eEJ7dsYPOX5AzMNrHNOnLEwGQnAwqyTYPOtX4/CQe1DiTmwS
         oMULVs7t/gzsZtleQnXzWxWYyqy3R9pWSEeQ+5yBorlF3olX6VWkxA3eil5mwVvvnpJG
         1X0A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769649097; x=1770253897; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSVGt8as8LEYmgDu9c9BmAOwcIDQvoR+ttqvLRbhmSk=;
        b=mpx9YNGhuLXpzb8KeJE02fnFEtvKuq8KDmO1sWSgHv5TRdE8eILrFkelROI77E02A/
         Uki6OiC8D9Z6W5XkDh0Gmsug7AR/L3ggCYqIh6HMH62npykdiTFRRFS6y8mMLPB7tkh0
         dUCmd+OGBuYoKgzsJq5kB0ro0f1N1va3n46elCGWFQP/cP/ZeoskMUGQt/PV9cbne9M8
         JnTVJRXLnB/+Z7IAwXW2FLaqTRQwedzgAvPPLY2yrJh222LwVvDAXqIUkhULiOIvOLmd
         QqcXlzO+VkUCD0bqNGE58odM4WcBEjw64n3dp1yg7+K8TsNkW6tmarYuSv4aMYcKOZYO
         tuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649097; x=1770253897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSVGt8as8LEYmgDu9c9BmAOwcIDQvoR+ttqvLRbhmSk=;
        b=HyZRKXJ69hUIw1gQpIP0SC3m2hgzMdwq+oV0kGFPK3u+q+f9sPfdMYg1ekJxsXdGvD
         Y79bKsxA6iDREUlFCtUshd4SasEHi/igQbcHKsk5EWVzd0gujTX0e35Gtcl5uciC8Noz
         1K1C6bYWnUHEGDcKeE5HIOxBiKF19FYoWe8TQDfC38BGR8qJp3yGYpmhHruL13DsC2Xv
         1I5mIxpITcDHmJQqo6/hKX+Uls+1WfR3ED8qfPIEK+KBXkDHFd0A0SuQrhgFKzhLSJi2
         rOBdIXzScakV6DcdFF0gHBisM5XrZBxX5mGqnxczHFEl3Gq7rkcf1ezrM14SEuNc/RIe
         inEw==
X-Forwarded-Encrypted: i=1; AJvYcCXo7YISw0HbMT+QqCUChUmPsGDAHwx0TasjJj17svSwCT6+m3QACb7oDwuv6pc7KDj5N071LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv1OK6aKOiMn8Vd4VfVeCHVTbT759UWrnZkuXX27AThRX97jLy
	zZylIRCqtOX/9U7xndicD/g1aK2ufwlw1UruKUfT1BKNMrSn7cmXbj2C59psd0Z81QNypWML8TM
	EvOcaieY3vvkY6xunMW94rE6hdMsgWDqz9WXHcOck
X-Gm-Gg: AZuq6aJTepbj3EoajfPmD6w2K8andtmLjKK/li50mzdoH2lbbCy6/1iNW0nMyfzFsBf
	EnKqzze5KuR4n3Dn3xxuFudBv3ynb8aohXKNT3KsmT43HQhTfohT5OzGWApFTzYbZyvugFfCjoH
	1Gfckytk7aJd0+SHnvO2p3WjY2ALfhEMn4D/RStc1cch+0Zz2SJjffCNuDMNCC3zkpqRiA2I6D0
	hrdWGCBoHy+aCyP/xMq39PIwbLNOTKsJ14q6xc0lj2IPDAlcuOJ0uB9aivrn294WWa/G01sr66W
	Cx3enpRUKg/675ANKVaIpLvjZO6y
X-Received: by 2002:ac8:7c47:0:b0:503:2d8f:4cd9 with SMTP id
 d75a77b69052e-503b67573e4mr5410721cf.16.1769649096824; Wed, 28 Jan 2026
 17:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com> <20260128195943.GY1641016@ziepe.ca>
In-Reply-To: <20260128195943.GY1641016@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 28 Jan 2026 17:11:25 -0800
X-Gm-Features: AZwV_Qg8fFmu7C7S4fidkwAvXAKr8T8WZOaG3wh7Y4myB6lAdsCMpqMVoC_OLgs
Message-ID: <CAAywjhRXwRD7rmZ2DjN2roDMvWCV2772KhM2hox5RE8Prt4nxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/32] Add live update state preservation
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 11:59=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Dec 02, 2025 at 11:02:30PM +0000, Samiullah Khawaja wrote:
> >
> > Samiullah Khawaja (26):
> >   iommu: Add liveupdate FLB for IOMMU state preservation
> >   iommu: Register IOMMU FLB with iommufd file handler
> >   iommu: Implement IOMMU LU FLB preserve/unpreserve callbacks
> >   iommu: Add iommu_domain ops to preserve, unpreserve and restore
> >   iommu/pages: Add APIs to preserve/unpreserve/restore iommu pages
> >   iommupt: Implement preserve/unpreserve/restore callbacks
> >   iommu: Add APIs to preserve/unpreserve iommu domains
> >   iommufd: Use the iommu_domain_preserve/unpreserve APIs
> >   iommu: Add API to keep track of iommu domain attachments
> >   iommu: Add API to preserve/unpreserve a device
> >   iommu/vt-d: Implement device and iommu preserve/unpreserve ops
> >   iommufd: Add APIs to preserve/unpreserve a vfio cdev
> >   vfio/pci: Preserve the iommufd state of the vfio cdev
> >   iommu: Add APIs to get preserved state of a device
> >   iommu/vt-d: Clean the context entries of unpreserved devices
> >   iommu: Implement IOMMU FLB retrieve and finish ops
> >   iommu: Add an API get the preserved state of an IOMMU
> >   iommu/vt-d: restore state of the preserved IOMMU
> >   iommu: Add helper APIs to fetch preserved device state
> >   iommu/vt-d: reclaim domain ids of the preserved devices
> >   iommu: restore preserved domain and reattach
> >   iommu/vt-d: reuse the preserved domain id for preserved devices
> >   iommufd: Handle the iommufd can_finish properly
> >   iommu: Transfer device ownership after liveupdate
> >   iommu: Allow replacing restored domain
> >   iommufd/selftest: Add test to verify iommufd preservation
> >
> > YiFei Zhu (6):
> >   iommufd: Allow HWPTs to have a NULL IOAS
> >   iommufd: split alloc and domain assign from iommufd_hwpt_paging_alloc
> >   iommufd: Add basic skeleton based on liveupdate_file_handler
> >   iommufd-lu: Implement basic prepare/cancel/finish/retrieve using
> >     folios
> >   iommufd-lu: Implement ioctl to let userspace mark an HWPT to be
> >     preserved
> >   iommufd-lu: Persist iommu hardware pagetables for live update
>
> This really needs to be made smaller and more focused to be
> reviewable and mergable. Try to stick to 15-ish patches.

Agreed. I will restructure this into a more focused series.
>
> There is a lot giong on here, I suggest focusing this only on the main
> iommu core, a vt-d driver implementation of the bare minimum, and an
> iommufd function to trigger preservation of a domain.

The preservation is done into FLB and that is bound to the iommufd
file handler. So the phase 1 series will need some boiler plate logic
to trigger preserve/unpreserve. It will also need checking that memfds
are preserved and SEALd to make it robust. But I will try to keep it
to a minimum.
>
> Start off by just making the successor kernel fail to accept any
> drivers at all because the iommu_domain was preserved. ie restore the
> domain and set it as the default_domain and then fail in
> iommu_device_use_default_domain() and related functions.

Right. In this model, the device would remain unusable after
liveupdate as you cannot do session finish. So the only way to recover
would be to do a proper reboot. But I think this is a great
intermediate step.
>
> All it should do is convey an iommu_domain and the pasid table entry
> unchanged without hit from prior to successor kernel. That's the bare
> minimum.
>
> Then a second series which picks up from there and feeds the sucessor pat=
h
> through iommufd/vfio.

Yes this sounds like a great split of series. I experimented with this
a little and it is workable. But like I mentioned earlier, some boiler
plate will be needed.
>
> Jason
