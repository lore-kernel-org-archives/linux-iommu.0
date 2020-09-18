Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E337C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:02:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0B4208B8
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0B4208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E7519872ED;
	Fri, 18 Sep 2020 10:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8takuymSdxF; Fri, 18 Sep 2020 10:02:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32CFF872CC;
	Fri, 18 Sep 2020 10:02:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 185B0C0859;
	Fri, 18 Sep 2020 10:02:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BEDC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 78DD1877E3
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NllfFJvqI2Gt for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:02:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8809F877E1
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:02:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 91457293; Fri, 18 Sep 2020 12:02:37 +0200 (CEST)
Date: Fri, 18 Sep 2020 12:02:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v9 0/7] IOMMU user API enhancement
Message-ID: <20200918100235.GQ31590@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Yi Sun <yi.y.sun@intel.com>
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

Hi Jacob,

On Fri, Sep 11, 2020 at 02:57:49PM -0700, Jacob Pan wrote:
> IOMMU user API header was introduced to support nested DMA translation and
> related fault handling. The current UAPI data structures consist of three
> areas that cover the interactions between host kernel and guest:
>  - fault handling
>  - cache invalidation
>  - bind guest page tables, i.e. guest PASID
> 
> Future extensions are likely to support more architectures and vIOMMU features.
> 
> In the previous discussion, using user-filled data size and feature flags is
> made a preferred approach over a unified version number.
> https://lkml.org/lkml/2020/1/29/45
> 
> In addition to introduce argsz field to data structures, this patchset is also
> trying to document the UAPI design, usage, and extension rules. VT-d driver
> changes to utilize the new argsz field is included, VFIO usage is to follow.
> 
> This set is available at:
> https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v9

This changes user visible structs in incompatible ways, are you sure
those are not used yet anywhere?

Please address Randy's comments on patch 1 and my comment about the
build-time checking and repost with linux-api@vger.kernel.org on Cc.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
