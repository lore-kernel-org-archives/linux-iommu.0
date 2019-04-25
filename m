From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Date: Thu, 25 Apr 2019 16:32:35 +0200
Message-ID: <20190425143235.GD16790@lst.de>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de> <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk> <20190425141832.GA16643@lst.de> <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab71b3ad-c737-82ed-5727-9f4382569b4b@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Christoph Hellwig <hch@lst.de>, Dan Carpenter <dan.carpenter@oracle.com>, Jiri Slaby <jslaby@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, "kernel-janitors@vger.kernel.org H Hartley Sweeten" <hsweeten@visionengravers.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 25, 2019 at 03:31:01PM +0100, Ian Abbott wrote:
> On 25/04/2019 15:18, Christoph Hellwig wrote:
>> On Thu, Apr 25, 2019 at 03:13:49PM +0100, Ian Abbott wrote:
>>> So for comedi_isadma, we can just replace the NULL with a pointer to a
>>> static dummy device with a 24-bit coherent mask?
>>
>> It should be converted to a proper isa_driver, so that it gets a real
>> struct device.
>
> But it will work as a short term solution?  comedi_isadma isn't a driver, 
> but is used by a few comedi drivers for ISA cards.

Then convert the drivers properly and pass on the device from them.
