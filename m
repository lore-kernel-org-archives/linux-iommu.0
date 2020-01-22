Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FEFC32771
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 04:51:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABB821569
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 04:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABB821569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8346A20495;
	Wed, 22 Jan 2020 04:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S9fItMyoTVp6; Wed, 22 Jan 2020 04:51:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EDC6620387;
	Wed, 22 Jan 2020 04:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D070AC0176;
	Wed, 22 Jan 2020 04:51:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E357DC0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 04:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C65C287B5D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 04:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmGCM4g+DV6d for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 04:51:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0FC9B87B82
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 04:50:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jan 2020 20:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; d="scan'208";a="215781251"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138])
 ([10.239.159.138])
 by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 20:50:53 -0800
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200121141712.GA94911@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <48576108-c261-1bb8-cea9-db3b6782f383@linux.intel.com>
Date: Wed, 22 Jan 2020 12:49:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121141712.GA94911@google.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Bjorn,

On 1/21/20 10:17 PM, Bjorn Helgaas wrote:
> [+cc linux-pci, thread athttps://lore.kernel.org/r/20200101052648.14295-1-baolu.lu@linux.intel.com]
> 
> On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
>> The new parameter takes a list of devices separated by a semicolon.
>> Each device specified will have its iommu_passthrough bit in struct
>> device set. This is very similar to the existing 'disable_acs_redir'
>> parameter.
> Almost all of this patchset is in drivers/iommu.  Should the parameter
> be "iommu ..." instead of "pci=iommu_passthrough=..."?
> 
> There is already an "iommu.passthrough=" argument.  Would this fit
> better there?  Since the iommu_passthrough bit is generic, it seems
> like you anticipate similar situations for non-PCI devices.
> 

Yes. Fair enough.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
