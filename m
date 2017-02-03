From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 0/5] Implement SMMU passthrough using the default domain
Date: Fri, 3 Feb 2017 22:03:09 +0530
Message-ID: <017701d27e3b$381d24d0$a8576e70$@codeaurora.org>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<010801d27654$47b7e450$d727acf0$@codeaurora.org>
	<20170126171857.GE27598@8bytes.org>
	<CAF6AEGtfrrwVZ_W86_HqVsiqfcM=XFa+g2LECFYQJmvv7-JSqQ@mail.gmail.com>
	<012501d27d6b$5e396c80$1aac4580$@codeaurora.org>
	<20170202161047.GG13839@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170202161047.GG13839-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will, Rob,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Will Deacon
>Sent: Thursday, February 02, 2017 9:41 PM
>To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
>foundation.org
>Subject: Re: [PATCH 0/5] Implement SMMU passthrough using the default domain
>
>On Thu, Feb 02, 2017 at 09:15:19PM +0530, Sricharan wrote:
>> Hi Rob,
>>
>> >-----Original Message-----
>> >From: linux-arm-kernel [mailto:linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Rob Clark
>> >Sent: Thursday, February 02, 2017 8:33 PM
>> >To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> >Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>; linux-arm-
>> >kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> >Subject: Re: [PATCH 0/5] Implement SMMU passthrough using the default domain
>> >
>> >On Thu, Jan 26, 2017 at 12:18 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>> >> On Tue, Jan 24, 2017 at 08:42:23PM +0530, Sricharan wrote:
>> >>> Thanks for this series. We had a case with the GPU.
>> >>> The GPU's iommu was setup by kernel and the GPU
>> >>> also does dynamic updates for on-the-fly switching between
>> >>> process pagetables.  GPU driver was not using DMA domain and
>> >>> the GPU's firmware was always expecting to run out  of contextbank
>> >>>  '0' (although not correct) , which was not the case after the DMA domain
>> >>> was made default  as '0' was getting allocated for DMA domain and
>> >>> there were concerns about reusing the DMA domain as well.
>> >>> Now with this series, looks there is an way out of that that can be tried.
>> >>>
>> >>> So should the default domain not be per device specific selectable ?
>> >>
>> >> Note that iommu-drivers can request direct-mapping for any given device
>> >> on its initializtion. This is used on x86 for devices that need a 1-1
>> >> mapping for some reason.
>> >>
>> >> Also device drivers can use the iommu-api and assign their own domain to
>> >> a device, which allows them to manage the dma address space on their
>> >> own.
>> >
>> >Part of the problem is that dev->archdata.dma_ops gets wired up to
>> >iommu_dma_ops.  Which isn't so bad on it's own, except that cache ops
>> >are not exposed to drivers, forcing us to use dma-mapping API
>> >(dma_map_sg, etc) for cache operations.
>> >
>> >Possibly we should just expose cache op's to drivers bypass this abuse
>> >of dma-mapping.
>> >
>> [1], with this, when the default domain in not DOMAIN_DMA, then
>> dev->archdata.dma_ops is not set to iommu_dma_ops , instead remains
>> to be swiotlb_ops. Is that not correct for gpu's unmanaged domain case ?
>>
>> https://www.spinics.net/lists/arm-kernel/msg556209.html
>>
>> >btw, Will, we definitely want this to *not* rely on kcmdline for the
>> >gpu with it's own private iommu case..
>>
>> Ya, that changes behavior for all devices and some might want
>> DMA_DOMAIN and some UNMANAGED.
>
>My patch changes the *default* domain. When would this ever be UNMANAGED?
>
>If you're using an UNMANAGED domain, I think you need to take care of the
>DMA ops yourself. There are likely missing functions to do that, but they
>should be added in a separate series.

Sorry, i should have said DOMAIN_DMA or DOMAIN_IDENTITY is set as
*default* domains from your patchset. So i have not tested this series
yet. But the requirement that i thought for the gpu was
    * a context bank (specially '0') should not be reserved for DOMAIN_DMA
   * dma_ops should not be set to iommu_dma_ops for the gpu device.

I was seeing that both of that are satisfied in this series, if we choose
IDENTITY_DOMAIN as default and later gpu attaches it own
*UNMANAGED* domain.

The only thing i was thinking was, since we are changing the default domain
for all device from command line, some device which require DOMAIN_DMA
and some which require DOMAIN_IDENTITY as default was not possible.

Regards,
 Sricharan
