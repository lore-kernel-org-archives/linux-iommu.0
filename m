Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E0C282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0B12146F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Axi4fAqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0B12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A2BF2597;
	Fri,  5 Apr 2019 16:27:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 22CED2598
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:27:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 71FE2FD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:27:10 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id i19so3567274pfd.0
	for <iommu@lists.linux-foundation.org>;
	Fri, 05 Apr 2019 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amacapital-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=Ysh9Mrjjsf5KUobUQGzy35ckMcQFsSqKm4VSGfPwcIc=;
	b=Axi4fAqr2bS9Bwzw1Irlq12HPKbspntoYaZJJuLovmIBMQ2xArZLYze4QwgYBVDKDn
	zL/9SdwLZ1xGc5XCaHsXf/ApMEn//V1nydmtLvcjew8Z18vhi26OGDOcLOfmUM8EiWM/
	GbiWUxAJCqHKRFQ0BIaeWLdjOXOUWjqOQAd2uKYIvKnPZZbcnGIVlfXyA8VffZimBSKk
	aAWBRBWbtr03KHwGhrXpYDj4bqK2qmLN7qHg0wUUMOhbOpU5gTa/AN+LfafZ+GXxWJjn
	nd3KBNGDuQXGpaZtogKzMvSbt6Fd5dDqeOYzUDHMqAWYARvtA+nx6frZBvNPLc5TC5NJ
	X1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=Ysh9Mrjjsf5KUobUQGzy35ckMcQFsSqKm4VSGfPwcIc=;
	b=CdLzLU4OBEHWwhiAK/rB6yap9URH+WNWfiihZn/QOpa+Tm6uF3Ys6jhoVYpVbdpeq+
	0F5wDLD/QqUDtepmAB77NNc2Mk4cXe4WwlQYeVeVZ1+2bTvcgi6mEtTLxX5heyAs2D1f
	7OxU+aOxYcVonUvPs/TVOShuzykTWhh3FTIgfeTQCfEWVgKfXLOrfDQNHh7sBVHT2Etj
	Ep5BjAgE4OlMAn/7w5ooGUM8jLLRsccL3gXhq8sNnomIOPBqfMI/aTJBMkZ9ZRU0MTgD
	0jUUViAnoJtcpW4PQht47t23ze9GIhT4L3/x5mz5bwYtcoJ0YagNQMm3v6lCL59vNmRB
	5L7w==
X-Gm-Message-State: APjAAAWg199WE1VrAI49qa9vhsfgHcoTy6mlHelOV9BBMcA9wG6vYsDg
	WwRP5majXBdhYcoinm/8MBVpwQ==
X-Google-Smtp-Source: APXvYqygZiTN+T87sxq85RkOULmkYm62y61sBAXlwRhci93Kw+o/kR8k8BWdCBaKxI+XOmVfuk4mnw==
X-Received: by 2002:a63:cc0a:: with SMTP id x10mr12528292pgf.179.1554481629724;
	Fri, 05 Apr 2019 09:27:09 -0700 (PDT)
Received: from ?IPv6:2600:100e:b12a:ccdd:512d:55a6:36a5:bcd4?
	([2600:100e:b12a:ccdd:512d:55a6:36a5:bcd4])
	by smtp.gmail.com with ESMTPSA id
	g73sm41439912pfd.185.2019.04.05.09.27.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 09:27:08 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 12/13] xpfo,
	mm: Defer TLB flushes for non-current CPUs (x86 only)
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <36b999d4-adf6-08a3-2897-d77b9cba20f8@intel.com>
Date: Fri, 5 Apr 2019 10:27:05 -0600
Message-Id: <E0BBD625-6FE0-4A8A-884B-E10FAFC3319E@amacapital.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
	<DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
	<36b999d4-adf6-08a3-2897-d77b9cba20f8@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
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
Message-ID: <20190405162705.80qKVwelRsIzWCNO9w-OFGnbqakBr-0bEs04OgKc46w@z>

Cgo+IE9uIEFwciA1LCAyMDE5LCBhdCAxMDowMSBBTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2Vu
QGludGVsLmNvbT4gd3JvdGU6Cj4gCj4gT24gNC81LzE5IDg6MjQgQU0sIEFuZHkgTHV0b21pcnNr
aSB3cm90ZToKPj4+IFNvdW5kcyBsaWtlIHdlIG5lZWQgYSBtZWNoYW5pc20gdGhhdCB3aWxsIGRv
IHRoZSBkZWZlcnJlZCBYUEZPIFRMQiAKPj4+IGZsdXNoZXMgd2hlbmV2ZXIgdGhlIGtlcm5lbCBp
cyBlbnRlcmVkLCBhbmQgbm90IF9qdXN0XyBhdCBjb250ZXh0Cj4+PiBzd2l0Y2ggdGltZS4gIFRo
aXMgcGVybWl0cyBhbiBhcHAgdG8gcnVuIGluIHVzZXJzcGFjZSB3aXRoIHN0YWxlCj4+PiBrZXJu
ZWwgVExCIGVudHJpZXMgYXMgbG9uZyBhcyBpdCB3YW50cy4uLiB0aGF0J3MgaGFybWxlc3MuCj4g
Li4uCj4+IEkgc3VwcG9zZSB3ZSBjb3VsZCBkbyB0aGUgZmx1c2ggYXQgY29udGV4dCBzd2l0Y2gg
KmFuZCoKPj4gZW50cnkuICBJIGJldCB0aGF0IHBlcmZvcm1hbmNlIHN0aWxsIHV0dGVybHkgc3Vj
a3MsIHRob3VnaCDigJQgb24gbWFueQo+PiB3b3JrbG9hZHMsIHRoaXMgdHVybnMgZXZlcnkgZW50
cnkgaW50byBhIGZ1bGwgZmx1c2gsIGFuZCB3ZSBhbHJlYWR5Cj4+IGtub3cgZXhhY3RseSBob3cg
bXVjaCB0aGF0IHN1Y2tzIOKAlCBpdOKAmXMgaWRlbnRpY2FsIHRvIEtQVEkgd2l0aG91dAo+PiBQ
Q0lELiAgKEFuZCB5ZXMsIGlmIHdlIGdvIHRoaXMgcm91dGUsIHdlIG5lZWQgdG8gbWVyZ2UgdGhp
cyBsb2dpYwo+PiB0b2dldGhlciDigJQgd2Ugc2hvdWxkbuKAmXQgd3JpdGUgQ1IzIHR3aWNlIG9u
IGVudHJ5KS4KPiAKPiBZZWFoLCBwcm9iYWJseSB0cnVlLgo+IAo+IEp1c3QgZXllYmFsbGluZyB0
aGlzLCBpdCB3b3VsZCBtZWFuIG1hcHBpbmcgdGhlICJjcHUgbmVlZHMgZGVmZXJyZWQKPiBmbHVz
aCIgdmFyaWFibGUgaW50byB0aGUgY3B1X2VudHJ5X2FyZWEsIHdoaWNoIGRvZXNuJ3Qgc2VlbSB0
b28gYXdmdWwuCj4gCj4gSSB0aGluayB0aGUgYmFzaWMgb3ZlcmFsbCBjb25jZXJuIGlzIHRoYXQg
dGhlIGRlZmVycmVkIGZsdXNoIGxlYXZlcyB0b28KPiBtYW55IGhvbGVzIGFuZCBieSB0aGUgdGlt
ZSB3ZSBjbG9zZSB0aGVtIHN1ZmZpY2llbnRseSwgcGVyZm9ybWFuY2Ugd2lsbAo+IHN1Y2sgYWdh
aW4uICBTZWVtcyBsaWtlIGEgdG90YWxseSB2YWxpZCBjb25jZXJuLCBidXQgbXkgY3J5c3RhbCBi
YWxsIGlzCj4gaGF6eSBvbiB3aGV0aGVyIGl0IHdpbGwgYmUgd29ydGggaXQgaW4gdGhlIGVuZCB0
byBtYW55IGZvbGtzCj4gCj4gLi4uCj4+IEluIG90aGVyIHdvcmRzLCBJIHRoaW5rIHRoYXQgcmV0
MmRpciBpcyBhbiBpbnN1ZmZpY2llbnQganVzdGlmaWNhdGlvbgo+PiBmb3IgWFBGTy4KPiAKPiBZ
ZWFoLCBvdGhlciB0aGluZ3MgdGhhdCBpdCBpcyBnb29kIGZvciBoYXZlIGtpbmRhIGJlZW4gbG9z
dCBpbiB0aGUKPiBub2lzZS4gIEkgdGhpbmsgSSBmaXJzdCBzdGFydGVkIGxvb2tpbmcgYXQgdGhp
cyBsb25nIGJlZm9yZSBNZWx0ZG93biBhbmQKPiBMMVRGIHdlcmUgcHVibGljLgo+IAo+IFRoZXJl
IGFyZSBoeXBlcnZpc29ycyBvdXQgdGhlcmUgdGhhdCBzaW1wbHkgZG9uJ3QgKHBlcnNpc3RlbnRs
eSkgbWFwCj4gdXNlciBkYXRhLiAgVGhleSBjYW4ndCBsZWFrIHVzZXIgZGF0YSBiZWNhdXNlIHRo
ZXkgZG9uJ3QgZXZlbiBoYXZlCj4gYWNjZXNzIHRvIGl0IGluIHRoZWlyIHZpcnR1YWwgYWRkcmVz
cyBzcGFjZS4gIFRob3NlIGh5cGVydmlzb3JzIGhhZCBhCj4gbXVjaCBlYXNpZXIgdGltZSB3aXRo
IEwxVEYgbWl0aWdhdGlvbiB0aGFuIHdlIGRpZC4gIEJhc2ljYWxseSwgdGhleQo+IGNvdWxkIGZs
dXNoIHRoZSBMMSBhZnRlciB1c2VyIGRhdGEgd2FzIGFjY2Vzc2libGUgaW5zdGVhZCBvZiBiZWZv
cmUKPiB1bnRydXN0ZWQgZ3Vlc3QgY29kZSBydW5zLgo+IAo+IE15IGhvcGUgaXMgdGhhdCBYUEZP
IGNvdWxkIHByb3ZpZGUgdXMgc2ltaWxhciBwcm90ZWN0aW9uLiAgQnV0LAo+IHNvbWVib2R5J3Mg
Z290IHRvIHBva2UgYXQgaXQgZm9yIGEgd2hpbGUgdG8gc2VlIGhvdyBmYXIgdGhleSBjYW4gcHVz
aCBpdC4KPiAKPiBJTU5ITywgWFBGTyBpcyAqYWx3YXlzKiBnb2luZyB0byBiZSBwYWluZnVsIGZv
ciBrZXJuZWwgY29tcGlsZXMuICBCdXQsCj4gY2xvdWQgcHJvdmlkZXJzIGFyZW4ndCBkb2luZyBh
IGxvdCBvZiBrZXJuZWwgY29tcGlsZXMgb24gdGhlaXIgS1ZNCj4gaG9zdHMsIGFuZCB0aGV5IGRl
ZXBseSBjYXJlIGFib3V0IGxlYWtpbmcgdGhlaXIgdXNlcnMnIGRhdGEuCgpBdCB0aGUgcmlzayBv
ZiBhc2tpbmcgc3R1cGlkIHF1ZXN0aW9uczogd2UgYWxyZWFkeSBoYXZlIGEgbWVjaGFuaXNtIGZv
ciB0aGlzOiBoaWdobWVtLiAgQ2FuIHdlIGVuYWJsZSBoaWdobWVtIG9uIHg4Nl82NCwgbWF5YmUg
d2l0aCBzb21lIGhldXJpc3RpY3MgdG8gbWFrZSBpdCB3b3JrIHdlbGw/Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
