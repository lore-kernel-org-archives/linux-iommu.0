Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC8DC54EEB
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 01:50:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FCF206F8
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FCF206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6493220472;
	Tue, 24 Mar 2020 01:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrouJnt0o2-1; Tue, 24 Mar 2020 01:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 034412041B;
	Tue, 24 Mar 2020 01:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1695C1AE2;
	Tue, 24 Mar 2020 01:50:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8185DC0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 01:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6FA8E8739D
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 01:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHO1p-6vdXM7 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 01:50:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B19458739A
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 01:50:35 +0000 (UTC)
IronPort-SDR: z5TTKX9AOT+wKXLXERxtJLbw924ElDJU1YZ1CHxnH91p4WNZJ7VlYZJojZWbaiFtN0/kOgTuHC
 6t3kMh/OhaaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 18:50:34 -0700
IronPort-SDR: hb5mjBhKyue57icqQi85DOjV/OBJFZdhWqWaHBv3XK63dQ41SilVLnhUr8KHWtkMvg1bvqVUOU
 wAVLSU3WTWJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="264978515"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.83])
 ([10.254.208.83])
 by orsmga002.jf.intel.com with ESMTP; 23 Mar 2020 18:50:29 -0700
Subject: Re: [PATCH V10 02/11] iommu/uapi: Define a mask for bind data
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <ae2a1a46-07ed-8445-d905-37dda1459e28@linux.intel.com>
 <20200323123726.64974d83@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c3a8337b-5e38-d883-5ea7-375ff9209acf@linux.intel.com>
Date: Tue, 24 Mar 2020 09:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323123726.64974d83@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On 2020/3/24 3:37, Jacob Pan wrote:
> On Sun, 22 Mar 2020 09:29:32 +0800> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> On 2020/3/21 7:27, Jacob Pan wrote:
>>> Memory type related flags can be grouped together for one simple
>>> check.
>>>
>>> ---
>>> v9 renamed from EMT to MTS since these are memory type support
>>> flags. ---
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    include/uapi/linux/iommu.h | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>>> index 4ad3496e5c43..d7bcbc5f79b0 100644
>>> --- a/include/uapi/linux/iommu.h
>>> +++ b/include/uapi/linux/iommu.h
>>> @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
>>>    	__u32 pat;
>>>    	__u32 emt;
>>>    };
>>> -
>>> +#define IOMMU_SVA_VTD_GPASID_MTS_MASK
>>> (IOMMU_SVA_VTD_GPASID_CD | \
>>> +					 IOMMU_SVA_VTD_GPASID_EMTE
>>> | \
>>> +					 IOMMU_SVA_VTD_GPASID_PCD
>>> |  \
>>> +
>>> IOMMU_SVA_VTD_GPASID_PWT)
>> As name implies, can this move to intel-iommu.h?
>>
> I also thought about this but the masks are in vendor specific part of
> the UAPI.
> 

I looked through this patch series. It looks good to me. I will do some
code style cleanup and take it to v5.7. I am not the right person to
decide whether include/uapi/linux/iommu.h is the right place for this,
so I will move it to Intel IOMMU driver for now.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
