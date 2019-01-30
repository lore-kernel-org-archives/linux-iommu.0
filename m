From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove change_pte notifier
Date: Wed, 30 Jan 2019 17:32:00 +0100
Message-ID: <20190130163159.t2633rwpjbffjyvz@8bytes.org>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-2-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130055758.3994-2-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Xu <peterx@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 01:57:57PM +0800, Peter Xu wrote:
> The change_pte() interface is tailored for PFN updates, while the
> other notifier invalidate_range() should be enough for Intel IOMMU
> cache flushing.  Actually we've done similar thing for AMD IOMMU
> already in 8301da53fbc1 ("iommu/amd: Remove change_pte mmu_notifier
> call-back", 2014-07-30) but the Intel IOMMU driver still have it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Applied to x86/vt-d, thanks.
