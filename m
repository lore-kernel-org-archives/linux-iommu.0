Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52638C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 17:54:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF1020727
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 17:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF1020727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9EA9C2E8F4;
	Fri, 15 May 2020 17:54:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25yf4p0vMBVA; Fri, 15 May 2020 17:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B6067258B9;
	Fri, 15 May 2020 17:54:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9599EC0859;
	Fri, 15 May 2020 17:54:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93097C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 17:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7BA382E8E5
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 17:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wME0YZqXWlGm for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 17:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 by silver.osuosl.org (Postfix) with ESMTPS id 33E75258B9
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 17:54:42 +0000 (UTC)
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 4EDBB736;
 Fri, 15 May 2020 17:54:39 +0000 (UTC)
Date: Fri, 15 May 2020 11:54:38 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 03/14] docs: fix references for DMA*.txt files
Message-ID: <20200515115438.52c119d7@lwn.net>
In-Reply-To: <0539f4b4b442dba92358b6c8d9e8fb5eafcec693.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
 <0539f4b4b442dba92358b6c8d9e8fb5eafcec693.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 David Howells <dhowells@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Logan Gunthorpe <logang@deltatee.com>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Alan Stern <stern@rowland.harvard.edu>, Allison Randal <allison@lohutok.net>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Daniel Lustig <dlustig@nvidia.com>,
 Andrea Parri <parri.andrea@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, SeongJae Park <sj38.park@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Luc Maranget <luc.maranget@inria.fr>, Thomas Gleixner <tglx@linutronix.de>,
 Tom Vaden <tom.vaden@hpe.com>,
 Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri,  1 May 2020 17:37:47 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> As we moved those files to core-api, fix references to point
> to their newer locations.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/PCI/pci.rst                          |  6 +++---
>  Documentation/block/biodoc.rst                     |  2 +-
>  Documentation/core-api/bus-virt-phys-mapping.rst   |  2 +-
>  Documentation/core-api/dma-api.rst                 |  6 +++---
>  Documentation/core-api/dma-isa-lpc.rst             |  2 +-
>  Documentation/driver-api/usb/dma.rst               |  6 +++---
>  Documentation/memory-barriers.txt                  |  6 +++---
>  .../translations/ko_KR/memory-barriers.txt         |  6 +++---
>  arch/ia64/hp/common/sba_iommu.c                    | 12 ++++++------
>  arch/parisc/kernel/pci-dma.c                       |  2 +-
>  arch/x86/include/asm/dma-mapping.h                 |  4 ++--
>  arch/x86/kernel/amd_gart_64.c                      |  2 +-
>  drivers/parisc/sba_iommu.c                         | 14 +++++++-------
>  include/linux/dma-mapping.h                        |  2 +-
>  include/media/videobuf-dma-sg.h                    |  2 +-
>  kernel/dma/debug.c                                 |  2 +-
>  16 files changed, 38 insertions(+), 38 deletions(-)

...of course, not applying patch 2 causes this one to not apply, so
holding off for now...

jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
