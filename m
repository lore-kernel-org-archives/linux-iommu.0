Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07B7C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 12:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 487A081777;
	Tue, 28 Jun 2022 12:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 487A081777
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YTH0Q47b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58GuYPH_spdP; Tue, 28 Jun 2022 12:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1935E818C2;
	Tue, 28 Jun 2022 12:39:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1935E818C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0526C0039;
	Tue, 28 Jun 2022 12:39:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71FA0C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 12:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AF774179E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 12:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AF774179E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YTH0Q47b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4ELdG9cQ79E for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 12:39:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0072B416CA
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0072B416CA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656419949; x=1687955949;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xH+zDbWm9NnK+jA1wnqDI01ZjKwfPCHuUTs1IQUIh5U=;
 b=YTH0Q47bnCPfThkjfz3bFhyAWGyxYS2CRL8j8KTGyMLXPL1b4JGYsWZ6
 +kosx1x0CVVJr4EYIJQ9ubLdWPAr945/3oWWIQIxUieUkTaTrL5JDEJCx
 i4ezulyQsDSAPg5Pbt/GP8j/qI/wbwEKaT4RWWtuBK/HK/K8PbRk7lD3q
 +LJqIXUgvp3R1vlWF8x7ipJWFdcWQbdkSMJY/+2yjDmmIFQwyBS1e2BIm
 oYHGMhPWJ8s3X3v41RhoRFFjhIRVEiukY2FLqVmBKOOPzIDiI6B3BvQK+
 7Mun2bMhjAVTGO6UwiceTDgFuHKgIzlSadrbsr/simPHTdw310U19sjim Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279274696"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="279274696"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 05:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646897670"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 05:39:05 -0700
Message-ID: <e311ead5-776b-ad71-5ad9-98f9ab6e569a@linux.intel.com>
Date: Tue, 28 Jun 2022 20:39:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>
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

On 2022/6/25 20:51, Lu Baolu wrote:
> Hi folks,
> 
> This is a follow-up series of changes proposed by this patch:
> 
> https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/
> 
> It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
> the DMAR_UNITS_SUPPORTED to 1024.
> 
> Please help review and suggest.

This series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/vtd-next-for-v5.20

Best regards,
baolu

> 
> Best regards,
> baolu
> 
> Lu Baolu (6):
>    iommu/vt-d: Remove unused domain_get_iommu()
>    iommu/vt-d: Use IDA interface to manage iommu sequence id
>    iommu/vt-d: Refactor iommu information of each domain
>    iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
>    iommu/vt-d: Remove global g_iommus array
>    iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
> 
>   include/linux/dmar.h        |   6 +-
>   drivers/iommu/intel/iommu.h |  29 ++++--
>   drivers/iommu/intel/dmar.c  |  33 ++-----
>   drivers/iommu/intel/iommu.c | 188 ++++++++++++++----------------------
>   drivers/iommu/intel/pasid.c |   2 +-
>   drivers/iommu/intel/svm.c   |   2 +-
>   6 files changed, 103 insertions(+), 157 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
