Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A19C43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 09:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CAEC41874;
	Fri,  1 Jul 2022 09:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CAEC41874
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WWk6sr7+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 53VAV6xJVcyq; Fri,  1 Jul 2022 09:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C61A341869;
	Fri,  1 Jul 2022 09:12:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C61A341869
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9898AC0035;
	Fri,  1 Jul 2022 09:12:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 215E8C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 09:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A0AC81272
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 09:12:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A0AC81272
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WWk6sr7+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FT_elMNrFLJc for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:12:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FE0080AB1
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FE0080AB1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656666750; x=1688202750;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/kNlVEyPH0w8WhI0mhYcgoRy3O47A7bOqC6yeIddZ5M=;
 b=WWk6sr7+/Hj1Dm1lFwXe+4Vnjwrs41oxnVSqcwdfPG3WgTpMeGSlXfQv
 wX3S1dMEXQKj/n3b40n/3eAio12B/jynJ3rYmtnHg2rTwW/BQggpc/HsR
 EPf/Vq+H2akuG32KJgRDeB7Cd3OuL8xoUB29Sl2Cofs+yNPE27F+nXXns
 Aep8MRHDbqD3OUFKTsFAedhsZz0NPGV78hrJ8ZfIdv1ji0/XIQwJABhUo
 1hM91kTSSjZueLzuSAbALH+7GpHtSLjfjEmhxxIyBm7fxt5ri3PCLqbkd
 uloxnkfKVrmNfR7ETeYO9jkLUIJI8pxaU+dKce+pgIdnYWjbhlQaHd0be g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271376372"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="271376372"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 02:12:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="659366507"
Received: from wenjuhe-mobl1.ccr.corp.intel.com (HELO [10.249.171.195])
 ([10.249.171.195])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 02:12:27 -0700
Message-ID: <94c67e49-4604-e296-fa1a-e1105d67c5fd@linux.intel.com>
Date: Fri, 1 Jul 2022 17:12:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 10/11] iommu/vt-d: Use device_domain_lock accurately
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/7/1 16:15, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 29, 2022 3:47 PM
>>
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>>   	list_for_each_entry(info, &domain->devices, link) {
>> -		if (!info->dev)
>> -			continue;
>> -
> 
> suppose you can replace all spin_lock_irqsave() with spin_lock()
> in patch5 instead of leaving some replacement to next patch.
> 

Make sense. I will update the series.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
