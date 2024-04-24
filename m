Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417E16F271
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001458; cv=none; b=s8jyIakcUn4buIjojR2AAEhvgWGALh/mV3UcFFYAxtszXMwG+KAbkLr75+Hj5Gkv3LHmF6aAhbUIpptnyNcjrIuQcfn4FOqTyXzmElMkPboywrc1ls7lPCbIMrfoTYDp8Gp0hTzBU6lN+ZGINJ/Fx6wmLBR0WRz0b+7bM8Y31uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001458; c=relaxed/simple;
	bh=8tX0hIqEDwtvdHuLOQHmw3t48nptNzqhFmHzM8Lw3Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL9w9pABJP48BVsovJ7oh+jIl1Wlu2cVpJdELhcnSWCESw2u7YPWO8bqWxCNQyaC25ZWMaEXIsFYpoAVSGWXQm9o5a3MeE1dnQWZmwU+C0B5+b5EXOOMJ30lsryTIreCObPOvsUduoO5Le5J4fNM1pCvQx1v6iYOIWjx9cNJM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mXDDtG0v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mXDDtG0v"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so389378a91.2
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714001456; x=1714606256; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMATVbNc+KeJ4YoonusKbhJs7fn4XepeFw1NaKuOxdo=;
        b=mXDDtG0v66spk1JvVVZoPpLi0HZ5PZGwAUJ7hssUQlSpgP/tftasA/5Nj/CmAhvo5b
         iL2fwTifAbBjMDhUvRssy2rXiLDfNbeLiv9UdAVTahv63rqeRcPh5bbes9vYmvmqODyo
         0hweFNuh3hpVp+VPMkTug1YcB2d6XspmTDQlihkUpczoXCoEGijVXIvyaYQDSNaGv1tB
         P17RjS6Y71Zw5dzk43lu401Xrr04/3WvA5qo4dPlE6lVRtSIDDo8h/sSafsQtDueHX0D
         ViyjnGHVQpgnOGJsUWWZbFyf5r3INfg1npX7pUasUwAIqsM6N1YwCIjeXe6YYxeTVUwm
         Wf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001456; x=1714606256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMATVbNc+KeJ4YoonusKbhJs7fn4XepeFw1NaKuOxdo=;
        b=q2KlUAEeKeYGN22NTd+hEjxP5Tf3E1yrcFmGVOB9q1ukEd4V0gKv5D8cqK3HkpyntO
         Uf/j8dIuwpYHhafjwt7yIvmW7eBKOr5nsfVr9Nm6kY/IzgiFGip1wClzNtfRi0hs3hzl
         4ono4hfjOXdCV0oVCVhWGaDRoo0DAbtkoGxqRGSmRWkgYb4nFq4yMaIUAg4w5xut5E8E
         ew3EQZH4B4jxhpo+2w9ne9IX3ViB+/afNuyiSrG9iBcTxCngtNrSo5zHkx6YReSYEs0l
         PXeUlOU3V+Hvw+YBFZfNtzYY2ixWYCydgF+qKJvbO2xUw3/XEXI9PAzB3GHF90ZmMu/T
         KK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjAWzudqnJe4xCPWBg4Wn5PPCusvNuCp8GIpxEdyPleQo/pEtH1nstvM8oZ30s4bo04cAt1yc/tFBlF+05xJXiye58Sr8=
X-Gm-Message-State: AOJu0YwKy2uir9RBhkiZRMW0pe7EtIyKsD0rCrDPTcsfGZ3UGqM4Xrv8
	pxAxD/6sFY6MJRgWOhxjTZ3OH8rtHbVFW1XvUezCtRo5b18+18k5DbR3qBBdSuQka7MubSJfbuz
	Dx1cE1Fh6l9U7m/pN9tKmZvDCjTVVidPmP0hxFv+fPq1EYVssyJU=
X-Google-Smtp-Source: AGHT+IHDriSlySRYAYqL2sP2QSsED+lIW5yVPA8GnLPlrwvTr2mGvTrOQx5/GwZwnS4XHBtP69e+E7BWAjK1DtYW0H4=
X-Received: by 2002:a17:90b:1103:b0:2a3:be59:e969 with SMTP id
 gi3-20020a17090b110300b002a3be59e969mr3617650pjb.47.1714001456387; Wed, 24
 Apr 2024 16:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1713456597.git.tjeznach@rivosinc.com> <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <20240419125627.GD223006@ziepe.ca>
In-Reply-To: <20240419125627.GD223006@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 24 Apr 2024 16:30:45 -0700
Message-ID: <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:56=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Apr 18, 2024 at 09:32:25AM -0700, Tomasz Jeznach wrote:
>
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index a4f74588cdc2..32ddc372432d 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
> >  #define dev_to_iommu(dev) \
> >       container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, =
iommu)
> >
> > +/* IOMMU PSCID allocation namespace. */
> > +static DEFINE_IDA(riscv_iommu_pscids);
> > +#define RISCV_IOMMU_MAX_PSCID                BIT(20)
> > +
>
> You may consider putting this IDA in the riscv_iommu_device() and move
> the pscid from the domain to the bond?
>

I've been considering containing IDA inside riscv_iommu_device at some
point,  but it made PCSID management more complicated.  In the follow
up patches it is desired for PSCID to be unique across all IOMMUs in
the system (within guest's GSCID), as the protection domains might
(and will) be shared between more than single IOMMU device.

> >  /* Device resource-managed allocations */
> >  struct riscv_iommu_devres {
> >       unsigned long addr;
> > @@ -752,12 +756,77 @@ static int riscv_iommu_ddt_alloc(struct riscv_iom=
mu_device *iommu)
> >       return 0;
> >  }
> >
> > +struct riscv_iommu_bond {
> > +     struct list_head list;
> > +     struct rcu_head rcu;
> > +     struct device *dev;
> > +};
> > +
> > +/* This struct contains protection domain specific IOMMU driver data. =
*/
> > +struct riscv_iommu_domain {
> > +     struct iommu_domain domain;
> > +     struct list_head bonds;
> > +     int pscid;
> > +     int numa_node;
> > +     int amo_enabled:1;
> > +     unsigned int pgd_mode;
> > +     /* paging domain */
> > +     unsigned long pgd_root;
> > +};
>
> Glad to see there is no riscv_iommu_device pointer in the domain!
>
> > +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > +                                 unsigned long start, unsigned long en=
d)
> > +{
> > +     struct riscv_iommu_bond *bond;
> > +     struct riscv_iommu_device *iommu;
> > +     struct riscv_iommu_command cmd;
> > +     unsigned long len =3D end - start + 1;
> > +     unsigned long iova;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
>
> Pedantically this locking isn't locked right, there is technically
> nothing that prevents bond->dev and the iommu instance struct from
> being freed here. eg iommufd can hit races here if userspace can hot
> unplug devices.
>
> I suggest storing the iommu pointer itself in the bond instead of the
> device then add a synchronize_rcu() to the iommu unregister path.
>

Very good point. Thanks for pointing this out.
Reworked to add locking around list modifications (and do not
incorrectly rely on iommu group mutex locks).

> > +             riscv_iommu_cmd_inval_vma(&cmd);
> > +             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > +             if (len > 0 && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > +                     for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> > +                             riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> > +                             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +                     }
> > +             } else {
> > +                     riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +             }
> > +     }
>
> This seems suboptimal, you probably want to copy the new design that
> Intel is doing where you allocate "bonds" that are already
> de-duplicated. Ie if I have 10 devices on the same iommu sharing the
> domain the above will invalidate the PSCID 10 times. It should only be
> done once.
>
> ie add a "bond" for the (iommu,pscid) and refcount that based on how
> many devices are used. Then another "bond" for the ATS stuff eventually.
>

Agree, not perfect to send duplicate invalidations.
This should improve with follow up patchsets introducing of SVA
(reusing the same, extended bond structure) and update to send IOTLB
range invalidations.

For this change I've decided to go with as simple as possible
implementation and over-invalidate for domains with multiple devices
attached. Hope this makes sense.

> > +
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
> > +
> > +             riscv_iommu_cmd_iofence(&cmd);
> > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEO=
UT);
> > +     }
> > +     rcu_read_unlock();
> > +}
> > +
>
> > @@ -787,12 +870,390 @@ static int riscv_iommu_attach_domain(struct risc=
v_iommu_device *iommu,
> >               xchg64(&dc->ta, ta);
> >               xchg64(&dc->tc, tc);
> >
> > -             /* Device context invalidation will be required. Ignoring=
 for now. */
> > +             if (!(tc & RISCV_IOMMU_DC_TC_V))
> > +                     continue;
>
> No negative caching in HW?
>
No. Disallowed by the spec.

> > +             /* Invalidate device context cache */
> > +             riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> > +             riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +
> > +             if (FIELD_GET(RISCV_IOMMU_PC_FSC_MODE, fsc) =3D=3D RISCV_=
IOMMU_DC_FSC_MODE_BARE)
> > +                     continue;
> > +
> > +             /* Invalidate last valid PSCID */
> > +             riscv_iommu_cmd_inval_vma(&cmd);
> > +             riscv_iommu_cmd_inval_set_pscid(&cmd, FIELD_GET(RISCV_IOM=
MU_DC_TA_PSCID, ta));
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +     }
> > +
> > +     /* Synchronize directory update */
> > +     riscv_iommu_cmd_iofence(&cmd);
> > +     riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> > +
> > +     /* Track domain to devices mapping. */
> > +     if (bond)
> > +             list_add_rcu(&bond->list, &domain->bonds);
>
> This is in the wrong order, the invalidation on the pscid needs to
> start before the pscid is loaded into HW in the first place otherwise
> concurrent invalidations may miss HW updates.
>
> > +
> > +     /* Remove tracking from previous domain, if needed. */
> > +     iommu_domain =3D iommu_get_domain_for_dev(dev);
> > +     if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING=
)) {
>
> No need for !!, && is already booleanizing
>
> > +             domain =3D iommu_domain_to_riscv(iommu_domain);
> > +             bond =3D NULL;
> > +             rcu_read_lock();
> > +             list_for_each_entry_rcu(b, &domain->bonds, list) {
> > +                     if (b->dev =3D=3D dev) {
> > +                             bond =3D b;
> > +                             break;
> > +                     }
> > +             }
> > +             rcu_read_unlock();
> > +
> > +             if (bond) {
> > +                     list_del_rcu(&bond->list);
> > +                     kfree_rcu(bond, rcu);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> > +static inline size_t get_page_size(size_t size)
> > +{
> > +     if (size >=3D IOMMU_PAGE_SIZE_512G)
> > +             return IOMMU_PAGE_SIZE_512G;
> > +     if (size >=3D IOMMU_PAGE_SIZE_1G)
> > +             return IOMMU_PAGE_SIZE_1G;
> > +     if (size >=3D IOMMU_PAGE_SIZE_2M)
> > +             return IOMMU_PAGE_SIZE_2M;
> > +     return IOMMU_PAGE_SIZE_4K;
> > +}
> > +
> > +#define _io_pte_present(pte) ((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE=
))
> > +#define _io_pte_leaf(pte)    ((pte) & _PAGE_LEAF)
> > +#define _io_pte_none(pte)    ((pte) =3D=3D 0)
> > +#define _io_pte_entry(pn, prot)      ((_PAGE_PFN_MASK & ((pn) << _PAGE=
_PFN_SHIFT)) | (prot))
> > +
> > +static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> > +                              unsigned long pte, struct list_head *fre=
elist)
> > +{
> > +     unsigned long *ptr;
> > +     int i;
> > +
> > +     if (!_io_pte_present(pte) || _io_pte_leaf(pte))
> > +             return;
> > +
> > +     ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
> > +
> > +     /* Recursively free all sub page table pages */
> > +     for (i =3D 0; i < PTRS_PER_PTE; i++) {
> > +             pte =3D READ_ONCE(ptr[i]);
> > +             if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0=
) =3D=3D pte)
> > +                     riscv_iommu_pte_free(domain, pte, freelist);
> > +     }
> > +
> > +     if (freelist)
> > +             list_add_tail(&virt_to_page(ptr)->lru, freelist);
> > +     else
> > +             free_page((unsigned long)ptr);
> > +}
>
> Consider putting the page table handling in its own file?
>

It was in separate file at some point, but merged to iommu.c, as its
simple enough with ~300 lines only. Probably not worth separating this
out.

> > +static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu=
_domain,
> > +                                         struct device *dev)
> > +{
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> > +     struct page *page;
> > +
> > +     if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> > +             return -ENODEV;
> > +
> > +     domain->numa_node =3D dev_to_node(iommu->dev);
> > +     domain->amo_enabled =3D !!(iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD=
);
> > +
> > +     if (!domain->pgd_root) {
> > +             page =3D alloc_pages_node(domain->numa_node,
> > +                                     GFP_KERNEL_ACCOUNT | __GFP_ZERO, =
0);
> > +             if (!page)
> > +                     return -ENOMEM;
> > +             domain->pgd_root =3D (unsigned long)page_to_virt(page);
>
> The pgd_root should be allocated by the alloc_paging function, not
> during attach. There is no locking here that will protect against
> concurrent attach and also map before attach should work.
>
> You can pick up the numa affinity from the alloc paging dev pointer
> (note it may be null still in some cases)
>

Good point. Thanks. Will send update shortly with v3.

> Jason

Ack to all other comments, thank you!
Best,
- Tomasz
