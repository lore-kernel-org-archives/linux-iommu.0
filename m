From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Don't put uninitialised IOVA domains
Date: Tue, 9 Aug 2016 16:22:13 +0100
Message-ID: <47011e29-b584-7440-94be-5570c26525d6@arm.com>
References: <d88eb3dc42377b8aa7947d2b0141f28589ae645f.1469634042.git.robin.murphy@arm.com>
	<20160809150157.GF1437@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160809150157.GF1437-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/08/16 16:01, Joerg Roedel wrote:
> On Wed, Jul 27, 2016 at 04:46:06PM +0100, Robin Murphy wrote:
>> Due to the limitations of having to wait until we see a device's DMA
>> restrictions before we know how we want an IOVA domain initialised,
>> there is a window for error if a DMA ops domain is allocated but later
>> freed without ever being used. In that case, init_iova_domain() was
>> never called, so calling put_iova_domain() from iommu_put_dma_cookie()
>> ends up trying to take an uninitialised lock and crashing.
>>
>> Make things robust by skipping the call unless the IOVA domain actually
>> has been initialised, as we probably should have done from the start.
>>
> 
> Missing 'Fixes:' and probably 'Cc: stable' lines?
> 
>> Reported-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> I'm not sure this warrants a cc stable, as with the code currently in
>> mainline it's only at all likely if other things have already failed
>> elsewhere in a manner they should not be expected to.
> 
> Yes, I think this qualifies for stable. Please re-send with the Acks and
> Reviewed-by lines too. I'll queue this in my fixes branch and send it
> upstream asap.

Will do, thanks!

Robin.

> 
> 
> 	Joerg
> 
