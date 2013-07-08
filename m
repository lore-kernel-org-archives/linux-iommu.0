From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI
	bridges
Date: Mon, 08 Jul 2013 11:07:20 -0600
Message-ID: <1373303240.2602.28.camel@ul30vt.home>
References: <20130528183527.3318.5365.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130528183527.3318.5365.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg,

Where do we stand on this series?  You had a concern that the heuristic
used in patch 1/ could be dangerous.  The suggestion for detecting the
issue was actually from Bjorn who replied with his rationale.  Do you
want to go in the direction of a fixed whitelist or do you agree that
even if the heuristic breaks it provides better behavior than what we
have now?  Thanks,

Alex


On Tue, 2013-05-28 at 12:40 -0600, Alex Williamson wrote:
> This series tries to address:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=44881
> 
> Where pci_find_upstream_pcie_bridge() gets lost trying to find the
> upstream PCIe-to-PCI bridge for a device because the bridge doesn't
> expose a PCIe capability.  To do this, we add a iommu_pci_is_pcie_bridge
> function which includes a quirk to look to the next upstream device
> as a sanity check.  We can then replace pci_find_upstream_pcie_bridge
> with a function that's a bit more generic and less tied to intel-iommu
> eccentricities.
> 
> v2 uses the same logic as v1, but moves the search and match code to
> IOMMU-core since PCI-core doesn't want it.  v1 has several reports
> from users that this solves the problem they have in the above bz.
> Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       iommu: Quirked PCIe bridge test and search function
>       intel-iommu: Convert to iommu_pci_find_upstream + iommu_pci_is_pcie_bridge
> 
> 
>  drivers/iommu/Kconfig               |    5 ++
>  drivers/iommu/Makefile              |    1 
>  drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
>  drivers/iommu/intel_irq_remapping.c |   15 +++++--
>  drivers/iommu/pci.c                 |   69 +++++++++++++++++++++++++++++++
>  drivers/iommu/pci.h                 |   23 ++++++++++
>  6 files changed, 157 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/iommu/pci.c
