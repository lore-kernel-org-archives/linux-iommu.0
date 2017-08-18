From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/4] iommu: Prevent VMD child devices from being
	remapping targets
Date: Fri, 18 Aug 2017 11:04:33 -0500
Message-ID: <20170818160433.GN28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
	<20170817181014.1257-5-jonathan.derrick@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817181014.1257-5-jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Fugate <david.fugate-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Scott Bauer <scott.bauer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[+cc Robin]

This series looks fine to me as far as PCI is concerned, and I'd be
happy to take it via my tree given an ack from David for this IOMMU
piece.  Alternatively, you can add my

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

to the other patches if you want to take it via another tree.

Robin raised a question about basically this same patch the first time
around.  Not sure whether there's still an objection there.

On Thu, Aug 17, 2017 at 12:10:14PM -0600, Jon Derrick wrote:
> VMD child devices must use the VMD endpoint's ID as the requester.
> Because of this, there needs to be a way to link the parent VMD
> endpoint's iommu group and associated mappings to the VMD child devices
> such that attaching and detaching child devices modify the endpoint's
> mappings, while preventing early detaching on a singular device removal
> or unbinding.
> 
> The reassignment of individual VMD child devices devices to VMs is
> outside the scope of VMD, but may be implemented in the future. For now
> it is best to prevent any such attempts.
> 
> This patch prevents VMD child devices from returning an IOMMU, which
> prevents it from exposing an iommu_group sysfs directories and allowing
> subsequent binding by userspace-access drivers such as VFIO.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 687f18f..94353a6e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -901,6 +901,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>  		struct pci_dev *pf_pdev;
>  
>  		pdev = to_pci_dev(dev);
> +
> +		/* VMD child devices currently cannot be handled individually */
> +		if (is_vmd(pdev->bus))
> +			return NULL;
> +
>  		/* VFs aren't listed in scope tables; we need to look up
>  		 * the PF instead to find the IOMMU. */
>  		pf_pdev = pci_physfn(pdev);
> -- 
> 2.9.4
> 
