From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 2 Dec 2015 14:59:31 +0100
Message-ID: <20151202135931.GF3783@pd.tnic>
References: <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
 <565ED81B.3020606@profitbricks.com>
 <20151202115142.GD18805@8bytes.org>
 <565EE4AA.4070309@profitbricks.com>
 <20151202125315.GB3910@pd.tnic>
 <565EEBC3.5050807@profitbricks.com>
 <20151202131300.GC3910@pd.tnic>
 <565EEFB4.4080108@profitbricks.com>
 <20151202134047.GE3783@pd.tnic>
 <565EF6BF.6020204@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565EF6BF.6020204@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <yun.wang@profitbricks.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@gmail.com>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 02, 2015 at 02:48:47PM +0100, Michael Wang wrote:
> I'm not sure why amd-iommu use get_page not kmalloc to initialize the
> pointer table, but if it's necessary then the conflict will be there,
> it's not the fault of driver or kmemleak, but the design require them
> to cooperate with each other.

So, according to you, we should go and "fix" all callers of
__get_free_pages() to make kmemleak happy. Then when the next new tool
comes along, we should "fix" another kernel API just so that the tools
are happy.

Bzzt. Wrong!

The tools should work without sprinkling their code everywhere. Driver
etc developers don't need to care about what tool they make happy or
not. Tools' hooks should be hidden in macro magic so that developers
don't care.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
