Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF9AC43461
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 18:12:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7259F2083B
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yn1ERvJR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dsVN9RWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7259F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A12287454;
	Thu,  3 Sep 2020 18:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8DE8IPH0rtg; Thu,  3 Sep 2020 18:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74FE087453;
	Thu,  3 Sep 2020 18:12:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69379C0052;
	Thu,  3 Sep 2020 18:12:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 911ABC0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 18:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6F50C2270C
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 18:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mU7MdDmg1o+L for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 18:12:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 978E120400
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 18:12:13 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1599156730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kNaEs04RarZatwvnCZYp8Xyjij0m0qzMj73pUrlORw4=;
 b=yn1ERvJRi3Ap+fUwpE6YE6QEJw75JqHwztjGLfuIu5Vhx3ylMcPaeZMvt5r7IvXcWh2dAh
 7+z/aBykT9nJNYFo4QDegWd1mhgggaPOZ01qE8hyd4uY+QT0PBl3pkiYuzKw4KK3iGrXUr
 14y2LCk2YypciaSpx/mGkXvE0yiU5PSMcNx6TYqrk1t9NAuNFM6JknEl8Xbx7SEbi8u2zu
 ThkvHpDONagjoyMhBYJuQeMvMbIjXzsUhAvsaYpyYEJPejQesbQQGHFRQP2bHdcIklQKao
 rCqIVG7cJWCK1a7UyFdTjAaJOvn/BS6CkMvwnJ9pnqFjjru6qQ8dggQ04IJkjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1599156730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kNaEs04RarZatwvnCZYp8Xyjij0m0qzMj73pUrlORw4=;
 b=dsVN9RWDW8rGNqnULQccYNxG7P4DgVJRNir2mvhT2bTe8IjmmCK2zcbya02NGrTVlYkNdL
 1dML9FSRvccDMDDw==
To: "Raj\, Ashok" <ashok.raj@intel.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <20200903163516.GA23129@araj-mobl1.jf.intel.com>
References: <20200826111628.794979401@linutronix.de>
 <20200903163516.GA23129@araj-mobl1.jf.intel.com>
Date: Thu, 03 Sep 2020 20:12:09 +0200
Message-ID: <87eeniybk6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Juergen Gross <jgross@suse.com>, Russ Anderson <rja@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

Ashok,

On Thu, Sep 03 2020 at 09:35, Ashok Raj wrote:
> On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
>> This is the second version of providing a base to support device MSI (non
>> PCI based) and on top of that support for IMS (Interrupt Message Storm)
>
> s/Storm/Store
>
> maybe pun intended :-)

Maybe? :)

>> based devices in a halfways architecture independent way.
>
> You mean "halfways" because the message addr and data follow guidelines
> per arch (x86 or such), but the location of the storage isn't dictated
> by architecture? or did you have something else in mind?

Yes, the actual message adress and data format are architecture
specific, but we also have x86 specific allocation info format which
needs an arch callback unfortunately.

>>    - Ensure that the necessary flags are set for device SMI
>
> is that supposed to be MSI? 

Of course, but SMI is a better match for Message Storm :)

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
