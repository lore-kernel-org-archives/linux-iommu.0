Return-Path: <SRS0=2ATj=ZS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C4C432C0
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 12:00:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969D42073F
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="KY6ceqkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969D42073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6DE8A86C53;
	Tue, 26 Nov 2019 12:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8XlRkowTEfo; Tue, 26 Nov 2019 12:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4698986D2F;
	Tue, 26 Nov 2019 12:00:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D6B5C0880;
	Tue, 26 Nov 2019 12:00:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B9BC0878
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 12:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F364A2202C
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 12:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5k6LxwF-malg for <iommu@lists.linux-foundation.org>;
 Tue, 26 Nov 2019 12:00:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.80])
 by silver.osuosl.org (Postfix) with ESMTPS id 90977214EC
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574769604;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=OiXIPkAa+jo3JWZau1B2Ey3v2wblVpCTuGCnmx5s9Rg=;
 b=KY6ceqkIB/d72oE4z/zZoY9Y08SlX5sj1VtMmq9VmKDpYBz5DcC+yINveFhl4CEaRO
 WrCWB2VnLrTHD6uiCFlfARjDfLmu5NQtD3+Oo2h8T8BAn7PTf3SFVYa4Z7pgGhSOB43N
 9bWE9agTP4r3q5PeW+wTnxg7l+8uLNMHWMJl+Jo+ciqXeZtsYRB5L3gbpxhBogg2lxKD
 6EDGWNxAGJUkI6kvztxgDdLd9/4EhqDtG2c8Yg/UzcF6BI8iAiJLDzjuvSo933ZDSBlO
 1e1TXmWAzTsVT4KQQbbNQrJMPOW/Bpb677pTIIsZ8I+NwGBfmd1P4W7uWdEq8IXgIbMH
 c2hA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSIh0PhkEvMsMre1rbZ/xz+jsR"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:14bb:b5af:17db:dc1]
 by smtp.strato.de (RZmta 45.0.2 AUTH) with ESMTPSA id x0678cvAQBv38le
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 26 Nov 2019 12:57:03 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To: Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de> <20191125093159.GA23118@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <b668bc25-9268-d25e-f9a0-176bb4ce1d07@xenosoft.de>
Date: Tue, 26 Nov 2019 12:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191125093159.GA23118@linux.ibm.com>
Content-Language: de-DE
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net, rtd2@xtra.co.nz,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, paulus@samba.org,
 mad skateman <madskateman@gmail.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Robin Murphy <robin.murphy@arm.com>, nsaenzjulienne@suse.de
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

T24gMjUgTm92ZW1iZXIgMjAxOSBhdCAxMDozMiBhbSwgTWlrZSBSYXBvcG9ydCB3cm90ZToKPiBP
biBNb24sIE5vdiAyNSwgMjAxOSBhdCAwODozOToyM0FNICswMTAwLCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToKPj4gT24gU2F0LCBOb3YgMjMsIDIwMTkgYXQgMTI6NDI6MjdQTSArMDEwMCwgQ2hy
aXN0aWFuIFppZ290emt5IHdyb3RlOgo+Pj4gSGVsbG8gQ2hyaXN0b3BoLAo+Pj4KPj4+IFBsZWFz
ZSBmaW5kIGF0dGFjaGVkIHRoZSBkbWVzZyBvZiB5b3VyIEdpdCBrZXJuZWwuCj4+IFRoYW5rcy4g
IEl0IGxvb2tzIGxpa2Ugb24geW91ciBwbGF0Zm9ybSB0aGUgc3dpb3RsYiBidWZmZXIgaXNuJ3QK
Pj4gYWN0dWFsbHkgYWRkcmVzc2FibGUgYmFzZWQgb24gdGhlIGJ1cyBkbWEgbWFzayBsaW1pdCwg
d2hpY2ggaXMgcmF0aGVyCj4+IGludGVyZXN0aW5nLiAgc3dpb3RsYl9pbml0IHVzZXMgbWVtYmxv
Y2tfYWxsb2NfbG93IHRvIGFsbG9jYXRlIHRoZQo+PiBidWZmZXIsIGFuZCBJJ2xsIG5lZWQgc29t
ZSBoZWxwIGZyb20gTWlrZSBhbmQgdGhlIHBvd2VycGMgbWFpbnRhaW5lcnMKPj4gdG8gZmlndXJl
IG91dCBob3cgdGhhdCBzZWxlY3Qgd2hlcmUgdG8gYWxsb2NhdGUgdGhlIGJ1ZmZlciBmcm9tLCBh
bmQKPj4gaG93IHdlIGNhbiBtb3ZlIGl0IHRvIGEgbG93ZXIgYWRkcmVzcy4gIE15IGd1dCBmZWVs
aW5nIHdvdWxkIGJlIHRvIHRyeQo+PiB0byBkbyB3aGF0IGFybTY0IGRvZXMgYW5kIGRlZmluZSBh
IG5ldyBBUkNIX0xPV19BRERSRVNTX0xJTUlULCBwcmVmZXJhYmx5Cj4+IHdpdGhvdXQgbmVlZGlu
ZyB0b28gbXVjaCBhcmNoIHNwZWNpZmljIG1hZ2ljLgo+IFByZXN1bWluZyB0aGUgcHJvYmxlbSBp
cyByZWxldmFudCBmb3IgYWxsIENvcmVOZXQgYm9hcmRzIHNvbWV0aGluZyBsaWtlCj4gdGhpcyBj
b3VsZCB3b3JrOgo+ICAgCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9k
bWEuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9kbWEuaAo+IGluZGV4IDFiNGYwMjU0ODY4
Zi4uN2M2Y2ZlZWFmZjUyIDEwMDY0NAo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9k
bWEuaAo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9kbWEuaAo+IEBAIC0zNDcsNSAr
MzQ3LDExIEBAIGV4dGVybiBpbnQgaXNhX2RtYV9icmlkZ2VfYnVnZ3k7Cj4gICAjZGVmaW5lIGlz
YV9kbWFfYnJpZGdlX2J1Z2d5CSgwKQo+ICAgI2VuZGlmCj4gICAKPiArI2lmZGVmIENPTkZJR19D
T1JFTkVUX0dFTkVSSUMKPiArZXh0ZXJuIHBoeXNfYWRkcl90IHBwY19kbWFfcGh5c19saW1pdDsK
PiArI2RlZmluZSBBUkNIX0xPV19BRERSRVNTX0xJTUlUCShwcGNfZG1hX3BoeXNfbGltaXQgLSAx
KQo+ICsjZW5kaWYKPiArCj4gKwo+ICAgI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8KPiAgICNlbmRp
ZgkvKiBfQVNNX1BPV0VSUENfRE1BX0ggKi8KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy84NXh4L2NvbW1vbi5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2NvbW1v
bi5jCj4gaW5kZXggZmUwNjA2NDM5YjVhLi4zNDZiNDM2YjZkM2YgMTAwNjQ0Cj4gLS0tIGEvYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2NvbW1vbi5jCj4gKysrIGIvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy84NXh4L2NvbW1vbi5jCj4gQEAgLTEyNiwzICsxMjYsNyBAQCB2b2lkIF9faW5pdCBt
cGM4NXh4X3FlX3Bhcl9pb19pbml0KHZvaWQpCj4gICAJfQo+ICAgfQo+ICAgI2VuZGlmCj4gKwo+
ICsjaWZkZWYgQ09ORklHX0NPUkVORVRfR0VORVJJQwo+ICtwaHlzX2FkZHJfdCBwcGNfZG1hX3Bo
eXNfbGltaXQgPSAweGZmZmZmZmZmVUw7Cj4gKyNlbmRpZgo+IGRpZmYgLS1naXQgYS9hcmNoL3Bv
d2VycGMvcGxhdGZvcm1zLzg1eHgvY29yZW5ldF9nZW5lcmljLmMgYi9hcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzg1eHgvY29yZW5ldF9nZW5lcmljLmMKPiBpbmRleCA3ZWUyYzY2MjhmNjQuLjY3M2Jj
YmRjN2M3NSAxMDA2NDQKPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvY29yZW5l
dF9nZW5lcmljLmMKPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvY29yZW5ldF9n
ZW5lcmljLmMKPiBAQCAtNjQsNyArNjQsNyBAQCB2b2lkIF9faW5pdCBjb3JlbmV0X2dlbl9zZXR1
cF9hcmNoKHZvaWQpCj4gICAJbXBjODV4eF9zbXBfaW5pdCgpOwo+ICAgCj4gICAJc3dpb3RsYl9k
ZXRlY3RfNGcoKTsKPiAtCj4gKwlwcGNfZG1hX3BoeXNfbGltaXQgPSAweDBmZmZmZmZmVUw7Cj4g
ICAJcHJfaW5mbygiJXMgYm9hcmRcbiIsIHBwY19tZC5uYW1lKTsKPiAgIAo+ICAgCW1wYzg1eHhf
cWVfaW5pdCgpOwpIZWxsbyBNaWtlLAoKTXkgUENJIFRWIGNhcmQgd29ya3MgYWxzbyB3aXRoIHlv
dXIgcGF0Y2ghIEJlZm9yZSBJIGhhZCB0byBhZGQgIiNpbmNsdWRlIAo8YXNtL2RtYS5oPiIgdG8g
dGhlIGZpbGUgImFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jb3JlbmV0X2dlbmVyaWMuYyIg
CmJlY2F1c2Ugb2YgdGhlIGZvbGxvd2luZyBlcnJvcjoKCi0tLS0tLQoKIMKgIENDwqDCoMKgwqDC
oCBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvY29yZW5ldF9nZW5lcmljLm8KIMKgIENDwqDC
oMKgwqDCoCBpcGMvdXRpbC5vCiDCoCBDQ8KgwqDCoMKgwqAgaXBjL21zZ3V0aWwubwphcmNoL3Bv
d2VycGMvcGxhdGZvcm1zLzg1eHgvY29yZW5ldF9nZW5lcmljLmM6IEluIGZ1bmN0aW9uIArigJhj
b3JlbmV0X2dlbl9zZXR1cF9hcmNo4oCZOgphcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvY29y
ZW5ldF9nZW5lcmljLmM6Nzc6MjogZXJyb3I6IArigJhwcGNfZG1hX3BoeXNfbGltaXTigJkgdW5k
ZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IAptZWFuIOKAmGNw
dV90b19waHlzX2lk4oCZPwogwqAgcHBjX2RtYV9waHlzX2xpbWl0ID0gMHgwZmZmZmZmZlVMOwog
wqAgXn5+fn5+fn5+fn5+fn5+fn5+CiDCoCBjcHVfdG9fcGh5c19pZAphcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzg1eHgvY29yZW5ldF9nZW5lcmljLmM6Nzc6Mjogbm90ZTogZWFjaCAKdW5kZWNsYXJl
ZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBh
cHBlYXJzIGluCnNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjY1OiByZWNpcGUgZm9yIHRhcmdldCAK
J2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jb3JlbmV0X2dlbmVyaWMubycgZmFpbGVkCm1h
a2VbM106ICoqKiBbYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2NvcmVuZXRfZ2VuZXJpYy5v
XSBFcnJvciAxCnNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTA5OiByZWNpcGUgZm9yIHRhcmdldCAK
J2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eCcgZmFpbGVkCm1ha2VbMl06ICoqKiBbYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy84NXh4XSBFcnJvciAyCnNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTA5
OiByZWNpcGUgZm9yIHRhcmdldCAnYXJjaC9wb3dlcnBjL3BsYXRmb3JtcycgCmZhaWxlZAptYWtl
WzFdOiAqKiogW2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXNdIEVycm9yIDIKTWFrZWZpbGU6MTY1Mjog
cmVjaXBlIGZvciB0YXJnZXQgJ2FyY2gvcG93ZXJwYycgZmFpbGVkCm1ha2U6ICoqKiBbYXJjaC9w
b3dlcnBjXSBFcnJvciAyCgotLS0tLS0KCkFmdGVyIHRoYXQgSSB3YXMgYWJsZSB0byBjb21waWxl
IHRoZSBsYXRlc3QgR2l0IGtlcm5lbCB3aXRoIHlvdXIgcGF0Y2guCgpUaGFua3MsCkNocmlzdGlh
bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
