Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F5C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 21:15:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D398214C6
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 21:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D398214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0137A1D0C;
	Thu, 18 Apr 2019 21:15:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 83028179D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 21:15:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 30687466
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 21:15:10 +0000 (UTC)
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hHEMp-0006bb-27; Thu, 18 Apr 2019 23:14:47 +0200
Date: Thu, 18 Apr 2019 23:14:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 01/29] tracing: Cleanup stack trace code
In-Reply-To: <20190418135721.5vwd6ngxagrrrrtt@treble>
Message-ID: <alpine.DEB.2.21.1904182313470.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084253.142712304@linutronix.de>
	<20190418135721.5vwd6ngxagrrrrtt@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	David Rientjes <rientjes@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>, Chris Mason <clm@fb.com>,
	LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
	iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-btrfs@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418211445.raNfdJ_3dNKd2QiIsrYwTPu-me7PPfjE_YVfOxFAf7A@z>

On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> On Thu, Apr 18, 2019 at 10:41:20AM +0200, Thomas Gleixner wrote:
> > - Remove the extra array member of stack_dump_trace[]. It's not required as
> >   the stack tracer stores at max array size - 1 entries so there is still
> >   an empty slot.
> 
> What is the empty slot used for?

I was trying to find an answer but failed. Maybe it's just historical
leftovers or Steven knows where the magic is in this maze.

Thanks,

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
