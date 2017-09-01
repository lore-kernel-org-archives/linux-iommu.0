From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/vt-d: Don't be too aggressive when clearing one
 context entry
Date: Fri, 1 Sep 2017 11:31:07 +0200
Message-ID: <20170901093107.dk5tt7jcgvbrbjpm@8bytes.org>
References: <1503929789-26698-1-git-send-email-sironi@amazon.de>
 <1504169891-9480-1-git-send-email-sironi@amazon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504169891-9480-1-git-send-email-sironi@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Filippo Sironi <sironi@amazon.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 31, 2017 at 10:58:11AM +0200, Filippo Sironi wrote:
> Previously, we were invalidating context cache and IOTLB globally when
> clearing one context entry.  This is a tad too aggressive.
> Invalidate the context cache and IOTLB for the interested device only.
> 
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iommu/intel-iommu.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)

Applied, thanks.
