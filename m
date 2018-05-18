From: Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Fri, 18 May 2018 16:02:46 -0500
Message-ID: <3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
 <20180515134603.GD18595@8bytes.org>
 <4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
 <89a0e3af-8970-cd80-418d-630841795807@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89a0e3af-8970-cd80-418d-630841795807@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/18/2018 11:49 AM, Randy Dunlap wrote:
> On 05/18/2018 08:20 AM, Gary R Hook wrote:
>> On 05/15/2018 08:46 AM, Joerg Roedel wrote:
>>> On Mon, May 14, 2018 at 03:00:50PM -0500, Gary R Hook wrote:
>>>> This was brought up a few weeks ago in, I believe, version 3 of this patch.
>>>> That question was discussed (because that's what I did the first time out),
>>>> and _someone_ _else_ asked about why I didn't just do it the way I've done
>>>> it here.
>>>
>>> You don't have this problem if you put the code in amd_iommu.c in an
>>> IOMMU_DEBUGFS ifdef.
>>
>> Of course. My preference, however, is a separate file to avoid size creep. That's why I've done it this way.
>>
>> To whit: there have been threads discussing the advisability/acceptability of using #ifdefs for debug code. My take-away was to avoid them. Perhaps I misunderstood.
>>
>> So: I don't understand your comment. Is this an observation, or is it an imperative statement? I'd like for a maintainer to clearly indicate what is acceptable, and I'll do it.
>>
>>
> 
> Hi,
> I looked back at Robin Murphy's comments on April 17:
> 
> <quote>
> Well, you could do a makefile-level dependency i.e.:
> 
> ifeq ($(CONFIG_IOMMU_DEBUG), y)
> obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
> obj-$(CONFIG_BLAH_IOMMU) += blah_iommu_debugfs.o
> ...
> endif
> 
> Or alternatively have an intermediate silent Kconfig option:
> 
> config AMD_IOMMU_DEBUG
> 	def_bool y
> 	depends on AMD_IOMMU && IOMMU_DEBUG
> 
> The makefile option is arguably ugly, but does at least scale better ;)
> </quote>
> 
> 
> I think the Kconfig option would have been the correct choice.

"Preferred", perhaps. Neither is incorrect. And really, the 
Makefile/Kconfig choice is somewhat separate from the organization issue.

So I've made the changes for this. Now I'm waiting on Joerg to make a 
decision on the code/file organization. I still prefer a separate file 
for the debug fs code.
