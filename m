Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B18C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 23:16:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC622068E
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 23:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC622068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F22C787F43;
	Mon, 15 Jun 2020 23:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruiaqEULq5jT; Mon, 15 Jun 2020 23:16:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E1D187F89;
	Mon, 15 Jun 2020 23:16:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18DFDC0890;
	Mon, 15 Jun 2020 23:16:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 214F5C016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 23:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E7D68234BD
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 23:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YdpasAINpeJ2 for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 23:16:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id E8827232A7
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 23:16:20 +0000 (UTC)
IronPort-SDR: QVY76wXheBxRDvQNBrfBXgS1ogXIr5q+6AwIYy8hHNnINE0T81cvhTSQ/B59gzePq2OSZp7RRr
 3Kvk7oCkC9wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 16:16:20 -0700
IronPort-SDR: T6ZjbELIrapPoUUC8t/yjki9aqCic7a2OCwmjZ4mzrjLS+BziTN1GdCLNAuNKeyY7ttZANoaUg
 /GtVSFW3HOXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; d="scan'208";a="290863836"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 15 Jun 2020 16:16:19 -0700
Date: Mon, 15 Jun 2020 16:16:18 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 04/12] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200615231618.GF13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-5-git-send-email-fenghua.yu@intel.com>
 <9d1bd13c-0e0d-bead-f9a8-9422996a33f8@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9d1bd13c-0e0d-bead-f9a8-9422996a33f8@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

Hi, Baolu,

On Sat, Jun 13, 2020 at 08:17:40PM +0800, Lu Baolu wrote:
> Hi Fenghua,
> 
> On 2020/6/13 8:41, Fenghua Yu wrote:
> >+implement implement fairness or ensure forward progress can be made.
> 
> Repeated "implement".

Will fix this.

> >+For example, the Intel Data Streaming Accelerator (DSA) uses
> >+intel_svm_bind_mm(), which will do the following.
> 
> The Intel SVM APIs have been deprecated. Drivers should use
> iommu_sva_bind_device() instead. Please also update other places in
> this document.

Will fix this.

Thanks.

-Fenghua

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
