Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C71C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 22:30:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AD12087F
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 22:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AD12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC05F1D0C;
	Thu, 18 Apr 2019 22:30:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E01B21CD8
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 20:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD9EA466
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 20:22:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	18 Apr 2019 13:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; d="scan'208";a="141818813"
Received: from dytagah-mobl.amr.corp.intel.com ([10.254.15.29])
	by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2019 13:22:22 -0700
Message-ID: <a8b9954d0c0a6cc4c213ff65c9ec3795ed0a05ba.camel@linux.intel.com>
Subject: Re: [patch V2 20/29] tracing: Simplify stacktrace retrieval in
	histograms
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 18 Apr 2019 15:22:22 -0500
In-Reply-To: <20190418161342.34f4abca@gandalf.local.home>
References: <20190418084119.056416939@linutronix.de>
	<20190418084254.910579307@linutronix.de>
	<20190418094014.7d457f29@gandalf.local.home>
	<014a7564d606b249a5e50bef0fedf266977a935b.camel@linux.intel.com>
	<20190418161342.34f4abca@gandalf.local.home>
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
X-Mailman-Approved-At: Thu, 18 Apr 2019 22:30:27 +0000
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, David Sterba <dsterba@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190418202222.18iNoPISCZ3Mz0ez-4hC0-bzNUJ-asAwJosl1aO_rZE@z>

Hi Steve,

On Thu, 2019-04-18 at 16:13 -0400, Steven Rostedt wrote:
> On Thu, 18 Apr 2019 14:58:55 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > > Tom,
> > > 
> > > Can you review this too?  
> > 
> > Looks good to me too!
> > 
> > Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> 
> Would you be OK to upgrade this to a Reviewed-by tag?
> 

Yeah, I did review it and even tested it, so:

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Tom


> Thanks!
> 
> -- Steve

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
