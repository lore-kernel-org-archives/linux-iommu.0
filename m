Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA3FC433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 11:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F75A40911;
	Wed,  9 Feb 2022 11:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id poka3zonAeiQ; Wed,  9 Feb 2022 11:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6E77400A4;
	Wed,  9 Feb 2022 11:58:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD852C001A;
	Wed,  9 Feb 2022 11:58:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72BA4C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 11:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6133760A71
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 11:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IS80vb7acZSX for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 11:57:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB38F60670
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644407878; x=1675943878;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8IZ/Rh6FmqlwMDzbGpDcbVjCxbVIT0IalMt8i72Hz/I=;
 b=BTgaeIOOTFto4x3JzE+a4Tsz/PU/e57Rks2o0R+jaSOKSnv9uXXmqs9v
 lIAWTnKVd/gKrm0INn1NkirmpXEdX5RSG0Y8Q1hiJnmM3m8/MHoHrh0tf
 89PsrrAUUrgf5ulEcggxzG/4NE03KV1zW7/VcVPXT+qCorRUtftOTwbyd
 UsM35k+fId0HeESetrumvjdEEth2Lfem5YSM8bXpLmQQRWPj8ctPQhQ/O
 joQWhvCwG2QLtT9gkr0npfoDAEW0ykBclozmlDAxqzuw+OJTh9Z0JXfYf
 nImsT+pbi2xXuSxG+b98PG/Fcga2V/zZ5kLR/ev4+ND9DPTj8/l+YJ6m7 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236593661"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; d="scan'208";a="236593661"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 03:57:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; d="scan'208";a="541062729"
Received: from smile.fi.intel.com ([10.237.72.61])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 03:57:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1nHlaj-002bKV-N1; Wed, 09 Feb 2022 13:56:57 +0200
Date: Wed, 9 Feb 2022 13:56:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <YgOsCS/gbfCppMY7@smile.fi.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
> Compiler is not happy about hidden declaration of intel_iommu_ops.
> 
> .../iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
> 
> Move declaration to header file to make compiler happy.

Note, with this change we are closer to have a clean build with the
CONFIG_WERROR=y when `make W=1`.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
