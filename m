From: Harsh Jain <Harsh@chelsio.com>
Subject: Re: DMA error when sg->offset value is greater than PAGE_SIZE in
 Intel IOMMU
Date: Wed, 20 Sep 2017 17:00:00 +0530
Message-ID: <dbc09c67-825b-31ea-df1c-9e6b825aa0b7@chelsio.com>
References: <20170920080151.GA3348@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20170920080151.GA3348@gondor.apana.org.au>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dwmw2@infradead.org, joro@8bytes.org, linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, leedom@chelsio.com
List-Id: iommu@lists.linux-foundation.org



On 20-09-2017 13:31, Herbert Xu wrote:
> Harsh Jain <Harsh@chelsio.com> wrote:
>> While debugging DMA mapping error in chelsio crypto driver we observed that when scatter/gather list received by driver has some entry with page->offset > 4096 (PAGE_SIZE). It starts giving DMA error.  Without IOMMU it works fine.
> This is not a bug.  The network stack can and will feed us such
> SG lists.
>
>> 2) It cannot be driver's responsibilty to update received sg entries to adjust offset and page 
>> because we are not the only one who directly uses received sg list.
> No the driver must deal with this.  Having said that, if we can
> improve our driver helper interface to make this easier then we
> should do that too.  What we certainly shouldn't do is to take a
> whack-a-mole approach like this patch does.
Agreed,I added that patch for understanding purpose only. Today I referred other crypto driver for DMA related code. Most of them are using dma_map_sg except QAT. In QAT, They are first updating the Page address using offset then mapping each page in for loop with dma_map_single(0. I will try the same in chelsio driver will see the behavior.
>
> Cheers,
