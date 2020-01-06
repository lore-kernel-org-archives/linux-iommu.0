Return-Path: <SRS0=Oi6h=23=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672A8C32771
	for <iommu@archiver.kernel.org>; Mon,  6 Jan 2020 08:37:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D0821734
	for <iommu@archiver.kernel.org>; Mon,  6 Jan 2020 08:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D0821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6DBC42048D;
	Mon,  6 Jan 2020 08:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CYcv8qeBfDP5; Mon,  6 Jan 2020 08:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 27C9B20462;
	Mon,  6 Jan 2020 08:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC54DC1D83;
	Mon,  6 Jan 2020 08:37:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4BEFC0881
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 08:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8CC0786FAD
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 08:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXn826wqJjZk for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jan 2020 08:37:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D0AD86F8D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 08:37:10 +0000 (UTC)
Received: from mail-pl1-f198.google.com ([209.85.214.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1ioNsq-0003O7-8O
 for iommu@lists.linux-foundation.org; Mon, 06 Jan 2020 08:37:08 +0000
Received: by mail-pl1-f198.google.com with SMTP id 2so8947736plb.15
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jan 2020 00:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=SNXkADHZhyJy0Bp0apNiPJvlafdrd5bDbFyFMJQ4dXU=;
 b=ao0urKOBNFU3lvh9hUBjmql02NOIMqlUpLITEuLiMVTNXFEWNwQlI//ETyZ2ky0Zv5
 Uo9jy7ncmGBxnEoTAakxPUU47Pnw07QZWCNCvQcF3K+mVQaVk90R0Ch/mG2L0WpuQERO
 XG/SvjifJ3ECEazRiQP516UkrRZ7uHqVYozQSq1nkuwF84QQ/jdxZ5vqtkflUfRmMXVr
 Qzjt3OgxJh0zXh8YIcqrHCeCHb2/tHrLwGIBoNXhcdqZb8WHSA82VUYUhI4eV1CvOrjz
 t07LokelARvq0hBYR1vWWwqnU47n+w/6WWFQD1zynRCSkyISIjmrm+u1aMFV1Y4XKAd/
 gi/g==
X-Gm-Message-State: APjAAAUOgLD5JMvKhUTCZl/SCuVAhHcf2hWIaMVHsJG4gClIqo3mEKQ3
 6nKF9Gc/5ukcnhTzgQs3Cc4kamPnnx2Hwz8YK50XoN2NQfSnU6NMGZlfPqjJAkykaCflVmIeIX7
 H3r938qEIjZbq1UKPGyyenlREs8aeWXjfjw9vLN9MprM76l8=
X-Received: by 2002:a17:90a:d78f:: with SMTP id
 z15mr41730959pju.36.1578299826803; 
 Mon, 06 Jan 2020 00:37:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEWrpnG0Qq6ElKUrUWzb4feESIT75MmnAI+RtORJgSr8PQwJVAJItr4+ahT0t2D7LvT5sagw==
X-Received: by 2002:a17:90a:d78f:: with SMTP id
 z15mr41730949pju.36.1578299826569; 
 Mon, 06 Jan 2020 00:37:06 -0800 (PST)
Received: from 2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net
 (2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net.
 [2001:b011:380f:35a3:2839:ccbd:36ed:2f4a])
 by smtp.gmail.com with ESMTPSA id o31sm72172458pgb.56.2020.01.06.00.37.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jan 2020 00:37:06 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <84CFD1EE-2DB7-451F-98E4-58C4B0046A81@canonical.com>
Date: Mon, 6 Jan 2020 16:37:04 +0800
Message-Id: <C4ADFDF0-8252-412A-8CFE-8E5ACE853B0A@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
 <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
 <20191217095341.GG8689@8bytes.org>
 <6DC0EAB3-89B5-4A16-9A38-D7AD954DDF1C@canonical.com>
 <CY4PR12MB13505BE6EFF95F7C48253120F7520@CY4PR12MB1350.namprd12.prod.outlook.com>
 <84CFD1EE-2DB7-451F-98E4-58C4B0046A81@canonical.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kernel development list <linux-kernel@vger.kernel.org>
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



> On Dec 20, 2019, at 10:13, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On Dec 20, 2019, at 03:15, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:
>> 
>>> -----Original Message-----
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Wednesday, December 18, 2019 12:45 PM
>>> To: Joerg Roedel <joro@8bytes.org>
>>> Cc: Christoph Hellwig <hch@infradead.org>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; iommu@lists.linux-foundation.org; Kernel
>>> development list <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>>> systems
>>> 
>>> 
>>> 
>>>> On Dec 17, 2019, at 17:53, Joerg Roedel <joro@8bytes.org> wrote:
>>>> 
>>>> On Fri, Dec 06, 2019 at 01:57:41PM +0800, Kai-Heng Feng wrote:
>>>>> Hi Joerg,
>>>>> 
>>>>>> On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote:
>>>>>> 
>>>>>> On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
>>>>>>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>>>>>>> 
>>>>>>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
>>>>>>> do the same here to avoid screen flickering on 4K monitor.
>>>>>> 
>>>>>> Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
>>>>>> identity map the GPU device?
>>>>> 
>>>>> Ok, there's set_device_exclusion_range() to exclude the device from
>>> IOMMU.
>>>>> However I don't know how to generate range_start and range_length,
>>> which are read from ACPI.
>>>> 
>>>> set_device_exclusion_range() is not the solution here. The best is if
>>>> the GPU device is put into a passthrough domain at boot, in which it
>>>> will be identity mapped. DMA still goes through the IOMMU in this
>>>> case, but it only needs to lookup the device-table, page-table walks
>>>> will not be done anymore.
>>>> 
>>>> The best way to implement this is to put it into the
>>>> amd_iommu_add_device() in drivers/iommu/amd_iommu.c. There is this
>>>> check:
>>>> 
>>>>      if (dev_data->iommu_v2)
>>>> 		iommu_request_dm_for_dev(dev);
>>>> 
>>>> The iommu_request_dm_for_dev() function causes the device to be
>>>> identity mapped. The check can be extended to also check for a device
>>>> white-list for devices that need identity mapping.
>>> 
>>> My patch looks like this but the original behavior (4K screen flickering) is still
>>> the same:
>> 
>> Does reverting the patch to disable ATS along with this patch help?
> 
> Unfortunately it doesn't help.

Any further suggestion to let me try?

Kai-Heng

> 
> Kai-Heng
> 
>> 
>> Alex
>> 
>>> 
>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>> index bd25674ee4db..f913a25c9e92 100644
>>> --- a/drivers/iommu/amd_iommu.c
>>> +++ b/drivers/iommu/amd_iommu.c
>>> @@ -42,6 +42,7 @@
>>> #include <asm/iommu.h>
>>> #include <asm/gart.h>
>>> #include <asm/dma.h>
>>> +#include <asm/pci-direct.h>
>>> 
>>> #include "amd_iommu_proto.h"
>>> #include "amd_iommu_types.h"
>>> @@ -2159,6 +2160,8 @@ static int amd_iommu_add_device(struct device
>>> *dev)
>>>       struct iommu_domain *domain;
>>>       struct amd_iommu *iommu;
>>>       int ret, devid;
>>> +       bool need_identity_mapping = false;
>>> +       u32 header;
>>> 
>>>       if (!check_device(dev) || get_dev_data(dev))
>>>               return 0;
>>> @@ -2184,7 +2187,11 @@ static int amd_iommu_add_device(struct device
>>> *dev)
>>> 
>>>       BUG_ON(!dev_data);
>>> 
>>> -       if (dev_data->iommu_v2)
>>> +       header = read_pci_config(0, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>>> PCI_FUNC(devid));
>>> +       if ((header & 0xffff) == 0x1002 && (header >> 16) == 0x98e4)
>>> +               need_identity_mapping = true;
>>> +
>>> +       if (dev_data->iommu_v2 || need_identity_mapping)
>>>               iommu_request_dm_for_dev(dev);
>>> 
>>>       /* Domains are initialized for this device - have a look what we ended up
>>> with */
>>> 
>>> 
>>> $ dmesg | grep -i direct
>>> [    0.011446] Using GB pages for direct mapping
>>> [    0.703369] pci 0000:00:01.0: Using iommu direct mapping
>>> [    0.703830] pci 0000:00:08.0: Using iommu direct mapping
>>> 
>>> So the graphics device (pci 0000:00:01.0:) is using direct mapping after the
>>> change.
>>> 
>>> Kai-Heng
>>> 
>>>> 
>>>> HTH,
>>>> 
>>>> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
