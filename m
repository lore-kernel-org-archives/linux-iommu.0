From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Thu, 31 Oct 2013 09:17:17 +0100
Message-ID: <20131031.101717.1419377840657413108.hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com><1382092020-13170-11-git-send-email-hdoyu@nvidia.com><5271893C.6000507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:33:32 +0100:

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
> space ID" has its own set of page tables.

Right.
"memory client ID" is used to find out MC_SMMU_<swgroup>_ASID_0
register. This register is used to associate <swgroup> to address
space(AS). <swgroup> == H/W. <swgroup> can be attached to any AS.

> Is "swgroup" simply another name for "memory client ID"? If so, it'd
> be good to use just one term consistently.

I used the name "memory client ID" because this ID can be used to find
out HOTRESET bit in MC_CLIENT_HOTRESET_*_0 registers in addition to
find the MC_SMMU_<swgroup>_ASID_0 offset. But maybe it's easy to use
the consistent name as "swgroup". If laster HOTRESET wants automatic
calculation they could borrow/redefine the same ID list, just
replacing the prefix. What do you think?

> Assuming "swgroup" is "memory client ID",

Yes

> why can't the driver just
> create a list/... of known swgroups at runtime, based on the swgroup
> values that each device uses, which would presumably be either
> hard-coded in the client device's driver, or represented in the DT smmu
> property's "iommu specifier" value.

Why we have "nvidia,swgroups" is just to avoid a device node having a
wrong "nvidia,memory-clients" which is not supported by that Tegra
SoC, which could crash kernel eventually. This info may be residual
since we define both "nvidia,swgroups" and "nvidia,memory-clients" at
once in DT. I'll remove "nvidia,swgroups" in SMMU node.
