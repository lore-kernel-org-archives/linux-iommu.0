Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9CC433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 17:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1400240327;
	Fri, 25 Mar 2022 17:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Xjv0bKCwSIG; Fri, 25 Mar 2022 17:49:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C020740158;
	Fri, 25 Mar 2022 17:49:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93A81C001D;
	Fri, 25 Mar 2022 17:49:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C003AC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 17:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A09BE400E0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 17:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ePU_7QyQ_si for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 17:49:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42863400DE
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 17:49:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54000D6E;
 Fri, 25 Mar 2022 10:49:48 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4619F3F73D;
 Fri, 25 Mar 2022 10:49:46 -0700 (PDT)
Message-ID: <c982f1d7-c565-769a-abae-79c962969d88@arm.com>
Date: Fri, 25 Mar 2022 17:49:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Content-Language: en-GB
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
 <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
 <ad7ae652a2b54261a522008a25238039@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ad7ae652a2b54261a522008a25238039@huawei.com>
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-03-23 16:06, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: 22 March 2022 19:09
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
>> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
>> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR
>> memory regions
>>
>> On 2022-02-21 15:43, Shameer Kolothum via iommu wrote:
>>> Add helper functions (iort_iommu_get/put_rmrs()) that
>>> retrieves/releases RMR memory descriptors associated
>>> with a given IOMMU. This will be used by IOMMU drivers
>>> to set up necessary mappings.
>>>
>>> Invoke it from the generic iommu helper functions.
>>
>> iommu_dma_get_resv_regions() already exists - please extend that rather
>> than adding a parallel implementation of the same thing but different.
>> IORT should export a single get_resv_regions helper which combines the
>> new RMRs with the existing MSI workaround, and a separate "do I need to
>> bypass this StreamID" helper for the SMMU drivers to call directly at
>> reset time, since the latter isn't really an iommu-dma responsibility.
> 
> Right. I actually had couple of back and forth on the interfaces and settled
> on this mainly because it just requires a single interface from IORT for both
> get_resv_regions() and SMMU driver reset bypass path.
> ie, iort_iommu_get/put_rmrs()).
> 
> But agree the above comment is also valid.
> 
>> I'm happy to do that just by shuffling wrappers around for now - we can
>> come back and streamline the code properly afterwards - but the sheer
>> amount of indirection currently at play here is so hard to follow that
>> it's not even all that easy to see how it's crossing abstraction levels
>> improperly.
> 
> Please find below the revised ones. Please take a look and let me know.

Yeah, that looks like it should work!

Cheers,
Robin.

> 
> Thanks,
> Shameer
> 
> iommu-dma:
> 
> void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list) {
> 
>          if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>                  iort_iommu_get_resv_regions(dev, list);
> }
> 
> void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list) {
> 
>          if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>                  iort_iommu_put_resv_regions(dev, list);
>          generic_iommu_put_resv_regions(dev, list);
> }
> 
> iort:
> 
> void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head) {
>          struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> 
>          iort_iommu_msi_get_resv_regions(dev, head);
>          iort_iommu_get_rmrs(fwspec->iommu_fwnode, dev, head);
> }
> 
> void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head) {
>     ./*Free both RMRs and HW MSI ones */
> }
> 
> /* The below ones will be directly called from SMMU drivers during reset */
> void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) {
>          iort_iommu_get_rmrs(iommu_fwnode, NULL, head); }
> }
> 
> void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) {
>          iort_iommu_put_resv_regions(NULL, head);
> }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
