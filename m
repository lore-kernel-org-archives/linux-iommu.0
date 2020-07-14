Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CDFC433F1
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 13:55:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4094620760
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 13:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4094620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 16C7E89166;
	Tue, 14 Jul 2020 13:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bE96W4_eaEJ; Tue, 14 Jul 2020 13:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8657D8915F;
	Tue, 14 Jul 2020 13:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61B69C0891;
	Tue, 14 Jul 2020 13:55:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38A1AC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2746A89166
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12h_jH8Z4WVp for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 13:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 982DB8915F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:54:54 +0000 (UTC)
IronPort-SDR: lBmB+9yByNNJCA3G9jGlqlTfoHt3Hb9195zOnsceIAeNEg95u+dFmSvLgQtmlZCWcWpryVb+60
 RswHlQgU2cgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148031395"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="148031395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 06:54:50 -0700
IronPort-SDR: +XxidMzrv1a/8/8wXZ7LcHaInmy7T6RrqjR1IZ3hUJ3l6CBXlDbbvF1v1Acu2ApZ+1FOxRdw/u
 m41TaWmbXY1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="485370296"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 06:54:49 -0700
Date: Tue, 14 Jul 2020 06:54:49 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] iommu: Change type of pasid to u32
Message-ID: <20200714135449.GI32961@romley-ivt3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
 <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Peter Zijlstra <peterz@infradead.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Luck, Tony" <tony.luck@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Jul 13, 2020 at 07:45:49PM -0700, Liu, Yi L wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Sent: Tuesday, July 14, 2020 7:48 AM
> >
> > PASID is defined as a few different types in iommu including "int",
> > "u32", and "unsigned int". To be consistent and to match with uapi
> > definitions, define PASID and its variations (e.g. max PASID) as "u32".
> > "u32" is also shorter and a little more explicit than "unsigned int".
> >
> > No PASID type change in uapi although it defines PASID as __u64 in
> > some places.
> 
> just out of curious, why not using ioasid_t? In Linux kernel, PASID is
> managed by ioasid.

ioasid_t is only used in limited underneath files (ioasid.c and ioasid.h).
Instead of changing hundreds of places to use ioasid_t, it's better to
keep ioasid_t only used in the files.

And it's explict and matches with uapi to define PASID as u32. Changing
to ioasid_t in so many files (amd, gpu, crypto, etc) may confuse upper
users on "why ioasid_t".

So we had better to explicitly define PASID as u32 and keep ioasid_t in
the limited underneath files.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
