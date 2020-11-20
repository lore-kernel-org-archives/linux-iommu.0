Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F6C388F9
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 02:20:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D442225E
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 02:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D442225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0470B86D78;
	Fri, 20 Nov 2020 02:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w3mdakllhSc5; Fri, 20 Nov 2020 02:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9782D86D08;
	Fri, 20 Nov 2020 02:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B056C1825;
	Fri, 20 Nov 2020 02:20:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96F27C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 02:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7A395203F3
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 02:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mXNn6DP9TyiF for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 02:20:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id DC4631FC71
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 02:20:21 +0000 (UTC)
IronPort-SDR: RBFj+OR8j1TcxUII0B18jSolp3COCwdzmPUDWRkS628asIY9vwz+sy8K4M10E6D6vivbmkHz+6
 QcfKBED/pKNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="158439151"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; d="scan'208";a="158439151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2020 18:20:21 -0800
IronPort-SDR: xt3/am10qXx+QJZeUjl3U9pdvg23WlP0jWA6zWN9RlOM4lgb1P4f+O5ptqZmbhIi+UtUbE6K8V
 emJkv5yQqdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; d="scan'208";a="431430496"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 18:20:19 -0800
Subject: Re: [Patch V8 3/3] iommu: Document usage of
 "/sys/kernel/iommu_groups/<grp_id>/type" file
To: Will Deacon <will@kernel.org>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-4-ashok.raj@intel.com>
 <20201118135137.GA2177@willie-the-truck>
 <7eeae289-070f-c5c9-aff5-edbb8437ef69@linux.intel.com>
 <20201119085529.GB3599@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <918cf2d0-91b7-b1f1-3859-88615acbbb1c@linux.intel.com>
Date: Fri, 20 Nov 2020 10:13:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119085529.GB3599@willie-the-truck>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

Hi Will

On 11/19/20 4:55 PM, Will Deacon wrote:
> Hi Lu,
> 
> On Thu, Nov 19, 2020 at 10:32:43AM +0800, Lu Baolu wrote:
>> On 11/18/20 9:51 PM, Will Deacon wrote:
>>> On Fri, Sep 25, 2020 at 12:06:20PM -0700, Ashok Raj wrote:
>>> I can't figure out from this description what string is returned to
>>> userspace in the case that the group is configured as  blocked or unmanaged.
>>
>> This series only enables switching a default domain in use between DMA
>> and IDENTITY. Other cases will result in write failures.
> 
> I understood that from the text, but what I couldn't figure out is what
> happens if you *read* the file when the default domain is not identity
> or DMA. I think that should be documented.

Yes, agreed. I will add this.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
