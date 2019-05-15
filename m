Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2878BC04E87
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 13:07:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80D720881
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80D720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9FA782163;
	Wed, 15 May 2019 13:07:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B23A41F28
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 13:07:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 672B582C
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 13:07:05 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 685F330832EA;
	Wed, 15 May 2019 13:07:04 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A0A01995D;
	Wed, 15 May 2019 13:06:59 +0000 (UTC)
Subject: Re: [PATCH v7 04/23] iommu: Introduce attach/detach_pasid_table API
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu, joro@8bytes.org, alex.williamson@redhat.com, 
	jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, will.deacon@arm.com, 
	robin.murphy@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-5-eric.auger@redhat.com>
	<21bfdab4-846c-1dc7-6dff-62a46cc9c829@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b4c47851-0269-5aa2-682a-77677f756205@redhat.com>
Date: Wed, 15 May 2019 15:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <21bfdab4-846c-1dc7-6dff-62a46cc9c829@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 15 May 2019 13:07:04 +0000 (UTC)
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, christoffer.dall@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Jean-Philippe,

On 5/15/19 2:09 PM, Jean-Philippe Brucker wrote:
> On 08/04/2019 13:18, Eric Auger wrote:
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index edcc0dda7993..532a64075f23 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -112,4 +112,51 @@ struct iommu_fault {
>>  		struct iommu_fault_page_request prm;
>>  	};
>>  };
>> +
>> +/**
>> + * SMMUv3 Stream Table Entry stage 1 related information
>> + * The PASID table is referred to as the context descriptor (CD) table.
>> + *
>> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
>> +   or 2-level table)
> 
> Running "scripts/kernel-doc -v -none" on this header produces some
> warnings. Not sure if we want to get rid of all of them, but we should
> at least fix the coding style for this comment (line must start with
> " * "). I'm fixing it up on my sva/api branch
Thanks!

Let me know if you want me to do the job for additional fixes.

Eric


> 
> Thanks,
> Jean
> 
>> + * @s1dss: STE s1dss (specifies the behavior when pasid_bits != 0
>> +   and no pasid is passed along with the incoming transaction)
>> + * Please refer to the smmu 3.x spec (ARM IHI 0070A) for full details
>> + */
>> +struct iommu_pasid_smmuv3 {
>> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
>> +	__u32	version;
>> +	__u8 s1fmt;
>> +	__u8 s1dss;
>> +	__u8 padding[2];
>> +};
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
