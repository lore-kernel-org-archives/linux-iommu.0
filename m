Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1225BC433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 03:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ED7983E79;
	Tue, 21 Jun 2022 03:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8ED7983E79
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h7wV0R6B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcTxwUpwRRgf; Tue, 21 Jun 2022 03:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75201832B0;
	Tue, 21 Jun 2022 03:39:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75201832B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46006C0039;
	Tue, 21 Jun 2022 03:39:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32C25C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 03:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F305240482
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 03:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F305240482
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=h7wV0R6B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aebhIc8qS8Bu for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 03:39:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F7E140135
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F7E140135
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 03:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655782767; x=1687318767;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qVX3BzEHCS59pOvp34Vx2zJmoCdlA/L6qhq0aL8cy4M=;
 b=h7wV0R6BGIJXvVn1V9ExEWSAJEYN4syCBmEiZs8NN+/dd9IJTZtLNHrY
 5n3P1aGMTctO9zjzdS82qWH6q+ILeTDBpr2dK9IqrO3iGIsgqGyT9YM7j
 fW6WUbvB9CtHVir/wGGjz4+hR+tVDmVCcnjc2btqERIrZwadRGvMGdb3b
 3SGBx/A4jxNMbJ5M1MTjAj+nrKdldtSKRlajJK31eAJ5fq+zxwcpc+356
 15E788iL6q9hcEDI6XuRyEtM7FVFxludBv4Ft5R0nZOmPJbmd8lLySTXd
 6WvpcnE/zXV2QvXgKf2BouMrv5godGNl2P4PnLpw803GBXkGDfss3BsEH w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341702263"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="341702263"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 20:39:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="833381018"
Received: from zequnyu-mobl1.ccr.corp.intel.com (HELO [10.255.31.162])
 ([10.255.31.162])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 20:39:23 -0700
Message-ID: <5d13cab5-1f0a-51c7-78a3-fb5d3d793ab1@linux.intel.com>
Date: Tue, 21 Jun 2022 11:39:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F60972DF52EEF945D408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764F60972DF52EEF945D408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/6/21 10:54, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, June 20, 2022 4:17 PM
>> @@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct
>> dmar_domain *domain, struct device *dev)
>>   			ret = intel_pasid_setup_second_level(iommu,
>> domain,
>>   					dev, PASID_RID2PASID);
>>   		spin_unlock_irqrestore(&iommu->lock, flags);
>> -		if (ret) {
>> +		if (ret && ret != -EBUSY) {
>>   			dev_err(dev, "Setup RID2PASID failed\n");
>>   			dmar_remove_one_dev_info(dev);
>>   			return ret;
>> --
>> 2.25.1
> 
> It's cleaner to avoid this error at the first place, i.e. only do the
> setup when the first device is attached to the pasid table.

The logic that identifies the first device might introduce additional
unnecessary complexity. Devices that share a pasid table are rare. I
even prefer to give up sharing tables so that the code can be
simpler.:-)

--
Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
