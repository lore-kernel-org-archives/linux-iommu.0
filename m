Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811EC10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:06:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319FA218A6
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319FA218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2373514CC;
	Thu, 18 Apr 2019 09:06:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A9E3714A3
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:06:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 23CA3863
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:06:21 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH2zW-0001ls-Ty; Thu, 18 Apr 2019 11:05:59 +0200
Message-Id: <20190418084119.056416939@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 18 Apr 2019 10:41:19 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 00/29] stacktrace: Consolidate stack trace usage
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>, Chris Mason <clm@fb.com>,
	Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418084119.Mzj14KLiaJ1HUX35-4hOpJnp1dcPeLVoY8lpb-czZCo@z>

This is an update to V1:

 https://lkml.kernel.org/r/20190410102754.387743324@linutronix.de

Struct stack_trace is a sinkhole for input and output parameters which is
largely pointless for most usage sites. In fact if embedded into other data
structures it creates indirections and extra storage overhead for no
benefit.

Looking at all usage sites makes it clear that they just require an
interface which is based on a storage array. That array is either on stack,
global or embedded into some other data structure.

Some of the stack depot usage sites are outright wrong, but fortunately the
wrongness just causes more stack being used for nothing and does not have
functional impact.

Fix this up by:

  1) Providing plain storage array based interfaces for stacktrace and
     stackdepot.

  2) Cleaning up the mess at the callsites including some related
     cleanups.

  3) Removing the struct stack_trace based interfaces

  This is not yet changing the struct stack_trace interfaces at the
  architecture level, but it removes the exposure to the usage sites.

The last two patches are extending the cleanup to the architecture level by
replacing the various save_stack_trace.* architecture interfaces with a
more unified arch_stack_walk() interface. x86 is converted, but I have
worked through all architectures already and it removes lots of duplicated
code and allows consolidation across the board. The rest of the
architecture patches are not included in this posting as I want to get
feedback on the approach itself. The diffstat of cleaning up the remaining
architectures is currently on top of the current lot is:

   47 files changed, 402 insertions(+), 1196 deletions(-)

Once this has settled, the core interfaces can be improved by adding
features, which allow to get rid of the imprecise 'skip number of entries'
approach which tries to remove the stack tracer and the callsites themself
from the trace. That's error prone due to inlining and other issues. Having
e.g. a _RET_IP_ based filter allows to do that far more reliable.

The series is based on:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/stacktrace

which contains the removal of the inconsistent and pointless ULONG_MAX
termination of stacktraces.

It's also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/stacktrace

   up to:  131038eb3e2f ("x86/stacktrace: Use common infrastructure")

Changes vs. V1:

   - Applied the ULONG_MAX termination cleanup in tip

   - Addressed the review comments

   - Fixed up the last users of struct stack_trace outside the stacktrace
     core and architecture code (livepatch, tracing)

   - Added the new arch_stack_walk() model and converted x86 to it

Thanks,

	tglx

---
 arch/x86/Kconfig                              |    1 
 arch/x86/kernel/stacktrace.c                  |  116 +--------
 drivers/gpu/drm/drm_mm.c                      |   22 -
 drivers/gpu/drm/i915/i915_vma.c               |   11 
 drivers/gpu/drm/i915/intel_runtime_pm.c       |   21 -
 drivers/md/dm-bufio.c                         |   15 -
 drivers/md/persistent-data/dm-block-manager.c |   19 -
 fs/btrfs/ref-verify.c                         |   15 -
 fs/proc/base.c                                |   14 -
 include/linux/ftrace.h                        |   18 -
 include/linux/lockdep.h                       |    9 
 include/linux/stackdepot.h                    |    8 
 include/linux/stacktrace.h                    |   80 +++++-
 kernel/backtracetest.c                        |   11 
 kernel/dma/debug.c                            |   13 -
 kernel/latencytop.c                           |   17 -
 kernel/livepatch/transition.c                 |   22 -
 kernel/locking/lockdep.c                      |   81 ++----
 kernel/stacktrace.c                           |  323 ++++++++++++++++++++++++--
 kernel/trace/trace.c                          |  105 +++-----
 kernel/trace/trace.h                          |    8 
 kernel/trace/trace_events_hist.c              |   12 
 kernel/trace/trace_stack.c                    |   76 ++----
 lib/Kconfig                                   |    4 
 lib/fault-inject.c                            |   12 
 lib/stackdepot.c                              |   50 ++--
 mm/kasan/common.c                             |   30 --
 mm/kasan/report.c                             |    7 
 mm/kmemleak.c                                 |   24 -
 mm/page_owner.c                               |   79 ++----
 mm/slub.c                                     |   12 
 31 files changed, 664 insertions(+), 571 deletions(-)



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
