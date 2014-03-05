From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix logics to determine and checking max PASID
Date: Wed, 5 Mar 2014 23:35:45 +0100
Message-ID: <20140305223544.GA2813@8bytes.org>
References: <1394046068-3858-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394046068-3858-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jay.cornwall-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kim.naru-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 05, 2014 at 01:01:08PM -0600, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
>  drivers/iommu/amd_iommu.c       |   26 +++++++++++++++++++++++---
>  drivers/iommu/amd_iommu_init.c  |   15 ++++++++-------
>  drivers/iommu/amd_iommu_types.h |    6 ++----
>  drivers/iommu/amd_iommu_v2.c    |    2 +-
>  4 files changed, 34 insertions(+), 15 deletions(-)

Hmm, this looks a bit complicated. Since the inv_iotlb_pasid and
complete_ppr command only support 16 bit pasids by specification, there
is no way to support pasids with more than 16 bits in general anymore. I
think the best way to handle it is to just change the PASID_MASK to
0x0000ffff.

>  static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
>  				  int qdep, u64 address, bool size)
>  {
> +	/* Note:
> +	 * This command supports only 16-bit PASID.
> +	 * Currently, hardware only implement upto 16-bit PASID
> +	 * even though the spec says it could have upto 20 bits.
> +	 * This is likely to be updated in the future revision of
> +	 * IOMMU specs when the hardware with PASID > 16 bits
> +	 * become available.
> +	 */
> +	BUG_ON(pasid > 0xFFFF);

We can keep this as BUG_ON(pasid & ~PASID_MASK), but then ...

> -		cmd->data[1]  = pasid & PASID_MASK;
> +		cmd->data[1]  = pasid & amd_iommu_max_pasid;

... masking out the other bits is redundant.


	Joerg
