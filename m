From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4] iommu/vt-d: Several fixes for 5.1
Date: Fri, 1 Mar 2019 10:24:01 +0100
Message-ID: <20190301092401.GA10516@8bytes.org>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 01, 2019 at 11:23:09AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> This includes several small fixes. All are stable kernel irrelated.
> Please consider it for 5.1-rc1.
> 
> Best regards,
> Lu Baolu
> 
> Lu Baolu (4):
>   iommu/vt-d: Disable ATS support on untrusted devices
>   iommu/vt-d: Set context field after value initialized
>   iommu/vt-d: Fix NULL pointer reference in intel_svm_bind_mm()
>   iommu/vt-d: Get domain ID before clear pasid entry

Applied, thanks.
