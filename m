From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Wed, 21 Nov 2018 12:40:44 +0800
Message-ID: <758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181107164323.GA19831-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 11/8/18 12:43 AM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> Hi,
> 
> On Wed, Nov 07, 2018 at 11:40:30AM +0800, Lu Baolu wrote:
>> Hi Joerg,
>>
>> On 11/7/18 12:25 AM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
>> Nowadays, we can find PASID granular DMA translation on both ARM and x86
>> platforms. With PASID granular DMA translation supported in system iommu, if
>> a device divides itself into multiple subsets and tag the DMA
>> transfers of each subset with a unique PASID, each subset become
>> assignable. We call the assignable subset as an ADI (Assignable Device
>> Interface). As the result, each ADI could be attached with a domain.
> 
> Yeah, I know the background. The point is, the IOMMU-API as of today
> implements a strict one-to-one relationship between domains and devices,
> every device can only have one domain assigned at a given time. If we
> assign a new domain to a device, the old gets unassigned.
> 
> If we allow to attach multiple domains to a single device we
> fundamentally break that semantic.

Yes. In the latest v4 submission, we use the aux-domain specific APIs to
attach/detach the domain to a device. Do you see other APIs that will
possibly break this semantic?

> 
> Therefore I think it is better is support the ADI devices with
> subdomains and a new set of functions in the API to handle only these
> sub-domains.

Can you please elaborate a bit more about the concept of subdomains?
 From my point of view, an aux-domain is a normal un-managed domain which
has a PASID and could be attached to any ADIs through the aux-domain
specific attach/detach APIs. It could also be attached to a device with
the existing domain_attach/detach_device() APIs at the same time, hence
mdev and pci devices in a vfio container could share a domain.

Best regards,
Lu Baolu

> 
>> Further more, a single domain might be attached to an ADI of device A,
>> while attached to another legacy device B which doesn't support PASID
>> features. In this case, we say "Domain 4" is attached to ADI(PASID#x) in
>> aux mode and attached to device B in primary mode.
> 
> This will of course not work with subdomains, but is that really
> necessary? VFIO already allocates a separate domain for each device
> anyway (iirc), so it is unlikely that is uses the same domain for a
> legacy and an ADI device.
> 
> 
> Regards,
> 
> 	Joerg
> 
