Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2815E8C
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930311; cv=none; b=TXHLk6D+FQyZl6BbS2GyjDGQEj6lvdQ7UxzzgKwIz/HIyEBkO3bEBFSgIjnjv13AWbT0Be2ALez4LjaZTi6PbQ6bfmE2OfAiXPPNnF/U6g6NXz/MIdSIL8fY+gmVIczmJfJtGGF7lGR3Z/NU4cWQnyqtRLu4f51sv+RiC2SmKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930311; c=relaxed/simple;
	bh=w3ctF2kkXuAdtwBxTgVer99sFfT2TRblRo0scHkVfxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gofwm2RmXcdfocVQm62ryV2ZhkpxtqsJuWxMwCaGnfrPT3yK55qhxvCeDe+JtHMgQl+PkUIH/xh4i2c5rOFVM7M9AbgPwX0uu4wV+kkkaR1fBSsivIDB0V/m5jK8VRFNDV8tj1FL3+YgZPtZoctjIweEhYXj6u2VYnSvTefcGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NjEGWSgN; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NjEGWSgN"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e1ec659c40so102800039f.2
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715930308; x=1716535108; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+0KCira9mJWWTTjaioczmdnMR7NcDji1gszRUx7BWs=;
        b=NjEGWSgNawjz6byUYErBzfkvp/ixKv4BPfUjvqK7BcduBO2376kLqR75Jd4bqWjhYy
         nOJzFNz+okpZb45c9x+dfgGbrHlvzg/7YAB7cBfiM3OyU3e1HPQhb0YDzQdK2eqGKW0t
         5QggPjjNrm+l/1W7bDtHkv99rcovJPVSmcJcJAYkfKy77PWyA7vL8CogqOuTDe4Sl16u
         g3c3XLdzi94H7GrPzHWnZ9s0NBpC2xI3LBlaZakQajt5/EjCO/AV6O9Z3uAoKyvq8NF7
         LlOx5ipmp50jHsFteSe9x3PyMm3ysn3Rw1e63RRDA2mo3LDtTAAPizJmgiav202Eanjw
         j03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930308; x=1716535108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+0KCira9mJWWTTjaioczmdnMR7NcDji1gszRUx7BWs=;
        b=vf6g36grtW1C9wFc9Q+D90R0Tkim8vtpxGrvQRmCOaqiWLrpB0nRRv6m0p18YrKJx+
         Oa5yY9y8f/klAHWpNL0VHuG4FaZ4YAgGfa4oeYVt3JYXTDA5dColVSCSGmiPu4e85RXJ
         SXbknmvS8bOCr5oX8PhPEzl6+2EhP/JYOgt/0+1E3Rx9AooaFMR3GlSEDJlnjyFZiqo+
         iUexvVBWodeZGszfzfzkQ9STSfELett4XoNubrbdMwS7EPDIwq3s3PupNyRCIgg4RANa
         uUOebuR5TblS/JSAUVoFeI/CZUIdvhvhpf3VGG2E1JkRXCprgJnknPw510e3Q8juE8Qm
         8jWw==
X-Forwarded-Encrypted: i=1; AJvYcCXk+cLgdiNTKaieLmPyqKgnQ6vLGz0LnrnU3/400vcsosuHUca+iSlS+5Ck4wzE8joM0K58k4pAuvkQvEKhbWD5Iyro4GM=
X-Gm-Message-State: AOJu0YzCl7nbXynkdJfnLM7ZjVOA1OZKOa819/xmdVF83mWsd386Pt2R
	adCI/qFBgK80SLyOiWd4GEq7tJF8E1QXPzkTwpCN2lcMrtuuNP343Om22jaRgeeysr+tI3Kb2fN
	0w+bG9eg0DXRqE69sOGcjx9L/NXc7KjiRUqM/eQ==
X-Google-Smtp-Source: AGHT+IErN2ODMAVX/d0UbH311lwSj6Tc1MG2YmXZLrVGCGnLmPS8FlIDiPgArBu8bNqFcfVBTIkXOnUIllOE6qkm3sc=
X-Received: by 2002:a05:6602:27c1:b0:7e1:89ca:3b5d with SMTP id
 ca18e2360f4ac-7e1b51bdae1mr3037047839f.8.1715930307843; Fri, 17 May 2024
 00:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1715708679.git.tjeznach@rivosinc.com> <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>
In-Reply-To: <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 17 May 2024 15:18:17 +0800
Message-ID: <CANXhq0qTTxhNStzUhygy6tg=Muq6-a4DJonUs+i8KYhyteLnzQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 2:17=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> Introduce first-stage address translation support.
>
> Page table configured by the IOMMU driver will use the highest mode
> implemented by the hardware, unless not known at the domain allocation
> time falling back to the CPU=E2=80=99s MMU page mode.
>
> This change introduces IOTINVAL.VMA command, required to invalidate
> any cached IOATC entries after mapping is updated and/or removed from
> the paging domain.  Invalidations for the non-leaf page entries use
> IOTINVAL for all addresses assigned to the protection domain for
> hardware not supporting more granular non-leaf page table cache
> invalidations.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 635 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 632 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8666ea0517ee..766f644f67b6 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -41,6 +41,10 @@
>  #define dev_to_iommu(dev) \
>         iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
>
> +/* IOMMU PSCID allocation namespace. */
> +static DEFINE_IDA(riscv_iommu_pscids);
> +#define RISCV_IOMMU_MAX_PSCID          (BIT(20) - 1)
> +
>  /* Device resource-managed allocations */
>  struct riscv_iommu_devres {
>         void *addr;
> @@ -779,6 +783,197 @@ static int riscv_iommu_iodir_set_mode(struct riscv_=
iommu_device *iommu,
>         return 0;
>  }
>
> +/* This struct contains protection domain specific IOMMU driver data. */
> +struct riscv_iommu_domain {
> +       struct iommu_domain domain;
> +       struct list_head bonds;
> +       spinlock_t lock;                /* protect bonds list updates. */
> +       int pscid;
> +       int amo_enabled:1;
> +       int numa_node;
> +       unsigned int pgd_mode;
> +       unsigned long *pgd_root;
> +};
> +
> +#define iommu_domain_to_riscv(iommu_domain) \
> +       container_of(iommu_domain, struct riscv_iommu_domain, domain)
> +
> +/* Private IOMMU data for managed devices, dev_iommu_priv_* */
> +struct riscv_iommu_info {
> +       struct riscv_iommu_domain *domain;
> +};
> +
> +/*
> + * Linkage between an iommu_domain and attached devices.
> + *
> + * Protection domain requiring IOATC and DevATC translation cache invali=
dations,
> + * should be linked to attached devices using a riscv_iommu_bond structu=
re.
> + * Devices should be linked to the domain before first use and unlinked =
after
> + * the translations from the referenced protection domain can no longer =
be used.
> + * Blocking and identity domains are not tracked here, as the IOMMU hard=
ware
> + * does not cache negative and/or identity (BARE mode) translations, and=
 DevATC
> + * is disabled for those protection domains.
> + *
> + * The device pointer and IOMMU data remain stable in the bond struct af=
ter
> + * _probe_device() where it's attached to the managed IOMMU, up to the
> + * completion of the _release_device() call. The release of the bond str=
ucture
> + * is synchronized with the device release.
> + */
> +struct riscv_iommu_bond {
> +       struct list_head list;
> +       struct rcu_head rcu;
> +       struct device *dev;
> +};
> +
> +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> +                                struct device *dev)
> +{
> +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> +       struct riscv_iommu_bond *bond;
> +       struct list_head *bonds;
> +
> +       bond =3D kzalloc(sizeof(*bond), GFP_KERNEL);
> +       if (!bond)
> +               return -ENOMEM;
> +       bond->dev =3D dev;
> +
> +       /*
> +        * List of devices attached to the domain is arranged based on
> +        * managed IOMMU device.
> +        */
> +
> +       spin_lock(&domain->lock);
> +       list_for_each_rcu(bonds, &domain->bonds)
> +               if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bon=
d, list)->dev) =3D=3D iommu)
> +                       break;
> +       list_add_rcu(&bond->list, bonds);
> +       spin_unlock(&domain->lock);
> +
> +       /* Synchronize with riscv_iommu_iotlb_inval() sequence. See comme=
nt below. */
> +       smp_mb();
> +
> +       return 0;
> +}
> +
> +static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
> +                                   struct device *dev)
> +{
> +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> +       struct riscv_iommu_bond *bond, *found =3D NULL;
> +       struct riscv_iommu_command cmd;
> +       int count =3D 0;
> +
> +       if (!domain)
> +               return;
> +
> +       spin_lock(&domain->lock);
> +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +               if (found && count)
> +                       break;
> +               else if (bond->dev =3D=3D dev)
> +                       found =3D bond;
> +               else if (dev_to_iommu(bond->dev) =3D=3D iommu)
> +                       count++;
> +       }
> +       if (found)
> +               list_del_rcu(&found->list);
> +       spin_unlock(&domain->lock);
> +       kfree_rcu(found, rcu);
> +
> +       /*
> +        * If this was the last bond between this domain and the IOMMU
> +        * invalidate all cached entries for domain's PSCID.
> +        */
> +       if (!count) {
> +               riscv_iommu_cmd_inval_vma(&cmd);
> +               riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +               riscv_iommu_cmd_send(iommu, &cmd);
> +
> +               riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT)=
;
> +       }
> +}
> +
> +/*
> + * Send IOTLB.INVAL for whole address space for ranges larger than 2MB.
> + * This limit will be replaced with range invalidations, if supported by
> + * the hardware, when RISC-V IOMMU architecture specification update for
> + * range invalidations update will be available.
> + */
> +#define RISCV_IOMMU_IOTLB_INVAL_LIMIT  (2 << 20)
> +
> +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> +                                   unsigned long start, unsigned long en=
d)
> +{
> +       struct riscv_iommu_bond *bond;
> +       struct riscv_iommu_device *iommu, *prev;
> +       struct riscv_iommu_command cmd;
> +       unsigned long len =3D end - start + 1;
> +       unsigned long iova;
> +
> +       /*
> +        * For each IOMMU linked with this protection domain (via bonds->=
dev),
> +        * an IOTLB invaliation command will be submitted and executed.
> +        *
> +        * Possbile race with domain attach flow is handled by sequencing
> +        * bond creation - riscv_iommu_bond_link(), and device directory
> +        * update - riscv_iommu_iodir_update().
> +        *
> +        * PTE Update / IOTLB Inval           Device attach & directory u=
pdate
> +        * --------------------------         --------------------------
> +        * update page table entries          add dev to the bond list
> +        * FENCE RW,RW                        FENCE RW,RW
> +        * For all IOMMUs: (can be empty)     Update FSC/PSCID
> +        *   FENCE IOW,IOW                      FENCE IOW,IOW
> +        *   IOTLB.INVAL                        IODIR.INVAL
> +        *   IOFENCE.C
> +        *
> +        * If bond list is not updated with new device, directory context=
 will
> +        * be configured with already valid page table content. If an IOM=
MU is
> +        * linked to the protection domain it will receive invalidation
> +        * requests for updated page table entries.
> +        */
> +       smp_mb();
> +
> +       rcu_read_lock();
> +
> +       prev =3D NULL;
> +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +               iommu =3D dev_to_iommu(bond->dev);
> +
> +               /*
> +                * IOTLB invalidation request can be safely omitted if al=
ready sent
> +                * to the IOMMU for the same PSCID, and with domain->bond=
s list
> +                * arranged based on the device's IOMMU, it's sufficient =
to check
> +                * last device the invalidation was sent to.
> +                */
> +               if (iommu =3D=3D prev)
> +                       continue;
> +
> +               riscv_iommu_cmd_inval_vma(&cmd);
> +               riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +               if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> +                       for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> +                               riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> +                               riscv_iommu_cmd_send(iommu, &cmd);
> +                       }
> +               } else {
> +                       riscv_iommu_cmd_send(iommu, &cmd);
> +               }
> +               prev =3D iommu;
> +       }
> +
> +       prev =3D NULL;
> +       list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +               iommu =3D dev_to_iommu(bond->dev);
> +               if (iommu =3D=3D prev)
> +                       continue;
> +
> +               riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT)=
;
> +               prev =3D iommu;
> +       }
> +       rcu_read_unlock();
> +}
> +
>  #define RISCV_IOMMU_FSC_BARE 0
>
>  /*
> @@ -798,10 +993,28 @@ static void riscv_iommu_iodir_update(struct riscv_i=
ommu_device *iommu,
>  {
>         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>         struct riscv_iommu_dc *dc;
> +       struct riscv_iommu_command cmd;
> +       bool sync_required =3D false;
>         u64 tc;
>         int i;
>
> -       /* Device context invalidation ignored for now. */
> +       for (i =3D 0; i < fwspec->num_ids; i++) {
> +               dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> +               tc =3D READ_ONCE(dc->tc);
> +               if (tc & RISCV_IOMMU_DC_TC_V)
> +                       continue;
> +
> +               WRITE_ONCE(dc->tc, tc & ~RISCV_IOMMU_DC_TC_V);
> +
> +               /* Invalidate device context cached values */
> +               riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> +               riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> +               riscv_iommu_cmd_send(iommu, &cmd);
> +               sync_required =3D true;
> +       }
> +
> +       if (sync_required)
> +               riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT)=
;
>
>         /*
>          * For device context with DC_TC_PDTV =3D 0, translation attribut=
es valid bit
> @@ -820,12 +1033,406 @@ static void riscv_iommu_iodir_update(struct riscv=
_iommu_device *iommu,
>         }
>  }
>
> +/*
> + * IOVA page translation tree management.
> + */
> +
> +#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
> +#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
> +#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
> +#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
> +
> +#define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
> +
> +static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_domai=
n)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> +}
> +
> +static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
> +                                  struct iommu_iotlb_gather *gather)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
> +}
> +
> +static inline size_t get_page_size(size_t size)
> +{
> +       if (size >=3D IOMMU_PAGE_SIZE_512G)
> +               return IOMMU_PAGE_SIZE_512G;
> +       if (size >=3D IOMMU_PAGE_SIZE_1G)
> +               return IOMMU_PAGE_SIZE_1G;
> +       if (size >=3D IOMMU_PAGE_SIZE_2M)
> +               return IOMMU_PAGE_SIZE_2M;
> +       return IOMMU_PAGE_SIZE_4K;
> +}
> +
> +#define _io_pte_present(pte)   ((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE=
))
> +#define _io_pte_leaf(pte)      ((pte) & _PAGE_LEAF)
> +#define _io_pte_none(pte)      ((pte) =3D=3D 0)
> +#define _io_pte_entry(pn, prot)        ((_PAGE_PFN_MASK & ((pn) << _PAGE=
_PFN_SHIFT)) | (prot))
> +
> +static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> +                                unsigned long pte, struct list_head *fre=
elist)
> +{
> +       unsigned long *ptr;
> +       int i;
> +
> +       if (!_io_pte_present(pte) || _io_pte_leaf(pte))
> +               return;
> +
> +       ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
> +
> +       /* Recursively free all sub page table pages */
> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +               pte =3D READ_ONCE(ptr[i]);
> +               if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0=
) =3D=3D pte)
> +                       riscv_iommu_pte_free(domain, pte, freelist);
> +       }
> +
> +       if (freelist)
> +               list_add_tail(&virt_to_page(ptr)->lru, freelist);
> +       else
> +               iommu_free_page(ptr);
> +}
> +
> +static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *d=
omain,
> +                                           unsigned long iova, size_t pg=
size,
> +                                           gfp_t gfp)
> +{
> +       unsigned long *ptr =3D domain->pgd_root;
> +       unsigned long pte, old;
> +       int level =3D domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_S=
V39 + 2;
> +       void *addr;
> +
> +       do {
> +               const int shift =3D PAGE_SHIFT + PT_SHIFT * level;
> +
> +               ptr +=3D ((iova >> shift) & (PTRS_PER_PTE - 1));
> +               /*
> +                * Note: returned entry might be a non-leaf if there was
> +                * existing mapping with smaller granularity. Up to the c=
aller
> +                * to replace and invalidate.
> +                */
> +               if (((size_t)1 << shift) =3D=3D pgsize)
> +                       return ptr;
> +pte_retry:
> +               pte =3D READ_ONCE(*ptr);
> +               /*
> +                * This is very likely incorrect as we should not be addi=
ng
> +                * new mapping with smaller granularity on top
> +                * of existing 2M/1G mapping. Fail.
> +                */
> +               if (_io_pte_present(pte) && _io_pte_leaf(pte))
> +                       return NULL;
> +               /*
> +                * Non-leaf entry is missing, allocate and try to add to =
the
> +                * page table. This might race with other mappings, retry=
.
> +                */
> +               if (_io_pte_none(pte)) {
> +                       addr =3D iommu_alloc_page_node(domain->numa_node,=
 gfp);
> +                       if (!addr)
> +                               return NULL;
> +                       old =3D pte;
> +                       pte =3D _io_pte_entry(virt_to_pfn(addr), _PAGE_TA=
BLE);
> +                       if (cmpxchg_relaxed(ptr, old, pte) !=3D old) {
> +                               iommu_free_page(addr);
> +                               goto pte_retry;
> +                       }
> +               }
> +               ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pt=
e));
> +       } while (level-- > 0);
> +
> +       return NULL;
> +}
> +
> +static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domain *d=
omain,
> +                                           unsigned long iova, size_t *p=
te_pgsize)
> +{
> +       unsigned long *ptr =3D domain->pgd_root;
> +       unsigned long pte;
> +       int level =3D domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_S=
V39 + 2;
> +
> +       do {
> +               const int shift =3D PAGE_SHIFT + PT_SHIFT * level;
> +
> +               ptr +=3D ((iova >> shift) & (PTRS_PER_PTE - 1));
> +               pte =3D READ_ONCE(*ptr);
> +               if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
> +                       *pte_pgsize =3D (size_t)1 << shift;
> +                       return ptr;
> +               }
> +               if (_io_pte_none(pte))
> +                       return NULL;
> +               ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pt=
e));
> +       } while (level-- > 0);
> +
> +       return NULL;
> +}
> +
> +static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
> +                                unsigned long iova, phys_addr_t phys,
> +                                size_t pgsize, size_t pgcount, int prot,
> +                                gfp_t gfp, size_t *mapped)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       size_t size =3D 0;
> +       size_t page_size =3D get_page_size(pgsize);
> +       unsigned long *ptr;
> +       unsigned long pte, old, pte_prot;
> +       int rc =3D 0;
> +       LIST_HEAD(freelist);
> +
> +       if (!(prot & IOMMU_WRITE))
> +               pte_prot =3D _PAGE_BASE | _PAGE_READ;
> +       else if (domain->amo_enabled)
> +               pte_prot =3D _PAGE_BASE | _PAGE_READ | _PAGE_WRITE;
> +       else
> +               pte_prot =3D _PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _PAG=
E_DIRTY;
> +
> +       while (pgcount) {
> +               ptr =3D riscv_iommu_pte_alloc(domain, iova, page_size, gf=
p);
> +               if (!ptr) {
> +                       rc =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               old =3D READ_ONCE(*ptr);
> +               pte =3D _io_pte_entry(phys_to_pfn(phys), pte_prot);
> +               if (cmpxchg_relaxed(ptr, old, pte) !=3D old)
> +                       continue;
> +
> +               riscv_iommu_pte_free(domain, old, &freelist);
> +
> +               size +=3D page_size;
> +               iova +=3D page_size;
> +               phys +=3D page_size;
> +               --pgcount;
> +       }
> +
> +       *mapped =3D size;
> +
> +       if (!list_empty(&freelist)) {
> +               /*
> +                * In 1.0 spec version, the smallest scope we can use to
> +                * invalidate all levels of page table (i.e. leaf and non=
-leaf)
> +                * is an invalidate-all-PSCID IOTINVAL.VMA with AV=3D0.
> +                * This will be updated with hardware support for
> +                * capability.NL (non-leaf) IOTINVAL command.
> +                */
> +               riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
> +               iommu_put_pages_list(&freelist);
> +       }
> +
> +       return rc;
> +}
> +
> +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> +                                     unsigned long iova, size_t pgsize,
> +                                     size_t pgcount,
> +                                     struct iommu_iotlb_gather *gather)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       size_t size =3D pgcount << __ffs(pgsize);
> +       unsigned long *ptr, old;
> +       size_t unmapped =3D 0;
> +       size_t pte_size;
> +
> +       while (unmapped < size) {
> +               ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
> +               if (!ptr)
> +                       return unmapped;
> +
> +               /* partial unmap is not allowed, fail. */
> +               if (iova & (pte_size - 1))
> +                       return unmapped;
> +
> +               old =3D READ_ONCE(*ptr);
> +               if (cmpxchg_relaxed(ptr, old, 0) !=3D old)
> +                       continue;
> +
> +               iommu_iotlb_gather_add_page(&domain->domain, gather, iova=
,
> +                                           pte_size);
> +
> +               iova +=3D pte_size;
> +               unmapped +=3D pte_size;
> +       }
> +
> +       return unmapped;
> +}
> +
> +static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_d=
omain,
> +                                           dma_addr_t iova)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       unsigned long pte_size;
> +       unsigned long *ptr;
> +
> +       ptr =3D riscv_iommu_pte_fetch(domain, iova, &pte_size);
> +       if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +               return 0;
> +
> +       return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size -=
 1));
> +}
> +
> +static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_do=
main)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       const unsigned long pfn =3D virt_to_pfn(domain->pgd_root);
> +
> +       WARN_ON(!list_empty(&domain->bonds));
> +
> +       if ((int)domain->pscid > 0)
> +               ida_free(&riscv_iommu_pscids, domain->pscid);
> +
> +       riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NUL=
L);
> +       kfree(domain);
> +}
> +
> +static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, i=
nt pgd_mode)
> +{
> +       switch (pgd_mode) {
> +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> +               return iommu->caps & RISCV_IOMMU_CAP_S_SV39;
> +
> +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> +               return iommu->caps & RISCV_IOMMU_CAP_S_SV48;
> +
> +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> +               return iommu->caps & RISCV_IOMMU_CAP_S_SV57;
> +       }
> +       return false;
> +}
> +
> +static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_d=
omain,
> +                                           struct device *dev)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> +       u64 fsc, ta;
> +
> +       if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> +               return -ENODEV;
> +
> +       fsc =3D FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
> +             FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_=
root));
> +       ta =3D FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> +            RISCV_IOMMU_PC_TA_V;
> +
> +       if (riscv_iommu_bond_link(domain, dev))
> +               return -ENOMEM;
> +
> +       riscv_iommu_iodir_update(iommu, dev, fsc, ta);
> +       riscv_iommu_bond_unlink(info->domain, dev);
> +       info->domain =3D domain;
> +
> +       return 0;
> +}
> +
> +static const struct iommu_domain_ops riscv_iommu_paging_domain_ops =3D {
> +       .attach_dev =3D riscv_iommu_attach_paging_domain,
> +       .free =3D riscv_iommu_free_paging_domain,
> +       .map_pages =3D riscv_iommu_map_pages,
> +       .unmap_pages =3D riscv_iommu_unmap_pages,
> +       .iova_to_phys =3D riscv_iommu_iova_to_phys,
> +       .iotlb_sync =3D riscv_iommu_iotlb_sync,
> +       .flush_iotlb_all =3D riscv_iommu_iotlb_flush_all,
> +};
> +
> +static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct devic=
e *dev)
> +{
> +       struct riscv_iommu_domain *domain;
> +       struct riscv_iommu_device *iommu;
> +       unsigned int pgd_mode;
> +       int va_bits;
> +
> +       iommu =3D dev ? dev_to_iommu(dev) : NULL;
> +
> +       /*
> +        * In unlikely case when dev or iommu is not known, use system
> +        * SATP mode to configure paging domain radix tree depth.
> +        * Use highest available if actual IOMMU hardware capabilities
> +        * are known here.
> +        */
> +       if (!iommu) {
> +               pgd_mode =3D satp_mode >> SATP_MODE_SHIFT;
> +               va_bits =3D VA_BITS;
> +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV57) {
> +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57;
> +               va_bits =3D 57;
> +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV48) {
> +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48;
> +               va_bits =3D 48;
> +       } else if (iommu->caps & RISCV_IOMMU_CAP_S_SV39) {
> +               pgd_mode =3D  RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39;
> +               va_bits =3D 39;
> +       } else {
> +               dev_err(dev, "cannot find supported page table mode\n");
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> +       if (!domain)
> +               return ERR_PTR(-ENOMEM);
> +
> +       INIT_LIST_HEAD_RCU(&domain->bonds);
> +       spin_lock_init(&domain->lock);
> +       domain->numa_node =3D NUMA_NO_NODE;
> +
> +       if (iommu) {
> +               domain->numa_node =3D dev_to_node(iommu->dev);
> +               domain->amo_enabled =3D !!(iommu->caps & RISCV_IOMMU_CAP_=
AMO_HWAD);
> +       }
> +
> +       domain->pgd_mode =3D pgd_mode;
> +       domain->pgd_root =3D iommu_alloc_page_node(domain->numa_node,
> +                                                GFP_KERNEL_ACCOUNT);
> +       if (!domain->pgd_root) {
> +               kfree(domain);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> +                                       RISCV_IOMMU_MAX_PSCID, GFP_KERNEL=
);
> +       if (domain->pscid < 0) {
> +               iommu_free_page(domain->pgd_root);
> +               kfree(domain);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       /*
> +        * Note: RISC-V Privilege spec mandates that virtual addresses
> +        * need to be sign-extended, so if (VA_BITS - 1) is set, all
> +        * bits >=3D VA_BITS need to also be set or else we'll get a
> +        * page fault. However the code that creates the mappings
> +        * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
> +        * for now, so we'll end up with invalid virtual addresses
> +        * to map. As a workaround until we get this sorted out
> +        * limit the available virtual addresses to VA_BITS - 1.
> +        */
> +       domain->domain.geometry.aperture_start =3D 0;
> +       domain->domain.geometry.aperture_end =3D DMA_BIT_MASK(va_bits - 1=
);
> +       domain->domain.geometry.force_aperture =3D true;
> +
> +       domain->domain.ops =3D &riscv_iommu_paging_domain_ops;
> +
> +       return &domain->domain;
> +}
> +
>  static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu=
_domain,
>                                               struct device *dev)
>  {
>         struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
>
> +       /* Make device context invalid, translation requests will fault w=
/ #258 */
>         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> +       riscv_iommu_bond_unlink(info->domain, dev);
> +       info->domain =3D NULL;
>
>         return 0;
>  }
> @@ -841,8 +1448,11 @@ static int riscv_iommu_attach_identity_domain(struc=
t iommu_domain *iommu_domain,
>                                               struct device *dev)
>  {
>         struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
>
>         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_=
IOMMU_PC_TA_V);
> +       riscv_iommu_bond_unlink(info->domain, dev);
> +       info->domain =3D NULL;
>
>         return 0;
>  }
> @@ -856,7 +1466,7 @@ static struct iommu_domain riscv_iommu_identity_doma=
in =3D {
>
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
> -       return IOMMU_DOMAIN_IDENTITY;
> +       return 0;
>  }
>
>  static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> @@ -875,6 +1485,7 @@ static struct iommu_device *riscv_iommu_probe_device=
(struct device *dev)
>  {
>         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>         struct riscv_iommu_device *iommu;
> +       struct riscv_iommu_info *info;
>         struct riscv_iommu_dc *dc;
>         u64 tc;
>         int i;
> @@ -893,6 +1504,9 @@ static struct iommu_device *riscv_iommu_probe_device=
(struct device *dev)
>         if (iommu->ddt_mode <=3D RISCV_IOMMU_DDTP_MODE_BARE)
>                 return ERR_PTR(-ENODEV);
>
> +       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return ERR_PTR(-ENOMEM);
>         /*
>          * Allocate and pre-configure device context entries in
>          * the device directory. Do not mark the context valid yet.
> @@ -902,24 +1516,39 @@ static struct iommu_device *riscv_iommu_probe_devi=
ce(struct device *dev)
>                 tc |=3D RISCV_IOMMU_DC_TC_SADE;
>         for (i =3D 0; i < fwspec->num_ids; i++) {
>                 dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> -               if (!dc)
> +               if (!dc) {
> +                       kfree(info);
>                         return ERR_PTR(-ENODEV);
> +               }
>                 if (READ_ONCE(dc->tc) & RISCV_IOMMU_DC_TC_V)
>                         dev_warn(dev, "already attached to IOMMU device d=
irectory\n");
>                 WRITE_ONCE(dc->tc, tc);
>         }
>
> +       dev_iommu_priv_set(dev, info);
> +
>         return &iommu->iommu;
>  }
>
> +static void riscv_iommu_release_device(struct device *dev)
> +{
> +       struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> +
> +       synchronize_rcu();
> +       kfree(info);
> +}
> +
>  static const struct iommu_ops riscv_iommu_ops =3D {
> +       .pgsize_bitmap =3D SZ_4K,
>         .of_xlate =3D riscv_iommu_of_xlate,
>         .identity_domain =3D &riscv_iommu_identity_domain,
>         .blocked_domain =3D &riscv_iommu_blocking_domain,
>         .release_domain =3D &riscv_iommu_blocking_domain,
> +       .domain_alloc_paging =3D riscv_iommu_alloc_paging_domain,
>         .def_domain_type =3D riscv_iommu_device_domain_type,
>         .device_group =3D riscv_iommu_device_group,
>         .probe_device =3D riscv_iommu_probe_device,
> +       .release_device =3D riscv_iommu_release_device,
>  };
>
>  static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)

Reviewed-by: Zong Li <zong.li@sifive.com>

Thanks

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
