From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 2 Dec 2015 13:53:15 +0100
Message-ID: <20151202125315.GB3910@pd.tnic>
References: <564F051E.9010703@profitbricks.com>
 <20151125150806.GG2064@8bytes.org>
 <5655D072.1000901@profitbricks.com>
 <565EC9F4.2050401@profitbricks.com>
 <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
 <565ECE54.5080706@profitbricks.com>
 <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
 <565ED81B.3020606@profitbricks.com>
 <20151202115142.GD18805@8bytes.org>
 <565EE4AA.4070309@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565EE4AA.4070309@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <yun.wang@profitbricks.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@gmail.com>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 02, 2015 at 01:31:38PM +0100, Michael Wang wrote:
> It's not my work or your work... it's a defect in the module and maintainer
> should take responsibility on fixing it, correct?

Well, you said "actually we just want to get rid of this annoying report
on obj won't leak..."

It sounds to me like you want to have something fixed. So you do the
patch properly, add to the commit message why exactly you're doing it
and test it. Like everyone else.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
