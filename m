From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Date: Fri, 9 Nov 2018 08:49:55 +0100
Message-ID: <20181109074955.GA27489@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de> <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: hch@lst.de, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, robin.murphy@arm.com, konrad.wilk@oracle.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Valentin Schneider <valentin.schneider@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
> swiotlb_map_sg_attrs", I reproduce the hangs.
> 
> Any suggestions for how to further debug what might be going wrong
> would be appreciated!

Very odd.  In the end map_sg and map_page are defined to do the same
things to start with.  The only real issue we had in this area was:

"[PATCH v2] of/device: Really only set bus DMA mask when appropriate"

so with current mainline + that you still see a problem, and if you
rever the commit we are replying to it still goes away?
