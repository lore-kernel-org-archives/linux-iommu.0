From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: What is the meaning of PASID_MIN?
Date: Tue, 12 Feb 2019 11:13:28 +0800
Message-ID: <fa7475c2-f64f-04d5-1e15-42d0cb1401d0@linux.intel.com>
References: <20190211192804.GI12668@bombadil.infradead.org>
	<0d86f3e8-60ec-5433-8602-487c8dc1ed83@linux.intel.com>
	<20190212030232.GI1011@xz-x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190212030232.GI1011@xz-x1>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


On 2/12/19 11:02 AM, Peter Xu wrote:
> On Tue, Feb 12, 2019 at 10:44:23AM +0800, Lu Baolu wrote:
>> Hi,
>>
>> On 2/12/19 3:28 AM, Matthew Wilcox wrote:
>>>
>>> I'm looking at commit 562831747f6299abd481b5b00bd4fa19d5c8a259
>>> which fails to adequately explain why we can't use PASID 0.  Commit
>>> af39507305fb83a5d3c475c2851f4d59545d8a18 also doesn't explain why PASID
>>> 0 is no longer usable for the intel-svm driver.
>>
>> Sorry that we didn't make it clear.
>>
>>>
>>> There are a load of simplifications that could be made to this, but I
>>> don't know which ones to suggest without a clear understanding of the
>>> problem you're actually trying to solve.
>>>
>>
>> PASID 0 has been reserved by Intel IOMMU driver for RID_PASID purpose.
>>
>> VT-d scalable mode treats all address translation as PASID granularity.
>> For DMA requests-with-PASID, the PASID value in the DMA request will be
>> used. For DMA requests-without-PASID, VT-d will use a static PASID value
>> specified in the RID_PASID field of the context entry. PASID 0 has been
>> reserved for this usage for all devices.
>>
>> (Please refer to 9.4 of the spec 3.0 for more details.)
> 
> Hi, Baolu,

Hi Peter,

> 
> I have a similar confusion.
> 
> If PASID==0 is reserved for requests-without-PASID, then does it mean
> that for each scalable mode context entry the RID_PASID field will
> always be zero?

Yes.

>  Or say, since we already have the per-context-entry
> RID_PASID field which seems to be configurable, why we still need to
> reserve the PASID==0?

We decided to set RID_PASID always to 0. This will make things simple
especially for virtual IOMMU case. It will also be compatible with other
arch's which reserves PASID 0 for legacy translation.

Best regards,
Lu Baolu
