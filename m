Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B9CCA482
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 08:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28A41404EB;
	Tue, 21 Jun 2022 08:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28A41404EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BxLNshCD;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k6ybPuTn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihhLtSFm6YV1; Tue, 21 Jun 2022 08:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C779F40283;
	Tue, 21 Jun 2022 08:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C779F40283
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20807C0039;
	Tue, 21 Jun 2022 08:45:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98029C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 08:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A1E941977
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 08:45:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A1E941977
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=BxLNshCD; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=k6ybPuTn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPETMWO3EjlG for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 08:45:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25DBB41970
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25DBB41970
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 08:45:55 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0974F1F966;
 Tue, 21 Jun 2022 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655801153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pouBC4i764FgZXOuJ6SFkbk2xa1PZt6dSFI3XEoLes=;
 b=BxLNshCDBQRc4XmBU9sLjI5ynrIOKZzeUOi0zGyby68AWR+NLDKh1gQWWSjQmyLNWRb+W0
 dy0bLKDuzMCdi110ykiH+iFiyHYjXJJ9LzLM8QxvKgjLk/ggBpz5iUtfZUkwmUxpm4jxDI
 CIeoXXpEVaSAUBtAywORVhvrAqEkhoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655801153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pouBC4i764FgZXOuJ6SFkbk2xa1PZt6dSFI3XEoLes=;
 b=k6ybPuTnlEi+J6ckMb+UuqBX0ObNoZVxlTDbFsuZr7WGvkpdlP8i7LXSwEWQ9sn0i6kP5E
 tdUC8b/eV67CtfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3B6C13A88;
 Tue, 21 Jun 2022 08:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qHp9M0CFsWJvEAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 21 Jun 2022 08:45:52 +0000
Message-ID: <cc1028ad-bd51-dea7-9f3d-fb954416b9fa@suse.de>
Date: Tue, 21 Jun 2022 10:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-3-arnd@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220617125750.728590-3-arnd@kernel.org>
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
YW5uIDxhcm5kQGFybmRiLmRlPgo+IAo+IFRoZSBCdXNMb2dpYyBkcml2ZXIgaXMgdGhlIGxhc3Qg
cmVtYWluaW5nIGRyaXZlciB0aGF0IHJlbGllcyBvbiB0aGUKPiBkZXByZWNhdGVkIGJ1c190b192
aXJ0KCkgZnVuY3Rpb24sIHdoaWNoIGluIHR1cm4gb25seSB3b3JrcyBvbiBhIGZldwo+IGFyY2hp
dGVjdHVyZXMsIGFuZCBpcyBpbmNvbXBhdGlibGUgd2l0aCBib3RoIHN3aW90bGIgYW5kIGlvbW11
IHN1cHBvcnQuCj4gCj4gQmVmb3JlIGNvbW1pdCAzOTFlMmYyNTYwMWUgKCJbU0NTSV0gQnVzTG9n
aWM6IFBvcnQgZHJpdmVyIHRvIDY0LWJpdC4iKSwKPiB0aGUgZHJpdmVyIGhhZCBhIGRlcGVuZGVu
Y3kgb24geDg2LTMyLCBwcmVzdW1hYmx5IGJlY2F1c2Ugb2YgdGhpcwo+IHByb2JsZW0uIEhvd2V2
ZXIsIHRoZSBjaGFuZ2UgaW50cm9kdWNlZCBhbm90aGVyIGJ1ZyB0aGF0IG1hZGUgaXQgc3RpbGwK
PiBpbXBvc3NpYmxlIHRvIHVzZSB0aGUgZHJpdmVyIG9uIGFueSA2NC1iaXQgbWFjaGluZS4KPiAK
PiBUaGlzIHdhcyBpbiB0dXJuIGZpeGVkIGluIGNvbW1pdCA1NmYzOTYxNDZhZjIgKCJzY3NpOiBC
dXNMb2dpYzogRml4Cj4gNjQtYml0IHN5c3RlbSBlbnVtZXJhdGlvbiBlcnJvciBmb3IgQnVzbG9n
aWMiKSwgOCB5ZWFycyBsYXRlciwgd2hpY2gKPiBzaG93cyB0aGF0IHRoZXJlIGFyZSBub3QgYSBs
b3Qgb2YgdXNlcnMuCj4gCj4gTWFjaWVqIGlzIHN0aWxsIHVzaW5nIHRoZSBkcml2ZXIgb24gMzIt
Yml0IGhhcmR3YXJlLCBhbmQgS2hhbGlkIG1lbnRpb25lZAo+IHRoYXQgdGhlIGRyaXZlciB3b3Jr
cyB3aXRoIHRoZSBkZXZpY2UgZW11bGF0aW9uIHVzZWQgaW4gVmlydHVhbEJveAo+IGFuZCBWTXdh
cmUuIEJvdGggb2YgdGhvc2Ugb25seSBlbXVsYXRlIGl0IGZvciBXaW5kb3dzIDIwMDAgYW5kIG9s
ZGVyCj4gb3BlcmF0aW5nIHN5c3RlbXMgdGhhdCBkaWQgbm90IHNoaXAgd2l0aCB0aGUgYmV0dGVy
IExTSSBsb2dpYyBkcml2ZXIuCj4gCj4gRG8gYSBtaW5pbXVtIGZpeCB0aGF0IHNlYXJjaGVzIHRo
cm91Z2ggdGhlIGxpc3Qgb2YgZGVzY3JpcHRvcnMgdG8gZmluZAo+IG9uZSB0aGF0IG1hdGNoZXMg
dGhlIGJ1cyBhZGRyZXNzLiBUaGlzIGlzIGNsZWFybHkgYXMgaW5lZmZpY2llbnQgYXMKPiB3YXMg
aW5kaWNhdGVkIGluIHRoZSBjb2RlIGNvbW1lbnQgYWJvdXQgdGhlIGxhY2sgb2YgYSBidXNfdG9f
dmlydCgpCj4gcmVwbGFjZW1lbnQuIEEgYmV0dGVyIGZpeCB3b3VsZCBsaWtlbHkgaW52b2x2ZSBj
aGFuZ2luZyBvdXQgdGhlIGVudGlyZQo+IGRlc2NyaXB0b3IgYWxsb2NhdGlvbiBmb3IgYSBzaW1w
bGVyIG9uZSwgYnV0IHRoYXQgd291bGQgYmUgbXVjaAo+IG1vcmUgaW52YXNpdmUuCj4gCj4gQ2M6
IE1hY2llaiBXLiBSb3p5Y2tpIDxtYWNyb0BvcmNhbS5tZS51az4KPiBDYzogTWF0dCBXYW5nIDx3
d2VudGFvQHZtd2FyZS5jb20+Cj4gQ2M6IEtoYWxpZCBBeml6IDxraGFsaWRAZ29uZWhpa2luZy5v
cmc+Cj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiAtLS0K
PiAgIGRyaXZlcnMvc2NzaS9CdXNMb2dpYy5jIHwgMjcgKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tCj4gICBkcml2ZXJzL3Njc2kvS2NvbmZpZyAgICB8ICAyICstCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDE3IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvQnVzTG9naWMuYyBiL2RyaXZlcnMvc2NzaS9CdXNMb2dpYy5jCj4gaW5kZXgg
YTg5N2M4ZjkxNGNmLi5kMDU3YWJmY2RkNWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zY3NpL0J1
c0xvZ2ljLmMKPiArKysgYi9kcml2ZXJzL3Njc2kvQnVzTG9naWMuYwo+IEBAIC0yNTE1LDEyICsy
NTE1LDI2IEBAIHN0YXRpYyBpbnQgYmxvZ2ljX3Jlc3VsdGNvZGUoc3RydWN0IGJsb2dpY19hZGFw
dGVyICphZGFwdGVyLAo+ICAgCXJldHVybiAoaG9zdHN0YXR1cyA8PCAxNikgfCB0Z3Rfc3RhdHVz
Owo+ICAgfQo+ICAgCj4gKy8qCj4gKyAqIHR1cm4gdGhlIGRtYSBhZGRyZXNzIGZyb20gYW4gaW5i
b3ggaW50byBhIGNjYiBwb2ludGVyCj4gKyAqIFRoaXMgaXMgcmF0aGVyIGluZWZmaWNpZW50Lgo+
ICsgKi8KPiArc3RhdGljIHN0cnVjdCBibG9naWNfY2NiICoKPiArYmxvZ2ljX2luYm94X3RvX2Nj
YihzdHJ1Y3QgYmxvZ2ljX2FkYXB0ZXIgKmFkYXB0ZXIsIHN0cnVjdCBibG9naWNfaW5ib3ggKmlu
Ym94KQo+ICt7Cj4gKwlzdHJ1Y3QgYmxvZ2ljX2NjYiAqY2NiOwo+ICsKPiArCWZvciAoY2NiID0g
YWRhcHRlci0+YWxsX2NjYnM7IGNjYjsgY2NiID0gY2NiLT5uZXh0X2FsbCkKPiArCQlpZiAoaW5i
b3gtPmNjYiA9PSBjY2ItPmRtYV9oYW5kbGUpCj4gKwkJCWJyZWFrOwo+ICsKPiArCXJldHVybiBj
Y2I7Cj4gK30KPiAgIAo+ICAgLyoKPiAgICAgYmxvZ2ljX3NjYW5faW5ib3ggc2NhbnMgdGhlIElu
Y29taW5nIE1haWxib3hlcyBzYXZpbmcgYW55Cj4gICAgIEluY29taW5nIE1haWxib3ggZW50cmll
cyBmb3IgY29tcGxldGlvbiBwcm9jZXNzaW5nLgo+ICAgKi8KPiAtCj4gICBzdGF0aWMgdm9pZCBi
bG9naWNfc2Nhbl9pbmJveChzdHJ1Y3QgYmxvZ2ljX2FkYXB0ZXIgKmFkYXB0ZXIpCj4gICB7Cj4g
ICAJLyoKPiBAQCAtMjU0MCwxNiArMjU1NCw3IEBAIHN0YXRpYyB2b2lkIGJsb2dpY19zY2FuX2lu
Ym94KHN0cnVjdCBibG9naWNfYWRhcHRlciAqYWRhcHRlcikKPiAgIAllbnVtIGJsb2dpY19jbXBs
dF9jb2RlIGNvbXBfY29kZTsKPiAgIAo+ICAgCXdoaWxlICgoY29tcF9jb2RlID0gbmV4dF9pbmJv
eC0+Y29tcF9jb2RlKSAhPSBCTE9HSUNfSU5CT1hfRlJFRSkgewo+IC0JCS8qCj4gLQkJICAgV2Ug
YXJlIG9ubHkgYWxsb3dlZCB0byBkbyB0aGlzIGJlY2F1c2Ugd2UgbGltaXQgb3VyCj4gLQkJICAg
YXJjaGl0ZWN0dXJlcyB3ZSBydW4gb24gdG8gbWFjaGluZXMgd2hlcmUgYnVzX3RvX3ZpcnQoCj4g
LQkJICAgYWN0dWFsbHkgd29ya3MuICBUaGVyZSAqbmVlZHMqIHRvIGJlIGEgZG1hX2FkZHJfdG9f
dmlydCgpCj4gLQkJICAgaW4gdGhlIG5ldyBQQ0kgRE1BIG1hcHBpbmcgaW50ZXJmYWNlIHRvIHJl
cGxhY2UKPiAtCQkgICBidXNfdG9fdmlydCgpIG9yIGVsc2UgdGhpcyBjb2RlIGlzIGdvaW5nIHRv
IGJlY29tZSB2ZXJ5Cj4gLQkJICAgaW5uZWZmaWNpZW50Lgo+IC0JCSAqLwo+IC0JCXN0cnVjdCBi
bG9naWNfY2NiICpjY2IgPQo+IC0JCQkoc3RydWN0IGJsb2dpY19jY2IgKikgYnVzX3RvX3ZpcnQo
bmV4dF9pbmJveC0+Y2NiKTsKPiArCQlzdHJ1Y3QgYmxvZ2ljX2NjYiAqY2NiID0gYmxvZ2ljX2lu
Ym94X3RvX2NjYihhZGFwdGVyLCBhZGFwdGVyLT5uZXh0X2luYm94KTsKPiAgIAkJaWYgKGNvbXBf
Y29kZSAhPSBCTE9HSUNfQ01EX05PVEZPVU5EKSB7Cj4gICAJCQlpZiAoY2NiLT5zdGF0dXMgPT0g
QkxPR0lDX0NDQl9BQ1RJVkUgfHwKPiAgIAkJCQkJY2NiLT5zdGF0dXMgPT0gQkxPR0lDX0NDQl9S
RVNFVCkgewo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvS2NvbmZpZyBiL2RyaXZlcnMvc2Nz
aS9LY29uZmlnCj4gaW5kZXggY2Y3NTU4OGEyNTg3Li41NmJkYzA4ZDBiNzcgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9zY3NpL0tjb25maWcKPiArKysgYi9kcml2ZXJzL3Njc2kvS2NvbmZpZwo+IEBA
IC01MTMsNyArNTEzLDcgQEAgY29uZmlnIFNDU0lfSFBUSU9QCj4gICAKPiAgIGNvbmZpZyBTQ1NJ
X0JVU0xPR0lDCj4gICAJdHJpc3RhdGUgIkJ1c0xvZ2ljIFNDU0kgc3VwcG9ydCIKPiAtCWRlcGVu
ZHMgb24gUENJICYmIFNDU0kgJiYgVklSVF9UT19CVVMKPiArCWRlcGVuZHMgb24gUENJICYmIFND
U0kKPiAgIAloZWxwCj4gICAJICBUaGlzIGlzIHN1cHBvcnQgZm9yIEJ1c0xvZ2ljIE11bHRpTWFz
dGVyIGFuZCBGbGFzaFBvaW50IFNDU0kgSG9zdAo+ICAgCSAgQWRhcHRlcnMuIENvbnN1bHQgdGhl
IFNDU0ktSE9XVE8sIGF2YWlsYWJsZSBmcm9tCgpDQ0IgaGFuZGxpbmcgaW4gdGhlIGRyaXZlciBp
cyB1Z2x5IGFueXdheSwgc28gdGhhdCdsbCBiZSBnb29kIGVub3VnaC4KClJldmlld2VkLWJ5OiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhh
bm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBz
dXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcK
SFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
