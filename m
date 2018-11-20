From: Yi Sun <yi.y.sun@linux.intel.com>
Subject: Re: [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation
Date: Tue, 20 Nov 2018 10:29:47 +0800
Message-ID: <20181120022946.GA27998@yi.y.sun>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
 <20181119163648.GD31468@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119163648.GD31468@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 18-11-19 11:36:48, Konrad Rzeszutek Wilk wrote:
> On Mon, Nov 12, 2018 at 02:44:56PM +0800, Lu Baolu wrote:
> > This adds an uniformed API set for global PASIDs used by IOMMU
> > and device drivers which depend on IOMMU. It works for drivers
> > running on bare metal, full virtualized environments and para-
> > virtualized environment.
> > 
> 
> Are there also some QEMU patches for this in RFC state?

Yes, we already have draft codes and are working on refining
them. Will send patches out for your review. Thanks!
