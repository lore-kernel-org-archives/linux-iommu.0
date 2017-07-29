From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 0/4] iommu/tegra: gart: Couple corrections
Date: Sat, 29 Jul 2017 14:04:36 +0300
Message-ID: <430af3ab-29cd-bbe8-087d-82d8113d2a89@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
 <20170725144335.GC30429@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170725144335.GC30429-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 25.07.2017 17:43, Joerg Roedel wrote:
> On Wed, Jul 05, 2017 at 07:29:44PM +0300, Dmitry Osipenko wrote:
>> I've added an experimental support of the GART to the Tegra DRM driver
>> and it ended up with a very positive result. During the testing of the
>> GART driver I've noticed couple of its minor shortcomings, so here the
>> patches to remedy them.
>>
>> Dmitry Osipenko (4):
>>   iommu/tegra: gart: Don't unnecessarily allocate registers context
>>   iommu/tegra: gart: Check whether page is already mapped
>>   iommu/tegra: gart: Move PFN validation out of spinlock
>>   iommu/tegra: gart: Correct number of unmapped bytes
> 
> Patches look good to me (except patch 1, which I am not sure about, but
> maybe only due my limited knowledge about the hardware).
> 
> So I take them when Thierry gives his Acked-by.
> 

Okay, Thierry should get to this patchset eventually.

-- 
Dmitry
