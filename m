From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Disable ATS support on untrusted devices
Date: Sat, 2 Mar 2019 10:29:28 +0200
Message-ID: <20190302082928.GX4511@lahna.fi.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
 <20190301032313.9311-2-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190301032313.9311-2-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 01, 2019 at 11:23:10AM +0800, Lu Baolu wrote:
> Commit fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted
> devices") disables ATS support on the devices which have been marked
> as untrusted. Unfortunately this is not enough to fix the DMA attack
> vulnerabiltiies because IOMMU driver allows translated requests as
> long as a device advertises the ATS capability. Hence a malicious
> peripheral device could use this to bypass IOMMU.
> 
> This disables the ATS support on untrusted devices by clearing the
> internal per-device ATS mark. As the result, IOMMU driver will block
> any translated requests from any device marked as untrusted.
> 
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
