From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 26 Nov 2018 03:01:20 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE6877B@SHSMSX101.ccr.corp.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
	<758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
	<20181123112125.GF1586@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181123112125.GF1586-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Friday, November 23, 2018 7:21 PM
> 
> On Wed, Nov 21, 2018 at 12:40:44PM +0800, Lu Baolu wrote:
> > Can you please elaborate a bit more about the concept of subdomains?
> > From my point of view, an aux-domain is a normal un-managed domain
> which
> > has a PASID and could be attached to any ADIs through the aux-domain
> > specific attach/detach APIs. It could also be attached to a device with
> > the existing domain_attach/detach_device() APIs at the same time, hence
> > mdev and pci devices in a vfio container could share a domain.
> 
> Okay, let's think a bit about having aux-specific attach/detach
> functions, in the end I don't insist on my proposal as long as the
> IOMMU-API extensions are clean, consistent, and have well defined
> semantics.
> 
> If we have aux-domain specific attach/detach functions like
> iommu_aux_domain_attach/detach(), what happens when the primary
> domain
> of the device is changed with iommu_attach/detach()?
> 
> 	1) Will the aux-domains stay in place? If yes, how does this
> 	   work in setups where the pasid-bound page-tables are
> 	   guest-owned and translated through the primary domain
> 	   page-tables?
> 
> 	2) Will the aux-domains be unbound too? In that case, if the
> 	   primary domain is re-used, will the aux-domains be implicitly
> 	   bound too when iommu_device_attach() is called?
> 
> 	3) Do we just disallow changing the primary domain through that
> 	   interface as long as there are aux-domains or mm_structs
> 	   bound to the device?

3) sounds like a right option. 

IMO Primary domain represents the primary ownership of DMA capability 
of the whole device. The owner (say host driver) may lend partial capability 
(e.g. allocating some queues) to a sub-owner (through aux-domain to a VM 
or mm_struct to a process), when ownership is still claimed by this owner.

Primary domain switch means ownership change (e.g. from host driver to 
guest driver if type is changed from DMA-API to UNMANAGED), which usually
implies driver load/unload thus all resource usages from previous owner must 
be cleaned up before actual switch happens, which include things allocated 
from DMA-API, aux domain API, and SVA APIs. 

> 
> Using option 2) or 3) would mean that the aux-domains are still bound to
> the primary domain, but that is not reflected in the API. Further, if an

Do you suggest some reflection in API interface definition, or specific API 
implementation? If the former I didn't get how to do it. If the latter, yes 
it's missed in current RFC. We should add check in necessary code path.

> aux-domain is just a normal domain (struct iommu_domain), what
> happens
> when a domain that was used as a primary domain and has bound
> aux-domains to it, is bound with iommu_aux_domain_attach() to another
> domain?

aux domain is essentially a way to lend partial DMA capability to less-
privileged entity (process or VM), which implies that part of DMA 
unmanaged by kernel driver. If we can make such assumption that aux 
only applies to UNMANAGED domain (thus disallow BLOCKED/IDENTITY/
DMA from using aux), then above open doesn't exist, because if primary 
domain is UNMANAGED type it essentially means the whole device fully 
owned by user space or guest thus no host driver entity to ever create 
aux domain. If primary domain is not UNMANAGED type, it will fail in 
aux API. with this design, each device will have at most one primary
and multiple aux, i.e. just two layers. no aux-bind-to-aux thing.

this assumption should be true in discussed usages around aux domain. 
but I may overlook something... Jean?

> 
> As you can see, this design decission raises a lot of questions, but
> maybe we can work it out and find a solution we all agree on.
> 

Thanks for raising those good opens!

Thanks
Kevin
