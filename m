From: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for Linux v4.1
Date: Sat, 2 May 2015 19:59:39 +0300
Message-ID: <5545027B.1010704@amd.com>
References: <20150420023433.GA3719@8bytes.org> <55349B7C.2090109@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55349B7C.2090109-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Linus,

I've been trying for almost 3 weeks to get the patch at 
http://lists.linuxfoundation.org/pipermail/iommu/2015-April/012757.html 
into the IOMMU tree.

However, Joerg is not answering my emails for some reason (vacation/sick?)

This is a small patch to amd_iommu_v2.c, but it fixes a *big* bug, which 
causes a kernel thread to be stuck and resources to not be freed.

As amdkfd (AMD HSA kernel driver) is the only client for amd_iommu_v2 
driver, it effects only HSA systems. I would like to get this into 4.1 
and I also marked it as stable for 4.0.

Could you please take a look, ack it and pull it to -rc3/4 ? I can send 
you the patch again with git or I can also send it through Dave's drm 
pull request if that's more convenient for you.

Thanks,

	Oded

On 04/20/2015 09:23 AM, Oded Gabbay wrote:
> Hi Joerg,
>
> I sent to you (cc iommu mailing list) an important fix on Apr-16 for a
> bug in amd_iommu_v2.c (from kernel 4.0). See:
> http://lists.linuxfoundation.org/pipermail/iommu/2015-April/012757.html
>
> Could you please add that to the pull request ?
> Its creating problems when running HSA applications.
>
> Thanks,
>
>      Oded
>
> On 04/20/2015 05:34 AM, Joerg Roedel wrote:
>> Hi Linus,
>>
>> The following changes since commit
>> e42391cd048809d903291d07f86ed3934ce138e9:
>>
>>    Linux 4.0-rc6 (2015-03-29 15:26:31 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
>> tags/iommu-updates-v4.1
>>
>> for you to fetch changes up to 7f65ef01e131650d455875598099cd06fea6096b:
>>
>>    Merge branches 'iommu/fixes', 'x86/vt-d', 'x86/amd', 'arm/smmu',
>> 'arm/tegra' and 'core' into next (2015-04-02 13:33:19 +0200)
>>
>> ----------------------------------------------------------------
>>
>> IOMMU Updates for Linux v4.1
>>
>> Not much this time, but the changes include:
>>
>>     * Moving domain allocation into the iommu drivers to prepare for
>>       the introduction of default domains for devices
>>
>>     * Fixing the IO page-table code in the AMD IOMMU driver to
>>       correctly encode large page sizes
>>
>>     * Extension of the PCI support in the ARM-SMMU driver
>>
>>     * Various fixes and cleanups
>>
>> ----------------------------------------------------------------
>> Dan Carpenter (1):
>>        iommu/amd: Small cleanup in mn_release()
>>
>> Joerg Roedel (27):
>>        iommu: Introduce domain_alloc and domain_free iommu_ops
>>        iommu: Introduce iommu domain types
>>        iommu: Only allow iommu_map/unmap for paging domains
>>        iommu/amd: Make use of domain_alloc and domain_free
>>        iommu/vt-d: Make use of domain_alloc and domain_free
>>        iommu/omap: Make use of domain_alloc and domain_free
>>        iommu/arm-smmu: Make use of domain_alloc and domain_free
>>        iommu/exynos: Make use of domain_alloc and domain_free
>>        iommu/tegra-smmu: Make use of domain_alloc and domain_free
>>        iommu/tegra-gart: Make use of domain_alloc and domain_free
>>        iommu/msm: Make use of domain_alloc and domain_free
>>        iommu/shmobile: Make use of domain_alloc and domain_free
>>        iommu/ipmmu-vmsa: Make use of domain_alloc and domain_free
>>        iommu/rockchip: Make use of domain_alloc and domain_free
>>        iommu/fsl: Make use of domain_alloc and domain_free
>>        iommu: Remove domain_init and domain_free iommu_ops
>>        Merge branch 'for-joerg/arm-smmu/updates' of
>> git://git.kernel.org/.../will/linux into arm/smmu
>>        iommu/amd: Use BUS_NOTIFY_REMOVED_DEVICE
>>        iommu/amd: Ignore BUS_NOTIFY_UNBOUND_DRIVER event
>>        iommu/amd: Don't allocate with __GFP_ZERO in alloc_coherent
>>        iommu/amd: Add support for contiguous dma allocator
>>        iommu/amd: Return the pte page-size in fetch_pte
>>        iommu/amd: Optimize iommu_unmap_page for new fetch_pte interface
>>        iommu/amd: Optimize alloc_new_range for new fetch_pte interface
>>        iommu/amd: Optimize amd_iommu_iova_to_phys for new fetch_pte
>> interface
>>        iommu/amd: Correctly encode huge pages in iommu page tables
>>        Merge branches 'iommu/fixes', 'x86/vt-d', 'x86/amd',
>> 'arm/smmu', 'arm/tegra' and 'core' into next
>>
>> Quentin Lambert (1):
>>        iommu/vt-d: Convert non-returned local variable to boolean when
>> relevant
>>
>> Robin Murphy (1):
>>        iommu/arm-smmu: set a more appropriate DMA mask
>>
>> Thierry Reding (3):
>>        iommu/tegra: Setup aperture
>>        iommu/tegra: gart: Set aperture at domain initialization time
>>        iommu/tegra: smmu: Compute PFN mask at runtime
>>
>> Will Deacon (3):
>>        iommu/arm-smmu: ensure CBA2R is initialised before CBAR on SMMUv2
>>        iommu/arm-smmu: handle multi-alias IOMMU groups for PCI devices
>>        iommu/io-pgtable-arm: avoid speculative walks through TTBR1
>>
>>   drivers/iommu/amd_iommu.c           | 250
>> ++++++++++++++++++------------------
>>   drivers/iommu/amd_iommu_types.h     |  13 +-
>>   drivers/iommu/amd_iommu_v2.c        |   2 +-
>>   drivers/iommu/arm-smmu.c            | 180 ++++++++++++++++----------
>>   drivers/iommu/exynos-iommu.c        |  87 +++++++------
>>   drivers/iommu/fsl_pamu_domain.c     |  60 +++++----
>>   drivers/iommu/fsl_pamu_domain.h     |   2 +-
>>   drivers/iommu/intel-iommu.c         |  68 +++++-----
>>   drivers/iommu/intel_irq_remapping.c |  12 +-
>>   drivers/iommu/io-pgtable-arm.c      |   5 +
>>   drivers/iommu/iommu.c               |  26 ++--
>>   drivers/iommu/ipmmu-vmsa.c          |  42 +++---
>>   drivers/iommu/msm_iommu.c           |  73 ++++++-----
>>   drivers/iommu/omap-iommu.c          |  49 ++++---
>>   drivers/iommu/rockchip-iommu.c      |  40 +++---
>>   drivers/iommu/shmobile-iommu.c      |  39 +++---
>>   drivers/iommu/tegra-gart.c          |  88 ++++++++-----
>>   drivers/iommu/tegra-smmu.c          |  59 +++++----
>>   include/linux/iommu.h               |  33 ++++-
>>   19 files changed, 644 insertions(+), 484 deletions(-)
>>
>> Please pull.
>>
>> Thanks,
>>
>>     Joerg
>>
