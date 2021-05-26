Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E0C47088
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 16:37:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48A3610A0
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 16:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48A3610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E16E40502;
	Wed, 26 May 2021 16:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFNCV2vkSl99; Wed, 26 May 2021 16:36:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 779BC40143;
	Wed, 26 May 2021 16:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41B88C000E;
	Wed, 26 May 2021 16:36:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7AEEC0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEE3C40502
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGo4AyjZ4f4b for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 16:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EBC340143
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:36:55 +0000 (UTC)
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqxMT3LlxzQrmn;
 Thu, 27 May 2021 00:33:09 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 00:36:47 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 00:36:45 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Wed, 26 May 2021 17:36:44 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Topic: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Index: AQHXUIxzNCstxTr9F0iaZEElN6n+2Kr1Vn6AgACfpbA=
Date: Wed, 26 May 2021 16:36:44 +0000
Message-ID: <260859e85c854b90b513599f4febfbad@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
 <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
In-Reply-To: <13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.87.129]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
> Sent: 26 May 2021 08:53
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
> regions
> 
> Hi Shameer,
> 
> On 5/24/2021 2:02 PM, Shameer Kolothum wrote:
> > Add a helper function that retrieves RMR memory descriptors
> > associated with a given IOMMU. This will be used by IOMMU
> > drivers to setup necessary mappings.
> >
> > Now that we have this, invoke it from the generic helper
> > interface.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 50
> +++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/dma-iommu.c |  4 ++++
> >  include/linux/acpi_iort.h |  7 ++++++
> >  3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index fea1ffaedf3b..01917caf58de 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -12,6 +12,7 @@
> >
> >  #include <linux/acpi_iort.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/dma-iommu.h>
> >  #include <linux/iommu.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > @@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct
> device *dev)
> >  	return err;
> >  }
> >
> > +/**
> > + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with
> IOMMU
> > + * @iommu: fwnode for the IOMMU
> > + * @head: RMR list head to be populated
> > + *
> > + * Returns: 0 on success, <0 failure
> > + */
> > +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> > +			struct list_head *head)
> > +{
> > +	struct iort_rmr_entry *e;
> > +	struct acpi_iort_node *iommu;
> > +	int rmrs = 0;
> > +
> > +	iommu = iort_get_iort_node(iommu_fwnode);
> > +	if (!iommu || list_empty(&iort_rmr_list))
> > +		return -ENODEV;
> > +
> > +	list_for_each_entry(e, &iort_rmr_list, list) {
> > +		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC |
> IOMMU_MMIO;
> 
> We have a case with an IP block that needs EXEC rights on its reserved
> memory, so could you please drop the IOMMU_NOEXEC flag?

Ok, I think I can drop that one if there are no other concerns. I was not quite
sure what to include here in the first place as the IORT spec is not giving any
further details about the RMR regions(May be the flags field can be extended to
describe these details).

Thanks,
Shameer

   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
