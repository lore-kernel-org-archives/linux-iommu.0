From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: Task based virtual address spaces
Date: Thu, 5 Oct 2017 11:08:12 +0100
Message-ID: <dc2eabcc-0aba-89ce-cf03-b220fd5c2132@arm.com>
References: <20171004194327.GA25346@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171004194327.GA25346@jcrouse-lnx.qualcomm.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: jcrouse@codeaurora.org
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, arnd@arndb.de, ssusheel@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi Jordan,

On 04/10/17 20:43, Jordan Crouse wrote:
> Trying to start back up the conversation about multiple address
> spaces for IOMMU devices. If you will remember Jean-Philippe posted
> some patches back in February for SVM on arm-smmu-v3.
> 
> For quite some time the downstream Snapdragon kernels have supported
> something we call "per-process" page tables for the GPU. As with full SVM
> this involves creating a virtual address space per task but unlike SVM
> we don't automatically share the page table from the CPU. Instead we
> want to create a new page table and explicitly map/unmap address ranges
> into it. We provide the physical address of the page table to the GPU and
> it goes through the mechanics of programming the TTBR0 and invalidating
> the TLB when starts executing a submission for a given task.

Why does the GPU need the pgd? Does it implement its own MMU specifically
for process contexts? I understand you don't use PASIDs/SSIDs to isolate
process PT but context switch instead?

> As with all things IOMMU this discussion needs to be split into two parts -
> the API and the implementation. I want to focus on the generic API for this
> email. Shortly after Jean-Philippe posted his patches I sent out a rough
> prototype of how the downstream solution worked [1]:
> 
> +-----------------+       +------------------+
> | "master" domain |  ---> | "dynamic" domain |
> +-----------------+  \    +------------------+
>                       \                    
>                        \  +------------------+
>                         - | "dynamic" domain |
>                           +------------------+

I also considered using hierarchical domains in my first prototype, but it
didn't seem to fit the IOMMU API. In the RFC that I intend to post this
week, I propose an iommu_process structure for everything process related.

I'm not sure if my new proposal fits your model since I didn't intend
iommu_process to be controllable externally with an IOMMU map/unmap
interface (the meat of the bind/unbind API is really page table sharing).
In v2 bind/unbind still only returns a PASID, not the process structure,
but I'll Cc you so we can work something out.

> Given a "master" domain (created in the normal way) we can create any number
> of "dynamic" domains which share the same configuration as the master (table
> format, context bank, quirks, etc). When the dynamic domain is allocated/
> attached it creates a new page table - for all intents and purposes this is
> a "real" domain except that it doesn't actually touch the hardware. We can
> use this domain with iommu_map() / iommu_unmap() as usual and then pass the
> physical address (acquired through a IOMMU domain attribute) to the GPU and
> everything works.
> 
> The main goal for this approach was to try to use the iommu API instead of
> teaching the GPU driver how to deal with several generations of page table
> formats and IOMMU devices. Shoehorning it into the domain struct was a
> path of least resistance that has served Snapdragon well but it was never
> really anything we considered to be a generic solution.
> 
> In the SVM patches, Jean-Philippe introduces iommu_bind_task():
> https://patchwork.codeaurora.org/patch/184777/. Given a struct task and
> a bit of other stuff it goes off and does SVM magic.
> 
> My proposal would be to extend this slightly and return a iommu_task
> struct from iommu_bind_task:
> 
> struct iommu_task *iommu_bind_task(struct device *dev, strut task_strut *task,
> 	int *pasid, int flags, void *priv);

Since the GPU driver acts as a proxy and the PT are not shared, I suppose
you don't need the task_struct at all? Or maybe just for cleaning up on
process exit?

Thanks,
Jean

> For implementations that did real SVM the rest would behave the same, but for
> targets with explicit map requirements the iommu_task token could then be
> used for map/unmap:
> 
> iommu_task_map(struct iommu_task *task, unsigned long iova, phys_addr_t paddr,
> 	size_t size, int prot);
> 
> iommu_task_unmap(struct iommu_task *task, unsigned long iova, size_t size);
> 
> int iommu_unbind_task(struct device *dev, struct iommu_task *task, int pasid,
> 	int flags);
> 
> (Note that I'm typing these up on the fly - don't take these prototypes as
> gospel. This is mostly just a representation of the hooks we would need).
> 
> Internally this would come down into the device drivers with code similar
> to https://patchwork.codeaurora.org/patch/184751/. At the device level
> the biggest question figuring out if this is the "full SVM" or "explicit"
> model - we could handle that with compatible strings or dt quirks or even
> a flag to iommu_bind_task(). On Snapdragon we have the additional
> requirement to get the physical address for the page table. That could
> be encoded into pasid or returned in the iommu_task struct or a task
> attribute function.>
> Comments welcome of course. I think that if we can focus on getting a good
> generic API nailed down we can drill into the specifics. Between the 410c
> and the 820c we have two good examples that we can rapidly prototype.
> I would like to get this on the radar so we can get it merged and stabilized
> with enough time to hit a LTS release.
> 
> Thanks,
> Jordan
> 
> [1] https://patchwork.codeaurora.org/patch/192573/
> https://patchwork.codeaurora.org/patch/192571/
> https://patchwork.codeaurora.org/patch/192577/
> https://patchwork.codeaurora.org/patch/192579/
> 
> 
