Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9146BC433FE
	for <iommu@archiver.kernel.org>; Tue, 18 Jan 2022 15:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10B6060E2D;
	Tue, 18 Jan 2022 15:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KiEmGFP7CZ6; Tue, 18 Jan 2022 15:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA07660B2D;
	Tue, 18 Jan 2022 15:58:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAAF9C0031;
	Tue, 18 Jan 2022 15:58:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27D5EC002F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 15:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 1490A400D3
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 15:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id VGpttArt32i6 for <iommu@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:58:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id C9989400CF
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 15:58:05 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1642521485; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=kZDrU8Dg8Jr5jR4QX28dOeZKIG/4+04z5OJQI5wFtME=;
 b=FHyR6EPQkI8ZMAstIG0CEJ/Z7O+CioPAUnJelfDYPY7XtwuhO5p8RwVMeOH+JIPPg4pzE+WY
 6uLeiSyqefkihgVJ5tCI5mLKoHL9bV2Z68gavU/jxeCeQt0AwPXTZiDSc+NL9e8+FFDymiE0
 8nie7gALlrkZUrqvuhrJb6y0rZ4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61e6e38c62864ab10102cf53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Jan 2022 15:58:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id F1C89C43618; Tue, 18 Jan 2022 15:58:03 +0000 (UTC)
Received: from [192.168.0.100] (unknown [103.164.200.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D678C4338F;
 Tue, 18 Jan 2022 15:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4D678C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=quicinc.com
Subject: Re: [PATCH v3] iommu: Fix potential use-after-free during probe
To: Robin Murphy <robin.murphy@arm.com>,
 Vijayanand Jitta <quic_vjitta@quicinc.com>, joro@8bytes.org,
 will@kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1641993184-1232-1-git-send-email-quic_vjitta@quicinc.com>
 <9913d026-fddd-c188-0873-0f7a66fb2c3c@arm.com>
From: Vijayanand Jitta <quic_vjitta@quicinc.com>
Message-ID: <5f923b2d-645c-a7df-e16b-e8526015db32@quicinc.com>
Date: Tue, 18 Jan 2022 21:27:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9913d026-fddd-c188-0873-0f7a66fb2c3c@arm.com>
Content-Language: en-GB
Cc: kernel-team@android.com
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

CgpPbiAxLzE4LzIwMjIgNzoxOSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDEt
MTIgMTM6MTMsIFZpamF5YW5hbmQgSml0dGEgd3JvdGU6Cj4+IEthc2FuIGhhcyByZXBvcnRlZCB0
aGUgZm9sbG93aW5nIHVzZSBhZnRlciBmcmVlIG9uIGRldi0+aW9tbXUuCj4+IHdoZW4gYSBkZXZp
Y2UgcHJvYmUgZmFpbHMgYW5kIGl0IGlzIGluIHByb2Nlc3Mgb2YgZnJlZWluZyBkZXYtPmlvbW11
Cj4+IGluIGRldl9pb21tdV9mcmVlIGZ1bmN0aW9uLCBhIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVu
YyBydW5zIGluIHBhcmFsbGVsCj4+IGFuZCB0cmllcyB0byBhY2Nlc3MgZGV2LT5pb21tdS0+Zndz
cGVjIGluIG9mX2lvbW11X2NvbmZpZ3VyZSBwYXRoIHRodXMKPj4gY2F1c2luZyB1c2UgYWZ0ZXIg
ZnJlZS4KPj4KPj4gQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4gb2ZfaW9tbXVfY29uZmln
dXJlKzB4YjQvMHg0YTQKPj4gUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZmZmY4N2EyZjFhY2I4
IGJ5IHRhc2sga3dvcmtlci91MTY6Mi8xNTMKPj4KPj4gV29ya3F1ZXVlOiBldmVudHNfdW5ib3Vu
ZCBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMKPj4gQ2FsbCB0cmFjZToKPj4gwqAgZHVtcF9iYWNr
dHJhY2UrMHgwLzB4MzNjCj4+IMKgIHNob3dfc3RhY2srMHgxOC8weDI0Cj4+IMKgIGR1bXBfc3Rh
Y2tfbHZsKzB4MTZjLzB4MWUwCj4+IMKgIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24rMHg4NC8w
eDM5Ywo+PiDCoCBfX2thc2FuX3JlcG9ydCsweDE4NC8weDMwOAo+PiDCoCBrYXNhbl9yZXBvcnQr
MHg1MC8weDc4Cj4+IMKgIF9fYXNhbl9sb2FkOCsweGMwLzB4YzQKPj4gwqAgb2ZfaW9tbXVfY29u
ZmlndXJlKzB4YjQvMHg0YTQKPj4gwqAgb2ZfZG1hX2NvbmZpZ3VyZV9pZCsweDJmYy8weDRkNAo+
PiDCoCBwbGF0Zm9ybV9kbWFfY29uZmlndXJlKzB4NDAvMHg1Ywo+PiDCoCByZWFsbHlfcHJvYmUr
MHgxYjQvMHhiNzQKPj4gwqAgZHJpdmVyX3Byb2JlX2RldmljZSsweDExYy8weDIyOAo+PiDCoCBf
X2RldmljZV9hdHRhY2hfZHJpdmVyKzB4MTRjLzB4MzA0Cj4+IMKgIGJ1c19mb3JfZWFjaF9kcnYr
MHgxMjQvMHgxYjAKPj4gwqAgX19kZXZpY2VfYXR0YWNoKzB4MjVjLzB4MzM0Cj4+IMKgIGRldmlj
ZV9pbml0aWFsX3Byb2JlKzB4MjQvMHgzNAo+PiDCoCBidXNfcHJvYmVfZGV2aWNlKzB4NzgvMHgx
MzQKPj4gwqAgZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jKzB4MTMwLzB4MWE4Cj4+IMKgIHByb2Nl
c3Nfb25lX3dvcmsrMHg0YzgvMHg5NzAKPj4gwqAgd29ya2VyX3RocmVhZCsweDVjOC8weGFlYwo+
PiDCoCBrdGhyZWFkKzB4MWY4LzB4MjIwCj4+IMKgIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4Cj4+
Cj4+IEFsbG9jYXRlZCBieSB0YXNrIDE6Cj4+IMKgIF9fX19rYXNhbl9rbWFsbG9jKzB4ZDQvMHgx
MTQKPj4gwqAgX19rYXNhbl9rbWFsbG9jKzB4MTAvMHgxYwo+PiDCoCBrbWVtX2NhY2hlX2FsbG9j
X3RyYWNlKzB4ZTQvMHgzZDQKPj4gwqAgX19pb21tdV9wcm9iZV9kZXZpY2UrMHg5MC8weDM5NAo+
PiDCoCBwcm9iZV9pb21tdV9ncm91cCsweDcwLzB4OWMKPj4gwqAgYnVzX2Zvcl9lYWNoX2Rldisw
eDExYy8weDE5Ywo+PiDCoCBidXNfaW9tbXVfcHJvYmUrMHhiOC8weDdkNAo+PiDCoCBidXNfc2V0
X2lvbW11KzB4Y2MvMHgxM2MKPj4gwqAgYXJtX3NtbXVfYnVzX2luaXQrMHg0NC8weDEzMCBbYXJt
X3NtbXVdCj4+IMKgIGFybV9zbW11X2RldmljZV9wcm9iZSsweGI4OC8weGM1NCBbYXJtX3NtbXVd
Cj4+IMKgIHBsYXRmb3JtX2Rydl9wcm9iZSsweGU0LzB4MTNjCj4+IMKgIHJlYWxseV9wcm9iZSsw
eDJjOC8weGI3NAo+PiDCoCBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MTFjLzB4MjI4Cj4+IMKgIGRl
dmljZV9kcml2ZXJfYXR0YWNoKzB4ZjAvMHgxNmMKPj4gwqAgX19kcml2ZXJfYXR0YWNoKzB4ODAv
MHgzMjAKPj4gwqAgYnVzX2Zvcl9lYWNoX2RldisweDExYy8weDE5Ywo+PiDCoCBkcml2ZXJfYXR0
YWNoKzB4MzgvMHg0OAo+PiDCoCBidXNfYWRkX2RyaXZlcisweDFkYy8weDNhNAo+PiDCoCBkcml2
ZXJfcmVnaXN0ZXIrMHgxOGMvMHgyNDQKPj4gwqAgX19wbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIr
MHg4OC8weDljCj4+IMKgIGluaXRfbW9kdWxlKzB4NjQvMHhmZjQgW2FybV9zbW11XQo+PiDCoCBk
b19vbmVfaW5pdGNhbGwrMHgxN2MvMHgyZjAKPj4gwqAgZG9faW5pdF9tb2R1bGUrMHhlOC8weDM3
OAo+PiDCoCBsb2FkX21vZHVsZSsweDNmODAvMHg0YTQwCj4+IMKgIF9fc2Vfc3lzX2Zpbml0X21v
ZHVsZSsweDFhMC8weDFlNAo+PiDCoCBfX2FybTY0X3N5c19maW5pdF9tb2R1bGUrMHg0NC8weDU4
Cj4+IMKgIGVsMF9zdmNfY29tbW9uKzB4MTAwLzB4MjY0Cj4+IMKgIGRvX2VsMF9zdmMrMHgzOC8w
eGE0Cj4+IMKgIGVsMF9zdmMrMHgyMC8weDMwCj4+IMKgIGVsMF9zeW5jX2hhbmRsZXIrMHg2OC8w
eGFjCj4+IMKgIGVsMF9zeW5jKzB4MTYwLzB4MTgwCj4+Cj4+IEZyZWVkIGJ5IHRhc2sgMToKPj4g
wqAga2FzYW5fc2V0X3RyYWNrKzB4NGMvMHg4NAo+PiDCoCBrYXNhbl9zZXRfZnJlZV9pbmZvKzB4
MjgvMHg0Ywo+PiDCoCBfX19fa2FzYW5fc2xhYl9mcmVlKzB4MTIwLzB4MTVjCj4+IMKgIF9fa2Fz
YW5fc2xhYl9mcmVlKzB4MTgvMHgyOAo+PiDCoCBzbGFiX2ZyZWVfZnJlZWxpc3RfaG9vaysweDIw
NC8weDJmYwo+PiDCoCBrZnJlZSsweGZjLzB4M2E0Cj4+IMKgIF9faW9tbXVfcHJvYmVfZGV2aWNl
KzB4Mjg0LzB4Mzk0Cj4+IMKgIHByb2JlX2lvbW11X2dyb3VwKzB4NzAvMHg5Ywo+PiDCoCBidXNf
Zm9yX2VhY2hfZGV2KzB4MTFjLzB4MTljCj4+IMKgIGJ1c19pb21tdV9wcm9iZSsweGI4LzB4N2Q0
Cj4+IMKgIGJ1c19zZXRfaW9tbXUrMHhjYy8weDEzYwo+PiDCoCBhcm1fc21tdV9idXNfaW5pdCsw
eDQ0LzB4MTMwIFthcm1fc21tdV0KPj4gwqAgYXJtX3NtbXVfZGV2aWNlX3Byb2JlKzB4Yjg4LzB4
YzU0IFthcm1fc21tdV0KPj4gwqAgcGxhdGZvcm1fZHJ2X3Byb2JlKzB4ZTQvMHgxM2MKPj4gwqAg
cmVhbGx5X3Byb2JlKzB4MmM4LzB4Yjc0Cj4+IMKgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgxMWMv
MHgyMjgKPj4gwqAgZGV2aWNlX2RyaXZlcl9hdHRhY2grMHhmMC8weDE2Ywo+PiDCoCBfX2RyaXZl
cl9hdHRhY2grMHg4MC8weDMyMAo+PiDCoCBidXNfZm9yX2VhY2hfZGV2KzB4MTFjLzB4MTljCj4+
IMKgIGRyaXZlcl9hdHRhY2grMHgzOC8weDQ4Cj4+IMKgIGJ1c19hZGRfZHJpdmVyKzB4MWRjLzB4
M2E0Cj4+IMKgIGRyaXZlcl9yZWdpc3RlcisweDE4Yy8weDI0NAo+PiDCoCBfX3BsYXRmb3JtX2Ry
aXZlcl9yZWdpc3RlcisweDg4LzB4OWMKPj4gwqAgaW5pdF9tb2R1bGUrMHg2NC8weGZmNCBbYXJt
X3NtbXVdCj4+IMKgIGRvX29uZV9pbml0Y2FsbCsweDE3Yy8weDJmMAo+PiDCoCBkb19pbml0X21v
ZHVsZSsweGU4LzB4Mzc4Cj4+IMKgIGxvYWRfbW9kdWxlKzB4M2Y4MC8weDRhNDAKPj4gwqAgX19z
ZV9zeXNfZmluaXRfbW9kdWxlKzB4MWEwLzB4MWU0Cj4+IMKgIF9fYXJtNjRfc3lzX2Zpbml0X21v
ZHVsZSsweDQ0LzB4NTgKPj4gwqAgZWwwX3N2Y19jb21tb24rMHgxMDAvMHgyNjQKPj4gwqAgZG9f
ZWwwX3N2YysweDM4LzB4YTQKPj4gwqAgZWwwX3N2YysweDIwLzB4MzAKPj4gwqAgZWwwX3N5bmNf
aGFuZGxlcisweDY4LzB4YWMKPj4gwqAgZWwwX3N5bmMrMHgxNjAvMHgxODAKPj4KPj4gRml4IHRo
aXMgYnkgdGFraW5nIGRldmljZV9sb2NrIGR1cmluZyBwcm9iZV9pb21tdV9ncm91cC4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogVmlqYXlhbmFuZCBKaXR0YSA8cXVpY192aml0dGFAcXVpY2luYy5jb20+
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCAxMiArKysrKysrKy0tLS0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUu
Ywo+PiBpbmRleCBkZDc4NjNlLi4yNjE3OTJkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+IEBAIC0xNjE3LDcgKzE2
MTcsNyBAQCBzdGF0aWMgaW50IHByb2JlX2lvbW11X2dyb3VwKHN0cnVjdCBkZXZpY2UgKmRldiwK
Pj4gdm9pZCAqZGF0YSkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWQgKmdy
b3VwX2xpc3QgPSBkYXRhOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXA7
Cj4+IC3CoMKgwqAgaW50IHJldDsKPj4gK8KgwqDCoCBpbnQgcmV0ID0gMDsKPj4gwqAgwqDCoMKg
wqDCoCAvKiBEZXZpY2UgaXMgcHJvYmVkIGFscmVhZHkgaWYgaW4gYSBncm91cCAqLwo+PiDCoMKg
wqDCoMKgIGdyb3VwID0gaW9tbXVfZ3JvdXBfZ2V0KGRldik7Cj4+IEBAIC0xNjI2LDkgKzE2MjYs
MTMgQEAgc3RhdGljIGludCBwcm9iZV9pb21tdV9ncm91cChzdHJ1Y3QgZGV2aWNlCj4+ICpkZXYs
IHZvaWQgKmRhdGEpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqDCoMKgwqDC
oCB9Cj4+IMKgIC3CoMKgwqAgcmV0ID0gX19pb21tdV9wcm9iZV9kZXZpY2UoZGV2LCBncm91cF9s
aXN0KTsKPj4gLcKgwqDCoCBpZiAocmV0ID09IC1FTk9ERVYpCj4+IC3CoMKgwqDCoMKgwqDCoCBy
ZXQgPSAwOwo+PiArwqDCoMKgIHJldCA9IGRldmljZV90cnlsb2NrKGRldik7Cj4+ICvCoMKgwqAg
aWYgKHJldCkgewo+IAo+IFRoaXMgZG9lc24ndCBzZWVtIHJpZ2h0IC0gd2UgY2FuJ3QgaGF2ZSBh
IG5vbi1kZXRlcm1pbmlzdGljIHNpdHVhdGlvbgo+IHdoZXJlIF9faW9tbXVfcHJvYmVfZGV2aWNl
KCkgbWF5IG9yIG1heSBub3QgYmUgY2FsbGVkIGRlcGVuZGluZyBvbiB3aGF0Cj4gYW55b25lIGVs
c2UgbWlnaHQgYmUgZG9pbmcgd2l0aCB0aGUgZGV2aWNlIGF0IHRoZSBzYW1lIHRpbWUuCj4gCj4g
SSBkb24ndCBmdWxseSB1bmRlcnN0YW5kIGhvdyBfX2lvbW11X3Byb2JlX2RldmljZSgpIGFuZAo+
IG9mX2lvbW11X2NvbmZpZ3VyZSgpIGNhbiBiZSBydW5uaW5nIGZvciB0aGUgc2FtZSBkZXZpY2Ug
YXQgdGhlIHNhbWUKPiB0aW1lLCBidXQgaWYgdGhhdCdzIG5vdCBhIHJhY2Ugd2hpY2ggY2FuIGJl
IGZpeGVkIGluIGl0cyBvd24gcmlnaHQsIHRoZW4KClRoYW5rcyBmb3IgdGhlIHJldmlldyBjb21t
ZW50cy4KCkR1cmluZyBhcm1fc21tdSBwcm9iZSwgYnVzX2Zvcl9lYWNoX2RldiBpcyBjYWxsZWQg
d2hpY2ggY2FsbHMKX19pb21tdV9wcm9iZV9kZXZpY2UgZm9yIGVhY2ggYWxsIHRoZSBkZXZzIG9u
IHRoYXQgYnVzLgoKICAgX19pb21tdV9wcm9iZV9kZXZpY2UrMHg5MC8weDM5NAogICBwcm9iZV9p
b21tdV9ncm91cCsweDcwLzB4OWMKICAgYnVzX2Zvcl9lYWNoX2RldisweDExYy8weDE5YwogICBi
dXNfaW9tbXVfcHJvYmUrMHhiOC8weDdkNAogICBidXNfc2V0X2lvbW11KzB4Y2MvMHgxM2MKICAg
YXJtX3NtbXVfYnVzX2luaXQrMHg0NC8weDEzMCBbYXJtX3NtbXVdCiAgIGFybV9zbW11X2Rldmlj
ZV9wcm9iZSsweGI4OC8weGM1NCBbYXJtX3NtbXVdCgphbmQgdGhlIGRlZmVycmVkIHByb2JlIGZ1
bmN0aW9uIGlzIGNhbGxpbmcgb2ZfaW9tbXVfY29uZmlndXJlIG9uIHRoZQpzYW1lIGRldiB3aGlj
aCBpcyBjdXJyZW50bHkgaW4gX19pb21tdV9wcm9iZV9kZXZpY2UgcGF0aCBpbiB0aGlzIGNhc2UK
dGh1cyBjYXVzaW5nIHRoZSByYWNlLgoKPiBJIHRoaW5rIGFkZGluZyBhIHJlZmNvdW50IHRvIGRl
dl9pb21tdSB3b3VsZCBiZSBhIG1vcmUgc2Vuc2libGUgd2F5IHRvCj4gbWl0aWdhdGUgaXQuCgpS
aWdodCwgQWRkaW5nIHJlZmNvdW50IGZvciBkZXZfaW9tbXUgc2hvdWxkIGhlbHAgLCBJJ2xsIHBv
c3QgYSBuZXcgcGF0Y2gKd2l0aCBpdC4KClRoYW5rcywKVmlqYXkKPiAKPiBSb2Jpbi4KPiAKPj4g
K8KgwqDCoMKgwqDCoMKgIHJldCA9IF9faW9tbXVfcHJvYmVfZGV2aWNlKGRldiwgZ3JvdXBfbGlz
dCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0ID09IC1FTk9ERVYpCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldCA9IDA7Cj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZpY2VfdW5sb2NrKGRl
dik7Cj4+ICvCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IMKgIH0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
