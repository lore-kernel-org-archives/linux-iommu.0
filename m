Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8407EC2BA19
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 03:29:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E495206C3
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 03:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E495206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 253FB84995;
	Mon, 13 Apr 2020 03:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjhQ2d9GYGxq; Mon, 13 Apr 2020 03:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4484784961;
	Mon, 13 Apr 2020 03:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29519C1D7D;
	Mon, 13 Apr 2020 03:29:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE59FC0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 03:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C676285B7C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 03:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-PXHZ-lsLaM for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 03:29:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 370C985BC0
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 03:29:35 +0000 (UTC)
IronPort-SDR: 8LVBgZb8k90SSjiZcpGzYX93gBoSmEitqF+/096EF99CJVlg3Ou8bbxddx2iTtFqG9ZA9njux1
 +EmIT2wyQo/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 20:29:34 -0700
IronPort-SDR: kaY6tSE5sav4RYffzh5Gz8m+KI24+vSEUaId10rWnW/z77yZuUjZQe137BBTWyM9T41eTMKCJy
 8agcj2vT/LvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="453023852"
Received: from araj-mobl1.jf.intel.com ([10.255.32.166])
 by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2020 20:29:31 -0700
Date: Sun, 12 Apr 2020 20:29:31 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Raj, Ashok" <ashok.raj@linux.intel.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200413032930.GB18479@araj-mobl1.jf.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>
 <20200408040021.GS67127@otc-nc-03>
 <20200408101940.3459943d@w520.home>
 <20200413031043.GA18183@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200413031043.GA18183@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

Going through the PCIe Spec, there seems a lot of such capabilities
that are different between PF and VF. Some that make sense
and some don't.


On Sun, Apr 12, 2020 at 08:10:43PM -0700, Raj, Ashok wrote:
> 
> > 
> > I agree though, I don't know why the SIG would preclude implementing
> > per VF control of these features.  Thanks,
> > 

For e.g. 

VF doesn't have I/O and Mem space enables, but has BME
Interrupt Status
Correctable Error Reporting
Almost all of Device Control Register.

So it seems like there is a ton of them we have to deal with today for 
VF's. How do we manage to emulate them without any support for them 
in VF's? 


> 
> Cheers,
> Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
