From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing
	workarounds
Date: Fri, 20 Jan 2017 12:02:13 +0530
Message-ID: <001101d272e6$f365b820$da312860$@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
	<1484838356-24962-9-git-send-email-sricharan@codeaurora.org>
	<20170119165053.GC28483@red-moon>
	<b3f0f112-e4a0-fa4d-4f18-44484392a5e9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b3f0f112-e4a0-fa4d-4f18-44484392a5e9-5wv7dgnIgG8@public.gmane.org>
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
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, 'Lorenzo Pieralisi' <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>-----Original Message-----
>From: linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Robin Murphy
>Sent: Thursday, January 19, 2017 11:28 PM
>To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>; Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>Cc: will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-arm-
>msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org 
>Subject: Re: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing workarounds
>
>On 19/01/17 16:50, Lorenzo Pieralisi wrote:
>> On Thu, Jan 19, 2017 at 08:35:52PM +0530, Sricharan R wrote:
>>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>>
>>> Now that the appropriate ordering is enforced via profe-deferral of
>>> masters in core code, rip it all out and bask in the simplicity.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> [Sricharan: Rebased on top of ACPI IORT SMMU series]
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>  * No change
>>
>> Well, a tad too early on the series for ACPI, aka if we bisect the
>> series here you would break ACPI.
>>
>> Totally agree on the patch, but you should move it to the end of the
>> series.
>
>Indeed - I think a more appropriate ordering of the current patch
>numbers would be:
>
>1, 2, 3, 4, 9, 5+10 (squashed), 6, 11, 7, 8, 12
>

Ok, will repost with this order.

Regards,
 Sricharan
