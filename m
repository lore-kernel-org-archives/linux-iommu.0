From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/6] Add support for privileged mappings
Date: Mon, 11 Jul 2016 15:02:24 +0100
Message-ID: <5783A6F0.7040903@arm.com>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160709020919.6760-1-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Daly <pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hey Mitch,

Thanks for having the necessary go at the DMA API - I think the series
looks broadly workable now.

On 09/07/16 03:09, Mitchel Humpherys wrote:
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
>   (1) There is no way in the IOMMU API to even request privileged mappings.
> 
>   (2) It's difficult to implement a DMA mapper that correctly models the
>       ARM VMSAv8 behavior of unprivileged-writeable =>
>       privileged-execute-never.
> 
> This series rectifies (1) by introducing an IOMMU API for privileged
> mappings and implements it in io-pgtable-arm.
> 
> This series rectifies (2) by introducing a new dma attribute
> (DMA_ATTR_PRIVILEGED_EXECUTABLE) for users of the DMA API that need
> privileged, executable mappings, and implements it in the arm64 IOMMU DMA
> mapper.  The one known user (pl330.c) is converted over to the new
> attribute.
> 
> Jordan and Jeremy can provide more info on the use case if needed, but the
> high level is that it's a security feature to prevent attacks such as [1].

My understanding of that hack is that it involves switching the GPU into
privileged mode to get at the mapping of the IOMMU registers in the
first place, so I don't see at a glance how having privileged mappings
defends against that. What it clearly does do, however, is get us _to_
the point where it's necessary to do such a privilege switch in the
first place, as opposed to everything being trivially wide-open, which
is no bad thing.

Robin.

> 
> [1] https://github.com/robclark/kilroy
> 
> Changelog:
> 
>   v1..v2
> 
>     - Added a new DMA attribute to make executable privileged mappings
>       work, and use that in the pl330 driver (suggested by Will).
> 
> 
> Jeremy Gebben (1):
>   iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag
> 
> Mitchel Humpherys (5):
>   iommu: add IOMMU_PRIV attribute
>   Revert "iommu/arm-smmu: Treat all device transactions as unprivileged"
>   common: DMA-mapping: add DMA_ATTR_PRIVILEGED_EXECUTABLE attribute
>   arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED_EXECUTABLE
>   dmaengine: pl330: Make sure microcode is privileged-executable
> 
>  Documentation/DMA-attributes.txt |  9 +++++++++
>  arch/arm64/mm/dma-mapping.c      |  6 +++---
>  drivers/dma/pl330.c              |  7 +++++--
>  drivers/iommu/arm-smmu.c         |  5 +----
>  drivers/iommu/dma-iommu.c        | 15 +++++++++++----
>  drivers/iommu/io-pgtable-arm.c   | 16 +++++++++++-----
>  include/linux/dma-attrs.h        |  1 +
>  include/linux/dma-iommu.h        |  3 ++-
>  include/linux/iommu.h            |  1 +
>  9 files changed, 44 insertions(+), 19 deletions(-)
> 
