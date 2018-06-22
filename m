From: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Fri, 22 Jun 2018 16:56:05 +0200
Message-ID: <20180622145603.GA17701@localhost.localdomain>
References: <20180303082234.GB24991@localhost.localdomain>
	<20180303161249.GA9516@lst.de>
	<20180303181904.GA19076@localhost.localdomain>
	<20180305151010.GA15965@lst.de>
	<20180311180124.GA27731@localhost.localdomain>
	<5696e17e-e0f4-4e6c-7783-4eeea0ff7a5e@arm.com>
	<20180313131745.GC6260@lst.de>
	<d0659e5e-4be7-9a1e-fb8e-b418962d74de@arm.com>
	<20180315075831.GB12136@lst.de>
	<dfc5505e-9ab9-2d81-2fc5-623730a68ba9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dfc5505e-9ab9-2d81-2fc5-623730a68ba9-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin, Christoph,

On Thu, Mar 15, 2018 at 01:11:03PM +0000, Robin Murphy wrote:
> On 15/03/18 07:58, Christoph Hellwig wrote:
> > On Wed, Mar 14, 2018 at 05:43:46PM +0000, Robin Murphy wrote:
> > > > So maybe for now the quick fix is to move the sleep check as suggested
> > > > earlier in this thread, but in the long run we probably need to do some
> > > > major rework of how dma_declare_coherent_memory and friends work.
> > > 
> > > Maybe; I do think the specific hcd_alloc_coherent() case could still be
> > > fixed within the scope of the existing code, but it's not quite as clean
> > > and straightforward as I first thought, and the practical impact of
> > > tweaking the WARN should be effectively zero despite the theoretical edge
> > > cases it opens up. Do you want me to write it up as a proper patch?
> > 
> > Yes.  Including a proper comment on why the might_sleep is placed there.
> 
> OK, will do.

How is to going with moving the sleep check?

Another regression triggered by the OHCI turned up in v4.16 with commit
205e1b7f51e4af26 "dma-mapping: warn when there is no coherent_dma_mask"
by Christoph Hellwig:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 62 at ./include/linux/dma-mapping.h:516 ohci_setup+0x41c/0x424 [ohci_hcd]
Modules linked in: ohci_ps2(+) ohci_hcd usbcore usb_common sd_mod iop iop_fio iop_module iop_memory sif
CPU: 0 PID: 62 Comm: modprobe Not tainted 4.16.0+ #1533
Stack : 00000000 00000000 80747392 00000037 81c6eb0c 804f32e7 80493b24 0000003e
        80743498 00000204 00000001 c01c0000 802a2fa0 10058c00 81ea5a68 804facc0
        00000000 00000000 80740000 00000007 00000000 00000060 00000000 00000000
        3a6d6d6f 00000000 0000005f 646f6d20 80000000 00000000 c01e66e8 c01e813c
        00000009 00000204 00000001 c01c0000 00000018 80278fe0 0007579f 00000001
        ...
Call Trace:
[<8001d6e4>] show_stack+0x74/0x104
[<800323a8>] __warn+0x118/0x120
[<8003246c>] warn_slowpath_null+0x44/0x58
[<c01e66e8>] ohci_setup+0x41c/0x424 [ohci_hcd]
[<c01f209c>] ohci_ps2_reset+0x30/0x70 [ohci_ps2]
[<c01a8aec>] usb_add_hcd+0x2d4/0x89c [usbcore]
[<c01f2360>] ohci_hcd_ps2_probe+0x284/0x2a4 [ohci_ps2]
[<802a8a74>] platform_drv_probe+0x2c/0x68
[<802a70b4>] driver_probe_device+0x22c/0x2e4
[<802a71f0>] __driver_attach+0x84/0xc8
[<802a53fc>] bus_for_each_dev+0x60/0x90
[<802a6580>] bus_add_driver+0x1b8/0x200
[<802a7980>] driver_register+0xc0/0x100
[<800106bc>] do_one_initcall+0x17c/0x190
[<800841f4>] do_init_module+0x74/0x1f0
[<80082f30>] load_module+0x1680/0x2044
[<80083adc>] SyS_finit_module+0xa0/0xb8
[<8002190c>] syscall_common+0x34/0x58
---[ end trace e71738b5fa6bf9aa ]---

Fredrik
