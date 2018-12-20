From: Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and
 tlb_sync to iotlb_sync
Date: Thu, 20 Dec 2018 15:47:28 +0000
Message-ID: <CALQxJutDpN6SagB89=cPvNczmD8kRXwaq-yzor7kULU4iLt2uA@mail.gmail.com>
References: <20181204182734.20184-1-murphyt7@tcd.ie> <20181205160439.bjbh7stdey32hjgj@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205160439.bjbh7stdey32hjgj@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Ah shoot, it looks like I forgot to change flush_tlb_all -> flush_iotlb_all

Should I submit another patch?

On Wed, 5 Dec 2018 at 16:04, Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Dec 04, 2018 at 06:27:34PM +0000, Tom Murphy wrote:
> > From: tom <murphyt7@tcd.ie>
> >
> > Someone forgot to update this comment.
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> > ---
> >  include/linux/iommu.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Applied, thanks.
