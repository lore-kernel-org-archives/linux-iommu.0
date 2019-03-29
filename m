From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
Date: Fri, 29 Mar 2019 10:33:02 +0800
Message-ID: <f1d6340e-88d8-3286-2f23-44094563c1c7@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
 <20190327064823.GA13309@infradead.org>
 <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
 <20190328161134.GA27879@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328161134.GA27879@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/29/19 12:11 AM, Christoph Hellwig wrote:
> On Thu, Mar 28, 2019 at 02:33:04PM +0800, Lu Baolu wrote:
>> For the swiotlb APIs, I am thinking about keeping current APIs untouched
>> and adding below new ones for bounce page.
> 
> In the lon run I'd like tow avoid duplicate APIs, especially as the
> current low-level swiotlb APIs only two callers.  But please go ahead
> with the new APIs for now, I will try to see if we can do something
> on top later.
> 

Sure.

Best regards,
Lu Baolu
