From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 2 Dec 2015 14:40:48 +0100
Message-ID: <20151202134047.GE3783@pd.tnic>
References: <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
 <565ECE54.5080706@profitbricks.com>
 <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
 <565ED81B.3020606@profitbricks.com>
 <20151202115142.GD18805@8bytes.org>
 <565EE4AA.4070309@profitbricks.com>
 <20151202125315.GB3910@pd.tnic>
 <565EEBC3.5050807@profitbricks.com>
 <20151202131300.GC3910@pd.tnic>
 <565EEFB4.4080108@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565EEFB4.4080108@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <yun.wang@profitbricks.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@gmail.com>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 02, 2015 at 02:18:44PM +0100, Michael Wang wrote:
> Do you mean this could be a real kmemleak? Could you please provide
> more details?

Did you read Joerg's last mail?

> Yeah, but it would be better to solve it, otherwise whoever saw this
> report will need to go into the amd-iommu, make sure it's not a real
> leak, then change their testing script...

No, you don't need to go into the iommu - you need to fix kmemleak.

And frankly, I'm getting sick and tired of all those tools needing
special handling and us adding code just so that they're happy. If the
tools can't figure out something, they shouldn't warn just in case but
shut up instead.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
