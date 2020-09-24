Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B16C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 18:09:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC28C22208
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 18:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC28C22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 45D9786A85;
	Thu, 24 Sep 2020 18:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWt3WUxZVmYo; Thu, 24 Sep 2020 18:09:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6453385335;
	Thu, 24 Sep 2020 18:09:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF52C0889;
	Thu, 24 Sep 2020 18:09:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7C20C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D069085429
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pac-7Ug4ZSPV for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 18:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ACDC785402
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:09:14 +0000 (UTC)
IronPort-SDR: QgC05f99jtdWksnY0gALyy6H/yd9xApIPE8XgFNgyB1o6bt67vM4adwQgEy/OB1jx8lUUBPFs0
 vsDbvBc5sFcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="179386477"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="179386477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 11:09:07 -0700
IronPort-SDR: fTN88eBS4ZGG0H6UJwXoUequL6Ju3JPJg39ZHVmhom6pOBekTTlWPf9fPUWHkwAuWhbvL0v4Lo
 o1rPhHwRFtBg==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="487025646"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 11:09:06 -0700
Date: Thu, 24 Sep 2020 11:09:05 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924180905.GB85236@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Joerg Roedel <jroedel@suse.de>, "Jechlitschek,
 Christoph" <christoph.jechlitschek@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Rajat Jain <rajatja@google.com>,
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

Hi Kai

+ Alex, since he had some of the early quirks authored.

On Thu, Sep 24, 2020 at 12:31:53AM +0800, Kai-Heng Feng wrote:
> [+Cc Christoph]
> 
> > On Sep 24, 2020, at 00:03, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > [+cc IOMMU and NVMe folks]
> > 
> > Sorry, I forgot to forward this to linux-pci when it was first
> > reported.
> > 
> > Apparently this happens with v5.9-rc3, and may be related to
> > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > which appeared in v5.8-rc3.
> > 
> > There are several dmesg logs and proposed patches in the bugzilla, but
> > no analysis yet of what the problem is.  From the first dmesg
> > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
> 
> AFAIK Intel is working on it internally.
> Comet Lake probably needs ACS quirk like older generation chips.

I have confirmed with Internal documentation that the problem exists on
Comet Lake. But its fixed ICL and TGL generations.

Unfortunately I do not see if the public specupdate documents are for these
generation chipsets to makes sure all root port id's can be captured.

There is also another entry in bugzilla that was forwarded that referred to
Request Redirect Capability to be always disabled as well. This same
workaround also seems to be turning off RR for the root port. I believe it
should fix it as well. But i saw another patch attached.

Can you tell how you reproduce this? just doing a

#echo mem > /sys/power/state

is sufficient with an attached NVMe drive? 

> 
> > 
> >  [   50.434945] PM: suspend entry (deep)
> >  [   50.802086] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x11e0f)
> >  [   50.842775] ACPI: Preparing to enter system sleep state S3
> >  [   50.858922] ACPI: Waking up from system sleep state S3
> >  [   50.883622] nvme 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> >  [   50.947352] nvme 0000:01:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x11e0f)
> >  [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> >  [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> >  [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >  [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> >  [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> >  [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> >  [   50.947843] nvme nvme0: frozen state error detected, reset controller
> > 
> > I suspect the nvme "can't change power state" and restore config space
> > errors are a consequence of the DPC event.  If DPC disables the link,
> > the device is inaccessible.
> > 
> > I don't know what caused the ACS Violation.  The AER TLP Header Log
> > might have a clue, but unfortunately we didn't print it.
> > 

Apparently it also requires to disable RR, and I'm not able to confirm if
CML requires that as well. 

pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
table, so i'm not sure why we need the other patch in bugzilla is required.


Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
