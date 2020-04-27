Return-Path: <SRS0=6Sm1=6L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A5C4CECC
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 20:51:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EC02070B
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 20:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EC02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 289EC84D56;
	Mon, 27 Apr 2020 20:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4W1jxkI7DUQ; Mon, 27 Apr 2020 20:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A036C84B55;
	Mon, 27 Apr 2020 20:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 771CBC0172;
	Mon, 27 Apr 2020 20:51:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F38EC003B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1BC1C2221F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWLcxRJF-v4d for <iommu@lists.linux-foundation.org>;
 Mon, 27 Apr 2020 20:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id DC87B20385
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:51:47 +0000 (UTC)
IronPort-SDR: 1CykEM5xIg/tdkFJJbumfFO9FbI27iMXPTb8znTkBWan+cwF9zWK/AE3EYnBgCBxGIp50+JN1K
 zC4uCTD/u5oQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 13:51:47 -0700
IronPort-SDR: OzjFzowdiAAi7ko+rI7XAZrtRA1KQSqppc5kR0KuQeUaV/9XsuF+JR/9ixe+1kaIKzk5G/F4YW
 jqykhlmsh48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="275604013"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 27 Apr 2020 13:51:46 -0700
Date: Mon, 27 Apr 2020 13:50:51 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/7] x86/msr-index: Define IA32_PASID MSR
Message-ID: <20200427205050.GE242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-5-git-send-email-fenghua.yu@intel.com>
 <87sggqsd9j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sggqsd9j.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Sun, Apr 26, 2020 at 01:22:00PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> 
> > The IA32_PASID MSR (0xd93) contains the Process Address Space Identifier
> > (PASID), a 20-bit value. Bit 31 must be set to indicate the value
> > programmed in the MSR is valid. Hardware uses PASID to identify which
> > process submits the work and direct responses to the right process.
> 
> No. It does not identify the process. It identifies the process' address
> space as the name says.
> 
> Please provide coherent and precise information.

Ok. Will change to address space identification.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
