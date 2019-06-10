Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34227C43218
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 19:28:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114192086A
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 19:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114192086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B7140DC2;
	Mon, 10 Jun 2019 19:28:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC2D3D84
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 19:28:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6E956711
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 19:28:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Jun 2019 12:28:33 -0700
X-ExtLoop1: 1
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga003.jf.intel.com with ESMTP; 10 Jun 2019 12:28:33 -0700
Message-ID: <dbd8a4dcc9de6e7b3232c6c90597939a794860b9.camel@intel.com>
Subject: Re: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
	generic iommu
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
Date: Mon, 10 Jun 2019 12:25:31 -0700
In-Reply-To: <1560192412.27481.12.camel@intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
	<20190609023803.23832-6-baolu.lu@linux.intel.com>
	<1560192412.27481.12.camel@intel.com>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"cai@lca.pw" <cai@lca.pw>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 2019-06-10 at 11:45 -0700, Mehta, Sohil wrote:
> On Sun, 2019-06-09 at 10:38 +0800, Lu Baolu wrote:
> >  static int __init si_domain_init(int hw)
> > @@ -3306,14 +3252,13 @@ static int __init init_dmars(void)
> >                 if (pasid_supported(iommu))
> >                         intel_svm_init(iommu);
> >  #endif
> > -       }
> >  
> > -       /*
> > -        * Now that qi is enabled on all iommus, set the root entry
> > and flush
> > -        * caches. This is required on some Intel X58 chipsets,
> > otherwise the
> > -        * flush_context function will loop forever and the boot
> > hangs.
> > -        */
> > -       for_each_active_iommu(iommu, drhd) {
> > +               /*
> > +                * Now that qi is enabled on all iommus, set the root
> > entry and
> > +                * flush caches. This is required on some Intel X58
> > chipsets,
> > +                * otherwise the flush_context function will loop
> > forever and
> > +                * the boot hangs.
> > +                */
> >                 iommu_flush_write_buffer(iommu);
> >                 iommu_set_root_entry(iommu);
> >                 iommu->flush.flush_context(iommu, 0, 0, 0,
> > DMA_CCMD_GLOBAL_INVL);
> 
> This changes the intent of the original code. As the comment says
> enable QI on all IOMMUs, then flush the caches and set the root entry.
> The order of setting the root entries has changed now.
> 
> Refer: 
> Commit a4c34ff1c029 ('iommu/vt-d: Enable QI on all IOMMUs before
> setting root entry')

Thanks Sohil! for catching the bug.
Will send a V2 to Lu Baolu fixing this.

Regards,
Sai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
