From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v4 06/12] iommu/vt-d: Add second level page table
 interface
Date: Wed, 7 Nov 2018 07:13:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FB11@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-7-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105053151.7173-7-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Monday, November 5, 2018 1:32 PM
> 
> This adds the interfaces to setup or tear down the structures
> for second level page table translations. This includes types
> of second level only translation and pass through.

A little bit refining to the description:)
"This patch adds interfaces for setup or tear down second level
translation in PASID granularity. Translation type includes second
level only type and pass-through type."

> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>

[...]

> +
> +void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> +				 struct device *dev, int pasid)
> +{
> +	struct pasid_entry *pte;

pte is confusing as it is similar with pte in paging structures. may use
pt_entry or just pasid_entry. This comment applies to other "pte"s in
this patch.

Thanks,
Yi Liu
