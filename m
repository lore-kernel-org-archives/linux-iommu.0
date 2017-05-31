From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root
	complex nodes
Date: Wed, 31 May 2017 12:23:20 -0500
Message-ID: <20170531172320.3u6bdctv44aqighy@rob-hp-laptop>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
	<20170524180143.19855-3-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170524180143.19855-3-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 24, 2017 at 07:01:38PM +0100, Jean-Philippe Brucker wrote:
> Address Translation Service (ATS) is an extension to PCIe allowing
> endpoints to manage their own IOTLB, called Address Translation Cache
> (ATC). Instead of having every memory transaction processed by the IOMMU,
> the endpoint can first send an Address Translation Requests for an IOVA,
> obtain the corresponding Physical Address from the IOMMU and store it in
> its ATC. Subsequent transactions to this memory region can be performed on
> the PA, in which case they are marked 'translated' and (partially) bypass
> the IOMMU.
> 
> Since the extension uses fields that were previously reserved in the
> PCIe Translation Layer Packet, it seems ill-advised to enabled it on a
> system that doesn't fully support ATS.
> 
> To "old" root complexes that simply ignored the new AT field, an Address
> Translation Request will look exactly like a Memory Read Request, so the
> root bridge will forward a memory read to the IOMMU instead of a
> translation request. If the access succeeds, the RC will send a Read
> Completion, which looks like a Translation Completion, back to the
> endpoint. As a result the endpoint might end up storing the content of
> memory instead of a physical address in its ATC. In reality, it's more
> likely that the size fields will be invalid and either end will detect the
> error, but in any case, it is undesirable.
> 
> Add a way for firmware to tell the OS that ATS is supported by the PCI
> root complex.

Can't firmware have already enabled ATS? Often for things like this, not 
present means "use firmware setting".

> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-iommu.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> index 0def586fdcdf..f21a68ec471a 100644
> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> @@ -44,6 +44,14 @@ Optional properties
>  - iommu-map-mask: A mask to be applied to each Requester ID prior to being
>    mapped to an IOMMU specifier per the iommu-map property.
>  
> +- ats-supported: if present, the root complex supports the Address
> +  Translation Service (ATS). It is able to interpret the AT field in PCIe
> +  Transaction Layer Packets, and forward Translation Completions or
> +  Invalidation Requests to endpoints.

Why can't this be based on the compatible strings?

Rob
