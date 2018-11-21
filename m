From: Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/9] Use vm_insert_range
Date: Wed, 21 Nov 2018 14:37:24 -0500
Message-ID: <0c6f1144-6ee0-29df-5e1f-d35d2264e06e@oracle.com>
References: <20181115154314.GA27850@jordon-HP-15-Notebook-PC>
 <CAFqt6zZGP5DnAQd_19xKcLezOYaLsZpPr=FGxiTb7JRjTEJ4cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAFqt6zZGP5DnAQd_19xKcLezOYaLsZpPr=FGxiTb7JRjTEJ4cA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, vbabka-AlSwsSmVLrQ@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, stefanr-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, airlied-cv59FeDIM0c@public.gmane.org, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/21/18 1:24 AM, Souptick Joarder wrote:
> On Thu, Nov 15, 2018 at 9:09 PM Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Previouly drivers have their own way of mapping range of
>> kernel pages/memory into user vma and this was done by
>> invoking vm_insert_page() within a loop.
>>
>> As this pattern is common across different drivers, it can
>> be generalized by creating a new function and use it across
>> the drivers.
>>
>> vm_insert_range is the new API which will be used to map a
>> range of kernel memory/pages to user vma.
>>
>> All the applicable places are converted to use new vm_insert_range
>> in this patch series.
>>
>> Souptick Joarder (9):
>>   mm: Introduce new vm_insert_range API
>>   arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
>>   drivers/firewire/core-iso.c: Convert to use vm_insert_range
>>   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
>>   drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
>>   iommu/dma-iommu.c: Convert to use vm_insert_range
>>   videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range
>>   xen/gntdev.c: Convert to use vm_insert_range
>>   xen/privcmd-buf.c: Convert to use vm_insert_range
> Any further comment on driver changes ?

Xen drivers (the last two patches) look fine to me.

-boris


>>  arch/arm/mm/dma-mapping.c                         | 21 ++++++-----------
>>  drivers/firewire/core-iso.c                       | 15 ++----------
>>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 20 ++--------------
>>  drivers/gpu/drm/xen/xen_drm_front_gem.c           | 20 +++++-----------
>>  drivers/iommu/dma-iommu.c                         | 12 ++--------
>>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 ++++++-------------
>>  drivers/xen/gntdev.c                              | 11 ++++-----
>>  drivers/xen/privcmd-buf.c                         |  8 ++-----
>>  include/linux/mm_types.h                          |  3 +++
>>  mm/memory.c                                       | 28 +++++++++++++++++++++++
>>  mm/nommu.c                                        |  7 ++++++
>>  11 files changed, 70 insertions(+), 98 deletions(-)
>>
>> --
>> 1.9.1
>>
