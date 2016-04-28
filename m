From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Thu, 28 Apr 2016 17:34:51 +0300
Message-ID: <20160428172039-mutt-send-email-mst@redhat.com>
References: <20160421135416.GE11775@citrix.com>
	<1461759501.118304.149.camel@infradead.org>
	<20160427153345-mutt-send-email-mst@redhat.com>
	<20160427142331.GH17926@8bytes.org>
	<20160427172630-mutt-send-email-mst@redhat.com>
	<20160427145632.GI17926@8bytes.org>
	<20160427180007-mutt-send-email-mst@redhat.com>
	<1461770135.118304.152.camel@infradead.org>
	<20160427211635-mutt-send-email-mst@redhat.com>
	<1461784617.118304.181.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461784617.118304.181.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Kevin Wolf <kwolf-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cornelia.huck-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, Wei Liu <wei.liu2-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Stefan Hajnoczi <stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, qemu-block-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, Stefano Stabellini <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Borntraeger <borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Amit Shah <amit.shah-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Anthony PERARD <anthony.perard-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 27, 2016 at 08:16:57PM +0100, David Woodhouse wrote:
> On Wed, 2016-04-27 at 21:17 +0300, Michael S. Tsirkin wrote:
> > 
> > > Because it's a dirty hack in the *wrong* place.
> > 
> > No one came up with a better one so far :(
> 
> Seriously?
> 
> Take a look at drivers/iommu/intel-iommu.c. It has quirks for all kinds
> of shitty devices that have to be put in passthrough mode or otherwise
> excluded.

I see work-arounds for broken IOMMUs but not for
individual devices. Could you point me to a more specific
example?


> We don't actually *need* it for the Intel IOMMU; all we need is for
> QEMU to stop lying in its DMAR tables.

We need it for legacy QEMU anyway, and it's not easy for QEMU to stop
lying about virtio, so we'll need it for a while.
I think it's easy for QEMU to stop lying about assigned devices,
so we don't need it for non-virtio devices.

> We *do* want the same kind of quirks in the relevant POWER and ARM
> IOMMU code in the kernel. Do that (hell, a simple quirk for all virtio
> devices will suffice, but NOT in the virtio driver

Sure - that works. It does not have to be in the driver.

>) at the same moment
> you fix the virtio devices to use the DMA API. Job done.
> 
> Some time *later* we can work on *refining* that quirk, and a way for
> QEMU to tell the guest (via something generic like fwcfg, maybe) that
> some devices are and aren't translated.

I don't see why how fwcfg can work here. It's a static thing,
devices can come and go with hotplug.

> Actually, I'm about to look at moving dma_ops into struct device and
> cleaning up the way we detect which IOMMU is attached, at device
> instantiation time. Perhaps I can shove the virtio-exception quirk in
> there while I'm at it...

Sounds good.

> -- 
> dwmw2
> 
