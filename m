From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Date: Wed, 30 Jan 2019 17:24:33 +0100
Message-ID: <20190130162433.ac3gzibnurwgubzf@8bytes.org>
References: <20190124023132.20410-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124023132.20410-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2019 at 10:31:32AM +0800, Lu Baolu wrote:
> Commit 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable
> mode capability") enables VT-d scalable mode if hardware
> advertises the capability. As we will bring up different
> features and use cases to upstream in different patch
> series, it will leave some intermediate kernel versions
> which support partial features. Hence, end user might run
> into problems when they use such kernels on bare metals
> or virtualization environments.
> 
> This leaves scalable mode default off and end users could
> turn it on with "intel-iommu=sm_on" only when they have
> clear ideas about which scalable features are supported
> in the kernel.
> 
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied to iommu/fixes, thanks.
