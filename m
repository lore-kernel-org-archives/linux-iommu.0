From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Date: Fri, 25 Jan 2019 10:02:04 +0800
Message-ID: <f2aa4ab2-4a3b-9d6c-357b-367fe142f47a@linux.intel.com>
References: <20190124023132.20410-1-baolu.lu@linux.intel.com>
 <20190124132250.k3rnlpaqazmatzaf@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124132250.k3rnlpaqazmatzaf@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 1/24/19 9:22 PM, Joerg Roedel wrote:
> On Thu, Jan 24, 2019 at 10:31:32AM +0800, Lu Baolu wrote:
>> Commit 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable
>> mode capability") enables VT-d scalable mode if hardware
>> advertises the capability. As we will bring up different
>> features and use cases to upstream in different patch
>> series, it will leave some intermediate kernel versions
>> which support partial features. Hence, end user might run
>> into problems when they use such kernels on bare metals
>> or virtualization environments.
> 
> I don't get it, can you be more specific about the problems that users
> might run into?

Sorry, I didn't make it clear in the message.

Around VT-d scalable mode, we plan to enable several features.
For example,

(1)basic scalable mode support;
(2)aux domain;
(3)system level pasid allocation;
....

Since they will be submitted in different patch series for reviewing and
merging, users will face compatible problems. For example, when users
run kernel v5.0, they might fail to assign an ADI (Assignable Device
Interface) to a VM because the aux domain is not included yet. They will
complain "I have a kernel claimed to support scalable mode, but when I
tried to assign an ADI to a VM, ...".

So we decide to leave it off by default, and turn it default on later
when all the features get merged. Users could try scalable mode features
with "intel-iommu=sm_on" in kernel command line.

> And is this patch needed as a fix for v5.0 or is it just
> a precaution because future patches might break something for users?

It will be better if it can be a fix for v5.0.

Best regards,
Lu Baolu
