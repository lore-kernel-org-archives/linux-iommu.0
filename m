From: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
 IOMMU cookie
Date: Tue, 23 Apr 2019 10:26:11 +0100
Message-ID: <943b0907-f2ee-63c1-7134-997ffaf6f348@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-2-julien.grall@arm.com>
 <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Thomas,

On 4/18/19 8:28 PM, Thomas Gleixner wrote:
> On Thu, 18 Apr 2019, Julien Grall wrote:
> 
>> When an MSI doorbell is located downstream of an IOMMU, it is required
>> to swizzle the physical address with an appropriately-mapped IOVA for any
>> device attached to one of our DMA ops domain.
>>
>> At the moment, the allocation of the mapping may be done when composing
>> the message. However, the composing may be done in non-preemtible
>> context while the allocation requires to be called from preemptible
>> context.
>>
>> A follow-up patch will split the current logic in two functions
>> requiring to keep an IOMMU cookie per MSI.
>>
>> This patch introduces a new field in msi_desc to store an IOMMU cookie
>> when CONFIG_IOMMU_DMA is selected.
> 
> # git grep 'This patch' Documentation/process/
> 
> Applied to the whole series.

Sorry for that. I will rework all the commit messages and resend the series.

Cheers,

-- 
Julien Grall
