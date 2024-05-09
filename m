Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A6130A65
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715238865; cv=none; b=aQ0kPTqJcqAPMBTvGcXbCFQz/IdExKFZTbFAFET3J6okZIdsPTy2e0lnY/OSv8Ckhi43ktZRS4rJvPkWff+oBEkkDwPt5VnErWMaXBhsH3PGsgsew7p/bA1mMgTUbL6DmOqi+SnNOKl1RZOFYYV0Yeg0HFbO69MTAKQzrn5rlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715238865; c=relaxed/simple;
	bh=pRAdeURYjGBfECglCoyb7AsR8c6sN21zXC0/EujyyCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTlrB1cBpS0bLQJI4QV9x5erBYaNwUEpl/mu7yh/FONonLi7j2jx2UIGTE+nJ2MivnvNMZ+sOkhx/gA1jwu06iGEp5N2ytL3x//uPuWw7p+p+XEk7Er9wJ6escc/KylqeCkcDBNl3uZrGKjzFJtJ3WHAxWTm30iOz5Hx6D4K+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Kfc1qBeQ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kfc1qBeQ"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e17b4357a6so22772539f.3
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715238862; x=1715843662; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBN9pPMdddwoIcplA8VvxvHJrWLbiPNGjyCnBGQ4lvk=;
        b=Kfc1qBeQTaEOAzcy1g87E9M8qucBWhksFyq0whIvpZu9h6+Nn4xnEqAOC/sjlu++6X
         yltxa6r+kHZvIoaWEYnh+XL1FNL9rBA5E23IIjdnUvQVrT2AnOcMx/bTSYYBE9ZzMQJK
         BJu+Op8tUvu70GsJeblJlTkdkiDNS/WaZqON34DoJxcEk95YH28YWCh6oBMazlFcr1bw
         fhU19xtKg+AERIrfJs8G9uHG/tMRmBCu7gYFqcCC87qsBbdful0CcUyUWFgZbueJ7yXI
         xEQMgxZ74jQ5nDTwvruFvowC3eZ8fFdEydLwTfw+igWWaFZjiDO8XLBy7yU/23X1u0+z
         VJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715238862; x=1715843662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBN9pPMdddwoIcplA8VvxvHJrWLbiPNGjyCnBGQ4lvk=;
        b=V0sQdxqGMWrAFQRp8UzUje9TUYszNAE9bOdruWQS5y2UDmW9qrHPAucOtI5m7NYyGd
         Vobk26IF2ylshjvMkuu8qvUfdgj6bov1yW8/se/isZFps6muvpmgurYsL1JEcmtC2j0Z
         8q0DvONf4CKIy7HqYx8yVKPeNzbbf4DE/kWOsIYiWLvFBfLseqF9JA/DjXefGJfuwYSb
         LuWAwitr1h6pkvTqMuI1/biYcwznityKdf69o+zxQBR9Nk1/Oc4cuNdT28oUcU0W6XC2
         KL23CgDG6K4QKq5wspSXWmxXlunaGII1bz9MZrprX4rNyxYYUxJumpebyV6q2NKd0wlO
         nT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP0qSK0sLbpCxLYjhDqnu0kPEEAo+gQGlHfCMrv8wR6dkpFoB9z9Nr04VkMZT1rvOGX+MubrA8u9L6TuLdnrnUn/RNCGg=
X-Gm-Message-State: AOJu0YxvobzeYnqR1paYu8MMxuaYCwn/Zk1zzdOb4NBBWylzLb8Qh54k
	gEgjjonzWUGyx2FgBI4O8ku5fS2nwUdPUH1HMrL/xt+SYqm64A3woNjU59DcuV6KSZA6VyT2JFL
	WjV9trkRa/BrwntZ9E2HRofYAXHpnux4nWLpgHg==
X-Google-Smtp-Source: AGHT+IGxmDFn4qJlnU8RB3g4fWoeAIPJL8F88zj43OLKN/aUuw9ozP0pwwUqlSxRTT/ymdLcXwVNjO+/k9pPuDsMg7I=
X-Received: by 2002:a5e:da48:0:b0:7d5:e3c3:e771 with SMTP id
 ca18e2360f4ac-7e18fd4bdf4mr529562739f.8.1715238862061; Thu, 09 May 2024
 00:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714752293.git.tjeznach@rivosinc.com> <1cda67ed73f0a1d5cb906b3692a90ab35416f2ba.1714752293.git.tjeznach@rivosinc.com>
 <CANXhq0o7X+sp4YgRHR_G11XHPy55_TEiNiO4z1NMt2v8toxk_Q@mail.gmail.com> <CAH2o1u4v-ubRhrxfxer9=Z7X-G5ihPQ6BJRo=jOfnvh8PTF4fA@mail.gmail.com>
In-Reply-To: <CAH2o1u4v-ubRhrxfxer9=Z7X-G5ihPQ6BJRo=jOfnvh8PTF4fA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 9 May 2024 15:14:11 +0800
Message-ID: <CANXhq0oXxNYb_Gaq228bZetb4xSEpBn+BwaCnW-8sJX52s9sxg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 12:13=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> On Wed, May 8, 2024 at 8:57=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
> >
> > On Sat, May 4, 2024 at 12:13=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> > >
> > > Introduce first-stage address translation support.
> > >
> > > Page table configured by the IOMMU driver will use the highest mode
> > > implemented by the hardware, unless not known at the domain allocatio=
n
> > > time falling back to the CPU=E2=80=99s MMU page mode.
> > >
> > > This change introduces IOTINVAL.VMA command, required to invalidate
> > > any cached IOATC entries after mapping is updated and/or removed from
> > > the paging domain.  Invalidations for the non-leaf page entries use
> > > IOTINVAL for all addresses assigned to the protection domain for
> > > hardware not supporting more granular non-leaf page table cache
> > > invalidations.
> > >
> > > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > > ---
> > >  drivers/iommu/riscv/iommu.c | 587 ++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 585 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.=
c
> > > index 4349ac8a3990..ec701fde520f 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -41,6 +41,10 @@
> > >  #define dev_to_iommu(dev) \
> > >         iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
> > >
> > > +/* IOMMU PSCID allocation namespace. */
> > > +static DEFINE_IDA(riscv_iommu_pscids);
> > > +#define RISCV_IOMMU_MAX_PSCID          (BIT(20) - 1)
> > > +
> > >  /* Device resource-managed allocations */
> > >  struct riscv_iommu_devres {
> > >         void *addr;
> > > @@ -766,6 +770,143 @@ static int riscv_iommu_iodir_set_mode(struct ri=
scv_iommu_device *iommu,
> > >         return 0;
> > >  }
> > >
> > > +/* This struct contains protection domain specific IOMMU driver data=
. */
> > > +struct riscv_iommu_domain {
> > > +       struct iommu_domain domain;
> > > +       struct list_head bonds;
> > > +       spinlock_t lock;                /* protect bonds list updates=
. */
> > > +       int pscid;
> > > +       int numa_node;
> > > +       int amo_enabled:1;
> > > +       unsigned int pgd_mode;
> > > +       unsigned long *pgd_root;
> > > +};
> > > +
> > > +#define iommu_domain_to_riscv(iommu_domain) \
> > > +       container_of(iommu_domain, struct riscv_iommu_domain, domain)
> > > +
> > > +/* Private IOMMU data for managed devices, dev_iommu_priv_* */
> > > +struct riscv_iommu_info {
> > > +       struct riscv_iommu_domain *domain;
> > > +};
> > > +
> > > +/* Linkage between an iommu_domain and attached devices. */
> > > +struct riscv_iommu_bond {
> > > +       struct list_head list;
> > > +       struct rcu_head rcu;
> > > +       struct device *dev;
> > > +};
> > > +
> > > +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> > > +                                struct device *dev)
> > > +{
> > > +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > > +       struct riscv_iommu_bond *bond;
> > > +       struct list_head *bonds;
> > > +
> > > +       bond =3D kzalloc(sizeof(*bond), GFP_KERNEL);
> > > +       if (!bond)
> > > +               return -ENOMEM;
> > > +       bond->dev =3D dev;
> > > +
> > > +       /*
> > > +        * Linked device pointer and iommu data remain stable in bond=
 struct
> > > +        * as long the device is attached to the managed IOMMU at _pr=
obe_device(),
> > > +        * up to completion of _release_device() call. Release of the=
 bond will be
> > > +        * synchronized at the device release, to guarantee no stale =
pointer is
> > > +        * used inside rcu protected sections.
> > > +        *
> > > +        * List of devices attached to the domain is arranged based o=
n
> > > +        * managed IOMMU device.
> > > +        */
> > > +
> > > +       spin_lock(&domain->lock);
> > > +       list_for_each_rcu(bonds, &domain->bonds)
> > > +               if (dev_to_iommu(list_entry(bonds, struct riscv_iommu=
_bond, list)->dev) =3D=3D iommu)
> > > +                       break;
> > > +       list_add_rcu(&bond->list, bonds);
> > > +       spin_unlock(&domain->lock);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domai=
n,
> > > +                                   struct device *dev)
> > > +{
> > > +       struct riscv_iommu_bond *bond, *found =3D NULL;
> > > +
> > > +       if (!domain)
> > > +               return;
> > > +
> > > +       spin_lock(&domain->lock);
> > > +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > +               if (bond->dev =3D=3D dev) {
> > > +                       list_del_rcu(&bond->list);
> > > +                       found =3D bond;
> > > +               }
> > > +       }
> > > +       spin_unlock(&domain->lock);
> > > +       kfree_rcu(found, rcu);
> > > +}
> > > +
> > > +/*
> > > + * Send IOTLB.INVAL for whole address space for ranges larger than 2=
MB.
> > > + * This limit will be replaced with range invalidations, if supporte=
d by
> > > + * the hardware, when RISC-V IOMMU architecture specification update=
 for
> > > + * range invalidations update will be available.
> > > + */
> > > +#define RISCV_IOMMU_IOTLB_INVAL_LIMIT  (2 << 20)
> > > +
> > > +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domai=
n,
> > > +                                   unsigned long start, unsigned lon=
g end)
> > > +{
> > > +       struct riscv_iommu_bond *bond;
> > > +       struct riscv_iommu_device *iommu, *prev;
> > > +       struct riscv_iommu_command cmd;
> > > +       unsigned long len =3D end - start + 1;
> > > +       unsigned long iova;
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       prev =3D NULL;
> > > +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > +               iommu =3D dev_to_iommu(bond->dev);
> > > +
> > > +               /*
> > > +                * IOTLB invalidation request can be safely omitted i=
f already sent
> > > +                * to the IOMMU for the same PSCID, and with domain->=
bonds list
> > > +                * arranged based on the device's IOMMU, it's suffici=
ent to check
> > > +                * last device the invalidation was sent to.
> > > +                */
> > > +               if (iommu =3D=3D prev)
> > > +                       continue;
> > > +
> > > +               riscv_iommu_cmd_inval_vma(&cmd);
> > > +               riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > > +               if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > > +                       for (iova =3D start; iova < end; iova +=3D PA=
GE_SIZE) {
> > > +                               riscv_iommu_cmd_inval_set_addr(&cmd, =
iova);
> > > +                               riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +                       }
> > > +               } else {
> > > +                       riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +               }
> > > +               prev =3D iommu;
> > > +       }
> > > +
> > > +       prev =3D NULL;
> > > +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > +               iommu =3D dev_to_iommu(bond->dev);
> > > +               if (iommu =3D=3D prev)
> > > +                       continue;
> > > +
> > > +               riscv_iommu_cmd_iofence(&cmd);
> >
> > I was wondering why we need many 'iofence' commands following
> > invalidation commands. Could we just use one iofence to guarantees
> > that all previous invalidation commands have been completed?
> >
>
> Unless I'm missing something, this code should send only one IOFENCE.C
> command send per IOMMU device. If there are multiple IOMMU devices
> involved in the invalidation sequence, we have to wait for all of the
> invalidation commands to complete, as there is no synchronization
> mechanism between those independent IOMMUs.
>

Sorry for confusing, I guess I need to rephrase my question. Is it
possible that the iommu devices of each device in bonds list are
interlaced? For instance, iommu device A -> iommu device B -> iommu
device A -> iommu device B. I was wondering if we need to consider
this situation and try to ignore second iofence for the repeating
iommu device, or actually, this situation won't occur.

> > > +               riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_T=
IMEOUT);
> > > +               prev =3D iommu;
> > > +       }
> > > +       rcu_read_unlock();
> > > +}
> > > +
> > >  #define RISCV_IOMMU_FSC_BARE 0
> > >
> > >  /*
> > > @@ -785,10 +926,29 @@ static void riscv_iommu_iodir_update(struct ris=
cv_iommu_device *iommu,
> > >  {
> > >         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > >         struct riscv_iommu_dc *dc;
> > > +       struct riscv_iommu_command cmd;
> > > +       bool sync_required =3D false;
> > >         u64 tc;
> > >         int i;
> > >
> > > -       /* Device context invalidation ignored for now. */
> > > +       for (i =3D 0; i < fwspec->num_ids; i++) {
> > > +               dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> > > +               tc =3D READ_ONCE(dc->tc);
> > > +               if (tc & RISCV_IOMMU_DC_TC_V) {
> > > +                       WRITE_ONCE(dc->tc, tc & ~RISCV_IOMMU_DC_TC_V)=
;
> > > +
> > > +                       /* Invalidate device context cached values */
> > > +                       riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> > > +                       riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->i=
ds[i]);
> > > +                       riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +                       sync_required =3D true;
> > > +               }
> > > +       }
> > > +
> > > +       if (sync_required) {
> > > +               riscv_iommu_cmd_iofence(&cmd);
> > > +               riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVA=
L_TIMEOUT);
> > > +       }
> > >
> > >         /*
> > >          * For device context with DC_TC_PDTV =3D 0, translation attr=
ibutes valid bit
> > > @@ -806,12 +966,415 @@ static void riscv_iommu_iodir_update(struct ri=
scv_iommu_device *iommu,
> > >         }
> > >  }
> > >
> > > +/*
> > > + * IOVA page translation tree management.
> > > + */
> > > +
> > > +#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
> > > +#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
> > > +#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
> > > +#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
> > > +
> > > +#define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
> > > +
> > > +static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_d=
omain)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +
> > > +       riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> > > +}
> > > +
> > > +static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain=
,
> > > +                                  struct iommu_iotlb_gather *gather)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +
> > > +       riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
> > > +}
> > > +
> > > +static inline size_t get_page_size(size_t size)
> > > +{
> > > +       if (size >=3D IOMMU_PAGE_SIZE_512G)
> > > +               return IOMMU_PAGE_SIZE_512G;
> > > +       if (size >=3D IOMMU_PAGE_SIZE_1G)
> > > +               return IOMMU_PAGE_SIZE_1G;
> > > +       if (size >=3D IOMMU_PAGE_SIZE_2M)
> > > +               return IOMMU_PAGE_SIZE_2M;
> > > +       return IOMMU_PAGE_SIZE_4K;
> > > +}
> > > +
> > > +#define _io_pte_present(pte)   ((pte) & (_PAGE_PRESENT | _PAGE_PROT_=
NONE))
> > > +#define _io_pte_leaf(pte)      ((pte) & _PAGE_LEAF)
> > > +#define _io_pte_none(pte)      ((pte) =3D=3D 0)
> > > +#define _io_pte_entry(pn, prot)        ((_PAGE_PFN_MASK & ((pn) << _=
PAGE_PFN_SHIFT)) | (prot))
> > > +
> > > +static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> > > +                                unsigned long pte, struct list_head =
*freelist)
> > > +{
> > > +       unsigned long *ptr;
> > > +       int i;
> > > +
> > > +       if (!_io_pte_present(pte) || _io_pte_leaf(pte))
> > > +               return;
> > > +
> > > +       ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
> > > +
> > > +       /* Recursively free all sub page table pages */
> > > +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> > > +               pte =3D READ_ONCE(ptr[i]);
> > > +               if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pt=
e, 0) =3D=3D pte)
> > > +                       riscv_iommu_pte_free(domain, pte, freelist);
> > > +       }
> > > +
> > > +       if (freelist)
> > > +               list_add_tail(&virt_to_page(ptr)->lru, freelist);
> > > +       else
> > > +               iommu_free_page(ptr);
> > > +}
> > > +
> > > +static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domai=
n *domain,
> > > +                                           unsigned long iova, size_=
t pgsize,
> > > +                                           gfp_t gfp)
> > > +{
> > > +       unsigned long *ptr =3D domain->pgd_root;
> > > +       unsigned long pte, old;
> > > +       int level =3D domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MO=
DE_SV39 + 2;
> > > +       void *addr;
> > > +
> > > +       do {
> > > +               const int shift =3D PAGE_SHIFT + PT_SHIFT * level;
> > > +
> > > +               ptr +=3D ((iova >> shift) & (PTRS_PER_PTE - 1));
> > > +               /*
> > > +                * Note: returned entry might be a non-leaf if there =
was
> > > +                * existing mapping with smaller granularity. Up to t=
he caller
> > > +                * to replace and invalidate.
> > > +                */
> > > +               if (((size_t)1 << shift) =3D=3D pgsize)
> > > +                       return ptr;
> > > +pte_retry:
> > > +               pte =3D READ_ONCE(*ptr);
> > > +               /*
> > > +                * This is very likely incorrect as we should not be =
adding
> > > +                * new mapping with smaller granularity on top
> > > +                * of existing 2M/1G mapping. Fail.
> > > +                */
> > > +               if (_io_pte_present(pte) && _io_pte_leaf(pte))
> > > +                       return NULL;
> > > +               /*
> > > +                * Non-leaf entry is missing, allocate and try to add=
 to the
> > > +                * page table. This might race with other mappings, r=
etry.
> > > +                */
> > > +               if (_io_pte_none(pte)) {
> > > +                       addr =3D iommu_alloc_page_node(domain->numa_n=
ode, gfp);
> > > +                       if (!addr)
> > > +                               return NULL;
> > > +                       old =3D pte;
> > > +                       pte =3D _io_pte_entry(virt_to_pfn(addr), _PAG=
E_TABLE);
> > > +                       if (cmpxchg_relaxed(ptr, old, pte) !=3D old) =
{
> > > +                               iommu_free_page(addr);
> > > +                               goto pte_retry;
> > > +                       }
> > > +               }
> > > +               ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pf=
n(pte));
> > > +       } while (level-- > 0);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domai=
n *domain,
> > > +                                           unsigned long iova, size_=
t *pte_pgsize)
> > > +{
> > > +       unsigned long *ptr =3D domain->pgd_root;
> > > +       unsigned long pte;
> > > +       int level =3D domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MO=
DE_SV39 + 2;
> > > +
> > > +       do {
> > > +               const int shift =3D PAGE_SHIFT + PT_SHIFT * level;
> > > +
> > > +               ptr +=3D ((iova >> shift) & (PTRS_PER_PTE - 1));
> > > +               pte =3D READ_ONCE(*ptr);
> > > +               if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
> > > +                       *pte_pgsize =3D (size_t)1 << shift;
> > > +                       return ptr;
> > > +               }
> > > +               if (_io_pte_none(pte))
> > > +                       return NULL;
> > > +               ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pf=
n(pte));
> > > +       } while (level-- > 0);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
> > > +                                unsigned long iova, phys_addr_t phys=
,
> > > +                                size_t pgsize, size_t pgcount, int p=
rot,
> > > +                                gfp_t gfp, size_t *mapped)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +       size_t size =3D 0;
> > > +       size_t page_size =3D get_page_size(pgsize);
> > > +       unsigned long *ptr;
> > > +       unsigned long pte, old, pte_prot;
> > > +       int rc =3D 0;
> > > +       LIST_HEAD(freelist);
> > > +
> > > +       if (!(prot & IOMMU_WRITE))
> > > +               pte_prot =3D _PAGE_BASE | _PAGE_READ;
> > > +       else if (domain->amo_enabled)
> > > +               pte_prot =3D _PAGE_BASE | _PAGE_READ | _PAGE_WRITE;
> > > +       else
> > > +               pte_prot =3D _PAGE_BASE | _PAGE_READ | _PAGE_WRITE | =
_PAGE_DIRTY;
> > > +
> > > +       while (pgcount) {
> > > +               ptr =3D riscv_iommu_pte_alloc(domain, iova, page_size=
, gfp);
> > > +               if (!ptr) {
> > > +                       rc =3D -ENOMEM;
> > > +                       break;
> > > +               }
> > > +
> > > +               old =3D READ_ONCE(*ptr);
> > > +               pte =3D _io_pte_entry(phys_to_pfn(phys), pte_prot);
> > > +               if (cmpxchg_relaxed(ptr, old, pte) !=3D old)
> > > +                       continue;
> > > +
> > > +               riscv_iommu_pte_free(domain, old, &freelist);
> > > +
> > > +               size +=3D page_size;
> > > +               iova +=3D page_size;
> > > +               phys +=3D page_size;
> > > +               --pgcount;
> > > +       }
> > > +
> > > +       *mapped =3D size;
> > > +
> > > +       if (!list_empty(&freelist)) {
> > > +               /*
> > > +                * In 1.0 spec version, the smallest scope we can use=
 to
> > > +                * invalidate all levels of page table (i.e. leaf and=
 non-leaf)
> > > +                * is an invalidate-all-PSCID IOTINVAL.VMA with AV=3D=
0.
> > > +                * This will be updated with hardware support for
> > > +                * capability.NL (non-leaf) IOTINVAL command.
> > > +                */
> > > +               riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> > > +               iommu_put_pages_list(&freelist);
> > > +       }
> > > +
> > > +       return rc;
> > > +}
> > > +
> > > +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_dom=
ain,
> > > +                                     unsigned long iova, size_t pgsi=
ze,
> > > +                                     size_t pgcount,
> > > +                                     struct iommu_iotlb_gather *gath=
er)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +       size_t size =3D pgcount << __ffs(pgsize);
> > > +       unsigned long *ptr, old;
> > > +       size_t unmapped =3D 0;
> > > +       size_t pte_size;
> > > +
> > > +       while (unmapped < size) {
> > > +               ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size=
);
> > > +               if (!ptr)
> > > +                       return unmapped;
> > > +
> > > +               /* partial unmap is not allowed, fail. */
> > > +               if (iova & (pte_size - 1))
> > > +                       return unmapped;
> > > +
> > > +               old =3D READ_ONCE(*ptr);
> > > +               if (cmpxchg_relaxed(ptr, old, 0) !=3D old)
> > > +                       continue;
> > > +
> > > +               iommu_iotlb_gather_add_page(&domain->domain, gather, =
iova,
> > > +                                           pte_size);
> > > +
> > > +               iova +=3D pte_size;
> > > +               unmapped +=3D pte_size;
> > > +       }
> > > +
> > > +       return unmapped;
> > > +}
> > > +
> > > +static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iom=
mu_domain,
> > > +                                           dma_addr_t iova)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +       unsigned long pte_size;
> > > +       unsigned long *ptr;
> > > +
> > > +       ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
> > > +       if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> > > +               return 0;
> > > +
> > > +       return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_si=
ze - 1));
> > > +}
> > > +
> > > +static void riscv_iommu_free_paging_domain(struct iommu_domain *iomm=
u_domain)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +       const unsigned long pfn =3D virt_to_pfn(domain->pgd_root);
> > > +
> > > +       WARN_ON(!list_empty(&domain->bonds));
> > > +
> > > +       if ((int)domain->pscid > 0)
> > > +               ida_free(&riscv_iommu_pscids, domain->pscid);
> > > +
> > > +       riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE),=
 NULL);
> > > +       kfree(domain);
> > > +}
> > > +
> > > +static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iomm=
u, int pgd_mode)
> > > +{
> > > +       switch (pgd_mode) {
> > > +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> > > +               return iommu->caps & RISCV_IOMMU_CAP_S_SV39;
> > > +
> > > +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> > > +               return iommu->caps & RISCV_IOMMU_CAP_S_SV48;
> > > +
> > > +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> > > +               return iommu->caps & RISCV_IOMMU_CAP_S_SV57;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > > +static int riscv_iommu_attach_paging_domain(struct iommu_domain *iom=
mu_domain,
> > > +                                           struct device *dev)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > > +       u64 fsc, ta;
> > > +
> > > +       if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> > > +               return -ENODEV;
> > > +
> > > +       if (domain->numa_node =3D=3D NUMA_NO_NODE)
> > > +               domain->numa_node =3D dev_to_node(iommu->dev);
> > > +
> > > +       if (riscv_iommu_bond_link(domain, dev))
> > > +               return -ENOMEM;
> > > +
> > > +       /*
> > > +        * Invalidate PSCID.
> > > +        * This invalidation might be redundant if IOATC has been alr=
eady cleared,
> > > +        * however we are not keeping track for domains not linked to=
 a device.
> > > +        */
> > > +       riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> > > +
> > > +       fsc =3D FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode)=
 |
> > > +             FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->=
pgd_root));
> > > +       ta =3D FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> > > +            RISCV_IOMMU_PC_TA_V;
> > > +
> > > +       riscv_iommu_iodir_update(iommu, dev, fsc, ta);
> > > +       riscv_iommu_bond_unlink(info->domain, dev);
> >
> > Should we unlink bond before link it?
> >
>
> No. This will potentially result in missing mapping invalidation for
> previously attached (and still valid during
> riscv_iommu_iodir_update()) domain.

Okay, my original concern was that it would break the list in the old
domain, but I noticed that it will allocate a new bond instance for
the new domain. Thanks for clarifying.

>
> > > +       info->domain =3D domain;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct iommu_domain_ops riscv_iommu_paging_domain_ops =
=3D {
> > > +       .attach_dev =3D riscv_iommu_attach_paging_domain,
> > > +       .free =3D riscv_iommu_free_paging_domain,
> > > +       .map_pages =3D riscv_iommu_map_pages,
> > > +       .unmap_pages =3D riscv_iommu_unmap_pages,
> > > +       .iova_to_phys =3D riscv_iommu_iova_to_phys,
> > > +       .iotlb_sync =3D riscv_iommu_iotlb_sync,
> > > +       .flush_iotlb_all =3D riscv_iommu_iotlb_flush_all,
> > > +};
> > > +
> > > +static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct d=
evice *dev)
> > > +{
> > > +       struct riscv_iommu_domain *domain;
> > > +       struct riscv_iommu_device *iommu;
> > > +       unsigned int pgd_mode;
> > > +       int va_bits;
> > > +
> > > +       iommu =3D dev ? dev_to_iommu(dev) : NULL;
> > > +
> > > +       /*
> > > +        * In unlikely case when dev or iommu is not known, use syste=
m
> > > +        * SATP mode to configure paging domain radix tree depth.
> > > +        * Use highest available if actual IOMMU hardware capabilitie=
s
> > > +        * are known here.
> > > +        */
> > > +       if (!iommu) {
> > > +               pgd_mode =3D satp_mode >> SATP_MODE_SHIFT;
> > > +               va_bits =3D VA_BITS;
> > > +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV57) {
> > > +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57;
> > > +               va_bits =3D 57;
> > > +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV48) {
> > > +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48;
> > > +               va_bits =3D 48;
> > > +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV39) {
> > > +               pgd_mode =3D  RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39;
> > > +               va_bits =3D 39;
> > > +       } else {
> > > +               dev_err(dev, "cannot find supported page table mode\n=
");
> > > +               return ERR_PTR(-ENODEV);
> > > +       }
> > > +
> > > +       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > > +       if (!domain)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       INIT_LIST_HEAD_RCU(&domain->bonds);
> > > +       spin_lock_init(&domain->lock);
> > > +       domain->numa_node =3D NUMA_NO_NODE;
> > > +
> > > +       if (iommu) {
> > > +               domain->numa_node =3D dev_to_node(iommu->dev);
> > > +               domain->amo_enabled =3D !!(iommu->caps & RISCV_IOMMU_=
CAP_AMO_HWAD);
> > > +       }
> > > +
> > > +       domain->pgd_mode =3D pgd_mode;
> > > +       domain->pgd_root =3D iommu_alloc_page_node(domain->numa_node,
> > > +                                                GFP_KERNEL_ACCOUNT);
> > > +       if (!domain->pgd_root) {
> > > +               kfree(domain);
> > > +               return ERR_PTR(-ENOMEM);
> > > +       }
> > > +
> > > +       domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> > > +                                       RISCV_IOMMU_MAX_PSCID, GFP_KE=
RNEL);
> > > +       if (domain->pscid < 0) {
> > > +               iommu_free_page(domain->pgd_root);
> > > +               kfree(domain);
> > > +               return ERR_PTR(-ENOMEM);
> > > +       }
> > > +
> > > +       /*
> > > +        * Note: RISC-V Privilege spec mandates that virtual addresse=
s
> > > +        * need to be sign-extended, so if (VA_BITS - 1) is set, all
> > > +        * bits >=3D VA_BITS need to also be set or else we'll get a
> > > +        * page fault. However the code that creates the mappings
> > > +        * above us (e.g. iommu_dma_alloc_iova()) won't do that for u=
s
> > > +        * for now, so we'll end up with invalid virtual addresses
> > > +        * to map. As a workaround until we get this sorted out
> > > +        * limit the available virtual addresses to VA_BITS - 1.
> > > +        */
> > > +       domain->domain.geometry.aperture_start =3D 0;
> > > +       domain->domain.geometry.aperture_end =3D DMA_BIT_MASK(va_bits=
 - 1);
> > > +       domain->domain.geometry.force_aperture =3D true;
> > > +
> > > +       domain->domain.ops =3D &riscv_iommu_paging_domain_ops;
> > > +
> > > +       return &domain->domain;
> > > +}
> > > +
> > >  static int riscv_iommu_attach_blocking_domain(struct iommu_domain *i=
ommu_domain,
> > >                                               struct device *dev)
> > >  {
> > >         struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > >
> > >         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0)=
;
> > > +       riscv_iommu_bond_unlink(info->domain, dev);
> > > +       info->domain =3D NULL;
> > >
> > >         return 0;
> > >  }
> > > @@ -827,8 +1390,11 @@ static int riscv_iommu_attach_identity_domain(s=
truct iommu_domain *iommu_domain,
> > >                                               struct device *dev)
> > >  {
> > >         struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > >
> > >         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RI=
SCV_IOMMU_PC_TA_V);
> > > +       riscv_iommu_bond_unlink(info->domain, dev);
> > > +       info->domain =3D NULL;
> > >
> > >         return 0;
> > >  }
> > > @@ -842,7 +1408,7 @@ static struct iommu_domain riscv_iommu_identity_=
domain =3D {
> > >
> > >  static int riscv_iommu_device_domain_type(struct device *dev)
> > >  {
> > > -       return IOMMU_DOMAIN_IDENTITY;
> > > +       return 0;
> > >  }
> > >
> > >  static struct iommu_group *riscv_iommu_device_group(struct device *d=
ev)
> > > @@ -861,6 +1427,7 @@ static struct iommu_device *riscv_iommu_probe_de=
vice(struct device *dev)
> > >  {
> > >         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > >         struct riscv_iommu_device *iommu;
> > > +       struct riscv_iommu_info *info;
> > >         struct riscv_iommu_dc *dc;
> > >         u64 tc;
> > >         int i;
> > > @@ -895,17 +1462,33 @@ static struct iommu_device *riscv_iommu_probe_=
device(struct device *dev)
> > >                 WRITE_ONCE(dc->tc, tc);
> > >         }
> > >
> > > +       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > > +       if (!info)
> > > +               return ERR_PTR(-ENOMEM);
> > > +       dev_iommu_priv_set(dev, info);
> > > +
> > >         return &iommu->iommu;
> > >  }
> > >
> > > +static void riscv_iommu_release_device(struct device *dev)
> > > +{
> > > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > > +
> > > +       synchronize_rcu();
> > > +       kfree(info);
> > > +}
> > > +
> > >  static const struct iommu_ops riscv_iommu_ops =3D {
> > > +       .pgsize_bitmap =3D SZ_4K,
> > >         .of_xlate =3D riscv_iommu_of_xlate,
> > >         .identity_domain =3D &riscv_iommu_identity_domain,
> > >         .blocked_domain =3D &riscv_iommu_blocking_domain,
> > >         .release_domain =3D &riscv_iommu_blocking_domain,
> > > +       .domain_alloc_paging =3D riscv_iommu_alloc_paging_domain,
> > >         .def_domain_type =3D riscv_iommu_device_domain_type,
> > >         .device_group =3D riscv_iommu_device_group,
> > >         .probe_device =3D riscv_iommu_probe_device,
> > > +       .release_device =3D riscv_iommu_release_device,
> > >  };
> > >
> > >  static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > > --
> > > 2.34.1
> > >
>
> Best regards,
> - Tomasz
>
>
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
