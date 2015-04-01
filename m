From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/9] AMD IOMMU Updates for v4.1
Date: Wed, 1 Apr 2015 14:11:57 -0500
Message-ID: <551C42FD.1040209@amd.com>
References: <1427893132-18310-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427893132-18310-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/1/2015 7:58 AM, Joerg Roedel wrote:
> Hi,
>
> here are a few fixes and enhancements for the AMD IOMMU
> driver for the next merge window. They are tested on
> different versions of AMD IOMMUs. Please review.
>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (9):
>    iommu/amd: Use BUS_NOTIFY_REMOVED_DEVICE
>    iommu/amd: Ignore BUS_NOTIFY_UNBOUND_DRIVER event
>    iommu/amd: Don't allocate with __GFP_ZERO in alloc_coherent
>    iommu/amd: Add support for contiguous dma allocator
>    iommu/amd: Return the pte page-size in fetch_pte
>    iommu/amd: Optimize iommu_unmap_page for new fetch_pte interface
>    iommu/amd: Optimize alloc_new_range for new fetch_pte interface
>    iommu/amd: Optimize amd_iommu_iova_to_phys for new fetch_pte interface
>    iommu/amd: Correctly encode huge pages in iommu page tables
>
>   drivers/iommu/amd_iommu.c       | 166 +++++++++++++++++++---------------------
>   drivers/iommu/amd_iommu_types.h |   6 ++
>   2 files changed, 83 insertions(+), 89 deletions(-)
>

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Thanks,

Suravee
