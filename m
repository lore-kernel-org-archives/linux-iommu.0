From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 3/3] arm64: hook up IOMMU dma_ops
Date: Tue, 03 Mar 2015 13:10:34 +0000
Message-ID: <54F5B2CA.9050907@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
	<482b3b109a3d4818b1b1e693f488a919cf1bb707.1423226542.git.robin.murphy@arm.com>
	<54F59565.7000807@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54F59565.7000807-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/03/15 11:05, leizhen wrote:
> On 2015/2/6 22:55, Robin Murphy wrote:
>> With iommu_dma_ops in place, hook them up to the configuration code, so
>> IOMMU-fronted devices will get them automatically.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   arch/arm64/Kconfig                   |  1 +
>>   arch/arm64/include/asm/dma-mapping.h | 11 ++++++-----
>>   arch/arm64/mm/dma-mapping.c          | 15 +++++++++++++++
>>   3 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b1f9a20..e2abcdc 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -66,6 +66,7 @@ config ARM64
>>   	select HAVE_PERF_USER_STACK_DUMP
>>   	select HAVE_RCU_TABLE_FREE
>>   	select HAVE_SYSCALL_TRACEPOINTS
>> +	select IOMMU_DMA if IOMMU_SUPPORT
>
> IOMMU_SUPPORT is selected above, so "if IOMMU_SUPPORT" can be omitted.
> And I suggest putting "select IOMMU_DMA" next to "select IOMMU_SUPPORT".

Not in this patch set it isn't ;)

Omitting the "if IOMMU_SUPPORT" at this point results in this for me:

*** Default configuration is based on 'defconfig'
warning: (ARM64) selects IOMMU_DMA which has unmet direct dependencies 
(IOMMU_SUPPORT && NEED_SG_DMA_LENGTH)

Furthermore, if IOMMU_SUPPORT is selected anywhere I think it should be 
in defconfig, rather than here - if the user wants to leave out all the 
IOMMU drivers, then they should be able to turn off IOMMU_SUPPORT as 
well (since it makes no sense on its own), at which point the 
architecture then needs to make sure that IOMMU_DMA is deselected. 
Unless there's a more elegant way to enforce that, I think this 
"select...if..." needs to stay as it is.

Robin.
