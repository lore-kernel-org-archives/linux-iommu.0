Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63ACC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 03:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FC7D60FB1;
	Fri,  1 Jul 2022 03:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FC7D60FB1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JuFE7dml
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zFcXOftgGmqs; Fri,  1 Jul 2022 03:17:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EFE560A87;
	Fri,  1 Jul 2022 03:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EFE560A87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4706C002D;
	Fri,  1 Jul 2022 03:17:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10FD9C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 03:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D80C960A8A
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 03:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D80C960A8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yxraetbQBdul for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 03:17:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEA0660A87
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEA0660A87
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 03:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656645447; x=1688181447;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=X7KG6YEkiVYtWl6cE7h9dCi+akN1ajBggBxEmd4Yg2I=;
 b=JuFE7dmljk/AIzWBzkxHw6ogrGqRzcClTVYV0BI3Colk0S5nSNPuAnah
 N3uUykKVo5qmihyGgToP69lTGFxVDoqwKROsffFmuHbc7wsUFICYZQTT2
 XohLshLvHW3EH3tDxpzxfJZrZAykI6PWYs1cIPvIUPHbP9pzKcyt1vQHG
 3VcYQk7IhNoTfv8xU5xUKSBZZ1C4Y3r9kP6kcLZ8iR6g5+heWEOGdui8w
 TjxgA1OOweYijpbb3O+eQ6oFTHyGV3jVC/twFXjHFZq8HwRzhHeuPFSiI
 hrLTa/vBKe8Tggk6wPwQbLekJyFyWvn1iWMlJ3/GSSBHptm4Iq5WI8eji g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262338688"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="262338688"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 20:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="589066578"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 20:17:24 -0700
Message-ID: <239cfd97-b381-f523-f149-e127f44a0780@linux.intel.com>
Date: Fri, 1 Jul 2022 11:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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

On 6/30/22 4:29 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, June 25, 2022 8:52 PM
>>
>> In the IOMMU hot-add path, there's a need to check whether an IOMMU
>> has been probed. Instead of checking the IOMMU pointer in the global
>> list, it's better to allocate a flag bit in iommu->flags for this
>> purpose.
> 
> Sorry I didn't get the point of original check. This is the hotplug path
> hence the caller of this function should already figure out it's a new
> iommu before reaching this point?
> 

Either did I. It was added by below commit without any comments about
this check.

commit ffebeb46dd34736c90ffbca1ccb0bef8f4827c44
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Sun Nov 9 22:48:02 2014 +0800

     iommu/vt-d: Enhance intel-iommu driver to support DMAR unit hotplug

     Implement required callback functions for intel-iommu driver
     to support DMAR unit hotplug.

     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
     Reviewed-by: Yijing Wang <wangyijing@huawei.com>
     Signed-off-by: Joerg Roedel <jroedel@suse.de>

I went through the whole hot-add process and found this check seemed to
be duplicate.

Hot-add process starts from dmar_device_hotplug(), it uses a rwlock to
synchronize the hot-add paths.

2386         down_write(&dmar_global_lock);
2387         if (insert)
2388                 ret = dmar_hotplug_insert(tmp);
2389         else
2390                 ret = dmar_hotplug_remove(tmp);
2391         up_write(&dmar_global_lock);

dmar_device_hotplug()
->dmar_hotplug_insert()
-->dmar_parse_one_drhd()   /* the added intel_iommu is allocated here*/
-->dmar_hp_add_drhd()	   /* the intel_iommu is about to bring up */
--->intel_iommu_add()

The duplicate check here:

         if (g_iommus[iommu->seq_id])
                 return 0;

All the iommu units are allocated and then initialized in the same
synchronized path. There is no need to check a duplicate initialization.

I would like to remove this check if no objection.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
