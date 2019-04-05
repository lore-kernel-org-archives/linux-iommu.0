Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D5BC282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:33:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EEC2146F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WdLx0/KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EEC2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3D0842598;
	Fri,  5 Apr 2019 16:33:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ABBB02539
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:32:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4F9697F8
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:32:27 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id e24so3545412pfi.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 05 Apr 2019 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amacapital-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=kqcsrGTilJy4opNk7wpYgFnO9IX3q48oZ/se5d5Fh+A=;
	b=WdLx0/KSwL1WPu0snge32d6ZIdnUb3H6+B8O/RsVHhTweSt1p0DmoQfz2aWHWXhqas
	qo9Qemwz68tIaLAbZfwwo5CEcCjX0wtAsMDdgR2qlrZTKEkpZfPUpVRB9zkF3o/dZqzH
	DCiBYIZd1Wwd0tVhc+aIFGdw7GsagvAyHDz6bHzh3Gcx/tVZawPXNV0HZkqFPmSR6LGp
	kaWSbtOLyhQJxDPI+WIXNQZrDVVs1UFhRkQzV7feG5nviaCaAvjENz5ZKRzEhzeFanRw
	1uMXQuJizl4OetjSa0HD8AqfSYjRImGT2t3GkqEiTzAt2oA3jwK5bK4Kp/+dxyPhQk1q
	ww9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=kqcsrGTilJy4opNk7wpYgFnO9IX3q48oZ/se5d5Fh+A=;
	b=i8hxLvt7XVvWT1UDdeFfywEjj4lPRvU9ynAbMvs2C9Y7RqxoZ3CSgSNlOe19YE7S60
	bglBCvANxBDBmsqs4wK4qITVd5DnIR4FpifWZxACJO0btsr8o2sdNGLoSpKy8jhbo0Y1
	1usW11NrLtM2Y6+x760jYtGRA2r5sVUFJbcv8G222O02cbTQRs2ILC1ctj0AIfCvOV5O
	jivi8egtIKriAVSg1vcP0fBfRoCAB1YXnmFfG6vQdNUbAOJrTc8VoYPxpLw+psxNr924
	dD2pcrxi2PhMGRMh3e6IFbQVJ/UqVqv6pjtR7T97m6E57TPL27tdlHOESS4iVNxU8w5M
	xShA==
X-Gm-Message-State: APjAAAWSPofPbA8qfeOoZexWIkLXWTJ+yjB+0JYsYzohc4mByvzkIowO
	FqHdKTtrGJlnnVDsIK/ZvbFeeg==
X-Google-Smtp-Source: APXvYqygLiIChVcG2YU1rQkegW7uT2rvBBY5X3TPt/OOf0cq8B55fxMm9uUFI8xhMC+YNFeDkf7Tvw==
X-Received: by 2002:a63:2045:: with SMTP id r5mr13119100pgm.394.1554481946639; 
	Fri, 05 Apr 2019 09:32:26 -0700 (PDT)
Received: from ?IPv6:2600:100e:b12a:ccdd:512d:55a6:36a5:bcd4?
	([2600:100e:b12a:ccdd:512d:55a6:36a5:bcd4])
	by smtp.gmail.com with ESMTPSA id
	p2sm74419465pfi.73.2019.04.05.09.32.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 09:32:25 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 12/13] xpfo,
	mm: Defer TLB flushes for non-current CPUs (x86 only)
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190405155603.GA12463@cisco>
Date: Fri, 5 Apr 2019 10:32:17 -0600
Message-Id: <54380A49-2D32-46BE-AF30-A9930F461FCE@amacapital.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
	<DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
	<20190405155603.GA12463@cisco>
To: Tycho Andersen <tycho@tycho.ws>
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
Message-ID: <20190405163217.EUYwtahD_DYrdmqheosKSwoz44sjm3Goq2Ys6ac0rqY@z>

Cgo+IE9uIEFwciA1LCAyMDE5LCBhdCA5OjU2IEFNLCBUeWNobyBBbmRlcnNlbiA8dHljaG9AdHlj
aG8ud3M+IHdyb3RlOgo+IAo+PiBPbiBGcmksIEFwciAwNSwgMjAxOSBhdCAwOToyNDo1MEFNIC0w
NjAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+IAo+PiAKPj4+IE9uIEFwciA1LCAyMDE5LCBh
dCA4OjQ0IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiB3cm90ZToKPj4+
IAo+Pj4gT24gNC81LzE5IDEyOjE3IEFNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+Pj4+IHBy
b2Nlc3MuIElzIHRoYXQgYW4gYWNjZXB0YWJsZSB0cmFkZS1vZmY/Cj4+Pj4gWW91IGFyZSBub3Qg
c2VyaW91c2x5IGFza2luZyB3aGV0aGVyIGNyZWF0aW5nIGEgdXNlciBjb250cm9sbGFibGUgcmV0
MmRpcgo+Pj4+IGF0dGFjayB3aW5kb3cgaXMgYSBhY2NlcHRhYmxlIHRyYWRlLW9mZj8gQXByaWwg
MXN0IHdhcyBhIGZldyBkYXlzIGFnby4KPj4+IAo+Pj4gV2VsbCwgbGV0J3Mgbm90IGZvcmdldCB0
aGF0IHRoaXMgc2V0IGF0IGxlYXN0IHRha2VzIHVzIGZyb20gImFsd2F5cwo+Pj4gdnVsbmVyYWJs
ZSB0byByZXQyZGlyIiB0byBhIGNob2ljZSBiZXR3ZWVuOgo+Pj4gCj4+PiAxLiBmYXN0LWlzaCBh
bmQgInZ1bG5lcmFibGUgdG8gcmV0MmRpciBmb3IgYSB1c2VyLWNvbnRyb2xsYWJsZSB3aW5kb3ci
Cj4+PiAyLiBzbG93IGFuZCAibWl0aWdhdGVkIGFnYWluc3QgcmV0MmRpciIKPj4+IAo+Pj4gU291
bmRzIGxpa2Ugd2UgbmVlZCBhIG1lY2hhbmlzbSB0aGF0IHdpbGwgZG8gdGhlIGRlZmVycmVkIFhQ
Rk8gVExCCj4+PiBmbHVzaGVzIHdoZW5ldmVyIHRoZSBrZXJuZWwgaXMgZW50ZXJlZCwgYW5kIG5v
dCBfanVzdF8gYXQgY29udGV4dCBzd2l0Y2gKPj4+IHRpbWUuICBUaGlzIHBlcm1pdHMgYW4gYXBw
IHRvIHJ1biBpbiB1c2Vyc3BhY2Ugd2l0aCBzdGFsZSBrZXJuZWwgVExCCj4+PiBlbnRyaWVzIGFz
IGxvbmcgYXMgaXQgd2FudHMuLi4gdGhhdCdzIGhhcm1sZXNzLgo+PiAKPj4gSSBkb27igJl0IHRo
aW5rIHRoaXMgaXMgZ29vZCBlbm91Z2guIFRoZSBiYWQgZ3V5cyBjYW4gZW50ZXIgdGhlIGtlcm5l
bCBhbmQgYXJyYW5nZSBmb3IgdGhlIGtlcm5lbCB0byB3YWl0LCAqaW4ga2VybmVsKiwgZm9yIGxv
bmcgZW5vdWdoIHRvIHNldCB1cCB0aGUgYXR0YWNrLiAgdXNlcmZhdWx0ZmQgaXMgdGhlIG1vc3Qg
b2J2aW91cyB3YXksIGJ1dCB0aGVyZSBhcmUgcGxlbnR5LiBJIHN1cHBvc2Ugd2UgY291bGQgZG8g
dGhlIGZsdXNoIGF0IGNvbnRleHQgc3dpdGNoICphbmQqIGVudHJ5LiAgSSBiZXQgdGhhdCBwZXJm
b3JtYW5jZSBzdGlsbCB1dHRlcmx5IHN1Y2tzLCB0aG91Z2gg4oCUIG9uIG1hbnkgd29ya2xvYWRz
LCB0aGlzIHR1cm5zIGV2ZXJ5IGVudHJ5IGludG8gYSBmdWxsIGZsdXNoLCBhbmQgd2UgYWxyZWFk
eSBrbm93IGV4YWN0bHkgaG93IG11Y2ggdGhhdCBzdWNrcyDigJQgaXTigJlzIGlkZW50aWNhbCB0
byBLUFRJIHdpdGhvdXQgUENJRC4gIChBbmQgeWVzLCBpZiB3ZSBnbyB0aGlzIHJvdXRlLCB3ZSBu
ZWVkIHRvIG1lcmdlIHRoaXMgbG9naWMgdG9nZXRoZXIg4oCUIHdlIHNob3VsZG7igJl0IHdyaXRl
IENSMyB0d2ljZSBvbiBlbnRyeSkuCj4+IAo+PiBJIGZlZWwgbGlrZSB0aGlzIHdob2xlIGFwcHJv
YWNoIGlzIG1pc2d1aWRlZC4gcmV0MmRpciBpcyBub3Qgc3VjaCBhIGdhbWUgY2hhbmdlciB0aGF0
IGZpeGluZyBpdCBpcyB3b3J0aCBodWdlIHNsb3dkb3ducy4gSSB0aGluayBhbGwgdGhpcyBlZmZv
cnQgc2hvdWxkIGJlIHNwZW50IG9uIHNvbWUga2luZCBvZiBzZW5zaWJsZSBDRkkuIEZvciBleGFt
cGxlLCB3ZSBzaG91bGQgYmUgYWJsZSB0byBtb3N0bHkgc3F1YXNoIHJldDJhbnl0aGluZyBieSBp
bnNlcnRpbmcgYSBjaGVjayB0aGF0IHRoZSBoaWdoIGJpdHMgb2YgUlNQIG1hdGNoIHRoZSB2YWx1
ZSBvbiB0aGUgdG9wIG9mIHRoZSBzdGFjayBiZWZvcmUgYW55IGNvZGUgdGhhdCBwb3BzIFJTUC4g
IE9uIGFuIEZQTyBidWlsZCwgdGhlcmUgYXJlbuKAmXQgYWxsIHRoYXQgbWFueSBob3QgUE9QIFJT
UCBpbnN0cnVjdGlvbnMsIEkgdGhpbmsuCj4+IAo+PiAoQWN0dWFsbHksIGNoZWNraW5nIHRoZSBi
aXRzIGlzIHN1Ym9wdGltYWwuIERvOgo+PiAKPj4gdW5zaWduZWQgbG9uZyBvZmZzZXQgPSAqcnNw
IC0gcnNwOwo+PiBvZmZzZXQgPj49IFRIUkVBRF9TSElGVDsKPj4gaWYgKHVubGlrZWx5KG9mZnNl
dCkpCj4+IEJVRygpOwo+PiBQT1AgUlNQOwo+IAo+IFRoaXMgaXMgYSBuZWF0IHRyaWNrLCBhbmQg
ZGVmaW5pdGVseSBwcmV2ZW50cyBnb2luZyByYW5kb20gcGxhY2VzIGluCj4gdGhlIGhlYXAuIEJ1
dCwKPiAKPj4gVGhpcyBtZWFucyB0aGF0IGl04oCZcyBhbHNvIGltcG9zc2libGUgdG8gdHJpY2sg
YSBmdW5jdGlvbiB0byByZXR1cm4gaW50byBhIGJ1ZmZlciB0aGF0IGlzIG9uIHRoYXQgZnVuY3Rp
b27igJlzIHN0YWNrLikKPiAKPiBXaHkgaXMgdGhpcyB0cnVlPyBBbGwgeW91J3JlIGNoZWNraW5n
IGlzIHRoYXQgeW91IGNhbid0IHNoaWZ0IHRoZQo+ICJsb2NhdGlvbiIgb2YgdGhlIHN0YWNrLiBJ
ZiB5b3UgY2FuIGluamVjdCBzdHVmZiBpbnRvIGEgc3RhY2sgYnVmZmVyLAo+IGNhbid0IHlvdSBq
dXN0IGluamVjdCB0aGUgcmlnaHQgZnJhbWUgdG8gcmV0dXJuIHRvIHlvdXIgY29kZSBhcyB3ZWxs
LAo+IHNvIHlvdSBkb24ndCBoYXZlIHRvIHNoaWZ0IGxvY2F0aW9ucz8KPiAKPiAKCkJ1dCB0aGUg
aW5qZWN0ZWQgUk9QIHBheWxvYWQgd2lsbCBiZSAqYmVsb3cqIFJTUCwgc28geW914oCZbGwgbmVl
ZCBhIGdhZGdldCB0aGF0IGNhbiBkZWNyZW1lbnQgUlNQLiAgVGhpcyBtYWtlcyB0aGUgYXR0YWNr
IGEgZ29vZCBkZWFsIGhhcmRlci4KClNvbWV0aGluZyBsaWtlIFJBUCBvbiB0b3AsIG9yIENFVCwg
d2lsbCBtYWtlIHRoaXMgZXZlbiBoYXJkZXIuCgo+IAo+IFR5Y2hvCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
