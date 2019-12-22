Return-Path: <SRS0=tVkr=2M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B1C2D0C0
	for <iommu@archiver.kernel.org>; Sun, 22 Dec 2019 07:01:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E3A2070A
	for <iommu@archiver.kernel.org>; Sun, 22 Dec 2019 07:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E3A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5009D1FB6B;
	Sun, 22 Dec 2019 07:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ies1x25U7cza; Sun, 22 Dec 2019 07:01:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 024D820130;
	Sun, 22 Dec 2019 07:01:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCE15C1D81;
	Sun, 22 Dec 2019 07:01:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4310C0881
 for <iommu@lists.linux-foundation.org>; Sun, 22 Dec 2019 07:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A38A985FAD
 for <iommu@lists.linux-foundation.org>; Sun, 22 Dec 2019 07:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxNby646ulKY for <iommu@lists.linux-foundation.org>;
 Sun, 22 Dec 2019 07:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2CBCD85F92
 for <iommu@lists.linux-foundation.org>; Sun, 22 Dec 2019 07:01:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Dec 2019 23:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,342,1571727600"; d="scan'208";a="416946691"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2019 23:01:33 -0800
Subject: Re: [PATCH v4 0/7] Use 1st-level for IOVA translation
From: Lu Baolu <baolu.lu@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191219031634.15168-1-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A13A364@SHSMSX104.ccr.corp.intel.com>
 <434d7478-1ed3-1962-ff9d-1b37d0c44b9c@linux.intel.com>
Message-ID: <46169833-6fae-d37e-89c3-c3abcdd31d79@linux.intel.com>
Date: Sun, 22 Dec 2019 15:00:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <434d7478-1ed3-1962-ff9d-1b37d0c44b9c@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>
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

Hi Yi,

On 12/21/19 11:14 AM, Lu Baolu wrote:
> Hi again,
> 
> On 2019/12/20 19:50, Liu, Yi L wrote:
>> 3) Per VT-d spec, FLPT has canonical requirement to the input
>> addresses. So I'd suggest to add some enhance regards to it.
>> Please refer to chapter 3.6:-).
>>
>> 3.6 First-Level Translation
>> First-level translation restricts the input-address to a canonical 
>> address (i.e., address bits 63:N have
>> the same value as address bit [N-1], where N is 48-bits with 4-level 
>> paging and 57-bits with 5-level
>> paging). Requests subject to first-level translation by remapping 
>> hardware are subject to canonical
>> address checking as a pre-condition for first-level translation, and a 
>> violation is treated as a
>> translation-fault.
> 
> It seems to be a conflict at bit 63. It should be the same as bit[N-1]
> according to the canonical address requirement; but it is also used as
> the XD control. Any thought?

Ignore this please. It makes no sense. :-) I confused.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
