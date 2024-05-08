Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB86D1B0
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184820; cv=none; b=u+XwUJfD+OW/OCxH7E/Od9z8WRtoJJzCxuZIMwwiCSdC12tlaI/LgPsVwGJTCaCgf/swLsIKJYKqHmR2KBYNU+RKxxg8Ji6CoqsMzsouDiVWNV3Y/TaQan9kHMzWOKorYSAt+V+T3A4eL9sl3GycAO8SOqYRnQJrZql+M9XgezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184820; c=relaxed/simple;
	bh=TQ0Rq+yJYVKCsPQsmkXEekC8IIEWGamvVw3+CAn/Meg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbEPRYsiwmVtjXVXKXlRXywkUtqwzK3vGPK1qxQpt062OR4xiV8KBUDCM1gozT0hiLS6VoNVq/bwvAG13kFPsv7BHpq97SsK2HMVU4WUDUXG5ygq75bqUKOWFPN8+Z/t/pw5vc1CK2GLF8T8esl8BLWON0i+hBjPR5uP/3WcwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dVk9kgrm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dVk9kgrm"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3340696a12.3
        for <iommu@lists.linux.dev>; Wed, 08 May 2024 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715184817; x=1715789617; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wzPZXPF08nXvL6NB4K6q2k6ZLhmnxMGN/g0egnkffQ=;
        b=dVk9kgrm/LZb9ZtxnCHPSgJF58LoJjSi6rLoepQQ7YiBKjaZJQ14mjIpS4ya6YsrdJ
         O45De9E/8vQ4xm43phQxRhjwmn9++7Kax+oFkjSDbIerb0JCDr5altC8FlZMp9PFnxx/
         wxWiGYxFtsoMobmU49GfKW2e7LMPczXAGb9mkhtMPWvcbFU/E8H2LnIAJx7Hh5ctGUvS
         jY4MbIondwWtPUgRd7c9fWV0K4TeryEMQsrg8/pdl1C3ID1suX0bHzmzUoMmwMRiYSBk
         Yc2+MGaNE9rXyZtHOdhldLlPntIHGKWMW2FMv6jBcEPJGTAJByDHeKHwnJQSQ5fjJLdR
         yBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715184817; x=1715789617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wzPZXPF08nXvL6NB4K6q2k6ZLhmnxMGN/g0egnkffQ=;
        b=OWvn13a+/M8KUWundAR7GM4yFgCtS1GYKrv9jCjfikcdgLACSdmndRRa2CqqnAgQJL
         EWtiBj+CIcv8wqAb8VLCXeXu+WsFguEGM+5svKm4LJKrkp15iTj+hNOAyPXadUHFq64X
         bDJpxVlePCLKj0Qsh20vrZLuMPSkDudBXKUXZh9PGtyJ9ISRlXs2+ljF4TBzmPfjJL5i
         Nz83eL+PKgrmA0IZx3p9ypZbmjaRaPNxQ95RR2eKocnLkvd+68S7FqDRmPFU7CU4XLGA
         qAAyJkr9252EhsfnWGpB26E0aUcOf9LoVtYlh9CbTerY+l6XtpEwxXi2May+6efs3xyl
         Cz/w==
X-Forwarded-Encrypted: i=1; AJvYcCVzpp1GPRV7tXqkviIUpsxPKnVZ8Dy/wPqql1hNvCDB4x2ATDVBSxHP5RgorYQxBWZgJBvEYsIkmH6D7jB/AW6u5JTcdEM=
X-Gm-Message-State: AOJu0YyFcv3MYaNQfpzXw0mjiHCfq1IztPlQipkMveYd4fWzm+tlKiHE
	TWHQ78bBdU7UQzDhO9kTudiF/4+yaxoIZdYqEarK9pmU1ik0A4nS2ZSE1c/kJV+FWdPV7t+YkX9
	RZHdNgiO7wbarPhMHxvSa0x83523gUZMt6cpWCw==
X-Google-Smtp-Source: AGHT+IGv7S6EkEp5Y+Vx9AsT/UwHAAMAVM2Tn8vsBIrWa6tAdjf96shNsB4A3y1Ph5K1VoPsReVmk7vGkM+e7lQHU/8=
X-Received: by 2002:a17:90a:dd90:b0:2b6:2079:c581 with SMTP id
 98e67ed59e1d1-2b62079cf4dmr2336836a91.32.1715184816519; Wed, 08 May 2024
 09:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714752293.git.tjeznach@rivosinc.com> <1cda67ed73f0a1d5cb906b3692a90ab35416f2ba.1714752293.git.tjeznach@rivosinc.com>
 <CANXhq0o7X+sp4YgRHR_G11XHPy55_TEiNiO4z1NMt2v8toxk_Q@mail.gmail.com>
In-Reply-To: <CANXhq0o7X+sp4YgRHR_G11XHPy55_TEiNiO4z1NMt2v8toxk_Q@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 8 May 2024 09:13:25 -0700
Message-ID: <CAH2o1u4v-ubRhrxfxer9=Z7X-G5ihPQ6BJRo=jOfnvh8PTF4fA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] iommu/riscv: Paging domain support
To: Zong Li <zong.li@sifive.com>
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

On Wed, May 8, 2024 at 8:57=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> On Sat, May 4, 2024 at 12:13=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc=
.com> wrote:
> >
> > Introduce first-stage address translation support.
> >
> > Page table configured by the IOMMU driver will use the highest mode
> > implemented by the hardware, unless not known at the domain allocation
> > time falling back to the CPU=E2=80=99s MMU page mode.
> >
> > This change introduces IOTINVAL.VMA command, required to invalidate
> > any cached IOATC entries after mapping is updated and/or removed from
> > the paging domain.  Invalidations for the non-leaf page entries use
> > IOTINVAL for all addresses assigned to the protection domain for
> > hardware not supporting more granular non-leaf page table cache
> > invalidations.
> >
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 587 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 585 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 4349ac8a3990..ec701fde520f 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -41,6 +41,10 @@
> >  #define dev_to_iommu(dev) \
> >         iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
> >
> > +/* IOMMU PSCID allocation namespace. */
> > +static DEFINE_IDA(riscv_iommu_pscids);
> > +#define RISCV_IOMMU_MAX_PSCID          (BIT(20) - 1)
> > +
> >  /* Device resource-managed allocations */
> >  struct riscv_iommu_devres {
> >         void *addr;
> > @@ -766,6 +770,143 @@ static int riscv_iommu_iodir_set_mode(struct risc=
v_iommu_device *iommu,
> >         return 0;
> >  }
> >
> > +/* This struct contains protection domain specific IOMMU driver data. =
*/
> > +struct riscv_iommu_domain {
> > +       struct iommu_domain domain;
> > +       struct list_head bonds;
> > +       spinlock_t lock;                /* protect bonds list updates. =
*/
> > +       int pscid;
> > +       int numa_node;
> > +       int amo_enabled:1;
> > +       unsigned int pgd_mode;
> > +       unsigned long *pgd_root;
> > +};
> > +
> > +#define iommu_domain_to_riscv(iommu_domain) \
> > +       container_of(iommu_domain, struct riscv_iommu_domain, domain)
> > +
> > +/* Private IOMMU data for managed devices, dev_iommu_priv_* */
> > +struct riscv_iommu_info {
> > +       struct riscv_iommu_domain *domain;
> > +};
> > +
> > +/* Linkage between an iommu_domain and attached devices. */
> > +struct riscv_iommu_bond {
> > +       struct list_head list;
> > +       struct rcu_head rcu;
> > +       struct device *dev;
> > +};
> > +
> > +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> > +                                struct device *dev)
> > +{
> > +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +       struct riscv_iommu_bond *bond;
> > +       struct list_head *bonds;
> > +
> > +       bond =3D kzalloc(sizeof(*bond), GFP_KERNEL);
> > +       if (!bond)
> > +               return -ENOMEM;
> > +       bond->dev =3D dev;
> > +
> > +       /*
> > +        * Linked device pointer and iommu data remain stable in bond s=
truct
> > +        * as long the device is attached to the managed IOMMU at _prob=
e_device(),
> > +        * up to completion of _release_device() call. Release of the b=
ond will be
> > +        * synchronized at the device release, to guarantee no stale po=
inter is
> > +        * used inside rcu protected sections.
> > +        *
> > +        * List of devices attached to the domain is arranged based on
> > +        * managed IOMMU device.
> > +        */
> > +
> > +       spin_lock(&domain->lock);
> > +       list_for_each_rcu(bonds, &domain->bonds)
> > +               if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_b=
ond, list)->dev) =3D=3D iommu)
> > +                       break;
> > +       list_add_rcu(&bond->list, bonds);
> > +       spin_unlock(&domain->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
> > +                                   struct device *dev)
> > +{
> > +       struct riscv_iommu_bond *bond, *found =3D NULL;
> > +
> > +       if (!domain)
> > +               return;
> > +
> > +       spin_lock(&domain->lock);
> > +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +               if (bond->dev =3D=3D dev) {
> > +                       list_del_rcu(&bond->list);
> > +                       found =3D bond;
> > +               }
> > +       }
> > +       spin_unlock(&domain->lock);
> > +       kfree_rcu(found, rcu);
> > +}
> > +
> > +/*
> > + * Send IOTLB.INVAL for whole address space for ranges larger than 2MB=
.
> > + * This limit will be replaced with range invalidations, if supported =
by
> > + * the hardware, when RISC-V IOMMU architecture specification update f=
or
> > + * range invalidations update will be available.
> > + */
> > +#define RISCV_IOMMU_IOTLB_INVAL_LIMIT  (2 << 20)
> > +
> > +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > +                                   unsigned long start, unsigned long =
end)
> > +{
> > +       struct riscv_iommu_bond *bond;
> > +       struct riscv_iommu_device *iommu, *prev;
> > +       struct riscv_iommu_command cmd;
> > +       unsigned long len =3D end - start + 1;
> > +       unsigned long iova;
> > +
> > +       rcu_read_lock();
> > +
> > +       prev =3D NULL;
> > +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +               iommu =3D dev_to_iommu(bond->dev);
> > +
> > +               /*
> > +                * IOTLB invalidation request can be safely omitted if =
already sent
> > +                * to the IOMMU for the same PSCID, and with domain->bo=
nds list
> > +                * arranged based on the device's IOMMU, it's sufficien=
t to check
> > +                * last device the invalidation was sent to.
> > +                */
> > +               if (iommu =3D=3D prev)
> > +                       continue;
> > +
> > +               riscv_iommu_cmd_inval_vma(&cmd);
> > +               riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > +               if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > +                       for (iova =3D start; iova < end; iova +=3D PAGE=
_SIZE) {
> > +                               riscv_iommu_cmd_inval_set_addr(&cmd, io=
va);
> > +                               riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +                       }
> > +               } else {
> > +                       riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +               }
> > +               prev =3D iommu;
> > +       }
> > +
> > +       prev =3D NULL;
> > +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +               iommu =3D dev_to_iommu(bond->dev);
> > +               if (iommu =3D=3D prev)
> > +                       continue;
> > +
> > +               riscv_iommu_cmd_iofence(&cmd);
>
> I was wondering why we need many 'iofence' commands following
> invalidation commands. Could we just use one iofence to guarantees
> that all previous invalidation commands have been completed?
>

Unless I'm missing something, this code should send only one IOFENCE.C
command send per IOMMU device. If there are multiple IOMMU devices
involved in the invalidation sequence, we have to wait for all of the
invalidation commands to complete, as there is no synchronization
mechanism between those independent IOMMUs.

> > +               riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIM=
EOUT);
> > +               prev =3D iommu;
> > +       }
> > +       rcu_read_unlock();
> > +}
> > +
> >  #define RISCV_IOMMU_FSC_BARE 0
> >
> >  /*
> > @@ -785,10 +926,29 @@ static void riscv_iommu_iodir_update(struct riscv=
_iommu_device *iommu,
> >  {
> >         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >         struct riscv_iommu_dc *dc;
> > +       struct riscv_iommu_command cmd;
> > +       bool sync_required =3D false;
> >         u64 tc;
> >         int i;
> >
> > -       /* Device context invalidation ignored for now. */
> > +       for (i =3D 0; i < fwspec->num_ids; i++) {
> > +               dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> > +               tc =3D READ_ONCE(dc->tc);
> > +               if (tc & RISCV_IOMMU_DC_TC_V) {
> > +                       WRITE_ONCE(dc->tc, tc & ~RISCV_IOMMU_DC_TC_V);
> > +
> > +                       /* Invalidate device context cached values */
> > +                       riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> > +                       riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids=
[i]);
> > +                       riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +                       sync_required =3D true;
> > +               }
> > +       }
> > +
> > +       if (sync_required) {
> > +               riscv_iommu_cmd_iofence(&cmd);
> > +               riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_=
TIMEOUT);
> > +       }
> >
> >         /*
> >          * For device context with DC_TC_PDTV =3D 0, translation attrib=
utes valid bit
> > @@ -806,12 +966,415 @@ static void riscv_iommu_iodir_update(struct risc=
v_iommu_device *iommu,
> >         }
> >  }
> >
> > +/*
> > + * IOVA page translation tree management.
> > + */
> > +
> > +#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
> > +#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
> > +#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
> > +#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
> > +
> > +#define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
> > +
> > +static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_dom=
ain)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +
> > +       riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> > +}
> > +
> > +static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
> > +                                  struct iommu_iotlb_gather *gather)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +
> > +       riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
> > +}
> > +
> > +static inline size_t get_page_size(size_t size)
> > +{
> > +       if (size >=3D IOMMU_PAGE_SIZE_512G)
> > +               return IOMMU_PAGE_SIZE_512G;
> > +       if (size >=3D IOMMU_PAGE_SIZE_1G)
> > +               return IOMMU_PAGE_SIZE_1G;
> > +       if (size >=3D IOMMU_PAGE_SIZE_2M)
> > +               return IOMMU_PAGE_SIZE_2M;
> > +       return IOMMU_PAGE_SIZE_4K;
> > +}
> > +
> > +#define _io_pte_present(pte)   ((pte) & (_PAGE_PRESENT | _PAGE_PROT_NO=
NE))
> > +#define _io_pte_leaf(pte)      ((pte) & _PAGE_LEAF)
> > +#define _io_pte_none(pte)      ((pte) =3D=3D 0)
> > +#define _io_pte_entry(pn, prot)        ((_PAGE_PFN_MASK & ((pn) << _PA=
GE_PFN_SHIFT)) | (prot))
> > +
> > +static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> > +                                unsigned long pte, struct list_head *f=
reelist)
> > +{
> > +       unsigned long *ptr;
> > +       int i;
> > +
> > +       if (!_io_pte_present(pte) || _io_pte_leaf(pte))
> > +               return;
> > +
> > +       ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
> > +
> > +       /* Recursively free all sub page table pages */
> > +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> > +               pte =3D READ_ONCE(ptr[i]);
> > +               if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte,=
 0) =3D=3D pte)
> > +                       riscv_iommu_pte_free(domain, pte, freelist);
> > +       }
> > +
> > +       if (freelist)
> > +               list_add_tail(&virt_to_page(ptr)->lru, freelist);
> > +       else
> > +               iommu_free_page(ptr);
> > +}
> > +
> > +static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain =
*domain,
> > +                                           unsigned long iova, size_t =
pgsize,
> > +                                           gfp_t gfp)
> > +{
> > +       unsigned long *ptr =3D domain->pgd_root;
> > +       unsigned long pte, old;
> > +       int level =3D domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE=
_SV39 + 2;
> > +       void *addr;
> > +
> > +       do {
> > +               const int shift =3D PAGE_SHIFT + PT_SHIFT * level;
> > +
> > +               ptr +=3D ((iova >> shift) & (PTRS_PER_PTE - 1));
> > +               /*
> > +                * Note: returned entry might be a non-leaf if there wa=
s
> > +                * existing mapping with smaller granularity. Up to the=
 caller
> > +                * to replace and invalidate.
> > +                */
> > +               if (((size_t)1 << shift) =3D=3D pgsize)
> > +                       return ptr;
> > +pte_retry:
> > +               pte =3D READ_ONCE(*ptr);
> > +               /*
> > +                * This is very likely incorrect as we should not be ad=
ding
> > +                * new mapping with smaller granularity on top
> > +                * of existing 2M/1G mapping. Fail.
> > +                */
> > +               if (_io_pte_present(pte) && _io_pte_leaf(pte))
> > +                       return NULL;
> > +               /*
> > +                * Non-leaf entry is missing, allocate and try to add t=
o the
> > +                * page table. This might race with other mappings, ret=
ry.
> > +                */
> > +               if (_io_pte_none(pte)) {
> > +                       addr =3D iommu_alloc_page_node(domain->numa_nod=
e, gfp);
> > +                       if (!addr)
> > +                               return NULL;
> > +                       old =3D pte;
> > +                       pte =3D _io_pte_entry(virt_to_pfn(addr), _PAGE_=
TABLE);
> > +                       if (cmpxchg_relaxed(ptr, old, pte) !=3D old) {
> > +                               iommu_free_page(addr);
> > +                               goto pte_retry;
> > +                       }
> > +               }
> > +               ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(=
pte));
> > +       } while (level-- > 0);
> > +
> > +       return NULL;
> > +}
> > +
> > +static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domain =
*domain,
> > +                                           unsigned long iova, size_t =
*pte_pgsize)
> > +{
> > +       unsigned long *ptr =3D domain->pgd_root;
> > +       unsigned long pte;
> > +       int level =3D domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE=
_SV39 + 2;
> > +
> > +       do {
> > +               const int shift =3D PAGE_SHIFT + PT_SHIFT * level;
> > +
> > +               ptr +=3D ((iova >> shift) & (PTRS_PER_PTE - 1));
> > +               pte =3D READ_ONCE(*ptr);
> > +               if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
> > +                       *pte_pgsize =3D (size_t)1 << shift;
> > +                       return ptr;
> > +               }
> > +               if (_io_pte_none(pte))
> > +                       return NULL;
> > +               ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(=
pte));
> > +       } while (level-- > 0);
> > +
> > +       return NULL;
> > +}
> > +
> > +static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
> > +                                unsigned long iova, phys_addr_t phys,
> > +                                size_t pgsize, size_t pgcount, int pro=
t,
> > +                                gfp_t gfp, size_t *mapped)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +       size_t size =3D 0;
> > +       size_t page_size =3D get_page_size(pgsize);
> > +       unsigned long *ptr;
> > +       unsigned long pte, old, pte_prot;
> > +       int rc =3D 0;
> > +       LIST_HEAD(freelist);
> > +
> > +       if (!(prot & IOMMU_WRITE))
> > +               pte_prot =3D _PAGE_BASE | _PAGE_READ;
> > +       else if (domain->amo_enabled)
> > +               pte_prot =3D _PAGE_BASE | _PAGE_READ | _PAGE_WRITE;
> > +       else
> > +               pte_prot =3D _PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _P=
AGE_DIRTY;
> > +
> > +       while (pgcount) {
> > +               ptr =3D riscv_iommu_pte_alloc(domain, iova, page_size, =
gfp);
> > +               if (!ptr) {
> > +                       rc =3D -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               old =3D READ_ONCE(*ptr);
> > +               pte =3D _io_pte_entry(phys_to_pfn(phys), pte_prot);
> > +               if (cmpxchg_relaxed(ptr, old, pte) !=3D old)
> > +                       continue;
> > +
> > +               riscv_iommu_pte_free(domain, old, &freelist);
> > +
> > +               size +=3D page_size;
> > +               iova +=3D page_size;
> > +               phys +=3D page_size;
> > +               --pgcount;
> > +       }
> > +
> > +       *mapped =3D size;
> > +
> > +       if (!list_empty(&freelist)) {
> > +               /*
> > +                * In 1.0 spec version, the smallest scope we can use t=
o
> > +                * invalidate all levels of page table (i.e. leaf and n=
on-leaf)
> > +                * is an invalidate-all-PSCID IOTINVAL.VMA with AV=3D0.
> > +                * This will be updated with hardware support for
> > +                * capability.NL (non-leaf) IOTINVAL command.
> > +                */
> > +               riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> > +               iommu_put_pages_list(&freelist);
> > +       }
> > +
> > +       return rc;
> > +}
> > +
> > +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domai=
n,
> > +                                     unsigned long iova, size_t pgsize=
,
> > +                                     size_t pgcount,
> > +                                     struct iommu_iotlb_gather *gather=
)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +       size_t size =3D pgcount << __ffs(pgsize);
> > +       unsigned long *ptr, old;
> > +       size_t unmapped =3D 0;
> > +       size_t pte_size;
> > +
> > +       while (unmapped < size) {
> > +               ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
> > +               if (!ptr)
> > +                       return unmapped;
> > +
> > +               /* partial unmap is not allowed, fail. */
> > +               if (iova & (pte_size - 1))
> > +                       return unmapped;
> > +
> > +               old =3D READ_ONCE(*ptr);
> > +               if (cmpxchg_relaxed(ptr, old, 0) !=3D old)
> > +                       continue;
> > +
> > +               iommu_iotlb_gather_add_page(&domain->domain, gather, io=
va,
> > +                                           pte_size);
> > +
> > +               iova +=3D pte_size;
> > +               unmapped +=3D pte_size;
> > +       }
> > +
> > +       return unmapped;
> > +}
> > +
> > +static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu=
_domain,
> > +                                           dma_addr_t iova)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +       unsigned long pte_size;
> > +       unsigned long *ptr;
> > +
> > +       ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
> > +       if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> > +               return 0;
> > +
> > +       return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size=
 - 1));
> > +}
> > +
> > +static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_=
domain)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +       const unsigned long pfn =3D virt_to_pfn(domain->pgd_root);
> > +
> > +       WARN_ON(!list_empty(&domain->bonds));
> > +
> > +       if ((int)domain->pscid > 0)
> > +               ida_free(&riscv_iommu_pscids, domain->pscid);
> > +
> > +       riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), N=
ULL);
> > +       kfree(domain);
> > +}
> > +
> > +static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu,=
 int pgd_mode)
> > +{
> > +       switch (pgd_mode) {
> > +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> > +               return iommu->caps & RISCV_IOMMU_CAP_S_SV39;
> > +
> > +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> > +               return iommu->caps & RISCV_IOMMU_CAP_S_SV48;
> > +
> > +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> > +               return iommu->caps & RISCV_IOMMU_CAP_S_SV57;
> > +       }
> > +       return false;
> > +}
> > +
> > +static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu=
_domain,
> > +                                           struct device *dev)
> > +{
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > +       u64 fsc, ta;
> > +
> > +       if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> > +               return -ENODEV;
> > +
> > +       if (domain->numa_node =3D=3D NUMA_NO_NODE)
> > +               domain->numa_node =3D dev_to_node(iommu->dev);
> > +
> > +       if (riscv_iommu_bond_link(domain, dev))
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * Invalidate PSCID.
> > +        * This invalidation might be redundant if IOATC has been alrea=
dy cleared,
> > +        * however we are not keeping track for domains not linked to a=
 device.
> > +        */
> > +       riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> > +
> > +       fsc =3D FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
> > +             FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pg=
d_root));
> > +       ta =3D FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> > +            RISCV_IOMMU_PC_TA_V;
> > +
> > +       riscv_iommu_iodir_update(iommu, dev, fsc, ta);
> > +       riscv_iommu_bond_unlink(info->domain, dev);
>
> Should we unlink bond before link it?
>

No. This will potentially result in missing mapping invalidation for
previously attached (and still valid during
riscv_iommu_iodir_update()) domain.

> > +       info->domain =3D domain;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct iommu_domain_ops riscv_iommu_paging_domain_ops =3D=
 {
> > +       .attach_dev =3D riscv_iommu_attach_paging_domain,
> > +       .free =3D riscv_iommu_free_paging_domain,
> > +       .map_pages =3D riscv_iommu_map_pages,
> > +       .unmap_pages =3D riscv_iommu_unmap_pages,
> > +       .iova_to_phys =3D riscv_iommu_iova_to_phys,
> > +       .iotlb_sync =3D riscv_iommu_iotlb_sync,
> > +       .flush_iotlb_all =3D riscv_iommu_iotlb_flush_all,
> > +};
> > +
> > +static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct dev=
ice *dev)
> > +{
> > +       struct riscv_iommu_domain *domain;
> > +       struct riscv_iommu_device *iommu;
> > +       unsigned int pgd_mode;
> > +       int va_bits;
> > +
> > +       iommu =3D dev ? dev_to_iommu(dev) : NULL;
> > +
> > +       /*
> > +        * In unlikely case when dev or iommu is not known, use system
> > +        * SATP mode to configure paging domain radix tree depth.
> > +        * Use highest available if actual IOMMU hardware capabilities
> > +        * are known here.
> > +        */
> > +       if (!iommu) {
> > +               pgd_mode =3D satp_mode >> SATP_MODE_SHIFT;
> > +               va_bits =3D VA_BITS;
> > +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV57) {
> > +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57;
> > +               va_bits =3D 57;
> > +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV48) {
> > +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48;
> > +               va_bits =3D 48;
> > +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV39) {
> > +               pgd_mode =3D  RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39;
> > +               va_bits =3D 39;
> > +       } else {
> > +               dev_err(dev, "cannot find supported page table mode\n")=
;
> > +               return ERR_PTR(-ENODEV);
> > +       }
> > +
> > +       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > +       if (!domain)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       INIT_LIST_HEAD_RCU(&domain->bonds);
> > +       spin_lock_init(&domain->lock);
> > +       domain->numa_node =3D NUMA_NO_NODE;
> > +
> > +       if (iommu) {
> > +               domain->numa_node =3D dev_to_node(iommu->dev);
> > +               domain->amo_enabled =3D !!(iommu->caps & RISCV_IOMMU_CA=
P_AMO_HWAD);
> > +       }
> > +
> > +       domain->pgd_mode =3D pgd_mode;
> > +       domain->pgd_root =3D iommu_alloc_page_node(domain->numa_node,
> > +                                                GFP_KERNEL_ACCOUNT);
> > +       if (!domain->pgd_root) {
> > +               kfree(domain);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> > +                                       RISCV_IOMMU_MAX_PSCID, GFP_KERN=
EL);
> > +       if (domain->pscid < 0) {
> > +               iommu_free_page(domain->pgd_root);
> > +               kfree(domain);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       /*
> > +        * Note: RISC-V Privilege spec mandates that virtual addresses
> > +        * need to be sign-extended, so if (VA_BITS - 1) is set, all
> > +        * bits >=3D VA_BITS need to also be set or else we'll get a
> > +        * page fault. However the code that creates the mappings
> > +        * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
> > +        * for now, so we'll end up with invalid virtual addresses
> > +        * to map. As a workaround until we get this sorted out
> > +        * limit the available virtual addresses to VA_BITS - 1.
> > +        */
> > +       domain->domain.geometry.aperture_start =3D 0;
> > +       domain->domain.geometry.aperture_end =3D DMA_BIT_MASK(va_bits -=
 1);
> > +       domain->domain.geometry.force_aperture =3D true;
> > +
> > +       domain->domain.ops =3D &riscv_iommu_paging_domain_ops;
> > +
> > +       return &domain->domain;
> > +}
> > +
> >  static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iom=
mu_domain,
> >                                               struct device *dev)
> >  {
> >         struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> >
> >         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> > +       riscv_iommu_bond_unlink(info->domain, dev);
> > +       info->domain =3D NULL;
> >
> >         return 0;
> >  }
> > @@ -827,8 +1390,11 @@ static int riscv_iommu_attach_identity_domain(str=
uct iommu_domain *iommu_domain,
> >                                               struct device *dev)
> >  {
> >         struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> >
> >         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISC=
V_IOMMU_PC_TA_V);
> > +       riscv_iommu_bond_unlink(info->domain, dev);
> > +       info->domain =3D NULL;
> >
> >         return 0;
> >  }
> > @@ -842,7 +1408,7 @@ static struct iommu_domain riscv_iommu_identity_do=
main =3D {
> >
> >  static int riscv_iommu_device_domain_type(struct device *dev)
> >  {
> > -       return IOMMU_DOMAIN_IDENTITY;
> > +       return 0;
> >  }
> >
> >  static struct iommu_group *riscv_iommu_device_group(struct device *dev=
)
> > @@ -861,6 +1427,7 @@ static struct iommu_device *riscv_iommu_probe_devi=
ce(struct device *dev)
> >  {
> >         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >         struct riscv_iommu_device *iommu;
> > +       struct riscv_iommu_info *info;
> >         struct riscv_iommu_dc *dc;
> >         u64 tc;
> >         int i;
> > @@ -895,17 +1462,33 @@ static struct iommu_device *riscv_iommu_probe_de=
vice(struct device *dev)
> >                 WRITE_ONCE(dc->tc, tc);
> >         }
> >
> > +       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > +       if (!info)
> > +               return ERR_PTR(-ENOMEM);
> > +       dev_iommu_priv_set(dev, info);
> > +
> >         return &iommu->iommu;
> >  }
> >
> > +static void riscv_iommu_release_device(struct device *dev)
> > +{
> > +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > +
> > +       synchronize_rcu();
> > +       kfree(info);
> > +}
> > +
> >  static const struct iommu_ops riscv_iommu_ops =3D {
> > +       .pgsize_bitmap =3D SZ_4K,
> >         .of_xlate =3D riscv_iommu_of_xlate,
> >         .identity_domain =3D &riscv_iommu_identity_domain,
> >         .blocked_domain =3D &riscv_iommu_blocking_domain,
> >         .release_domain =3D &riscv_iommu_blocking_domain,
> > +       .domain_alloc_paging =3D riscv_iommu_alloc_paging_domain,
> >         .def_domain_type =3D riscv_iommu_device_domain_type,
> >         .device_group =3D riscv_iommu_device_group,
> >         .probe_device =3D riscv_iommu_probe_device,
> > +       .release_device =3D riscv_iommu_release_device,
> >  };
> >
> >  static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > --
> > 2.34.1
> >

Best regards,
- Tomasz


> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
