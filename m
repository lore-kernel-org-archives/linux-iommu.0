From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Sun, 4 Mar 2018 21:05:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1803042053340.2862-100000@netrider.rowland.org>
References: <20180304175949.GB2368@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180304175949.GB2368-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 4 Mar 2018, Fredrik Noring wrote:

> Hi Alan Stern,
> 
> > > Alan, can dma_free_coherent be delayed to a point when IRQs are enabled?
> > 
> > Yes, subject to the usual concerns about not being delayed for too 
> > long.  Also, some HCDs are highly memory-constrained.  I don't know if 
> > they use this API, but if they do then delaying a free could result in 
> > not enough memory being available when an allocation is needed.
> 
> The PS2 HCD in this case is limited to 256 KiB and memory allocation
> failures can be observed frequently in USB traces (102 subsequent failures
> in the trace below involving mass storage transactions, for example). Is
> there any smartness to the allocations?

Not as far as I know.

>  My impression is that the USB core
> loops until it gets what it wants, and then happily resumes. Does it busy
> wait?

No, it doesn't loop and it doesn't busy-wait.  It just fails if memory 
can't be allocated immediately.  Maybe the higher-level driver has a 
retry loop of some sort.

> The RT3070 wireless USB device driver, for example, has hardcoded buffer
> limits that exceed the total amount of available memory. It refuses to
> accept devices unless adjusted in the source (as in the patch below), after
> which it works nicely.
> 
> Other USB device drivers such as the one for the AR9271 wireless device
> trigger endlessly repeating kernel warnings claiming
> 
> 	BOGUS urb xfer, pipe 1 != type 3
> 
> as shown in this kernel backtrace:

...

> I don't know if this is related to memory limitations or some other problem
> though.

Another problem.  This message indicates there's a bug in the ath9k
driver; it says that the driver submitted an interrupt URB for a bulk
endpoint.

Alan Stern
