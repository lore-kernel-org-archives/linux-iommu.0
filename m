From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: PCIe oops for NULL pointer dereference during next-20170807 and
 next-20170815
Date: Thu, 17 Aug 2017 16:30:35 +0800
Message-ID: <858f0baf-b43c-185c-d03d-5be032d9da64@rock-chips.com>
References: <c6ae57b6-1175-4ba4-b66d-d2f5393d06fc@rock-chips.com>
 <2ac52f40-c34f-6c31-b8db-868c40a977a3@rock-chips.com>
 <20170817075825.GR30515@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170817075825.GR30515@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: shawn.lin@rock-chips.com, Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: iommu@lists.linux-foundation.org

On 2017/8/17 15:58, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 03:02:31PM +0800, Shawn Lin wrote:
>> So should we revert this commit or maybe we could add some checking
>> into gic-v2m and gic-v3-its to see if the dev is iommu-capable? If not,
>> we should create another routine to map MSI msg.
> 
> Yes, fixing this in gic code is the right approach. I usually don't
> revert patches to hide problems somewhere else.
>

Ok, then I post a patch for fixing that in gic code. Thanks.


> 
> Regards,
> 
> 	Joerg
> 
> 
> 
> 
