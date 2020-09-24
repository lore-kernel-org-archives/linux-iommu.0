Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F01C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 17:21:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0462395C
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 17:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0462395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 782A887322;
	Thu, 24 Sep 2020 17:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MymeiXzMep8q; Thu, 24 Sep 2020 17:21:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 36E1687189;
	Thu, 24 Sep 2020 17:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C787C0890;
	Thu, 24 Sep 2020 17:21:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A486CC0859
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 17:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 931DD86ACD
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 17:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vim6T8pblUSm for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 17:21:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B343384FB1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 17:21:50 +0000 (UTC)
IronPort-SDR: rsk7rxZ+RuXwJRigR3nqo/vi9PpyJNT/hAyzaJOOtDSL9MAJNeTPQXovbcm+HwPnsH7QW7zULV
 Ei0jFQFO23qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="140715815"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="140715815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 10:21:49 -0700
IronPort-SDR: tMYX/mVOXmGiY6pmKp2B+akxpblK8msHE6I3qO//dQktL72HJqmVlFZ+Id4ZWD3G8AVJOWA8I6
 d7tvxr/t7IyQ==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="349358477"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 10:21:49 -0700
Date: Thu, 24 Sep 2020 10:21:48 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH V7 0/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20200924172148.GA85236@otc-nc-03>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,


On Mon, Sep 07, 2020 at 08:54:44PM -0700, Prakhya, Sai Praneeth wrote:
> Presently, the default domain of an iommu group is allocated during boot time
> and it cannot be changed later. So, the device would typically be either in
> identity (pass_through) mode or the device would be in DMA mode as long as the
> system is up and running. There is no way to change the default domain type
> dynamically i.e. after booting, a device cannot switch between identity mode and
> DMA mode.
> 
> Assume a use case wherein the privileged user would want to use the device in
> pass-through mode when the device is used for host so that it would be high
> performing. Presently, this is not supported. Hence add support to change the
> default domain of an iommu group dynamically.
> 
> Support this by writing to a sysfs file, namely
> "/sys/kernel/iommu_groups/<grp_id>/type".
> 
> Testing:
> --------
> Tested by dynamically changing storage device (nvme) from
> 1. identity mode to DMA and making sure file transfer works
> 2. DMA mode to identity mode and making sure file transfer works
> Tested only for intel_iommu/vt-d. Would appreciate if someone could test on AMD
> and ARM based machines.
> 

Just trying to followup on this series.

Sai has moved out of Intel, hence I'm trying to followup on his behalf.

Let me know if you have queued this for the next release.

> Based on iommu maintainer's 'next' branch.
> 
> Changes from V6:
> ----------------
> 1. None except for version bump.
> 

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
