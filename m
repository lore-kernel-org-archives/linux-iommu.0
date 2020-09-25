Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D93BC4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 15:50:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7534121D7A
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 15:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jsCuR452"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7534121D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EFC7887624;
	Fri, 25 Sep 2020 15:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BbQOABJwfbU; Fri, 25 Sep 2020 15:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54BF38761C;
	Fri, 25 Sep 2020 15:50:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A0EDC0859;
	Fri, 25 Sep 2020 15:50:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B66F1C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 15:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A31E886E41
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 15:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dnI10k6f5fZu for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 15:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 60FE886E3E
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vetmaFlRbxjG1gdDdh98OoTp5N216Sm8DYU37hXmY/4=; b=jsCuR452EgU0sos8kOsxSDr7R3
 +WnE00/9rj4OSw7HiifYWzMSz2zCXDKSUbj6zfwWTttYV1qOL4NJ7f5lcASVzcTd5ei+SEDvdISkd
 7R87MMZAzYQMltLhqaAbg9lfweLZSGGYhkQUycDhiQMudOoCFc5Sc4Hv+bRvfmWW583ncfRKpGi4d
 pkVo7M/zFgkSpXPR2Qtvwe6TRceX8ehOHPs2SB63y8/Tny+ju3buF7EDRpQAP2dNR9M6VCpZ8LTnI
 uZSijMScB44GmbgqKAHg07k2n+ktUQpuaHgqXOQ8do64DP8NSLMDvzFg46Pel/9/eRlCTefHa0uA+
 XnrXREfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLpyf-000281-Sm; Fri, 25 Sep 2020 15:49:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 046FF980DC7; Fri, 25 Sep 2020 17:49:37 +0200 (CEST)
Date: Fri, 25 Sep 2020 17:49:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qian Cai <cai@redhat.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
Message-ID: <20200925154937.GL29142@worktop.programming.kicks-ass.net>
References: <20200826111628.794979401@linutronix.de>
 <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
 Thomas Gleixner <tglx@linutronix.de>, Jon Derrick <jonathan.derrick@intel.com>,
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

On Fri, Sep 25, 2020 at 11:29:13AM -0400, Qian Cai wrote:

> It looks like the crashes happen in the interrupt remapping code where they are
> only able to to generate partial call traces.

> [    8.466614][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    8.474295][    T0] #PF: supervisor instruction fetch in kernel mode
> [    8.480669][    T0] #PF: error_code(0x0010) - not-present page
> [    8.486518][    T0] PGD 0 P4D 0 
> [    8.489757][    T0] Oops: 0010 [#1] SMP KASAN PTI
> [    8.494476][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G          I       5.9.0-rc6-next-20200925 #2
> [    8.503987][    T0] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
> [    8.513238][    T0] RIP: 0010:0x0
> [    8.516562][    T0] Code: Bad RIP v

Here it looks like this:

[    1.830276] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.838043] #PF: supervisor instruction fetch in kernel mode
[    1.844357] #PF: error_code(0x0010) - not-present page
[    1.850090] PGD 0 P4D 0
[    1.852915] Oops: 0010 [#1] SMP
[    1.856419] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc6-00700-g0248dedd12d4 #419
[    1.865447] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
[    1.876902] RIP: 0010:0x0
[    1.879824] Code: Bad RIP value.
[    1.883423] RSP: 0000:ffffffff82803da0 EFLAGS: 00010282
[    1.889251] RAX: 0000000000000000 RBX: ffffffff8282b980 RCX: ffffffff82803e40
[    1.897241] RDX: 0000000000000001 RSI: ffffffff82803e40 RDI: ffffffff8282b980
[    1.905201] RBP: ffff88842f331000 R08: 00000000ffffffff R09: 0000000000000001
[    1.913162] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000048
[    1.921123] R13: ffffffff82803e40 R14: ffffffff8282b9c0 R15: 0000000000000000
[    1.929085] FS:  0000000000000000(0000) GS:ffff88842f400000(0000) knlGS:0000000000000000
[    1.938113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.944524] CR2: ffffffffffffffd6 CR3: 0000000002811001 CR4: 00000000000606b0
[    1.952484] Call Trace:
[    1.955214]  msi_domain_alloc+0x36/0x130
[    1.959594]  __irq_domain_alloc_irqs+0x165/0x380
[    1.964748]  dmar_alloc_hwirq+0x9a/0x120
[    1.969127]  dmar_set_interrupt.part.0+0x1c/0x60
[    1.974281]  enable_drhd_fault_handling+0x2c/0x6c
[    1.979532]  apic_intr_mode_init+0xfa/0x100
[    1.984191]  x86_late_time_init+0x20/0x30
[    1.988662]  start_kernel+0x723/0x7e6
[    1.992748]  secondary_startup_64_no_verify+0xa6/0xab
[    1.998386] Modules linked in:
[    2.001794] CR2: 0000000000000000
[    2.005510] ---[ end trace 837dc60d7c66efa2 ]---

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
