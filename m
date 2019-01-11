From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and
 tlb_sync to iotlb_sync
Date: Fri, 11 Jan 2019 11:05:43 +0100
Message-ID: <20190111100543.GD5825@8bytes.org>
References: <20181204182734.20184-1-murphyt7@tcd.ie>
 <20181205160439.bjbh7stdey32hjgj@8bytes.org>
 <CALQxJutDpN6SagB89=cPvNczmD8kRXwaq-yzor7kULU4iLt2uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALQxJutDpN6SagB89=cPvNczmD8kRXwaq-yzor7kULU4iLt2uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 20, 2018 at 03:47:28PM +0000, Tom Murphy wrote:
> Ah shoot, it looks like I forgot to change flush_tlb_all -> flush_iotlb_all
> 
> Should I submit another patch?

Yes, please.
