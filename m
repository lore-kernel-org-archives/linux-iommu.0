From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/tegra: smmu: Simplify allocation at once
Date: Tue, 15 May 2012 20:47:58 +0200
Message-ID: <20120515.214758.1198702094241248784.hdoyu@nvidia.com>
References: <4FB19677.4040702@wwwdotorg.org><20120515.112649.411607744957826949.hdoyu@nvidia.com><4FB27FA9.20106@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FB27FA9.20106-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Tue, 15 May 2012 18:09:13 +0200:

> On 05/15/2012 02:26 AM, Hiroshi Doyu wrote:
> > Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Tue, 15 May 2012 01:34:15 +0200:
> > 
> >> On 05/14/2012 01:16 PM, Hiroshi DOYU wrote:
> >>> To simplify the code, alloc necessary data at once.
> >>>
> >>> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>> ---
> >>> This patch requires:
> >>>
> >>>     [PATCH 1/2] iommu/tegra: smmu: Add device tree support for SMMU
> >>>         http://marc.info/?l=linux-tegra&m=133663641107327&w=2
> >>>
> >>> Also the above patch requires:
> >>>
> >>>     [PATCH 1/1] dt: Add general DMA window parser
> >>>         http://marc.info/?l=linux-tegra&m=133671302703840&w=2
> >>
> >> I know I've been harping on about dependencies, but you typically only
> >> need to mention them if the dependencies are not already checked into
> >> the branch you expect this patch to be checked into.
> >>
> >>> -	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> >>> +	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
> >>> +		return -ENODEV;
> >>
> >> I believe you need to change the asids variable from int to u32 to avoid
> >> a warning here.
> > 
> > There's no warning but it's allowed because of "-Wno-pointer-sign". It
> 
> That's odd. I'm sure I have seen this warning recently when calling this
> API, but you're right, I'm not able to trigger that warning right now,
> so this is fine.

Then, either [PATCH v1] or [PATCH v2] would be ok, but v2 may be a bit
better because it's exacltly compatible with that function prototype,
of_property_read_u32(...u32 *).
