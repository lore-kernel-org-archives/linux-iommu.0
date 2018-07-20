From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: use the generic dma-noncoherent code for microblaze
Date: Fri, 20 Jul 2018 14:33:44 +0200
Message-ID: <434e2ef1-3e3f-46d5-a7d1-62ed0e217da0@xilinx.com>
References: <20180719125440.424-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719125440.424-1-hch@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 19.7.2018 14:54, Christoph Hellwig wrote:
> Hi Michal,
> 
> can you review these patches to switch microblaze to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.
> 

I can't see any issue with them.
Both applied to next.

Thanks,
Michal
