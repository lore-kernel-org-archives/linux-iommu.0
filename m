Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2523C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 19:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36EFD4148A;
	Tue,  1 Feb 2022 19:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xByED45rJW5n; Tue,  1 Feb 2022 19:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B19641549;
	Tue,  1 Feb 2022 19:16:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7018C001A;
	Tue,  1 Feb 2022 19:16:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 447C5C000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 19:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BBEC40524
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 19:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NggZ8il6BKFv for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 19:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF8FE400C4
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643742986; x=1675278986;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LDmf2v3N2NhM2Hdh6gi3mwHkdkRYa0bVRdGcj6cVXnk=;
 b=U64jHR/fjKuCyHbi7u+vLGsreEBld8uu62MFWUrqCY0XMrD/rqqJBuk1
 xLFUhrqQzVsHmNsMJCMY8QFhSfiVj+y4cwfsJOv0UF5m83AxBBu33wTUZ
 N1GHUtr4JrPEEUZkOi6Tc18gsAzWjSCE7mN8UclqtBhW2XtL03GHhb/0I
 /uUWzGKXYAkxBCFYpZgnM3PaceRWQHSz/T6SlwzaLBAWwvX0Rl69ZRQuT
 DDTvUorAN139Gn37ZLQMwkH3Jy8r8YZreisZRs0q/2n+CQlvM7KM2n1vS
 ZqXuJ2LBNCAvzQiShDaA7X4ZHYkiLawyKJeTEefy0z8jOSz5JyCUbKk2S A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245361818"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; d="scan'208";a="245361818"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2022 11:16:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; d="scan'208";a="565696311"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2022 11:16:25 -0800
Date: Tue, 1 Feb 2022 11:19:18 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <20220201111918.48aadfdf@jacob-builder>
In-Reply-To: <YfgFqp+lR9wRdUWn@8bytes.org>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-2-baolu.lu@linux.intel.com>
 <YfZBlzYTN/RfCGnE@8bytes.org>
 <d9c35bb7-e6f5-a439-505b-5352c34f5621@arm.com>
 <YfgFqp+lR9wRdUWn@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Zhang@8bytes.org, iommu@lists.linux-foundation.org,
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

On Mon, 31 Jan 2022 16:52:10 +0100, Joerg Roedel <joro@8bytes.org> wrote:

> On Mon, Jan 31, 2022 at 01:53:06PM +0000, Robin Murphy wrote:
> > Indeed I very nearly asked whether we couldn't just call these from
> > intel_iommu_{probe,release}_device() directly, but it looks like they
> > also interact with the interrupt remapping stuff which can be built
> > independently of the IOMMU API :(  
> 
> Okay, but having two notifiers is still ugly. Can we only register a
> notifier when IRQ-remapping is used without IOMMU-API? In this case a
> single notifier be sufficient.
> 
Do you mean having an IRQ remapping notifier regardless IOMMU-API is
enabled, right?
It make sense, I will give it a try.

> Regards,
> 
> Joerg
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
