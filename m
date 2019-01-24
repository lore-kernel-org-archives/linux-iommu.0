From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 2/8] iommu/vt-d: Add per-device IOMMU feature ops
 entries
Date: Thu, 24 Jan 2019 14:20:39 +0100
Message-ID: <20190124132038.qqmwxq7yqm3ejen4@8bytes.org>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
 <20190110030027.31447-3-baolu.lu@linux.intel.com>
 <20190111111644.epawu474jdjv4a33@8bytes.org>
 <b96994da-b3bd-1321-b45f-4c9c1fc4b0c4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b96994da-b3bd-1321-b45f-4c9c1fc4b0c4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng@8bytes.org, Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Lu Baolu,

On Thu, Jan 24, 2019 at 02:47:39PM +0800, Lu Baolu wrote:
> bool iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)?

Looks good. Having a function to check for enabled features is certainly
a good thing.

Regards,

	Joerg
