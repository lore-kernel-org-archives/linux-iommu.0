Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87619C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 18:38:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DF1207C4
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 18:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DF1207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3105D84499;
	Mon, 28 Sep 2020 18:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rvlzzlof-pTz; Mon, 28 Sep 2020 18:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C586842FF;
	Mon, 28 Sep 2020 18:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C0F5C0889;
	Mon, 28 Sep 2020 18:38:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D785C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 18:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 453C2843E9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 18:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5HR7mjRw565p for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 18:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E86E3842FF
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 18:38:47 +0000 (UTC)
IronPort-SDR: wuarhkyrIJVCJ96Ms7oXMRnO10HRZdV7OYKUrwHGxOIyfgi6QK9anCytzlqP4iJRTGJjZn2SSV
 TcUIKaubWdXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="246784286"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="246784286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 11:38:46 -0700
IronPort-SDR: JExQWT9GytmoqUJjWWfoYiFWm2ROgswGk82oXhpKsrogI/lX+XzPT5+ZNvBpVwls4DrM/WjH9G
 3eMVhQSaIUzg==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="311889478"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 11:38:45 -0700
Date: Mon, 28 Sep 2020 11:40:53 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v12 0/6] IOMMU user API enhancement
Message-ID: <20200928114053.79170d23@jacob-builder>
In-Reply-To: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

Hi Joerg,

Just wondering if you will be able to take this for v5.10? There hasn't
been any material changes since we last discussed in LPC. We have VFIO and
other vSVA patches depending on it.

Thanks!

Jacob 

On Fri, 25 Sep 2020 09:32:41 -0700, Jacob Pan <jacob.pan.linux@gmail.com>
wrote:

> IOMMU user API header was introduced to support nested DMA translation and
> related fault handling. The current UAPI data structures consist of three
> areas that cover the interactions between host kernel and guest:
>  - fault handling
>  - cache invalidation
>  - bind guest page tables, i.e. guest PASID
> 
> Future extensions are likely to support more architectures and vIOMMU
> features.
> 
> In the previous discussion, using user-filled data size and feature flags
> is made a preferred approach over a unified version number.
> https://lkml.org/lkml/2020/1/29/45
> 
> In addition to introduce argsz field to data structures, this patchset is
> also trying to document the UAPI design, usage, and extension rules. VT-d
> driver changes to utilize the new argsz field is included, VFIO usage is
> to follow.
> 
> This set is available at:
> https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v12
> 
> Thanks,
> 
> Jacob
> 
> 
> Changelog:
> v12
> 	- Removed a redundant check in cache invalidate API
> v11
> 	- Use #define instead of enum in PASID data format, squashed
> change into "iommu/uapi: Handle data and argsz filled by users"
> 	- Remove alloc/free from documentation per Yi's comment. IOMMU
> UAPI does not perform IOASID alloc/free.
> v10
> 	- Documentation grammar fixes based on Randy's review
> v9
> 	- Directly pass PASID value to iommu_sva_unbind_gpasid() without
> 	  the superfluous data in struct iommu_gpasid_bind_data.
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
> 	- Documentation improvements based on suggestions by Eric Auger
> 	  Replaced example code with a pointer to the actual code
> 	- Added more checks for illegal flags combinations
> 	- Added doc file to MAINTAINERS
> v5
> 	- Addjusted paddings in UAPI data to be 8 byte aligned
> 	- Do not clobber argsz in IOMMU core before passing on to vendor
> driver
> 	- Removed pr_warn_ for invalid UAPI data check, just return
> -EINVAL
> 	- Clarified VFIO responsibility in UAPI data handling
> 	- Use iommu_uapi prefix to differentiate APIs has in-kernel caller
> 	- Added comment for unchecked flags of invalidation granularity
> 	- Added example in doc to show vendor data checking
> 
> v4
> 	- Added checks of UAPI data for reserved fields, version, and
> flags.
> 	- Removed version check from vendor driver (vt-d)
> 	- Relaxed argsz check to match the UAPI struct size instead of
> variable union size
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
> 	- Create wrapper function for in-kernel users of UAPI functions
> v2:
> 	- Removed unified API version and helper
> 	- Introduced argsz for each UAPI data
> 	- Introduced UAPI doc
> 
> 
> Jacob Pan (6):
>   docs: IOMMU user API
>   iommu/uapi: Add argsz for user filled data
>   iommu/uapi: Use named union for user data
>   iommu/uapi: Rename uapi functions
>   iommu/uapi: Handle data and argsz filled by users
>   iommu/vt-d: Check UAPI data processed by IOMMU core
> 
>  Documentation/userspace-api/iommu.rst | 209
> ++++++++++++++++++++++++++++++++++ MAINTAINERS
> |   1 + drivers/iommu/intel/iommu.c           |  25 ++--
>  drivers/iommu/intel/svm.c             |  13 ++-
>  drivers/iommu/iommu.c                 | 196
> +++++++++++++++++++++++++++++-- include/linux/iommu.h                 |
> 35 ++++-- include/uapi/linux/iommu.h            |  18 ++-
>  7 files changed, 456 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/userspace-api/iommu.rst
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
