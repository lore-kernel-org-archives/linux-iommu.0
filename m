Return-Path: <SRS0=kikZ=TJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCEBC04AAE
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 02:28:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F2A2173E
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 02:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F2A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E34C2E8F;
	Thu,  9 May 2019 02:28:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 16C23E7A
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 02:28:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 811621FB
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 02:28:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 May 2019 19:28:34 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 08 May 2019 19:28:32 -0700
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
	type
To: Tom Murphy <tmurphy@arista.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
	<20190429020925.18136-2-baolu.lu@linux.intel.com>
	<CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4a21bf25-bde5-3248-2f41-17c5c8803c5f@linux.intel.com>
Date: Thu, 9 May 2019 10:22:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Tom,

On 5/6/19 11:32 PM, Tom Murphy wrote:
> The AMD driver already solves this problem and uses the generic
> iommu_request_dm_for_dev function. It seems like both drivers have the
> same problem and could use the same solution. Is there any reason we
> can't have use the same solution for the intel and amd driver?

The iommu_request_dm_for_dev() works for vt-d driver as well. But it's
insufficient. Another case is the default domain type is IDENTITY, but
the iommu driver can only support DMA type. Is it possible to add an
iommu_request_dma_map_for_dev() for this purpose?

> 
> Could we just  copy the implementation of the AMD driver? It would be
> nice to have the same behavior across both drivers especially as we
> move to make both drivers use more generic code.

Yes, agreed.

Best regards,
Lu Baolu

> 
> On Mon, Apr 29, 2019 at 3:16 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> This adds an optional ops entry to query the default domain
>> types supported by the iommu driver for  a specific device.
>> This is necessary in cases where the iommu driver can only
>> support a specific type of default domain for a device. In
>> normal cases, this ops will return IOMMU_DOMAIN_ANY which
>> indicates that the iommu driver supports both IOMMU_DOMAIN_DMA
>> and IOMMU_DOMAIN_IDENTITY, hence the static default domain
>> type will be used.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 13 ++++++++++---
>>   include/linux/iommu.h | 11 +++++++++++
>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index acd6830e6e9b..1ad9a1f2e078 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1097,15 +1097,22 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>>           * IOMMU driver.
>>           */
>>          if (!group->default_domain) {
>> +               unsigned int domain_type = IOMMU_DOMAIN_ANY;
>>                  struct iommu_domain *dom;
>>
>> -               dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
>> -               if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
>> +               if (ops->def_domain_type)
>> +                       domain_type = ops->def_domain_type(dev);
>> +
>> +               if (domain_type == IOMMU_DOMAIN_ANY)
>> +                       domain_type = iommu_def_domain_type;
>> +
>> +               dom = __iommu_domain_alloc(dev->bus, domain_type);
>> +               if (!dom && domain_type != IOMMU_DOMAIN_DMA) {
>>                          dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
>>                          if (dom) {
>>                                  dev_warn(dev,
>>                                           "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
>> -                                        iommu_def_domain_type);
>> +                                        domain_type);
>>                          }
>>                  }
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 8239ece9fdfc..ba9a5b996a63 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -79,12 +79,16 @@ struct iommu_domain_geometry {
>>    *     IOMMU_DOMAIN_DMA        - Internally used for DMA-API implementations.
>>    *                               This flag allows IOMMU drivers to implement
>>    *                               certain optimizations for these domains
>> + *     IOMMU_DOMAIN_ANY        - All domain types defined here
>>    */
>>   #define IOMMU_DOMAIN_BLOCKED   (0U)
>>   #define IOMMU_DOMAIN_IDENTITY  (__IOMMU_DOMAIN_PT)
>>   #define IOMMU_DOMAIN_UNMANAGED (__IOMMU_DOMAIN_PAGING)
>>   #define IOMMU_DOMAIN_DMA       (__IOMMU_DOMAIN_PAGING |        \
>>                                   __IOMMU_DOMAIN_DMA_API)
>> +#define IOMMU_DOMAIN_ANY       (IOMMU_DOMAIN_IDENTITY |        \
>> +                                IOMMU_DOMAIN_UNMANAGED |       \
>> +                                IOMMU_DOMAIN_DMA)
>>
>>   struct iommu_domain {
>>          unsigned type;
>> @@ -196,6 +200,11 @@ enum iommu_dev_features {
>>    * @dev_feat_enabled: check enabled feature
>>    * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
>>    * @aux_get_pasid: get the pasid given an aux-domain
>> + * @def_domain_type: get per-device default domain type that the IOMMU
>> + *             driver is able to support. Valid returns values:
>> + *             - IOMMU_DOMAIN_DMA: only suports non-identity domain
>> + *             - IOMMU_DOMAIN_IDENTITY: only supports identity domain
>> + *             - IOMMU_DOMAIN_ANY: supports all
>>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>>    */
>>   struct iommu_ops {
>> @@ -251,6 +260,8 @@ struct iommu_ops {
>>          void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
>>          int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
>>
>> +       int (*def_domain_type)(struct device *dev);
>> +
>>          unsigned long pgsize_bitmap;
>>   };
>>
>> --
>> 2.17.1
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
