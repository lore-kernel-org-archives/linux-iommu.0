From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Wed, 25 Jul 2018 13:17:46 +0100
Message-ID: <20180725121746.GD31576@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<20180725113122.GD24736@lst.de>
	<5e036ade-db0b-f628-a4a0-6d014d1d76c8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5e036ade-db0b-f628-a4a0-6d014d1d76c8-5wv7dgnIgG8@public.gmane.org>
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
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 25, 2018 at 01:12:56PM +0100, Robin Murphy wrote:
> On 25/07/18 12:31, Christoph Hellwig wrote:
> >Hi Robin,
> >
> >this series looks fine to me.  Do you want me to pull this into the
> >dma-mapping tree?  I'd like to see a few more ACKs from the ACPI/OF/
> >IOMMU maintainers though.
> 
> Thanks, I was indeed assuming that the dma-mapping tree would be the best
> route to keep this lot together, hence including patch #1 even though it's
> not functionally related (having spoken to Will offline I think he's happy
> for that one to go through you rather than via arm64 this time around, even
> if #2-#7 don't make it).

Yes, that's right. Here's my ack if it helps:

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
