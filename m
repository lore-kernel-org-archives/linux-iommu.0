From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/dma: Restore scatterlist offsets correctly
Date: Tue, 5 Apr 2016 15:06:41 +0100
Message-ID: <5703C671.6030207@arm.com>
References: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
	<20160405125926.GI17838@8bytes.org> <5703B98A.6010200@arm.com>
	<20160405133310.GA9516@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160405133310.GA9516-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/04/16 14:33, Joerg Roedel wrote:
> On Tue, Apr 05, 2016 at 02:11:38PM +0100, Robin Murphy wrote:
>> On 05/04/16 13:59, Joerg Roedel wrote:
>>> On Thu, Mar 10, 2016 at 07:28:12PM +0000, Robin Murphy wrote:
>>>> With the change to stashing just the IOVA-page-aligned remainder of the
>>>> CPU-page offset rather than the whole thing, the failure path in
>>>> __invalidate_sg() also needs tweaking to account for that in the case of
>>>> differing page sizes where the two offsets may not be equivalent.
>>>> Similarly in __finalise_sg(), lest the architecture-specific wrappers
>>>> later get the wrong address for cache maintenance on sync or unmap.
>>>>
>>>> Fixes: 164afb1d85b8 ("iommu/dma: Use correct offset in map_sg")
>>>> Reported-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>>
>>> Cc: stable-gepDB1WL6pn9qxiX1TGQuw@public.gmane.org # v4.4+ ?
>>
>> Good point - the kind of people using 64k pages are also likely to
>> be the ones sticking to stable kernels. Are you able to handle that,
>> or would you like me to resend?
>
> I added the tag and put the commit into my iommu/fixes branch. Can you
> re-send me the second commit when the first is upstream (I'll send the
> pull-req this week)? I'd like to avoid creating an additional
> merge-commit just for this patch.

Sure, will do - I agree there's absolutely no need to be mucking about 
with context conflicts right now.

Thanks a lot,
Robin.

>
>
> 	Joerg
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
