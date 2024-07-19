Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51701362
	for <iommu@lists.linux.dev>; Fri, 19 Jul 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370808; cv=none; b=KQZWyPnVN9MV8vtGnZY2ujAJ0hN8TtZ3L9km/wTV/D6tkeJiYzOunGEGCKJ3HxOxgF15gfrzUY13FWDe2wx+616jIuUr5PwyZnhFA7SLEmmAhpCRWi5Sne04Q4G6G+RRwRT00v1FSGr2kVTcShnmAga7wj02L2x6JhIRPMin3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370808; c=relaxed/simple;
	bh=00BTB1zDKOqZ9MO33Ee0LgPjLVsUhzoC8G9c9gQAe2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHQRfCzumnLy6ZI8JoUM6rHJ1Gwd7IvoXkOVmvm+oKN99Lzc1y+Um3gRwwTjb2iF84sz5ZRVm+EEC1meHZw9lya0Bm+hIt71F+7f8Zmnne04cbPOREn79Un5RWQwAOkSPjW3UY97jz0xX4dOnQnLU0G2yY/qipLk8jlFD4F3RtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bO3XO4Mf; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bO3XO4Mf"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8076cee8607so59898239f.1
        for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721370805; x=1721975605; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g28joi+JxJhlBlHO1ZSGbEwfIwqGeoouz9evpM2n3vc=;
        b=bO3XO4MfyxqD7Ilezv6Gx+0hTQPTmXy02srFrcevVyqLgbA4REPV8vMsuPvaixlBmH
         3WMzZlxWiEBs3/NUAWFe6PgLdOF2sR/vQivHtaDO7S7ZB1X7UsnhmylwQ5RqCvCEC5Fh
         92kxCNzFU7ysAe00lLwOb4By+Krdi81/B2PHKtTn/FIu1oLwyTCz7rKm7oGlCxvpWxyr
         7MQ2D0lEJyiOWghVhLSpHGF2QUGuCdnxYCXkZCKRzrxWhIewdaS1kfS8kmdXzuG4ITLs
         CiFanbOSe40gCMyl9hyVo4FXgSHbCk3bdInkJwaqdM9CUoThMT8/x+uqRwTSY1Yzfi3P
         bYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721370805; x=1721975605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g28joi+JxJhlBlHO1ZSGbEwfIwqGeoouz9evpM2n3vc=;
        b=X4vF1NWVXV4eUsCT0s+oTAAXlm4Q2Jq5PlPGmTl8Amf3ScoLXxu30DwQ9cMF8eM2u3
         +Z/79uxiCirV1rNTYAR6GlpnOR+V1GF4tlzR7INxrwsJtOWPIRvKEPL9/SU1on085Uod
         FosKNRWHvDUCwW3+VkdcMEyqZrv0d7v5pSpzetzy36SvVuXsyISpF8jQpkPQdofDupRC
         cQdhdGrtUbSb6UGyJbikTY0Im/b4rQrM/PuZIvnh+o8PYATliE2JmipufbdsUwhkumUC
         ErBdsqmN/NVPZYB7P+B982b4L30743B6jiVjfeR6CpwCdZ54NqPT20MXUTcZ5ox2kNji
         1Jlw==
X-Forwarded-Encrypted: i=1; AJvYcCU4bQxjBiw9fDdZ5rcELOTSjHlenz99PLm4P5389wgFa5h4iJx1JO0PfDaQmfcdJ+yF+HyrpjSkpI7onBIDOyDNRQuv/xU=
X-Gm-Message-State: AOJu0YxAY8OFEcviF+gvOV4W5dJwX3hYX6A9Z9madIoFqX1KtviJeFfH
	bH7pXjUseudb5XsBY7SwazMlGktDBfdIxM2jndj5xanhuUemdRgxTDtqBHeUSmZPo/Gy9x73Xfu
	Esi5xoLPaDER6UTmQyEp6WRMHewyMCSLjGtE7hA==
X-Google-Smtp-Source: AGHT+IEaXlA5IopI29EACV1fijT953kqODbjYMQ8yJsJkRlhwWNkxcZ95BVrHfdCm1t/7rc1NcwjVNtHnEjNdtccRSw=
X-Received: by 2002:a05:6602:2cd2:b0:805:2e94:f21f with SMTP id
 ca18e2360f4ac-81710137c53mr919379139f.2.1721370804459; Thu, 18 Jul 2024
 23:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1718388908.git.tjeznach@rivosinc.com> <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
In-Reply-To: <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 19 Jul 2024 14:33:13 +0800
Message-ID: <CANXhq0rpX=+YZLfzLcBmHPUxBpo+xWPY9XaNkV0eQAX72KCFKw@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 1:28=E2=80=AFPM Tomasz Jeznach <tjeznach@rivosinc.c=
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
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 642 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 639 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a00396a61439..859cdd455576 100644
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
> +       list_for_each(bonds, &domain->bonds)
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
> +       list_for_each_entry(bond, &domain->bonds, list) {
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
> +               if (len && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
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
> +               if (!(tc & RISCV_IOMMU_DC_TC_V))
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
> @@ -817,15 +1030,416 @@ static void riscv_iommu_iodir_update(struct riscv=
_iommu_device *iommu,
>                 /* Update device context, write TC.V as the last step. */
>                 dma_wmb();
>                 WRITE_ONCE(dc->tc, tc);
> +
> +               /* Invalidate device context after update */
> +               riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> +               riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> +               riscv_iommu_cmd_send(iommu, &cmd);
> +       }
> +
> +       riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> +}
> +
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

Hi Tomasz,
I recently hit the issue here when I removed a device. I think we need
to unlink the device's bond in domain before releasing domain.
Do you mind pick the following modification in this patch? Thanks.

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 859cdd455576..f0707147e706 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1541,6 +1541,8 @@ static void riscv_iommu_release_device(struct device =
*dev)
 {
        struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);

+       riscv_iommu_bond_unlink(info->domain, dev);
+
        synchronize_rcu();
        kfree(info);
 }

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
> +               return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
> +
> +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> +               return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48;
> +
> +       case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> +               return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57;
>         }
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
> +       } else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57;
> +               va_bits =3D 57;
> +       } else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48;
> +               va_bits =3D 48;
> +       } else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
> +               pgd_mode =3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39;
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
> +               domain->amo_enabled =3D !!(iommu->caps & RISCV_IOMMU_CAPA=
BILITIES_AMO_HWAD);
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
>  }
>
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
> @@ -841,8 +1455,11 @@ static int riscv_iommu_attach_identity_domain(struc=
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
> @@ -856,7 +1473,7 @@ static struct iommu_domain riscv_iommu_identity_doma=
in =3D {
>
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
> -       return IOMMU_DOMAIN_IDENTITY;
> +       return 0;
>  }
>
>  static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> @@ -875,6 +1492,7 @@ static struct iommu_device *riscv_iommu_probe_device=
(struct device *dev)
>  {
>         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>         struct riscv_iommu_device *iommu;
> +       struct riscv_iommu_info *info;
>         struct riscv_iommu_dc *dc;
>         u64 tc;
>         int i;
> @@ -893,6 +1511,9 @@ static struct iommu_device *riscv_iommu_probe_device=
(struct device *dev)
>         if (iommu->ddt_mode <=3D RISCV_IOMMU_DDTP_IOMMU_MODE_BARE)
>                 return ERR_PTR(-ENODEV);
>
> +       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return ERR_PTR(-ENOMEM);
>         /*
>          * Allocate and pre-configure device context entries in
>          * the device directory. Do not mark the context valid yet.
> @@ -902,24 +1523,39 @@ static struct iommu_device *riscv_iommu_probe_devi=
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
> --
> 2.34.1
>
