Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA9DC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 10:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12AB1827AA;
	Wed,  6 Jul 2022 10:47:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12AB1827AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 98SsTfSF8BPQ; Wed,  6 Jul 2022 10:47:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3A8A827A1;
	Wed,  6 Jul 2022 10:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3A8A827A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2DF0C0033;
	Wed,  6 Jul 2022 10:47:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D316DC002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D057827A8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D057827A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJehjM-a4wqZ for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 10:46:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62B9C827A1
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62B9C827A1
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:46:59 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 66B3D4CC; Wed,  6 Jul 2022 12:46:56 +0200 (CEST)
Date: Wed, 6 Jul 2022 12:46:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <YsVoHtiNIhvrN+Zd@8bytes.org>
References: <20220521002115.1624069-1-yian.chen@intel.com>
 <7149e5dd-c72e-538b-b98f-0fbc89580a95@linux.intel.com>
 <YrVPelnOi9nql/8C@8bytes.org>
 <1036ab2c-f854-9746-ddc7-e9fe20cd3d40@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1036ab2c-f854-9746-ddc7-e9fe20cd3d40@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Jun 24, 2022 at 02:12:28PM +0800, Baolu Lu wrote:
> It makes sense as far as I am aware. By putting IOMMUs in pass-through
> mode, there will be no run-time costs and things could be simplified a
> lot.
> 
> Besides the refactoring efforts, we still need this quick fix so that
> the fix could be propagated to various stable and vendors' downstream trees.

Patch is applied now for 5.19.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
