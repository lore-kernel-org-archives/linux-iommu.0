Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F0CC5ACAE
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 10:37:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CD22087E
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 10:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CD22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 976651C54;
	Wed, 11 Sep 2019 10:37:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EE5411C4D
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 10:37:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8B9DA832
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 10:37:30 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 0E3E9386; Wed, 11 Sep 2019 12:37:28 +0200 (CEST)
Date: Wed, 11 Sep 2019 12:37:27 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Message-ID: <20190911103726.GB21988@8bytes.org>
References: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
	<20190910080823.GA3247@8bytes.org>
	<1568136807.58430.11.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568136807.58430.11.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "Lu,
	Baolu" <baolu.lu@intel.com>, "Park, Kyung Min" <kyung.min.park@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "Raj,
	Ashok" <ashok.raj@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 10, 2019 at 05:30:09PM +0000, Mehta, Sohil wrote:
> On Tue, 2019-09-10 at 10:08 +0200, Joerg Roedel wrote:
> > > +=A0=A0=A0=A0=A0"Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
> > "Unknown", "Unknown", /* 0x49-0x4F */
> > =

> > Maybe add the number (0x49-0x4f) to the respecting "Unknown" fields?
> > If
> > we can't give a reason we should give the number for easier debugging
> > in
> > the future. Same for the "Unknown" fields below.
> =

> I believe a fault number is always printed in=A0dmar_fault_do_one() even
> if the reason is unknown.
> =

> DMAR: [DMA Write] Request device [00:02.0] fault addr 108a000 [fault
> reason 23] Unknown

Right, applied the patch, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
