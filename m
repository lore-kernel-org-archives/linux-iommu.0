Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75EBC433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 03:34:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630A120721
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 03:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630A120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27FFD87593;
	Thu, 28 May 2020 03:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lDdqtlRxETv7; Thu, 28 May 2020 03:34:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9E96C87590;
	Thu, 28 May 2020 03:34:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B1BC088D;
	Thu, 28 May 2020 03:34:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB74EC016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 03:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99EA387593
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 03:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MhO-I1bZ4z5h for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 03:34:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1F89F87590
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 03:34:19 +0000 (UTC)
IronPort-SDR: 0Wg1Tajh6ZTlYHlj9FkO9AHSz/x540Hj/hjnko8dHMN54D3id6iyio6TDOxUTE4nOXT3TdBRZu
 4YiS2F1+Z2dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 20:34:18 -0700
IronPort-SDR: SD9MOkMMNAmBJFscSXar70Qk2TI1Z1aJgdc0yPjnJCY4UkS4x9Tp6b5mnDiVPTwcaqrExSDgX/
 ItLYY7bqnV7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="345768164"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232])
 ([10.255.30.232])
 by orsmga001.jf.intel.com with ESMTP; 27 May 2020 20:34:15 -0700
Subject: Re: [PATCH v2 0/2] iommu: Remove iommu_sva_ops::mm_exit()
To: Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
References: <20200423125329.782066-1-jean-philippe@linaro.org>
 <20200527101038.GD265288@myrica> <20200527124240.GK5221@8bytes.org>
 <00f0597f-b235-b92e-ad41-a7ffcff9b59b@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <70869150-a830-6f9c-f8d0-ad9a25b7f1a6@linux.intel.com>
Date: Thu, 28 May 2020 11:34:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <00f0597f-b235-b92e-ad41-a7ffcff9b59b@linux.intel.com>
Content-Language: en-US
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jgg@ziepe.ca,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-accelerators@lists.ozlabs.org
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

Sorry for the typo.

On 2020/5/28 11:32, Lu Baolu wrote:
> Hi Jorge,
      ^^^^^
      Joerg


> 
> On 2020/5/27 20:42, Joerg Roedel wrote:
>> Hi Jean-Philippe,
>>
>> On Wed, May 27, 2020 at 12:10:38PM +0200, Jean-Philippe Brucker wrote:
>>> I was wondering if you could take these two patches for v5.8. The API
>>> change is a precursor for the SVA support in SMMUv3, and the VT-d
>>> implementation of the SVA API (queued for 5.8) doesn't implement
>>> iommu_sva_ops.
>>
>> I'd like some Acks on patch 2 (at least from the Intel people) before
>> going ahead with this.
>>
> 
> Patch 2 in this series looks good to me.
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> +Jacob, he participated in the discussions.
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
