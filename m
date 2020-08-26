Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E92C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 15:53:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACCB2078D
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAMVIkAq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jmJX9jYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACCB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E7D18841C9;
	Wed, 26 Aug 2020 15:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OztzpPy7y49b; Wed, 26 Aug 2020 15:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E822F81E48;
	Wed, 26 Aug 2020 15:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFDF2C07FF;
	Wed, 26 Aug 2020 15:53:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C1AAC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F1FB287BFE
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Stv9TPz1Xz5 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 15:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6607E87BC0
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 15:53:24 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598457201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goeJdvyvZirwLASPyTOx+y+LUKYx5a0JO0G5JsEt0Cs=;
 b=DAMVIkAqyy4AKY1e6W79Rih9wNEl9PD/FZjnhUNeIIoZ7l7kq/75TfVmu354vBX+/WVqTA
 0YjI/dmCcnmc3U2AuvKkvnJKdt48xoP5IxXuMm27KNP1xsFyVwIRtBfqkgnCIvQXzuV6vO
 yy0UO9WOuwsx5oUqk0Ah2/+CRbxmtC+gkgpofiIg04ycN8dSJq5uqkczQFlAcXU0kXJ5sV
 Vw/U5GyWJhrSz1COrbHuQ71RfkMBq07l75m5ZIuXl47zptJGJwDPvs+R6DQbg7r93KYqfV
 ccMOndh+4GHBiJK7goeyGUBc8gRKvX4CmWiSf1sVfIKxV3RYU7gc8uWD8gpBpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598457201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goeJdvyvZirwLASPyTOx+y+LUKYx5a0JO0G5JsEt0Cs=;
 b=jmJX9jYrcb8PLSa2rxhC1AqHOM8H5y0zrmuUZbL4nNMTKGQ07p4qkJrjolnc5PiJECMKF1
 ku155QR6nYgU0uDQ==
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
In-Reply-To: <20200826112333.992429909@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.992429909@linutronix.de>
Date: Wed, 26 Aug 2020 17:53:20 +0200
Message-ID: <87h7spv1xr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Aug 26 2020 at 13:17, Thomas Gleixner wrote:
> + * If CONFIG_PCI_MSI_ARCH_FALLBACKS is not selected they are replaced by
> + * stubs with warnings.
>   */
> +#ifdef CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS

Groan, I obviously failed to pull that back from the test box where I
fixed it. That wants to be:

+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS

Doing five things at once does not work well
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
