From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix the size calculation of pasid table
Date: Mon, 10 Oct 2016 21:00:14 +0800
Message-ID: <57FB90DE.7010808@redhat.com>
References: <1473648551-10025-1-git-send-email-xlpang@redhat.com>
	<20160919121827.GB3541@8bytes.org>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160919121827.GB3541-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Ping David for confirmation

On 2016/09/19 at 20:18, Joerg Roedel wrote:
> [Cc'ing David]
>
> On Mon, Sep 12, 2016 at 10:49:11AM +0800, Xunlei Pang wrote:
>> According to the vt-d spec, the size of pasid (state) entry is 8B
>> which equals 3 in power of 2, the number of pasid (state) entries
>> is (ecap_pss + 1) in power of 2.
>>
>> Thus the right size of pasid (state) table in power of 2 should be
>> ecap_pss(iommu->ecap) plus "1+3=4" other than 7.
>>
>> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-svm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 8ebb353..cfa75c2 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -39,7 +39,7 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>>  	struct page *pages;
>>  	int order;
>>  
>> -	order = ecap_pss(iommu->ecap) + 7 - PAGE_SHIFT;
>> +	order = ecap_pss(iommu->ecap) + 4 - PAGE_SHIFT;
>>  	if (order < 0)
>>  		order = 0;
> The patch seems to be correct, but I'll let David comment on it first.
>
>
>
> 	Joerg
>
