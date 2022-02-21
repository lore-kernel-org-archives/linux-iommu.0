Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35F4C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 02:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 718F040892;
	Mon, 21 Feb 2022 02:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id InaT0JH_SMRL; Mon, 21 Feb 2022 02:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4218540886;
	Mon, 21 Feb 2022 02:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15CBFC001A;
	Mon, 21 Feb 2022 02:46:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E17C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 02:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BF1581450
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 02:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RSqXJSPAxFt4 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 02:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A9478144F
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 02:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645411577; x=1676947577;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uz8E+xxDJjeZD5vPZzoxNAUPHJZRua/avHFTeYZFUi4=;
 b=kzBkCQfpXyQRcx3IqNsLMksHNUDr8b+maxb3A9C+EK95YXxVGGs/549x
 InmFCf+xpiHIUhpF/l655MdG6y8QDUrwkNtvaU6cKvxaZ5Jr1jaB7RLdw
 JzGo5D0j+s52lUQjoerM/0/Jd8KxmaGxICeowYGPYT1NEIcWVqkhgt4xw
 ZmW6vJLbzYSgeluIItpaNviQuX/auH2jaILGuTEqLPoxMXugtJCE8KkGm
 Uu/ob+Y2af54Rdo2g0xvab2CUn9rQpsacx64/lpO64ybksp1peRKflmid
 SPv0MJfQGY3betQ6paCyMwq/EqzqpbbnsI5WooHlObmWelBe079JJkYxB g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251371164"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="251371164"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2022 18:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; d="scan'208";a="683067471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 18:46:13 -0800
Message-ID: <b762903c-adf9-67a0-df6d-a1212e12670e@linux.intel.com>
Date: Mon, 21 Feb 2022 10:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix list_add double add when enabling
 VMD and scalable mode
Content-Language: en-US
To: Huang Adrian <adrianhuang0701@gmail.com>
References: <20220216091307.703-1-adrianhuang0701@gmail.com>
 <989cf124-13d7-5601-a942-e515c81a72a9@linux.intel.com>
 <CAHKZfL0dx8HuuB1AqN3fkcHjPZDJMTfPqRgW4XnuFVE8Cw4iFQ@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <CAHKZfL0dx8HuuB1AqN3fkcHjPZDJMTfPqRgW4XnuFVE8Cw4iFQ@mail.gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2/18/22 4:21 PM, Huang Adrian wrote:
>> Another thing I am still concerned is about the context entry setup.
>> What does the context entries look like for both VMD and subdevices
>> after domain_context_mapping() being called?
> pasid_table in struct device_domain_info is NULL because the field
> pasid_table is configured in intel_pasid_alloc_table().
> 
> The following statement in domain_context_mapping_one() is true for
> subdevices because the context is configured by the real VMD device
> 0000:59:00.5. So, domain_context_mapping() does nothing for
> subdevices.
>                  if (context_present(context))
>                                goto out_unlock;
> 
> Here is the log for your reference with pr_debug() enabled.
> 
> [   19.063445] pci 0000:59:00.5: Adding to iommu group 42
> ...
> [   22.673502] DMAR: Set context mapping for 59:00.5
> ..
> [   32.089696] vmd 0000:59:00.5: PCI host bridge to bus 10000:80
> [   32.119452] pci 10000:80:01.0: [8086:352a] type 01 class 0x060400
> [   32.126302] pci 10000:80:01.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
> [   32.134023] pci 10000:80:01.0: enabling Extended Tags
> [   32.139730] pci 10000:80:01.0: PME# supported from D0 D3hot D3cold
> [   32.160526] DMAR: Set context mapping for 59:00.5
> [   32.171090] pci 10000:80:01.0: Adding to iommu group 42
> ...

That's clear to me now. Thank you very much!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
