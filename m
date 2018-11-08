From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: iommu/io-pgtable-arm-v7s: About pagetable 33bit PA
Date: Thu, 8 Nov 2018 15:31:32 +0800
Message-ID: <1541662292.22369.22.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

After the commit ad67f5a6545f ("arm64: replace ZONE_DMA with
ZONE_DMA32"), we don't have ZONE_DMA in aarch64, but
__arm_v7s_alloc_table[1] use the GFP_DMA to expect the physical address
of pagetable should be 32bit.

Right now we meet a issue that the lvl1 pagetable PA is 0x1_3ab6_0000 in
the 4GB broad. then the IOMMU initialize failed.(This issue can be fixed
if we revert ad67f5a6545f.)

I planed to add GFP_DMA32 for pagetable allocation. the level1 was
ok but level2 was failed. It looks that slab don't like GFP_DMA32[2].
this is the warning log:
=====
Unexpected gfp: 0x4 (GFP_DMA32). Fixing up to gfp: 0x488020 (GFP_ATOMIC|
__GFP_ZERO). Fix your code!
=====
I don't know why slab don't allow GFP_DMA32, the gfp flags seems only
be bypassed to alloc_page. Is it possible that let slab allow GFP_DMA32
for aarch64?

We notice that this has been discussed[3]. but if we use alloc_page for
the level2 pagetable, It may waste lots of memory.

Any suggestion is appreciated.


Reported-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

[1]
https://elixir.bootlin.com/linux/v4.20-rc1/source/drivers/iommu/io-pgtable-arm-v7s.c#L200
[2] https://elixir.bootlin.com/linux/v4.20-rc1/source/mm/internal.h#L37
[3] https://patchwork.kernel.org/patch/10474289/
