From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
 prq_event_thread()
Date: Tue, 6 Nov 2018 16:48:42 +0100
Message-ID: <20181106154842.f7wqijqesjuuqk7n@8bytes.org>
References: <20181105021858.16958-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105021858.16958-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Sohil Mehta <sohil.mehta@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 05, 2018 at 10:18:58AM +0800, Lu Baolu wrote:
> When handling page request without pasid event, go to "no_pasid"
> branch instead of "bad_req". Otherwise, a NULL pointer deference
> will happen there.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for v4.20, thanks.
