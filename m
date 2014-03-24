From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] iommu/amd: Fix logic to determine and checking max
	PASID
Date: Mon, 24 Mar 2014 16:48:06 +0100
Message-ID: <20140324154806.GB2775@8bytes.org>
References: <1394067258-5968-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394067258-5968-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Wed, Mar 05, 2014 at 06:54:18PM -0600, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> In reality, the spec can only support 16-bit PASID since
> INVALIDATE_IOTLB_PAGES and COMPLETE_PPR_REQUEST commands only allow 16-bit
> PASID. So, we updated the PASID_MASK accordingly and invoke BUG_ON
> if the hardware is reporting PASmax more than 16-bit.
> 
> Besides, max PASID is defined as ((2^(PASmax+1)) - 1). The current does not
> determine this correctly.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>

Applied, thanks.

Btw, is there any publicly available driver/way/whatever for me to test the
AMD IOMMUv2 code paths?


	Joerg
