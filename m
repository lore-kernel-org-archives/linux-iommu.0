From: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Subject: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Fri, 2 Mar 2018 19:07:06 +0100
Message-ID: <20180302180704.GA3846@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello DMA mapping helpers maintainers,

I'm porting the PS2 OHCI driver to v4.15 and it triggers

	WARN_ON(irqs_disabled());

in include/linux/dma-mapping.h:dma_free_attrs (trace below). USB maintainer
Alan Stern notes in

https://www.spinics.net/lists/linux-usb/msg162817.html

that

	This is caused by a deficiency in the DMA core: dma_free_coherent()
	wants interrupts to be enabled when it is called.  I'm not sure how
	the other host controller drivers cope with this.

What is the best way to proceed? Can dma_free_attrs be reworked to handle
disabled IRQs?

Fredrik

------------[ cut here ]------------
WARNING: CPU: 0 PID: 50 at ./include/linux/dma-mapping.h:537 hcd_buffer_free+0x130/0x200
Modules linked in:
CPU: 0 PID: 50 Comm: echo Not tainted 4.15.0+ #1001
Stack : 81f30ab8 803ed49c 00000003 0000000b 805a3a08 805454c4 00000099 800610dc
        00000009 00000219 00000001 fffffff3 00000099 10058400 81c09a20 00000001
        00000000 00000000 805a0000 00000001 0000000a 00000002 00000001 6d6f4320
        80420770 0000000f 81c098d8 81c098a0 80000000 00000000 802f4690 804e3f8c
        00000009 00000219 00000001 fffffff3 00000000 00000000 00000000 805a0000
        ...
Call Trace:
[<1f603d86>] show_stack+0x74/0x104
[<add27dec>] __warn+0x118/0x120
[<c729dcd6>] warn_slowpath_null+0x44/0x58
[<c7e21a9a>] hcd_buffer_free+0x130/0x200
[<61864241>] usb_hcd_unmap_urb_for_dma+0x160/0x16c
[<d52afbb3>] __usb_hcd_giveback_urb+0x5c/0x120
[<3a41e8a9>] finish_urb+0x98/0x138
[<9278d9d1>] ohci_work+0x14c/0x494
[<49e08409>] ohci_irq+0x134/0x2dc
[<673da5e4>] usb_hcd_irq+0x2c/0x44
[<5d46375d>] __handle_irq_event_percpu+0x98/0x158
[<a3455ed6>] handle_irq_event_percpu+0x20/0x64
[<e92d5f7a>] handle_irq_event+0x3c/0x64
[<bebbf000>] handle_level_irq+0xe4/0x120
[<9e612100>] generic_handle_irq+0x28/0x38
[<02b6b3c9>] do_IRQ+0x18/0x24
---[ end trace 9dc1d2a5ee71f57d ]---
