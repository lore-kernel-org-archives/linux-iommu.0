Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33CEC388F9
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:07:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E092469D
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E092469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 72DDF86C51;
	Thu, 19 Nov 2020 12:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEzE+sLmUEoS; Thu, 19 Nov 2020 12:07:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D0D886C4C;
	Thu, 19 Nov 2020 12:07:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3FCAC1825;
	Thu, 19 Nov 2020 12:07:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85437C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6BE5D86AD0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AwnMXOqdLiA4 for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 12:07:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B699F86AA5
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:07:11 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CcJJf3lMNz67F2M;
 Thu, 19 Nov 2020 20:04:50 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 19 Nov 2020 13:07:08 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 19 Nov 2020 12:07:07 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Thu, 19 Nov 2020 12:07:07 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Sami Mujawar <Sami.Mujawar@arm.com>, "david.e.box@linux.intel.com"
 <david.e.box@linux.intel.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>
Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Topic: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Thread-Index: AQHWtpQY66bs/ZNapk2zvFyjgM+sLanPaxLw
Date: Thu, 19 Nov 2020 12:07:07 +0000
Message-ID: <735edb5c4da842609c1d2a0eed73b06c@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-3-shameerali.kolothum.thodi@huawei.com>
 <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
 <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>
In-Reply-To: <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.210.168.73]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, nd <nd@arm.com>, Robin
 Murphy <Robin.Murphy@arm.com>, wanghuiqiang <wanghuiqiang@huawei.com>
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
> From: Sami Mujawar [mailto:Sami.Mujawar@arm.com]
> Sent: 09 November 2020 12:30
> To: david.e.box@linux.intel.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; devel@acpica.org
> Cc: Linuxarm <linuxarm@huawei.com>; Lorenzo Pieralisi
> <Lorenzo.Pieralisi@arm.com>; joro@8bytes.org; Robin Murphy
> <Robin.Murphy@arm.com>; wanghuiqiang <wanghuiqiang@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>; nd <nd@arm.com>
> Subject: RE: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
> parsing
> 
> Hi,
> 
> -----Original Message-----
> From: David E. Box <david.e.box@linux.intel.com>
> Sent: 28 October 2020 06:44 PM
> To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; devel@acpica.org
> Cc: linuxarm@huawei.com; Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>;
> joro@8bytes.org; Robin Murphy <Robin.Murphy@arm.com>;
> wanghuiqiang@huawei.com; jonathan.cameron@huawei.com
> Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
> parsing
> 
> Hi,
> 
> On Tue, 2020-10-27 at 11:26 +0000, Shameer Kolothum wrote:
> 
> ...
> 
> > @@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct
> > acpi_iort_node *iort_node)
> >  #else
> >  static inline void iort_enable_acs(struct acpi_iort_node *iort_node)
> > { }
> >  #endif
> > +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> > +{
> > +	struct iort_rmr_entry *e;
> > +	u64 end, start = desc->base_address, length = desc->length;
> > +
> > +	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K != 0))
> 
> You could just do:
> 
> if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K))
> 
> [SAMI] In my opinion, the following may be better:
> 	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> [/SAMI]

Thanks for your suggestions. I don't have a strong opinion on either
of those, but will change it with the latter one for now.

Thanks,
Shameer

> Regards,
> 
> Sami Mujawar
> 
> David
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-leave@acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
