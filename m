From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Thu, 22 Nov 2018 08:39:19 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE5A7A7@SHSMSX101.ccr.corp.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<42949d93-e22c-dd4d-cd49-46efc0b73cdb@arm.com>
	<20181112145541.GB25808@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181112145541.GB25808-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Monday, November 12, 2018 10:56 PM
> 
> Hi Jean-Philippe,
> 
> On Thu, Nov 08, 2018 at 06:29:42PM +0000, Jean-Philippe Brucker wrote:
> > (1) My initial approach would have been to use the same page tables for
> > the default_domain and this new domain, but it might be precisely what
> > you were trying to avoid with this new proposal: a device attached to
> > two domains at the same time.
> 
> My request was about the initial assumptions a device driver can make
> about a device. This assumptions is that DMA-API is set up and
> initialized for it, for everything else (like SVA) the device driver
> needs to take special action, like allocating an SVA domain and attaching
> the device to it.

Hi, Joerg,

I agree special action needs to be taken for everything else (other than
DMA-API), but the point that I didn't get is why the action must be based
a new SVA-type domain, instead of extending default domain with SVA
capability (including related paging structures which are accessed through 
new SVA APIs). In the latter case domain-wise attribute (e.g. IRQ mapping) 
is naturally shared between capabilities (DMA-API and SVA). There is no 
need to create cross-domain connections as two options that you listed 
below.

Can you help elaborate more about the motivation behind proposal?

P.S. as you may see from other threads, we support same IOMMU 
capabilities (both IOVA and SVA) on vfio-mdev (i.e. aux domain) as ones 
on vfio-pci. which leads to below situation following your proposal, if
'AUX' is treated as a separate capability as SVA:

|-default domain (DMA-API)
	|-sva domain1 (SVA)
	|-sva domain2 (SVA)
	|-...
	|-sva domainN (AUX, guest DMA-API)
	|	|- sva domainN1 (AUX, guest SVA)
	|	|- sva domainN2 (AUX, guest SVA)
	|	|-...
	|-sva domainM (AUX, guest DMA-API)
	|	|- sva domainM1 (AUX, guest SVA)
	|	|- sva domainM2 (AUX, guest SVA)
	|	|-...

Is that what is in your mind? would it cause unnecessary complexities
on handling those layers?

The hierarchy could be simplified if we allow aux domain to carry both 
DMA-API and SVA capability:

|-default domain (DMA-API)
	|-sva domain1 (SVA)
	|-sva domain2 (SVA)
	|-...
	|-sva domainN (AUX, guest DMA-API, guest SVA)
	|-sva domainM (AUX, guest DMA-API, guest SVA)

However doing so cause inconsistency on domain definition. why cannot
default domain have full capability but aux domain can?

Further moving along that road, we could have below (as proposed in
this series):

|-default domain (DMA-API, SVA)
	|-sva domainN (AUX, guest DMA-API, guest SVA)
	|-sva domainM (AUX, guest DMA-API, guest SVA)
(whether putting aux domains as sub-domain or same level is not big deal)

There each domain could support full DMA translation capabilities (IOVA, SVA, 
GPA, GIOVA, etc) with supporting structures together (1st level, 2nd level, irq 
mapping, etc.), and new APIs are invented to utilized new capabilities beyond 
existing DMA-API in each domain. 'AUX' here becomes a orthogonal way to 
those DMA translation  capabilities, and is chosen at domain attach time based 
on device configuration. means same domain can be default on deviceA while
being aux on deviceB (when assigning pci and mdev to same VM).

Thoughts? :-)

> 
> This should of course not break any IRQ setups for the device, and also
> enforcing an ordering is not a good and maintainable solution.
> 
> So what you could do here is to either:
> 
> 	1) Save the needed IRQ mappings in some extra datastructure and
> 	   duplicate it in the SVA domain. This also makes it easier to
> 	   use the same SVA domain with multiple devices.
> 
> 	2) Just re-use the 'page-tables' from the default domain in the
> 	   sva-domain. This needs to happen at attach-time, because at
> 	   allocation time you don't know the device yet.
> 
> I think 1) is the best solution, what do you think?
> 
> Btw, things would be different if we could expose SVA through the
> DMA-API to drivers. In this case we could just make the default domain
> of type SVA and be done, but we are not there yet.
> 
> Regards,

Thanks
Kevin
