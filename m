Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E38BC433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 14:41:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C552E21655
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 14:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C552E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C346862D4;
	Tue,  1 Sep 2020 14:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMk0CsCR54b8; Tue,  1 Sep 2020 14:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A726B86203;
	Tue,  1 Sep 2020 14:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97991C0052;
	Tue,  1 Sep 2020 14:41:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4127C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 14:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8C92D203D2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 14:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id linzf40cX2uE for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 14:41:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by silver.osuosl.org (Postfix) with ESMTPS id ACB67203CC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 14:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by a.mx.secunet.com (Postfix) with ESMTP id 3889720482;
 Tue,  1 Sep 2020 16:41:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
 by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRikdZ9yi3Va; Tue,  1 Sep 2020 16:41:45 +0200 (CEST)
Received: from mail-essen-02.secunet.de (mail-essen-02.secunet.de
 [10.53.40.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by a.mx.secunet.com (Postfix) with ESMTPS id C128B201AA;
 Tue,  1 Sep 2020 16:41:45 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mail-essen-02.secunet.de (10.53.40.205) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 1 Sep 2020 16:41:45 +0200
Received: from [172.18.16.185] (172.18.16.185) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 16:41:45 +0200
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <e27cd096-a721-db9d-e4ce-7a432ed6cd4c@secunet.com>
 <12935d0b-61ff-d274-b1ee-3b1fba36bdc7@linux.intel.com>
From: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Subject: Re: [Regression] [PATCH] iommu: Avoid crash in
 init_no_remapping_devices if iommu is NULL
Message-ID: <1eafacd8-8cdb-d6ae-130c-dca66dbe3598@secunet.com>
Date: Tue, 1 Sep 2020 16:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12935d0b-61ff-d274-b1ee-3b1fba36bdc7@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Cc: iommu@lists.linux-foundation.org
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

T24gMDEuMDkuMjAgMDQ6MDIsIEx1IEJhb2x1IHdyb3RlOgpbLi4uXQo+IFRoaXMgbG9va3MgbW9y
ZSBsaWtlIGEgZ2VuZXJpYyBpc3N1ZSwgdXNlZC1iZWZvcmUtYWxsb2NhdGVkLCBhbmQgc2hvdWxk
Cj4gYmUgZml4ZWQgaW4gaW9tbXUuYyBpbnN0ZWFkIG9mIFZULWQgZHJpdmVyLiBIb3cgYWJvdXQK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9p
b21tdS5jCj4gaW5kZXggOGZkOTNhNWI4NzY0Li5hNTk5ZGE4N2ViNjAgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9pb21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gQEAg
LTE5MCw2ICsxOTAsMjggQEAgc3RhdGljIHZvaWQgZGV2X2lvbW11X2ZyZWUoc3RydWN0IGRldmlj
ZSAqZGV2KQo+IMKgwqDCoMKgwqDCoMKgIGRldi0+aW9tbXUgPSBOVUxMOwo+IMKgfQo+IAo+ICt2
b2lkICpkZXZfaW9tbXVfcHJpdl9nZXQoc3RydWN0IGRldmljZSAqZGV2KQo+ICt7Cj4gK8KgwqDC
oMKgwqDCoCBzdHJ1Y3QgZGV2X2lvbW11ICpwYXJhbSA9IGRldl9pb21tdV9nZXQoZGV2KTsKPiAr
Cj4gK8KgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTighcGFyYW0pKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHBhcmFtLT5wcml2Owo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKGRldl9pb21t
dV9wcml2X2dldCk7Cj4gKwo+ICt2b2lkIGRldl9pb21tdV9wcml2X3NldChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHZvaWQgKnByaXYpCj4gK3sKPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZfaW9tbXUg
KnBhcmFtID0gZGV2X2lvbW11X2dldChkZXYpOwo+ICsKPiArwqDCoMKgwqDCoMKgIGlmIChXQVJO
X09OKCFwYXJhbSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICsK
PiArwqDCoMKgwqDCoMKgwqAgcGFyYW0tPnByaXYgPSBwcml2Owo+ICt9Cj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGRldl9pb21tdV9wcml2X3NldCk7Cj4gKwoKVGhpcyBmaXggd291bGQgd29yayBpbiBt
eSBjYXNlLiBJIHRlc3RlZCBpdCB3aXRoIHNsaWdodCBtb2RpZmljYXRpb24gdG8KcmVwbGFjZSB0
aGUgaW5saW5lIHJvdXRpbmVzIGluIGluY2x1ZGUvbGludXgvaW9tbXUuaC4KClRoZSBXQVJOX09O
IHdhcyBub3QgdHJpZ2dlcmVkIGR1cmluZyBteSB0ZXN0cy4gSG93ZXZlciwgbG9va2luZyBhdCB0
aGUKZGVmaW5pdGlvbiBvZiBkZXZfaW9tbXVfZ2V0IHRoaXMgaXMgdG8gYmUgZXhwZWN0ZWQuCgpS
ZWdhcmRzLAoKCVRvcnN0ZW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
