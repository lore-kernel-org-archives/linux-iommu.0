Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37879C2BA80
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 04:00:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0726D20730
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 04:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0726D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B594B87877;
	Wed,  8 Apr 2020 04:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wozKnRq-SNTg; Wed,  8 Apr 2020 04:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCF7087762;
	Wed,  8 Apr 2020 04:00:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1EC6C1D7E;
	Wed,  8 Apr 2020 04:00:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89B61C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 04:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 74BFE868DE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 04:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXtLl-46X3pJ for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 04:00:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3A5A3868D5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 04:00:22 +0000 (UTC)
IronPort-SDR: KW25VnXfr3a5OtnKkoIZEnNoTUdEZZnpjongN9opW0pp+w5N+9zGH3NbOVxfDy8XEHINv780x9
 CGUXOZqe5OoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 21:00:21 -0700
IronPort-SDR: f9f374JUMkKx4uPk6CViWMoJ7usS0ImJsEAoos95KEZ8procvMO83u9Ez6k6bMdPzvgEpKaLQq
 uU7jtP826KNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; d="scan'208";a="269639700"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by orsmga002.jf.intel.com with ESMTP; 07 Apr 2020 21:00:21 -0700
Date: Tue, 7 Apr 2020 21:00:21 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 2/2] vfio/pci: Emulate PASID/PRI capability for VFs
Message-ID: <20200408040021.GS67127@otc-nc-03>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <1584880394-11184-3-git-send-email-yi.l.liu@intel.com>
 <20200402165954.48d941ee@w520.home>
 <A2975661238FB949B60364EF0F2C25743A2204FE@SHSMSX104.ccr.corp.intel.com>
 <20200403112545.6c115ba3@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D80E13D@SHSMSX104.ccr.corp.intel.com>
 <20200407095801.648b1371@w520.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200407095801.648b1371@w520.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Wu,
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

+ Bjorn

FWIW I can't understand why PCI SIG went different ways with ATS, 
where its enumerated on PF and VF. But for PASID and PRI its only
in PF. 

I'm checking with our internal SIG reps to followup on that.

On Tue, Apr 07, 2020 at 09:58:01AM -0600, Alex Williamson wrote:
> > Is there vendor guarantee that hidden registers will locate at the
> > same offset between PF and VF config space? 
> 
> I'm not sure if the spec really precludes hidden registers, but the
> fact that these registers are explicitly outside of the capability
> chain implies they're only intended for device specific use, so I'd say
> there are no guarantees about anything related to these registers.

As you had suggested in the other thread, we could consider
using the same offset as in PF, but even that's a better guess
still not reliable.

The other option is to maybe extend driver ops in the PF to expose
where the offsets should be. Sort of adding the quirk in the 
implementation. 

I'm not sure how prevalent are PASID and PRI in VF devices. If SIG is resisting 
making VF's first class citizen, we might ask them to add some verbiage
to suggest leave the same offsets as PF open to help emulation software.


> 
> FWIW, vfio started out being more strict about restricting config space
> access to defined capabilities, until...
> 
> commit a7d1ea1c11b33bda2691f3294b4d735ed635535a
> Author: Alex Williamson <alex.williamson@redhat.com>
> Date:   Mon Apr 1 09:04:12 2013 -0600
> 

Cheers,
Ashok

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
