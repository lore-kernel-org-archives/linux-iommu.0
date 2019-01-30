From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Date: Wed, 30 Jan 2019 17:31:10 +0100
Message-ID: <20190130163110.muqt3wt2bpvmyseq@8bytes.org>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130055758.3994-3-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Xu <peterx@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 01:57:58PM +0800, Peter Xu wrote:
> AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> but that's actually already covered by invalidate_range().  Remove the
> extra notifier and the chunks.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Applied to x86/amd, thanks.
