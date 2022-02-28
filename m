Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6906C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 20:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 478B1403A5;
	Mon, 28 Feb 2022 20:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l_P7egqyh1RN; Mon, 28 Feb 2022 20:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65A44402E1;
	Mon, 28 Feb 2022 20:58:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC2AC0033;
	Mon, 28 Feb 2022 20:58:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF19C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 20:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8027481BFA
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 20:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWZty-qVeZ7A for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 20:58:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9E8281D4F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 20:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646081902; x=1677617902;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=sLk7pBo2dA1yWf7ocqmDVD0lo8KHmAuZlGagbkLtpsM=;
 b=mJw3oOzouPDnlrIQ8yMgT4E1HAjlalTMvXmPQ5TsdYnKZZccIApzlCMv
 tDjhzECFCwYdpobI3WocdgnGMUYJhYyx0+H25ni6roQek7n3GmlhaQu3G
 jvDVXKsW7cB+LsJ6mWJSXQ+otLnrBK28K6Opa1tZai1j8MYA6AQE+dWsg
 7ZJno3ci9WSxHXl0L6mX3oUKvN79llhELjvmBb0Gomiwqt7wyvE2OqHOS
 s1SqeeHcFZA0MyPOG/1zxVgQ4SBGsvnyC2WWjS1Cca/f/a2Bdz3vj0vog
 93yggZluHCK7XMJKTVvUDZDC1j5k85g3lxQKhGH/NtS4sDbJIIT6i9Wab A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313706880"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="313706880"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 12:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="593357835"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2022 12:58:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 12:58:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 12:58:10 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Mon, 28 Feb 2022 12:58:10 -0800
From: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To: "Surendrakumar Upadhyay, TejaskumarX"
 <tejaskumarx.surendrakumar.upadhyay@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Topic: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Index: AQHYKICtFQkFA46yO0OFPY9iSTfQxqyit6oAgACFdoCAANRbAIAAxyUAgAEUC4CABBQ2AA==
Date: Mon, 28 Feb 2022 20:58:10 +0000
Message-ID: <8062e30a608f526fab4e63b71ea4a2e4ec3ec846.camel@intel.com>
References: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
 <2eb4e522d6294a6ade91b89ea1c5cc7c8dac1e51.camel@intel.com>
 <9a3d9767-e63b-0bcc-99a9-5e1cf9c31493@linux.intel.com>
 <f398077ff925fd8ed5697c777fa674157977dce6.camel@intel.com>
 <30755cb5-d366-6c24-3025-ce1d94e82a8d@linux.intel.com>
In-Reply-To: <30755cb5-d366-6c24-3025-ce1d94e82a8d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
x-originating-ip: [10.1.200.100]
Content-ID: <1B915075F7D81D4FB7289929B38D8F0B@intel.com>
MIME-Version: 1.0
Cc: "Talla, RavitejaX Goud" <ravitejax.goud.talla@intel.com>
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

On Sat, 2022-02-26 at 14:40 +0800, Lu Baolu wrote:
> On 2/25/22 10:12 PM, Vivi, Rodrigo wrote:
> > On Fri, 2022-02-25 at 10:20 +0800, Lu Baolu wrote:
> > > On 2/24/22 9:39 PM, Vivi, Rodrigo wrote:
> > > > On Thu, 2022-02-24 at 13:42 +0800, Lu Baolu wrote:
> > > > > On 2/23/22 2:29 PM, Tejas Upadhyay wrote:
> > > > > > The VT-d spec requires (10.4.4 Global Command Register, TE
> > > > > > field) that:
> > > > > > 
> > > > > > Hardware implementations supporting DMA draining must drain
> > > > > > any in-flight DMA read/write requests queued within the
> > > > > > Root-Complex before completing the translation enable
> > > > > > command and reflecting the status of the command through
> > > > > > the TES field in the Global Status register.
> > > > > > 
> > > > > > Unfortunately, some integrated graphic devices fail to do
> > > > > > so after some kind of power state transition. As the
> > > > > > result, the system might stuck in iommu_disable_translati
> > > > > > on(), waiting for the completion of TE transition.
> > > > > > 
> > > > > > This adds RPLS to a quirk list for those devices and skips
> > > > > > TE disabling if the qurik hits.
> > > > > > 
> > > > > > Fixes:https://gitlab.freedesktop.org/drm/intel/-
> > > > > > /issues/4898
> > > > > > Fixes: LCK-10789
> > > > > Remove this please.
> > > > good catch. Wrong use of Fixes tag.
> > > > "Fixes:" should only be used for patches fixing other patches
> > > > and
> > > > mentioning the commit id.
> > > This is still a fix patch, right? If so,
> > > 
> > > Fixes: b1012ca8dc4f9 "iommu/vt-d: Skip TE disabling on quirky gfx
> > > dedicated iommu"
> > > Cc:stable@vger.kernel.org
> > hm... you have a point, but I'm not comfortable with this because
> > for me it is like an addition of a pci id of a new platform.
> > Older kernels won't have the support for that anyway.
> > and if for every new platform we add here we need to blame this
> > b1012ca8dc4f9 (which did the right time when it was created)
> > it doesn't look fair to me.
> 
> I have no idea about the graphic roadmap. So I'd like you to decide
> it.

okay, so no Fixes or CC-stable it is.

> 
> > 
> > > > Baolu,
> > > > could you mind if we use
> > > > 
> > > > Closes:https://gitlab.freedesktop.org/drm/intel/-/issues/4898
> > > > 
> > > > or maybe
> > > > 
> > > > References:https://gitlab.freedesktop.org/drm/intel/-
> > > > /issues/4898
> > > > 
> > > > This last one seems to be the one use in drivers/iommu
> > > > and the Closes is what we use in drm-intel, hence the one used
> > > > with gitlab.freedesktop links in general.
> > > How about "Link:"?
> > > 
> > > As Documentation/process/submitting-patches.rst states:
> > > 
> > > If related discussions or any other background information behind
> > > the
> > > change
> > > can be found on the web, add 'Link:' tags pointing to it. In case
> > > your patch
> > > fixes a bug, for example, add a tag with a URL referencing the
> > > report
> > > in the
> > > mailing list archives or a bug tracker; if the patch is a result
> > > of
> > > some
> > > earlier mailing list discussion or something documented on the
> > > web,
> > > point to
> > > it.
> > yeap, "Link:" works well too.

Tejas, please change it to "Link:"

> > 
> > With these changes could we get your ack to merge to drm-intel?
> 
> This change in VT-d driver looks good to me.
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

and please resend to intel-gfx cc'ing the iommu mailing list.
no topic/core-for-CI prefix this time, just a clean submission so
we can get that and apply to drm-intel/drm-intel-next after
passing our CI.

Thank you all,
Rodrigo.



> 
> Best regards,
> baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
