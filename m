Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D6C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 13:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D6A613C5
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 13:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D6A613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06D0283C87;
	Tue,  1 Jun 2021 13:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EhzAnhzBpMje; Tue,  1 Jun 2021 13:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6811B82CDD;
	Tue,  1 Jun 2021 13:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C14CC000E;
	Tue,  1 Jun 2021 13:11:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29D11C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 13:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A69883C87
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 13:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SURQbhF0j9yJ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 13:10:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6541282CDD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 13:10:59 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FvXW34ZMTz67Pr;
 Tue,  1 Jun 2021 21:07:11 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 21:10:55 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 21:10:54 +0800
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Lu Baolu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Alex Williamson
 (alex.williamson@redhat.com)" <alex.williamson@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <b343c294-e097-0c94-e480-4dde80c308d1@huawei.com>
Date: Tue, 1 Jun 2021 21:10:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kirti Wankhede <kwankhede@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gMjAyMS82LzEgMjA6MzAsIEx1IEJhb2x1IHdyb3RlOgo+IE9uIDIwMjEvNi8xIDE1OjE1LCBT
aGVubWluZyBMdSB3cm90ZToKPj4gT24gMjAyMS82LzEgMTM6MTAsIEx1IEJhb2x1IHdyb3RlOgo+
Pj4gSGkgU2hlbm1pbmcsCj4+Pgo+Pj4gT24gNi8xLzIxIDEyOjMxIFBNLCBTaGVubWluZyBMdSB3
cm90ZToKPj4+PiBPbiAyMDIxLzUvMjcgMTU6NTgsIFRpYW4sIEtldmluIHdyb3RlOgo+Pj4+PiAv
ZGV2L2lvYXNpZCBwcm92aWRlcyBhbiB1bmlmaWVkIGludGVyZmFjZSBmb3IgbWFuYWdpbmcgSS9P
IHBhZ2UgdGFibGVzIGZvcgo+Pj4+PiBkZXZpY2VzIGFzc2lnbmVkIHRvIHVzZXJzcGFjZS4gRGV2
aWNlIHBhc3N0aHJvdWdoIGZyYW1ld29ya3MgKFZGSU8sIHZEUEEsCj4+Pj4+IGV0Yy4pIGFyZSBl
eHBlY3RlZCB0byB1c2UgdGhpcyBpbnRlcmZhY2UgaW5zdGVhZCBvZiBjcmVhdGluZyB0aGVpciBv
d24gbG9naWMgdG8KPj4+Pj4gaXNvbGF0ZSB1bnRydXN0ZWQgZGV2aWNlIERNQXMgaW5pdGlhdGVk
IGJ5IHVzZXJzcGFjZS4KPj4+Pj4KPj4+Pj4gVGhpcyBwcm9wb3NhbCBkZXNjcmliZXMgdGhlIHVB
UEkgb2YgL2Rldi9pb2FzaWQgYW5kIGFsc28gc2FtcGxlIHNlcXVlbmNlcwo+Pj4+PiB3aXRoIFZG
SU8gYXMgZXhhbXBsZSBpbiB0eXBpY2FsIHVzYWdlcy4gVGhlIGRyaXZlci1mYWNpbmcga2VybmVs
IEFQSSBwcm92aWRlZAo+Pj4+PiBieSB0aGUgaW9tbXUgbGF5ZXIgaXMgc3RpbGwgVEJELCB3aGlj
aCBjYW4gYmUgZGlzY3Vzc2VkIGFmdGVyIGNvbnNlbnN1cyBpcwo+Pj4+PiBtYWRlIG9uIHRoaXMg
dUFQSS4KPj4+Pj4KPj4+Pj4gSXQncyBiYXNlZCBvbiBhIGxlbmd0aHkgZGlzY3Vzc2lvbiBzdGFy
dGluZyBmcm9tIGhlcmU6Cj4+Pj4+IMKgwqDCoMKgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWlvbW11LzIwMjEwMzMwMTMyODMwLkdPMjM1NjI4MUBudmlkaWEuY29tLwo+Pj4+Pgo+Pj4+
PiBJdCBlbmRzIHVwIHRvIGJlIGEgbG9uZyB3cml0aW5nIGR1ZSB0byBtYW55IHRoaW5ncyB0byBi
ZSBzdW1tYXJpemVkIGFuZAo+Pj4+PiBub24tdHJpdmlhbCBlZmZvcnQgcmVxdWlyZWQgdG8gY29u
bmVjdCB0aGVtIGludG8gYSBjb21wbGV0ZSBwcm9wb3NhbC4KPj4+Pj4gSG9wZSBpdCBwcm92aWRl
cyBhIGNsZWFuIGJhc2UgdG8gY29udmVyZ2UuCj4+Pj4+Cj4+Pj4gWy4uXQo+Pj4+Cj4+Pj4+IC8q
Cj4+Pj4+IMKgwqDCoCAqIFBhZ2UgZmF1bHQgcmVwb3J0IGFuZCByZXNwb25zZQo+Pj4+PiDCoMKg
wqAgKgo+Pj4+PiDCoMKgwqAgKiBUaGlzIGlzIFRCRC4gQ2FuIGJlIGFkZGVkIGFmdGVyIG90aGVy
IHBhcnRzIGFyZSBjbGVhcmVkIHVwLiBMaWtlbHkgaXQKPj4+Pj4gwqDCoMKgICogd2lsbCBiZSBh
IHJpbmcgYnVmZmVyIHNoYXJlZCBiZXR3ZWVuIHVzZXIva2VybmVsLCBhbiBldmVudGZkIHRvIG5v
dGlmeQo+Pj4+PiDCoMKgwqAgKiB0aGUgdXNlciBhbmQgYW4gaW9jdGwgdG8gY29tcGxldGUgdGhl
IGZhdWx0Lgo+Pj4+PiDCoMKgwqAgKgo+Pj4+PiDCoMKgwqAgKiBUaGUgZmF1bHQgZGF0YSBpcyBw
ZXIgSS9PIGFkZHJlc3Mgc3BhY2UsIGkuZS46IElPQVNJRCArIGZhdWx0aW5nX2FkZHIKPj4+Pj4g
wqDCoMKgICovCj4+Pj4gSGksCj4+Pj4KPj4+PiBJdCBzZWVtcyB0aGF0IHRoZSBpb2FzaWQgaGFz
IGRpZmZlcmVudCB1c2FnZSBpbiBkaWZmZXJlbnQgc2l0dWF0aW9uLCBpdCBjb3VsZAo+Pj4+IGJl
IGRpcmVjdGx5IHVzZWQgaW4gdGhlIHBoeXNpY2FsIHJvdXRpbmcsIG9yIGp1c3QgYSB2aXJ0dWFs
IGhhbmRsZSB0aGF0IGluZGljYXRlcwo+Pj4+IGEgcGFnZSB0YWJsZSBvciBhIHZQQVNJRCB0YWJs
ZSAoc3VjaCBhcyB0aGUgR1BBIGFkZHJlc3Mgc3BhY2UsIGluIHRoZSBzaW1wbGUKPj4+PiBwYXNz
dGhyb3VnaCBjYXNlLCB0aGUgRE1BIGlucHV0IHRvIElPTU1VIHdpbGwganVzdCBjb250YWluIGEg
U3RyZWFtIElELCBubwo+Pj4+IFN1YnN0cmVhbSBJRCksIHJpZ2h0Pwo+Pj4+Cj4+Pj4gQW5kIEJh
b2x1IHN1Z2dlc3RlZCB0aGF0IHNpbmNlIG9uZSBkZXZpY2UgbWlnaHQgY29uc3VtZSBtdWx0aXBs
ZSBwYWdlIHRhYmxlcywKPj4+PiBpdCdzIG1vcmUgcmVhc29uYWJsZSB0byBoYXZlIG9uZSBmYXVs
dCBoYW5kbGVyIHBlciBwYWdlIHRhYmxlLiBCeSB0aGlzLCBkbyB3ZQo+Pj4+IGhhdmUgdG8gbWFp
bnRhaW4gc3VjaCBhbiBpb2FzaWQgaW5mbyBsaXN0IGluIHRoZSBJT01NVSBsYXllcj8KPj4+IEFz
IGRpc2N1c3NlZCBlYXJsaWVyLCB0aGUgSS9PIHBhZ2UgZmF1bHQgYW5kIGNhY2hlIGludmFsaWRh
dGlvbiBwYXRocwo+Pj4gd2lsbCBoYXZlICJkZXZpY2UgbGFiZWxzIiBzbyB0aGF0IHRoZSBpbmZv
cm1hdGlvbiBjb3VsZCBiZSBlYXNpbHkKPj4+IHRyYW5zbGF0ZWQgYW5kIHJvdXRlZC4KPj4+Cj4+
PiBTbyBpdCdzIGxpa2VseSB0aGUgcGVyLWRldmljZSBmYXVsdCBoYW5kbGVyIHJlZ2lzdGVyaW5n
IEFQSSBpbiBpb21tdQo+Pj4gY29yZSBjYW4gYmUga2VwdCwgYnV0IC9kZXYvaW9hc2lkIHdpbGwg
YmUgZ3Jvd24gd2l0aCBhIGxheWVyIHRvCj4+PiB0cmFuc2xhdGUgYW5kIHByb3BhZ2F0ZSBJL08g
cGFnZSBmYXVsdCBpbmZvcm1hdGlvbiB0byB0aGUgcmlnaHQKPj4+IGNvbnN1bWVycy4KPj4gWWVh
aCwgaGF2aW5nIGEgZ2VuZXJhbCBwcmVwcm9jZXNzaW5nIG9mIHRoZSBmYXVsdHMgaW4gSU9BU0lE
IHNlZW1zIHRvIGJlCj4+IGEgZG9hYmxlIGRpcmVjdGlvbi4gQnV0IHNpbmNlIHRoZXJlIG1heSBi
ZSBtb3JlIHRoYW4gb25lIGNvbnN1bWVyIGF0IHRoZQo+PiBzYW1lIHRpbWUsIHdobyBpcyByZXNw
b25zaWJsZSBmb3IgcmVnaXN0ZXJpbmcgdGhlIHBlci1kZXZpY2UgZmF1bHQgaGFuZGxlcj8KPiAK
PiBUaGUgZHJpdmVycyByZWdpc3RlciBwZXIgcGFnZSB0YWJsZSBmYXVsdCBoYW5kbGVycyB0byAv
ZGV2L2lvYXNpZCB3aGljaAo+IHdpbGwgdGhlbiByZWdpc3RlciBpdHNlbGYgdG8gaW9tbXUgY29y
ZSB0byBsaXN0ZW4gYW5kIHJvdXRlIHRoZSBwZXItCj4gZGV2aWNlIEkvTyBwYWdlIGZhdWx0cy4g
VGhpcyBpcyBqdXN0IGEgdG9wIGxldmVsIHRob3VnaHQuIEhhdmVuJ3QgZ29uZQo+IHRocm91Z2gg
dGhlIGRldGFpbHMgeWV0LiBOZWVkIHRvIHdhaXQgYW5kIHNlZSB3aGF0IC9kZXYvaW9hc2lkIGZp
bmFsbHkKPiBsb29rcyBsaWtlLgoKT0suIEFuZCBpdCBuZWVkcyB0byBiZSBjb25maXJtZWQgYnkg
SmVhbiBzaW5jZSB3ZSBtaWdodCBtaWdyYXRlIHRoZSBjb2RlIGZyb20KaW8tcGdmYXVsdC5jIHRv
IElPQVNJRC4uLiBBbnl3YXksIGZpbmFsaXplIC9kZXYvaW9hc2lkIGZpcnN0LiAgVGhhbmtzLAoK
U2hlbm1pbmcKCj4gCj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1Cj4gLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
