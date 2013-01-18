From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra: smmu: Support variable MMIO range
Date: Fri, 18 Jan 2013 10:05:46 +0100
Message-ID: <20130118.110546.1909336134474854222.hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com><1358237848-968-4-git-send-email-hdoyu@nvidia.com><50F717B8.6050800@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F717B8.6050800-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 16 Jan 2013 22:12:24 +0100:

> On 01/15/2013 01:17 AM, Hiroshi Doyu wrote:
> > There are 3 SMMU MMIO register blocks. They may get bigger as new
> > Tegra SoC comes. This patch enables to support variable size of those
> > register blocks.
>
> Why would the register blocks move around? In the HW, there's one single
> chunk of memory containing all the SMMU registers, and we simply carve
> out a few holes since some unrelated registers are stuck in the middle,
> thus leaving us with 3 register ranges. If the size of those carved out
> chunks changes, then doesn't that mean all the registers moved around
> within the single chunk, and hence all the register offsets in the
> driver become invalid?

Presently there are 3 register blocks. In the future chips over some
generations, some of register block "size" can be extended to the end
and also more new register blocks will be added, which is expected at
most a few blocks. Usually the starting address of each block won't
change. Ideally SMMU register blocks should be in one block, but it
was a bit too late to change this design(or H/W). Considering this
situation, in this driver, number of register blocks should be
allocated dynamically, based on the info from DT. Its range checks
should be done in the accessors as below(*1) if necessary. This way
may sacrifice some perf because a new accessor prevents compiler
optimization of register offset calculation, but I think that SMMU
register accesses are not so frequent and it's acceptable in order to
unify "tegra-smmu" over Tegra SoCs.

*1:

 /*
  *	SMMU register accessors
  */
 static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
 {
 	void __iommu *addr = smmu->regbase + offs;
 #ifdef DEBUG
 	int i;

 	for (i = 0; i < smmu->num_regblks; i++) {
 		BUG_ON(addr < smmu->reg[i].start);
 		if (addr <= smmu->reg[i].end)
 			break;
 	}
 #endfi
 	return readl(addr);
 }

Even the checks if "offs" is in some of register blocks could be
ifdef'ed out with DEBUG. "smmu->regbase" can be calculated in probe()
as below. I don't think that we don't need to access "mc" DT entry to
get this address. since "smmu"'s 1st reg block always starts at 0x10.

  /* same as "mc"'s 1st reg block */
  smmu->regbase = smmu->reg[0] & PAGE_MASK;
