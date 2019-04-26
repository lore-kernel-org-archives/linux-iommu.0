From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Don't request page request irq under
 dmar_global_lock
Date: Fri, 26 Apr 2019 16:45:21 +0200
Message-ID: <20190426144521.GI24576@8bytes.org>
References: <20190419064329.17946-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419064329.17946-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 19, 2019 at 02:43:29PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel-iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.
