From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Support page request in scalable mode
Date: Fri, 11 Jan 2019 12:29:41 +0100
Message-ID: <20190111112941.nv6p2veleipwyirs@8bytes.org>
References: <20190111050457.27234-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190111050457.27234-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu Yi L <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 11, 2019 at 01:04:57PM +0800, Lu Baolu wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> VT-d Rev3.0 has made a few changes to the page request interface,
> 
> 1. widened PRQ descriptor from 128 bits to 256 bits;
> 2. removed streaming response type;
> 3. introduced private data that requires page response even the
>    request is not last request in group (LPIG).
> 
> This is a supplement to commit 1c4f88b7f1f92 ("iommu/vt-d: Shared
> virtual address in scalable mode") and makes the svm code compliant
> with VT-d Rev3.0.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied for v5.1, thanks.
