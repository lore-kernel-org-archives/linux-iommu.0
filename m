From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Wed, 5 Dec 2018 16:47:10 +0100
Message-ID: <20181205154710.GB16835@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
 <20181203134411.lejlkbnagxml54ro@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 03, 2018 at 05:23:40PM +0000, Liu, Yi L wrote:
> So for a device without PASID support, we need to at least to have a PASID
> entry so that its DMA request (without pasid) can be translated. Thus a PASID
> table is needed for such devices.

That makes sense, thanks for the explanation.


	Joerg
