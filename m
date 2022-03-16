Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0939C433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 22:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7046040893;
	Wed, 16 Mar 2022 22:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JsonujbfTudu; Wed, 16 Mar 2022 22:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62C2C40867;
	Wed, 16 Mar 2022 22:23:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CBDAC001A;
	Wed, 16 Mar 2022 22:23:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED19C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 22:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A9A340867
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 22:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17k6V5j5ozyg for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 22:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C762D404B6
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647469409; x=1679005409;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4l2wtAnqIaSrxTx4a8Iz1qlZB3MxdUypqpSLj9uN4UI=;
 b=dG9QCxYDCWzYt8VlxFUwACji0+tmUUImMp34pFJL8av/OoH9OeeXaPUO
 xpcBV7U7ZNYsyFxwDVMiPEX7ZLQfR2xpVcDG2f0YAjH0Yd0qFAONIktjW
 7HIzOmAmZgiJS7LeIMhKr5x3ZjuocWyYiZJ2//6iepU3x996wgFXwIzA9
 DPl/0rfuLI0Ymq8YNfPwxw0IycQawgTDD4y/Xv/bo+QLVu98q7MJ0PFI8
 85OjYdA0qnrtsnl8G07jovW6FcmD3NmDrKdqMw5E0cLRzEo9bAVrMYd6Z
 vc7rCn58ByLxy+B7HLmEt9C6EL49KQA3/5M/KolscT1EtmvlUaIqCNgot A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238889121"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="238889121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 15:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="498609298"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga003.jf.intel.com with ESMTP; 16 Mar 2022 15:23:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 15:23:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 15:23:27 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Wed, 16 Mar 2022 15:23:27 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoVItg7zFudxUWnMbj/fRutSKzA+EIAgACG8QCAAAf/gIABbKUAgAAX9gD//4u9gA==
Date: Wed, 16 Mar 2022 22:23:26 +0000
Message-ID: <17d73d88e08047f09636cf39edd69892@intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com> <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com> <20220316135004.61ae1611@jacob-builder>
 <20220316221550.GS11336@nvidia.com>
In-Reply-To: <20220316221550.GS11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

> I would expect real applications will try to use the same PASID for
> the same IOVA map to optimize IOTLB caching.

On Intel a ring3 application only gets to use one PASID.

The ENQCMD instruction pick up the PASID for the process
from the IA32_PASID MSR (set by OS when first access,
and on context switches thereafter).

Kernel users (ring0) can supply any PASID when they use
the ENQCMDS instruction. Is that what you mean when you
say "real applications"?

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
