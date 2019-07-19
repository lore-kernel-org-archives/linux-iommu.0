Return-Path: <SRS0=Jh8h=VQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27934C76188
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 05:00:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CEA2082F
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 05:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CEA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE25721A9;
	Fri, 19 Jul 2019 05:00:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CBC9F21A4
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 04:59:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 501B4F8
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 04:59:57 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8707C024AF6;
	Fri, 19 Jul 2019 04:59:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-123.pek2.redhat.com
	[10.72.12.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C94C363633;
	Fri, 19 Jul 2019 04:59:45 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to x86
	arch code
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	Thiago Jung Bauermann <bauerman@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<20190718032858.28744-6-bauerman@linux.ibm.com>
	<4a07bf75-b516-c81b-da7a-4b323e6d7e52@amd.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <c85ae8ff-3b7b-88bf-6b6a-c41b159c9cc2@redhat.com>
Date: Fri, 19 Jul 2019 12:59:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4a07bf75-b516-c81b-da7a-4b323e6d7e52@amd.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 19 Jul 2019 04:59:56 +0000 (UTC)
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

5ZyoIDIwMTnlubQwN+aciDE55pelIDAxOjQ3LCBMZW5kYWNreSwgVGhvbWFzIOWGmemBkzoKPiBP
biA3LzE3LzE5IDEwOjI4IFBNLCBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gd3JvdGU6Cj4+IFNlY3Vy
ZSBFbmNyeXB0ZWQgVmlydHVhbGl6YXRpb24gaXMgYW4geDg2LXNwZWNpZmljIGZlYXR1cmUsIHNv
IGl0IHNob3VsZG4ndAo+PiBhcHBlYXIgaW4gZ2VuZXJpYyBrZXJuZWwgY29kZSBiZWNhdXNlIGl0
IGZvcmNlcyBub24teDg2IGFyY2hpdGVjdHVyZXMgdG8KPj4gZGVmaW5lIHRoZSBzZXZfYWN0aXZl
KCkgZnVuY3Rpb24sIHdoaWNoIGRvZXNuJ3QgbWFrZSBhIGxvdCBvZiBzZW5zZS4KPj4KPj4gVG8g
c29sdmUgdGhpcyBwcm9ibGVtLCBhZGQgYW4geDg2IGVsZmNvcmVoZHJfcmVhZCgpIGZ1bmN0aW9u
IHRvIG92ZXJyaWRlCj4+IHRoZSBnZW5lcmljIHdlYWsgaW1wbGVtZW50YXRpb24uIFRvIGRvIHRo
YXQsIGl0J3MgbmVjZXNzYXJ5IHRvIG1ha2UKPj4gcmVhZF9mcm9tX29sZG1lbSgpIHB1YmxpYyBz
byB0aGF0IGl0IGNhbiBiZSB1c2VkIG91dHNpZGUgb2Ygdm1jb3JlLmMuCj4+Cj4+IEFsc28sIHJl
bW92ZSB0aGUgZXhwb3J0IGZvciBzZXZfYWN0aXZlKCkgc2luY2UgaXQncyBvbmx5IHVzZWQgaW4g
ZmlsZXMgdGhhdAo+PiB3b24ndCBiZSBidWlsdCBhcyBtb2R1bGVzLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBUaGlhZ28gSnVuZyBCYXVlcm1hbm4gPGJhdWVybWFuQGxpbnV4LmlibS5jb20+Cj4gCj4g
QWRkaW5nIExpYW5ibyBhbmQgQmFvcXVhbiwgd2hvIHJlY2VudGx5IHdvcmtlZCBvbiB0aGlzLCBm
b3IgdGhlaXIgcmV2aWV3Lgo+IAoKVGhpcyBjaGFuZ2UgbG9va3MgZ29vZCB0byBtZS4KClJldmll
d2VkLWJ5OiBMaWFuYm8gSmlhbmcgPGxpamlhbmdAcmVkaGF0LmNvbT4KClRoYW5rcy4KTGlhbmJv
Cgo+IFRoYW5rcywKPiBUb20KPiAKPj4gLS0tCj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3Jhc2hfZHVt
cF82NC5jIHwgIDUgKysrKysKPj4gIGFyY2gveDg2L21tL21lbV9lbmNyeXB0LmMgICAgICAgfCAg
MSAtCj4+ICBmcy9wcm9jL3ZtY29yZS5jICAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0KPj4g
IGluY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oICAgICAgfCAxNCArKysrKysrKysrKysrKwo+PiAg
aW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5oICAgICB8ICAxIC0KPj4gIDUgZmlsZXMgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9jcmFzaF9kdW1wXzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2hfZHVt
cF82NC5jCj4+IGluZGV4IDIyMzY5ZGQ1ZGUzYi4uMDQ1ZTgyZTg5NDViIDEwMDY0NAo+PiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2hfZHVtcF82NC5jCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9jcmFzaF9kdW1wXzY0LmMKPj4gQEAgLTcwLDMgKzcwLDggQEAgc3NpemVfdCBjb3B5X29sZG1l
bV9wYWdlX2VuY3J5cHRlZCh1bnNpZ25lZCBsb25nIHBmbiwgY2hhciAqYnVmLCBzaXplX3QgY3Np
emUsCj4+ICB7Cj4+ICAJcmV0dXJuIF9fY29weV9vbGRtZW1fcGFnZShwZm4sIGJ1ZiwgY3NpemUs
IG9mZnNldCwgdXNlcmJ1ZiwgdHJ1ZSk7Cj4+ICB9Cj4+ICsKPj4gK3NzaXplX3QgZWxmY29yZWhk
cl9yZWFkKGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCB1NjQgKnBwb3MpCj4+ICt7Cj4+ICsJcmV0
dXJuIHJlYWRfZnJvbV9vbGRtZW0oYnVmLCBjb3VudCwgcHBvcywgMCwgc2V2X2FjdGl2ZSgpKTsK
Pj4gK30KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMgYi9hcmNoL3g4
Ni9tbS9tZW1fZW5jcnlwdC5jCj4+IGluZGV4IDcxMzlmMmY0Mzk1NS4uYjFlODIzNDQxMDkzIDEw
MDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jCj4+ICsrKyBiL2FyY2gveDg2
L21tL21lbV9lbmNyeXB0LmMKPj4gQEAgLTM0OSw3ICszNDksNiBAQCBib29sIHNldl9hY3RpdmUo
dm9pZCkKPj4gIHsKPj4gIAlyZXR1cm4gc21lX21lX21hc2sgJiYgc2V2X2VuYWJsZWQ7Cj4+ICB9
Cj4+IC1FWFBPUlRfU1lNQk9MKHNldl9hY3RpdmUpOwo+PiAgCj4+ICAvKiBPdmVycmlkZSBmb3Ig
RE1BIGRpcmVjdCBhbGxvY2F0aW9uIGNoZWNrIC0gQVJDSF9IQVNfRk9SQ0VfRE1BX1VORU5DUllQ
VEVEICovCj4+ICBib29sIGZvcmNlX2RtYV91bmVuY3J5cHRlZChzdHJ1Y3QgZGV2aWNlICpkZXYp
Cj4+IGRpZmYgLS1naXQgYS9mcy9wcm9jL3ZtY29yZS5jIGIvZnMvcHJvYy92bWNvcmUuYwo+PiBp
bmRleCA1Nzk1N2M5MWM2ZGYuLmNhMWYyMGJlZGQ4YyAxMDA2NDQKPj4gLS0tIGEvZnMvcHJvYy92
bWNvcmUuYwo+PiArKysgYi9mcy9wcm9jL3ZtY29yZS5jCj4+IEBAIC0xMDAsOSArMTAwLDkgQEAg
c3RhdGljIGludCBwZm5faXNfcmFtKHVuc2lnbmVkIGxvbmcgcGZuKQo+PiAgfQo+PiAgCj4+ICAv
KiBSZWFkcyBhIHBhZ2UgZnJvbSB0aGUgb2xkbWVtIGRldmljZSBmcm9tIGdpdmVuIG9mZnNldC4g
Ki8KPj4gLXN0YXRpYyBzc2l6ZV90IHJlYWRfZnJvbV9vbGRtZW0oY2hhciAqYnVmLCBzaXplX3Qg
Y291bnQsCj4+IC0JCQkJdTY0ICpwcG9zLCBpbnQgdXNlcmJ1ZiwKPj4gLQkJCQlib29sIGVuY3J5
cHRlZCkKPj4gK3NzaXplX3QgcmVhZF9mcm9tX29sZG1lbShjaGFyICpidWYsIHNpemVfdCBjb3Vu
dCwKPj4gKwkJCSB1NjQgKnBwb3MsIGludCB1c2VyYnVmLAo+PiArCQkJIGJvb2wgZW5jcnlwdGVk
KQo+PiAgewo+PiAgCXVuc2lnbmVkIGxvbmcgcGZuLCBvZmZzZXQ7Cj4+ICAJc2l6ZV90IG5yX2J5
dGVzOwo+PiBAQCAtMTY2LDcgKzE2Niw3IEBAIHZvaWQgX193ZWFrIGVsZmNvcmVoZHJfZnJlZSh1
bnNpZ25lZCBsb25nIGxvbmcgYWRkcikKPj4gICAqLwo+PiAgc3NpemVfdCBfX3dlYWsgZWxmY29y
ZWhkcl9yZWFkKGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCB1NjQgKnBwb3MpCj4+ICB7Cj4+IC0J
cmV0dXJuIHJlYWRfZnJvbV9vbGRtZW0oYnVmLCBjb3VudCwgcHBvcywgMCwgc2V2X2FjdGl2ZSgp
KTsKPj4gKwlyZXR1cm4gcmVhZF9mcm9tX29sZG1lbShidWYsIGNvdW50LCBwcG9zLCAwLCBmYWxz
ZSk7Cj4+ICB9Cj4+ICAKPj4gIC8qCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NyYXNo
X2R1bXAuaCBiL2luY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oCj4+IGluZGV4IGY3NzRjNWViOWUz
Yy4uNDY2NGZjMTg3MWRlIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NyYXNoX2R1bXAu
aAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2NyYXNoX2R1bXAuaAo+PiBAQCAtMTE1LDQgKzExNSwx
OCBAQCBzdGF0aWMgaW5saW5lIGludCB2bWNvcmVfYWRkX2RldmljZV9kdW1wKHN0cnVjdCB2bWNv
cmVkZF9kYXRhICpkYXRhKQo+PiAgCXJldHVybiAtRU9QTk9UU1VQUDsKPj4gIH0KPj4gICNlbmRp
ZiAvKiBDT05GSUdfUFJPQ19WTUNPUkVfREVWSUNFX0RVTVAgKi8KPj4gKwo+PiArI2lmZGVmIENP
TkZJR19QUk9DX1ZNQ09SRQo+PiArc3NpemVfdCByZWFkX2Zyb21fb2xkbWVtKGNoYXIgKmJ1Ziwg
c2l6ZV90IGNvdW50LAo+PiArCQkJIHU2NCAqcHBvcywgaW50IHVzZXJidWYsCj4+ICsJCQkgYm9v
bCBlbmNyeXB0ZWQpOwo+PiArI2Vsc2UKPj4gK3N0YXRpYyBpbmxpbmUgc3NpemVfdCByZWFkX2Zy
b21fb2xkbWVtKGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LAo+PiArCQkJCSAgICAgICB1NjQgKnBw
b3MsIGludCB1c2VyYnVmLAo+PiArCQkJCSAgICAgICBib29sIGVuY3J5cHRlZCkKPj4gK3sKPj4g
KwlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4+ICt9Cj4+ICsjZW5kaWYgLyogQ09ORklHX1BST0NfVk1D
T1JFICovCj4+ICsKPj4gICNlbmRpZiAvKiBMSU5VWF9DUkFTSERVTVBfSCAqLwo+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5oIGIvaW5jbHVkZS9saW51eC9tZW1fZW5j
cnlwdC5oCj4+IGluZGV4IDBjNWIwZmY5ZWIyOS4uNWM0YTE4YTkxZjg5IDEwMDY0NAo+PiAtLS0g
YS9pbmNsdWRlL2xpbnV4L21lbV9lbmNyeXB0LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9tZW1f
ZW5jcnlwdC5oCj4+IEBAIC0xOSw3ICsxOSw2IEBACj4+ICAjZWxzZQkvKiAhQ09ORklHX0FSQ0hf
SEFTX01FTV9FTkNSWVBUICovCj4+ICAKPj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBtZW1fZW5jcnlw
dF9hY3RpdmUodm9pZCkgeyByZXR1cm4gZmFsc2U7IH0KPj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBz
ZXZfYWN0aXZlKHZvaWQpIHsgcmV0dXJuIGZhbHNlOyB9Cj4+ICAKPj4gICNlbmRpZgkvKiBDT05G
SUdfQVJDSF9IQVNfTUVNX0VOQ1JZUFQgKi8KPj4gIAo+PgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
