Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9828C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:27:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C20D2081A
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C20D2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 754D485EB8;
	Fri, 26 Jun 2020 12:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZGTLvlVlcCi; Fri, 26 Jun 2020 12:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B96D385BD0;
	Fri, 26 Jun 2020 12:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98466C0863;
	Fri, 26 Jun 2020 12:27:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97751C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7F21D2353A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PCPdToW0BvG8 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 12:22:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 0F41222E96
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:22:46 +0000 (UTC)
IronPort-SDR: apHpdmHCLDL1d5pkcPqSzGniI6nyF38i1s44JQVx/lCFGolm6iDiyXIvALRnrG7uVsJp6X42Mk
 77KVwQ0CA/HA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="133684245"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; d="scan'208";a="133684245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 05:22:46 -0700
IronPort-SDR: F5eHo2m2CFQpkNJaLvMJixEf0mOWgyXmWSFNR0ssn6jmoARey1jsvDfPfsk2m3B9/kk+8TIjqL
 8AK8eNcG2bhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; d="scan'208";a="301047902"
Received: from swallace-mobl2.ger.corp.intel.com (HELO
 btopel-mobl.ger.intel.com) ([10.252.52.84])
 by orsmga007.jf.intel.com with ESMTP; 26 Jun 2020 05:22:42 -0700
Subject: Re: the XSK buffer pool needs be to reverted
To: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
References: <20200626074725.GA21790@lst.de>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <f1512c3e-79eb-ba75-6f38-ca09795973c1@intel.com>
Date: Fri, 26 Jun 2020 14:22:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626074725.GA21790@lst.de>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 26 Jun 2020 12:27:55 +0000
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>
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

T24gMjAyMC0wNi0yNiAwOTo0NywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gSGkgQmrDtnJu
LAo+IAo+IHlvdSBhZGRpdGlvbiBvZiB0aGUgeHNrX2J1ZmZfcG9vbC5jIEFQSXMgaW4gY29tbWl0
IDJiNDM0NzBhZGQ4Ywo+ICgieHNrOiBJbnRyb2R1Y2UgQUZfWERQIGJ1ZmZlciBhbGxvY2F0aW9u
IEFQSSIpIGlzIHVuZm9ydHVuYXRlbHkgcmF0aGVyCj4gYnJva2VuIGJ5IG1ha2luZyBsb3RzIG9m
IGFzc3VtcHRpb25zIGFuZCBwb2tpbmcgaW50byBkbWEtZGlyZWN0IGFuZAo+IHN3aW90bGIgaW50
ZXJuYWxzIHRoYXQgYXJlIG9mIG5vIGJ1c2luZXNzIHRvIG91dHNpZGUgdXNlcnMgYW5kIGNsZWFy
bHkKPiBtYXJrZWQgYXMgc3VjaC4gICBJJ2QgYmUgZ2xhZCB0byB3b3JrIHdpdGggeW91ciBkb2lu
ZyBzb21ldGhpbmcgcHJvcGVyCj4gZm9yIHBvb2xzLCBidXQgdGhhdCBuZWVkcyBwcm9wZXIgQVBJ
cyBhbmQgcHJvYmFibHkgbGl2ZSBpbiB0aGUgZG1hCj4gbWFwcGluZyBjb3JlLCBidXQgZm9yIHRo
YXQgeW91J2QgYWN0dWFsbHkgbmVlZCB0byBjb250YWN0IHRoZSByZWxldmFudAo+IG1haW50YWlu
ZXJzIGJlZm9yZSBwb2tpbmcgaW50byBpbnRlcm5hbHMuCj4KCkNocmlzdG9waCwKClRoYW5rcyBm
b3IgY2xhcmlmeWluZyB0aGF0LiBMZXQncyB3b3JrIG9uIGEgc29sdXRpb24gdGhhdCBjYW4gcmVz
aWRlIGluCnRoZSBkbWEgbWFwcGluZyBjb3JlLgoKPiBUaGUgY29tbWl0IHNlZW1zIHRvIGhhdmUg
YSBsb25nIGRvdmUgdGFpbCBvZiBjb21taXRzIGRlcGVuZGluZyBvbiBpdAo+IGRlc3BpdGUgb25s
eSBiZWluZyBhIG1vbnRoIG9sZCwgc28gbWF5YmUgeW91IGNhbiBkbyB0aGUgcmV2ZXJ0IGZvciBu
b3c/Cj4KClJldmVydGluZyB0aGUgd2hvbGUgc2VyaWVzIHNvdW5kcyBhIGJpdCB0b28gbXVjaC4g
TGV0J3MgZm9jdXMgb24gdGhlCnBhcnQgdGhhdCBicmVha3MgdGhlIGRtYSBhcGkgYWJzdHJhY3Rp
b24uIEknbSBhc3N1bWluZyB0aGF0IHlvdSdyZQpyZWZlcnJpbmcgdG8gdGhlCgogICBzdGF0aWMg
Ym9vbCB4cF9jaGVja19jaGVhcF9kbWEoc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wpCgpmdW5j
dGlvbiAoYW5kIHJlbGF0ZWQgZnVuY3Rpb25zIGNhbGxlZCBmcm9tIHRoYXQpPwoKPiBOb3RlIHRo
YXQgdGhpcyBpcyBzb21ld2hhdCB1cmdlbnQsIGFzIHZhcmlvdXMgb2YgdGhlIEFQSXMgdGhhdCB0
aGUgY29kZQo+IGlzIGFidXNpbmcgYXJlIHNsYXRlZCB0byBnbyBhd2F5IGZvciBMaW51eCA1Ljks
IHNvIHRoaXMgYWRkaXRpb24gY29tZXMKPiBhdCBhIHJlYWxseSBiYWQgdGltZS4KPiAKClVuZGVy
c3Rvb2QuIFdkeXQgYWJvdXQgc29tZXRoaW5nIGluIHRoZSBsaW5lcyBvZiB0aGUgZGlmZiBiZWxv
dz8gSXQncwpidWlsZCB0ZXN0ZWQgb25seSwgYnV0IHJlbW92ZXMgYWxsIG5vbi1kbWEgQVBJIHVz
YWdlICgicG9raW5nCmludGVybmFscyIpLiBXb3VsZCB0aGF0IGJlIGEgd2F5IGZvcndhcmQsIGFu
ZCB0aGVuIGFzIGEgbmV4dCBzdGVwIHdvcmsKb24gYSBzb2x1dGlvbiB0aGF0IHdvdWxkIGdpdmUg
c2ltaWxhciBiZW5lZml0cywgYnV0IHNvbWV0aGluZyB0aGF0IHdvdWxkCmxpdmUgaW4gdGhlIGRt
YSBtYXBwaW5nIGNvcmU/CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQveHNrX2J1ZmZfcG9vbC5o
IGIvaW5jbHVkZS9uZXQveHNrX2J1ZmZfcG9vbC5oCmluZGV4IGE0ZmYyMjY1MDVjOS4uMDAzYjE3
MmNlMGQyIDEwMDY0NAotLS0gYS9pbmNsdWRlL25ldC94c2tfYnVmZl9wb29sLmgKKysrIGIvaW5j
bHVkZS9uZXQveHNrX2J1ZmZfcG9vbC5oCkBAIC00MCw3ICs0MCw2IEBAIHN0cnVjdCB4c2tfYnVm
Zl9wb29sIHsKICAJdTMyIGhlYWRyb29tOwogIAl1MzIgY2h1bmtfc2l6ZTsKICAJdTMyIGZyYW1l
X2xlbjsKLQlib29sIGNoZWFwX2RtYTsKICAJYm9vbCB1bmFsaWduZWQ7CiAgCXZvaWQgKmFkZHJz
OwogIAlzdHJ1Y3QgZGV2aWNlICpkZXY7CkBAIC04MCw5ICs3OSw2IEBAIHN0YXRpYyBpbmxpbmUg
ZG1hX2FkZHJfdCB4cF9nZXRfZnJhbWVfZG1hKHN0cnVjdCAKeGRwX2J1ZmZfeHNrICp4c2tiKQog
IHZvaWQgeHBfZG1hX3N5bmNfZm9yX2NwdV9zbG93KHN0cnVjdCB4ZHBfYnVmZl94c2sgKnhza2Ip
OwogIHN0YXRpYyBpbmxpbmUgdm9pZCB4cF9kbWFfc3luY19mb3JfY3B1KHN0cnVjdCB4ZHBfYnVm
Zl94c2sgKnhza2IpCiAgewotCWlmICh4c2tiLT5wb29sLT5jaGVhcF9kbWEpCi0JCXJldHVybjsK
LQogIAl4cF9kbWFfc3luY19mb3JfY3B1X3Nsb3coeHNrYik7CiAgfQoKQEAgLTkxLDkgKzg3LDYg
QEAgdm9pZCB4cF9kbWFfc3luY19mb3JfZGV2aWNlX3Nsb3coc3RydWN0IHhza19idWZmX3Bvb2wg
Cipwb29sLCBkbWFfYWRkcl90IGRtYSwKICBzdGF0aWMgaW5saW5lIHZvaWQgeHBfZG1hX3N5bmNf
Zm9yX2RldmljZShzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwKICAJCQkJCSAgZG1hX2FkZHJf
dCBkbWEsIHNpemVfdCBzaXplKQogIHsKLQlpZiAocG9vbC0+Y2hlYXBfZG1hKQotCQlyZXR1cm47
Ci0KICAJeHBfZG1hX3N5bmNfZm9yX2RldmljZV9zbG93KHBvb2wsIGRtYSwgc2l6ZSk7CiAgfQoK
ZGlmZiAtLWdpdCBhL25ldC94ZHAveHNrX2J1ZmZfcG9vbC5jIGIvbmV0L3hkcC94c2tfYnVmZl9w
b29sLmMKaW5kZXggNTQwZWQ3NWU0NDgyLi41NzE0ZjM3MTEzODEgMTAwNjQ0Ci0tLSBhL25ldC94
ZHAveHNrX2J1ZmZfcG9vbC5jCisrKyBiL25ldC94ZHAveHNrX2J1ZmZfcG9vbC5jCkBAIC0yLDkg
KzIsNiBAQAoKICAjaW5jbHVkZSA8bmV0L3hza19idWZmX3Bvb2wuaD4KICAjaW5jbHVkZSA8bmV0
L3hkcF9zb2NrLmg+Ci0jaW5jbHVkZSA8bGludXgvZG1hLWRpcmVjdC5oPgotI2luY2x1ZGUgPGxp
bnV4L2RtYS1ub25jb2hlcmVudC5oPgotI2luY2x1ZGUgPGxpbnV4L3N3aW90bGIuaD4KCiAgI2lu
Y2x1ZGUgInhza19xdWV1ZS5oIgoKQEAgLTU1LDcgKzUyLDYgQEAgc3RydWN0IHhza19idWZmX3Bv
b2wgKnhwX2NyZWF0ZShzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCAKdTMyIG5yX3BhZ2VzLCB1MzIgY2h1
bmtzLAogIAlwb29sLT5mcmVlX2hlYWRzX2NudCA9IGNodW5rczsKICAJcG9vbC0+aGVhZHJvb20g
PSBoZWFkcm9vbTsKICAJcG9vbC0+Y2h1bmtfc2l6ZSA9IGNodW5rX3NpemU7Ci0JcG9vbC0+Y2hl
YXBfZG1hID0gdHJ1ZTsKICAJcG9vbC0+dW5hbGlnbmVkID0gdW5hbGlnbmVkOwogIAlwb29sLT5m
cmFtZV9sZW4gPSBjaHVua19zaXplIC0gaGVhZHJvb20gLSBYRFBfUEFDS0VUX0hFQURST09NOwog
IAlJTklUX0xJU1RfSEVBRCgmcG9vbC0+ZnJlZV9saXN0KTsKQEAgLTEyNSw0OCArMTIxLDYgQEAg
c3RhdGljIHZvaWQgeHBfY2hlY2tfZG1hX2NvbnRpZ3VpdHkoc3RydWN0IAp4c2tfYnVmZl9wb29s
ICpwb29sKQogIAl9CiAgfQoKLXN0YXRpYyBib29sIF9fbWF5YmVfdW51c2VkIHhwX2NoZWNrX3N3
aW90bGJfZG1hKHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sKQotewotI2lmIGRlZmluZWQoQ09O
RklHX1NXSU9UTEIpCi0JcGh5c19hZGRyX3QgcGFkZHI7Ci0JdTMyIGk7Ci0KLQlmb3IgKGkgPSAw
OyBpIDwgcG9vbC0+ZG1hX3BhZ2VzX2NudDsgaSsrKSB7Ci0JCXBhZGRyID0gZG1hX3RvX3BoeXMo
cG9vbC0+ZGV2LCBwb29sLT5kbWFfcGFnZXNbaV0pOwotCQlpZiAoaXNfc3dpb3RsYl9idWZmZXIo
cGFkZHIpKQotCQkJcmV0dXJuIGZhbHNlOwotCX0KLSNlbmRpZgotCXJldHVybiB0cnVlOwotfQot
Ci1zdGF0aWMgYm9vbCB4cF9jaGVja19jaGVhcF9kbWEoc3RydWN0IHhza19idWZmX3Bvb2wgKnBv
b2wpCi17Ci0jaWYgZGVmaW5lZChDT05GSUdfSEFTX0RNQSkKLQljb25zdCBzdHJ1Y3QgZG1hX21h
cF9vcHMgKm9wcyA9IGdldF9kbWFfb3BzKHBvb2wtPmRldik7Ci0KLQlpZiAob3BzKSB7Ci0JCXJl
dHVybiAhb3BzLT5zeW5jX3NpbmdsZV9mb3JfY3B1ICYmCi0JCQkhb3BzLT5zeW5jX3NpbmdsZV9m
b3JfZGV2aWNlOwotCX0KLQotCWlmICghZG1hX2lzX2RpcmVjdChvcHMpKQotCQlyZXR1cm4gZmFs
c2U7Ci0KLQlpZiAoIXhwX2NoZWNrX3N3aW90bGJfZG1hKHBvb2wpKQotCQlyZXR1cm4gZmFsc2U7
Ci0KLQlpZiAoIWRldl9pc19kbWFfY29oZXJlbnQocG9vbC0+ZGV2KSkgewotI2lmIGRlZmluZWQo
Q09ORklHX0FSQ0hfSEFTX1NZTkNfRE1BX0ZPUl9DUFUpIHx8CQlcCi0JZGVmaW5lZChDT05GSUdf
QVJDSF9IQVNfU1lOQ19ETUFfRk9SX0NQVV9BTEwpIHx8CVwKLQlkZWZpbmVkKENPTkZJR19BUkNI
X0hBU19TWU5DX0RNQV9GT1JfREVWSUNFKQotCQlyZXR1cm4gZmFsc2U7Ci0jZW5kaWYKLQl9Ci0j
ZW5kaWYKLQlyZXR1cm4gdHJ1ZTsKLX0KLQogIGludCB4cF9kbWFfbWFwKHN0cnVjdCB4c2tfYnVm
Zl9wb29sICpwb29sLCBzdHJ1Y3QgZGV2aWNlICpkZXYsCiAgCSAgICAgICB1bnNpZ25lZCBsb25n
IGF0dHJzLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCB1MzIgbnJfcGFnZXMpCiAgewpAQCAtMTk1LDcg
KzE0OSw2IEBAIGludCB4cF9kbWFfbWFwKHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLCBzdHJ1
Y3QgCmRldmljZSAqZGV2LAogIAkJeHBfY2hlY2tfZG1hX2NvbnRpZ3VpdHkocG9vbCk7CgogIAlw
b29sLT5kZXYgPSBkZXY7Ci0JcG9vbC0+Y2hlYXBfZG1hID0geHBfY2hlY2tfY2hlYXBfZG1hKHBv
b2wpOwogIAlyZXR1cm4gMDsKICB9CiAgRVhQT1JUX1NZTUJPTCh4cF9kbWFfbWFwKTsKQEAgLTI4
MCwxMSArMjMzLDkgQEAgc3RydWN0IHhkcF9idWZmICp4cF9hbGxvYyhzdHJ1Y3QgeHNrX2J1ZmZf
cG9vbCAqcG9vbCkKICAJeHNrYi0+eGRwLmRhdGEgPSB4c2tiLT54ZHAuZGF0YV9oYXJkX3N0YXJ0
ICsgWERQX1BBQ0tFVF9IRUFEUk9PTTsKICAJeHNrYi0+eGRwLmRhdGFfbWV0YSA9IHhza2ItPnhk
cC5kYXRhOwoKLQlpZiAoIXBvb2wtPmNoZWFwX2RtYSkgewotCQlkbWFfc3luY19zaW5nbGVfcmFu
Z2VfZm9yX2RldmljZShwb29sLT5kZXYsIHhza2ItPmRtYSwgMCwKLQkJCQkJCSBwb29sLT5mcmFt
ZV9sZW4sCi0JCQkJCQkgRE1BX0JJRElSRUNUSU9OQUwpOwotCX0KKwlkbWFfc3luY19zaW5nbGVf
cmFuZ2VfZm9yX2RldmljZShwb29sLT5kZXYsIHhza2ItPmRtYSwgMCwKKwkJCQkJIHBvb2wtPmZy
YW1lX2xlbiwKKwkJCQkJIERNQV9CSURJUkVDVElPTkFMKTsKICAJcmV0dXJuICZ4c2tiLT54ZHA7
CiAgfQogIEVYUE9SVF9TWU1CT0woeHBfYWxsb2MpOwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
