Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2CCC433DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 13:41:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E81B20899
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 13:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E81B20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D76798A828;
	Thu,  2 Jul 2020 13:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fkU8nz83mo+C; Thu,  2 Jul 2020 13:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 557918A827;
	Thu,  2 Jul 2020 13:41:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A937C0888;
	Thu,  2 Jul 2020 13:41:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B02E9C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 13:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 97FAB89019
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 13:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dDGcH1EBJYqH for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 13:41:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 418B588F56
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 13:41:51 +0000 (UTC)
IronPort-SDR: hxACLdea+N6/YvmRG63MY73ZQcKE+ad3VrCA9JXL206R89Qxb++oQSplEqI6giV4sGtGQVcIyy
 oToflcdl8ivQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="134348606"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="134348606"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 06:41:50 -0700
IronPort-SDR: wFf9IowRhIrrxXAfe0HAhCgpuT7c0GGXXdivPPwUowrtH8FRJGqQIZ8lF2g+3RsvpWBjPH1JZU
 iii9fIyjMu4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="304250473"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 06:41:50 -0700
Date: Thu, 2 Jul 2020 06:48:25 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>
Subject: Re: IOASID set token
Message-ID: <20200702064825.20f9d2b1@jacob-builder>
In-Reply-To: <20200701232916.38fd7908@jacob-builder>
References: <20200701232916.38fd7908@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
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

Hi Jean,

Just realized I should send this to your Linaro account instead of ARM.
So Hi again :)

On Wed, 1 Jul 2020 23:29:16 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Hi Jean,
> 
> Have a question for you on whether we can have a fixed token type for
> ioasid_set.
> 
> Currently, ioasid_set has an arbitrary token. For VT-d vSVA usage, we
> choose mm as ioasid_set token to identify PASIDs within a guest. We
> have multiple in-kernel users of PASIDs such as VFIO, KVM, and VDCM.
> When an IOASID set is created, there is not a good way to communicate
> about the token choices. So we have to let VDCM and KVM *assume* mm
> is used as token, then retrieve ioasid_set based on the token.
> 
> This assumption of "mm as token" is not a reliable SW architecture. So
> we are thinking if we can have an explicit ioasid_set token type where
> mm is used. After all, PASID and mm are closely related.
> 
> The code change might be the following:
> 1. add a flag to indicate token type when ioasid_set is allocated,
> e.g. IOASID_SET_TYPE_MM
> IOASID_SET_TYPE_ANY
> 2. other users of the ioasid_set can query if an mm token exists based
> on the flag IOASID_SET_TYPE_MM, then retrieve the ioasid_set.
> 
> Existing ioasid_set user can still use arbitrary token under the flag
> IOASID_SET_TYPE_ANY
> 
> Would this be an issue for ARM usage?
> 
> Thanks,
> 
> Jacob

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
