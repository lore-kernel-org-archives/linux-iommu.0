From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] fix flush_tlb_all typo
Date: Tue, 26 Feb 2019 10:21:06 +0100
Message-ID: <20190226092106.GB19617@8bytes.org>
References: <20190211155033.7850-1-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211155033.7850-1-murphyt7@tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 11, 2019 at 03:50:33PM +0000, Tom Murphy wrote:
> Fix typo, flush_tlb_all should be flush_iotlb_all
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>

Applied, thanks.
