From: "'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Wed, 12 Dec 2018 10:29:21 +0100
Message-ID: <20181212092920.GT16835@8bytes.org>
References: <11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
	<758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
	<20181123112125.GF1586@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE68777@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE689B8@SHSMSX101.ccr.corp.intel.com>
	<20181207102926.GM16835@8bytes.org>
	<fc173d9f-57e2-dd87-95d0-1c615f2e14e3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fc173d9f-57e2-dd87-95d0-1c615f2e14e3-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 11, 2018 at 01:35:23PM +0000, Jean-Philippe Brucker wrote:
> > 	/* So we need a iommu_aux_detach_all()? */
> 
> This could be useful for device drivers that want to do bulk cleanup on
> device removal. If they rely on Function Level Reset to disable PASID
> states for example, they could also cleanup with a detach_all(). But
> most will probably need to clean up individual PASID states (for example
> free all mdevs) and therefore don't need detach_all()

Yeah, so the more I think about it, the more dangerous it seems to have
this function. It creates subtle error cases for the users of SVA and
aux-domains because their mapping goes away without notice. It is
certainly better to force an orderly shutdown of all users before the
device can be re-assigned.

> > This concept can also be easily extended for supporting SVA in parallel
> > on the same device, with the same constraints regarding the behavior of
> > iommu_attach_device()/iommu_detach_device().
> 
> So this would be without the initial step of attaching an "ext" domain
> to the device in order to enable SVA/PASID?

No, I don't think anymore we should introduce a special domain type to
enable these features. Separate enable/disable functions per feature
seem to be a better choice.

> If I understood it correctly, I agree with the
> iommu_attach/detach_device() behavior for SVA as well. If a device is
> bound to an mm, then the device cannot be attached to another domain
> with iommu_attach_device(). This prevents leaks and forces the device
> driver to clean up PASID states when switching to a different driver
> (e.g. vfio-pci)

Right, the API should ensure we are safe on that side.

Thanks,

	Joerg
