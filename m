Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A18C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 20:03:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8313E2344C
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 20:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8313E2344C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10BB48658A;
	Thu, 24 Sep 2020 20:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSUpHVtu5mzj; Thu, 24 Sep 2020 20:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82F36864D0;
	Thu, 24 Sep 2020 20:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BFF3C0859;
	Thu, 24 Sep 2020 20:03:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BC86C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 20:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 36F2D874D3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 20:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EMW55-IqOawp for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 20:03:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 90C2E874CF
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 20:03:40 +0000 (UTC)
IronPort-SDR: iSTR1zQjPf+Dgf2eh3H2QWg0R9S5KVWmEb7MbXmqTAlVO7GwjzV86caXVU8cmyUkvnC2XwaKB5
 cVR4lpUuo3+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149080444"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="149080444"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 13:03:36 -0700
IronPort-SDR: rE7k9Y2C1CZ+onZsdxfwq3rMXOIxI0PfazBZOvmV8AIsKeex9TwCiMByFH1VnIxlAbirefXbiN
 BXma1uP5kcPQ==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="336143599"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 13:03:35 -0700
Date: Thu, 24 Sep 2020 13:03:34 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924200334.GC86064@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <20200923161944.GA17764@otc-nc-03>
 <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Joerg Roedel <jroedel@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci <linux-pci@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Sep 23, 2020 at 12:45:11PM -0700, Rajat Jain wrote:
> On Wed, Sep 23, 2020 at 9:19 AM Raj, Ashok <ashok.raj@intel.com> wrote:
> >
> > Hi Bjorn
> >
> >
> > On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> > > [+cc IOMMU and NVMe folks]
> > >
> > > Sorry, I forgot to forward this to linux-pci when it was first
> > > reported.
> > >
> > > Apparently this happens with v5.9-rc3, and may be related to
> > > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > > which appeared in v5.8-rc3.
> > >
> > > There are several dmesg logs and proposed patches in the bugzilla, but
> > > no analysis yet of what the problem is.  From the first dmesg
> > > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
> >
> > We have been investigating this internally as well. It appears maybe the
> > specupdate for Cometlake is missing the errata documention. The offsets
> > were wrong in some of them, and if its the same issue its likely cause.
> 
> Can you please also confirm if errata applies to Tigerlake ?
> 

We confirmed ICL/TGL isn't affected.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
