Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A9DCCA473
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 13:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7C9340BAC;
	Wed, 15 Jun 2022 13:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q_XE5_SZOdXY; Wed, 15 Jun 2022 13:10:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0146540178;
	Wed, 15 Jun 2022 13:10:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B93C5C0039;
	Wed, 15 Jun 2022 13:10:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71B2CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6838441962
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPDglSDZkSNv for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 13:10:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C282B41960
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655298625; x=1686834625;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=49iVnIBH2iZUFVwoFe1umaO203mLoJXO8qFijdhPPbM=;
 b=WTxXP8pohFb5jV+44aOGOMplOZV8wkvbkL9vwdP4Rreaxml7mK2xWfD4
 Cx1KRJeL656PsE482BO1u/gkliweLJl73vqNJ7pyVbjzhqFedKi5XoGOz
 mMRHozIr0w1SVUGqUd9Z/KCWMGwN4vTnyLWDmnD/t78bAVZA6kw+pM9gS
 7cZWcMOQ7fk4ImysbB8uTKevGmF3FUBDFo4zbFA1YULnUdRS/nd+PxJFG
 /IUuKhGizJ1AW23f4ZkVYVjaxoqJ+MvRhGs6UYqL9Ynn7yoJPNxftdGH0
 tuKdsEG+9H7k2osOhY5j4Y+a12iB4MNUEapKqLm4X7zDv+N2fGyeounIw A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277747074"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="277747074"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 06:10:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="589105904"
Received: from leitan-mobl.ccr.corp.intel.com (HELO [10.255.31.142])
 ([10.255.31.142])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 06:10:21 -0700
Message-ID: <b11b7cca-9e39-ac60-57a9-4e7049579221@linux.intel.com>
Date: Wed, 15 Jun 2022 21:10:19 +0800
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
 <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
 <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/6/15 14:22, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 3:21 PM
>>
>> On 2022/6/14 14:49, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 14, 2022 10:51 AM
>>>>
>>>> The disable_dmar_iommu() is called when IOMMU initialization fails or
>>>> the IOMMU is hot-removed from the system. In both cases, there is no
>>>> need to clear the IOMMU translation data structures for devices.
>>>>
>>>> On the initialization path, the device probing only happens after the
>>>> IOMMU is initialized successfully, hence there're no translation data
>>>> structures.
>>> Out of curiosity. With kexec the IOMMU may contain stale mappings
>>> from the old kernel. Then is it meaningful to disable IOMMU after the
>>> new kernel fails to initialize it properly?
>>
>> For kexec kernel, if the IOMMU is detected to be pre-enabled, the IOMMU
>> driver will try to copy tables from the old kernel. If copying table
>> fails, the IOMMU driver will disable IOMMU and do the normal
>> initialization.
>>
> 
> What about an error occurred after copying table in the initialization
> path? The new kernel will be in a state assuming iommu is disabled
> but it is still enabled using an old mapping for certain devices...
>   

If copying table failed, the translation will be disabled and a clean
root table will be used.

if (translation_pre_enabled(iommu)) {
         pr_info("Translation already enabled - trying to copy 
translation structures\n");

         ret = copy_translation_tables(iommu);
         if (ret) {
                 /*
                  * We found the IOMMU with translation
                  * enabled - but failed to copy over the
                  * old root-entry table. Try to proceed
                  * by disabling translation now and
                  * allocating a clean root-entry table.
                  * This might cause DMAR faults, but
                  * probably the dump will still succeed.
                  */
                 pr_err("Failed to copy translation tables from previous 
kernel for %s\n",
                        iommu->name);
                 iommu_disable_translation(iommu);
                 clear_translation_pre_enabled(iommu);
         } else {
                 pr_info("Copied translation tables from previous kernel 
for %s\n",
                         iommu->name);
         }
}

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
