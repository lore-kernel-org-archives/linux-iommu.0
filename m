From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Thu, 31 Oct 2013 10:31:33 -0700
Message-ID: <20131031173132.GD3037@kartoffel>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
	<5271893C.6000507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5271893C.6000507-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 30, 2013 at 10:33:32PM +0000, Stephen Warren wrote:
> On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
> > This provides the info about which H/W Accelerators are supported on
> > Tegra SoC. This info is passed from DT. This is necessary to have the
> > unified SMMU driver among Tegra SoCs. Instead of using platform data,
> > DT passes "nvidia,swgroups" now. DT is mandatory in Tegra.
> 
> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> > index 89fb543..6a844b3 100644
> > --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> > @@ -8,6 +8,11 @@ Required properties:
> >  - nvidia,#asids : # of ASIDs
> >  - dma-window : IOVA start address and length.
> >  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> > +- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
> > +  Each bit represents one swgroup. The assignments may be found in header
> > +  file <dt-bindings/memory/tegra-swgroup.h>. Its max is 64. 2 cells
> 
> That file doesn't exist at this point in the series. I think you should
> create a patch up-front that adds that header, and modifies the binding
> document, all in one go, and separate from any driver code changes.
> Separate DT/driver patches were IIRC agreed to be preferablte at the
> recent ARM workshop.

That certainly matches what I recall from the ARM minisummit.

> 
> > +  are required. This unique ID info can be used to calculate
> > +  MC_SMMU_<SWGROUP name>_ASID_0 offset and HOTRESET bit.
> 
> I'm afraid I still don't quite understand what a swgroup is.
> 
> IIUC, the HW works like this based on comments in a previous patch:
> 
> Each bus-master attached to the MMU passes a "memory client ID" along
> with the transaction. Some devices can generate transactions with
> different "memory client IDs". There is a mapping inside the SMMU from
> "memory client ID" to "address space ID". (I don't know what form that
> mapping takes; can you point out where it's set up?). Each "address
> space ID" has its own set of page tables. Is "swgroup" simply another
> name for "memory client ID"? If so, it'd be good to use just one term
> consistently.

The ARM SMMU refers to these as "stream IDs", as that's the architected name
that appears in all the hardware documentation. If "swgroup" is the term used
in the hardware documentation I think it makes sense to stick with it, as long
as there's a description in the binding document that points out what an
"swgroup" is. If there's a common term that both binding documents could refer
to to define what stream-id/swgroup are, that would be nice.

There are a few other differences in approach with the current ARM SMMU binding:
Documentation/devicetree/bindings/iommu/arm,smmu.txt

We should probably begin to look for commonality such that the next iommu
device that gets a binding is closer to a generic iommu class binding.

> 
> Assuming "swgroup" is "memory client ID", why can't the driver just
> create a list/... of known swgroups at runtime, based on the swgroup
> values that each device uses, which would presumably be either
> hard-coded in the client device's driver, or represented in the DT smmu
> property's "iommu specifier" value.

Assuming that the swgroup values of IP block instances are static, that sounds
like the ARM SMMU binding approach. Are the IDs static, or can they be assigned
at runtime?

Thanks,
Mark.
