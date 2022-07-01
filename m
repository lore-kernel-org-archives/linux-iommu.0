Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F4BC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 01:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB1D360FAF;
	Fri,  1 Jul 2022 01:21:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB1D360FAF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jARrzZQF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xS3HFld5Jq0e; Fri,  1 Jul 2022 01:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77B4760F40;
	Fri,  1 Jul 2022 01:21:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77B4760F40
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53678C002D;
	Fri,  1 Jul 2022 01:21:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFD3BC0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 01:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B888C40943
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 01:21:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B888C40943
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jARrzZQF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1B8-IjseJtmF for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76EB540908
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76EB540908
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656638513; x=1688174513;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=H4ENz9j9WZZPAItQz3miCy+CRrDXsBwHO08vdhTePe4=;
 b=jARrzZQFDE1EFLNeVX+X47vf9M91N2h/dUyRw4I8OUe66qQO+yTcaYT1
 ptrJq0/cVRN1iaVGOdmgwfp4AvX+gez9ODp7lxAPFM1Em7bA8cH5nqpWI
 BEeDtCx3YITl9sj9wlqlX0uoRtAfc6hw/D5U84nK7vJXKMrQbKRgKW8fF
 7tbN1D7s3s8A958jgy/zkLyzugtwf7jtQHqEW4PNue8kNEjaCmtnqUgtQ
 2qzMw3vX6x4lWhG14tau7cyPmBQloPMjDRL4HbZ6bChkUblnRM4YOTlyV
 4L/dksfXE5fVXK9fO6RDOhhdnNVcAn177QZkVFBKkk+snvxL5QiRwWxew g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="281279859"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="281279859"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 18:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="589038477"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 18:21:49 -0700
Message-ID: <617e5bc8-aaef-c6b9-c50b-8fadb8ea8efb@linux.intel.com>
Date: Fri, 1 Jul 2022 09:17:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 2/6] iommu/vt-d: Use IDA interface to manage iommu
 sequence id
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271C0143C8EA440BDAF45828CBA9@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271C0143C8EA440BDAF45828CBA9@BL1PR11MB5271.namprd11.prod.outlook.com>
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

On 6/30/22 4:21 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, June 25, 2022 8:52 PM
>>
>> @@ -1062,11 +1040,14 @@ static int alloc_iommu(struct dmar_drhd_unit
>> *drhd)
>>   	if (!iommu)
>>   		return -ENOMEM;
>>
>> -	if (dmar_alloc_seq_id(iommu) < 0) {
>> +	iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
>> +					DMAR_UNITS_SUPPORTED,
> 
> should be "DMAR_UNITS_SUPPORTED - 1"

Yes, according to "@max: Highest ID to allocate.". Updated.

>> GFP_KERNEL);
>> +	if (iommu->seq_id < 0) {
>>   		pr_err("Failed to allocate seq_id\n");
>>   		err = -ENOSPC;
>>   		goto error;
>>   	}
> 
> ida_alloc_range() returns error code already. No need to change it.
> 

Agreed. Updated as below:

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index bf43889b9d2a..6327b34f5aa7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1041,10 +1041,10 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
                 return -ENOMEM;

         iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
-                                       DMAR_UNITS_SUPPORTED, GFP_KERNEL);
+                                       DMAR_UNITS_SUPPORTED - 1, 
GFP_KERNEL);
         if (iommu->seq_id < 0) {
                 pr_err("Failed to allocate seq_id\n");
-               err = -ENOSPC;
+               err = iommu->seq_id;
                 goto error;
         }
         sprintf(iommu->name, "dmar%d", iommu->seq_id);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
