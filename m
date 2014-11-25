From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for IOMMU
	masters
Date: Tue, 25 Nov 2014 08:35:21 +0100
Message-ID: <54743139.2020804@samsung.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<546C7D36.7030400@samsung.com> <20141119114150.GD15985@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20141119114150.GD15985-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-11-19 12:41, Will Deacon wrote:
> Hi Marek,
>
> On Wed, Nov 19, 2014 at 11:21:26AM +0000, Marek Szyprowski wrote:
>> On 2014-11-14 19:56, Will Deacon wrote:
>>> Hello everybody,
>>>
>>> Here is the fourth iteration of the RFC I've previously posted here:
>>>
>>>     RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
>>>     RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
>>>     RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
>>>
>>> Changes since RFCv3 include:
>>>
>>>     - Drastic simplification of the data structures, so that we no longer
>>>       pass around lists of domains. Instead, dma-mapping is expected to
>>>       allocate the domain (Joerg talked about adding a get_default_domain
>>>       operation to iommu_ops).
>>>
>>>     - iommu_ops is used to hold the per-instance IOMMU data
>>>
>>>     - Configuration of DMA segments added to of_dma_configure
>>>
>>> All feedback welcome.
>> I've rebased my Exynos SYSMMU patches on top of this patchset and it
>> works fine,
>> You can find them in the "[PATCH v3 00/19] Exynos SYSMMU (IOMMU)
>> integration with DT
>> and DMA-mapping subsystem" thread.
> I just saw that and it looks great, thanks! FWIW, I'll take the first 3
> patches you have into my series in some shape or another.

It would be great if the iommu integration patches were merged to -next 
to give
them a try for a few days. Joerg: do you plan to take those patches to 
v3.19 or
do you want to wait more?

>> You can add to all your patches:
>> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cheers.
>
>> I'm also interested in adding get_default_domain() callback, but I
>> assume that this
>> can be done once the basic patchset get merged. Do you plan to work on
>> it, do you want
>> me to implement it?
> If Joerg isn't working on it already (I don't think he is), then please
> do have a go if you have time. You'll probably want to avoid adding devices
> with addressing restrictions (i.e. non-zero dma_pfn_offset, weird dma masks)
> to the default domain, otherwise you'll run into issues initialising the
> iova allocator.
>
> I had a go at getting ARM dma-mapping to use a hypothetical
> get_default_domain function, so I've included the diff I ended up with below,
> in case it's at all useful.

I will check that soon, but I hope this is not strictly needed to get 
basic iommu
and dma-mapping integration merged.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
