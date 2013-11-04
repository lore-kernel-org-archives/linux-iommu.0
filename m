From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Mon, 4 Nov 2013 07:59:00 +0100
Message-ID: <20131104.085900.583730179932784222.hdoyu@nvidia.com>
References: <5271893C.6000507@wwwdotorg.org><20131031.101717.1419377840657413108.hdoyu@nvidia.com><5273DCCD.2050901@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5273DCCD.2050901-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Fri, 1 Nov 2013 17:54:37 +0100:

> On 10/31/2013 02:17 AM, Hiroshi Doyu wrote:
> > Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:33:32 +0100:
> ...
> > Right.
> > "memory client ID" is used to find out MC_SMMU_<swgroup>_ASID_0
> > register. This register is used to associate <swgroup> to address
> > space(AS). <swgroup> == H/W. <swgroup> can be attached to any AS.
> > 
> >> Is "swgroup" simply another name for "memory client ID"? If so, it'd
> >> be good to use just one term consistently.
> > 
> > I used the name "memory client ID" because this ID can be used to find
> > out HOTRESET bit in MC_CLIENT_HOTRESET_*_0 registers in addition to
> > find the MC_SMMU_<swgroup>_ASID_0 offset. But maybe it's easy to use
> > the consistent name as "swgroup". If laster HOTRESET wants automatic
> > calculation they could borrow/redefine the same ID list, just
> > replacing the prefix. What do you think?
> > 
> >> Assuming "swgroup" is "memory client ID",
> > 
> > Yes
> 
> I took a look at the TRM, and it does look like there's a distinction
> between client IDs and swgroups. The basic idea is that each swgroup
> encompasses n (n >= 1) memory client IDs. So, we do have to use both terms.

Well, I considred that memory-client's' ~= 'a' swgroup, and the term
"swgroup" isn't used in HOTREST, where actually each bit represents
a "swgroup".

> However, the bits in the HOTRESET register appear mostly align with
> swgroup IDs rather client IDs, so I think some of your explanation above
> is innaccurate.
> 
> I do want to point out that the HOTRESET bits don't 100% match the
> swgroup IDs though, so the driver needs to be careful, and perhaps
> contain some kind of mapping table between the two numbering spaces. In
> particular, on Tegra114, swgroups and ASID registers appear in order
> PPCS, <gap>, SATA, whereas there's no gap between the HOTRESET bits for
> PPCS and SATA, assuming the TRM is correct.

In our downstream, basically I provided to two conversion tables, one
for "MC_SMMU_<swgroup ID>_ASID_0" and the other for "HOTRESET"
bit. That table converts ID to them respectively. I think that this is
acceptable.
