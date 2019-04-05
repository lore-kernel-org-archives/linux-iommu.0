Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5851C4360F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:25:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B902184B
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NBqRhb6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B902184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 320EF25AF;
	Fri,  5 Apr 2019 15:25:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 522442579
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:24:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C72E684F
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:24:54 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id e6so3258072pgc.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 05 Apr 2019 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amacapital-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=FmlrGnlcnzOaXOwG0WgwsBliBrSjujp1iAaQnWvzoYU=;
	b=NBqRhb6DS4vNUj1PuPBydzkYS3LAQYQhIhx9yAMCmxN65credQ7KTgic8lRf4vjH3e
	fnX6zPmu6Mtq6J0THConhsabMoycJ5KcrywXIHRm2YRVl8H30vyOFAtjLWikgIWKLXa/
	j4inkJRKvQddon6vX6r9Xg66oVpfAyfgqKOXHyi7jWEHl40HbbbfH2nHgtUoh2twrYkD
	fw9OlCSnWwd/cVNP3B34xzS0SwmMr/LtBZ9aNgYcBodSAutqXEnh0u5Mwi8XrGKIgqhK
	WPO7GRN4bV3qrgd6Nhqk9Gc5sYGrvZNngo6cL0iAOyeiQqAHPK4S9oDda1cN4oyVJVIU
	YQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=FmlrGnlcnzOaXOwG0WgwsBliBrSjujp1iAaQnWvzoYU=;
	b=nAvZV0h3hj7fpfOPcvttIC3UVMNdr1f5uNhNh+t7cPN1FiQ7MINiXl5KyKxyrzshdV
	O2yaiDIDSr+bOdVLaQ3p4/rsp6O0mzxFY0dK6iYZOvOu4+dNuH083HDfj5VYf3ttwTpt
	KPaOisHV419BFUBuxD8OjwBLjpOuq9EZqBbK+Jw+7FwV/FY0jxbtmj1v8smf2iP41+hS
	glCjR+Hv6zR3JyE1MVEBd32D783N/l9lPYj4CELQtBkyOoLzD+Cp+kdo4ObbjxG/oQZu
	2Tj4nOsyYQIsj3Z06e7dr4eNckJkqJ3ulladri939piilYezVOB6vqFLyPEUCpIvWsAw
	6T5A==
X-Gm-Message-State: APjAAAXoL3UYgUy+ki1+t+cex2Xel5wILrYd9t8GjJ3zGcwYZFsMWOwY
	AUlxGGofpYyDeIM5V2G9BKhUIw==
X-Google-Smtp-Source: APXvYqz6bfaC+cy9ySwZcgCCVqfPOr2v2mH7Fz9R0nQBTjswjnpcsrJEN1MUvuKKZR21XLJqe97wCQ==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr1272543pgv.191.1554477894254; 
	Fri, 05 Apr 2019 08:24:54 -0700 (PDT)
Received: from [100.91.160.246] (72.sub-174-208-6.myvzw.com. [174.208.6.72])
	by smtp.gmail.com with ESMTPSA id
	o76sm59501993pfa.156.2019.04.05.08.24.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 08:24:52 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 12/13] xpfo,
	mm: Defer TLB flushes for non-current CPUs (x86 only)
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
Date: Fri, 5 Apr 2019 09:24:50 -0600
Message-Id: <DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
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
Message-ID: <20190405152450.oYQ36KAN1sLpXDuiXe34XbU-wmlblIryRX-As5eiEmU@z>

Cgo+IE9uIEFwciA1LCAyMDE5LCBhdCA4OjQ0IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToKPiAKPiBPbiA0LzUvMTkgMTI6MTcgQU0sIFRob21hcyBHbGVpeG5l
ciB3cm90ZToKPj4+IHByb2Nlc3MuIElzIHRoYXQgYW4gYWNjZXB0YWJsZSB0cmFkZS1vZmY/Cj4+
IFlvdSBhcmUgbm90IHNlcmlvdXNseSBhc2tpbmcgd2hldGhlciBjcmVhdGluZyBhIHVzZXIgY29u
dHJvbGxhYmxlIHJldDJkaXIKPj4gYXR0YWNrIHdpbmRvdyBpcyBhIGFjY2VwdGFibGUgdHJhZGUt
b2ZmPyBBcHJpbCAxc3Qgd2FzIGEgZmV3IGRheXMgYWdvLgo+IAo+IFdlbGwsIGxldCdzIG5vdCBm
b3JnZXQgdGhhdCB0aGlzIHNldCBhdCBsZWFzdCB0YWtlcyB1cyBmcm9tICJhbHdheXMKPiB2dWxu
ZXJhYmxlIHRvIHJldDJkaXIiIHRvIGEgY2hvaWNlIGJldHdlZW46Cj4gCj4gMS4gZmFzdC1pc2gg
YW5kICJ2dWxuZXJhYmxlIHRvIHJldDJkaXIgZm9yIGEgdXNlci1jb250cm9sbGFibGUgd2luZG93
Igo+IDIuIHNsb3cgYW5kICJtaXRpZ2F0ZWQgYWdhaW5zdCByZXQyZGlyIgo+IAo+IFNvdW5kcyBs
aWtlIHdlIG5lZWQgYSBtZWNoYW5pc20gdGhhdCB3aWxsIGRvIHRoZSBkZWZlcnJlZCBYUEZPIFRM
Qgo+IGZsdXNoZXMgd2hlbmV2ZXIgdGhlIGtlcm5lbCBpcyBlbnRlcmVkLCBhbmQgbm90IF9qdXN0
XyBhdCBjb250ZXh0IHN3aXRjaAo+IHRpbWUuICBUaGlzIHBlcm1pdHMgYW4gYXBwIHRvIHJ1biBp
biB1c2Vyc3BhY2Ugd2l0aCBzdGFsZSBrZXJuZWwgVExCCj4gZW50cmllcyBhcyBsb25nIGFzIGl0
IHdhbnRzLi4uIHRoYXQncyBoYXJtbGVzcy4KCkkgZG9u4oCZdCB0aGluayB0aGlzIGlzIGdvb2Qg
ZW5vdWdoLiBUaGUgYmFkIGd1eXMgY2FuIGVudGVyIHRoZSBrZXJuZWwgYW5kIGFycmFuZ2UgZm9y
IHRoZSBrZXJuZWwgdG8gd2FpdCwgKmluIGtlcm5lbCosIGZvciBsb25nIGVub3VnaCB0byBzZXQg
dXAgdGhlIGF0dGFjay4gIHVzZXJmYXVsdGZkIGlzIHRoZSBtb3N0IG9idmlvdXMgd2F5LCBidXQg
dGhlcmUgYXJlIHBsZW50eS4gSSBzdXBwb3NlIHdlIGNvdWxkIGRvIHRoZSBmbHVzaCBhdCBjb250
ZXh0IHN3aXRjaCAqYW5kKiBlbnRyeS4gIEkgYmV0IHRoYXQgcGVyZm9ybWFuY2Ugc3RpbGwgdXR0
ZXJseSBzdWNrcywgdGhvdWdoIOKAlCBvbiBtYW55IHdvcmtsb2FkcywgdGhpcyB0dXJucyBldmVy
eSBlbnRyeSBpbnRvIGEgZnVsbCBmbHVzaCwgYW5kIHdlIGFscmVhZHkga25vdyBleGFjdGx5IGhv
dyBtdWNoIHRoYXQgc3Vja3Mg4oCUIGl04oCZcyBpZGVudGljYWwgdG8gS1BUSSB3aXRob3V0IFBD
SUQuICAoQW5kIHllcywgaWYgd2UgZ28gdGhpcyByb3V0ZSwgd2UgbmVlZCB0byBtZXJnZSB0aGlz
IGxvZ2ljIHRvZ2V0aGVyIOKAlCB3ZSBzaG91bGRu4oCZdCB3cml0ZSBDUjMgdHdpY2Ugb24gZW50
cnkpLgoKSSBmZWVsIGxpa2UgdGhpcyB3aG9sZSBhcHByb2FjaCBpcyBtaXNndWlkZWQuIHJldDJk
aXIgaXMgbm90IHN1Y2ggYSBnYW1lIGNoYW5nZXIgdGhhdCBmaXhpbmcgaXQgaXMgd29ydGggaHVn
ZSBzbG93ZG93bnMuIEkgdGhpbmsgYWxsIHRoaXMgZWZmb3J0IHNob3VsZCBiZSBzcGVudCBvbiBz
b21lIGtpbmQgb2Ygc2Vuc2libGUgQ0ZJLiBGb3IgZXhhbXBsZSwgd2Ugc2hvdWxkIGJlIGFibGUg
dG8gbW9zdGx5IHNxdWFzaCByZXQyYW55dGhpbmcgYnkgaW5zZXJ0aW5nIGEgY2hlY2sgdGhhdCB0
aGUgaGlnaCBiaXRzIG9mIFJTUCBtYXRjaCB0aGUgdmFsdWUgb24gdGhlIHRvcCBvZiB0aGUgc3Rh
Y2sgYmVmb3JlIGFueSBjb2RlIHRoYXQgcG9wcyBSU1AuICBPbiBhbiBGUE8gYnVpbGQsIHRoZXJl
IGFyZW7igJl0IGFsbCB0aGF0IG1hbnkgaG90IFBPUCBSU1AgaW5zdHJ1Y3Rpb25zLCBJIHRoaW5r
LgoKKEFjdHVhbGx5LCBjaGVja2luZyB0aGUgYml0cyBpcyBzdWJvcHRpbWFsLiBEbzoKCnVuc2ln
bmVkIGxvbmcgb2Zmc2V0ID0gKnJzcCAtIHJzcDsKb2Zmc2V0ID4+PSBUSFJFQURfU0hJRlQ7Cmlm
ICh1bmxpa2VseShvZmZzZXQpKQpCVUcoKTsKUE9QIFJTUDsKClRoaXMgbWVhbnMgdGhhdCBpdOKA
mXMgYWxzbyBpbXBvc3NpYmxlIHRvIHRyaWNrIGEgZnVuY3Rpb24gdG8gcmV0dXJuIGludG8gYSBi
dWZmZXIgdGhhdCBpcyBvbiB0aGF0IGZ1bmN0aW9u4oCZcyBzdGFjay4pCgpJbiBvdGhlciB3b3Jk
cywgSSB0aGluayB0aGF0IHJldDJkaXIgaXMgYW4gaW5zdWZmaWNpZW50IGp1c3RpZmljYXRpb24g
Zm9yIFhQRk8uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
