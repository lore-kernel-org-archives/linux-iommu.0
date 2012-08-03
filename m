From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: debugfs for TLB/PTC statistics
Date: Fri, 3 Aug 2012 17:57:40 +0200
Message-ID: <20120803155740.GI1996@amd.com>
References: <1343711681-23394-1-git-send-email-hdoyu@nvidia.com>
 <1343897200-3396-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343897200-3396-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 02, 2012 at 11:46:40AM +0300, Hiroshi Doyu wrote:
> Add debugfs entries to collect TLB/PTC statistics.
> 
>   $ echo "reset" > /sys/kernel/debug/smmu/mc/{tlb,ptc}
>   $ echo "on" > /sys/kernel/debug/smmu/mc/{tlb,ptc}
>   $ echo "off" > /sys/kernel/debug/smmu/mc/{tlb,ptc}
>   $ cat /sys/kernel/debug/smmu/mc/{tlb,ptc}
>   hit:0014910c miss:00014d22
> 
>   The above format is:
>   hit:<HIT count><SPC>miss:<MISS count><SPC><CR+LF>
> 
>   fscanf(fp, "hit:%lx miss:%lx", &hit, &miss);
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Applied to arm/tegra, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
