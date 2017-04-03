From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] iommu/omap: Add support for iommu-groups and 'struct
	iommu_device'
Date: Mon, 3 Apr 2017 12:09:51 -0500
Message-ID: <9af51f75-312a-8137-82d1-e3b08cec3448@ti.com>
References: <1490962248-12602-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490962248-12602-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

Hi Joerg,

On 03/31/2017 07:10 AM, Joerg Roedel wrote:
> Hi,
> 
> here is a small patch-set for the omap-iommu driver to make
> it use new features of the iommu-core. Please review.

Thanks for the patches - this has been on my TODO list but you beat me
in getting there first :). Are these for 4.12?

I have given the series a quick try and these currently break the
functionality. I am investigating the failures, so will mostly need some
additional changes. Let me know if you want me to take up posting of the
v2. Meanwhile, I have added some comments on the patches.

regards
Suman

> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>   iommu/omap: Move data structures to omap-iommu.h
>   iommu/omap: Permanently keep iommu_dev pointer in arch_data
>   iommu/omap: Set dev->archdata.iommu = NULL in omap_iommu_remove_device
>   iommu/omap: Make use of 'struct iommu_device'
>   iommu/omap: Add iommu-group support
> 
>  drivers/iommu/omap-iommu.c               | 137 ++++++++++++++++++++-----------
>  drivers/iommu/omap-iommu.h               |  35 ++++++++
>  include/linux/platform_data/iommu-omap.h |  15 ----
>  3 files changed, 124 insertions(+), 63 deletions(-)
> 
