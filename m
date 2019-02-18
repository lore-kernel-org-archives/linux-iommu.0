From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Mon, 18 Feb 2019 17:01:59 +0000
Message-ID: <2cc5674a-a3a0-d8fe-65f5-4357da9b85d3@arm.com>
References: <CAKxU2N9o5WeUwFMUwwXKHaPj7R+oiSKV1c2n8RtXwGNZRtw5Sw@mail.gmail.com>
 <CAJ0CqmVNF83bWgc+LSQ3_i=zfp-sXC5Nf=nKfqB3SWa8r7sKdQ@mail.gmail.com>
 <83A1D243-9073-48D1-9F26-5A2581DCB829@gmail.com>
 <CAJ0CqmUgPWNJtCW4Q__sOtB8w-YtwW+uZy7crxMNrmSgQ6OFyA@mail.gmail.com>
 <1547404075.1582.0@smtp.gmail.com>
 <CAJ0CqmU7k5i26g7dGPxNdts7Gm67W6qNsr4vYuW05ugsEF1ohw@mail.gmail.com>
 <CAKxU2N-+CTaRdJMFVRdozJ5TTpN+_4thiDRBJBFq8gGtuRVYvA@mail.gmail.com>
 <20190114091841.GA23045@localhost.localdomain>
 <CAKxU2N8ioMszBCyQcH7CVhgBdW4aj7yZ+kYQe14DCV5OSAnxrg@mail.gmail.com>
 <20190115090400.GA2267@localhost.localdomain>
 <20190218143742.GA11872@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218143742.GA11872@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Samuel Sieb <samuel@sieb.net>, linux-wireless <linux-wireless@vger.kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Rosen Penev <rosenp@gmail.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 18/02/2019 14:37, Stanislaw Gruszka wrote:
[...]
> Another issue is that dma_map_sg() & dma_map_page() may require some
> constraints. I'm not sure about that and I want to clarify that with
> CCed mm maintainers. I think DMA drivers may expect sg->offset < PAGE_SIZE
> for both dma_map_sg() and dma_map_page(). Additionally dma_map_page()
> maight expect that offset & length specify buffer within one page.

Luckily, this came up a while back[1] and we seemed to reach a consensus 
that sg->offset >= PAGE_SIZE for dma_map_sg() was weird but valid. IIRC 
it was only the Intel IOMMU code which failed to handle that case 
appropriately (and which I fixed) - the AMD IOMMU code always looked 
like it should be OK, but I'm not sure I've ever seen definitive test 
results (and I don't have hardware to do so myself).

For dma_map_page(), length >= PAGE_SIZE should be perfectly valid and 
handled correctly. The offset >= PAGE_SIZE case is a bit harder to 
justify, but at the same time has less scope for the DMA API backend to 
get it wrong, so either way is likely to be OK in practice (in 
particular the AMD IOMMU code looks like it won't have a problem, since 
its map_page() implementation converts page and offset to a plain 
physical address before doing anything else).

Robin.

[1] 
https://lists.linuxfoundation.org/pipermail/iommu/2017-September/024148.html
