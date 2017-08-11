From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu: prevent VMD child devices from being remapping
	targets
Date: Fri, 11 Aug 2017 19:25:52 +0100
Message-ID: <fda8e2c5-11da-7189-794c-59a68273e4d8@arm.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
	<20170807195713.10963-3-jonathan.derrick@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170807195713.10963-3-jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Fugate <david.fugate-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Scott Bauer <scott.bauer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/08/17 20:57, Jon Derrick wrote:
> VMD child devices must use the VMD endpoint's ID as the DMA source.
> Because of this, there needs to be a way to link the parent VMD
> endpoint's DMAR domain to the VMD child devices' DMAR domain such that
> attaching and detaching child devices modify the endpoint's DMAR mapping
> and prevents early detaching.

That sounds like either pci_device_group() needs modifying, or perhaps
that intel-iommu needs its own extended iommu_ops::device_group
implementation, to ensure that VMD child devices get put in the same
group as their parent - if they share requester IDs they can't feasibly
be attached to different domains anyway.

Robin.

> This is outside the scope of VMD, so disable binding child devices to
> prevent unforeseen issues. This functionality may be implemented in the
> future.
> 
> This patch prevents VMD child devices from returning an IOMMU, which
> prevents it from exposing iommu_group sysfs directories and subsequent
> binding by userspace-access drivers such as VFIO.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 687f18f..651a6cd 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -905,6 +905,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>  		 * the PF instead to find the IOMMU. */
>  		pf_pdev = pci_physfn(pdev);
>  		dev = &pf_pdev->dev;
> +
> +		/* VMD child devices currently cannot be handled individually */
> +		if (pci_bus_is_vmd(pdev->bus))
> +			return NULL;
> +
>  		segment = pci_domain_nr(pdev->bus);
>  	} else if (has_acpi_companion(dev))
>  		dev = &ACPI_COMPANION(dev)->dev;
> 
