From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch Part2 V2 00/17] Enhance DMAR drivers to handle PCI/memory
	hotplug events
Date: Wed, 5 Mar 2014 08:48:04 +0100
Message-ID: <20140305074804.GE27471@8bytes.org>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392790057-32434-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 19, 2014 at 02:07:20PM +0800, Jiang Liu wrote:
> Jiang Liu (17):
>   iommu/vt-d: avoid double free of g_iommus on error recovery path
>   iommu/vt-d: avoid caching stale domain_device_info and fix memory
>     leak
>   iommu/vt-d: avoid caching stale domain_device_info when hot-removing
>     PCI device
>   iommu/vt-d: factor out dmar_alloc_dev_scope() for later reuse
>   iommu/vt-d: move private structures and variables into intel-iommu.c
>   iommu/vt-d: simplify function get_domain_for_dev()
>   iommu/vt-d: free resources if failed to create domain for PCIe
>     endpoint
>   iommu/vt-d: reduce duplicated code to handle virtual machine domains
>   iommu/vt-d: fix incorrect iommu_count for si_domain
>   iommu/vt-d: check for NULL pointer when freeing IOMMU data structure
>   iommu/vt-d: fix error in detect ATS capability
>   iommu/vt-d: introduce macro for_each_dev_scope() to walk device scope
>     entries
>   iommu/vt-d: introduce a rwsem to protect global data structures
>   iommu/vt-d: use RCU to protect global resources in interrupt context
>   iommu/vt-d, PCI: update DRHD/RMRR/ATSR device scope caches when PCI
>     hotplug happens
>   iommu/vt-d, PCI: unify the way to process DMAR device scope array
>   iommu/vt-d: update IOMMU state when memory hotplug happens
> 
>  drivers/iommu/dmar.c                |  412 +++++++++++++------
>  drivers/iommu/intel-iommu.c         |  750 ++++++++++++++++++-----------------
>  drivers/iommu/intel_irq_remapping.c |  108 +++--
>  drivers/iommu/iova.c                |   64 ++-
>  include/linux/dmar.h                |   74 ++--
>  include/linux/iova.h                |    2 +
>  6 files changed, 848 insertions(+), 562 deletions(-)

Applied, thanks Jiang.
