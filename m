From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Missing checks for pasid tables if
	allocation fails
Date: Fri, 20 Oct 2017 08:48:55 +0800
Message-ID: <59E947F7.4030402@linux.intel.com>
References: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439AFB902@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439AFB902-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yi,

On 10/19/2017 02:40 PM, Liu, Yi L wrote:
>
>> -----Original Message-----
>> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
>> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Lu Baolu
>> Sent: Thursday, October 19, 2017 8:39 AM
>> To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
>> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: [PATCH 1/3] iommu/vt-d: Missing checks for pasid tables if allocation fails
>>
>> intel_svm_alloc_pasid_tables() might return an error but never be checked by the
>> callers. Later when intel_svm_bind_mm() is called, there are no checks for valid pasid
>> tables before enabling them.
>>
>> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-svm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
>> f6697e5..43280ca 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -292,7 +292,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
>> flags, struct svm_dev_
>>  	int pasid_max;
>>  	int ret;
>>
>> -	if (WARN_ON(!iommu))
>> +	if (WARN_ON(!iommu || !iommu->pasid_table))
> [Liu, Yi L] Hi Baolu, I guess there also need a check to iommu->ecap , see if the pasid bit
> is reported. thoughts?
>

If pasid bit is not set in ecap register, iommu->pasid_table won't be set.

We did this by:

                if (pasid_enabled(iommu))
                        intel_svm_alloc_pasid_tables(iommu);

Best regards,
Lu Baolu
