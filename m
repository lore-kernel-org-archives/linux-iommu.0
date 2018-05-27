From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
	based ethernet
Date: Sat, 26 May 2018 21:15:05 -0700
Message-ID: <20180527041505.GB31985@roeck-us.net>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
	<alpine.LNX.2.21.1805271212480.9@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1805271212480.9-i19888lE8tflDoPlx7XIcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Finn Thain <fthain-PnMVE5gNl/W9dxLkCovUHLpzq4S04n8Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Joshua Thompson <funaho-E7XWuSn13XjYtjvyW6yDsg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Sun, May 27, 2018 at 01:01:11PM +1000, Finn Thain wrote:
> On Sat, 26 May 2018, Guenter Roeck wrote:
> 
> > As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> > coherent_dma_mask") the NatSemi SONIC Ethernet driver is issuing the
> > following warning on driver initialization on Macintosh q800 systems.
> > 
> > SONIC ethernet @50f0a000, MAC 08:00:07:12:34:56, IRQ 3
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 macsonic_init+0x6a/0x15a
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc6-mac-00286-g527f47c #1
> > Stack from 0781fdd8:
> >         0781fdd8 003615b3 000181ba 000005c4 07a24cbc 00000000 00000000 000020e8
> > 	07a24800 002c196c 0001824e 00334c06 00000204 001f782a 00000009 00000000
> > 	00000000 003358d9 001f782a 00334c06 00000204 00000003 00000000 07a24800
> > 	002b5cb6 000372ec 001f8b1a 07a24800 00359203 50f0a000 07a14a48 00000003
> > 	00000000 07845c0a 0039dcca 003c835c 003c835c 0035b924 001c19de 07845c00
> > 	07845c0a 0039dcca 001c06dc 07845c0a 0781fed8 00000007 0054d040 07845c0a
> > Call Trace: [<000181ba>] __warn+0xc0/0xc2
> >  [<000020e8>] do_one_initcall+0x0/0x140
> >  [<0001824e>] warn_slowpath_null+0x26/0x2c
> >  [<001f782a>] macsonic_init+0x6a/0x15a
> >  [<001f782a>] macsonic_init+0x6a/0x15a
> >  [<002b5cb6>] memcmp+0x0/0x2a
> >  [<000372ec>] printk+0x0/0x18
> >  [<001f8b1a>] mac_sonic_platform_probe+0x380/0x404
> > 
> > As per the warning the coherent_dma_mask is not set on this device.
> > There is nothing special about the DMA memory coherency on this hardware
> > so we can just set the mask to 32bits in the platform data for the FEC
> > ethernet devices.
> > 
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> 
> Acked-by: Finn Thain <fthain-PnMVE5gNl/W9dxLkCovUHLpzq4S04n8Q@public.gmane.org>
> 
> Geert, assuming that Guenter's patch is acceptable, would you also accept 
> a similar patch for the "macmace" platform device?
> 
> > ---
> > Modeled after f61e64310b75 ("m68k: set dma and coherent masks for platform
> > FEC ethernets"). 
> > 
> > RFC: Is "nothing special about the DMA memory coherency" correect ?
> > 
> 
> As I understand it, "cache-coherence" is meaningless unless you have 
> multiple CPU cores and caches. If there's only one CPU core, its cache 

Good point. Maybe it would be better to limit the warning to SMP systems
instead of (unnecessarily) fixing drivers all over the place ?

Guenter

---
>From 9eea0e1b609b69094682757285fd7f89d3930a8e Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Date: Sat, 26 May 2018 21:08:39 -0700
Subject: [PATCH] dma-mapping: Warn about coherent_dma_mask only for SMP

As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask") is unconditional, even if the affected system
is a single-CPU system where coherence is irrelevant. Limit the
warning to SMP configurations to reduce the noise.

Fixes: 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0f589e..ffbb39d84797 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -513,7 +513,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	void *cpu_addr;
 
 	BUG_ON(!ops);
-	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SMP) && dev && !dev->coherent_dma_mask);
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
-- 
2.7.4
