Return-Path: <SRS0=Jdo0=25=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2322C282DD
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 23:30:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CA62051A
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 23:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CA62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0C2C020508;
	Wed,  8 Jan 2020 23:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aaRsa4zRF0nK; Wed,  8 Jan 2020 23:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3C52E2049A;
	Wed,  8 Jan 2020 23:30:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 207E5C1D81;
	Wed,  8 Jan 2020 23:30:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA218C0881
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 23:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B7ECA867D4
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 23:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TFGFMoO42xNY for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jan 2020 23:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5072081132
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 23:29:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 15:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; d="scan'208";a="246494649"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 08 Jan 2020 15:29:56 -0800
Subject: Re: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
To: Christoph Hellwig <hch@infradead.org>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
 <20200102001823.21976-23-baolu.lu@linux.intel.com>
 <20200108141603.GA11875@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d73ac0f4-b347-8f59-d2a7-8eeee142ed8d@linux.intel.com>
Date: Thu, 9 Jan 2020 07:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108141603.GA11875@infradead.org>
Content-Language: en-US
Cc: Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org
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

Hi Christoph,

On 1/8/20 10:16 PM, Christoph Hellwig wrote:
>> +/*
>> + * We expect devices with endpoint scope to have normal PCI
>> + * headers, and devices with bridge scope to have bridge PCI
>> + * headers.  However some PCI devices may be listed in the
>> + * DMAR table with bridge scope, even though they have a
>> + * normal PCI header. We don't declare a socpe mismatch for
>> + * below special cases.
>> + */
> 
> Please use up all 80 lines for comments.
> 
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2f0d,	/* NTB devices  */
>> +			 quirk_dmar_scope_mismatch);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2020,	/* NVME host */
>> +			 quirk_dmar_scope_mismatch);
> 
> As said before "NVME host" host.  Besides the wrong spelling of NVMe,
> the NVMe host is the Linux kernel, so describing a device as such seems
> rather bogus.
> 

This patch has been replaced with this one.

https://lkml.org/lkml/2020/1/5/103

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
