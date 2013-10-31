From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Thu, 31 Oct 2013 18:00:29 +0000
Message-ID: <20131031180029.GB31082@mudshark.cambridge.arm.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
	<5271893C.6000507@wwwdotorg.org> <20131031173132.GD3037@kartoffel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131031173132.GD3037@kartoffel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 31, 2013 at 05:31:33PM +0000, Mark Rutland wrote:
> On Wed, Oct 30, 2013 at 10:33:32PM +0000, Stephen Warren wrote:
> > I'm afraid I still don't quite understand what a swgroup is.
> > 
> > IIUC, the HW works like this based on comments in a previous patch:
> > 
> > Each bus-master attached to the MMU passes a "memory client ID" along
> > with the transaction. Some devices can generate transactions with
> > different "memory client IDs". There is a mapping inside the SMMU from
> > "memory client ID" to "address space ID". (I don't know what form that
> > mapping takes; can you point out where it's set up?). Each "address
> > space ID" has its own set of page tables. Is "swgroup" simply another
> > name for "memory client ID"? If so, it'd be good to use just one term
> > consistently.
> 
> The ARM SMMU refers to these as "stream IDs", as that's the architected name
> that appears in all the hardware documentation. If "swgroup" is the term used
> in the hardware documentation I think it makes sense to stick with it, as long
> as there's a description in the binding document that points out what an
> "swgroup" is. If there's a common term that both binding documents could refer
> to to define what stream-id/swgroup are, that would be nice.

Sounds like:

  stream id == memory client id   (part of the binding)
  context id == address space id  (internal to the driver)

> There are a few other differences in approach with the current ARM SMMU binding:
> Documentation/devicetree/bindings/iommu/arm,smmu.txt
> 
> We should probably begin to look for commonality such that the next iommu
> device that gets a binding is closer to a generic iommu class binding.
> 
> > 
> > Assuming "swgroup" is "memory client ID", why can't the driver just
> > create a list/... of known swgroups at runtime, based on the swgroup
> > values that each device uses, which would presumably be either
> > hard-coded in the client device's driver, or represented in the DT smmu
> > property's "iommu specifier" value.
> 
> Assuming that the swgroup values of IP block instances are static, that sounds
> like the ARM SMMU binding approach. Are the IDs static, or can they be assigned
> at runtime?

The only valid case I can think of for dynamic IDs is for hotpluggable
devices sitting being a form of host controller (e.g. PCIe). In that case,
the host controller should handle the ID assignment, which must remain
static for the lifetime of a device.

Will
