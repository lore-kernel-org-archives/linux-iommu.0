From: Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH 0/2] Fix incorrect warning from dma-debug
Date: Sat, 6 May 2017 20:06:46 -0400
Message-ID: <477ded30-eef2-3598-3a8d-95d206e11efb@jonmasters.org>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <57305A4B.70401@arm.com> <57305FD8.7070006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <57305FD8.7070006@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/09/2016 06:00 AM, Robin Murphy wrote:
> On 09/05/16 10:37, Robin Murphy wrote:
>> Hi Niklas,
>>
>> On 08/05/16 11:59, Niklas Söderlund wrote:
>>> Hi,
>>>
>>> While using CONFIG_DMA_API_DEBUG i came across this warning which I
>>> think is a false positive. As shown dma_sync_single_for_device() are
>>> called from the dma_map_single() call path. This triggers the warning
>>> since the dma-debug code have not yet been made aware of the mapping.
>>
>> Almost right ;) The thing being mapped (the SPI device's buffer) and the
>> thing being synced (the IOMMU's PTE) are entirely unrelated. Due to the
>> current of_iommu_init() setup, the IOMMU is probed long before
>> dma_debug_init() gets called, therefore DMA debug is missing entries for
>> some of the initial page table mappings and gets confused when we update
>> them later.

What was the eventual followup/fix for this? We're seeing similar traces
to this during internal testing of 4.11 kernels.

Jon.

-- 
Computer Architect
