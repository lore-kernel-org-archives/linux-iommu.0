From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 5 Feb 2019 11:13:39 -0500
Message-ID: <20190205111128-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
	<20190129213137-mutt-send-email-mst@kernel.org>
	<20190130074427.GA29516@lst.de>
	<875ztzxvw2.fsf@morokweng.localdomain>
	<20190204152416-mutt-send-email-mst@kernel.org>
	<20190205072407.GA4311@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190205072407.GA4311-jcswGhMUV9g@public.gmane.org>
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
Cc: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alexey Kardashevskiy <aik-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Ram Pai <linuxram-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2019 at 08:24:07AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 04, 2019 at 04:38:21PM -0500, Michael S. Tsirkin wrote:
> > It was designed to make, when set, as many guests as we can work
> > correctly, and it seems to be successful in doing exactly that.
> > 
> > Unfortunately there could be legacy guests that do work correctly but
> > become slow. Whether trying to somehow work around that
> > can paint us into a corner where things again don't
> > work for some people is a question worth discussing.
> 
> The other problem is that some qemu machines just throw passthrough
> devices and virtio devices on the same virtual PCI(e) bus, and have a
> common IOMMU setup for the whole bus / root port / domain.  I think
> this is completely bogus, but unfortunately it is out in the field.
> 
> Given that power is one of these examples I suspect that is what
> Thiago referes to.  But in this case the answer can't be that we
> pile on hack ontop of another, but instead introduce a new qemu
> machine that separates these clearly, and make that mandatory for
> the secure guest support.

That could we one approach, assuming one exists that guests
already support.

-- 
MST
