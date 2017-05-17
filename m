From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RESEND] iommu/dma: Don't touch invalid iova_domain members
Date: Wed, 17 May 2017 16:43:24 +0200
Message-ID: <ad1cac5f-cd59-7de4-f5b4-7c7b2433a94d@redhat.com>
References: <122f47aa5596dc8ef0a1ee76e4425c7b597479a4.1494859975.git.robin.murphy@arm.com>
	<20170517123631.GB11068@8bytes.org>
	<dfe27cdf-9c9c-8e8c-f753-3a0289eb5c30@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <dfe27cdf-9c9c-8e8c-f753-3a0289eb5c30-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 17/05/2017 16:32, Robin Murphy wrote:
> On 17/05/17 13:36, Joerg Roedel wrote:
>> On Mon, May 15, 2017 at 04:01:30PM +0100, Robin Murphy wrote:
>>> When __iommu_dma_map() and iommu_dma_free_iova() are called from
>>> iommu_dma_get_msi_page(), various iova_*() helpers are still invoked in
>>> the process, whcih is unwise since they access a different member of the
>>> union (the iova_domain) from that which was last written, and there's no
>>> guarantee that sensible values will result anyway.
>>>
>>> CLean up the code paths that are valid for an MSI cookie to ensure we
>>> only do iova_domain-specific things when we're actually dealing with one.
>>>
>>> Fixes: a44e6657585b ("iommu/dma: Clean up MSI IOVA allocation")
>>> Reported-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Tested-by: Shanker Donthineni <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Tested-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>
>> Applied to iommu/fixes.
> 
> Thanks!
> 
>> Why didn't you add the Tested-by from Eric in
>> you resend?
> 
> Mostly due to the relative timing of those two events ;)

Yes no worries. I showed up later!

Thanks

Eric
> 
> Robin.
> 
>>
>>
>> 	Joerg
>>
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
