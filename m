From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/6] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Thu, 7 Jan 2016 13:34:12 +0100
Message-ID: <20160107123411.GH19149@8bytes.org>
References: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1451672020-2150-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451672020-2150-3-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 01, 2016 at 12:13:36PM -0600, Suravee Suthikulpanit wrote:
> Currently, amd_iommu_pc_get_max_[banks|counters]() require devid,
> which should not be the case. Also, these don't properly support
> multi-IOMMU system.
> 
> Current and future AMD systems with IOMMU that support perf counter
> would likely contain homogeneous IOMMUs where multiple IOMMUs are
> availalbe. So, this patch modifies these function to iterate all IOMMU
> to check the max banks and counters reported by the hardware.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/kernel/cpu/perf_event_amd_iommu.c | 17 +++++++----------
>  drivers/iommu/amd_iommu_init.c             | 20 ++++++++++++--------
>  include/linux/perf/perf_event_amd_iommu.h  |  7 ++-----
>  3 files changed, 21 insertions(+), 23 deletions(-)

Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This looks like the fix for the CZ issue, right? If true, it is
probably v4.5 material.
