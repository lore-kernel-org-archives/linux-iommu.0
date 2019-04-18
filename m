Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73272C10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426F72183E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QYox3mHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426F72183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6F54B16EA;
	Thu, 18 Apr 2019 12:45:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8227A144D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 12:11:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D259D6C5
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 12:11:56 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id n4so1028010vsm.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=iSgCAvUEGOmkA7yqq7QK6OCH2CFcFcPt+JEh4ZctSK0=;
	b=QYox3mHSqW80j2A3IIiagUUBm09mZj02WRCKir6HBQx5T+b+hhAzGHQFOTwlONKbj+
	JJgyR/WQHwg8Cc7ukRkbYZ/f59+ReLAwpKS1zTzZMgMWjQjpa+NvSVrh8A8T3ceV7bLY
	uoXOMjV66AX9yM+yes+lXGolAtYtmsYKfcrPtWTFFr/7rqv9SEvseUou0t+cwv7s/iye
	TvT67Ae1wW9IHuwbcM5KGneuy8s3xRcKd0xOYCDyYWSzCvqtrVSm9//cPZFi/yYSzHlT
	1EQatPDgbrTsuxjhpE9ZcaOv8iSwAziw9Dkkkdizs+FhJMHfeZvWV03ILGIJlDd0RIEk
	lVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=iSgCAvUEGOmkA7yqq7QK6OCH2CFcFcPt+JEh4ZctSK0=;
	b=HXXdnjZgUf8iVzWRTU08b4Xl0MLxdl7qNYO3Bd9B304YsKlncLUa3jnrdSPPZKzeCM
	bKs43wQIHRWLY0QMjuISZudtea3Srs0xi/EqNc0D+ANsPvflsjt82dsL6pVIAnPiDLVG
	TB+w0j8S2e+X9xU01rpNquw3K9A8p7P0xva7LiQzz8um0liWwhZk06mry2tL8s7i431v
	w6wr0OAjj8gWAiHRzZWceLLDpXSXDyZ+qYPVLGaTP0tPF8ITjjshnKxcdlrL48YWgV2z
	Ci8SPRsSmRrOC8pmlMmBUTDKTwHBxkH884SMdYuWnsu80fAruZx8wkZe0ApAQwIZ3mAf
	R6Kw==
X-Gm-Message-State: APjAAAVYkXfGquTl84Uj8a5F38q0S1EcjEY6TqZqnmKGKLQPzK23+bvj
	1DBdfYky4kCg7OH1J6wS9lkizw/HVku3j3EdiBkg1A==
X-Google-Smtp-Source: APXvYqwECAvEJzUlV7fzRl9b6wg7o0AisQ+1RCTx/KeiR4GaCwP9nHgwP4vp46KXwzB2ZT6/gaSoiXLGbekHjekrJKI=
X-Received: by 2002:a67:e30a:: with SMTP id j10mr51098919vsf.103.1555589515631;
	Thu, 18 Apr 2019 05:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418084119.056416939@linutronix.de>
	<20190418084254.361284697@linutronix.de>
	<CAG_fn=WP9+bVv9hedoaTzWK+xBzedxaGJGVOPnF0o115s-oWvg@mail.gmail.com>
	<alpine.DEB.2.21.1904181353420.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904181353420.3174@nanos.tec.linutronix.de>
Date: Thu, 18 Apr 2019 14:11:44 +0200
Message-ID:
 <CAG_fn=WL0yLqavV_mhodT=B6KcAzJ+LS0hss1jqany9Cn92RHw@mail.gmail.com>
Subject: Re: [patch V2 14/29] dm bufio: Simplify stack trace retrieval
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailman-Approved-At: Thu, 18 Apr 2019 12:45:00 +0000
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	dm-devel@redhat.com, Christoph Lameter <cl@linux.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	linux-arch@vger.kernel.org, x86@kernel.org,
	kasan-dev <kasan-dev@googlegroups.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
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
From: Alexander Potapenko via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418121144.t0IfVahPVNkrJdg36Y2dSv7yU-ilzfBTVOLsieFfe48@z>

T24gVGh1LCBBcHIgMTgsIDIwMTkgYXQgMTo1NCBQTSBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6Cj4KPiBPbiBUaHUsIDE4IEFwciAyMDE5LCBBbGV4YW5kZXIgUG90
YXBlbmtvIHdyb3RlOgo+ID4gT24gVGh1LCBBcHIgMTgsIDIwMTkgYXQgMTE6MDYgQU0gVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOgo+ID4gPiAtICAgICAgIHNhdmVf
c3RhY2tfdHJhY2UoJmItPnN0YWNrX3RyYWNlKTsKPiA+ID4gKyAgICAgICBiLT5zdGFja19sZW4g
PSBzdGFja190cmFjZV9zYXZlKGItPnN0YWNrX2VudHJpZXMsIE1BWF9TVEFDSywgMik7Cj4gPiBB
cyBub3RlZCBpbiBvbmUgb2Ygc2ltaWxhciBwYXRjaGVzIGJlZm9yZSwgY2FuIHdlIGhhdmUgYW4g
aW5saW5lCj4gPiBjb21tZW50IHRvIGluZGljYXRlIHdoYXQgZG9lcyB0aGlzICIyIiBzdGFuZCBm
b3I/Cj4KPiBDb21lIG9uLiBXZSBoYXZlIGdhemlsbGlvbiBvZiBmdW5jdGlvbnMgd2hpY2ggdGFr
ZSBudW1lcmljYWwgY29uc3RhbnQKPiBhcmd1bWVudHMuIFNob3VsZCB3ZSBhZGQgY29tbWVudHMg
dG8gYWxsIG9mIHRoZW0/Ck9rLCBzb3JyeS4gSSBtaWdodCBub3QgYmUgZmFtaWxpYXIgZW5vdWdo
IHdpdGggdGhlIGtlcm5lbCBzdHlsZSBndWlkZS4KPiBUaGFua3MsCj4KPiAgICAgICAgIHRnbHgK
CgoKLS0gCkFsZXhhbmRlciBQb3RhcGVua28KU29mdHdhcmUgRW5naW5lZXIKCkdvb2dsZSBHZXJt
YW55IEdtYkgKRXJpa2EtTWFubi1TdHJhw59lLCAzMwo4MDYzNiBNw7xuY2hlbgoKR2VzY2jDpGZ0
c2bDvGhyZXI6IFBhdWwgTWFuaWNsZSwgSGFsaW1haCBEZUxhaW5lIFByYWRvClJlZ2lzdGVyZ2Vy
aWNodCB1bmQgLW51bW1lcjogSGFtYnVyZywgSFJCIDg2ODkxClNpdHogZGVyIEdlc2VsbHNjaGFm
dDogSGFtYnVyZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
