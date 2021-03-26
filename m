Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F5FC433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 01:04:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137C461A1E
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 01:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137C461A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA59B6067A;
	Fri, 26 Mar 2021 01:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ECCykEdY1UXH; Fri, 26 Mar 2021 01:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FB216069D;
	Fri, 26 Mar 2021 01:04:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB43C000E;
	Fri, 26 Mar 2021 01:04:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC3DCC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C80388429F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CGptaxJ5Bxj4 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 01:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3343F84011
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 01:04:01 +0000 (UTC)
IronPort-SDR: BunBmfV94+qFJ0QeupjFjZ9x7CTHPou7Px3yauW/1BQhwcSCt2bEeBKoAg3tSIrdVjCZXMsF1A
 3d6tZN1AmhwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="276179489"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="276179489"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2021 18:04:00 -0700
IronPort-SDR: i/t+GBh+pimmH2clQEO7DHHzuKyakP9WT7fBKDiAFncZY+OdlPgEH4JY3/F61NzvRWcFausUHX
 huRfojb5IuNw==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="525855417"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.209.174.55])
 ([10.209.174.55])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2021 18:03:58 -0700
Subject: Re: [Patch V2 12/13] irqchip: Add IMS (Interrupt Message Store) driver
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
 <1614370277-23235-13-git-send-email-megha.dey@intel.com>
 <87zgyrqgbm.wl-maz@kernel.org> <87eeg3vyph.fsf@nanos.tec.linutronix.de>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <cc98407b-877c-317b-04c6-514db2ea09a4@intel.com>
Date: Thu, 25 Mar 2021 18:03:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87eeg3vyph.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, bhelgaas@google.com, dan.j.williams@intel.com,
 dwmw@amazon.co.uk
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

Hi Thomas/Marc,

On 3/25/2021 12:07 PM, Thomas Gleixner wrote:
> On Thu, Mar 25 2021 at 17:43, Marc Zyngier wrote:
>> On Fri, 26 Feb 2021 20:11:16 +0000,
>> Megha Dey <megha.dey@intel.com> wrote:
>>> +
>>> +#include <linux/irqchip/irq-ims-msi.h>
>>> +
>>> +#ifdef CONFIG_IMS_MSI_ARRAY
>> Given that this covers the whole driver, what is this #defined used
>> for? You might as well make the driver depend on this config option.
> That's a leftover from the initial version I wrote which had also
> support for IMS_MSI_QUEUE to store the message in queue memory, but we
> have no use case yet for it.
>
> But yes, as things stand now it does not make any sense and IIRC at the
> end they do not share anything in the C file except for some includes at
> the very end.
Sure, I will make this change.
>
> Thanks,
>
>          tglx
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
