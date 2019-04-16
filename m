Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE01C282DA
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C1020674
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C1020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D7CE8F38;
	Tue, 16 Apr 2019 15:21:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C55ECCC7
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 15:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 710AB828
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 15:21:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E670680D;
	Tue, 16 Apr 2019 08:21:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E3B23F59C;
	Tue, 16 Apr 2019 08:21:02 -0700 (PDT)
Date: Tue, 16 Apr 2019 16:21:00 +0100
From: Will Deacon <will.deacon@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
Message-ID: <20190416152100.GB4187@fuggles.cambridge.arm.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
	<20190409125308.18304-2-thunder.leizhen@huawei.com>
	<010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
	<222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: linux-ia64 <linux-ia64@vger.kernel.org>,
	Sebastian Ott <sebott@linux.ibm.com>,
	linux-doc <linux-doc@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
	linux-s390 <linux-s390@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, x86 <x86@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Tony Luck <tony.luck@intel.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416152100.tnDdncO-RJKRik-Y2MWQtLZJfgwixgCPwAb3lp_3XFc@z>

On Fri, Apr 12, 2019 at 02:11:31PM +0100, Robin Murphy wrote:
> On 12/04/2019 11:26, John Garry wrote:
> > On 09/04/2019 13:53, Zhen Lei wrote:
> > > +static int __init iommu_dma_mode_setup(char *str)
> > > +{
> > > +=A0=A0=A0 if (!str)
> > > +=A0=A0=A0=A0=A0=A0=A0 goto fail;
> > > +
> > > +=A0=A0=A0 if (!strncmp(str, "passthrough", 11))
> > > +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_PASS=
THROUGH;
> > > +=A0=A0=A0 else if (!strncmp(str, "lazy", 4))
> > > +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_LAZY;
> > > +=A0=A0=A0 else if (!strncmp(str, "strict", 6))
> > > +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_STRI=
CT;
> > > +=A0=A0=A0 else
> > > +=A0=A0=A0=A0=A0=A0=A0 goto fail;
> > > +
> > > +=A0=A0=A0 pr_info("Force dma mode to be %d\n", iommu_default_dma_mod=
e);
> > =

> > What happens if the cmdline option iommu.dma_mode is passed multiple
> > times? We get mutliple - possibily conflicting - prints, right?
> =

> Indeed; we ended up removing such prints for the existing options here,
> specifically because multiple messages seemed more likely to be confusing
> than useful.
> =

> > And do we need to have backwards compatibility, such that the setting
> > for iommu.strict or iommu.passthrough trumps iommu.dma_mode, regardless
> > of order?
> =

> As above I think it would be preferable to just keep using the existing
> options anyway. The current behaviour works out as:
> =

> iommu.passthrough |      Y	|	  N
> iommu.strict	  |      x	|    Y         N
> ------------------|-------------|---------|--------
> MODE		  | PASSTHROUGH | STRICT  |  LAZY
> =

> which seems intuitive enough that a specific dma_mode option doesn't add
> much value, and would more likely just overcomplicate things for users as
> well as our implementation.

Agreed. We can't remove the existing options, and they do the job perfectly
well so I don't see the need to add more options on top.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
