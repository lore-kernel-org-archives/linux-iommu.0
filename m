From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v4 08/12] iommu/vt-d: Pass pasid table to context mapping
Date: Wed, 7 Nov 2018 07:25:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FB28@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-9-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105053151.7173-9-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Monday, November 5, 2018 1:32 PM
> Subject: [PATCH v4 08/12] iommu/vt-d: Pass pasid table to context mapping
> 
> So that the pasid related info, such as the pasid table and the
> maximum of pasid could be used during setting up scalable mode
> context.

A little bit refine. Wish it helps. :)
"This patch passes the pasid related info(e.g. the pasid table and the
maximum of pasid) to context mapping, so that pasid related fields
can be setup accordingly in scalable mode context entry."

Regards,
Yi Liu
