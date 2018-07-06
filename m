From: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Fri, 6 Jul 2018 22:54:50 +0200
Message-ID: <20180706205449.GB2313@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
	<20180705193613.GA28905@lst.de>
	<5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
	<20180706141926.GA2313@localhost.localdomain>
	<bd63815c-260e-078f-4184-561c8e54e636@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bd63815c-260e-078f-4184-561c8e54e636-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: JuergenUrban-Mmb7MZpHnFY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

> > Does dma_set_coherent_mask want a device object representing the IOP? Such
> > a thing is currently not implemented, but can certainly be done.
> 
> Nope, just the same OHCI device as the dma_declare_coherent_memory() call.

Ah... and then some kind of dma_ops structure is needed to avoid -EIO?
Possibly using set_dma_ops()?

By the way, the DMA hardware supports executing device->{memory,FIFO},
{memory,FIFO}->device and FIFO<->memory simultaneously, with hardware stall
control, between different devices where memory or FIFOs act as intermediate
buffers. Memory can also be a source or a destination.

That might be a way to have the OHCI efficiently transfer data from/to main
memory. I suppose it would be two simultaneously linked DMA transfers such
as

	OHCI <-> SIF <-> main memory

or even three linked DMA transfers as in

	OHCI <-> IOP memory <-> SIF <-> main memory

where SIF is the IOP DMA interface, which is a bidirectional hardware FIFO.

Does the kernel DMA subsystem support simultaneously linked DMA transfers?
In addition, the DMA hardware also supports scatter-gather (chaining), so
memory need not be physically continuous.

> > As you noted, the kernel cannot and must not allocate any kind of normal
> > memory for this device. Typical DMA addresses 0-0x200000 are mapped to
> > 0x1c000000-0x1c200000 and is memory managed exclusively by the IOP. What
> > would be a suitable mask for that?
> 
> For the sake of accuracy, I guess maybe DMA_BIT_MASK(20) since that's what
> the OHCI's effective addressing capability is, even if it does happen to be
> to remote IOP RAM.

Isn't it 21 for 2 MiB? Hmm... I'm considering raising that to 8 MiB since
there are such devices too.

> Alternatively, there is perhaps some degree of argument
> for deliberately picking a nonzero but useless value like 1, although it
> looks like the MIPS allocator (at least the dma-default one) never actually
> checks whether the page it gets is within range of the device's coherent
> mask, which it probably should do.

Perhaps Maciej knows more about the details of the MIPS allocator?

Fredrik
