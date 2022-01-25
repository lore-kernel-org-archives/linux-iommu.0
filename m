Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98424C433FE
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 13:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE9460B45;
	Tue, 25 Jan 2022 13:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RaAKGlnX8C8; Tue, 25 Jan 2022 13:19:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E68460B35;
	Tue, 25 Jan 2022 13:19:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06793C0039;
	Tue, 25 Jan 2022 13:19:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBA10C002F;
 Tue, 25 Jan 2022 13:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9FB960B45;
 Tue, 25 Jan 2022 13:19:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HrIsozwVbZST; Tue, 25 Jan 2022 13:19:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7502760B35;
 Tue, 25 Jan 2022 13:19:51 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C010621129;
 Tue, 25 Jan 2022 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643116788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7ugEwGd8z1ciGcssO9NOuo6Y70kmTmAuz+RVBNhgQo=;
 b=OAQFnCJ9fJXwRf+XqgaH8z+GcXVjo9HxXhbpGWNi3xMFKm4awPudNVTJaJaXXs1dSxQj1I
 /htMCb/jE9Jo8zsCT8DVooqvtd6XAyQmf3X5bQaNYmHaXyRhOYiGujXcl4ae/nW4gqHHZG
 iIctFqchskLEpoSkcCX/nH6b9I06d44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643116788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7ugEwGd8z1ciGcssO9NOuo6Y70kmTmAuz+RVBNhgQo=;
 b=URWUxsOGxCPGESRThyQ7b2f2CoH5apJnVqlsxfRb5qW9qyCiYDfA7/lidO7XlY8xzuv09P
 oqD7gCa//062VVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F330613DE5;
 Tue, 25 Jan 2022 13:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TzS6OPP472GbRwAAMHmgww
 (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 13:19:47 +0000
Date: Tue, 25 Jan 2022 14:19:46 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
Message-ID: <20220125131943.GA5609@linux>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
 <b7c311d4b2cd377cdc4f92bc9ccf6af1@suse.de>
 <6AEF32AC-4E0D-41E0-8850-33B8BD955920@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6AEF32AC-4E0D-41E0-8850-33B8BD955920@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mel Gorman <mgorman@techsingularity.net>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Eric Ren <renzhengeek@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgMTI6MTc6MjNQTSAtMDUwMCwgWmkgWWFuIHdyb3RlOgo+
IFlvdSBhcmUgcmlnaHQuIFNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLiBJIHRoaW5rIGl0IHNob3Vs
ZCBiZQo+IOKAnFBhZ2UgaXNvbGF0aW9uIGlzIGRvbmUgYXQgbGVhc3Qgb24gbWF4KE1BWF9PUkRF
Ul9OUl9QQUVHUywKPiBwYWdlYmxvY2tfbnJfcGFnZXMpIGdyYW51bGFyaXR5LuKAnQo+IAo+IG1l
bW9yeV9ob3RwbHVnIHVzZXMgUEFHRVNfUEVSX1NFQ1RJT04uIEl0IGlzIGdyZWF0ZXIgdGhhbiB0
aGF0LgoKT3IganVzdCBzcGVjaWZ5IHRoYXQgdGhlIG1heChNQVhfT1JERVJfTlJfUEFHRVMsIHBh
Z2VibG9ja19ucl9wYWdlcykgZ3JhbnVyYWxpdHkKb25seSBjb21lcyBmcm9tIGFsbG9jX2NvbnRp
Z19yYW5nZSBhdCB0aGUgbW9tZW50LiBPdGhlciBjYWxsZXJzIG1pZ2h0IHdhbnQKdG8gd29yayBp
biBvdGhlciBncmFudWxhcml0eSAoZS5nOiBtZW1vcnktaG90cGx1ZykgYWx0aG91Z2ggdWx0aW1h
dGVseSB0aGUKcmFuZ2UgaGFzIHRvIGJlIGFsaWduZWQgdG8gc29tZXRoaW5nLgoKPiA+IFRydWUg
aXMgdGhhdCBzdGFydF9pc29sYXRlX3BhZ2VfcmFuZ2UoKSBleHBlY3RzIHRoZSByYW5nZSB0byBi
ZSBwYWdlYmxvY2sgYWxpZ25lZCBhbmQgd29ya3MgaW4gcGFnZWJsb2NrX25yX3BhZ2VzIGNodW5r
cywgYnV0IEkgZG8gbm90IHRoaW5rIHRoYXQgaXMgd2hhdCB5b3UgbWVhbnQgdG8gc2F5IGhlcmUu
Cj4gCj4gQWN0dWFsbHksIHN0YXJ0X2lzb2xhdGVfcGFnZV9yYW5nZSgpIHNob3VsZCBleHBlY3Qg
bWF4KE1BWF9PUkRFUl9OUl9QQUVHUywKPiBwYWdlYmxvY2tfbnJfcGFnZXMpIGFsaWdubWVudCBp
bnN0ZWFkIG9mIHBhZ2VibG9jayBhbGlnbm1lbnQuIEl0IHNlZW1zIHRvCj4gYmUgYW4gdW5jb3Zl
cmVkIGJ1ZyBpbiB0aGUgY3VycmVudCBjb2RlLCBzaW5jZSBhbGwgY2FsbGVycyB1c2VzIGF0IGxl
YXN0Cj4gbWF4KE1BWF9PUkRFUl9OUl9QQUVHUywgcGFnZWJsb2NrX25yX3BhZ2VzKSBhbGlnbm1l
bnQuCj4gCj4gVGhlIHJlYXNvbiBpcyB0aGF0IGlmIHN0YXJ0X2lzb2xhdGVfcGFnZV9yYW5nZSgp
IGlzIG9ubHkgcGFnZWJsb2NrIGFsaWduZWQKPiBhbmQgYSBjYWxsZXIgd2FudHMgdG8gaXNvbGF0
ZSBvbmUgcGFnZWJsb2NrIGZyb20gYSBNQVhfT1JERVItMQo+ICgyIHBhZ2VibG9ja3Mgb24geDg0
XzY0IHN5c3RlbXMpIGZyZWUgcGFnZSwgdGhpcyB3aWxsIGxlYWQgdG8gTUlHUkFURV9JU09MQVRF
Cj4gYWNjb3VudGluZyBlcnJvci4gVG8gYXZvaWQgaXQsIHN0YXJ0X2lzb2xhdGVfcGFnZV9yYW5n
ZSgpIG5lZWRzIHRvIGlzb2xhdGUKPiB0aGUgbWF4KE1BWF9PUkRFUl9OUl9QQUVHUywgcGFnZWJs
b2NrX25yX3BhZ2VzKSBhbGlnbmVkIHJhbmdlLgoKU28sIGxldCBtZSBzZWUgaWYgSSBnZXQgdGhp
cyBzdHJhaWdodDoKCllvdSBhcmUgc2F5aW5nIHRoYXQsIGN1cnJlbnRseSwgYWxsb2NfY29udGln
X3JhbmdlcygpIHdvcmtzIG9uIHRoZSBiaWdnZXN0CmFsaWdubWVudCBvdGhlcndpc2Ugd2UgbWln
aHQgaGF2ZSB0aGlzIHNjZW5hcmlvOgoKWyAgICAgIE1BWF9PUkRFUi0xICAgICAgIF0KW3BhZ2Vi
bG9jayMwXVtwYWdlYmxvY2sjMV0KCldlIG9ubHkgd2FudCB0byBpc29sYXRlIHBhZ2VibG9jayMx
LCBzbyB3ZSBwYXNzIGEgcGFnZWJsb2NrLWFsaWduZWQgcmFuZ2UgdG8Kc3RhcnRfaXNvbGF0ZV9w
YWdlX3JhbmdlKCksIGJ1dCB0aGUgcGFnZSBiZWxvbmdpbmcgdG8gcGFnZWJsb2NrIzEgc3BhbnMK
cGFnZWJsb2NrIzAgYW5kIHBhZ2VibG9jayMxIGJlY2F1c2UgaXQgaXMgYSBNQVhfT1JERVItMSBw
YWdlLgoKU28gd2hlbiB3ZSBjYWxsIHNldF9taWdyYXRldHlwZV9pc29sYXRlKCktPnNldF9wYWdl
YmxvY2tfbWlncmF0ZXR5cGUoKSwgdGhpcyB3aWxsCm1hcmsgZWl0aGVyIHBhZ2VibG9jayMwIG9y
IHBhZ2VibG9jayMxIGFzIGlzb2xhdGVkLCBidXQgdGhlIHdob2xlIHBhZ2Ugd2lsbCBiZSBwdXQK
aW4gdGhlIE1JR1JBVEVfSVNPTEFURSBmcmVlbGlzdCBieSBtb3ZlX2ZyZWVwYWdlc19ibG9jaygp
LT5tb3ZlX2ZyZWVwYWdlcygpLgpNZWFuaW5nLCB3ZSB3aWwgZWZmZWN0aXZlbHkgaGF2ZSB0d28g
cGFnZWJsb2NrcyBpc29sYXRlZCwgYnV0IG9ubHkgb25lIG1hcmtlZAphcyBzdWNoPwoKRGlkIEkg
Z2V0IGl0IHJpZ2h0IG9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nPwoKSSBrbm93IHRoYXQgdGhpcyBo
YXMgYmVlbiBkaXNjdXNzZWQgcHJldmlvdXNseSwgYW5kIHRoZSBjb3Zlci1sZXR0ZXIgYWxyZWFk
eQptZW50aW9ucyBpdCwgYnV0IEkgdGhpbmsgaXQgd291bGQgYmUgZ3JlYXQgdG8gaGF2ZSBzb21l
IHNvcnQgb2YgaW5mb3JtYXRpb24gYWJvdXQKdGhlIHByb2JsZW0gaW4gdGhlIGNvbW1pdCBtZXNz
YWdlIGFzIHdlbGwsIHNvIHBlb3BsZSBkbyBub3QgaGF2ZSB0byBnbyBhbmQgZmluZAppdCBzb21l
d2hlcmUgZWxzZS4KCgotLSAKT3NjYXIgU2FsdmFkb3IKU1VTRSBMYWJzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
