Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A03FC10F0F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:24:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174A92186A
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="utPoc6PE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174A92186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CF8F425AF;
	Fri,  5 Apr 2019 15:24:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7A24B2579
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:24:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E1B1834F
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:24:04 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id w23so3207954ply.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 05 Apr 2019 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amacapital-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=iGOCAhS0Nh0Q28F4cKGMxEhkILlnQQJc9LLSkn976ag=;
	b=utPoc6PENireic5FOXK/6gNlCZoHxLoVxXvIuWuV2Ldezt4oYNYBwGjH8t1h9Yythn
	NBMHVmJqsQiSSgLDIbxGelGGWG6PTrg17gPXjFFVs/bZNUfjI99ScPHiJH/n5asWnHTE
	pxNdiSFNyO4roPwGN23lMX2Kq+37RTiffPJuFlZpFzZur3TJegpdwYUlgYUr+m2i26gm
	W9XUIX1hCrY/7nA+NUxqTQO7hRs+NL4e2+3/cn/2OjM8JsqZQd2J5vN4EonJXxD2TV7C
	1PoI0If4qTkO1Kw+8RgLoJOuBc910yXQbM/NoefPRHlg97tXtOA6XN1KTxmL8UFx7IdR
	NTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=iGOCAhS0Nh0Q28F4cKGMxEhkILlnQQJc9LLSkn976ag=;
	b=Vf9UHN2WwPCr8DcF5FpSMZFrlRvXe5IKcWuAbC2D7Z/9HmVlG6HH7FT1QafRRIhcMa
	64UexFtIgpp8n2CzFGtrx10OxU17zMul8sFRKrhib1wPJKRBZrFw4VDqHhMYK58crc2d
	i+VjhrOEtbvQw/J0KeficyKuX5Nay5F7uJShTGo0yh7q7r484MR/Az+c6NdwoP8Lv2/v
	tRHtJEniGCAxSP3L+Tg+Em9zWITiVN/tK8/qi5kR27lu2/xckwCfyaO2ezrwtJUWupZW
	A4ps0WGd+YdBowszg2JWDgMb5R10F3dbiaHnvCF/OFkGH9NmNUkqPoJfJ6I9YncDulBc
	JMOA==
X-Gm-Message-State: APjAAAWw2QSYFgUuU52HmsKElfcAidh305b0kX283zc+lJIIExbVbuAX
	7O05d4tloa18zkpbLgkHqj94Gg==
X-Google-Smtp-Source: APXvYqxMP8hSJP5kyoEinr2wbSpbPq5dBS4iQHJvz9gcS8VG3LUoS2p3dEZlZaxIm7Q/ZUuQ39Skcg==
X-Received: by 2002:a17:902:1008:: with SMTP id
	b8mr13257931pla.120.1554477844312; 
	Fri, 05 Apr 2019 08:24:04 -0700 (PDT)
Received: from [100.91.160.246] (72.sub-174-208-6.myvzw.com. [174.208.6.72])
	by smtp.gmail.com with ESMTPSA id
	w10sm7488981pfi.126.2019.04.05.08.24.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 08:24:03 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 12/13] xpfo,
	mm: Defer TLB flushes for non-current CPUs (x86 only)
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
Date: Fri, 5 Apr 2019 09:24:01 -0600
Message-Id: <C1253C86-DD1F-469F-9B5E-ED7AA9FBEE4D@amacapital.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, steven.sistare@oracle.com,
	Christoph Hellwig <hch@lst.de>, Tycho Andersen <tycho@tycho.ws>,
	Andi Kleen <ak@linux.intel.com>, aneesh.kumar@linux.ibm.com,
	James Morris <jmorris@namei.org>,
	David Rientjes <rientjes@google.com>, anthony.yznaga@oracle.com,
	Rik van Riel <riel@surriel.com>, Nicholas Piggin <npiggin@gmail.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>, Joe Perches <joe@perches.com>,
	arunks@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
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
Message-ID: <20190405152401.09Tg5SOU4YLQ4aOp95oWHKv41_R8jw8mhACDQWlqOro@z>

Cgo+Pj4gT24gQXByIDQsIDIwMTksIGF0IDQ6NTUgUE0sIEtoYWxpZCBBeml6IDxraGFsaWQuYXpp
ekBvcmFjbGUuY29tPiB3cm90ZToKPj4+IAo+Pj4gT24gNC8zLzE5IDEwOjEwIFBNLCBBbmR5IEx1
dG9taXJza2kgd3JvdGU6Cj4+PiBPbiBXZWQsIEFwciAzLCAyMDE5IGF0IDEwOjM2IEFNIEtoYWxp
ZCBBeml6IDxraGFsaWQuYXppekBvcmFjbGUuY29tPiB3cm90ZToKPj4+IAo+Pj4gWFBGTyBmbHVz
aGVzIGtlcm5lbCBzcGFjZSBUTEIgZW50cmllcyBmb3IgcGFnZXMgdGhhdCBhcmUgbm93IG1hcHBl
ZAo+Pj4gaW4gdXNlcnNwYWNlIG9uIG5vdCBvbmx5IHRoZSBjdXJyZW50IENQVSBidXQgYWxzbyBh
bGwgb3RoZXIgQ1BVcwo+Pj4gc3luY2hyb25vdXNseS4gUHJvY2Vzc2VzIG9uIGVhY2ggY29yZSBh
bGxvY2F0aW5nIHBhZ2VzIGNhdXNlcyBhCj4+PiBmbG9vZCBvZiBJUEkgbWVzc2FnZXMgdG8gYWxs
IG90aGVyIGNvcmVzIHRvIGZsdXNoIFRMQiBlbnRyaWVzLgo+Pj4gTWFueSBvZiB0aGVzZSBtZXNz
YWdlcyBhcmUgdG8gZmx1c2ggdGhlIGVudGlyZSBUTEIgb24gdGhlIGNvcmUgaWYKPj4+IHRoZSBu
dW1iZXIgb2YgZW50cmllcyBiZWluZyBmbHVzaGVkIGZyb20gbG9jYWwgY29yZSBleGNlZWRzCj4+
PiB0bGJfc2luZ2xlX3BhZ2VfZmx1c2hfY2VpbGluZy4gVGhlIGNvc3Qgb2YgVExCIGZsdXNoIGNh
dXNlZCBieQo+Pj4gdW5tYXBwaW5nIHBhZ2VzIGZyb20gcGh5c21hcCBnb2VzIHVwIGRyYW1hdGlj
YWxseSBvbiBtYWNoaW5lcyB3aXRoCj4+PiBoaWdoIGNvcmUgY291bnQuCj4+PiAKPj4+IFRoaXMg
cGF0Y2ggZmx1c2hlcyByZWxldmFudCBUTEIgZW50cmllcyBmb3IgY3VycmVudCBwcm9jZXNzIG9y
Cj4+PiBlbnRpcmUgVExCIGRlcGVuZGluZyB1cG9uIG51bWJlciBvZiBlbnRyaWVzIGZvciB0aGUg
Y3VycmVudCBDUFUKPj4+IGFuZCBwb3N0cyBhIHBlbmRpbmcgVExCIGZsdXNoIG9uIGFsbCBvdGhl
ciBDUFVzIHdoZW4gYSBwYWdlIGlzCj4+PiB1bm1hcHBlZCBmcm9tIGtlcm5lbCBzcGFjZSBhbmQg
bWFwcGVkIGluIHVzZXJzcGFjZS4gRWFjaCBjb3JlCj4+PiBjaGVja3MgdGhlIHBlbmRpbmcgVExC
IGZsdXNoIGZsYWcgZm9yIGl0c2VsZiBvbiBldmVyeSBjb250ZXh0Cj4+PiBzd2l0Y2gsIGZsdXNo
ZXMgaXRzIFRMQiBpZiB0aGUgZmxhZyBpcyBzZXQgYW5kIGNsZWFycyBpdC4KPj4+IFRoaXMgcGF0
Y2ggcG90ZW50aWFsbHkgYWdncmVnYXRlcyBtdWx0aXBsZSBUTEIgZmx1c2hlcyBpbnRvIG9uZS4K
Pj4+IFRoaXMgaGFzIHZlcnkgc2lnbmlmaWNhbnQgaW1wYWN0IGVzcGVjaWFsbHkgb24gbWFjaGlu
ZXMgd2l0aCBsYXJnZQo+Pj4gY29yZSBjb3VudHMuCj4+IAo+PiBXaHkgaXMgdGhpcyBhIHJlYXNv
bmFibGUgc3RyYXRlZ3k/Cj4gCj4gSWRlYWxseSB3aGVuIHBhZ2VzIGFyZSB1bm1hcHBlZCBmcm9t
IHBoeXNtYXAsIGFsbCBDUFVzIHdvdWxkIGJlIHNlbnQgSVBJCj4gc3luY2hyb25vdXNseSB0byBm
bHVzaCBUTEIgZW50cnkgZm9yIHRob3NlIHBhZ2VzIGltbWVkaWF0ZWx5LiBUaGlzIG1heQo+IGJl
IGlkZWFsIGZyb20gY29ycmVjdG5lc3MgYW5kIGNvbnNpc3RlbmN5IHBvaW50IG9mIHZpZXcsIGJ1
dCBpdCBhbHNvCj4gcmVzdWx0cyBpbiBJUEkgc3Rvcm0gYW5kIHJlcGVhdGVkIFRMQiBmbHVzaGVz
IG9uIGFsbCBwcm9jZXNzb3JzLiBBbnkKPiB0aW1lIGEgcGFnZSBpcyBhbGxvY2F0ZWQgdG8gdXNl
cnNwYWNlLCB3ZSBhcmUgZ29pbmcgdG8gZ28gdGhyb3VnaCB0aGlzCj4gYW5kIGl0IGlzIHZlcnkg
ZXhwZW5zaXZlLiBPbiBhIDk2LWNvcmUgc2VydmVyLCBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbgo+
IGlzIDI2eCEhCgpJbmRlZWQuIFhQRk8gaXMgZXhwZW5zaXZlLgoKPiAKPiBXaGVuIHhwZm8gdW5t
YXBzIGEgcGFnZSBmcm9tIHBoeXNtYXAgb25seSAoYWZ0ZXIgbWFwcGluZyB0aGUgcGFnZSBpbgo+
IHVzZXJzcGFjZSBpbiByZXNwb25zZSB0byBhbiBhbGxvY2F0aW9uIHJlcXVlc3QgZnJvbSB1c2Vy
c3BhY2UpIG9uIG9uZQo+IHByb2Nlc3NvciwgdGhlcmUgaXMgYSBzbWFsbCB3aW5kb3cgb2Ygb3Bw
b3J0dW5pdHkgZm9yIHJldDJkaXIgYXR0YWNrIG9uCj4gb3RoZXIgY3B1cyB1bnRpbCB0aGUgVExC
IGVudHJ5IGluIHBoeXNtYXAgZm9yIHRoZSB1bm1hcHBlZCBwYWdlcyBvbgo+IG90aGVyIGNwdXMg
aXMgY2xlYXJlZC4KCldoeSBkbyB5b3UgdGhpbmsgdGhpcyB3aW5kb3cgaXMgc21hbGw/IEludGVy
dmFscyBvZiBzZWNvbmRzIHRvIG1vbnRocyBiZXR3ZWVuIGNvbnRleHQgc3dpdGNoZXMgYXJlbuKA
mXQgdW5oZWFyZCBvZi4KCkFuZCB3aHkgaXMgYSBzbWFsbCB3aW5kb3cgbGlrZSB0aGlzIGV2ZW4g
aGVscGZ1bD8gIEZvciBhIHJldDJkaXIgYXR0YWNrLCB5b3UganVzdCBuZWVkIHRvIGdldCBDUFUg
QSB0byBhbGxvY2F0ZSBhIHBhZ2UgYW5kIHdyaXRlIHRoZSByZXQyZGlyIHBheWxvYWQgYW5kIHRo
ZW4gZ2V0IENQVSBCIHRvIHJldHVybiB0byBpdCBiZWZvcmUgY29udGV4dCBzd2l0Y2hpbmcuICBU
aGlzIHNob3VsZCBiZSBkb2FibGUgcXVpdGUgcmVsaWFibHkuCgpTbyBJIGRvbuKAmXQgcmVhbGx5
IGhhdmUgYSBzdWdnZXN0aW9uLCBidXQgSSB0aGluayB0aGF0IGEgNDQlIHJlZ3Jlc3Npb24gdG8g
Z2V0IGEgd2VhayBkZWZlbnNlIGxpa2UgdGhpcyBkb2VzbuKAmXQgc2VlbSB3b3J0aHdoaWxlLiAg
SSBiZXQgdGhhdCBhbnkgb2YgYSBudW1iZXIgb2YgQ0ZJIHRlY2huaXF1ZXMgKFJBUC1saWtlIG9y
IG90aGVyd2lzZSkgd2lsbCBiZSBjaGVhcGVyIGFuZCBwcm90ZWN0IGFnYWluc3QgcmV0MmRpciBi
ZXR0ZXIuICBBbmQgdGhleeKAmWxsIGFsc28gcHJvdGVjdCBhZ2FpbnN0IHVzaW5nIG90aGVyIGtl
cm5lbCBtZW1vcnkgYXMgYSBzdGFjayBidWZmZXIuICBUaGVyZSBhcmUgcGxlbnR5IG9mIHRob3Nl
IOKAlCB0aGluayBwaXBlIGJ1ZmZlcnMsIG5ldHdvcmsgYnVmZmVycywgYW55IHBhZ2UgY2FjaGUg
bm90IGNvdmVyZWQgYnkgWFBGTywgWE1NL1lNTSBzYXZlZCBzdGF0ZSwgZXRjLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
