From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 00/11] PCI: Fix ATS deadlock
Date: Fri, 14 Aug 2015 09:40:57 -0500
Message-ID: <20150814144057.GB26431@google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150811154525.21078.85310.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 11, 2015 at 10:50:59AM -0500, Bjorn Helgaas wrote:
> Gregor reported a deadlock [1] when enabling a VF that supports ATS.
> This series is intended to fix that.  The second patch should be enough to
> fix the deadlock; the rest are simplification and cleanup.
> 
> These are based on v4.2-rc2.
> 
> [1] http://permalink.gmane.org/gmane.linux.kernel.iommu/9433
> 
> Changes between v2 and v3:
>   - Initialize info->ats.enabled, qdep in intel-iommu.c (Yinghai)
>   - Use "u8 enabled:1", not "int enabled:1" in intel-iommu.c state
>   - WARN_ON() if enabling ATS when already enabled (Joerg)
>   - Return -EBUSY, not -EINVAL if enabling ATS when already enabled
>   - Added Reviewed-by from Joerg
> 
> Changes between v1 and v2:
>   - Remove use of pci_ats_enabled() (intel-iommu.c)
>   - Call pci_ats_queue_depth() only once per device and cache result
>     (intel-iommu.c)
>   - Remove pci_ats_enabled() interface
>   - Stop caching queue depth in pci_dev to save space
>   - Add PF refcount of how many associated VFs have ATS enabled
>   - Add comment that ATS must be enabled on PF before on VFs
>   - Require ATS to be disabled on all VFs and PF before changing STU
> 
> ---
> 
> Bjorn Helgaas (11):
>       iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
>       PCI: Allocate ATS struct during enumeration
>       PCI: Embed ATS info directly into struct pci_dev
>       PCI: Reduce size of ATS structure elements
>       PCI: Rationalize pci_ats_queue_depth() error checking
>       PCI: Inline the ATS setup code into pci_ats_init()
>       PCI: Use pci_physfn() rather than looking up physfn by hand
>       PCI: Clean up ATS error handling
>       PCI: Move ATS declarations to linux/pci.h so they're all together
>       PCI: Stop caching ATS Invalidate Queue Depth
>       PCI: Remove pci_ats_enabled()
> 
> 
>  drivers/iommu/intel-iommu.c |   28 ++++++---
>  drivers/pci/ats.c           |  132 +++++++++++++++----------------------------
>  drivers/pci/probe.c         |    3 +
>  include/linux/pci-ats.h     |   49 ----------------
>  include/linux/pci.h         |   18 ++++++
>  5 files changed, 85 insertions(+), 145 deletions(-)

Applied with the tweaks Joerg suggested and his Ack/Reviewed-by to
pci/iommu for v4.3.  Thanks for all your reviewing and testing!
