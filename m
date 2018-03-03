From: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Sat, 3 Mar 2018 09:22:35 +0100
Message-ID: <20180303082234.GB24991@localhost.localdomain>
References: <20180302180704.GA3846@localhost.localdomain>
	<20180302213711.GA30356@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180302213711.GA30356-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

> Why do you want to free coherent dma allocations from irq context?
> They generally are a long-term resource that as a rule of thumb should
> be allocated in ->probe and freed in ->remove.

The device specific HCD only does dma_declare_coherent_memory (with
HCD_LOCAL_MEM) in ->probe, and dma_release_declared_memory in ->remove.

However, the generic USB core does a lot more:

https://lists.linuxfoundation.org/pipermail/iommu/2018-March/026338.html

Critically, it performs the following calls:

	   usb_hcd_irq
	-> ohci_irq
	-> ohci_work
	-> process_done_list
	-> takeback_td
	-> finish_urb
	-> usb_hcd_giveback_urb
	-> __usb_hcd_giveback_urb
	-> unmap_urb_for_dma
	-> usb_hcd_unmap_urb_for_dma
	-> hcd_free_coherent
	-> hcd_buffer_free
	-> dma_free_coherent
	-> dma_free_attrs

Could this be avoided in a reasonable way?

Fredrik
