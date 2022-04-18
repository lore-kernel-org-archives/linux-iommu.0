Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D45C433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 11:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D867283F74;
	Mon, 18 Apr 2022 11:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAHc_lsZrRHJ; Mon, 18 Apr 2022 11:28:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ABE2D83F48;
	Mon, 18 Apr 2022 11:28:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823A7C002F;
	Mon, 18 Apr 2022 11:28:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E41BFC002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAED54176C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pnT2tCX7iI2o for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 11:28:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E713B409B4
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650281313; x=1681817313;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tNq4Qjm5TYIl9oCAWJApb6um0N6xU0LHIz6k7RGPfeQ=;
 b=DZavhnFToWcBroZSN2CPi/d1ZF4PYo0pZW3Llwq4MIx2W5hduqAoUgOr
 YiZZ8PRcpwNywQZp/Empq5nelY0qTJJyTaIxOqvOaOX9ewAAK4FrA6P1/
 HeeMK64tzOfeEFa8dMgc5InHgxfRwgbV3MmkRSxwul0B7+AKIEu9xkofy
 Bl2QdFaoJeQXd1eKmzJfaKBN28ddsMCTBQk5qIfHsjMJPQf99eoL1jZjB
 qGqs/E15Gae7muyMYNZnznAPN571KxsrQvRs0TJtqqXhja7eDoqU5QHTQ
 YuEydEwfpB3KD74LZvcUOOIqti3o3CrXZ7j+CFW3ykjuIxlcR+yh4/Kih Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="349949125"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="349949125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 04:28:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="575537747"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.231])
 ([10.254.208.231])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 04:28:30 -0700
Message-ID: <d051f1a3-3d26-15f9-f5b0-46bd903e73e0@linux.intel.com>
Date: Mon, 18 Apr 2022 19:28:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] iommu/vt-d: Set PGSNP bit in pasid table entry for
 sva binding
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A47E4013FA692C7560D58CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A47E4013FA692C7560D58CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/18 14:56, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 16, 2022 8:31 PM
>>
>> This field make the requests snoop processor caches irrespective of other
>> attributes in the request or other fields in paging structure entries
>> used to translate the request. The latest VT-d specification states that
>> this field is treated as Reserved(0) for implementations not supporting
>> Snoop Control (SC=0 in the Extended Capability Register). Hence add a
>> check in the code.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 2 +-
>>   drivers/iommu/intel/svm.c   | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..9ca3c67a2058 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -625,7 +625,7 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   		}
>>   	}
>>
>> -	if (flags & PASID_FLAG_PAGE_SNOOP)
>> +	if ((flags & PASID_FLAG_PAGE_SNOOP) && ecap_sc_support(iommu-
>>> ecap))
>>   		pasid_set_pgsnp(pte);
> If the caller wants snoop for some reason is it correct to simply
> ignore the request when lacking of hw support? Suppose certain
> errno should be returned here...

Good catch. Perhaps I should make the cap check in a separated patch.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
