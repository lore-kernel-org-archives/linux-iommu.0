Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1597C47082
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 02:17:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B3A61155
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 02:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B3A61155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28B7440345;
	Mon, 24 May 2021 02:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1a8RrOinII4S; Mon, 24 May 2021 02:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id BED504031B;
	Mon, 24 May 2021 02:17:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97C11C000E;
	Mon, 24 May 2021 02:17:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21C4EC0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 02:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 086A760679
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 02:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkQzFCmveO-9 for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:17:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2009A60659
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 02:17:19 +0000 (UTC)
IronPort-SDR: NcYu5iJHlic8FBbiIhCpLPWTV159x+8Rsikl694PSvHkZWKdPlE9Ym7sGA88HwKDvJZSlhUcZ6
 wN2Qm7ZvI9Gw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="199930970"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="199930970"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2021 19:17:19 -0700
IronPort-SDR: 7SMFPUlYsxODckSA8W+JRGKXO9N/ABdGUtRQD3O0Wc4Oxhqc7lfJOmlKS6L5fv/AwCN6tL7RvK
 GmrFqoa2dpwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="629456472"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 23 May 2021 19:17:16 -0700
Subject: Re: [PATCH 01/11] iommu/vt-d: Add pasid private data helpers
To: Jacob Pan <jacob.jun.pan@intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
 <20210520031531.712333-2-baolu.lu@linux.intel.com>
 <20210521142518.25087d34@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <15bdf989-40c9-2b45-0fb6-273a43479789@linux.intel.com>
Date: Mon, 24 May 2021 10:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521142518.25087d34@jacob-builder>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

Hi Jacob,

Thanks for reviewing my patch.

On 5/22/21 5:25 AM, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Thu, 20 May 2021 11:15:21 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>> We are about to use iommu_sva_alloc/free_pasid() helpers in iommu core.
>> That means the pasid life cycle will be managed by iommu core. Use a
>> local array to save the per pasid private data instead of attaching it
>> the real pasid.
>>
> I feel a little awkward to have a separate xarray for storing per IOASID
> data. Seems duplicated.
> Jason suggested in another thread that we can make ioasid_data public
> and embeded in struct intel_svm, then we can get rid of the private data
> pointer. ioasid_find will return the ioasid_data, then we can retrieve the
> private data with container_of.

The problem that this patch wants to solve is that the
iommu_sva_alloc_pasid() will attach the mm pointer to the sva pasid.

         pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);

Assuming that each sva pasid can have only a single private data
pointer, the vendor iommu driver shouldn't set the private data again.

> 
> roughly,
> 
> struct intel_svm {
> 	...
> 	struct ioasid_data;
> };
> 
> struct ioasid_data {
> 	ioasid_t id;
> 	refcount_t refs;
> 	struct mm_struct *mm;
> };
> 
> This can be a separate patch/effort if it make sense to you.

Yes if we have a better solution.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
