From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Date: Fri, 13 Jul 2018 19:08:57 +0200
Message-ID: <20180713170857.GB17896@nazgul.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lijiang <lijiang@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 09, 2018 at 09:55:35PM +0800, lijiang wrote:
> About this issue, i want to use an example to describe it.
> /* drivers/iommu/amd_iommu_init.c */
> static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)

Those addresses come from the IVHD header which is an ACPI table. So the
dump kernel can find that out too.

> Obviously, the iommu mmio space is not encrypted, and the device
> mmio space is outside kdump kernel. We know that the old memory is
> encrypted, and the old memory is also outside kdump kernel. For the
> current case, e820__get_entry_type() and walk_iomem_res_desc() can't
> get the desired result, so we can't also decide whether encryption
> or not according to this result(rules). If we want to know whether
> encryption or not by deducing the address, we will need to read the
> content of memory and have a reference value for comparison, then
> what's a reference value? Sometimes we don't know that.

Again, if we don't know that how is the *caller* supposed to know
whether the memory is encrypted or not? Because

"we" == "caller"

in the kdump kernel.

And the more important question is, why are we dumping MMIO space of the
previous kernel *at* *all*? That doesn't make any sense to me.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
