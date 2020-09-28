Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF649C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:43:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568F623A50
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568F623A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 07C74840E4;
	Mon, 28 Sep 2020 22:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UykR_8qiCy5; Mon, 28 Sep 2020 22:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 040BD834B0;
	Mon, 28 Sep 2020 22:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2490C0889;
	Mon, 28 Sep 2020 22:43:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48112C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3706D85064
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rOaVzoMMqa01 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:43:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 72BE784E2E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:43:27 +0000 (UTC)
IronPort-SDR: Zcn6vl2+sYAyh3Ee7q/2xX/x2GZc1u6ArT2w0r7zMCixkppERTSxozfog0Jvc+hhj1UA5XUoeX
 SPK1SPRL2YbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223667146"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; d="scan'208";a="223667146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 15:43:26 -0700
IronPort-SDR: rCA5Vj6kEombFDbuiVXDEh9SbyPI6CHa4Jbb52aiogSx3I1tyBXcgeHfvMnlFOC97xkJ9YRUDh
 tYozbinczf4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; d="scan'208";a="294052885"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
 by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2020 15:43:26 -0700
Date: Mon, 28 Sep 2020 22:43:26 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 01/13] mm: Define pasid in mm
Message-ID: <20200928224326.GA3252736@otcwcpicx6.sc.intel.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-2-jean-philippe@linaro.org>
 <20200928222250.GA12847@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928222250.GA12847@willie-the-truck>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, fenghua.yu@intel.com,
 catalin.marinas@arm.com, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

Hi, Will and Jean,

On Mon, Sep 28, 2020 at 11:22:51PM +0100, Will Deacon wrote:
> On Fri, Sep 18, 2020 at 12:18:41PM +0200, Jean-Philippe Brucker wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > PASID is shared by all threads in a process. So the logical place to keep
> > track of it is in the "mm". Both ARM and X86 need to use the PASID in the
> > "mm".
> > 
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > https://lore.kernel.org/linux-iommu/1600187413-163670-8-git-send-email-fenghua.yu@intel.com/
> > ---
> >  include/linux/mm_types.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Acked-by: Will Deacon <will@kernel.org>

FYI. This patch is in x86 maintainers tree tip:x86/pasid now as part of
the x86 PASID MSR series.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
