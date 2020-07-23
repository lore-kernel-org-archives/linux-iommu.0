Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B946BC433E8
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 19:30:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615B02067D
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 19:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoGkpg7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615B02067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C22986E65;
	Thu, 23 Jul 2020 19:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDBeRvB56ZWP; Thu, 23 Jul 2020 19:30:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A01F084E24;
	Thu, 23 Jul 2020 19:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 921ACC004E;
	Thu, 23 Jul 2020 19:30:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D60CC004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 19:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 331B1203CF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 19:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aOKe99rRuAt6 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 19:30:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id C3938203AF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 19:30:43 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33B2B2067D;
 Thu, 23 Jul 2020 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595532643;
 bh=7InW/I38muM+u0qDvAzcUWvmPajbXN7K+EHKB8+aI98=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=VoGkpg7/H/Gv5IFWFsnv3YGd9Frr08vHEFmbXvHV17HbCRv5l1QxuOEeN+84FkX9M
 TiN0omh+WS5rh/FCKxAypSKymdubnrxE3f/EiI+4VGLZxy0A4lBLQBqFTt2r8ylvVJ
 RVPy/b29uNx5A8yMwdwYNa6gxhM5VF+H99Mm6Bmg=
Date: Thu, 23 Jul 2020 14:30:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI/ATS: PASID and PRI are only enumerated in PF devices.
Message-ID: <20200723193041.GA1446817@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723173819.GA345408@otc-nc-03>
Cc: Lu Baolu <baolu.lu@intel.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
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

On Thu, Jul 23, 2020 at 10:38:19AM -0700, Raj, Ashok wrote:
> Hi Bjorn
> 
> On Tue, Jul 21, 2020 at 09:54:01AM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 20, 2020 at 09:43:00AM -0700, Ashok Raj wrote:
> > > PASID and PRI capabilities are only enumerated in PF devices. VF devices
> > > do not enumerate these capabilites. IOMMU drivers also need to enumerate
> > > them before enabling features in the IOMMU. Extending the same support as
> > > PASID feature discovery (pci_pasid_features) for PRI.
> > > 
> > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > 
> > Hi Ashok,
> > 
> > When you update this for the 0-day implicit declaration thing, can you
> > update the subject to say what the patch *does*, as opposed to what it
> > is solving?  Also, no need for a period at the end.
> 
> Yes, will update and resend. Goofed up a couple things, i'll update those
> as well.
> 
> > Does this fix a regression?  Is it associated with a commit that we
> > could add as a "Fixes:" tag so we know how far back to try to apply
> > to stable kernels?
> 
> Yes, 

Does that mean "yes, this fixes a regression"?

> but the iommu files moved location and git fixes tags only generates
> for a few handful of commits and doesn't show the old ones. 

Not sure how to interpret the rest of this.  I'm happy to include the
SHA1 of the original commit that added the regression, even if the
file has moved since then.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
