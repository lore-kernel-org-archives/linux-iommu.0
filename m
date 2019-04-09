From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Date: Tue, 9 Apr 2019 19:23:09 +0200
Message-ID: <20190409172309.GD14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-8-hch@lst.de>
	<67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <67573dd3-72c7-692d-bc1a-7edb49ff9551-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>> -static inline int iommu_dma_init(void)
>> +static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>> +		u64 size, const struct iommu_ops *ops)
>>   {
>> -	return 0;
>>   }
>
> I don't think it makes sense to have a stub for that - AFAICS it should 
> only ever be called form arch code with an inherent "select IOMMU_DMA" 
> (much like the stuff which isn't stubbed currently).
>
> Otherwise, I'm about 97% sure the rest of the move looks OK - thanks for 
> splitting things up.

arm64 only selects IOMMU_DMA if IOMMU_SUPPORT is selected, which can
be disabled.  So to keep some (unusual) arm64 configs compiling we'll need
the stub..
