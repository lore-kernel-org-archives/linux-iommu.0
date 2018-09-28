From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
Date: Fri, 28 Sep 2018 14:42:53 +0100
Message-ID: <c1bda944-6279-4393-1277-c9df18594ca0@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <20180928133639.GF1577@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928133639.GF1577@brain-police>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 28/09/18 14:36, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 05:10:20PM +0100, Robin Murphy wrote:
>> Hopefully this is the last spin of the series - I've now dropped my light
>> touch and fixed up all the various prose text, plus implemented the proper
>> quirk support for short-descriptor because it's actually just a trivial
>> cut-and-paste job.
> 
> Did you manage to clarify how the lifetime of the domain/flush queue interacts
> with the periodic timer after the cookie has been freed?

Oh, yes - it turned out to be wrapped up in put_iova_domain() already 
(see free_iova_flush_queue()), so all looks good in that regard.

Robin.
