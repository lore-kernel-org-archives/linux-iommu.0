From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Date: Thu, 24 Jan 2019 14:22:50 +0100
Message-ID: <20190124132250.k3rnlpaqazmatzaf@8bytes.org>
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

I don't get it, can you be more specific about the problems that users
might run into? And is this patch needed as a fix for v5.0 or is it just
a precaution because future patches might break something for users?


Regards,

	Joerg
