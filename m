From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 25 Nov 2015 16:08:06 +0100
Message-ID: <20151125150806.GG2064@8bytes.org>
References: <564EFF6A.2050709@profitbricks.com>
 <564F051E.9010703@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564F051E.9010703@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <yun.wang@profitbricks.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 20, 2015 at 12:33:50PM +0100, Michael Wang wrote:
> The kmemleak testing on 3.18.24 show:
> 
> unreferenced object 0xffff880233ff9010 (size 16):
>   comm "swapper/0", pid 1, jiffies 4294937440 (age 2010.490s)
>   hex dump (first 16 bytes):
>     0a 0a 00 00 20 00 00 00 00 44 fb 33 02 88 ff ff  .... ....D.3....
>   backtrace:
>     [<ffffffff8118192d>] create_object+0x10d/0x2d0
>     [<ffffffff815c2d4b>] kmemleak_alloc+0x5b/0xc0
>     [<ffffffff8116dd19>] kmem_cache_alloc_trace+0xb9/0x160
>     [<ffffffff814ffe51>] get_irq_table+0x151/0x380
> 
> This is caused by the 'irq_lookup_table' was allocated with
> __get_free_pages() which won't create kmemleak object, thus it's
> pointers won't be count as referencing 'irq_remap_table' in
> kmemleak scan.

Isn't it better to allocate the kmemleak object manually instead of
ignoring all irq-table pointers? With this patch we might not notice any
real leak of irq-tables.



	Joerg
