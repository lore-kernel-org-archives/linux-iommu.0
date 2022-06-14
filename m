Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B751DC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 07:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5004241547;
	Tue, 14 Jun 2022 07:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zyy1iyozeEgQ; Tue, 14 Jun 2022 07:21:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0187B41551;
	Tue, 14 Jun 2022 07:21:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7876C0032;
	Tue, 14 Jun 2022 07:21:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE78C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C64640610
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMej3zRXJU6i for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 07:21:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7F46400BB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655191288; x=1686727288;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aT/jlo7bPBLI1E41rFd9cS9uKHWKQcFzJa6LdgUzabY=;
 b=SYhDVbbKtNpx+0PSNWFN4PG8s51AKDVMVDTZrdtIgapm8LF6vXlQEvHu
 R7DDgHtnUhjLrUnk5p9DG3ieOnQH2xxEbtADg5qvfQCU72U7TBfzBSH7+
 zZNwnBBcK+UpWJrDGBoD3Lp1DDwZggd/sad+J5zvIUV/Y3ZgYiVruQeY/
 DJ9yztF19hv6ya4FVRsrQTwvdoI6EW6xAO+Hq306hgZTFsIO/ZZMPOLIu
 o86M10F5VDuMNo5yh3QRHhO4/xq4wacjUuSorMFA8GWZUtDGIr1FbPcuo
 FPkVeJF4R9ls10q6jQqHCUiVyqiX7YutGnw+ZEJYLbort9gjn663pY7U3 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258984596"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="258984596"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:21:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910836980"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:21:25 -0700
Message-ID: <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
Date: Tue, 14 Jun 2022 15:21:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/6/14 14:49, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:51 AM
>>
>> The disable_dmar_iommu() is called when IOMMU initialization fails or
>> the IOMMU is hot-removed from the system. In both cases, there is no
>> need to clear the IOMMU translation data structures for devices.
>>
>> On the initialization path, the device probing only happens after the
>> IOMMU is initialized successfully, hence there're no translation data
>> structures.
> Out of curiosity. With kexec the IOMMU may contain stale mappings
> from the old kernel. Then is it meaningful to disable IOMMU after the
> new kernel fails to initialize it properly?

For kexec kernel, if the IOMMU is detected to be pre-enabled, the IOMMU
driver will try to copy tables from the old kernel. If copying table
fails, the IOMMU driver will disable IOMMU and do the normal
initialization.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
