From: Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
Date: Tue, 3 Jul 2018 19:59:20 +0100
Message-ID: <CAJwJo6Z8jGFdb0ZEUNFt+T7HiLvS69w6_QC9qVs9TqiJ7+sjTw@mail.gmail.com>
References: <20180621180823.805-1-dima@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: open list <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Any opinion on that?
It looks to remove a source of possible issues and
has a nice diffstat.

2018-06-21 19:08 GMT+01:00 Dmitry Safonov <dima@arista.com>:
> find_iova() looks to be using a bad locking practice: it locks the
> returned iova only for the search time.
> And looking in code, the element can be removed from the tree and freed
> under rbtree lock. That happens during memory hot-unplug and cleanup on
> module removal.
> Here I cleanup users of the function and delete it.
>
> Dmitry Safonov (3):
>   iommu/iova: Find and split iova under rbtree's lock
>   iommu/iova: Make free_iova() atomic
>   iommu/iova: Remove find_iova()
>
>  drivers/iommu/intel-iommu.c | 14 +++----------
>  drivers/iommu/iova.c        | 48 +++++++++++++++++----------------------------
>  include/linux/iova.h        | 17 ++++------------
>  3 files changed, 25 insertions(+), 54 deletions(-)
>

Thanks,
             Dmitry
