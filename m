From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Sun, 25 Nov 2018 14:51:14 +0800
Message-ID: <e58f9960-2516-62fa-fd88-2853065d99bf@linux.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
	<758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
	<20181123112125.GF1586@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/23/18 7:21 PM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> On Wed, Nov 21, 2018 at 12:40:44PM +0800, Lu Baolu wrote:
>> Can you please elaborate a bit more about the concept of subdomains?
>>  From my point of view, an aux-domain is a normal un-managed domain which
>> has a PASID and could be attached to any ADIs through the aux-domain
>> specific attach/detach APIs. It could also be attached to a device with
>> the existing domain_attach/detach_device() APIs at the same time, hence
>> mdev and pci devices in a vfio container could share a domain.
> 
> Okay, let's think a bit about having aux-specific attach/detach
> functions, in the end I don't insist on my proposal as long as the
> IOMMU-API extensions are clean, consistent, and have well defined
> semantics.
> 
> If we have aux-domain specific attach/detach functions like
> iommu_aux_domain_attach/detach(), what happens when the primary domain
> of the device is changed with iommu_attach/detach()?
> 
> 	1) Will the aux-domains stay in place? If yes, how does this
> 	   work in setups where the pasid-bound page-tables are
> 	   guest-owned and translated through the primary domain
> 	   page-tables?

Are you thinking about guest SVA? In this case, guest SVA will be
translated through the aux domain page-tables. So, we can safely change
the primary domain with aux-domains staying there.

Conceptually, the primary domain means the existing domain which is for
all Request ID based (a.k.a. transfers without PASID) translations. Any
transfer with PASID will not go through the primary domain.

> 
> 	2) Will the aux-domains be unbound too? In that case, if the
> 	   primary domain is re-used, will the aux-domains be implicitly
> 	   bound too when iommu_device_attach() is called?
> 
> 	3) Do we just disallow changing the primary domain through that
> 	   interface as long as there are aux-domains or mm_structs
> 	   bound to the device?
> 
> Using option 2) or 3) would mean that the aux-domains are still bound to
> the primary domain, but that is not reflected in the API. Further, if an
> aux-domain is just a normal domain (struct iommu_domain), what happens
> when a domain that was used as a primary domain and has bound
> aux-domains to it, is bound with iommu_aux_domain_attach() to another
> domain?
> 
> As you can see, this design decission raises a lot of questions, but
> maybe we can work it out and find a solution we all agree on.
> 
> 
> Regards,
> 
> 	Joerg

Best regards,
Lu Baolu
