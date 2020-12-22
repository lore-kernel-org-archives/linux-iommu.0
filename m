Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C24C433DB
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 18:15:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A333822510
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 18:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A333822510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4283885F93;
	Tue, 22 Dec 2020 18:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsQlhu0x7jSU; Tue, 22 Dec 2020 18:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7FFE85FA0;
	Tue, 22 Dec 2020 18:14:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4FD6C1825;
	Tue, 22 Dec 2020 18:14:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B246BC0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 18:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AC5418698E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 18:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PVh3ICHvfm4e for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 18:14:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB9CE8517C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 18:14:56 +0000 (UTC)
IronPort-SDR: rBU6Px1fQ5izShgjX+n/zNZP59qlUBCV0VLQ8g5A3NyKFQCdpAI50R96kDEKHmKcifYczZOoBV
 hk+misARFRWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="163626505"
X-IronPort-AV: E=Sophos;i="5.78,439,1599548400"; d="scan'208";a="163626505"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 10:14:56 -0800
IronPort-SDR: IT3jjR6wg7YLiRusbaq/JwX4lXhMmYaiM4SoyICECJYOxyEiHnivk9V+JJg+JeZQ9LyxBirzoW
 CS8i/JcSn/rg==
X-IronPort-AV: E=Sophos;i="5.78,439,1599548400"; d="scan'208";a="373496961"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 10:14:56 -0800
Date: Tue, 22 Dec 2020 10:17:02 -0800
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/4] iommu/vtd-: Misc fixes on scalable mode
Message-ID: <20201222101702.0e236af8@jacob-builder>
In-Reply-To: <20201220000352.183523-1-yi.l.liu@intel.com>
References: <20201220000352.183523-1-yi.l.liu@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, Kaijie.Guo@intel.com, ashok.raj@intel.com,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, will@kernel.org,
 jun.j.tian@intel.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Yi,

nit: The cover letter is 0/4, patches are 1/3 - 3/3. You also need to copy
LKML.

On Sun, 20 Dec 2020 08:03:49 +0800, Liu Yi L <yi.l.liu@intel.com> wrote:

> Hi,
> 
> This patchset aims to fix a bug regards to SVM usage on native, and
perhaps 'native SVM usage'
> also several bugs around subdevice (attached to device via auxiliary
> manner) tracking and ineffective device_tlb flush.
> 
> Regards,
> Yi Liu
> 
> Liu Yi L (3):
>   iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
>     intel_svm_dev
>   iommu/vt-d: Track device aux-attach with subdevice_domain_info.
>   iommu/vt-d: A fix to iommu_flush_dev_iotlb() for aux-domain
> 
>  drivers/iommu/intel/iommu.c | 182 ++++++++++++++++++++++++++++++------
>  drivers/iommu/intel/svm.c   |   9 +-
>  include/linux/intel-iommu.h |  13 ++-
>  3 files changed, 168 insertions(+), 36 deletions(-)
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
