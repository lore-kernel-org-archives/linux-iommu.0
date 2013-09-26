From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/9] arm-smmu: Misc changes/Calxeda ECX-2000 support
Date: Fri, 27 Sep 2013 00:36:12 +0200
Message-ID: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Following a new patch set to fix some issues, that I've seen when
using arm-smmu driver with MMU-400 and to enable support for SMMUs on
Calxeda ECX-2000.

Patches are rebased on Joerg's latest joro/next branch (as of today).
I hope that I have addressed all (most) comments from the last
submission for following patches:

 [PATCH 1/9] iommu/arm-smmu: Switch to arch_initcall for driver ...
 [PATCH 2/9] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu ...
 [PATCH 3/9] ARM: dma-mapping: Always pass proper prot flags to ...
 [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to avoid ...
 [PATCH 5/9] iommu/arm-smmu: Clear global and context bank fault ...

This time I've added patches for SMMU support on Calxeda ECX-2000.
Unfortunately this requires a quirk in the arm-smmu driver
(and that is the ugly part):

 [PATCH 6/9] iommu/arm-smmu: Support buggy implemenations where all
             config accesses are secure

I still kept the patch (slightly modified) to introduce a function to
isolate devices. I also merged the command line stuff into that patch
because it mainly belongs to it:

 [PATCH 7/9] iommu/arm-smmu: Add function that conditionally isolates
             all masters of all SMMUs

 (Maybe it's better to use a bus notifier to attach/detach devices
 instead. But I just started to look into this and code is not yet
 ready+tested.)

Also I think we need a default handler for context faults
Otherwise we won't notice when something goes wrong:

 [PATCH 8/9] iommu/arm-smmu: Introduce a default fault handler

And finally here's the dts-adaption to enable SMMUs

 [PATCH 9/9] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000

Would be nice if the noncontroversial patches (1-5?) could be applied.
(Esp. in case there are longer discussions about the rest.)

Comments welcome.


Thanks,

Andreas
