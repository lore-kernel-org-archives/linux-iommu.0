From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/amd: Fix PASID format in
	INVALIDATE_IOTLB_PAGES command
Date: Tue, 4 Mar 2014 15:12:51 +0100
Message-ID: <20140304141251.GB2799@8bytes.org>
References: <1393451371-17894-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393451371-17894-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jay Cornwall <jay.cornwall-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 26, 2014 at 03:49:31PM -0600, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> From: Jay Cornwall <jay.cornwall-5C7GfCeVMHo@public.gmane.org>
> 
> This patch corrects the PASID format in the INVALIDATE_IOTLB_PAGES
> command, which was caused by incorrect information in
> the AMD IOMMU Architectural Specification v2.01 document.
> 
>     Incorrect format:
>          cmd->data[0][16:23] = PASID[7:0]
>          cmd->data[1][16:27] = PASID[19:8]
> 
>      Correct format:
>          cmd->data[0][16:23] = PASID[15:8]
>          cmd->data[1][16:23] = PASID[7:0]
> 
> However, this does not affect the IOMMUv2 hardware implementation,
> and has been corrected since version 2.02 of the specification
> (available through AMD NDA).
> 
> Signed-off-by: Jay Cornwall <jay.cornwall-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Applied, thanks.

Does this mean that PASIDs are only 16 bits wide now from the former 20
bits?
