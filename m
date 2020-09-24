Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03647C4727E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9249D239CF
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9249D239CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A25386B72;
	Thu, 24 Sep 2020 19:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osvFQRGV3mx1; Thu, 24 Sep 2020 19:44:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A11AC86B1F;
	Thu, 24 Sep 2020 19:44:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F97EC0859;
	Thu, 24 Sep 2020 19:44:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB2D9C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 19:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B0B3C203CA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 19:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AcH3lYWkgNUd for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 19:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id E4B15203AE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 19:44:40 +0000 (UTC)
IronPort-SDR: HNnV+OEB+1Sl2Bqvp9+DJpVOsgLYlqgmp/F1cbC5nLIHtfVQoeVBmG2wbyui7c4s4Uny9ZM59a
 pIbDP6IkCBAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="160600624"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="160600624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 12:44:40 -0700
IronPort-SDR: 9E8u/g9+DJXqEJYEfe6YY2wPeNd83X3hmTGz1kbJ1RGdoDRCGp/cSFwecSPWI8ZisEm4oNTPlV
 H9TNfuoxnwHA==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="291360614"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 12:44:39 -0700
Date: Thu, 24 Sep 2020 12:44:37 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924194437.GA85997@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
 <20200924180905.GB85236@otc-nc-03>
 <20200924133938.6b93732f@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924133938.6b93732f@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Joerg Roedel <jroedel@suse.de>, "Jechlitschek,
 Christoph" <christoph.jechlitschek@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>
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

Hi Alex

> > Apparently it also requires to disable RR, and I'm not able to confirm if
> > CML requires that as well. 
> > 
> > pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
> > table, so i'm not sure why we need the other patch in bugzilla is required.
> 
> If we're talking about the Intel bug where PCH root ports implement
> the ACS capability and control registers as dword rather than word
> registers, then how is ACS getting enabled in order to generate an ACS
> violation?  The standard ACS code would write to the control register
> word at offset 6, which is still the read-only capability register on
> those devices.  Thanks,


Right... Maybe we need header log to figure out what exatly is happening. 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
