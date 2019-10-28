Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D1CA9EBE
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 10:55:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7AB20873
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 10:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="evqCuT/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7AB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C4C3C10C6;
	Mon, 28 Oct 2019 10:55:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CBC1510BC
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 10:55:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
	[62.209.51.94])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7761B14D
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 10:55:10 +0000 (UTC)
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
	x9SAjnpp032399; Mon, 28 Oct 2019 11:55:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=STMicroelectronics;
	bh=zjsQdHFc/W0m7opfzLvR4NJzrR4/uNd4FXJ7CriyM5M=;
	b=evqCuT/t4tzuDhBYDAPiRPboyHAVdq3u1DSRxIkoya5gGp+OYylgIyKMFqMqKPAj5D56
	XbUuBkHZkPcvvnZ2kmB5Adpz1czcvrvS9KJPppr8B6aOWnAZLI9kwUOcQbKv1byXb62r
	cvsT+2UBWi+Z/OUgoMPRn+CjnGUDI5GWMJN1hBV0gvUbcbd3xwbS/C8Q3hi8m1HZDcoI
	mmp4cZ3mGVvxSYNW5pYzxxX2rnZ0/IQfyzwrWkEhMG8w3mQSs8U++6T5JJsKAXsskv8n
	7Y0qfKPJv67oTFUaCfgMO2yEm/MI744EtJysmYw76Mb9zQqoYhaj5ozvMGn5e0vX3Fpv
	Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 2vvbww1svx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Mon, 28 Oct 2019 11:55:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41ABD10002A;
	Mon, 28 Oct 2019 11:55:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D0802C49F3; 
	Mon, 28 Oct 2019 11:55:05 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
	(10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2;
	Mon, 28 Oct 2019 11:55:04 +0100
Subject: Re: [BUG] dma-ranges, reserved memory regions, dma_alloc_coherent:
	possible bug?
To: Vladimir Murzin <vladimir.murzin@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Daniele Alessandrelli
	<daniele.alessandrelli@gmail.com>, Christoph Hellwig <hch@lst.de>, Marek
	Szyprowski <m.szyprowski@samsung.com>
References: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
	<d983cf57-f13d-a680-21c4-09b5ca93bc64@arm.com>
	<acf0dd2c-7e12-fba6-b7f8-dfd78c892fe5@arm.com>
	<417fa080-08f9-9f35-687b-c0b82a61628d@arm.com>
	<376133e3-25f2-ffe7-ef9f-4613388b2bf7@arm.com>
	<84747008-85e9-e71a-b9ad-cefcc6c0f661@st.com>
	<3305c91e-e630-b7fd-4c6f-598583504d67@arm.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <6b024e69-f612-6850-8a04-9b3049549092@st.com>
Date: Mon, 28 Oct 2019 11:55:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3305c91e-e630-b7fd-4c6f-598583504d67@arm.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
	(10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
	definitions=2019-10-28_05:2019-10-25,2019-10-28 signatures=0
Cc: iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgVmxhZCwKCk9uIDEwLzI0LzE5IDU6MjcgUE0sIFZsYWRpbWlyIE11cnppbiB3cm90ZToKPiBI
aSBBbGV4LAo+IAo+IE9uIDEwLzI0LzE5IDQ6MjAgUE0sIEFsZXhhbmRyZSBUb3JndWUgd3JvdGU6
Cj4+IEhpIFZsYWQsCj4+Cj4+IE9uIDEwLzI0LzE5IDI6NDMgUE0sIFZsYWRpbWlyIE11cnppbiB3
cm90ZToKPj4+IE9uIDEwLzE3LzE5IDEwOjQ2IEFNLCBWbGFkaW1pciBNdXJ6aW4gd3JvdGU6Cj4+
Pj4gSSdtIHdvbmRlcmluZyBpZiBJJ3ZlIG1pc3NlZCBzb21ldGhpbmcgd2l0aCBkaWZmIGJlbGxv
dyAoaXQgd2FzIGEgbG9uZyB0aW1lIGFnbyB3aGVuIEkgdG91Y2hlZCBETUEpPwo+Pj4KPj4+IEFu
eSBjb21tZW50cyBvbiB0aGF0PyBJIGNhbiBvbmx5IGJ1aWxkIHRlc3QgaXQsIHNvIGxhY2sgb2Yg
dGVzdGluZyBzdG9wcGluZyBtZSBmcm9tIHNlbmRpbmcgaXQgYXMgYQo+Pj4gcHJvcGVyIHBhdGNo
IDooCj4+Cj4+IEkgY2FuIG1ha2Ugc29tZSB0ZXN0cyB0b21vcnJvdy4gV2hpY2ggcGFydGljdWxh
ciBzZXR1cCBJIG5lZWQgdG8gdGVzdDogY29ydGV4IE03ICsgY2FjaGUgKyBkbWEgKyB4aXAgPyBM
ZXQgbWUga25vdy4KPiAKPiBJIGFzc3VtZSB4aXAgaW1wbGllcyBkbWEtcmFuZ2VzIGluIGR0LCB0
aGVuIHllcyBpdCBsb29rcyBsaWtlIHdoYXQgd2UgbmVlZC4KPiAKCkkgdGVzdGVkIHlvdXIgcGF0
Y2ggb24gc3RtMzJoNzQzMS1ldmFsIGJvYXJkIChjb3J0ZXgtTTcpLiBObyBpc3N1ZXMgCnJlcG9y
dGVkLiBJIHVzZSByZXNlcnZlZCBkbWEgbWVtb3J5IHBvb2wgZm9yIGRtYSBhY2Nlc3MgKCBEY2Fj
aGUgCmRpc2FibGVkKSBhbmQgZG1hX2FsbG9jX2NvaGVyZW50IGlzIG9rLiBOb3RlIHRoZXJlIGlz
IG5vICJkbWEtcmFuZ2VzIiAKZm9yIHRoaXMgYm9hcmQuCgpJIGFsc28gdGVzdGVkIGl0IG9uIHN0
bTMyZjQ2OS1kaXNjbyAoY29ydGV4LU00KSB3aGljaCB1c2VzIGRtYS1yYW5nZXMuIApObyBpc3N1
ZXMgcmVwb3J0ZWQgdG9vLiBOb3RlIHRoZXJlIGlzIG5vIGRhdGEgY2FjaGUgYXQgYWxsIGluIHRo
aXMgY2FzZS4KCnJlZ2FyZHMKCkFsZXgKCj4gR3JlYXQgdGhhbmtzIQo+IAo+IFZsYWRpbWlyCj4g
Cj4+Cj4+IHJlZ2FyZHMKPj4gYWxleAo+Pgo+Pj4KPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9tbS9kbWEtbWFwcGluZy1ub21tdS5jIGIvYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmctbm9t
bXUuYwo+Pj4+IGluZGV4IGRiOTI0NzguLjI4N2VmODkgMTAwNjQ0Cj4+Pj4gLS0tIGEvYXJjaC9h
cm0vbW0vZG1hLW1hcHBpbmctbm9tbXUuYwo+Pj4+ICsrKyBiL2FyY2gvYXJtL21tL2RtYS1tYXBw
aW5nLW5vbW11LmMKPj4+PiBAQCAtMzUsNyArMzUsNyBAQCBzdGF0aWMgdm9pZCAqYXJtX25vbW11
X2RtYV9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLAo+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhdHRycykKPj4+PiAg
wqAgwqAgewo+Pj4+IC3CoMKgwqAgdm9pZCAqcmV0ID0gZG1hX2FsbG9jX2Zyb21fZ2xvYmFsX2Nv
aGVyZW50KHNpemUsIGRtYV9oYW5kbGUpOwo+Pj4+ICvCoMKgwqAgdm9pZCAqcmV0ID0gZG1hX2Fs
bG9jX2Zyb21fZ2xvYmFsX2NvaGVyZW50KGRldiwgc2l6ZSwgZG1hX2hhbmRsZSk7Cj4+Pj4gIMKg
IMKgwqDCoMKgwqAgLyoKPj4+PiAgwqDCoMKgwqDCoMKgICogZG1hX2FsbG9jX2Zyb21fZ2xvYmFs
X2NvaGVyZW50KCkgbWF5IGZhaWwgYmVjYXVzZToKPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9kbWEtbWFwcGluZy5oIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCj4+Pj4gaW5k
ZXggNGExYzRmYy4uMTA5MThjNSAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1t
YXBwaW5nLmgKPj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKPj4+PiBAQCAt
MTYyLDcgKzE2Miw3IEBAIGludCBkbWFfcmVsZWFzZV9mcm9tX2Rldl9jb2hlcmVudChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIGludCBvcmRlciwgdm9pZCAqdmFkZHIpOwo+Pj4+ICDCoCBpbnQgZG1hX21t
YXBfZnJvbV9kZXZfY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSwKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lk
ICpjcHVfYWRkciwgc2l6ZV90IHNpemUsIGludCAqcmV0KTsKPj4+PiAgwqAgLXZvaWQgKmRtYV9h
bGxvY19mcm9tX2dsb2JhbF9jb2hlcmVudChzc2l6ZV90IHNpemUsIGRtYV9hZGRyX3QgKmRtYV9o
YW5kbGUpOwo+Pj4+ICt2b2lkICpkbWFfYWxsb2NfZnJvbV9nbG9iYWxfY29oZXJlbnQoc3RydWN0
IGRldmljZSAqZGV2LCBzc2l6ZV90IHNpemUsIGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUpOwo+Pj4+
ICDCoCBpbnQgZG1hX3JlbGVhc2VfZnJvbV9nbG9iYWxfY29oZXJlbnQoaW50IG9yZGVyLCB2b2lk
ICp2YWRkcik7Cj4+Pj4gIMKgIGludCBkbWFfbW1hcF9mcm9tX2dsb2JhbF9jb2hlcmVudChzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdm9pZCAqY3B1X2FkZHIsCj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCBzaXplLCBpbnQgKnJldCk7Cj4+Pj4g
QEAgLTE3Miw3ICsxNzIsNyBAQCBpbnQgZG1hX21tYXBfZnJvbV9nbG9iYWxfY29oZXJlbnQoc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHZvaWQgKmNwdV9hZGRyLAo+Pj4+ICDCoCAjZGVmaW5l
IGRtYV9yZWxlYXNlX2Zyb21fZGV2X2NvaGVyZW50KGRldiwgb3JkZXIsIHZhZGRyKSAoMCkKPj4+
PiAgwqAgI2RlZmluZSBkbWFfbW1hcF9mcm9tX2Rldl9jb2hlcmVudChkZXYsIHZtYSwgdmFkZHIs
IG9yZGVyLCByZXQpICgwKQo+Pj4+ICDCoCAtc3RhdGljIGlubGluZSB2b2lkICpkbWFfYWxsb2Nf
ZnJvbV9nbG9iYWxfY29oZXJlbnQoc3NpemVfdCBzaXplLAo+Pj4+ICtzdGF0aWMgaW5saW5lIHZv
aWQgKmRtYV9hbGxvY19mcm9tX2dsb2JhbF9jb2hlcmVudChzdHJ1Y3QgZGV2aWNlICpkZXYsIHNz
aXplX3Qgc2l6ZSwKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCAqZG1hX2hhbmRsZSkKPj4+PiAgwqAgewo+Pj4+
ICDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL2Nv
aGVyZW50LmMgYi9rZXJuZWwvZG1hL2NvaGVyZW50LmMKPj4+PiBpbmRleCA1NDVlMzg2Li41NTFi
MGViIDEwMDY0NAo+Pj4+IC0tLSBhL2tlcm5lbC9kbWEvY29oZXJlbnQuYwo+Pj4+ICsrKyBiL2tl
cm5lbC9kbWEvY29oZXJlbnQuYwo+Pj4+IEBAIC0xMjMsOCArMTIzLDkgQEAgaW50IGRtYV9kZWNs
YXJlX2NvaGVyZW50X21lbW9yeShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHBoeXNf
YWRkciwKPj4+PiAgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+ICDCoCB9Cj4+Pj4gIMKgIC1z
dGF0aWMgdm9pZCAqX19kbWFfYWxsb2NfZnJvbV9jb2hlcmVudChzdHJ1Y3QgZG1hX2NvaGVyZW50
X21lbSAqbWVtLAo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBzc2l6ZV90IHNpemUsIGRtYV9hZGRyX3Qg
KmRtYV9oYW5kbGUpCj4+Pj4gK3N0YXRpYyB2b2lkICpfX2RtYV9hbGxvY19mcm9tX2NvaGVyZW50
KHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9jb2hlcmVudF9tZW0gKm1lbSwKPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3NpemVfdCBzaXplLCBkbWFf
YWRkcl90ICpkbWFfaGFuZGxlKQo+Pj4+ICDCoCB7Cj4+Pj4gIMKgwqDCoMKgwqAgaW50IG9yZGVy
ID0gZ2V0X29yZGVyKHNpemUpOwo+Pj4+ICDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7
Cj4+Pj4gQEAgLTE0Myw3ICsxNDQsNyBAQCBzdGF0aWMgdm9pZCAqX19kbWFfYWxsb2NfZnJvbV9j
b2hlcmVudChzdHJ1Y3QgZG1hX2NvaGVyZW50X21lbSAqbWVtLAo+Pj4+ICDCoMKgwqDCoMKgIC8q
Cj4+Pj4gIMKgwqDCoMKgwqDCoCAqIE1lbW9yeSB3YXMgZm91bmQgaW4gdGhlIGNvaGVyZW50IGFy
ZWEuCj4+Pj4gIMKgwqDCoMKgwqDCoCAqLwo+Pj4+IC3CoMKgwqAgKmRtYV9oYW5kbGUgPSBtZW0t
PmRldmljZV9iYXNlICsgKHBhZ2VubyA8PCBQQUdFX1NISUZUKTsKPj4+PiArwqDCoMKgICpkbWFf
aGFuZGxlID0gZG1hX2dldF9kZXZpY2VfYmFzZShkZXYsIG1lbSkgKyAocGFnZW5vIDw8IFBBR0Vf
U0hJRlQpOwo+Pj4+ICDCoMKgwqDCoMKgIHJldCA9IG1lbS0+dmlydF9iYXNlICsgKHBhZ2VubyA8
PCBQQUdFX1NISUZUKTsKPj4+PiAgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZt
ZW0tPnNwaW5sb2NrLCBmbGFncyk7Cj4+Pj4gIMKgwqDCoMKgwqAgbWVtc2V0KHJldCwgMCwgc2l6
ZSk7Cj4+Pj4gQEAgLTE3NSwxNyArMTc2LDE4IEBAIGludCBkbWFfYWxsb2NfZnJvbV9kZXZfY29o
ZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzc2l6ZV90IHNpemUsCj4+Pj4gIMKgwqDCoMKgwqAg
aWYgKCFtZW0pCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiAgwqAgLcKg
wqDCoCAqcmV0ID0gX19kbWFfYWxsb2NfZnJvbV9jb2hlcmVudChtZW0sIHNpemUsIGRtYV9oYW5k
bGUpOwo+Pj4+ICvCoMKgwqAgKnJldCA9IF9fZG1hX2FsbG9jX2Zyb21fY29oZXJlbnQoZGV2LCBt
ZW0sIHNpemUsIGRtYV9oYW5kbGUpOwo+Pj4+ICDCoMKgwqDCoMKgIHJldHVybiAxOwo+Pj4+ICDC
oCB9Cj4+Pj4gIMKgIC12b2lkICpkbWFfYWxsb2NfZnJvbV9nbG9iYWxfY29oZXJlbnQoc3NpemVf
dCBzaXplLCBkbWFfYWRkcl90ICpkbWFfaGFuZGxlKQo+Pj4+ICt2b2lkICpkbWFfYWxsb2NfZnJv
bV9nbG9iYWxfY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzc2l6ZV90IHNpemUsCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCAqZG1h
X2hhbmRsZSkKPj4+PiAgwqAgewo+Pj4+ICDCoMKgwqDCoMKgIGlmICghZG1hX2NvaGVyZW50X2Rl
ZmF1bHRfbWVtb3J5KQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4+Pj4g
IMKgIC3CoMKgwqAgcmV0dXJuIF9fZG1hX2FsbG9jX2Zyb21fY29oZXJlbnQoZG1hX2NvaGVyZW50
X2RlZmF1bHRfbWVtb3J5LCBzaXplLAo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9o
YW5kbGUpOwo+Pj4+ICvCoMKgwqAgcmV0dXJuIF9fZG1hX2FsbG9jX2Zyb21fY29oZXJlbnQoZGV2
LCBkbWFfY29oZXJlbnRfZGVmYXVsdF9tZW1vcnksIHNpemUsCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2hhbmRsZSk7Cj4+Pj4gIMKgIH0KPj4+PiAg
wqAgwqAgc3RhdGljIGludCBfX2RtYV9yZWxlYXNlX2Zyb21fY29oZXJlbnQoc3RydWN0IGRtYV9j
b2hlcmVudF9tZW0gKm1lbSwKPj4+Cj4+Pgo+Pj4gVGhhbmtzCj4+PiBWbGFkaW1pcgo+Pj4KPiAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
