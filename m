From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [v4 0/8] Add VT-d Posted-Interrupts support - IOMMU part
Date: Thu, 2 Apr 2015 13:28:33 +0200
Message-ID: <20150402112833.GN4441@8bytes.org>
References: <1422864424-19411-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422864424-19411-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>
Cc: dwmw2@infradead.org, jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Li, Zhen-Hua" <zhen-hual@hp.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 02, 2015 at 04:06:56PM +0800, Feng Wu wrote:
> VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
> With VT-d Posted-Interrupts enabled, external interrupts from
> direct-assigned devices can be delivered to guests without VMM
> intervention when guest is running in non-root mode.
> 
> You can find the VT-d Posted-Interrtups Spec. in the following URL:
> http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html
> 
> This series was part of http://thread.gmane.org/gmane.linux.kernel.iommu/7708. To make things clear, send out IOMMU part here.

Besides the modify_irte() changes I asked for the patch-set looks good.
I just have some concerns what these changes mean for the VT-d kdump
improvements Zhen-Hua Li is working on. Can you please discuss the
implications of having both patch-sets applied with him and make sure
they work together? I think in its current form your patch-set breaks
the kdump support patches. I added Zhen-Hua to Cc.

Thanks,

	Joerg
