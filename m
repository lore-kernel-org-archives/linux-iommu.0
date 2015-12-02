From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for kmemleak
Date: Wed, 2 Dec 2015 11:31:02 +0000
Message-ID: <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
References: <564EFF6A.2050709@profitbricks.com> <564F051E.9010703@profitbricks.com>
 <20151125150806.GG2064@8bytes.org> <5655D072.1000901@profitbricks.com>
 <565EC9F4.2050401@profitbricks.com> <CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
 <565ECE54.5080706@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <565ECE54.5080706@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Wang <yun.wang@profitbricks.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 2 December 2015 at 10:56, Michael Wang <yun.wang@profitbricks.com> wrote:
> On 12/02/2015 11:52 AM, Catalin Marinas wrote:
>>> Is there any more concern? actually we just want to get rid of this
>>> annoying report on obj won't leak, if you're going to create obj for
>>> 'irq_lookup_table' that's also fine for us, or will you pick this patch?
>>
>> My preference (from a kmemleak perspective) is to tell kmemleak about
>> the irq_lookup_table. Untested:
>
> I'm fine with both solution, will leave the decision to maintainer :-)
>
> BTW, could you please send a formal patch with descriptions?

I could copy your description but I don't currently have a way (nor
time) to test the patch. If you plan to test it anyway, please feel
free to include my diff (which I guess was badly re-formatted by
gmail), I don't really mind which author it is (I found it easier to
show a diff than explain in plain English ;)).

-- 
Catalin
