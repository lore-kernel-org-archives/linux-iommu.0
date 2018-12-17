From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 3/6] ACPI/IORT: Use device_iommu_mapped()
Date: Mon, 17 Dec 2018 17:21:13 +0800
Message-ID: <2c279b05-f845-94ac-f0ad-a0c54f48a7ca@huawei.com>
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211134343.10664-4-joro@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>, jroedel@suse.de, Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2018/12/11 21:43, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Replace the iommu-check with a proper and readable function
> call.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
