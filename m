Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E76C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 21:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58FD9415F9;
	Wed,  9 Feb 2022 21:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBl0FnelTptt; Wed,  9 Feb 2022 21:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3CAB7415EA;
	Wed,  9 Feb 2022 21:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BAA0C0011;
	Wed,  9 Feb 2022 21:49:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 089A3C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 21:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC67160BE7
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 21:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWBSmsCeYy7n for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 21:49:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D8F960A4F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 21:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644443393; x=1675979393;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Tt0ZeSfHsh3LzybVc8zC/vABOyQkdzmIGTNOnVlCgk=;
 b=C6uCUATZ4ooWzQQLNSNZMy/CmwWIoGg9qldukqVm9P9JlRsLXXm2q0Z7
 ucNDkXio8hSnrpVm3gCG0Tgb91f27sKM776qkveZ0gsh1cYUrrOfySQ/B
 zQTzXTuFWXZFch8FHpimZPv9uZJxJLkitPn+YMN19dlCV++oeV4cFgFFq
 1Fl5gNeAOViZHmzLUkfVODkV+kA4c7Rrz/Q5exjpud573kmdkq5lhYEQb
 1VQ1crtS+IQ4boRHzIi9UkcReCKqRMGMkkHykPWUGJZMhpAQChIUJOD21
 +r1gNqoeMPrOQOUmr7lf7t4hPBTAeQ6PdmaAqr6aduvlL7m5d6OA8RV98 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249556720"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; d="scan'208";a="249556720"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 13:49:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; d="scan'208";a="568408820"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 13:49:52 -0800
Date: Wed, 9 Feb 2022 13:52:49 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <20220209135249.690b8a08@jacob-builder>
In-Reply-To: <20220203082150.qjsssis6ygh34yen@8bytes.org>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-2-baolu.lu@linux.intel.com>
 <YfZBlzYTN/RfCGnE@8bytes.org>
 <d9c35bb7-e6f5-a439-505b-5352c34f5621@arm.com>
 <YfgFqp+lR9wRdUWn@8bytes.org>
 <20220201111918.48aadfdf@jacob-builder>
 <20220203082150.qjsssis6ygh34yen@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, iommu@lists.linux-foundation.org,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Bernice <bernice.zhang@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 3 Feb 2022 09:25:58 +0100, Joerg Roedel <joro@8bytes.org> wrote:

> On Tue, Feb 01, 2022 at 11:19:18AM -0800, Jacob Pan wrote:
> > Do you mean having an IRQ remapping notifier regardless IOMMU-API is
> > enabled, right?
> > It make sense, I will give it a try.  
> 
> Yeah, that would be best. I really don't like to use two notifiers just
> to work around ordering issues.
> 
Another option Ashok and I discussed is that we can make DMAR cache persist
(which should be for explicitly listed devices in each DRHD) across PCI
remove-rescan cycle, then we don't need the DMAR PCI bus notifier at all.

This bug only impacts RCIEP device hotplug, which is not the most reasonable
use case, we have the space to look into a proper fix.

> Regards,
> 
> 	Joerg


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
