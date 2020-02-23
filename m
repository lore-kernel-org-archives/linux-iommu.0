Return-Path: <SRS0=uxOK=4L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A58C35669
	for <iommu@archiver.kernel.org>; Sun, 23 Feb 2020 01:50:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E6E20702
	for <iommu@archiver.kernel.org>; Sun, 23 Feb 2020 01:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A8520860F8;
	Sun, 23 Feb 2020 01:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xrfZNggE1_nZ; Sun, 23 Feb 2020 01:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5690B85FA0;
	Sun, 23 Feb 2020 01:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38F1AC1AE2;
	Sun, 23 Feb 2020 01:50:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 583D3C013E
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 01:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3DEC122708
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 01:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d3oF4uPxi8Kv for <iommu@lists.linux-foundation.org>;
 Sun, 23 Feb 2020 01:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 926B120346
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 01:50:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 17:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,474,1574150400"; d="scan'208";a="255217994"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by orsmga002.jf.intel.com with ESMTP; 22 Feb 2020 17:50:39 -0800
Subject: Re: [PATCH V2 2/5] iommu/vt-d: Rename device_def_domain_type() to
 intel_iommu_dev_def_domain_type()
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <cd79477f93816a4b0940a8f6770327772b9786af.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5cbc8651-3a7f-95fa-3db0-704cb15978f5@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F572054FD@ORSMSX114.amr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <682f468c-3c16-0a21-c67b-0305545d85fe@linux.intel.com>
Date: Sun, 23 Feb 2020 09:50:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F572054FD@ORSMSX114.amr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi,

On 2020/2/23 7:59, Prakhya, Sai Praneeth wrote:
>>
>> On 2020/2/17 5:57, Sai Praneeth Prakhya wrote:
>>> The functionality needed for iommu_ops->dev_def_domain_type() is
>>> already provided by device_def_domain_type() in intel_iommu.c. But,
>>> every call back function in intel_iommu_ops starts with intel_iommu
>>> prefix, hence rename
>>> device_def_domain_type() to intel_iommu_dev_def_domain_type() so that
>>> it follows the same semantics.
>>
>> How about keep device_def_domain_type() and call it in the new
>> intel_iommu_dev_def_domain_type()?
> 
> Sure! I could but could you please explain the advantages we might get by doing so?
> Less number of changes is what I could think of.. any other reasons?
> 

device_def_domain_type() is a quirk list for devices that must use a
specified domain type. intel_iommu_dev_def_domain_type() tells the upper
layer whether the device could switch to another type of domain. Put
them in separated functions will make it easier for maintenance.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
