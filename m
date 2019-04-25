From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Date: Thu, 25 Apr 2019 15:13:49 +0100
Message-ID: <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424142743.GC20974@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Slaby <jslaby@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, "kernel-janitors@vger.kernel.org H Hartley Sweeten" <hsweeten@visionengravers.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 24/04/2019 15:27, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 05:24:37PM +0300, Dan Carpenter wrote:
>> We already dereferenced "dev" when we called get_dma_ops() so this NULL
>> check is too late.  We're not supposed to pass NULL "dev" pointers to
>> dma_alloc_attrs().
> 
> Thanks, applied to the dma-mapping for-next tree.
> 
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> There are still at least two drivers which do pass a NULL unfortunately.
>>
>> drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
>> drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'
> 
> This is staging code.  Per official decree from Linus we can just
> ignore it, and I tend to do so to keep my sanity.

So for comedi_isadma, we can just replace the NULL with a pointer to a 
static dummy device with a 24-bit coherent mask?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
