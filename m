From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH -next] iommu/amd: Add missed 'tag' to error msg in
 iommu_print_event
Date: Thu, 8 Nov 2018 15:04:50 +0100
Message-ID: <20181108140450.GF19831@8bytes.org>
References: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
 <1541678253-143948-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541678253-143948-1-git-send-email-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 08, 2018 at 11:57:33AM +0000, YueHaibing wrote:
> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
> +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%08x]\n",

Changed the %08x to %03x, which is enough for a 10-bit value, and
applied it to x86/amd.

Thanks,

	Joerg
