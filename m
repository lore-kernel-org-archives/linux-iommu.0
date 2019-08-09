Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821EC433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 20:32:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22A8214C6
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 20:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22A8214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4F57ACB0;
	Fri,  9 Aug 2019 20:32:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8E1E2CA5
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 20:32:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DD1B167F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 20:32:10 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id DA0543D0; Fri,  9 Aug 2019 22:32:08 +0200 (CEST)
Date: Fri, 9 Aug 2019 22:32:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Message-ID: <20190809203208.GB1213@8bytes.org>
References: <20190809152233.2829-1-joro@8bytes.org>
	<20190809152233.2829-4-joro@8bytes.org>
	<7f383631-ce2c-e7c2-ceff-e7418bf8ff29@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f383631-ce2c-e7c2-ceff-e7418bf8ff29@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hey Tom,

On Fri, Aug 09, 2019 at 04:50:48PM +0000, Lendacky, Thomas wrote:
> On 8/9/19 10:22 AM, Joerg Roedel wrote:
> > +	if ((iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY) &&
> > +	    sme_active()) {
> > +		pr_info("SME detected - Disabling default IOMMU passthrough\n");
> > +		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
> 
> Should this also clear the iommu_pass_through variable (the one set by the
> iommu kernel parameter in arch/x86/kernel/pci-dma.c)?

This code is used on different architectures, so I can't cleanly access
architecture specific variables here.

> I guess this is more applicable to the original patchset that created the
> CONFIG_IOMMU_DEFAULT_PASSTHROUGH option, but should the default
> passthrough support be modified so that you don't have to specify multiple
> kernel parameters to change it?
> 
> Right now, if CONFIG_IOMMU_DEFAULT_PASSTHROUGH is set to yes, you can't
> just specify iommu=nopt to enable the IOMMU. You have to also specify
> iommu.passthrough=0. Do we want to fix that so that just specifying
> iommu=nopt or iommu.passthrough=0 does what is needed?

Yeah, that is currently a mess and I think cleaning that up is at least
partly in the scope of this patch-set. I'll look into that next week.


Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
