Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D63C433EF
	for <iommu@archiver.kernel.org>; Sun, 24 Apr 2022 04:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E631405A5;
	Sun, 24 Apr 2022 04:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kD4GAh4FUzKk; Sun, 24 Apr 2022 04:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87038400DD;
	Sun, 24 Apr 2022 04:37:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53320C0032;
	Sun, 24 Apr 2022 04:37:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD7D0C002D
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 04:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B59B160BF9
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 04:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCXsJq7D0Dsd for <iommu@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 04:37:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA4AF60B20
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 04:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650775069; x=1682311069;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HAFqm/cKTB4j4+tV4YQ9J7Ui8jD83jhADG6UUK2gF68=;
 b=HnNm54Wu6WbMVWUuDP6zqXGeGtE1uYtYtbca++3pjzHznqHIjNzJ8scC
 zWT4YOLf5tyrBhtXTgMbbhGfyrcmfYnMrv+U03qeB/QrwRMXAv+bDuRrz
 zYJiqmso2G8aj8pCe7R/iHcBEQLbVffXw+9wLd5t54Fo+unRcsmyMB8uL
 yqRDFciFzHH3YS0culgim44tY+eT8yHu7WMICUqEvjifpLkQ4+dPDdRkT
 7iQOsdZo/AqKIeahIG3FAG1MxjqEFJiUibxlGc7b44VZ+muqegKau0DSt
 8hxD6/BwnfWrIQgFfYvZ4R4KCu03fPWC95+dd9Ho630cryFDJ6p+gNz6b Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262589019"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="262589019"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 21:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="578658846"
Received: from yzhou56-mobl2.ccr.corp.intel.com (HELO [10.249.173.202])
 ([10.249.173.202])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 21:37:46 -0700
Message-ID: <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
Date: Sun, 24 Apr 2022 12:37:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
 <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 2022/4/24 11:37, Tian, Kevin wrote:
>>> This should be rebased on top of Jason's enforce coherency series
>>> instead of blindly setting it. No matter whether it's legacy mode
>>> where we set SNP in PTE or scalable mode where we set PGSNP
>>> in PASID entry for entire page table, the trigger point should be
>>> same i.e. when someone calls enforce_cache_coherency().
>> With Jason's enforce coherency series merged, we even don't need to set
>> PGSNP bit of a pasid entry for second level translation. 2nd level
>> always supports SNP in PTEs, so set PGSNP in pasid table entry is
>> unnecessary.
>>
> Yes, this sounds correct for 2nd-level.
> 
> but setting PGSNP of 1st level translation is also relevant to that
> change when talking about enforcing coherency in the guest. In
> this case PASID_FLAG_PAGE_SNOOP should be set also after
> enforce_cache_coherency() is called.

Yes. Agreed.

> Currently it's always set for unmanaged domain in
> domain_setup_first_level():
> 
> 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
> 		flags |= PASID_FLAG_PAGE_SNOOP;
> 
> Suppose we need a separate interface to update PGSNP after pasid
> entry is set up.

Currently enforcing coherency is only used in VFIO. In the VFIO use
case, it's safe to always set PGSNP when an UNMANAGED domain is attached
on the first level pasid translation. We could add support of updating
PGSNP after pasid entry setup once there's a real need.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
