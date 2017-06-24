From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: DMA_ATTR_WEAK_ORDERING defintion, was Re: [PATCH] nvme: set
	DMA_ATTR_WEAK_ORDERING attribute on dma buffers
Date: Sat, 24 Jun 2017 09:35:39 +0200
Message-ID: <20170624073539.GE14580@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
	<20170617115703.GA13002@lst.de>
	<6a32f30b-433a-9857-164f-1717405a6082@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6a32f30b-433a-9857-164f-1717405a6082-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alan Adamson <alan.adamson-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Mark Nelson <markn-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, axboe-b10kYP2dOMg@public.gmane.org, sagi-NQWnxTmZq1alnMjI0IkVqw@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvme-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

I always assumed that our streaming mappings are relaxed order for
TLP anyway.  And at very least Documentation/DMA-attributes.txt seems
to imply something different:


  DMA_ATTR_WEAK_ORDERING
  ----------------------

  DMA_ATTR_WEAK_ORDERING specifies that reads and writes to the mapping
  may be weakly ordered, that is that reads and writes may pass each other.

Which to me suggest host reads, which also makes me wonder why these
would even apply to our streaming mappings.

Adding the powerpc folks that added the DMA_ATTR_WEAK_ORDERING flag
originally back in 2008, but not actual users as far as I can tell -
those are all new and from the sparc gang, except for the noveau
driver, which is a bit older but only uses for dma_alloc_attrs, where
the original description makes sense to me.

On Wed, Jun 21, 2017 at 01:30:40PM -0700, Alan Adamson wrote:
> drivers may rely on strong ordering for certain writes. For example, a 
> device may use a specific location in host memory to serve as a "done" 
> flag. The device writes data to a buffer, and those writes can be relaxed 
> because the order in which the data bytes enter the buffer is not visible 
> to software. The device then writes to the "done" flag location, to 
> indicate to the consumer that it has completed the buffer write. The write 
> to "done" cannot pass the prior writes to the data buffer; otherwise 
> software polling on the "done" location could potentially read stale data 
> from the data buffer. Device driver developers need to understand the 
> hardware behavior and only set the DMA_ATTR_WEAK_ORDERING attribute when 
> safe.
>
> Alan Adamson
