From: Mark Hounschell <markh@compro.net>
Subject: Re: IOMMU/DMA API inquiry
Date: Thu, 19 Feb 2015 14:41:37 -0500
Message-ID: <54E63C71.3020804@compro.net>
References: <54E39AF3.1090409@compro.net> <20150218181901.GK29106@8bytes.org>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218181901.GK29106@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org >> Joerg Roedel" <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org >> Linux-kernel" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg, Thanks for the response.

On 02/18/2015 01:19 PM, joro@8bytes.org >> Joerg Roedel wrote:
> Hi Mark,
>
> On Tue, Feb 17, 2015 at 02:48:03PM -0500, Mark Hounschell wrote:
>> I understand that AMD IOMMU support is not available for 32-bit
>> kernels.  I believe the INTEL IOMMU is supported there. Not knowing
>> why, I was curious if that is going to remain that way?
>
> Yes, I have no plan on making the AMD IOMMU driver available on 32bit.
> But I would not be resistant to patches enabling the driver there.
>

OK. I might take a look. Should it not "just work" more or less?

>
>> I've learned that the AMD IOMMU does not play well with the kernels
>> "Contiguous Memory Allocator" (CMA). I also believe, but could be
>> mistaken, that the INTEL IOMMU does. Again, not knowing why, I was
>> curious if that is going to remain that way also?
>
> No, I will queue a patch for the next merge window to enable CMA use in
> the AMD IOMMU driver. So there will be support for this.
>

Great! That's a couple of  kernels away then. I would be happy to test 
if  you have a need.

>
>> Is the fact that the AMD IOMMU is not supported on 32 bit kernels
>> the reason that dma_map_page always returns 0 on 32 bit kernels.
>
> There is no particular reason for not supporting it on 32 bit kernels,
> it just didn't seem to be important yet. At least not important enough
> to justify the work.
>

Understood.

>> I've read the DMA-API-HOWTO.txt concerning dma_map_sg and at first I
>> thought that maybe dma_map_sg could be used to get around the fact
>> that AMD IOMMU doesn't work with CMA. But it looks as though I was
>> mistaken and I would actually have to do a DMA for_each_sg(sglist,
>> sg, count, i). Is that correct or can dma_map_sg somehow enable you
>> to do a single DMA using a single address for the entire sglist?
>
> The map_sg functions can't be used with the AMD IOMMU driver to work
> around missing CMA support. Depending on what you want it might work
> with the Intel IOMMU driver, as this one allocates a single IOVA region
> for the entire sg_list.
>

Thanks  Joerg

Regards
Mark
