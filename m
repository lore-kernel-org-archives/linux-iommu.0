Return-Path: <SRS0=gCe8=2L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF8C2D0C8
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 02:52:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C8420716
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 02:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C8420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DF1487440;
	Sat, 21 Dec 2019 02:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCYHXStTMoBI; Sat, 21 Dec 2019 02:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A90F87454;
	Sat, 21 Dec 2019 02:52:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4331CC1796;
	Sat, 21 Dec 2019 02:52:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 494B9C077D
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 02:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 337EC87E75
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 02:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aqs6J3xUlrjf for <iommu@lists.linux-foundation.org>;
 Sat, 21 Dec 2019 02:52:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 69AF287E5E
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 02:52:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 18:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; d="scan'208";a="228782618"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 18:52:34 -0800
Subject: Re: [PATCH v4 0/7] Use 1st-level for IOVA translation
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191219031634.15168-1-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A13A364@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ae36c46f-b16d-09a4-9edb-ded3a31332e6@linux.intel.com>
Date: Sat, 21 Dec 2019 10:51:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A13A364@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
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

Thanks for the comments.

On 12/20/19 7:50 PM, Liu, Yi L wrote:
> Hi Baolu,
> 
> In a brief, this version is pretty good to me. However, I still want
> to have the following checks to see if anything missed. Wish it
> helps.
> 
> 1) would using IOVA over FLPT default on?
> My opinion is that before we have got gIOVA nested translation
> done for passthru devices, we should make this feature as off.

No worry.

IOVA over first level is a sub-feature of scalable mode. Currently,
scalable mode is default off and we won't switch it on until all
features are done.

> 
> 2) the domain->agaw is somehow calculated according to the
> capabilities related to second level page table. As we are moving
> IOVA to FLPT, I'd suggest to calculate domain->agaw with the
> translation modes FLPT supports (e.g. 4 level and 5 level)

We merged first level and second level, hence the domain->agaw should be
selected for both. The only shortcoming of this is that it doesn't
support a 3-only second level in scalable mode. But I don't think we
have any chances to see such hardware.

> 
> 3) Per VT-d spec, FLPT has canonical requirement to the input
> addresses. So I'd suggest to add some enhance regards to it.
> Please refer to chapter 3.6 :-).

Yes. Good catch! We should manipulate the page table entry according to
this requirement.

> 
> 3.6 First-Level Translation
> First-level translation restricts the input-address to a canonical address (i.e., address bits 63:N have
> the same value as address bit [N-1], where N is 48-bits with 4-level paging and 57-bits with 5-level
> paging). Requests subject to first-level translation by remapping hardware are subject to canonical
> address checking as a pre-condition for first-level translation, and a violation is treated as a
> translation-fault.
> 
> Regards,
> Yi Liu

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
