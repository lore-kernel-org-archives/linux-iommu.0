Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F84CC43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 08:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBA0941978;
	Tue, 21 Jun 2022 08:43:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBA0941978
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=K0/rxxRx;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4sGC2Zpc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpGyMicVFXWz; Tue, 21 Jun 2022 08:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD7D241970;
	Tue, 21 Jun 2022 08:43:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD7D241970
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88E63C0039;
	Tue, 21 Jun 2022 08:43:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39E0FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 08:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1389660B5B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 08:43:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1389660B5B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=K0/rxxRx; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=4sGC2Zpc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H5jU7z8hjHXP for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 08:43:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2EAF60B48
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2EAF60B48
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 08:43:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BCAA1F8DE;
 Tue, 21 Jun 2022 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655800985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrjsV6j2GxgikRLfvlQrNeSRen6nfTOp6oxrH6LHqfA=;
 b=K0/rxxRxD+aiJWdzNoDa+0SoXPF1IC6BQYG8KRz+uLlaLWZurLtKhY6UYOEfPLCmqSRC/w
 Y1D5KwymXhBqhBR9crYjVykXd3bn4B3i3+h43/ukFTQ8zjpwPQ13XzqCAo01A3ELViJzf6
 uSLq81TeqOgtKl81+nNvuE01bTKb9wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655800985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrjsV6j2GxgikRLfvlQrNeSRen6nfTOp6oxrH6LHqfA=;
 b=4sGC2ZpcdwRXnQXA0/sC53dBVT8LwJN6GZh0t4vK8khlBh7SaMpQztL5XFMRTpAKtvDoDF
 +22dtf7sd6JD1TDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB47813A88;
 Tue, 21 Jun 2022 08:43:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A00dM5iEsWLADgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 21 Jun 2022 08:43:04 +0000
Message-ID: <361336a6-f3be-c7d9-7bdb-20c30c9a72df@suse.de>
Date: Tue, 21 Jun 2022 10:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-2-arnd@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 1/3] scsi: dpt_i2o: drop stale VIRT_TO_BUS dependency
In-Reply-To: <20220617125750.728590-2-arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, "Maciej W . Rozycki" <macro@orcam.me.uk>,
 linux-m68k@lists.linux-m68k.org, Denis Efremov <efremov@linux.com>,
 Mark Salyzyn <salyzyn@android.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Matt Wang <wwentao@vmware.com>,
 linux-alpha@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNi8xNy8yMiAxNDo1NywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBGcm9tOiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPgo+IAo+IFRoZSBkcHRfaTJvIGRyaXZlciB3YXMgZml4ZWQgdG8g
c3RvcCB1c2luZyB2aXJ0X3RvX2J1cygpIGluIDIwMDgsIGJ1dAo+IGl0IHN0aWxsIGhhcyBhIHN0
YWxlIHJlZmVyZW5jZSBpbiBhbiBlcnJvciBoYW5kbGluZyBjb2RlIHBhdGggdGhhdCBjb3VsZAo+
IG5ldmVyIHdvcmsuCj4gCj4gRml4IGl0IHVwIHRvIGJ1aWxkIHdpdGhvdXQgVklSVF9UT19CVVMg
YW5kIHJlbW92ZSB0aGUgS2NvbmZpZyBkZXBlbmRlbmN5Lgo+IAo+IFRoZSBhbHRlcm5hdGl2ZSB0
byB0aGlzIHdvdWxkIGJlIHRvIGp1c3QgcmVtb3ZlIHRoZSBkcml2ZXIsIGFzIGl0IGlzCj4gY2xl
YXJseSBvYnNvbGV0ZS4gVGhlIGkybyBkcml2ZXIgbGF5ZXIgd2FzIHJlbW92ZWQgaW4gMjAxNSB3
aXRoIGNvbW1pdAo+IDRhNzJhN2FmNDYyZCAoInN0YWdpbmc6IHJlbW92ZSBpMm8gc3Vic3lzdGVt
IiksIGJ1dCB0aGUgZXZlbiBvbGRlcgo+IGRwdF9pMm8gc2NzaSBkcml2ZXIgc3RheWVkIGFyb3Vu
ZC4KPiAKPiBUaGUgbGFzdCBub24tY2xlYW51cCBwYXRjaGVzIEkgY291bGQgZmluZCB3ZXJlIGZy
b20gTWlxdWVsIHZhbiBTbW9vcmVuYnVyZwo+IGFuZCBNYXJrIFNhbHl6eW4gYmFjayBpbiAyMDA4
LCB0aGV5IG1pZ2h0IGtub3cgaWYgdGhlcmUgaXMgYW55IGNoYW5jZQo+IG9mIHRoZSBoYXJkd2Fy
ZSBzdGlsbCBiZWluZyB1c2VkIGFueXdoZXJlLgo+IAo+IEZpeGVzOiA2N2FmMmIwNjBlMDIgKCJb
U0NTSV0gZHB0X2kybzogbW92ZSBmcm9tIHZpcnRfdG9fYnVzL2J1c190b192aXJ0IHRvIGRtYV9h
bGxvY19jb2hlcmVudCIpCj4gQ2M6IE1pcXVlbCB2YW4gU21vb3JlbmJ1cmcgPG1pa2V2c0B4czRh
bGwubmV0Pgo+IENjOiBNYXJrIFNhbHl6eW4gPHNhbHl6eW5AYW5kcm9pZC5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiAtLS0KPiAgIGRyaXZlcnMv
c2NzaS9LY29uZmlnICAgfCAyICstCj4gICBkcml2ZXJzL3Njc2kvZHB0X2kyby5jIHwgNCArKy0t
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL0tjb25maWcgYi9kcml2ZXJzL3Njc2kvS2NvbmZp
Zwo+IGluZGV4IGE5ZmU1MTUyYWRkZC4uY2Y3NTU4OGEyNTg3IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvc2NzaS9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9zY3NpL0tjb25maWcKPiBAQCAtNDYwLDcg
KzQ2MCw3IEBAIGNvbmZpZyBTQ1NJX01WVU1JCj4gICAKPiAgIGNvbmZpZyBTQ1NJX0RQVF9JMk8K
PiAgIAl0cmlzdGF0ZSAiQWRhcHRlYyBJMk8gUkFJRCBzdXBwb3J0ICIKPiAtCWRlcGVuZHMgb24g
U0NTSSAmJiBQQ0kgJiYgVklSVF9UT19CVVMKPiArCWRlcGVuZHMgb24gU0NTSSAmJiBQQ0kKPiAg
IAloZWxwCj4gICAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBhbGwgb2YgQWRhcHRlYydzIEkyTyBi
YXNlZCBSQUlEIGNvbnRyb2xsZXJzIGFzCj4gICAJICB3ZWxsIGFzIHRoZSBEUFQgU21hcnRSYWlk
IFYgY2FyZHMuICBUaGlzIGlzIGFuIEFkYXB0ZWMgbWFpbnRhaW5lZAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvZHB0X2kyby5jIGIvZHJpdmVycy9zY3NpL2RwdF9pMm8uYwo+IGluZGV4IDJl
OTE1NWJhNzQwOC4uNTVkZmU3MDExOTEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2NzaS9kcHRf
aTJvLmMKPiArKysgYi9kcml2ZXJzL3Njc2kvZHB0X2kyby5jCj4gQEAgLTUyLDExICs1MiwxMSBA
QCBNT0RVTEVfREVTQ1JJUFRJT04oIkFkYXB0ZWMgSTJPIFJBSUQgRHJpdmVyIik7Cj4gICAKPiAg
ICNpbmNsdWRlIDxsaW51eC90aW1lci5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPgo+
ICsjaW5jbHVkZSA8bGludXgvaW8uaD4KPiAgICNpbmNsdWRlIDxsaW51eC9pb3BvcnQuaD4KPiAg
ICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgo+ICAgCj4gICAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nv
ci5oPgkvKiBmb3IgYm9vdF9jcHVfZGF0YSAqLwo+IC0jaW5jbHVkZSA8YXNtL2lvLmg+CQkvKiBm
b3IgdmlydF90b19idXMsIGV0Yy4gKi8KPiAgIAo+ICAgI2luY2x1ZGUgPHNjc2kvc2NzaS5oPgo+
ICAgI2luY2x1ZGUgPHNjc2kvc2NzaV9jbW5kLmg+Cj4gQEAgLTIxMTIsNyArMjExMiw3IEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBhZHB0X2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpCj4gICAJCX0g
ZWxzZSB7Cj4gICAJCQkvKiBJY2ssIHdlIHNob3VsZCAqbmV2ZXIqIGJlIGhlcmUgKi8KPiAgIAkJ
CXByaW50ayhLRVJOX0VSUiAiZHB0aTogcmVwbHkgZnJhbWUgbm90IGZyb20gcG9vbFxuIik7Cj4g
LQkJCXJlcGx5ID0gKHU4ICopYnVzX3RvX3ZpcnQobSk7Cj4gKwkJCWdvdG8gb3V0Owo+ICAgCQl9
Cj4gICAKPiAgIAkJaWYgKHJlYWRsKHJlcGx5KSAmIE1TR19GQUlMKSB7CgpSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpQZXJzb25hbGx5IEkgd291bGRuJ3QgbWlu
ZCB0byBzZWUgdGhpcyBkcml2ZXIgZ29uZSwgYXMgaXQncyBiZWluZyBidWlsdCAKdXBvbiB0aGUg
KGxvbmctZGVmdW5jdCkgSTJPIHNwZWNpZmljYXRpb24uIFdlIGFscmVhZHkgZGVsZXRlZCB0aGUg
aTJvIApzdWJzeXN0ZW0geWVhcnMgYWdvLCBzbyBtYXliZSBpdCdzIHRpbWUgdG8gY29uc2lnbiB0
aGlzIGRyaXZlciB0byAKaGlzdG9yeSwgdG9vLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1
c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
