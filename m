From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Date: Tue, 23 Apr 2019 11:53:29 +0100
Message-ID: <eb6e62aa-ae1f-ab09-e477-c84ab5143881@arm.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190415143711.13c29308@x1.home> <20190415161015.564cb071@jacob-builder>
 <70c6b197-029e-94cd-2745-d4a193cbbcd0@arm.com>
 <20190418212958.65975103@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418212958.65975103@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 19/04/2019 05:29, Jacob Pan wrote:
> If it is OK with you, I will squash my changes into your ioasid patch
> and address the review comments in the v2 of this set, OK?
> i.e. 
> [PATCH 02/18] ioasid: Add custom IOASID allocator
> [PATCH 03/18] ioasid: Convert ioasid_idr to XArray

That's fine by me, although the "base" and "custom" patches are already
relatively large, so it might make sense to keep them separate

Thanks,
Jean
