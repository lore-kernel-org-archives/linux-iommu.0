Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79022C4360F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:57:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C242146F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="SlpVczIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C242146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ED1FA255D;
	Fri,  5 Apr 2019 15:57:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A8B442555
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:56:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yw1-f67.google.com (mail-yw1-f67.google.com
	[209.85.161.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC643FD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:56:10 +0000 (UTC)
Received: by mail-yw1-f67.google.com with SMTP id p64so2477027ywg.7
	for <iommu@lists.linux-foundation.org>;
	Fri, 05 Apr 2019 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tycho-ws.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=ID62lT7CASQ5exKZNTIxim8rPMV7b2wqTWy85yy70pY=;
	b=SlpVczIJK4+1H51yrIy2XZfnWYtmEO8C77COIGAPUsvrvhaEM0m8FRrKyBqnM6gFHh
	F3pKmsq85ALP71H/Hr7DfbZ8ERn5miX69yKlGBvznyK7Oykz4AisHBQBGcsxJcUG3e8V
	Y9GcKXwN2Jft4Hs79HORZFiCCnnWZdcsXFw/K5B9RrtuKxwW38YvRvETy8pZArliOfSF
	Iujj9qL/OF1qJg9m9Y9O8zweIiE3YhQsn0MVqk0fLSK+F84epR/kbKkAlRlnk163SPa6
	gFJAQgCbFTOMEKLtMia6TzIf49M1a/iPDjXt7LlNXym4YY3YruwJ488KnrSc1wwqL85q
	/img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=ID62lT7CASQ5exKZNTIxim8rPMV7b2wqTWy85yy70pY=;
	b=q50d8c9fa8EZ2kxzyByzNtWZ4YZ4JuwmSDD4IjC7rYKufsMniZQUXyyS8ulO6Yw8gz
	SdOlzjC9w4ZOfz3FDhMSFijbpsN6bXc2vhZjr61eCibblBw7fHqvaaiZpZUeN7LG01X9
	+RJU3qxFzru7OpASRynmv3haXCnCfLTa3afgH8Ww+XdRGfnTd7MGlEgU+59fmBtVe/Pl
	52AseiQkUFk7orHtMPFRL56NHWPV3+0UQnvQ/lH49HCXtZHnyfak6uut07yR8HL0Tpsv
	9nWAqRpUyjPaUf60ghkf2J+QPCJBKMH3S2pPLAVH9PGtN+HkoJHFVLcHMTLsLORItpT5
	uN0Q==
X-Gm-Message-State: APjAAAW+dZfcnOPZmnFj9iRJNN14PzYCTO8ODnyq+QDpqU/Se9M3JtoX
	8G50crG9Z6gCous+BSSDLlSUHQ==
X-Google-Smtp-Source: APXvYqwxZtHhbIF6A9Haj7ZQVMb9g3SIesRmO9UXkoy0Zl2crMaGtC7JfWk4iUGJpTgrcq4z6Txlcw==
X-Received: by 2002:a81:69d5:: with SMTP id
	e204mr11030566ywc.267.1554479769927; 
	Fri, 05 Apr 2019 08:56:09 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:38ae:7ccc:265c:2d2c])
	by smtp.gmail.com with ESMTPSA id
	z193sm7435775ywa.70.2019.04.05.08.56.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 08:56:08 -0700 (PDT)
Date: Fri, 5 Apr 2019 09:56:03 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH v9 12/13] xpfo, mm: Defer TLB flushes for non-current
	CPUs (x86 only)
Message-ID: <20190405155603.GA12463@cisco>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
	<DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>, steven.sistare@oracle.com,
	Christoph Hellwig <hch@lst.de>, Andi Kleen <ak@linux.intel.com>,
	aneesh.kumar@linux.ibm.com, James Morris <jmorris@namei.org>,
	David Rientjes <rientjes@google.com>, anthony.yznaga@oracle.com,
	Rik van Riel <riel@surriel.com>, Nicholas Piggin <npiggin@gmail.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>, Joe Perches <joe@perches.com>,
	arunks@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Mark Rutland <mark.rutland@arm.com>, Keith Busch <keith.busch@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>, brgl@bgdev.pl,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	jsteckli@amazon.de, Joerg Roedel <jroedel@suse.de>,
	Kees Cook <keescook@google.com>, zhangshaokun@hisilicon.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Aaron Lu <aaron.lu@intel.com>,
	Steve Capper <steve.capper@arm.com>, James Morse <james.morse@arm.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@suse.cz>,
	Dave Hansen <dave.hansen@intel.com>, alexander.h.duyck@linux.intel.com,
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	kanth.ghatraju@oracle.com, Huang Ying <ying.huang@intel.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ben Hutchings <ben@decadent.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>,
	Arnd Bergmann <arnd@arndb.de>, Andrey Konovalov <andreyknvl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>, osalvador@suse.de,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	iommu@lists.linux-foundation.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Logan Gunthorpe <logang@deltatee.com>, Roman Gushchin <guro@fb.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Linux-MM <linux-mm@kvack.org>, deepa.srinivasan@oracle.com,
	cpandya@codeaurora.org, X86 ML <x86@kernel.org>,
	yaojun8558363@gmail.com, Ingo Molnar <mingo@redhat.com>,
	Jon Masters <jcm@redhat.com>, thymovanbeers@gmail.com,
	Laura Abbott <labbott@redhat.com>, pradeep.vincent@oracle.com,
	pavel.tatashin@microsoft.com, Jann Horn <jannh@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jim Mattson <jmattson@google.com>,
	Juergen Gross <jgross@suse.com>, marco.antonio.780@gmail.com,
	Juerg Haefliger <juergh@gmail.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tyler Hicks <tyhicks@canonical.com>, John Haxby <john.haxby@oracle.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, liran.alon@oracle.com,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405155603.3BNU-J7bS6Z8pkjRj_O5TGHRp4JdHsEgOVGPfbAoFzk@z>

T24gRnJpLCBBcHIgMDUsIDIwMTkgYXQgMDk6MjQ6NTBBTSAtMDYwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+IAo+IAo+ID4gT24gQXByIDUsIDIwMTksIGF0IDg6NDQgQU0sIERhdmUgSGFuc2Vu
IDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOgo+ID4gCj4gPiBPbiA0LzUvMTkgMTI6MTcg
QU0sIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiA+Pj4gcHJvY2Vzcy4gSXMgdGhhdCBhbiBhY2Nl
cHRhYmxlIHRyYWRlLW9mZj8KPiA+PiBZb3UgYXJlIG5vdCBzZXJpb3VzbHkgYXNraW5nIHdoZXRo
ZXIgY3JlYXRpbmcgYSB1c2VyIGNvbnRyb2xsYWJsZSByZXQyZGlyCj4gPj4gYXR0YWNrIHdpbmRv
dyBpcyBhIGFjY2VwdGFibGUgdHJhZGUtb2ZmPyBBcHJpbCAxc3Qgd2FzIGEgZmV3IGRheXMgYWdv
Lgo+ID4gCj4gPiBXZWxsLCBsZXQncyBub3QgZm9yZ2V0IHRoYXQgdGhpcyBzZXQgYXQgbGVhc3Qg
dGFrZXMgdXMgZnJvbSAiYWx3YXlzCj4gPiB2dWxuZXJhYmxlIHRvIHJldDJkaXIiIHRvIGEgY2hv
aWNlIGJldHdlZW46Cj4gPiAKPiA+IDEuIGZhc3QtaXNoIGFuZCAidnVsbmVyYWJsZSB0byByZXQy
ZGlyIGZvciBhIHVzZXItY29udHJvbGxhYmxlIHdpbmRvdyIKPiA+IDIuIHNsb3cgYW5kICJtaXRp
Z2F0ZWQgYWdhaW5zdCByZXQyZGlyIgo+ID4gCj4gPiBTb3VuZHMgbGlrZSB3ZSBuZWVkIGEgbWVj
aGFuaXNtIHRoYXQgd2lsbCBkbyB0aGUgZGVmZXJyZWQgWFBGTyBUTEIKPiA+IGZsdXNoZXMgd2hl
bmV2ZXIgdGhlIGtlcm5lbCBpcyBlbnRlcmVkLCBhbmQgbm90IF9qdXN0XyBhdCBjb250ZXh0IHN3
aXRjaAo+ID4gdGltZS4gIFRoaXMgcGVybWl0cyBhbiBhcHAgdG8gcnVuIGluIHVzZXJzcGFjZSB3
aXRoIHN0YWxlIGtlcm5lbCBUTEIKPiA+IGVudHJpZXMgYXMgbG9uZyBhcyBpdCB3YW50cy4uLiB0
aGF0J3MgaGFybWxlc3MuCj4gCj4gSSBkb27igJl0IHRoaW5rIHRoaXMgaXMgZ29vZCBlbm91Z2gu
IFRoZSBiYWQgZ3V5cyBjYW4gZW50ZXIgdGhlIGtlcm5lbCBhbmQgYXJyYW5nZSBmb3IgdGhlIGtl
cm5lbCB0byB3YWl0LCAqaW4ga2VybmVsKiwgZm9yIGxvbmcgZW5vdWdoIHRvIHNldCB1cCB0aGUg
YXR0YWNrLiAgdXNlcmZhdWx0ZmQgaXMgdGhlIG1vc3Qgb2J2aW91cyB3YXksIGJ1dCB0aGVyZSBh
cmUgcGxlbnR5LiBJIHN1cHBvc2Ugd2UgY291bGQgZG8gdGhlIGZsdXNoIGF0IGNvbnRleHQgc3dp
dGNoICphbmQqIGVudHJ5LiAgSSBiZXQgdGhhdCBwZXJmb3JtYW5jZSBzdGlsbCB1dHRlcmx5IHN1
Y2tzLCB0aG91Z2gg4oCUIG9uIG1hbnkgd29ya2xvYWRzLCB0aGlzIHR1cm5zIGV2ZXJ5IGVudHJ5
IGludG8gYSBmdWxsIGZsdXNoLCBhbmQgd2UgYWxyZWFkeSBrbm93IGV4YWN0bHkgaG93IG11Y2gg
dGhhdCBzdWNrcyDigJQgaXTigJlzIGlkZW50aWNhbCB0byBLUFRJIHdpdGhvdXQgUENJRC4gIChB
bmQgeWVzLCBpZiB3ZSBnbyB0aGlzIHJvdXRlLCB3ZSBuZWVkIHRvIG1lcmdlIHRoaXMgbG9naWMg
dG9nZXRoZXIg4oCUIHdlIHNob3VsZG7igJl0IHdyaXRlIENSMyB0d2ljZSBvbiBlbnRyeSkuCj4g
Cj4gSSBmZWVsIGxpa2UgdGhpcyB3aG9sZSBhcHByb2FjaCBpcyBtaXNndWlkZWQuIHJldDJkaXIg
aXMgbm90IHN1Y2ggYSBnYW1lIGNoYW5nZXIgdGhhdCBmaXhpbmcgaXQgaXMgd29ydGggaHVnZSBz
bG93ZG93bnMuIEkgdGhpbmsgYWxsIHRoaXMgZWZmb3J0IHNob3VsZCBiZSBzcGVudCBvbiBzb21l
IGtpbmQgb2Ygc2Vuc2libGUgQ0ZJLiBGb3IgZXhhbXBsZSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8g
bW9zdGx5IHNxdWFzaCByZXQyYW55dGhpbmcgYnkgaW5zZXJ0aW5nIGEgY2hlY2sgdGhhdCB0aGUg
aGlnaCBiaXRzIG9mIFJTUCBtYXRjaCB0aGUgdmFsdWUgb24gdGhlIHRvcCBvZiB0aGUgc3RhY2sg
YmVmb3JlIGFueSBjb2RlIHRoYXQgcG9wcyBSU1AuICBPbiBhbiBGUE8gYnVpbGQsIHRoZXJlIGFy
ZW7igJl0IGFsbCB0aGF0IG1hbnkgaG90IFBPUCBSU1AgaW5zdHJ1Y3Rpb25zLCBJIHRoaW5rLgo+
IAo+IChBY3R1YWxseSwgY2hlY2tpbmcgdGhlIGJpdHMgaXMgc3Vib3B0aW1hbC4gRG86Cj4gCj4g
dW5zaWduZWQgbG9uZyBvZmZzZXQgPSAqcnNwIC0gcnNwOwo+IG9mZnNldCA+Pj0gVEhSRUFEX1NI
SUZUOwo+IGlmICh1bmxpa2VseShvZmZzZXQpKQo+IEJVRygpOwo+IFBPUCBSU1A7CgpUaGlzIGlz
IGEgbmVhdCB0cmljaywgYW5kIGRlZmluaXRlbHkgcHJldmVudHMgZ29pbmcgcmFuZG9tIHBsYWNl
cyBpbgp0aGUgaGVhcC4gQnV0LAoKPiBUaGlzIG1lYW5zIHRoYXQgaXTigJlzIGFsc28gaW1wb3Nz
aWJsZSB0byB0cmljayBhIGZ1bmN0aW9uIHRvIHJldHVybiBpbnRvIGEgYnVmZmVyIHRoYXQgaXMg
b24gdGhhdCBmdW5jdGlvbuKAmXMgc3RhY2suKQoKV2h5IGlzIHRoaXMgdHJ1ZT8gQWxsIHlvdSdy
ZSBjaGVja2luZyBpcyB0aGF0IHlvdSBjYW4ndCBzaGlmdCB0aGUKImxvY2F0aW9uIiBvZiB0aGUg
c3RhY2suIElmIHlvdSBjYW4gaW5qZWN0IHN0dWZmIGludG8gYSBzdGFjayBidWZmZXIsCmNhbid0
IHlvdSBqdXN0IGluamVjdCB0aGUgcmlnaHQgZnJhbWUgdG8gcmV0dXJuIHRvIHlvdXIgY29kZSBh
cyB3ZWxsLApzbyB5b3UgZG9uJ3QgaGF2ZSB0byBzaGlmdCBsb2NhdGlvbnM/CgpUaGFua3MhCgpU
eWNobwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
