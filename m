Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D111350D70
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870936; cv=none; b=k2rn9rEZ6mmooyH/Pep9CSASPqvGxkftgUmzzIicjqZ70rNKSiKmtKRViyyayXuFc6z4xmwbgn2k/UrZkDcq9HutN5FaUUQjFHDgYK+wHa1acpbsDFKIbQ7aLc1MA0HJdxaVeBMbvLZXIyTDeo/LY8dcx6cx8jsgAS6TVnuTEs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870936; c=relaxed/simple;
	bh=NyVpuu6c242XpNklWg2bhHy4hjRMhbWKMHNWVtNYLj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EV0tabOM+xgp6ConhA4vOBfjMWbzB3SId13TJqjYUeNuaJOrvd5L11KPYWRgvQddbTZ4PIiiDv038AvhdkdfyxDxyicPlIGdsz3ZhFBCJgGbVkdUgY0pPaxpbTP25NPV1+JbfdbmK7yKTC8m24lXUCaEeRXIu/mVkiEOFZvk/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgJK56OR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgJK56OR"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed67a143c5so12191cf.0
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764870931; x=1765475731; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOsbpVeOyVqsHLO7MLR/NCBqc9cGNtR6DcrpaRc+GFY=;
        b=BgJK56ORBZ34tzMmAs6YYaH7HEOaVYISYjk2tb+dPNAFmR6h2Vi+fNwrDzZD4vpdu9
         SrTAQEeDU5MRwMQpYeOE8O1ivnGPnCRrqmT75VOlPHBNFMVIp+cCaTuJDnWLDncNhlnP
         JA/O5YOJUMycS2lIKU/YP9AIqwInk2YwhB3vnrtfe1XfzSPOXMr8bL+dWjeZUnOBt79k
         oer1B5w5KyxeOmTfgPp1aSXuJ34asRFfb1ChTxPXIKyOj7x/pHoQfXIhb5Aevdq2k3eN
         lwDYrycqyQrNNU4pe8BBPULQn3xeBf4QEyWkIlJvQlA3rqN423rjzNV5m06afd35Y10h
         4TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870931; x=1765475731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOsbpVeOyVqsHLO7MLR/NCBqc9cGNtR6DcrpaRc+GFY=;
        b=kw6ZIaripVDFTg8B2fmexLeXvTBNUtezOOohpeWKrn0g8KP5hzUPjT32n5qUq11zcH
         buS5RpG5yM383mHOVlK/7eLnZBST/NQgiGY/l/EUU74ZRY44kMWGQbMQ0U9p/2bk/qR9
         OyNDh3v+Mt6CzE1uTmh1SCOTRK7YHsm6AsR/coL6htdPQ/H8Lj5fRqmyKbi5bScNdINk
         /cajVKfQxmtTx0V0qADtBn96V9+7mpJVvYYDYA1sBcFAW6fdosTEgDPjy3xVwwgWHJSy
         VsiEOHweM6ClE9SRUo7+qhsXnfQaMnDEeFd30m0ZLlnxLsb2+2Ey5/1+3mqp8r/G6m73
         zEgA==
X-Forwarded-Encrypted: i=1; AJvYcCXOEkWrrTrAw567mkjdlXjervrypA2jQIOxjFIwKCwnyKnL5J73zyf8Wo4Z4ZtlTQJJigXLIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYmdsQOIdJprFAbqGC2mnfGoK6I5c+HGwhcPB6shIvLADiul/U
	dPOLGSVuMuAX8r5nDZglt54WSRnVyNfTR8kciMQoFfW6N2As5My3hTe5A+/ZAIudaJ5TsrywYmD
	5mtDYfgmo6iRMnluNErasfaqtSIgGk7uAn6rM2xHE
X-Gm-Gg: ASbGncu5Ax+xrZPMyXYKfTSsFZn/5JOftPbMmxF5cQCPbhMQgwjebU+BTsxMxCBdVOH
	9t2+se182epqQ09cqI+fdi/FQ9H5uHR4zuDohTv9I/Otg6T8HCfqrTO29sT4jOTV7pbdftgMcBQ
	qpIFszh5NlTN1aY+YRaiM2uPiXfrJTOZxJTBIPZ9xcQWVfnGSFVsQAsmagpD6lTEcTaj8zKQBxm
	KjPoAr89IIGnjsiyWRdvexUunQWVz/E+dyiOBxW8IKRACjT8yE6Bm8exxccMJXk0lzaPH8aB8+4
	KchTFmVKdzgJd8mLuJdFa4j7QhXsz6wuKsGs/g==
X-Google-Smtp-Source: AGHT+IEay+eFFC1qw7vd/QRxNTgGljoxTTQtAsKp8ZLblU7oPxnvGeWoUcq+GsLqmhKRwfubRXTAgYTzsOBLn8vnrEs=
X-Received: by 2002:ac8:7f06:0:b0:4f0:22fb:6c1e with SMTP id
 d75a77b69052e-4f030e5dd48mr881cf.8.1764870931072; Thu, 04 Dec 2025 09:55:31
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com> <20251202230303.1017519-25-skhawaja@google.com>
 <b05a1dd0-9692-4bf7-8fa0-0b3857178d1b@linux.intel.com>
In-Reply-To: <b05a1dd0-9692-4bf7-8fa0-0b3857178d1b@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 4 Dec 2025 09:55:19 -0800
X-Gm-Features: AWmQ_blrh0Cyztzg275L6rz1FOu1j16Wiii2Ui5qXnfZeyPXV22wgXtoqbT3lRE
Message-ID: <CAAywjhR=+=3KKQbmEaj0htyzru36reKd8PRse23XMBBfq1myrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/32] iommu/vt-d: restore state of the preserved IOMMU
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 10:48=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 12/3/25 07:02, Samiullah Khawaja wrote:
> > During boot fetch the preserved state of IOMMU unit and if found then
> > restore the state. Reuse the root_table that was preserved in the
> > previous kernel.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >   drivers/iommu/intel/iommu.c      | 30 ++++++++++++++++++++++++------
> >   drivers/iommu/intel/iommu.h      |  2 ++
> >   drivers/iommu/intel/liveupdate.c | 30 ++++++++++++++++++++++++++++++
> >   3 files changed, 56 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 84fef81ecf4d..888351f91918 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -224,12 +224,12 @@ static void clear_translation_pre_enabled(struct =
intel_iommu *iommu)
> >       iommu->flags &=3D ~VTD_FLAG_TRANS_PRE_ENABLED;
> >   }
> >
> > -static void init_translation_status(struct intel_iommu *iommu)
> > +static void init_translation_status(struct intel_iommu *iommu, bool re=
storing)
> >   {
> >       u32 gsts;
> >
> >       gsts =3D readl(iommu->reg + DMAR_GSTS_REG);
> > -     if (gsts & DMA_GSTS_TES)
> > +     if (!restoring && (gsts & DMA_GSTS_TES))
> >               iommu->flags |=3D VTD_FLAG_TRANS_PRE_ENABLED;
> >   }
> >
> > @@ -672,10 +672,18 @@ void dmar_fault_dump_ptes(struct intel_iommu *iom=
mu, u16 source_id,
> >   #endif
> >
> >   /* iommu handling */
> > -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
> > +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct io=
mmu_ser *restored_state)
> >   {
> >       struct root_entry *root;
> >
> > +#if CONFIG_LIVEUPDATE
>
> nit: Is it possible to hide the "IS_ENABLED(CONFIG_LIVEUPDATE)" and "#if
> CONFIG_LIVEUPDATE" checks within the header files?

Thanks for pointing this out.

Yes I think this one can be moved into the header file. I will
evaluate/check all of them and move the ones that can be moved.
>
> > +     if (restored_state) {
> > +             intel_iommu_liveupdate_restore_root_table(iommu, restored=
_state);
> > +             /* Should not be needed since the entries are already cle=
aned in last kernel. */
> > +             __iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
> > +             return 0;
> > +     }
> > +#endif
> >       root =3D iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K=
);
> >       if (!root) {
> >               pr_err("Allocating root entry for %s failed\n",
> > @@ -1616,6 +1624,7 @@ static int copy_translation_tables(struct intel_i=
ommu *iommu)
> >
> >   static int __init init_dmars(void)
> >   {
> > +     struct iommu_ser *iommu_ser =3D NULL;
> >       struct dmar_drhd_unit *drhd;
> >       struct intel_iommu *iommu;
> >       int ret;
> > @@ -1638,8 +1647,12 @@ static int __init init_dmars(void)
> >                                                  intel_pasid_max_id);
> >               }
> >
> > +#if IS_ENABLED(CONFIG_LIVEUPDATE)
> > +             iommu_ser =3D iommu_get_preserved_data(iommu->reg_phys, I=
OMMU_INTEL);
> > +#endif
> > +
> >               intel_iommu_init_qi(iommu);
> > -             init_translation_status(iommu);
> > +             init_translation_status(iommu, !!iommu_ser);
> >
> >               if (translation_pre_enabled(iommu) && !is_kdump_kernel())=
 {
> >                       iommu_disable_translation(iommu);
> > @@ -1653,7 +1666,7 @@ static int __init init_dmars(void)
> >                * we could share the same root & context tables
> >                * among all IOMMU's. Need to Split it later.
> >                */
> > -             ret =3D iommu_alloc_root_entry(iommu);
> > +             ret =3D iommu_alloc_root_entry(iommu, iommu_ser);
> >               if (ret)
> >                       goto free_iommu;
> >
> > @@ -2112,6 +2125,7 @@ int dmar_parse_one_satc(struct acpi_dmar_header *=
hdr, void *arg)
> >   static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
> >   {
> >       struct intel_iommu *iommu =3D dmaru->iommu;
> > +     struct iommu_ser *iommu_ser =3D NULL;
> >       int ret;
> >
> >       /*
> > @@ -2120,7 +2134,11 @@ static int intel_iommu_add(struct dmar_drhd_unit=
 *dmaru)
> >       if (iommu->gcmd & DMA_GCMD_TE)
> >               iommu_disable_translation(iommu);
> >
> > -     ret =3D iommu_alloc_root_entry(iommu);
> > +#if IS_ENABLED(CONFIG_LIVEUPDATE)
> > +     iommu_ser =3D iommu_get_preserved_data(iommu->reg_phys, IOMMU_INT=
EL);
> > +#endif
> > +
> > +     ret =3D iommu_alloc_root_entry(iommu, iommu_ser);
> >       if (ret)
> >               goto out;
> >
> > diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> > index 1eb60ce1300f..b0c56e27f167 100644
> > --- a/drivers/iommu/intel/iommu.h
> > +++ b/drivers/iommu/intel/iommu.h
> > @@ -1283,6 +1283,8 @@ int intel_iommu_preserve_device(struct device *de=
v, struct device_ser *device_se
> >   void intel_iommu_unpreserve_device(struct device *dev, struct device_=
ser *device_ser);
> >   int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser=
 *iommu_ser);
> >   void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_=
ser *iommu_ser);
> > +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iom=
mu,
> > +                                            struct iommu_ser *iommu_se=
r);
> >   bool intel_iommu_liveupdate_clear_context_entries(struct intel_iommu =
*iommu);
> >   #endif
> >
> > diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liv=
eupdate.c
> > index 3f8c7f15bc36..140887187084 100644
> > --- a/drivers/iommu/intel/liveupdate.c
> > +++ b/drivers/iommu/intel/liveupdate.c
> > @@ -73,6 +73,36 @@ static int preserve_iommu_context(struct intel_iommu=
 *iommu)
> >       return ret;
> >   }
> >
> > +static void restore_iommu_context(struct intel_iommu *iommu)
> > +{
> > +     struct context_entry *context;
> > +     int i;
> > +
> > +     for (i =3D 0; i < ROOT_ENTRY_NR; i++) {
> > +             context =3D iommu_context_addr(iommu, i, 0, 0);
> > +             if (context)
> > +                     BUG_ON(!kho_restore_folio(virt_to_phys(context)))=
;
> > +
> > +             if (!sm_supported(iommu))
> > +                     continue;
> > +
> > +             context =3D iommu_context_addr(iommu, i, 0x80, 0);
> > +             if (context)
> > +                     BUG_ON(!kho_restore_folio(virt_to_phys(context)))=
;
> > +     }
> > +}
> > +
> > +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iom=
mu,
> > +                                            struct iommu_ser *iommu_se=
r)
> > +{
> > +     BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
> > +     iommu->root_entry =3D __va(iommu_ser->intel.root_table);
> > +
> > +     restore_iommu_context(iommu);
> > +     pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
> > +             iommu->reg_phys, iommu_ser->intel.root_table);
> > +}
> > +
> >   int intel_iommu_preserve_device(struct device *dev, struct device_ser=
 *device_ser)
> >   {
> >       struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>
> Thanks,
> baolu
>
