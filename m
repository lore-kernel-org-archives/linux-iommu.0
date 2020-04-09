Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E62C2BB85
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 19:32:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D08620757
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 19:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D08620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C37418807C;
	Thu,  9 Apr 2020 19:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5+Mr-xs1+eY; Thu,  9 Apr 2020 19:32:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4F78487BC8;
	Thu,  9 Apr 2020 19:32:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34027C1D7E;
	Thu,  9 Apr 2020 19:32:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A196C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 19:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0F9F287BC8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 19:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K61L-EI6QmAl for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 19:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 829EC87B5D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 19:32:24 +0000 (UTC)
IronPort-SDR: x84CTi+QlZ6Ios1llc+TizKTzurwSRMjhKLSvd59zzTXJ8WxK3mASYrxC5Dgpsab8iAvrU1pHF
 AVD3kpY1psEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 12:32:22 -0700
IronPort-SDR: FcOz2aKwDMUhIQvHop9Zpt0cOYquXgeCrNF7hCJY+gyODlZuB+JF9XbErfROwv238uifDji3OB
 1QnJ132mntlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="452116450"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
 by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2020 12:32:21 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH 0/1] Real DMA dev DMA domain patch
Date: Thu,  9 Apr 2020 15:17:35 -0400
Message-Id: <20200409191736.6233-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Cc: linux-pci@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux@endlessm.com,
 Jon Derrick <jonathan.derrick@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Sorry for the late patch here, but I hit the issue Baolu and Daniel
pointed out could occur, and requires this fix (or iommu=nopt).
Hoping to get it into an rc

Jon Derrick (1):
  iommu/vt-d: use DMA domain for real DMA devices and subdevices

 drivers/iommu/intel-iommu.c | 56 ++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

-- 
2.18.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
