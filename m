Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDCEC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 13:23:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BE964D9F
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 13:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BE964D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0593C87100;
	Thu,  4 Feb 2021 13:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnRlkT8isSqp; Thu,  4 Feb 2021 13:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54D2686CAC;
	Thu,  4 Feb 2021 13:23:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33381C07FD;
	Thu,  4 Feb 2021 13:23:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B3C9C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 13:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 17ACB87100
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 13:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfWZDHkVtNUs for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 13:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BDAFF86CAC
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 13:22:56 +0000 (UTC)
IronPort-SDR: d90Kt5H4XGc4kdD+TYailSYAD70E5L35YsPcMhOxtM7E/PP63ynT8E6jcHf/Lc2lLBMg0yI7o4
 xth5px72dKxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168352504"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; d="scan'208";a="168352504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 05:22:56 -0800
IronPort-SDR: a47xo9b31R3FLVNucSjlh/sN3LbSlBGDYTa8LHuvBSCf/agDgcXtOXZMHKsoMb7MtFaZRahtAE
 QjA42NzipnGQ==
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; d="scan'208";a="393165401"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.206])
 ([10.254.214.206])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 05:22:50 -0800
Subject: Re: [PATCH 11/12] platform-msi: Add platform check for subdevice irq
 domain
To: Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>
References: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
 <1612385805-3412-12-git-send-email-megha.dey@intel.com>
 <20210204121431.GH4247@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3082871a-32d7-8472-bd66-eae535ef2c3e@linux.intel.com>
Date: Thu, 4 Feb 2021 21:22:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204121431.GH4247@nvidia.com>
Content-Language: en-US
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, maz@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de,
 Leon Romanovsky <leon@kernel.org>, dan.j.williams@intel.com, dwmw@amazon.co.uk
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

Hi Jason,

On 2021/2/4 20:14, Jason Gunthorpe wrote:
> On Wed, Feb 03, 2021 at 12:56:44PM -0800, Megha Dey wrote:
>> +bool arch_support_pci_device_ims(struct pci_dev *pdev)
>> +{
> 
> Consistent language please, we are not using IMS elsewhere, this
> feature is called device_msi in Linux.
> 

Thanks for pointing this out. I will correct it.

> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
