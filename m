From: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA
 more precisely
Date: Fri, 21 Sep 2012 11:16:00 -0700
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E379FDC2372@HQMAIL04.nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
 <20120918124918.GK2505@amd.com>
 <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
 <201209190759.46174.arnd@arndb.de> <20120919125020.GQ2505@amd.com>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
 <505A7DB4.4090902@wwwdotorg.org>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC1F2D@HQMAIL04.nvidia.com>
 <505B35F7.2080201@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <505B35F7.2080201-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> > The device(H/W controller) need to access few special memory
> > blocks(IOVA==PA) and DRAM as well.
> 
> OK, so only /some/ of the VA space is VA==PA, and some is remapped; that's a
> little different that what you originally implied above.
> 
> BTW, which HW module is this; AVP/COP or something else. This sounds like an
> odd requirement.

This is not specific to ARM7. There are protected memory regions on Tegra that
can be accessed by some controllers like display, 2D, 3D, VDE, HDA. These are
DRAM regions configured as protected by BootRom. These memory regions
are not exposed to and not managed by OS page allocator. The H/W controller
 accesses to these regions still to go through IOMMU.
The IOMMU view for all the H/W controllers is not uniform on Tegra.
Some Controllers see entire 4GB IOVA space. i.e all accesses go though IOMMU.
Some controllers see the IOVA Space that don't overlap with MMIO space.  i.e
The MMIO address access bypass IOMMU and directly go to MMIO space.
Tegra IOMMU can support multiple address spaces as well. To hide controller
Specific behavior, the drivers should take care of one to one mapping and
remove inaccessible iova spaces in their address space's based platform device info.

In my initial mail, I referred protected memory regions as MMIO blocks, which
is incorrect.




-KR
