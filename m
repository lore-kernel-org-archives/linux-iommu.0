From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
Date: Thu, 28 Mar 2019 09:11:34 -0700
Message-ID: <20190328161134.GA27879@infradead.org>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
 <20190327064823.GA13309@infradead.org>
 <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 28, 2019 at 02:33:04PM +0800, Lu Baolu wrote:
> For the swiotlb APIs, I am thinking about keeping current APIs untouched
> and adding below new ones for bounce page.

In the lon run I'd like tow avoid duplicate APIs, especially as the
current low-level swiotlb APIs only two callers.  But please go ahead
with the new APIs for now, I will try to see if we can do something
on top later.
