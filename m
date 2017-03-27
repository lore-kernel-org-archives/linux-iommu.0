From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
Date: Mon, 27 Mar 2017 17:33:12 +0200
Message-ID: <20170327153312.GP7266@8bytes.org>
References: <20170322154429.GE7266@8bytes.org>
	<e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
	<20170322225320.GF7266@8bytes.org>
	<a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
	<20170323143014.GK7266@8bytes.org>
	<20170323145311.GA22972@e106794-lin.localdomain>
	<20170323165218.GL7266@8bytes.org>
	<9d318e88-11af-6dab-b30e-d6b5c02443fe@arm.com>
	<20170324110045.GM7266@8bytes.org>
	<7386120a-2848-059f-4de0-7888a2698923@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7386120a-2848-059f-4de0-7888a2698923-5wv7dgnIgG8@public.gmane.org>
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
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 24, 2017 at 07:08:47PM +0000, Jean-Philippe Brucker wrote:
> On 24/03/17 11:00, Joerg Roedel wrote:
> > The document you posted is an addition to the spec, so we can't rely on
> > a stop marker being sent by a device when it shuts down a context.
> > Current AMD GPUs don't send one, afaik.
> 
> Fair enough, though on the SMMU side we still don't know which shutdown
> model hardware vendors are more likely to choose. Devices could use the
> stop marker and never wait for completion of PPRs. In that case context
> shutdown would only have to make sure that PPRs are outside the PCI
> network, return immediately and allow the device driver to call unbind().

Yes, on a stop-marker we should immediatly remove the PASID from the
IOMMU and inform the driver. It might call unbind or do something with
the device.

> So to be on the safe side I think I will by default assume that PPRs are
> in flight during unbind, and drain both software and hardware queue to
> ensure we catch them all.

The AMD driver first removes the internal mapping of the PASID to its
managing data-structures, so that any follow-on faults will get
rejected.



	Joerg
