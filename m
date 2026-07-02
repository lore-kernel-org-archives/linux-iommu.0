Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931440B6D4
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979846; cv=none; b=tLHf76jmqtdskLX22yj5CrYhTs+EO4qph37zkgmsN/nVI4NrnLOzvmMCHEMVpBvB06hVzc4SVRPLF/CwpRv/Km62PttxttDAxkLn4+5piwQuOEb5/dIKuMuOGVuKOOYVx0S9tyXwUfCG2BQMIn3/Pvv1wb480dn6HEw8fyxhD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979846; c=relaxed/simple;
	bh=ap1syISulsKRSaIRGnWZqvqO+c8TnmiIW0rxGDJ3Zus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0Xk1i1iaK7yxZXRy9dBAoaUSAMEDSc/Fmi3wvDPXQS9Ixv7Lst+vUKVI2iZTNByofIg1AaQm9s7o74yVDZxD1ugnnH3OmFaUirThhs02eKltwzehKMtiVIoQ70V+s5DJ6ef1ovbQDS3LqEGTOEXi4gxUB6MfUpeuOu4RJJUuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTAL3SsD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTAL3SsD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c486f012so3240485e9.3
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782979843; x=1783584643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIcE6G+6TDMoCdkb5TNOONacJV25dJbtV9kWeZ6u/To=;
        b=MTAL3SsDXR/cRlK9HelLbFpIy24HApj3+CkO3MngvAgDN1wxCd2mFIXtFhOYktIQdW
         7kt7KGekOKMg0uWWTHRlUCPJBiwA4wh/MamzmL98RPkbCMVyx+R8eQGENx83r6Tg5VY9
         IU5Hu2jvLa1LPJ9z/4zHAeDsg0w1rhjaMU3OXo1fQ6adpd0QREFOG1bMMsFuKZnxL9kU
         jDhukWRGsrJPM8ZRZIM/UgwtDw+BJWvYY5DteU63tB6CCrn23IEAnQN2PFYuCVve1IVu
         hqRcgUPOsEk/6BHwgGnffEv6HTHsBh8geanDU/6NL2QlwuT5pNHHFK4uODDClvMEsGdL
         TLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979843; x=1783584643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIcE6G+6TDMoCdkb5TNOONacJV25dJbtV9kWeZ6u/To=;
        b=a69L8QffZ6g+d1gptG2YyF623MeNngNLaZvU868oCbVhFUy2jj/DuuCmd6w829xQ3c
         MN8EKZrFxzlrupR/HtLD2s8FkS20aohGwbEXz+NWGM3As2RoCU2hGh6SeyhojqMq8PCy
         O+HUc6ROL4aSsi4PEoRG10CCBj349WmwIAq/nQDr/VAEt9vZ49pOUz89hgdDpgV1qwWk
         7RknWRUZ6ocVudSREfaTJiyzbVR7uw5A/WV+HdZeTnZJgedsCnnJTliXFNVcS4Uk9riM
         lxPGQygorfb+KKTks147z0RpcX0wFz0izkW3KinZo79OKOIY1K4loMYPajOwP44uVWCM
         AI2w==
X-Forwarded-Encrypted: i=1; AFNElJ/7Xxa1Hby3D9Ec7ZMsCVuEKVYvUIWRQHSbZDoQan50toeRXPfihqE1bkDQ7k9kyYLp07t81g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJkMBf8Fa7olHsViDRj+/Um4/M4801vezEjC/R/i5eoaqyMUwO
	hom1sGYzltWHqmD+JTNr+lFWd2qHj6Mkcqxnn7VP8N4yqyzxPnXzghFQ
X-Gm-Gg: AfdE7clyXfUi0nn8PYLO3AYq1HJgf0ui5fpKvaZ8cltteiZ0l92EjVma8gcxddq+u7A
	jp5NoThI9w16YOFS9b/RMpzbMgxFWWeMSwzVOKLuPaQzrZ4E7X2hzisdvnClaDCtYUs2j6XjgX7
	ezNPM0Oxv6HCxJbFR/VVgVLMHa7OmfrR+mACJAxoELnV2pCf8T7Lsa8lEVya6sL2ULX3QE+4siN
	RSXckcuT9typm2IXFUMNuItepOmHRnUcuBHQZ8yq4DFzi8aXPtJHNTSRr1YQvallJeQqjxFFG3L
	fJMgalf+aN/h0Y9h/BQI3MXUdGCIoQ48xH2pwS50YPZUHal9UGbZ30+yKtDwpVud1xhGmVcu8FK
	qicBAr35zYXbzODs+lwtH1eSdz16n4Bk/fCJw7KDxiOLwNagwTKccnfbrZNxzDMALXCjBp/Wsvk
	Zn1rjVzUqHGei5FFRVHncbZGlA+jF5dN8FH2zdaY3dCnPUmoxBpUiwStZj
X-Received: by 2002:a05:600c:6c95:b0:493:bc4a:fb56 with SMTP id 5b1f17b1804b1-493c2bbcb21mr53757575e9.39.1782979842538;
        Thu, 02 Jul 2026 01:10:42 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3db964sm6530093f8f.8.2026.07.02.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:10:42 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:10:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Ankit
 Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, jmoroni@google.com, kpberry@google.com,
 chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260702091040.35eff00c@pumpkin>
In-Reply-To: <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260623015459.1153884-1-xuehaohu@google.com>
	<20260623094446.4a8fc2ed@pumpkin>
	<ajryxMaT5evDUxaq@google.com>
	<20260623235350.6540eaa2@pumpkin>
	<20260630124252.GD7525@ziepe.ca>
	<CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jul 2026 00:56:40 -0400
David Hu <xuehaohu@google.com> wrote:

> On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
> > =20
> > > > If we restrict incoming dmabuf transfers to fit within VFS-centric
> > > > limits (2GB), we impose unnecessary overhead on the RDMA stack, for=
cing
> > > > it to manage a significantly higher number of memory registrations.=
 By
> > > > cleanly splitting these massive contiguous device buffers into
> > > > page-aligned SGL entries, we directly improve the efficiency of P2P
> > > > transfers and memory registration. =20
> > >
> > > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think aff=
ects
> > > a lot of io) when the quotient is always 1.
> > > Splitting into 2G chunks is a lot cheaper. =20
> >
> > Doesn't matter this isn't fast path stuff. It is better to use fewer
> > SGL entries, IHMO.
> > =20
> > > > Since this change doesn't seem to have a negative impact on standar=
d file
> > > > I/O or break existing VFS constraints, I'm curious why we shouldn't
> > > > support splitting these >4GB P2P transfers? Am I missing something?=
 =20
> > >
> > > I was only wondering whether it was needed...
> > > It does bring up the question of why the >4GB transfers even need spl=
itting.
> > > But that is another question. =20
> >
> > SGL can only store an unsigned int size, so any large physical range
> > has to be split down.
> >
> > rdma now a days has code to process the sgl and restore back the > 4G
> > sizes since mode RDMA HW can accept that.
> >
> > commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> > Author: Michael Margolin <mrgolin@amazon.com>
> > Date:   Mon Feb 17 14:16:23 2025 +0000
> >
> >     RDMA/core: Fix best page size finding when it can cross SG entries
> >
> > So whatever this produces needs to be compatible with that to undo it. =
=20
>=20
> Thank you everyone. It looks like most open issues are sorted out.
> I'll wait for maintainers to weigh in before sending out v3 (which
> will remove the type cast for min() per David L.'s feedback, and
> revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).

Does this code get used a lot for 'normal' transfers?
I'm away from my normal systems and can't check.
But if pretty much all of the fragments are small (< 4G) then
it is probably worth adding a check for 'size < limit' before
anything else and optimising that case.

	David

>=20
> Hi Jason,
>=20
> Thank you for your feedback. I took a closer look at the commit to
> ensure compatibility. This patch is perfectly complementary, and
> actually prevents a failure in an edge case for the latest
> `ib_umem_find_best_pgsz` [1].
>=20
> Regards,
> David
>=20
> [1] For dma-buf split with `0xFFFFFFFF`, in case of a discontinguity
> in later buffers, we will hit this code path in
> `ib_umem_find_best_pgsz`
>=20
> ```
> if (i !=3D 0)
>     mask |=3D va;
> ```
> (*After `va` had been incremented by `0xFFFFFFFF`, due to `va +=3D
> sg_dma_len(sg) - pgoff`)
> (*Which will set the lowest bit of `mask` to 1)
>=20
> Because `count_trailing_zeros(mask) returns 0`,
> `ib_umem_find_best_pgsz()` will always return 0 in such cases.

