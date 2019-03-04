From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] iommu: io-pgtable: Add ARM Mali midgard MMU page table
 format
Date: Mon, 4 Mar 2019 09:32:36 -0600
Message-ID: <CAL_JsqJsfM1JM_7hhUboZx+zBo_tP8LUR8xTLZOQ0OWGdh=Q7A@mail.gmail.com>
References: <20190227232242.26910-1-robh@kernel.org>
 <e7a36bc9-e425-064b-ca12-3c655c8e5d4a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e7a36bc9-e425-064b-ca12-3c655c8e5d4a@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will.deacon@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 1, 2019 at 10:28 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 27/02/2019 23:22, Rob Herring wrote:
> > ARM Mali midgard GPU page tables are similar to standard 64-bit stage 1
> > page tables, but have a few differences. Add a new format type to
> > represent the format. The input address size is 48-bits and the output
> > address size is 40-bits (and possibly less?). Note that the later
> > bifrost GPUs follow the standard 64-bit stage 1 format.
> >
> > The differences in the format compared to 64-bit stage 1 format are:
> >
> > The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
> >
> > The access flags are not read-only and unprivileged, but read and write.
> > This is similar to stage 2 entries, but the memory attributes field matches
> > stage 1 being an index.
> >
> > The nG bit is not set by the vendor driver. This one didn't seem to matter,
> > but we'll keep it aligned to the vendor driver.

[...]

> > +     cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
> > +     iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
> > +     if (iop)
> > +             cfg->arm_lpae_s1_cfg.tcr = 0;
>
> The general design intent is that we return ready-to-go register values
> here (much like mmu_get_as_setup() in mali_kbase, it seems), so I think
> it's worth adding an arm_mali_cfg to the io_pgtable_cfg union and
> transforming the VMSA output into final transtab/transcfg/memattr format
> at this point, rather then callers needing to care (e.g. some of those
> AS_TRANSTAB_LPAE_* bits look reminiscent of the walk attributes we set
> up for a VMSA TCR).

I agree with returning ready-to-go values, but I'm not so sure the
bits are the same. Bits 0-1 are enable/mode bits which are pretty
specific to mali. Bit 2 is 'read inner' for whatever that means.
Perhaps it is read allocate cacheability, but that's a bit different
than RGN bits. Bit 4 is 'share outer'. Maybe it's the same as SH0 if
bit 3 is included, but I have no evidence of that. So I don't think
there's really anything to transform. We just set the bits needed. So
here's what I have in mind:

iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
if (iop) {
  u64 mair, ttbr;

  /* Copy values as union fields overlap */
  mair = cfg->arm_lpae_s1_cfg.mair[0];
  ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];

  cfg->arm_mali_lpae_cfg.mair = mair;
  cfg->arm_mali_lpae_cfg.ttbr = ttbr;
  cfg->arm_mali_lpae_cfg.ttbr |= ARM_MALI_LPAE_TTBR_READ_INNER |
    ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
}

Rob
