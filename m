Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B98C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 05:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DD9B40871;
	Tue, 22 Mar 2022 05:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twyZgWtElMYU; Tue, 22 Mar 2022 05:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E078C415D5;
	Tue, 22 Mar 2022 05:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4BA7C0012;
	Tue, 22 Mar 2022 05:03:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54783C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F39E40A17
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 127XBdCrBF7c for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:03:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51DDF400B8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647925403; x=1679461403;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=9uqPM+FOjSZGcrtq3DsRrRPnxlYdv1cSjJxdC+pFnns=;
 b=atJSAirMyoThKBZDI78SAODTtPNIf0cNq7y/7iDFjE+PVB7pU1RRGHKO
 z8qv6xPefs1JMSYqaFC6IeSJV18sHB9EjEe7fZrZMWiZHauOFSMKl1aoP
 kTKK1qNyacgs3bEkXjonU7G/BO5tTv5LOu58cn2q9WsRJj+DwVblhsuI5
 pDElX66SBCb/HDWeRaB+Hej5rd+68hGek4/fGBHoGrFGW8iSLIKePoZCn
 ZEG3yFkMF+8gv7rqQM5Aqukttat1x8MGqqpuCMnW/Jb12rb4SGTprclVq
 k1kZH70It+YaxBl/Fj3H1MLOYMT4b0VbbEIZhOI28FEXqu/N4yThyCMXc Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344152576"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="344152576"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 22:03:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="518728164"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186])
 ([10.254.209.186])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 22:03:17 -0700
Message-ID: <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
Date: Tue, 22 Mar 2022 13:03:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica> <20220321124346.GP11336@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
In-Reply-To: <20220321124346.GP11336@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022/3/21 20:43, Jason Gunthorpe wrote:
> On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:
> 
>> I tend to disagree with that last part. The fault is caused by a specific
>> device accessing shared page tables. We should keep that device
>> information throughout the fault handling, so that we can report it to the
>> driver when things go wrong.
> SVA faults should never be reported to drivers??
> 

When things go wrong, the corresponding response code will be responded
to the device through iommu_page_response(). The hardware should then
report the failure to the device driver and the device driver will
handle it in the device-specific way. There's no need to propagate the
I/O page faults to the device driver in any case. Do I understand it
right?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
