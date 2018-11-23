From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Fri, 23 Nov 2018 13:14:10 +0100
Message-ID: <20181123121410.GG1586@8bytes.org>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<42949d93-e22c-dd4d-cd49-46efc0b73cdb@arm.com>
	<20181112145541.GB25808@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE5A7A7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19BE5A7A7-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Kevin,

On Thu, Nov 22, 2018 at 08:39:19AM +0000, Tian, Kevin wrote:
> I agree special action needs to be taken for everything else (other than
> DMA-API), but the point that I didn't get is why the action must be based
> a new SVA-type domain, instead of extending default domain with SVA
> capability (including related paging structures which are accessed through 
> new SVA APIs). In the latter case domain-wise attribute (e.g. IRQ mapping) 
> is naturally shared between capabilities (DMA-API and SVA). There is no 
> need to create cross-domain connections as two options that you listed 
> below.
> 
> Can you help elaborate more about the motivation behind proposal?

Yeah, thinking more about it, there are no real reasons against allowing
aux and sva bindings on the default domain. It allows the host to use a
device through the DMA-API and assign parts of it to a guest or a
user-space process, for example.

> |-default domain (DMA-API)
> 	|-sva domain1 (SVA)
> 	|-sva domain2 (SVA)
> 	|-...
> 	|-sva domainN (AUX, guest DMA-API)
> 	|	|- sva domainN1 (AUX, guest SVA)
> 	|	|- sva domainN2 (AUX, guest SVA)
> 	|	|-...
> 	|-sva domainM (AUX, guest DMA-API)
> 	|	|- sva domainM1 (AUX, guest SVA)
> 	|	|- sva domainM2 (AUX, guest SVA)
> 	|	|-...

In my proposal the sva-domains are no sub-domains of the default-domain,
they exist on the same level. A device is detached from its default
domain and attached to an sva-domain.

> means same domain can be default on deviceA while being aux on deviceB
> (when assigning pci and mdev to same VM).

As already written in another mail, this raises a couple of questions,
like what happens when the aux-domain itself has other aux-domains bound
to it?


Regards,

	Joerg
