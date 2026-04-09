Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339338F94C
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722350; cv=none; b=jljtHngbx0gX2Av9eVgEcYMx5DLJiTouSSyliLSqqQB2TfJmgd1GB5HlytUZe1w55kYE4CTD1JgWzkyHqvcodxBxqgJopPIKqZEkPu71bilNcSsGwS+Q839QjLuNV0Sj4D+Nc33rvVQcHfQ88IYWZC3x3PpwYIA8gfbOA6MwScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722350; c=relaxed/simple;
	bh=Q7JCNytAYQjuPIy49hsOruJYEQOQeo30nyLQr9lJSc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLVzWLbb9WXw5UnVmIQVUPdXP0xs1aYauEVWQkk+w5ztYCNt7bC2PKsUzpTUiy+BtTwNK8xtTYdiTNndx71TxpmvkeTeIfCB72ZCki99kyfxoQlgvyoaXqisDcaaqxr8HPbgMTB4AhSL7ZrGxT1s8B7cU53XoS3wVNcUladCMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ElqQIajq; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElqQIajq"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso532105c88.0
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775722348; x=1776327148; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVeVfPITjwb8p8pHbgvmu2KbZC7o/feW4gic9JCSv60=;
        b=ElqQIajqo2080caMGInqwVmJLjQG5NrWvNVErAv2F1WtJAgVrV1sy3PajA/8OXOEc6
         XF2u4mbXLoPFIch/ms/AdYCLTu5fd0T1EotWoGFOh0lnzinJMwB3S+uHs8A2Zk6OjDPo
         h6lxScpDZKJgZWDy4sNcahZkEBcTW/JK+ZeLm5T0OmEoc4KovmL+QPpJpspQCG/+nhvj
         iOYGZ9LJPmV7BpYosAQs/8SSdoV7clDOFXwsXL78uq8ZqxaLN5U1hdRqOiIrixBSfhL1
         bhj4zXnisHqKORNkDVoKpNIlO0OcfqKf9K0lXXBZ10GJVSBiqjAp4sTWxBwcpb+XYeLF
         EKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722348; x=1776327148;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xVeVfPITjwb8p8pHbgvmu2KbZC7o/feW4gic9JCSv60=;
        b=aB4TZkcu+45N+8zh04j+EjkSPC0M257rh9fgXg4a7SkecpJNF12+StixBDjoI7Pvu/
         lL+oI1M+AczpZQc9D2m1FUEO7LyC00RhY2+8G7RjbwVJeI4DXHZq/Zpuu3Uy3uAAP7nP
         57XDNjhmvYI+HLuNRSbKdbEssTfhK2/OyCwSJ3iw2VpE5vLXbhLuuFAeLQvRXUqWVywP
         01j2MG9OJuYATiOkiznJvevEtGMrPUbfbNY6DK3gdsOatmEmOqlaBi5k3j57k0kij8XV
         whJQ3bXShZQxkjXSUpdV+2WAPSImqYJhh7yRPMZW8ikDX7njdYOyuWS9+zCX/PdlVnyU
         EPog==
X-Gm-Message-State: AOJu0YxROAtshgPpv5tuQ46yH5G/Co1naPFkuyTR5itVQgNupUaPZBRH
	2VuK4NBR0ACN9CEZ6E3a2Q7xAPjJ7YN7LZGl8JWBN+48SVzqTr58G24ZPLXuuOPGi5lcul43nyh
	oVQ==
X-Received: from dlag15.prod.google.com ([2002:a05:701b:250f:b0:12a:77b3:9893])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:51b:b0:12a:6c4b:9d01
 with SMTP id a92af1059eb24-12c28b80147mr1404191c88.7.1775722348287; Thu, 09
 Apr 2026 01:12:28 -0700 (PDT)
Date: Thu,  9 Apr 2026 08:12:25 +0000
In-Reply-To: <20260326220512.GA245789@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260326220512.GA245789@ziepe.ca>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409081227.2149181-1-wnliu@google.com>
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
From: Weinan Liu <wnliu@google.com>
To: jgg@ziepe.ca
Cc: iommu@lists.linux.dev, joro@8bytes.org, josef@toxicpanda.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, Mar 26, 2026 19:05:12 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Sat, Mar 14, 2026 at 02:24:11PM -0400, Josef Bacik wrote:
> > On Thu, Mar 12, 2026 at 9:40=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > > > We are hitting the following soft lockup in production on v6.6 and
> > > > v6.12, but the bug exists in all versions
> > > >
> > > > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w=
:1274919]
> > > > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > > > Hardware name: Google Google Compute Engine/Google Comput Engine, B=
IOS Google 10/25/2025
> > > > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > > > Call Trace:
> > > >  <TASK>
> > > >  amd_iommu_attach_device+0x69/0x450
> > > >  __iommu_device_set_domain+0x7b/0x190
> > > >  __iommu_group_set_core_domain+0x61/0xd0
> > > >  iommu_detatch_group+0x27/0x40
> > > >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> > > >  vfio_group_detach_container+0x59/0x160 [vfio]
> > > >  vfio_group_fops_release+0x4d/0x90 [vfio]
> > > >  __fput+0x95/0x2a0
> > > >  task_work_run+0x93/0xc0
> > > >  do_exit+0x321/0x950
> > > >  do_group_exit+0x7f/0xa0
> > > >  get_signal_0x77d/0x780
> > > >  </TASK>
> > > >
> > > > This occurs because we're a VM and we're splitting up the size
> > > > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > > > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
> > >
> > > This function doesn't exist in the upstream kernel anymore, and the
> > > new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> > > all, AFAIK.
> >=20
> > This was based on linus/master as of March 4th, and we get here via
> > amd_iommu_flush_tlb_all, which definitely still exists, so what
> > specifically are you talking about? Thanks,
>=20
> $ git grep amd_iommu_domain_flush_tlb_pde | wc -l
> 0
>=20
> The entire page table logic was rewritten. The stuff that caused these
> issues is gone and the new stuff doesn't appear to have this bug of
> passing size =3D=3D CMD_INV_IOMMU_ALL_PAGES_ADDRESS.
>=20
> If it does please explain it in terms of the new stuff without
> referencing deleted functions.
>=20
> I don't know how you get something like this into -stable.

I believe the function Josef is referring to on linux/master is amd_iommu_d=
omain_flush_all().
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/iommu/amd/iommu.c#=
L1820

The potential call sequence appears to be:
```
blocked_domain_attach_device() or amd_iommu_attach_device()
  -> detach_device()
    -> amd_iommu_domain_flush_all()
      ->amd_iommu_domain_flush_pages(...,
		CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
```

Based on the code in build_inv_address()[1], it doesn't make sense to break=
=20
the entire cache size into smaller sizes to perform multiple flushes for a =
chunk size
larger than 1 << 51(full flush)

[1] https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/iommu/amd/iomm=
u.c#L1289

