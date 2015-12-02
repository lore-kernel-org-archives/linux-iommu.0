From: Michael Wang <yun.wang@profitbricks.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 2 Dec 2015 14:48:47 +0100
Message-ID: <565EF6BF.6020204@profitbricks.com>
References: <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
 <565ECE54.5080706@profitbricks.com>
 <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
 <565ED81B.3020606@profitbricks.com> <20151202115142.GD18805@8bytes.org>
 <565EE4AA.4070309@profitbricks.com> <20151202125315.GB3910@pd.tnic>
 <565EEBC3.5050807@profitbricks.com> <20151202131300.GC3910@pd.tnic>
 <565EEFB4.4080108@profitbricks.com> <20151202134047.GE3783@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151202134047.GE3783@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@gmail.com>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 12/02/2015 02:40 PM, Borislav Petkov wrote:
> On Wed, Dec 02, 2015 at 02:18:44PM +0100, Michael Wang wrote:
[snip]
> 
>> Yeah, but it would be better to solve it, otherwise whoever saw this
>> report will need to go into the amd-iommu, make sure it's not a real
>> leak, then change their testing script...
> 
> No, you don't need to go into the iommu - you need to fix kmemleak.
> 
> And frankly, I'm getting sick and tired of all those tools needing
> special handling and us adding code just so that they're happy. If the
> tools can't figure out something, they shouldn't warn just in case but
> shut up instead.

If you mean the design of kmemleak, IMHO it's not that bad.

The problem is regarding performance, think about if kmemleak go into
every page to find out pointers, I guess the whole system will stuck.

I'm not sure why amd-iommu use get_page not kmalloc to initialize the pointer
table, but if it's necessary then the conflict will be there, it's not the fault
of driver or kmemleak, but the design require them to cooperate with each
other.

Regards,
Michael Wang

> 
