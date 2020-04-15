Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B68C2BB85
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 08:51:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4462820784
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 08:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4462820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1704585F9A;
	Wed, 15 Apr 2020 08:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwdoF4toQV4C; Wed, 15 Apr 2020 08:51:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9E4785F90;
	Wed, 15 Apr 2020 08:51:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE177C1AE2;
	Wed, 15 Apr 2020 08:51:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6579C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 08:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB82386CC7
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 08:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbW5HE-yRO6J for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 08:51:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C44B586BA4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 08:51:20 +0000 (UTC)
IronPort-SDR: /Nmsx0s3NuW3B62MoaRWUHZZrK+avpAMRWtHN0cCf3BdH9R1Evfwz3YjDWwJ7FcY251E8e+8oj
 7zOBWWB0+qig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 01:51:20 -0700
IronPort-SDR: xd9uDqMgnkX0scbPhyGHWRupxBViiiK/x+vQT2bmXrZTKg+P4RFZwtcmu8IBNIJOiUdtPVSli7
 J1WvFa/VGang==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="244050165"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2020 01:51:20 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 01:51:20 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 01:51:19 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 16:51:10 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Topic: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Index: AQHWEubNcojyloGV5kG0IsggcRYC46h50o9A//+BuQCAAIvZAA==
Date: Wed, 15 Apr 2020 08:51:10 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D82066C@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-3-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D82055A@SHSMSX104.ccr.corp.intel.com>
 <85ee7356-dd36-e872-8196-ad44bbc1ad20@linux.intel.com>
In-Reply-To: <85ee7356-dd36-e872-8196-ad44bbc1ad20@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 15, 2020 4:30 PM
> 
> On 2020/4/15 16:18, Tian, Kevin wrote:
> >> From: Lu Baolu<baolu.lu@linux.intel.com>
> >> Sent: Wednesday, April 15, 2020 1:26 PM
> >>
> >> Extend qi_submit_sync() function to support multiple descriptors.
> >>
> >> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/dmar.c        | 39 +++++++++++++++++++++++--------------
> >>   include/linux/intel-iommu.h |  1 +
> >>   2 files changed, 25 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> >> index bb42177e2369..61d049e91f84 100644
> >> --- a/drivers/iommu/dmar.c
> >> +++ b/drivers/iommu/dmar.c
> >> @@ -1157,12 +1157,11 @@ static inline void reclaim_free_desc(struct
> >> q_inval *qi)
> >>   	}
> >>   }
> >>
> >> -static int qi_check_fault(struct intel_iommu *iommu, int index)
> >> +static int qi_check_fault(struct intel_iommu *iommu, int index, int
> >> wait_index)
> >>   {
> >>   	u32 fault;
> >>   	int head, tail;
> >>   	struct q_inval *qi = iommu->qi;
> >> -	int wait_index = (index + 1) % QI_LENGTH;
> >>   	int shift = qi_shift(iommu);
> >>
> >>   	if (qi->desc_status[wait_index] == QI_ABORT)
> >> @@ -1234,12 +1233,12 @@ static int qi_check_fault(struct intel_iommu
> >> *iommu, int index)
> >>   int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> >>   		   unsigned int count, unsigned long options)
> >>   {
> >> -	int rc;
> >>   	struct q_inval *qi = iommu->qi;
> >> -	int offset, shift, length;
> >>   	struct qi_desc wait_desc;
> >>   	int wait_index, index;
> >>   	unsigned long flags;
> >> +	int offset, shift;
> >> +	int rc, i;
> >>
> >>   	if (!qi)
> >>   		return 0;
> >> @@ -1248,32 +1247,41 @@ int qi_submit_sync(struct intel_iommu
> *iommu,
> >> struct qi_desc *desc,
> >>   	rc = 0;
> >>
> >>   	raw_spin_lock_irqsave(&qi->q_lock, flags);
> >> -	while (qi->free_cnt < 3) {
> >> +	/*
> >> +	 * Check if we have enough empty slots in the queue to submit,
> >> +	 * the calculation is based on:
> >> +	 * # of desc + 1 wait desc + 1 space between head and tail
> >> +	 */
> >> +	while (qi->free_cnt < count + 2) {
> >>   		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> >>   		cpu_relax();
> >>   		raw_spin_lock_irqsave(&qi->q_lock, flags);
> >>   	}
> >>
> >>   	index = qi->free_head;
> >> -	wait_index = (index + 1) % QI_LENGTH;
> >> +	wait_index = (index + count) % QI_LENGTH;
> >>   	shift = qi_shift(iommu);
> >> -	length = 1 << shift;
> >>
> >> -	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
> >> +	for (i = 0; i < count; i++) {
> >> +		offset = ((index + i) % QI_LENGTH) << shift;
> >> +		memcpy(qi->desc + offset, &desc[i], 1 << shift);
> >> +		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
> >> +	}
> > what about doing one memcpy and leave the loop only for updating
> > qi status?
> >
> 
> One memcpy might cross the table boundary.
> 

Thanks. you are right.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
