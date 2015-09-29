From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] iommu: Add support for out of band flushing
Date: Tue, 29 Sep 2015 20:56:12 +0900
Message-ID: <CAAFQd5B-0T9wtYdEhTOy-gLJn5eDfw1PphgoH7uvQwBSD0YrRg@mail.gmail.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
 <1443504379-31841-2-git-send-email-tfiga@chromium.org> <20150929093257.GE9460@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150929093257.GE9460-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 29, 2015 at 6:32 PM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Sep 29, 2015 at 02:25:24PM +0900, Tomasz Figa wrote:
>> This patch adds a new "flush" callback to iommu_ops, which is supposed
>> to perform any necessary flushes within given IOMMU domain to make any
>> changes to mappings of given area [iova; iova + size) be reflected to
>> IOMMU clients.
>>
>> The purpose is to let IOMMU drivers skip page-by-page flushes and
>> replace it with one flush of full address range on devices which support
>> it.
>>
>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>  drivers/iommu/iommu.c | 33 ++++++++++++++++++++++++++++++---
>>  include/linux/iommu.h |  2 ++
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> I seem to remember that Rob Clark had proposed something like this back
> before it was decided to introduce the ->map_sg() callback instead. I
> can't find a reference to the discussion, so perhaps I'm misremembering
> but adding Rob Clark in case he has any recollection of why the outcome
> was what it was.

Oops, I was supposed to add Rob, but forgot in the end. Thanks for remembering.

>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> [...]
>> @@ -1389,6 +1410,7 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>               unmapped += unmapped_page;
>>       }
>>
>> +     iommu_flush(domain, orig_iova, unmapped);
>>       trace_unmap(orig_iova, size, unmapped);
>>       return unmapped;
>>  }
>> @@ -1419,19 +1441,24 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>>               if (!IS_ALIGNED(s->offset, min_pagesz))
>>                       goto out_err;
>>
>> -             ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
>> +             ret = __iommu_map(domain, iova + mapped, phys, s->length, prot);
>>               if (ret)
>>                       goto out_err;
>>
>>               mapped += s->length;
>>       }
>>
>> +     iommu_flush(domain, iova, mapped);
>> +
>>       return mapped;
>>
>>  out_err:
>>       /* undo mappings already done */
>>       iommu_unmap(domain, iova, mapped);
>>
>> +     /* flush in case part of our mapping already got cached */
>> +     iommu_flush(domain, iova, mapped);
>> +
>>       return 0;
>>
>>  }
>
> iommu_unmap() already does an iommu_flush(), so why flush again after
> iommu_unmap()?

Right, my mistake. This should be removed. Thanks for catching.

Best regards,
Tomasz
