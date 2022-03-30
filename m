Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ACAC433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 14:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23BF940D24;
	Wed, 30 Mar 2022 14:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3xadmWpFjOY; Wed, 30 Mar 2022 14:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CD7B404F6;
	Wed, 30 Mar 2022 14:21:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC72EC002C;
	Wed, 30 Mar 2022 14:21:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D4E6C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B9CE611EE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XofB7UFGsHFC for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 14:21:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 996D9610CB
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648650061; x=1680186061;
 h=message-id:date:mime-version:to:references:from:subject:
 in-reply-to:content-transfer-encoding;
 bh=FiqZAxLNLSA3q+0iMDyStSVs9TexPD0XlwioqNQSJ74=;
 b=HF9NUnv/cPq/qdIH6v/h8ty7J5E5A6Y2Ug3jtQcGX3OznoCyq/V52j31
 5Ix4LC6YKu6H5ALsxHLf+A9Ql1lS4870xmII4rgKshUsdZmQs13VCsWP7
 +SuqexX/vQLxUHMqJrbgLJwC9pOBBj43SpTqbPPPxVtmJSPPV/f/wstX/
 oPeunWpSWRCZaJuEKzEpoPVdy07IQhJyq8M2bMBY5h95VaI84m459GNSd
 0hOnM3WVywXAs7TZ/YgZpxxsIuR5nfDF7Er+CEGTbwuCtOLGqdoX04Gl2
 TVQVX07C8d2npA1qOjdbLPtl9Wt2glI4Ez9LkmJyz2vR+vFSGANsosXsg w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241709417"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="241709417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 07:20:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="586015679"
Received: from amahade1-mobl2.amr.corp.intel.com (HELO [10.209.45.250])
 ([10.209.45.250])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 07:20:44 -0700
Message-ID: <79bde999-cf8d-796b-1ddf-3cf612d28375@intel.com>
Date: Wed, 30 Mar 2022 07:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "hpa@zytor.com" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "joro@8bytes.org"
 <joro@8bytes.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Hegde, Vasant" <Vasant.Hegde@amd.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-2-alexander.deucher@amd.com>
 <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
 <BL1PR12MB5144C7172FCB8ED2C1AB013AF71F9@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD IOMMU
In-Reply-To: <BL1PR12MB5144C7172FCB8ED2C1AB013AF71F9@BL1PR12MB5144.namprd12.prod.outlook.com>
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

On 3/30/22 07:01, Deucher, Alexander wrote:
>> Just scanning this, it looks *awfully* generic.  Is anything in
>> here AMD- specific?  Should this be in an AMD-specific file?
> There is some information about the ACPI tables used to enumerate the
> IOMMUs and a link to the AMD IOMMU programming documentation.  Would
> you prefer I just create a combined x86 IOMMU document?

Yeah, I think that would make a lot of sense.  Let's just have one
document with an AMD section and an Intel section.  Maybe just rename
the existing one to intel-iommu => x86-iommu.rst.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
