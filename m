Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6125C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 14:10:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FB922A99
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 14:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FB922A99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E5DE582DDF;
	Fri,  8 Jan 2021 14:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PrdzDI7R_Yi; Fri,  8 Jan 2021 14:09:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4C3A786D50;
	Fri,  8 Jan 2021 14:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41840C088B;
	Fri,  8 Jan 2021 14:09:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 813F1C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F01E866F5
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1n0KwRh-YTkE for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 14:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E60F28627E
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:09:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0268E22525;
 Fri,  8 Jan 2021 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610114977;
 bh=fjs87wmD1dhPTR3MDXSplx7dascsW/EY1STyOCAmXes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kmWvRbk9mV7sNidMTbEW/3w5cx8bPc12n+7n7z/hFgGQWU7aZmKrx++KoYtd4OaFX
 taVIFEYO3Xz0sTR4zRGZ1qvBSEAYTYi70BtMlj9APaO5D0eJj4hjRVTNvrJRfEk+GJ
 quAK16/5j1/lSq57NaGJo5GWgNukj+PD1LunPd08CFC4MfxlV9OuB4QedvuptGm9Q7
 O4jGrscXHjgRms6vKJhc3twlp87R0ld3iT2zUiRmsST2eHpXzzNqSNpZK2s3w364YV
 ODP4n9CsGhvvf7a7J/lY0cYk/vtVgMZQgqpivwFhwCRKk4FyYXePF18voOoLT0Tg9E
 hEvJSMHxsZQFg==
Date: Fri, 8 Jan 2021 14:09:32 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Message-ID: <20210108140932.GA4811@willie-the-truck>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
 <20210105190357.GA12182@willie-the-truck>
 <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
 <9b26b7ac-b5c7-f38a-a078-b53a6b6bf375@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9b26b7ac-b5c7-f38a-a078-b53a6b6bf375@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Lu,

On Fri, Jan 08, 2021 at 07:52:47AM +0800, Lu Baolu wrote:
> On 2021/1/6 9:09, Lu Baolu wrote:
> > On 2021/1/6 3:03, Will Deacon wrote:
> > > On Thu, Dec 31, 2020 at 08:53:20AM +0800, Lu Baolu wrote:
> > > > @@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev
> > > > (struct intel_svm *svm, struct intel_svm_d
> > > > =A0=A0=A0=A0=A0 }
> > > > =A0 }
> > > > +static void intel_flush_svm_range_dev(struct intel_svm *svm,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
ruct intel_svm_dev *sdev,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 un=
signed long address,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 un=
signed long pages, int ih)
> > > > +{
> > > > +=A0=A0=A0 unsigned long shift =3D ilog2(__roundup_pow_of_two(pages=
));
> > > > +=A0=A0=A0 unsigned long align =3D (1ULL << (VTD_PAGE_SHIFT + shift=
));
> > > > +=A0=A0=A0 unsigned long start =3D ALIGN_DOWN(address, align);
> > > > +=A0=A0=A0 unsigned long end =3D ALIGN(address + (pages <<
> > > > VTD_PAGE_SHIFT), align);
> > > > +
> > > > +=A0=A0=A0 while (start < end) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 __flush_svm_range_dev(svm, sdev, start, alig=
n >>
> > > > VTD_PAGE_SHIFT, ih);
> > > > +=A0=A0=A0=A0=A0=A0=A0 start +=3D align;
> > > > +=A0=A0=A0 }
> > > > +}
> > > =

> > > Given that this only seems to be called from
> > > intel_invalidate_range(), which
> > > has to compute 'pages' only to have it pulled apart again here,
> > > perhaps it
> > > would be cleaner for intel_flush_svm_range() to take something like an
> > > 'order' argument instead?
> > > =

> > > What do you think?
> > =

> > We need to clean up here. It's duplicate with the qi_flush_piotlb()
> > helper. I have a patch under testing for this. I will post it for review
> > later.
> =

> I'm sorry, above reply is a little vague.
> =

> I meant to say, let's take 'pages' as the argument. We are going to use
> qi_flush_piotlb() here to avoid duplicate QI interactions. The
> qi_flush_piotlb() helper also takes 'pages', so keep 'pages' here will
> make things easier.
> =

> My cleanup patch is for v5.12. Can you please take this for v5.11?

Ah sorry, I didn't realise that was your plan. Please just include this
patch in a series of 2 when you post a fixed version of the trace event
removal and then I'll queue them up next week, as I've already prepared
the pull for today.

Apologies,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
