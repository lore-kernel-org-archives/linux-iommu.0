From: Michael Wang <yun.wang@profitbricks.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 2 Dec 2015 14:18:44 +0100
Message-ID: <565EEFB4.4080108@profitbricks.com>
References: <5655D072.1000901@profitbricks.com>
 <565EC9F4.2050401@profitbricks.com>
 <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
 <565ECE54.5080706@profitbricks.com>
 <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
 <565ED81B.3020606@profitbricks.com> <20151202115142.GD18805@8bytes.org>
 <565EE4AA.4070309@profitbricks.com> <20151202125315.GB3910@pd.tnic>
 <565EEBC3.5050807@profitbricks.com> <20151202131300.GC3910@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151202131300.GC3910@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@gmail.com>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Borislav

On 12/02/2015 02:13 PM, Borislav Petkov wrote:
> On Wed, Dec 02, 2015 at 02:01:55PM +0100, Michael Wang wrote:
>> Yeah.. it's a little complicated since we have our own kernel tree and this
>> won't be a problem for us, but we really prefer to help fix it in mainline
>> too, as long as this is really a defect, so others could save time on research
>> in future.
> 
> Well, to keep it realistic and if it were me, I wouldn't even take such
> a fix as it is apparently kmemleak's problem.

Do you mean this could be a real kmemleak? Could you please provide more details?

> 
> So you could fix your testing instead to ignore that error message now
> that you know it is a false-positive. That should be easiest.
> 

Yeah, but it would be better to solve it, otherwise whoever saw this report
will need to go into the amd-iommu, make sure it's not a real leak, then
change their testing script...

Regards,
Michael Wang
