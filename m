Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC325C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 23:57:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8547160FE7
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 23:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8547160FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 047B94028E;
	Fri, 30 Jul 2021 23:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hLYsKRDnVZ_Z; Fri, 30 Jul 2021 23:57:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5B884027D;
	Fri, 30 Jul 2021 23:57:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EBEBC001A;
	Fri, 30 Jul 2021 23:57:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0057C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 23:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E548D82C2E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 23:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pv9lAYY_SvuQ for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 23:57:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 308AB82B75
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 23:57:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213219735"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; d="scan'208";a="213219735"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 16:57:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; d="scan'208";a="508505463"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 16:56:59 -0700
Message-ID: <43dbe366ef396a81357c032ea62d8b9543678a3d.camel@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Dump DMAR translation structure
From: Kyung Min Park <kyung.min.park@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Fri, 30 Jul 2021 16:51:02 -0700
In-Reply-To: <YP6pw9j8i3bGOb13@8bytes.org>
References: <20210722042453.10579-1-kyung.min.park@intel.com>
 <YP6pw9j8i3bGOb13@8bytes.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Cc: ravi.v.shankar@intel.com, ashok.raj@intel.com, dwmw2@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 will@kernel.org
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

Hi Joerg,

On Mon, 2021-07-26 at 14:25 +0200, Joerg Roedel wrote:
> On Wed, Jul 21, 2021 at 09:24:53PM -0700, Kyung Min Park wrote:
> > When the dmar translation fault happens, the kernel prints a single
> > line
> > fault reason with corresponding hexadecimal code defined in the
> > Intel VT-d
> > specification.
> > 
> > Currently, when user wants to debug the translation fault in
> > detail,
> > debugfs is used for dumping the dmar_translation_struct, which is
> > not
> > available when the kernel failed to boot.
> > 
> > Dump the DMAR translation structure, pagewalk the IO page table and
> > print
> > the page table entry when the fault happens.
> > 
> > Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> 
> This is too much noise in dmesg for a single dmar fault. Please hide
> that additional debug information behind a debug kernel option for
> the
> VT-d driver.

Sure, let me change in the next version.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
