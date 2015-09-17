From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Don't use dma_to_phys()
Date: Thu, 17 Sep 2015 16:53:08 +0100
Message-ID: <55FAE1E4.4060009@arm.com>
References: <1c591836f1ec6e676a8889cdccd042650eadb73b.1442499554.git.robin.murphy@arm.com>
	<20150917145216.GJ25634@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150917145216.GJ25634-5wv7dgnIgG8@public.gmane.org>
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
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 17/09/15 15:52, Will Deacon wrote:
[...]
>> -static dma_addr_t __arm_lpae_dma_addr(struct device *dev, void *pages)
>> -{
>> -	return phys_to_dma(dev, virt_to_phys(pages));
>> -}
>
> Can we keep this helper kicking around, at least to contain the ugliness
> of the virt_to_phys + cast?

Can do for the sync and unmap cases - the alloc_pages one needs to avoid 
truncation in the comparison if dma_addr_t and phys_addr_t are different 
sizes, so can't safely cast one to the other either way. I can at least 
get rid of the u64 casts there though, as they seem superfluous after a 
bit of experimentation and another read of the good old "Usual 
arithmetic conversions". I'll fix up and repost.

Robin.

>
> Will
>
