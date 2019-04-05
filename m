Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C0C4360F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:02:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802072175B
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802072175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A0512583;
	Fri,  5 Apr 2019 16:02:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6A27A2561
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:01:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E612F7ED
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:01:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Apr 2019 09:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; d="scan'208";a="128936257"
Received: from skchinnx-mobl.amr.corp.intel.com (HELO [10.254.86.198])
	([10.254.86.198])
	by orsmga007.jf.intel.com with ESMTP; 05 Apr 2019 09:01:23 -0700
Subject: Re: [RFC PATCH v9 12/13] xpfo, mm: Defer TLB flushes for non-current
	CPUs (x86 only)
To: Andy Lutomirski <luto@amacapital.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
	<DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
	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
Message-ID: <36b999d4-adf6-08a3-2897-d77b9cba20f8@intel.com>
Date: Fri, 5 Apr 2019 09:01:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
Content-Language: en-US
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>, steven.sistare@oracle.com,
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
	Mike Kravetz <mike.kravetz@oracle.com>,
	Michal Hocko <mhocko@suse.cz>, alexander.h.duyck@linux.intel.com,
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
Message-ID: <20190405160123.1kdeOEgGvWQw63LZDixZJJFhD3zshiXRZfYLpkZdxQw@z>

T24gNC81LzE5IDg6MjQgQU0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToKPj4gU291bmRzIGxpa2Ug
d2UgbmVlZCBhIG1lY2hhbmlzbSB0aGF0IHdpbGwgZG8gdGhlIGRlZmVycmVkIFhQRk8gVExCIAo+
PiBmbHVzaGVzIHdoZW5ldmVyIHRoZSBrZXJuZWwgaXMgZW50ZXJlZCwgYW5kIG5vdCBfanVzdF8g
YXQgY29udGV4dAo+PiBzd2l0Y2ggdGltZS4gIFRoaXMgcGVybWl0cyBhbiBhcHAgdG8gcnVuIGlu
IHVzZXJzcGFjZSB3aXRoIHN0YWxlCj4+IGtlcm5lbCBUTEIgZW50cmllcyBhcyBsb25nIGFzIGl0
IHdhbnRzLi4uIHRoYXQncyBoYXJtbGVzcy4KLi4uCj4gSSBzdXBwb3NlIHdlIGNvdWxkIGRvIHRo
ZSBmbHVzaCBhdCBjb250ZXh0IHN3aXRjaCAqYW5kKgo+IGVudHJ5LiAgSSBiZXQgdGhhdCBwZXJm
b3JtYW5jZSBzdGlsbCB1dHRlcmx5IHN1Y2tzLCB0aG91Z2gg4oCUIG9uIG1hbnkKPiB3b3JrbG9h
ZHMsIHRoaXMgdHVybnMgZXZlcnkgZW50cnkgaW50byBhIGZ1bGwgZmx1c2gsIGFuZCB3ZSBhbHJl
YWR5Cj4ga25vdyBleGFjdGx5IGhvdyBtdWNoIHRoYXQgc3Vja3Mg4oCUIGl04oCZcyBpZGVudGlj
YWwgdG8gS1BUSSB3aXRob3V0Cj4gUENJRC4gIChBbmQgeWVzLCBpZiB3ZSBnbyB0aGlzIHJvdXRl
LCB3ZSBuZWVkIHRvIG1lcmdlIHRoaXMgbG9naWMKPiB0b2dldGhlciDigJQgd2Ugc2hvdWxkbuKA
mXQgd3JpdGUgQ1IzIHR3aWNlIG9uIGVudHJ5KS4KClllYWgsIHByb2JhYmx5IHRydWUuCgpKdXN0
IGV5ZWJhbGxpbmcgdGhpcywgaXQgd291bGQgbWVhbiBtYXBwaW5nIHRoZSAiY3B1IG5lZWRzIGRl
ZmVycmVkCmZsdXNoIiB2YXJpYWJsZSBpbnRvIHRoZSBjcHVfZW50cnlfYXJlYSwgd2hpY2ggZG9l
c24ndCBzZWVtIHRvbyBhd2Z1bC4KCkkgdGhpbmsgdGhlIGJhc2ljIG92ZXJhbGwgY29uY2VybiBp
cyB0aGF0IHRoZSBkZWZlcnJlZCBmbHVzaCBsZWF2ZXMgdG9vCm1hbnkgaG9sZXMgYW5kIGJ5IHRo
ZSB0aW1lIHdlIGNsb3NlIHRoZW0gc3VmZmljaWVudGx5LCBwZXJmb3JtYW5jZSB3aWxsCnN1Y2sg
YWdhaW4uICBTZWVtcyBsaWtlIGEgdG90YWxseSB2YWxpZCBjb25jZXJuLCBidXQgbXkgY3J5c3Rh
bCBiYWxsIGlzCmhhenkgb24gd2hldGhlciBpdCB3aWxsIGJlIHdvcnRoIGl0IGluIHRoZSBlbmQg
dG8gbWFueSBmb2xrcwoKLi4uCj4gSW4gb3RoZXIgd29yZHMsIEkgdGhpbmsgdGhhdCByZXQyZGly
IGlzIGFuIGluc3VmZmljaWVudCBqdXN0aWZpY2F0aW9uCj4gZm9yIFhQRk8uCgpZZWFoLCBvdGhl
ciB0aGluZ3MgdGhhdCBpdCBpcyBnb29kIGZvciBoYXZlIGtpbmRhIGJlZW4gbG9zdCBpbiB0aGUK
bm9pc2UuICBJIHRoaW5rIEkgZmlyc3Qgc3RhcnRlZCBsb29raW5nIGF0IHRoaXMgbG9uZyBiZWZv
cmUgTWVsdGRvd24gYW5kCkwxVEYgd2VyZSBwdWJsaWMuCgpUaGVyZSBhcmUgaHlwZXJ2aXNvcnMg
b3V0IHRoZXJlIHRoYXQgc2ltcGx5IGRvbid0IChwZXJzaXN0ZW50bHkpIG1hcAp1c2VyIGRhdGEu
ICBUaGV5IGNhbid0IGxlYWsgdXNlciBkYXRhIGJlY2F1c2UgdGhleSBkb24ndCBldmVuIGhhdmUK
YWNjZXNzIHRvIGl0IGluIHRoZWlyIHZpcnR1YWwgYWRkcmVzcyBzcGFjZS4gIFRob3NlIGh5cGVy
dmlzb3JzIGhhZCBhCm11Y2ggZWFzaWVyIHRpbWUgd2l0aCBMMVRGIG1pdGlnYXRpb24gdGhhbiB3
ZSBkaWQuICBCYXNpY2FsbHksIHRoZXkKY291bGQgZmx1c2ggdGhlIEwxIGFmdGVyIHVzZXIgZGF0
YSB3YXMgYWNjZXNzaWJsZSBpbnN0ZWFkIG9mIGJlZm9yZQp1bnRydXN0ZWQgZ3Vlc3QgY29kZSBy
dW5zLgoKTXkgaG9wZSBpcyB0aGF0IFhQRk8gY291bGQgcHJvdmlkZSB1cyBzaW1pbGFyIHByb3Rl
Y3Rpb24uICBCdXQsCnNvbWVib2R5J3MgZ290IHRvIHBva2UgYXQgaXQgZm9yIGEgd2hpbGUgdG8g
c2VlIGhvdyBmYXIgdGhleSBjYW4gcHVzaCBpdC4KCklNTkhPLCBYUEZPIGlzICphbHdheXMqIGdv
aW5nIHRvIGJlIHBhaW5mdWwgZm9yIGtlcm5lbCBjb21waWxlcy4gIEJ1dCwKY2xvdWQgcHJvdmlk
ZXJzIGFyZW4ndCBkb2luZyBhIGxvdCBvZiBrZXJuZWwgY29tcGlsZXMgb24gdGhlaXIgS1ZNCmhv
c3RzLCBhbmQgdGhleSBkZWVwbHkgY2FyZSBhYm91dCBsZWFraW5nIHRoZWlyIHVzZXJzJyBkYXRh
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
