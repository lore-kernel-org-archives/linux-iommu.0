From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] Refactor dummy DMA ops
Date: Fri, 7 Dec 2018 17:35:04 +0000
Message-ID: <84be56f9-d195-78c3-df4d-7e0c1f71e4d9@arm.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
 <20181207170519.GA26857@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207170519.GA26857@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, m.szyprowski@samsung.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 07/12/2018 17:05, Christoph Hellwig wrote:
> So I'd really prefer if we had a separate dummy.c file, like in
> my take on your previous patch here:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/e01adddc1733fa414dc16cd22e8f58be9b64a025
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/596bde76e5944a3f4beb8c2769067ca88dda127a
> 
> Otherwise this looks fine.  If you don't minde I'll take your patches,
> apply the move to a separate file and merge it into the above tree.

Sure - TBH I did consider creating a separate file, but then didn't for 
mysterious reasons that don't stand up to scrutiny. If you're happy to 
do the fixup on top that's fine by me (if culling .map_resource was 
intentional, please scrub the last bit of the commit message to match).

I'll make the equivalent change locally anyway just in case there's any 
other cause to resend.

Robin.
