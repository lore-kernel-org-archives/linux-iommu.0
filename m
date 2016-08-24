From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 19/19] iommu/dma: Add support for mapping MSIs
Date: Wed, 24 Aug 2016 11:06:59 +0100
Message-ID: <21fcb927-f0e9-6409-38d8-ddebed7522df@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<4c901ff0f6355039de55b0bc0df283065f02efa1.1471975357.git.robin.murphy@arm.com>
	<alpine.DEB.2.20.1608240950500.5714@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.20.1608240950500.5714@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 24/08/16 09:16, Thomas Gleixner wrote:
> On Tue, 23 Aug 2016, Robin Murphy wrote:
>> +	cookie = domain->iova_cookie;
>> +	iovad = &cookie->iovad;
>> +
>> +	spin_lock(&cookie->msi_lock);
>> +	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
>> +		if (msi_page->phys_hi == msg->address_hi &&
>> +		    msi_page->phys_lo - msg->address_lo < iovad->granule)
>> +			goto unlock;
>> +
>> +	ret = __iommu_dma_map_msi_page(dev, msg, domain, &msi_page);
>> +unlock:
>> +	spin_unlock(&cookie->msi_lock);
>> +
>> +	if (!ret) {
>> +		msg->address_hi = upper_32_bits(msi_page->iova);
>> +		msg->address_lo &= iova_mask(iovad);
>> +		msg->address_lo += lower_32_bits(msi_page->iova);
>> +	} else {
>> +		/*
>> +		 * We're called from a void callback, so the best we can do is
>> +		 * 'fail' by filling the message with obviously bogus values.
>> +		 * Since we got this far due to an IOMMU being present, it's
>> +		 * not like the existing address would have worked anyway...
>> +		 */
>> +		msg->address_hi = ~0U;
>> +		msg->address_lo = ~0U;
>> +		msg->data = ~0U;
>> +	}
> 
> The above is really horrible to parse. I had to read it five times to
> understand the logic.

Yeah, on reflection it is needlessly hideous. I think we should take
this as a clear lesson that whenever you find yourself thinking "Man, I
wish I had Python's for...else construct here", you're doing it wrong ;)

> static struct iommu_dma_msi_page *
> find_or_map_msi_page(struct iommu_dma_cookie *cookie, struct msi_msg *msg)
> {
> 	struct iova_domain *iovad = &cookie->iovad;
>        	struct iommu_dma_msi_page *page;
> 
> 	list_for_each_entry(*page, &cookie->msi_page_list, list) {
> 		if (page->phys_hi == msg->address_hi &&
> 		    page->phys_lo - msg->address_lo < iovad->granule)
> 		    	return page;
> 	}
> 
> 	/*
> 	 * FIXME: __iommu_dma_map_msi_page() should return a page or NULL.
> 	 * The integer return value is pretty pointless. If seperate error
> 	 * codes are required that's what ERR_PTR() is for ....
> 	 */
> 	ret = __iommu_dma_map_msi_page(dev, msg, domain, &page);
> 	return ret ? ERR_PTR(ret) : page;
> }
> 
> So now the code in iommu_dma_map_msi_msg() becomes:
> 
> 	spin_lock(&cookie->msi_lock);
> 	msi_page = find_or_map_msi_page(cookie, msg);
> 	spin_unlock(&cookie->msi_lock);
> 
> 	if (!IS_ERR_OR_NULL(msi_page)) {
> 		msg->address_hi = upper_32_bits(msi_page->iova);
> 		msg->address_lo &= iova_mask(iovad);
> 		msg->address_lo += lower_32_bits(msi_page->iova);
> 	} else {
> 		/*
> 		 * We're called from a void callback, so the best we can do is
> 		 * 'fail' by filling the message with obviously bogus values.
> 		 * Since we got this far due to an IOMMU being present, it's
> 		 * not like the existing address would have worked anyway...
> 		 */
> 		msg->address_hi = ~0U;
> 		msg->address_lo = ~0U;
> 		msg->data = ~0U;
> 	}
> 
> Hmm? 

OK, I've turned map_msi_page into get_msi_page (returning a page) and
just hoisted the list lookup into that, which leads to knock-on
simplifications throughout and is _much_ nicer. I now can't imagine why
I didn't get that far in the first place - thanks for the reality check!

Robin.

> 
> Thanks,
> 
> 	tglx
> 
