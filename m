From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Date: Fri, 5 Oct 2018 09:17:36 +0200
Message-ID: <20181005071736.GA24011@lst.de>
References: <20181003234746.3586.42014.stgit@localhost.localdomain> <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com> <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, alexander.h.duyck@linux.intel.com, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Greg KH <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 04, 2018 at 08:13:26AM -0700, Alexander Duyck wrote:
> Thanks for the review.
> 
> - Alex
> 
> P.S. It looks like I forgot to add Christoph to the original mail
> since I had just copied the To and Cc from the original submission, so
> I added him to the Cc for this.

Yes, there was some oddness with replies appearing out of nowhere that
I couldn't understand in my jetlagged state yesterday.   Now thay I've
caught up on iommu list traffic it all makes sense now.  I've applied
this with an Acked-by for Robin added based on his reply.
