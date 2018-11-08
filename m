From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] iommu/amd: remove set but not used variable 'tag'
Date: Thu, 8 Nov 2018 19:12:05 +0800
Message-ID: <6fef1aaf-e58e-720b-7060-353d6fd3901d@huawei.com>
References: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
 <20181108093237.GE19831@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108093237.GE19831@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2018/11/8 17:32, Joerg Roedel wrote:
> On Thu, Nov 08, 2018 at 06:12:40AM +0000, YueHaibing wrote:
>> -		tag = event[1] & 0x03FF;
>>  		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>  			pasid, address, flags);
> 
> This looks like tag was just missed in the error message. It is better
> to add it there instead of removing it.

Ok, will post a new patch.

> 
> Regards,
> 
> 	Joerg
> 
> .
> 
