Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B43C4727E
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 08:22:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85772087E
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 08:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgazHTI+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOZyUThn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85772087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7168922DE3;
	Thu,  1 Oct 2020 08:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPhZNrUXzApa; Thu,  1 Oct 2020 08:22:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 167492044C;
	Thu,  1 Oct 2020 08:22:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F091BC0889;
	Thu,  1 Oct 2020 08:22:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13739C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 08:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F03DC87311
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 08:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id basB4qHcJFEd for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 08:22:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1CA778730C
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 08:22:51 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1601540555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONHqAv4qT+OTc2BgimstCJPvlJyn9PqWstJJf6uzEpc=;
 b=NgazHTI+SJGDs8egXRGtdo+QGi3xh0JlmycrGchBYrODbgZTjUWPuqO6ut+FnIDPq/gdSJ
 vByj+411k82ifrt2BEVuNPgqX27Y3wm+6Dmn4KcscKE05+QXauqWGac/+IkXdSlflKGPVQ
 gqO3sNFZEbbRG+38SCAe6Uy+7ikGtCs4oqeZOia8yJeiTw1hywgKpiq12HtknxenkgKzRe
 OJrPufOitZDre5pRXFtSqz9yo9w/AoYjWbk8swkUhUsvsq/Dr/oz8+/DUOp6P8ZPNkir9G
 eIp6uHls/G0PP4zrn3niGbMtU2e4Jej+7XYXpi+l/7lKt0TktRFbV900KLGnEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1601540555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONHqAv4qT+OTc2BgimstCJPvlJyn9PqWstJJf6uzEpc=;
 b=IOZyUThnP0eFdoTtp5uGay28riwQzj9H86PK6wCN00tcNvQN7l480emm6WUDFykV9hpp72
 zqYBI/TNYKqiSDAg==
To: Zi Yan <ziy@nvidia.com>
Subject: Re: Boot crash due to "x86/msi: Consolidate MSI allocation"
In-Reply-To: <A838FF2B-11FC-42B9-87D7-A76CF46E0575@nvidia.com>
References: <A838FF2B-11FC-42B9-87D7-A76CF46E0575@nvidia.com>
Date: Thu, 01 Oct 2020 10:22:35 +0200
Message-ID: <874knegxtg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 linux-pci@vger.kernel.org, x86@kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org
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

Yan,

On Wed, Sep 30 2020 at 21:29, Zi Yan wrote:
> I am running linux-next on my Dell R630 and the system crashed at boot
> time. I bisected linux-next and got to your commit:
>
>     x86/msi: Consolidate MSI allocation
>
> The crash log is below and my .config is attached.
>
> [   11.840905]  intel_get_irq_domain+0x24/0xb0
> [   11.840905]  native_setup_msi_irqs+0x3b/0x90

This is not really helpful because that's in the middle of the queue and
that code is gone at the very end. Yes, it's unfortunate that this
breaks bisection.

Can you please test:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq

which contains fixes and if it still crashes provide the dmesg of it.

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
