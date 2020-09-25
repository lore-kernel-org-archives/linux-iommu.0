Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E578C4727E
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 23:14:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1480921D7F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 23:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O8WigxqA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qe4V7bKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1480921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82ACB8766F;
	Fri, 25 Sep 2020 23:14:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPJwZlLWrqE2; Fri, 25 Sep 2020 23:14:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB89C87603;
	Fri, 25 Sep 2020 23:14:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF5A5C0891;
	Fri, 25 Sep 2020 23:14:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C781BC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 23:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AF22586DB0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 23:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m3iFG-UTNoRi for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 23:14:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1992686222
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 23:14:23 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1601075659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hfCJknL7vN5FQ7E5rBJUvr3Ui/JGPGdNK+KMG+iROA=;
 b=O8WigxqARtdurkJ3wZLtFlOVp/IJYLWjDmhmQmul4Jh1+/tu2tcAC1TQqLvZ7X6XtgAJUn
 eOxJOrPLqDp0AFlhrf9ICCES57zKrQJtWeBw+enhlvFsmhVrk/PIHUraubnLUB8YFVD3EU
 aO+sAe/6qmqsJ4/w9ay6UGJ7n4LbTG7vauQWZ+EMoZO0h8etOCXCfxiQH5btgeOiQSreV3
 mVGp6pGYXUixpnIECzjY39qztquc0ZKZJGi+8R9bz6K81QFII/mn3LRxC2GMX7eONSPEt0
 XqZWoOf+IOa80v+JeOxpuuaVtH3FZsqK9XZ5peTSl+Dt7ASOi02SLO6a+QW6sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1601075659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hfCJknL7vN5FQ7E5rBJUvr3Ui/JGPGdNK+KMG+iROA=;
 b=qe4V7bKcqNpxkkupSUaXGl+NgWRwWilYYeYK3x3W8R47Rqr4/aCDpm5Xt3BubAKjEHc4Tr
 Du8N8X29kfg+K2Ag==
To: Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@redhat.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <20200925154937.GL29142@worktop.programming.kicks-ass.net>
References: <20200826111628.794979401@linutronix.de>
 <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com>
 <20200925154937.GL29142@worktop.programming.kicks-ass.net>
Date: Sat, 26 Sep 2020 01:14:18 +0200
Message-ID: <87tuvltpo5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-next@vger.kernel.org,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Fri, Sep 25 2020 at 17:49, Peter Zijlstra wrote:
> Here it looks like this:
>
> [    1.830276] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.838043] #PF: supervisor instruction fetch in kernel mode
> [    1.844357] #PF: error_code(0x0010) - not-present page
> [    1.850090] PGD 0 P4D 0
> [    1.852915] Oops: 0010 [#1] SMP
> [    1.856419] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc6-00700-g0248dedd12d4 #419
> [    1.865447] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
> [    1.876902] RIP: 0010:0x0
> [    1.879824] Code: Bad RIP value.
> [    1.883423] RSP: 0000:ffffffff82803da0 EFLAGS: 00010282
> [    1.889251] RAX: 0000000000000000 RBX: ffffffff8282b980 RCX: ffffffff82803e40
> [    1.897241] RDX: 0000000000000001 RSI: ffffffff82803e40 RDI: ffffffff8282b980
> [    1.905201] RBP: ffff88842f331000 R08: 00000000ffffffff R09: 0000000000000001
> [    1.913162] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000048
> [    1.921123] R13: ffffffff82803e40 R14: ffffffff8282b9c0 R15: 0000000000000000
> [    1.929085] FS:  0000000000000000(0000) GS:ffff88842f400000(0000) knlGS:0000000000000000
> [    1.938113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.944524] CR2: ffffffffffffffd6 CR3: 0000000002811001 CR4: 00000000000606b0
> [    1.952484] Call Trace:
> [    1.955214]  msi_domain_alloc+0x36/0x130

Hrm. That looks like a not initialized mandatory callback. Confused.

Is this on -next and if so, does this happen on tip:x86/irq as well?

Can you provide yoru config please?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
