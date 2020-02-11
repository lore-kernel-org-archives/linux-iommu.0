Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06988C352A3
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 17:53:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9DB206CC
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 17:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9DB206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tomt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88EC58454E;
	Tue, 11 Feb 2020 17:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lb_KfHVBPKB9; Tue, 11 Feb 2020 17:53:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 872E784520;
	Tue, 11 Feb 2020 17:53:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E808C1D80;
	Tue, 11 Feb 2020 17:53:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72956C07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 17:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5BD9986429
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 17:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Q9tImpGVaL0 for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 17:53:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail1.ugh.no (mail1.ugh.no [178.79.162.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 143F38643F
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 17:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail1.ugh.no (Postfix) with ESMTP id ACA8924EA8B;
 Tue, 11 Feb 2020 18:53:31 +0100 (CET)
Received: from mail1.ugh.no ([127.0.0.1])
 by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mBelwyQ0Zr-a; Tue, 11 Feb 2020 18:53:31 +0100 (CET)
Received: from [10.255.64.11] (unknown [185.176.245.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: andre@tomt.net)
 by mail.ugh.no (Postfix) with ESMTPSA id 3319D24EA6B;
 Tue, 11 Feb 2020 18:53:31 +0100 (CET)
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
To: Robin Murphy <robin.murphy@arm.com>, Chuck Lever <chuck.lever@oracle.com>
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
 <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
 <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
 <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
 <21c801a6-9a8b-1ebb-7e41-76e8385116ea@arm.com>
 <A411A8A6-ECEF-4EAD-84A1-99A30A213D8E@oracle.com>
 <35961bac-2f1e-3fbc-9661-031b9d5acee3@arm.com>
From: Andre Tomt <andre@tomt.net>
Message-ID: <55784ee1-f221-85e2-d811-b0c5821161a5@tomt.net>
Date: Tue, 11 Feb 2020 18:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <35961bac-2f1e-3fbc-9661-031b9d5acee3@arm.com>
Content-Language: en-US
Cc: Tom Murphy <tmurphy@arista.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
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

T24gMTEuMDIuMjAyMCAxNzozNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDExLzAyLzIwMjAg
NDowMyBwbSwgQ2h1Y2sgTGV2ZXIgd3JvdGU6Cj4+IFJvYmluLCB5b3VyIGV4cGxhbmF0aW9uIG1h
a2VzIHNlbnNlIHRvIG1lLiBJIGNhbiBwb3N0IGEgZml4IGZvciB0aGlzIAo+PiBpbWJhbGFuY2Ug
bGF0ZXIgdG9kYXkgZm9yIEFuZHJlIHRvIHRyeS4KPiAKPiBGV0lXIGhlcmUncyBhIHF1aWNrIGhh
Y2sgd2hpY2ggKnNob3VsZCogc3VwcHJlc3MgdGhlIGNvbmNhdGVuYXRpb24gCj4gYmVoYXZpb3Vy
IC0gaWYgaXQgbWFrZXMgQW5kcmUncyBzeXN0ZW0gYW55IGhhcHBpZXIgdGhlbiB0aGF0IHdvdWxk
IAo+IGluZGVlZCBwb2ludCB0b3dhcmRzIGRtYV9tYXBfc2coKSBoYW5kbGluZyBiZWluZyB0aGUg
Y3VscHJpdC4KPiAKPiBSb2Jpbi4KClRoaXMgaGFjayBkbyBpbmRlZWQgbWFrZSB0aGluZ3Mgd29y
ayBhZ2Fpbi4KCj4gLS0tLS0+OC0tLS0tCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1h
LWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4gaW5kZXggYTJlOTZhNWZkOWE3
Li5hNmI3MWJhZDUxOGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPiBAQCAtNzc5LDcgKzc3OSw3IEBAIHN0
YXRpYyBpbnQgX19maW5hbGlzZV9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCAKPiBzY2F0
dGVybGlzdCAqc2csIGludCBuZW50cywKPiAgwqDCoMKgwqDCoMKgwqDCoMKgICogLSBidXQgZG9l
c24ndCBmYWxsIGF0IGEgc2VnbWVudCBib3VuZGFyeQo+ICDCoMKgwqDCoMKgwqDCoMKgwqAgKiAt
IGFuZCB3b3VsZG4ndCBtYWtlIHRoZSByZXN1bHRpbmcgb3V0cHV0IHNlZ21lbnQgdG9vIGxvbmcK
PiAgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDCoMKgwqDCoMKgIGlmIChjdXJfbGVuICYm
ICFzX2lvdmFfb2ZmICYmIChkbWFfYWRkciAmIHNlZ19tYXNrKSAmJgo+ICvCoMKgwqDCoMKgwqDC
oCBpZiAoMCAmJiBjdXJfbGVuICYmICFzX2lvdmFfb2ZmICYmIChkbWFfYWRkciAmIHNlZ19tYXNr
KSAmJgo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKG1heF9sZW4gLSBjdXJfbGVuID49IHNf
bGVuZ3RoKSkgewo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogLi4udGhlbiBjb25jYXRl
bmF0ZSBpdCB3aXRoIHRoZSBwcmV2aW91cyBvbmUgKi8KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGN1cl9sZW4gKz0gc19sZW5ndGg7Cj4gQEAgLTc5OSw2ICs3OTksNyBAQCBzdGF0aWMgaW50
IF9fZmluYWxpc2Vfc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgCj4gc2NhdHRlcmxpc3Qg
KnNnLCBpbnQgbmVudHMsCj4gIMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNfbGVuZ3RoICsgc19pb3Zh
X29mZiA8IHNfaW92YV9sZW4pCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdXJfbGVuID0g
MDsKPiAgwqDCoMKgwqAgfQo+ICvCoMKgwqAgV0FSTl9PTihjb3VudCA8IG5lbnRzKTsKPiAgwqDC
oMKgwqAgcmV0dXJuIGNvdW50Owo+ICDCoH0KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
