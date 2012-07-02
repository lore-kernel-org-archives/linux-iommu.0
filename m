From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
Date: Mon, 2 Jul 2012 13:14:05 +0200
Message-ID: <20120702.141405.2044349227441097560.hdoyu@nvidia.com>
References: <20120702.131326.685361720133451299.hdoyu@nvidia.com><20120702.131903.1053229523265080291.hdoyu@nvidia.com><20120702104231.GD2558@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120702104231.GD2558-5C7GfCeVMHo@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

"joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote @ Mon, 2 Jul 2012 12:42:31 +0200:

> On Mon, Jul 02, 2012 at 12:19:03PM +0200, Hiroshi Doyu wrote:
> > Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Mon, 2 Jul 2012 12:13:26 +0200:
> > > The other 2 patehs are the replacement of this one. They are
> > > exclusive. Both of them are basically for the same fix.
> > 
> > I might not get your point. If you plan to take the this(the original)
> > as immediate fix for v3.5  you need tok take the others for v3.6 after
> > *reverting* the original. This would also work.
> 
> Or you rebase the other two patches on-top of the first patch. Should
> not be too difficult and you can also include the Ack from Steven while
> at it :)

I'm sending the following patch again. The first one is for v3.5. The
rest goes to v3.6 as Joerg suggested.

  v3.5
	[1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
  v3.6
	[1/3] Revert "iommu/tegra: smmu: Fix unsleepable memory allocation"
	[2/3] iommu/tegra: smmu: Remove unnecessary sanity check at alloc_pdir()
	[3/3] iommu/tegra: smmu: Fix unsleepable memory allocation at alloc_pdir()

Is this OK?
