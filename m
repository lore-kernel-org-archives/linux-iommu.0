Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A4C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 03:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E209F845E9;
	Thu, 23 Jun 2022 03:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E209F845E9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C37+zF4A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M81uPJ0Z8bmg; Thu, 23 Jun 2022 03:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A0112845BA;
	Thu, 23 Jun 2022 03:38:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0112845BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC9FC0032;
	Thu, 23 Jun 2022 03:38:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA80FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 03:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D06B40370
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 03:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D06B40370
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=C37+zF4A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DoD_48kszubw for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DCB140207
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DCB140207
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 03:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655955520; x=1687491520;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=U5JwulRGEY1I1BJUk8tkPc0NZfI5FzapZ/tvQYnIU7A=;
 b=C37+zF4AWZF7Mp4lI1ew9bTMTnefNaV2PEDOeUT+7AmWN0PRRGZWXWsH
 GasWWzj456FzYcuMbQ0ldZ3pBj6QeNIIe09y0WWzEZAM+ncm/ZrE4vCvb
 gkWdOcDf8w+OYywUqscJoifa57357suAZkKKg+H1/doYYgyhKycTJyPjN
 cSkIYmuYV+HbJl24CRz6q63Ml6ZMMisT30LHWcRV/e/D1VFr1EKpcKHg5
 lggqrMnxUaWwY9+JAm0aa/6v1ZIcH9eeepLUiRiRXL/uxvUXBX9fIVLFd
 Y5kwF18zNI2iVSe5kqaa5UPoDlNdpldaY2lpTkmovGbBUfaskHgmrzt4a w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280661668"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="280661668"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 20:38:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="644525123"
Received: from yutaoxu-mobl.ccr.corp.intel.com (HELO [10.249.172.190])
 ([10.249.172.190])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 20:38:36 -0700
Message-ID: <f3139dc1-2530-bb24-93ae-a74f895822c8@linux.intel.com>
Date: Thu, 23 Jun 2022 11:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
 <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
 <f0e4adc8-5d67-b76a-d0f1-2df83bd69a82@linux.intel.com>
 <20220623025126.ld45k72c2okodvvk@cantor>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220623025126.ld45k72c2okodvvk@cantor>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Russ Anderson <russ.anderson@hpe.com>,
 Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

On 2022/6/23 10:51, Jerry Snitselaar wrote:
>> The real problem here is that the iommu sequence ID overflows if
>> DMAR_UNITS_SUPPORTED is not big enough. This is purely a software
>> implementation issue, I am not sure whether user opt-in when building a
>> kernel package could help a lot here.
>>
> Is this something that could be figured out when parsing the dmar
> table? It looks like currently iommu_refcnt[], iommu_did[], and
> dmar_seq_ids[] depend on it.

That's definitely a better solution.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
