From: Zhangshaokun <zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
	register
Date: Fri, 27 Jul 2018 17:59:07 +0800
Message-ID: <4df3ba75-6fb2-3d2d-b29a-de46d28bade1@hisilicon.com>
References: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
	<dfeaf347-afd4-b3f2-eb01-2781028371e8@hisilicon.com>
	<20180727094816.GM28088@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180727094816.GM28088-5wv7dgnIgG8@public.gmane.org>
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
Cc: Miao Zhong <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


On 2018/7/27 17:48, Will Deacon wrote:
> On Fri, Jul 27, 2018 at 05:41:46PM +0800, Zhangshaokun wrote:
>> I saw it in your trees, is it necessary to Cc stable version?
> 
> I don't think so, given that we don't actually support PRI upstream.
> 

Got it, thanks your reply.

Shaokun

> Will
> 
>> On 2018/7/23 20:56, Shaokun Zhang wrote:
>>> From: Miao Zhong <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>>
>>> When PRI queue occurs overflow, driver should update the OVACKFLG to
>>> the PRIQ consumer register, otherwise subsequent PRI requests will not
>>> be processed.
>>>
>>> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>>> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> 
>>> Signed-off-by: Miao Zhong <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index 1d64710..deacc15 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -1301,6 +1301,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>>>  
>>>  	/* Sync our overflow flag, as we believe we're up to speed */
>>>  	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
>>> +	writel(q->cons, q->cons_reg);
>>>  	return IRQ_HANDLED;
>>>  }
>>>  
>>>
>>
> 
> .
> 
