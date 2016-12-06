From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ACPI/IORT: Make dma masks set-up IORT specific
Date: Tue, 6 Dec 2016 09:43:04 +0000
Message-ID: <20161206094304.GA2498@arm.com>
References: <20161205122619.25045-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161205122619.25045-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 05, 2016 at 12:26:19PM +0000, Lorenzo Pieralisi wrote:
> The introduction of acpi_dma_configure() allows to configure DMA
> and related IOMMU for any device that is DMA capable. To achieve
> that goal it ensures DMA masks are set-up to sane default values
> before proceeding with IOMMU and DMA ops configuration.
> 
> On x86/ia64 systems, through acpi_bind_one(), acpi_dma_configure() is
> called for every device that has an ACPI companion, in that every device
> is considered DMA capable on x86/ia64 systems (ie acpi_get_dma_attr() API),
> which has the side effect of initializing dma masks also for
> pseudo-devices (eg CPUs and memory nodes) and potentially for devices
> whose dma masks were not set-up before the acpi_dma_configure() API was
> introduced, which may have noxious side effects.
> 
> Therefore, in preparation for IORT firmware specific DMA masks set-up,
> wrap the default DMA masks set-up in acpi_dma_configure() inside an IORT
> specific wrapper that reverts to a NOP on x86/ia64 systems, restoring the
> default expected behaviour on x86/ia64 systems and keeping DMA default
> masks set-up on IORT based (ie ARM) arch configurations.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Joerg,
> 
> pending Rafael's ACK on it, given the 4.10 release timing and that the
> series is queued via the IOMMU tree please consider applying this patch to
> your arm/smmu branch for 4.10, it is not fixing a bug but it is modifying
> the x86/ia64 code path; I prefer preventing any issue related to default
> dma masks on x86/ia64 so I hope it can get merged along with the rest of
> the ACPI IORT SMMU series.
> 
> Thanks a lot and apologies,
> Lorenzo
> 
>  drivers/acpi/arm64/iort.c | 22 ++++++++++++++++++++++
>  drivers/acpi/scan.c       | 14 +-------------
>  include/linux/acpi_iort.h |  2 ++
>  3 files changed, 25 insertions(+), 13 deletions(-)

Looks straightforward to me:

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Joerg can probably just pick this on top of his queue.

Will
