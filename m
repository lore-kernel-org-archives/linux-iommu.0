Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C596C43461
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 00:13:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3487E2087E
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 00:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3487E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E10E8511B;
	Fri, 28 Aug 2020 00:13:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aLtYXS8V7Dgu; Fri, 28 Aug 2020 00:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AE1885087;
	Fri, 28 Aug 2020 00:13:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63959C016F;
	Fri, 28 Aug 2020 00:13:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57250C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 00:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F5FF87C11
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 00:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXYDXngL4-kP for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 00:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6433B87A3A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 00:13:47 +0000 (UTC)
IronPort-SDR: nn2afO+P9SU3bnEvefB//czltaseLnwDIk1vBsuS5tIxOXf4eCW90yprCYOxdvld6W6w/+YDWt
 tuewXkdsh8ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="174633105"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="174633105"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 17:13:46 -0700
IronPort-SDR: uAmGoMAFhGRvD5NPRLnN/ekYEL+Xjxv+g4TWsI9UNYPL5S4ZMqTmCJhNgf7wqckE0S2ryUHTLn
 7aEo94gI807g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="295950071"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga003.jf.intel.com with ESMTP; 27 Aug 2020 17:13:46 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 17:12:49 -0700
Received: from orsmsx101.amr.corp.intel.com (10.22.225.128) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 17:12:49 -0700
Received: from [10.254.177.214] (10.254.177.214) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 17:12:48 -0700
Subject: Re: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.163462706@linutronix.de>
 <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com>
 <878se1uulb.fsf@nanos.tec.linutronix.de>
 <87r1rtt9mi.fsf@nanos.tec.linutronix.de>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <f78f0b1f-3c83-2629-405c-7b25875432db@intel.com>
Date: Thu, 27 Aug 2020 17:12:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1rtt9mi.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
X-Originating-IP: [10.254.177.214]
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ
 Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

Hi Thomas,

On 8/26/2020 1:50 PM, Thomas Gleixner wrote:
> On Wed, Aug 26 2020 at 20:32, Thomas Gleixner wrote:
>> On Wed, Aug 26 2020 at 09:50, Megha Dey wrote:
>>>> @@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
>>>>    static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
>>>>    					  msi_alloc_info_t *arg)
>>>>    {
>>>> -	return arg->dmar_id;
>>>> +	return arg->hwirq;
>>> Shouldn't this return the arg->devid which gets set in dmar_alloc_hwirq?
>> Indeed.
> But for simplicity we can set arg->hwirq to the dmar id right in the
> alloc function and then once the generic ops are enabled remove the dmar
> callback completely
True, can get rid of more code that way.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
