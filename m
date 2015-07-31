From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Fri, 31 Jul 2015 12:32:17 +0100
Message-ID: <20150731113217.GE29497@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
	<20150721171101.GN31095@arm.com>
	<1437715466.23932.68.camel@mhfsdcap03>
	<20150724165325.GC21177@arm.com>
	<1437970868.25925.20.camel@mhfsdcap03>
	<1438329337.25925.147.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438329337.25925.147.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "th.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <th.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEmxxBWXNxL4zz@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 31, 2015 at 08:55:37AM +0100, Yong Wu wrote:
>     About the AP bits, I may have to add a new quirk for it...
> 
>   Current I add AP in pte like this:
> #define ARM_SHORT_PTE_RD_WR        (3 << 4)
> #define ARM_SHORT_PTE_RDONLY       BIT(9)
> 
> pteprot |=  ARM_SHORT_PTE_RD_WR;
> 
> 
>  If(!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> 
> 
>       pteprot |= ARM_SHORT_PTE_RDONLY;
> 
> The problem is that the BIT(9) in the level1 and level2 pagetable of our
> HW has been used for PA[32] that is for the dram size over 4G.

Aha, now *thats* a case of page-table abuse!

> so I had to add a quirk to disable bit9 while RDONLY case.
> (If BIT9 isn't disabled, the HW treat it as the PA[32] case then it will
> translation fault..)
> 
> like: IO_PGTABLE_QUIRK_SHORT_MTK ?

Given that you don't have XN either, maybe IO_PGTABLE_QUIRK_NO_PERMS?
When set, IOMMU_READ/WRITE/EXEC are ignored and the mapping will never
generate a permission fault.

Will
