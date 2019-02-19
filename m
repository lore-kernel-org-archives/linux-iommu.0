From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: zalon scsi WARNINGs at kernel/dma/mapping.c:290
	dma_free_attrs+0x5c/0x84
Date: Tue, 19 Feb 2019 16:16:09 +0100
Message-ID: <20190219151609.GA4121@lst.de>
References: <f7cf6b8f-671b-e01f-fa1f-6ca82c4af819@linux.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f7cf6b8f-671b-e01f-fa1f-6ca82c4af819-Y27EyoLml9s@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 19, 2019 at 12:57:18AM +0200, Meelis Roos wrote:
> I tried latest Linux on HP A180C (32-bit pa-risc). It works but the Zalon SCSI driver barfs warnings for GSC addon differential scsi board.
>
> The warnings seem to be DMA API related. Packaged 4.19 and self-compiled 5.0.0-rc7 exhibit the same problem.

It looks like the driver is trying to free DMA coherent memory with irqs
disabled, which is a big no-go on most non-coherent architectures (which
includes parisc).

The DMA coherent code in this driver is pretty convoluted, but I'll see
what I can do.  The warning has been there for a couple kernel release,
and the issue basically goes back to day 0 of support for non-coherent
architectures.
