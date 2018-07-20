From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Date: Fri, 20 Jul 2018 13:23:04 +0800
Message-ID: <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
References: <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
 <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lijiang <lijiang@redhat.com>, bhe@redhat.com
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 07/20/18 at 01:06pm, lijiang wrote:
> 在 2018年07月14日 01:08, Borislav Petkov 写道:
> > On Mon, Jul 09, 2018 at 09:55:35PM +0800, lijiang wrote:
> >> About this issue, i want to use an example to describe it.
> >> /* drivers/iommu/amd_iommu_init.c */
> >> static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
> > 
> > Those addresses come from the IVHD header which is an ACPI table. So the
> > dump kernel can find that out too.
> > Sure. I might understand your means, that will have to find all address out in
> order to cover any cases in kdump kernel, those address  might include MMIO
> space, HPET, ACPI device table, ERST, and so on... 
> 
> >> Obviously, the iommu mmio space is not encrypted, and the device
> >> mmio space is outside kdump kernel. We know that the old memory is
> >> encrypted, and the old memory is also outside kdump kernel. For the
> >> current case, e820__get_entry_type() and walk_iomem_res_desc() can't
> >> get the desired result, so we can't also decide whether encryption
> >> or not according to this result(rules). If we want to know whether
> >> encryption or not by deducing the address, we will need to read the
> >> content of memory and have a reference value for comparison, then
> >> what's a reference value? Sometimes we don't know that.
> > 
> > Again, if we don't know that how is the *caller* supposed to know
> > whether the memory is encrypted or not? Because
> > 
> > "we" == "caller"
> > 
> > in the kdump kernel.
> > 
> > And the more important question is, why are we dumping MMIO space of the
> > previous kernel *at* *all*? That doesn't make any sense to me.
> > 
> Sorry for my late reply.
> Here, it doesn't need to dump MMIO space of the previous kernel, when the
> kdump kernel boot, the MMIO address will be remapped in decryption manners,
> but the MMIO address don't belong to the range of the crash reserved memory,
> for the kdump kernel, the MMIO space(address) and IOMMU device table(address)
> are outside address, whereas, the IOMMU device table is encrypted in the first
> kernel, the kdump kernel will need to copy the content of IOMMU device table
> from the first kernel when the kdump kernel boot, so the IOMMU device table will
> be remapped in encryption manners.
> So some of them require to be remapped in encryption manners, and some(address)
> require to be remapped in decryption manners.
> 

There could be some misunderstanding here.  From the code
copy_device_table in amd_iommu_init.c,  iommu table entry is retrieved
by read mmio address, then use memremap to map the entry address for
copying the device table, so the thing related to your patch is the dev
table entry address not the mmio address.

As for why need copy the old dev table, I think it is for addressing
on-flight DMA issue,  just like the git log of below commit although the
commit is for Intel IOMMU but I think AMD IOMMU solution is similar:

commit 091d42e43d21b6ca7ec39bf5f9e17bc0bd8d4312
Author: Joerg Roedel <jroedel@suse.de>
Date:   Fri Jun 12 11:56:10 2015 +0200

    iommu/vt-d: Copy translation tables from old kernel
    
    If we are in a kdump kernel and find translation enabled in
    the iommu, try to copy the translation tables from the old
    kernel to preserve the mappings until the device driver
    takes over.

Baoquan knows more about this I think he can correct if I'm wrong.

Thanks
Dave
