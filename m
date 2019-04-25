Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AB0C072AB
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 13:21:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA7B206BA
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA7B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 588AA1E6D;
	Thu, 25 Apr 2019 13:21:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0FA241E56
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 13:21:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8CAA074A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 13:21:16 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D04D23164680;
	Thu, 25 Apr 2019 13:21:14 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 02E3F1001DE4;
	Thu, 25 Apr 2019 13:21:06 +0000 (UTC)
Subject: Re: [PATCH v2 02/19] iommu: introduce device fault data
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <220a581e-0ee8-70e2-796b-b434594e4825@redhat.com>
Date: Thu, 25 Apr 2019 15:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 13:21:15 +0000 (UTC)
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190425132105.SwQX84VVORrjrNijjWX0o_G4HIhncP7qU0ZMnd4tepQ@z>

Hi Jean-Philippe,

On 4/25/19 2:46 PM, Jean-Philippe Brucker wrote:
> On 24/04/2019 00:31, Jacob Pan wrote:
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> new file mode 100644
>> index 0000000..edcc0dd
>> --- /dev/null
>> +++ b/include/uapi/linux/iommu.h
>> @@ -0,0 +1,115 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * IOMMU user API definitions
>> + */
>> +
>> +#ifndef _UAPI_IOMMU_H
>> +#define _UAPI_IOMMU_H
>> +
>> +#include <linux/types.h>
>> +
>> +#define IOMMU_FAULT_PERM_WRITE	(1 << 0) /* write */
>> +#define IOMMU_FAULT_PERM_EXEC	(1 << 1) /* exec */
>> +#define IOMMU_FAULT_PERM_PRIV	(1 << 2) /* privileged */
> 
> Could we add IOMMU_FAULT_PERM_READ back? The PRI Page Request has both R
> and W fields, and R=W=0 encodes the PASID Stop Markers. Even though the
> IOMMU drivers currently filter out the Stop Markers, we may want to
> inject them into guests at some point in the future, which wouldn't be
> possible with the current API.

OK for me.

 We could add a
> IOMMU_FAULT_PAGE_REQUEST_PERM_VALID bit instead, but I still find it
> weird to denote the validity of a bitfield using a separate bit.
> 
> Given that three different series now rely on this, how about we send
> the fault patches separately for v5.2? I pushed the recoverable fault
> support applied on top of this, with the PERM_READ bit and cleaned up
> kernel doc, to git://linux-arm.org/linux-jpb.git sva/api

my only concern is is it likely to be upstreamed without any actual
user? In the positive, of course, I don't have any objection.

Thanks

Eric
> 
> Thanks,
> Jean
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
