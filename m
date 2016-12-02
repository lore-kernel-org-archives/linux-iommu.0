From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RESEND PATCH V6 0/6] Add support for privileged mappings
Date: Fri, 2 Dec 2016 16:16:39 +0000
Message-ID: <e7e05493-e216-d744-b828-351d2c70150d@arm.com>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1480690509-13490-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,

On 02/12/16 14:55, Sricharan R wrote:
> This series is a resend of the V5 that Mitch sent sometime back [2]
> All the patches are the same and i have just rebased. Not sure why this
> finally did not make it last time. The last patch in the previous
> series does not apply now [3], so just redid that. Also Copied the tags
> that he had from last time as well.

Heh, I was assuming this would be down to me to pick up. Vinod did have
some complaints last time about the commit message on the PL330 patch -
I did get as far as rewriting that and reworking onto my SMMU
changes[1], I just hadn't got round to sending it, so it fell onto the
"after the next merge window" pile.

I'd give some review comments, but they'd essentially be a diff against
that branch :)

Robin.

[1]:http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/mh/dma-priv

> The following patch to the ARM SMMU driver:
> 
>     commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
>     Author: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>     Date:   Tue Jan 26 18:06:34 2016 +0000
>     
>         iommu/arm-smmu: Treat all device transactions as unprivileged
> 
> started forcing all SMMU transactions to come through as "unprivileged".
> The rationale given was that:
> 
>   (1) There is no way in the IOMMU API to even request privileged
>       mappings.
> 
>   (2) It's difficult to implement a DMA mapper that correctly models the
>       ARM VMSAv8 behavior of unprivileged-writeable =>
>       privileged-execute-never.
> 
> This series rectifies (1) by introducing an IOMMU API for privileged
> mappings and implements it in io-pgtable-arm.
> 
> This series rectifies (2) by introducing a new dma attribute
> (DMA_ATTR_PRIVILEGED) for users of the DMA API that need privileged
> mappings which are inaccessible to lesser-privileged execution levels, and
> implements it in the arm64 IOMMU DMA mapper.  The one known user (pl330.c)
> is converted over to the new attribute.
> 
> Jordan and Jeremy can provide more info on the use case if needed, but the
> high level is that it's a security feature to prevent attacks such as [1].
> 
> [1] https://github.com/robclark/kilroy
> [2] https://lkml.org/lkml/2016/7/27/590
> [3] https://patchwork.kernel.org/patch/9250493/
> 
> Changelog:
> 
>  v5..v6
>     - Rebased all the patches and redid 6/6 as it does not apply in
>       this code base. 
> 
>  v4..v5
> 
>     - Simplified patch 4/6 (suggested by Robin Murphy).
> 
>   v3..v4
> 
>     - Rebased and reworked on linux next due to the dma attrs rework going
>       on over there.  Patches changed: 3/6, 4/6, and 5/6.
> 
>   v2..v3
> 
>     - Incorporated feedback from Robin:
>       * Various comments and re-wordings.
>       * Use existing bit definitions for IOMMU_PRIV implementation
>         in io-pgtable-arm.
>       * Renamed and redocumented dma_direction_to_prot.
>       * Don't worry about executability in new DMA attr.
> 
>   v1..v2
> 
>     - Added a new DMA attribute to make executable privileged mappings
>       work, and use that in the pl330 driver (suggested by Will).
> 
> Jeremy Gebben (1):
>   iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag
> 
> Mitchel Humpherys (4):
>   iommu: add IOMMU_PRIV attribute
>   common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
>   arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
>   dmaengine: pl330: Make sure microcode is privileged
> 
> Sricharan R (1):
>   iommu/arm-smmu: Set privileged attribute to 'default' instead of
>     'unprivileged'
> 
>  Documentation/DMA-attributes.txt | 10 ++++++++++
>  arch/arm64/mm/dma-mapping.c      |  6 +++---
>  drivers/dma/pl330.c              |  6 ++++--
>  drivers/iommu/arm-smmu.c         |  2 +-
>  drivers/iommu/dma-iommu.c        | 10 ++++++++--
>  drivers/iommu/io-pgtable-arm.c   |  5 ++++-
>  include/linux/dma-iommu.h        |  3 ++-
>  include/linux/dma-mapping.h      |  7 +++++++
>  include/linux/iommu.h            |  1 +
>  9 files changed, 40 insertions(+), 10 deletions(-)
> 
