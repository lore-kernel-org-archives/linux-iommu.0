Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C59C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:04:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517EE206F8
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517EE206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31918894F6;
	Fri, 27 Mar 2020 10:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UoN-qpF1bno5; Fri, 27 Mar 2020 10:04:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB459894F1;
	Fri, 27 Mar 2020 10:04:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9054C1D7C;
	Fri, 27 Mar 2020 10:04:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFF8BC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A853A88649
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LdQ9mDfYdau for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 10:04:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD8CA885FB
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:04:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 906FE2C8; Fri, 27 Mar 2020 11:04:23 +0100 (CET)
Date: Fri, 27 Mar 2020 11:04:22 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/3] Misc bug fixes for VT-d SVM
Message-ID: <20200327100422.GC11538@8bytes.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Raj Ashok <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Mar 19, 2020 at 09:32:28PM -0700, Jacob Pan wrote:
>   iommu/vt-d: Fix mm reference leak
>   iommu/vt-d: Add build dependency on IOASID

Applied these two, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
