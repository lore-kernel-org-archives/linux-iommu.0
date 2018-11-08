From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
	support
Date: Thu, 8 Nov 2018 10:16:51 +0800
Message-ID: <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
	<20181105053151.7173-5-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D5FAA2-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yi,

On 11/7/18 2:07 PM, Liu, Yi L wrote:
> Hi Baolu,
> 
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Monday, November 5, 2018 1:32 PM
> 
> [...]
> 
>> ---
>>   drivers/iommu/dmar.c                | 83 +++++++++++++++++++----------
>>   drivers/iommu/intel-svm.c           | 76 ++++++++++++++++----------
>>   drivers/iommu/intel_irq_remapping.c |  6 ++-
>>   include/linux/intel-iommu.h         |  9 +++-
>>   4 files changed, 115 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>> index d9c748b6f9e4..ec10427b98ac 100644
>> --- a/drivers/iommu/dmar.c
>> +++ b/drivers/iommu/dmar.c
>> @@ -1160,6 +1160,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int
>> index)
>>   	int head, tail;
>>   	struct q_inval *qi = iommu->qi;
>>   	int wait_index = (index + 1) % QI_LENGTH;
>> +	int shift = qi_shift(iommu);
>>
>>   	if (qi->desc_status[wait_index] == QI_ABORT)
>>   		return -EAGAIN;
>> @@ -1173,13 +1174,15 @@ static int qi_check_fault(struct intel_iommu *iommu,
>> int index)
>>   	 */
>>   	if (fault & DMA_FSTS_IQE) {
>>   		head = readl(iommu->reg + DMAR_IQH_REG);
>> -		if ((head >> DMAR_IQ_SHIFT) == index) {
>> +		if ((head >> shift) == index) {
>> +			struct qi_desc *desc = qi->desc + head;
>> +
>>   			pr_err("VT-d detected invalid descriptor: "
>>   				"low=%llx, high=%llx\n",
>> -				(unsigned long long)qi->desc[index].low,
>> -				(unsigned long long)qi->desc[index].high);
>> -			memcpy(&qi->desc[index], &qi->desc[wait_index],
>> -					sizeof(struct qi_desc));
>> +				(unsigned long long)desc->qw0,
>> +				(unsigned long long)desc->qw1);
> 
> Still missing qw2 and qw3. May make the print differ based on if smts is configed.

qw2 and qw3 are reserved from software point of view. We don't need to
print it for information.

> 
>> +			memcpy(desc, qi->desc + (wait_index << shift),
> 
> Would "memcpy(desc, (unsigned long long) (qi->desc +  (wait_index << shift)," be
> more safe?

Can that be compiled? memcpy() requires a "const void *" for the second
parameter. By the way, why it's safer with this casting?

> 
>> +			       1 << shift);
>>   			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
>>   			return -EINVAL;
>>   		}
>> @@ -1191,10 +1194,10 @@ static int qi_check_fault(struct intel_iommu *iommu,
>> int index)
>>   	 */
>>   	if (fault & DMA_FSTS_ITE) {
>>   		head = readl(iommu->reg + DMAR_IQH_REG);
>> -		head = ((head >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
>> +		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>   		head |= 1;
>>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>> -		tail = ((tail >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
>> +		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>
>>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>
>> @@ -1222,15 +1225,14 @@ int qi_submit_sync(struct qi_desc *desc, struct
>> intel_iommu *iommu)
>>   {
>>   	int rc;
>>   	struct q_inval *qi = iommu->qi;
>> -	struct qi_desc *hw, wait_desc;
>> +	int offset, shift, length;
>> +	struct qi_desc wait_desc;
>>   	int wait_index, index;
>>   	unsigned long flags;
>>
>>   	if (!qi)
>>   		return 0;
>>
>> -	hw = qi->desc;
>> -
>>   restart:
>>   	rc = 0;
>>
>> @@ -1243,16 +1245,21 @@ int qi_submit_sync(struct qi_desc *desc, struct
>> intel_iommu *iommu)
>>
>>   	index = qi->free_head;
>>   	wait_index = (index + 1) % QI_LENGTH;
>> +	shift = qi_shift(iommu);
>> +	length = 1 << shift;
>>
>>   	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
>>
>> -	hw[index] = *desc;
>> -
>> -	wait_desc.low = QI_IWD_STATUS_DATA(QI_DONE) |
>> +	offset = index << shift;
>> +	memcpy(qi->desc + offset, desc, length);
>> +	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>>   			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
>> -	wait_desc.high = virt_to_phys(&qi->desc_status[wait_index]);
>> +	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
>> +	wait_desc.qw2 = 0;
>> +	wait_desc.qw3 = 0;
>>
>> -	hw[wait_index] = wait_desc;
>> +	offset = wait_index << shift;
>> +	memcpy(qi->desc + offset, &wait_desc, length);
> 
> same question with above one.
> 

Ditto.

Best regards,
Lu Baolu
