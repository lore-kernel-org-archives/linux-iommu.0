Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C18C38A2E
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 12:13:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CD121D79
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 12:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CD121D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9472C8689C;
	Sat, 18 Apr 2020 12:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12S-RamKzCl1; Sat, 18 Apr 2020 12:13:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3007886881;
	Sat, 18 Apr 2020 12:13:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 079C3C089F;
	Sat, 18 Apr 2020 12:13:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E69EC0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3FA438689C
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgovFzI1tvap for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 12:13:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1259786881
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:13:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 171EA342; Sat, 18 Apr 2020 14:13:21 +0200 (CEST)
Date: Sat, 18 Apr 2020 14:13:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Message-ID: <20200418121319.GB6113@8bytes.org>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
 <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
 <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
 <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux PCI <linux-pci@vger.kernel.org>, Daniel Drake <drake@endlessm.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Linux Upstreaming Team <linux@endlessm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 13, 2020 at 10:48:55AM +0800, Lu Baolu wrote:
> I have sync'ed with Joerg. This patch set will be replaced with Joerg's
> proposal due to a race concern between domain switching and driver
> binding. I will rebase all vt-d patches in this set on top of Joerg's
> change.

Okay, but is this patch relevant for v5.7? The other changes we are
working on will not land before v5.8.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
