Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA6C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:06:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800FA60FC2
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 800FA60FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43C9F40015;
	Mon,  2 Aug 2021 15:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQmqROwDJePS; Mon,  2 Aug 2021 15:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F05ED403C6;
	Mon,  2 Aug 2021 15:06:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90189C0023;
	Mon,  2 Aug 2021 15:06:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2B8EC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3165401C5
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXjS47sXIvwI for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 15:06:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECF1140015
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:06:50 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 716CA60FF2;
 Mon,  2 Aug 2021 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627916810;
 bh=NUdIGVwiZymoyNB/NN4kI7nxgXjg9XtLvBPXAOcs2bk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RR+g/cJtTrD9M2DX63ufO+0V+JDARSoR2JvxOBsY1rqroBmzmk093PDotL7P08gKC
 nqInY6k6+td0SvNsDxUmvXWb3BtFohQSqA6m6wLAXEnpq05klahF/gtakgaRfbHU39
 1yGwYLv+zRyCIFLRUPjJfY5hj5om3/VeOyu5IxvL3CNFrTqPiRo94w1D9isb9aIrX5
 7JigCMnsmAh+XK2t7U2xZ0aq5fCWPh38WRXwa3A6oVhKZLLbR+0u54i2JdQ/qRPVG4
 0zTls9MTaawy/8gxjrbUPApkwUbtY8s8x+y7IWwNjUsu+IMVoiLzBO6LgKIMTGmVIn
 O/+9pmIb1QJHg==
Date: Mon, 2 Aug 2021 16:06:44 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
Message-ID: <20210802150644.GD28735@willie-the-truck>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1626259003-201303-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, linuxarm@huawei.com,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, robin.murphy@arm.com,
 jasowang@redhat.com, tian.shu.qiu@intel.com
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

On Wed, Jul 14, 2021 at 06:36:42PM +0800, John Garry wrote:
> Add max opt argument to init_iova_domain(), and use it to set the rcaches
> range.
> 
> Also fix up all users to set this value (at 0, meaning use default).

Wrap that in init_iova_domain_defaults() to avoid the mysterious 0?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
