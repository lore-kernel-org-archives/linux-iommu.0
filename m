From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH -next] iommu/amd: remove set but not used variable 'tag'
Date: Thu, 8 Nov 2018 10:32:37 +0100
Message-ID: <20181108093237.GE19831@8bytes.org>
References: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 08, 2018 at 06:12:40AM +0000, YueHaibing wrote:
> -		tag = event[1] & 0x03FF;
>  		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>  			pasid, address, flags);

This looks like tag was just missed in the error message. It is better
to add it there instead of removing it.

Regards,

	Joerg
