From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/7] Docs: dt: add PCI IOMMU map bindings
Date: Tue, 14 Jun 2016 15:16:46 +0100
Message-ID: <20160614141644.GI19407@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
	<3a7e47d7b8839ff079568137b5b1b438cfbb44ac.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3a7e47d7b8839ff079568137b5b1b438cfbb44ac.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 03, 2016 at 06:15:37PM +0100, Robin Murphy wrote:
> From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> 
> The existing IOMMU bindings are able to specify the relationship between
> masters and IOMMUs, but they are insufficient for describing the general
> case of hotpluggable busses such as PCI where the set of masters is not
> known until runtime, and the relationship between masters and IOMMUs is
> a property of the integration of the system.
> 
> This patch adds a generic binding for mapping PCI devices to IOMMUs,
> using a new iommu-map property (specific to PCI*) which may be used to
> map devices (identified by their Requester ID) to sideband data for the
> IOMMU which they master through.
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: +Rob's ack.
> 
>  .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

This looks great, thanks!

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
