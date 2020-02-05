Return-Path: <SRS0=q6a/=3Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F64C33CA1
	for <iommu@archiver.kernel.org>; Wed,  5 Feb 2020 10:10:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0D520661
	for <iommu@archiver.kernel.org>; Wed,  5 Feb 2020 10:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0D520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BC5D8550C;
	Wed,  5 Feb 2020 10:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dfbZxwy7soRD; Wed,  5 Feb 2020 10:10:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 509B8815D9;
	Wed,  5 Feb 2020 10:10:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3757EC0175;
	Wed,  5 Feb 2020 10:10:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC06DC0174
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 10:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A40E820450
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 10:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQtAU-optdcz for <iommu@lists.linux-foundation.org>;
 Wed,  5 Feb 2020 10:10:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by silver.osuosl.org (Postfix) with ESMTPS id 1B0C120335
 for <iommu@lists.linux-foundation.org>; Wed,  5 Feb 2020 10:10:18 +0000 (UTC)
Received: from mail-pj1-f71.google.com ([209.85.216.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1izHdP-0007bM-Pe
 for iommu@lists.linux-foundation.org; Wed, 05 Feb 2020 10:10:16 +0000
Received: by mail-pj1-f71.google.com with SMTP id m61so1039116pjb.1
 for <iommu@lists.linux-foundation.org>; Wed, 05 Feb 2020 02:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=b8Oi2WdDQGlnw0JZx35Y2ZoU7u/G+yblEF6ps+T1Z7A=;
 b=IMPOTIKHcf5Z3tA5g2vojZJgnaJWTXFFXq8oruV57GMbfAg2p1ljhDVjGovO5uzAR2
 8zzu8yL/BdAZSAhUhuuhPCY3jhFcgMRqyLxEC1IyP0d9+L2wnMmrv4ZrTorRdwNRnuWq
 qBXmHvMBNXcfMWuWWQXm754uO1cC57dwl0sS9Q/pbQN2dcnEc6Ui+GuCjU9RMUZ82ah+
 h1vYBL4x0Dvf9DfJ6Q9CET9j7j3TelfKqXoZCCI7hIKy2uP5VkNyhaIHpvwT2qLhPibR
 nUHNBGRSZ80WNl178K6Bk8UAgr12bHvsPEopGwUh7Rc95MySQXB+7THlv7bsJD9PH9hg
 nW3A==
X-Gm-Message-State: APjAAAV1bMA1h0LH024q4PCdAHBjs8KKCAS5WGHbvryPRmOvG/n85H8Z
 uortI1IIT6rb8PTFIXSnU9CPcAxc8b7K/UQtd7MntAsBEGPPE9gx0JikPxlZc5z5u6Dtkh2QLAt
 XGIyD/ZjMgkyOMrvdPGYBErugpHhynfjyiefBcAYTlYDA2Vo=
X-Received: by 2002:a62:828b:: with SMTP id
 w133mr34324166pfd.192.1580897414255; 
 Wed, 05 Feb 2020 02:10:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhLiRotsNnQNsivhoayjMiCgeXE0WQrA1E8lYViSEDb6rb+V+WWKm6Cr1nYBXR+C80MOw0Qw==
X-Received: by 2002:a62:828b:: with SMTP id
 w133mr34324136pfd.192.1580897413944; 
 Wed, 05 Feb 2020 02:10:13 -0800 (PST)
Received: from 2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net
 (2001-b011-380f-35a3-4cfd-361b-ac7d-6a8c.dynamic-ip6.hinet.net.
 [2001:b011:380f:35a3:4cfd:361b:ac7d:6a8c])
 by smtp.gmail.com with ESMTPSA id 10sm28075377pfu.132.2020.02.05.02.10.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Feb 2020 02:10:13 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <C4ADFDF0-8252-412A-8CFE-8E5ACE853B0A@canonical.com>
Date: Wed, 5 Feb 2020 18:10:11 +0800
Message-Id: <6B7AE45E-F1E0-4949-B3E6-B78658CD223F@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
 <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
 <20191217095341.GG8689@8bytes.org>
 <6DC0EAB3-89B5-4A16-9A38-D7AD954DDF1C@canonical.com>
 <CY4PR12MB13505BE6EFF95F7C48253120F7520@CY4PR12MB1350.namprd12.prod.outlook.com>
 <84CFD1EE-2DB7-451F-98E4-58C4B0046A81@canonical.com>
 <C4ADFDF0-8252-412A-8CFE-8E5ACE853B0A@canonical.com>
To: Joerg Roedel <joro@8bytes.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
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

Hi Joerg,

> On Jan 6, 2020, at 16:37, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On Dec 20, 2019, at 10:13, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On Dec 20, 2019, at 03:15, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:
>>> 
>>>> -----Original Message-----
>>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> Sent: Wednesday, December 18, 2019 12:45 PM
>>>> To: Joerg Roedel <joro@8bytes.org>
>>>> Cc: Christoph Hellwig <hch@infradead.org>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; iommu@lists.linux-foundation.org; Kernel
>>>> development list <linux-kernel@vger.kernel.org>
>>>> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>>>> systems
>>>> 
>>>> 
>>>> 
>>>>> On Dec 17, 2019, at 17:53, Joerg Roedel <joro@8bytes.org> wrote:
>>>>> 
>>>>> On Fri, Dec 06, 2019 at 01:57:41PM +0800, Kai-Heng Feng wrote:
>>>>>> Hi Joerg,
>>>>>> 
>>>>>>> On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote:
>>>>>>> 
>>>>>>> On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
>>>>>>>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>>>>>>>> 
>>>>>>>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
>>>>>>>> do the same here to avoid screen flickering on 4K monitor.
>>>>>>> 
>>>>>>> Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
>>>>>>> identity map the GPU device?
>>>>>> 
>>>>>> Ok, there's set_device_exclusion_range() to exclude the device from
>>>> IOMMU.
>>>>>> However I don't know how to generate range_start and range_length,
>>>> which are read from ACPI.
>>>>> 
>>>>> set_device_exclusion_range() is not the solution here. The best is if
>>>>> the GPU device is put into a passthrough domain at boot, in which it
>>>>> will be identity mapped. DMA still goes through the IOMMU in this
>>>>> case, but it only needs to lookup the device-table, page-table walks
>>>>> will not be done anymore.
>>>>> 
>>>>> The best way to implement this is to put it into the
>>>>> amd_iommu_add_device() in drivers/iommu/amd_iommu.c. There is this
>>>>> check:
>>>>> 
>>>>>     if (dev_data->iommu_v2)
>>>>> 		iommu_request_dm_for_dev(dev);
>>>>> 
>>>>> The iommu_request_dm_for_dev() function causes the device to be
>>>>> identity mapped. The check can be extended to also check for a device
>>>>> white-list for devices that need identity mapping.
>>>> 
>>>> My patch looks like this but the original behavior (4K screen flickering) is still
>>>> the same:
>>> 
>>> Does reverting the patch to disable ATS along with this patch help?
>> 
>> Unfortunately it doesn't help.
> 
> Any further suggestion to let me try?

Since using identity mapping with ATS doesn't help,
Is it possible to merge this patch as is?

Kai-Heng

> 
> Kai-Heng
> 
>> 
>> Kai-Heng
>> 
>>> 
>>> Alex
>>> 
>>>> 
>>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>>> index bd25674ee4db..f913a25c9e92 100644
>>>> --- a/drivers/iommu/amd_iommu.c
>>>> +++ b/drivers/iommu/amd_iommu.c
>>>> @@ -42,6 +42,7 @@
>>>> #include <asm/iommu.h>
>>>> #include <asm/gart.h>
>>>> #include <asm/dma.h>
>>>> +#include <asm/pci-direct.h>
>>>> 
>>>> #include "amd_iommu_proto.h"
>>>> #include "amd_iommu_types.h"
>>>> @@ -2159,6 +2160,8 @@ static int amd_iommu_add_device(struct device
>>>> *dev)
>>>>      struct iommu_domain *domain;
>>>>      struct amd_iommu *iommu;
>>>>      int ret, devid;
>>>> +       bool need_identity_mapping = false;
>>>> +       u32 header;
>>>> 
>>>>      if (!check_device(dev) || get_dev_data(dev))
>>>>              return 0;
>>>> @@ -2184,7 +2187,11 @@ static int amd_iommu_add_device(struct device
>>>> *dev)
>>>> 
>>>>      BUG_ON(!dev_data);
>>>> 
>>>> -       if (dev_data->iommu_v2)
>>>> +       header = read_pci_config(0, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>>>> PCI_FUNC(devid));
>>>> +       if ((header & 0xffff) == 0x1002 && (header >> 16) == 0x98e4)
>>>> +               need_identity_mapping = true;
>>>> +
>>>> +       if (dev_data->iommu_v2 || need_identity_mapping)
>>>>              iommu_request_dm_for_dev(dev);
>>>> 
>>>>      /* Domains are initialized for this device - have a look what we ended up
>>>> with */
>>>> 
>>>> 
>>>> $ dmesg | grep -i direct
>>>> [    0.011446] Using GB pages for direct mapping
>>>> [    0.703369] pci 0000:00:01.0: Using iommu direct mapping
>>>> [    0.703830] pci 0000:00:08.0: Using iommu direct mapping
>>>> 
>>>> So the graphics device (pci 0000:00:01.0:) is using direct mapping after the
>>>> change.
>>>> 
>>>> Kai-Heng
>>>> 
>>>>> 
>>>>> HTH,
>>>>> 
>>>>> 	Joerg
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
