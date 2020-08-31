Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E209C433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 07:30:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C9520738
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 07:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C9520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8A2E02077C;
	Mon, 31 Aug 2020 07:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BXEznhqKs9AI; Mon, 31 Aug 2020 07:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B2FA120511;
	Mon, 31 Aug 2020 07:30:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D861C0052;
	Mon, 31 Aug 2020 07:30:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94E99C0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 81218875C2
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4sZ6vmtViqN for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 07:30:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 00E2A875BC
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:30:20 +0000 (UTC)
IronPort-SDR: 54TsCbjVnyGCvLz7GbWaqF6Kod8lAt/MbslA9DgfylxzRvhxD8Jm+Q85FFDfm5GR2e9pwE9mwg
 iw6Avo0T1LjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144603598"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; d="scan'208";a="144603598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 00:30:19 -0700
IronPort-SDR: RhGSL7wyVsjh+qsvOh480VVPNj2zqANcLsAm0u5fLr0CbkyXraU3/CQPTHJpjckYsGMnAcC/x1
 3SMjo64MzSQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; d="scan'208";a="501762398"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.84])
 ([10.254.212.84])
 by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2020 00:29:57 -0700
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <02e30654-714b-520a-0d20-fca20794df93@linux.intel.com>
 <87pn77i93c.fsf@nanos.tec.linutronix.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b41eb9d7-0438-8a3a-d708-0173b4b25fea@linux.intel.com>
Date: Mon, 31 Aug 2020 15:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87pn77i93c.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On 2020/8/31 15:10, Thomas Gleixner wrote:
> On Mon, Aug 31 2020 at 08:51, Lu Baolu wrote:
>> On 8/26/20 7:16 PM, Thomas Gleixner wrote:
>>> This is the second version of providing a base to support device MSI (non
>>> PCI based) and on top of that support for IMS (Interrupt Message Storm)
>>> based devices in a halfways architecture independent way.
>>
>> After applying this patch series, the dmar_alloc_hwirq() helper doesn't
>> work anymore during boot. This causes the IOMMU driver to fail to
>> register the DMA fault handler and abort the IOMMU probe processing.
>> Is this a known issue?
> 
> See replies to patch 15/46 or pull the git tree. It has the issue fixed.

Ah! Yes. Sorry for the noise.

Beset regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
