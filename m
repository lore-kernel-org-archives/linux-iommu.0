Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7DC43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 17:26:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D167920738
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 17:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D167920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8274822CCE;
	Tue,  8 Sep 2020 17:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zm4aAZYN6Ce1; Tue,  8 Sep 2020 17:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2F06A228CA;
	Tue,  8 Sep 2020 17:26:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D2EC0859;
	Tue,  8 Sep 2020 17:26:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED89AC0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 17:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E991A86360
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 17:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q-_5XL3PxI-r for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4BEF286308
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 17:26:21 +0000 (UTC)
IronPort-SDR: STwNlGkOUB/DLN/O6DLkFtMDvppWIgSJrUeddts0SHd6u0fpAqLUpUbhBEgFVdX/iiKenh9lH4
 88xokA0XEQpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="157457297"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="157457297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 10:26:20 -0700
IronPort-SDR: XiymhjNUA1MBAjkAHI/4ikr9z83cYu77SojUFMvyufTkRcu9uNb8QMvw1Jj8UWALKRYMbBrT86
 xs89kRFngFqw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; d="scan'208";a="505147359"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 10:26:20 -0700
Date: Tue, 8 Sep 2020 10:33:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v8 0/7] IOMMU user API enhancement
Message-ID: <20200908103330.569cdcce@jacob-builder>
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg, Alex, and all.

Just wondering if there are any more comments? We have discussed this
at LPC, there are other patches depending on this set.

Thanks,

Jacob

On Mon, 31 Aug 2020 11:24:53 -0700
Jacob Pan <jacob.pan.linux@gmail.com> wrote:

> IOMMU user API header was introduced to support nested DMA
> translation and related fault handling. The current UAPI data
> structures consist of three areas that cover the interactions between
> host kernel and guest:
>  - fault handling
>  - cache invalidation
>  - bind guest page tables, i.e. guest PASID
> 
> Future extensions are likely to support more architectures and vIOMMU
> features.
> 
> In the previous discussion, using user-filled data size and feature
> flags is made a preferred approach over a unified version number.
> https://lkml.org/lkml/2020/1/29/45
> 
> In addition to introduce argsz field to data structures, this
> patchset is also trying to document the UAPI design, usage, and
> extension rules. VT-d driver changes to utilize the new argsz field
> is included, VFIO usage is to follow.
> 
> This set is available at:
> https://github.com/jacobpan/linux.git vsva_v5.8_uapi_v8
> 
> Thanks,
> 
> Jacob
> 
> 
> Changelog:
> v8
> 	- Rebased to v5.9-rc2
> 	- Addressed review comments from Eric Auger
> 	  1. added a check for the unused vendor flags
> 	  2. commit message improvements
> v7
> 	- Added PASID data format enum for range checking
> 	- Tidy up based on reviews from Alex W.
> 	- Removed doc section for vIOMMU fault handling
> v6
> 	- Renamed all UAPI functions with iommu_uapi_ prefix
> 	- Replaced argsz maxsz checking with flag specific size checks
> 	- Documentation improvements based on suggestions by Eric
> Auger Replaced example code with a pointer to the actual code
> 	- Added more checks for illegal flags combinations
> 	- Added doc file to MAINTAINERS
> v5
> 	- Addjusted paddings in UAPI data to be 8 byte aligned
> 	- Do not clobber argsz in IOMMU core before passing on to
> vendor driver
> 	- Removed pr_warn_ for invalid UAPI data check, just return
> -EINVAL
> 	- Clarified VFIO responsibility in UAPI data handling
> 	- Use iommu_uapi prefix to differentiate APIs has in-kernel
> caller
> 	- Added comment for unchecked flags of invalidation
> granularity
> 	- Added example in doc to show vendor data checking
> 
> v4
> 	- Added checks of UAPI data for reserved fields, version, and
> flags.
> 	- Removed version check from vendor driver (vt-d)
> 	- Relaxed argsz check to match the UAPI struct size instead
> of variable union size
> 	- Updated documentation
> 
> v3:
> 	- Rewrote backward compatibility rule to support existing code
> 	  re-compiled with newer kernel UAPI header that runs on older
> 	  kernel. Based on review comment from Alex W.
> 	  https://lore.kernel.org/linux-iommu/20200611094741.6d118fa8@w520.home/
> 	- Take user pointer directly in UAPI functions. Perform argsz
> check and copy_from_user() in IOMMU driver. Eliminate the need for
> 	  VFIO or other upper layer to parse IOMMU data.
> 	- Create wrapper function for in-kernel users of UAPI
> functions v2:
> 	- Removed unified API version and helper
> 	- Introduced argsz for each UAPI data
> 	- Introduced UAPI doc
> 
> 
> Jacob Pan (7):
>   docs: IOMMU user API
>   iommu/uapi: Add argsz for user filled data
>   iommu/uapi: Introduce enum type for PASID data format
>   iommu/uapi: Use named union for user data
>   iommu/uapi: Rename uapi functions
>   iommu/uapi: Handle data and argsz filled by users
>   iommu/vt-d: Check UAPI data processed by IOMMU core
> 
>  Documentation/userspace-api/iommu.rst | 211
> ++++++++++++++++++++++++++++++++++
> MAINTAINERS                           |   1 +
> drivers/iommu/intel/iommu.c           |  25 ++--
> drivers/iommu/intel/svm.c             |  13 ++-
> drivers/iommu/iommu.c                 | 205
> +++++++++++++++++++++++++++++++--
> include/linux/iommu.h                 |  35 ++++--
> include/uapi/linux/iommu.h            |  25 ++-- 7 files changed, 470
> insertions(+), 45 deletions(-) create mode 100644
> Documentation/userspace-api/iommu.rst
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
