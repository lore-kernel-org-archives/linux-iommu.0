From: Qian Cai <cai@lca.pw>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
Date: Tue, 30 Apr 2019 21:41:56 -0400
Message-ID: <61d3a8d6-48b0-0ec4-82e0-10c67ad9dcd7@lca.pw>
References: <1556290348.6132.6.camel@lca.pw> <20190426152632.GC3173@suse.de>
 <1556294112.6132.7.camel@lca.pw> <20190429142326.GA4678@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429142326.GA4678@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 4/29/19 10:23 AM, Joerg Roedel wrote:
> On Fri, Apr 26, 2019 at 11:55:12AM -0400, Qian Cai wrote:
>> https://git.sr.ht/~cai/linux-debug/blob/master/dmesg
> 
> Thanks, I can't see any definitions for unity ranges or exclusion ranges
> in the IVRS table dump, which makes it even more weird.
> 
> Can you please send me the output of
> 
> 	for f in `ls -1 /sys/kernel/iommu_groups/*/reserved_regions`; do echo "---$f"; cat $f;done
> 
> to double-check?

It is going to take a while to reserve that system again to gather the
information. BTW, this is only reproducible on linux-next but not mainline.
