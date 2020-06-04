Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EECC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 00:17:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EA7207D0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 00:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EA7207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 39E788812F;
	Thu,  4 Jun 2020 00:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofk410hFpJsw; Thu,  4 Jun 2020 00:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A19FF8812B;
	Thu,  4 Jun 2020 00:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71462C0178;
	Thu,  4 Jun 2020 00:17:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA0BC016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 00:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 42D1086DC9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 00:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PoXAGA77QvlB for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 00:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2518C86DC6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 00:17:04 +0000 (UTC)
IronPort-SDR: Eb6FKq7K6PR9dRwChd72kk8eq3RH0pB+9KVX5G+JkYw28wdFd+1qb8l7MmveCpsHDYkknSm41b
 8F0XiWv3CKaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 17:17:03 -0700
IronPort-SDR: sPBO2MhJa/2O5WbvWn1JQCmgd3+rjkI/Y5faZkoSCUZXYwyxGD01/SMaTFrDfd3dXrYc1xhz1g
 +NSZ/hoIN89Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; d="scan'208";a="294150329"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2020 17:17:01 -0700
Subject: Re: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own
 subdirectory
To: Joerg Roedel <joro@8bytes.org>
References: <20200602092616.24638-1-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <148834f4-849e-acf1-c347-e25093aac518@linux.intel.com>
Date: Thu, 4 Jun 2020 08:13:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602092616.24638-1-joro@8bytes.org>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

Hi Joerg,

On 6/2/20 5:26 PM, Joerg Roedel wrote:
> Hi,
> 
> two small patches to move the Intel and AMD IOMMU drivers into their own
> subdirectory under drivers/iommu/ to make the file structure a bit less
> cluttered.
> 

Does the MAINTAINERS file need to update?

Best regards,
baolu

> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (2):
>    iommu/amd: Move AMD IOMMU driver into subdirectory
>    iommu/vt-d: Move Intel IOMMU driver into subdirectory
> 
>   drivers/iommu/Makefile                         | 18 +++++++++---------
>   drivers/iommu/{ => amd}/amd_iommu.h            |  0
>   drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
>   .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
>   drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
>   drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
>   .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
>   .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
>   .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
>   drivers/iommu/{ => intel}/dmar.c               |  2 +-
>   drivers/iommu/{ => intel}/intel-pasid.h        |  0
>   drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
>   .../irq_remapping.c}                           |  2 +-
>   drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
>   drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
>   drivers/iommu/{intel-trace.c => intel/trace.c} |  0
>   16 files changed, 14 insertions(+), 14 deletions(-)
>   rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
>   rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
>   rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
>   rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
>   rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
>   rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
>   rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
>   rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
>   rename drivers/iommu/{ => intel}/dmar.c (99%)
>   rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
>   rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
>   rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
>   rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
>   rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
>   rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
