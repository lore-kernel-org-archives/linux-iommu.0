From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/5] iommu: Allow taking a reference on a group directly
Date: Tue, 15 Nov 2016 12:26:09 +0100
Message-ID: <20161115112609.GA24857@8bytes.org>
References: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 11, 2016 at 05:59:21PM +0000, Robin Murphy wrote:
> iommu_group_get_for_dev() expects that the IOMMU driver's device_group
> callback return a group with a reference held for the given device.
> Whilst allocating a new group is fine, and pci_device_group() correctly
> handles reusing an existing group, there is no general means for IOMMU
> drivers doing their own group lookup to take additional references on an
> existing group pointer without having to also store device pointers or
> resort to elaborate trickery.
> 
> Add an IOMMU-driver-specific function to fill the hole.
> 
> Acked-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: Fix the function name; clarify what exactly its callers are fixing.
> 
>  drivers/iommu/iommu.c | 13 +++++++++++++
>  include/linux/iommu.h |  1 +
>  2 files changed, 14 insertions(+)

Applied the series, thanks Robin.
