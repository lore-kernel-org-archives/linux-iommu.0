Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CBEC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:16:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35F961396
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35F961396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B2F8607CB;
	Tue,  1 Jun 2021 07:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Mq1iC-LXsCN; Tue,  1 Jun 2021 07:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7A82605FA;
	Tue,  1 Jun 2021 07:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBDA9C000E;
	Tue,  1 Jun 2021 07:16:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8398AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60CA083CD7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tOgP6c_TA6Ut for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 07:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D452683CD4
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:16:06 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvNfR6PWhz670K;
 Tue,  1 Jun 2021 15:13:03 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:16:00 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:15:59 +0800
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Lu Baolu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Alex Williamson
 (alex.williamson@redhat.com)" <alex.williamson@redhat.com>, Jason Wang
 <jasowang@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
Date: Tue, 1 Jun 2021 15:15:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

T24gMjAyMS82LzEgMTM6MTAsIEx1IEJhb2x1IHdyb3RlOgo+IEhpIFNoZW5taW5nLAo+IAo+IE9u
IDYvMS8yMSAxMjozMSBQTSwgU2hlbm1pbmcgTHUgd3JvdGU6Cj4+IE9uIDIwMjEvNS8yNyAxNTo1
OCwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4+PiAvZGV2L2lvYXNpZCBwcm92aWRlcyBhbiB1bmlmaWVk
IGludGVyZmFjZSBmb3IgbWFuYWdpbmcgSS9PIHBhZ2UgdGFibGVzIGZvcgo+Pj4gZGV2aWNlcyBh
c3NpZ25lZCB0byB1c2Vyc3BhY2UuIERldmljZSBwYXNzdGhyb3VnaCBmcmFtZXdvcmtzIChWRklP
LCB2RFBBLAo+Pj4gZXRjLikgYXJlIGV4cGVjdGVkIHRvIHVzZSB0aGlzIGludGVyZmFjZSBpbnN0
ZWFkIG9mIGNyZWF0aW5nIHRoZWlyIG93biBsb2dpYyB0bwo+Pj4gaXNvbGF0ZSB1bnRydXN0ZWQg
ZGV2aWNlIERNQXMgaW5pdGlhdGVkIGJ5IHVzZXJzcGFjZS4KPj4+Cj4+PiBUaGlzIHByb3Bvc2Fs
IGRlc2NyaWJlcyB0aGUgdUFQSSBvZiAvZGV2L2lvYXNpZCBhbmQgYWxzbyBzYW1wbGUgc2VxdWVu
Y2VzCj4+PiB3aXRoIFZGSU8gYXMgZXhhbXBsZSBpbiB0eXBpY2FsIHVzYWdlcy4gVGhlIGRyaXZl
ci1mYWNpbmcga2VybmVsIEFQSSBwcm92aWRlZAo+Pj4gYnkgdGhlIGlvbW11IGxheWVyIGlzIHN0
aWxsIFRCRCwgd2hpY2ggY2FuIGJlIGRpc2N1c3NlZCBhZnRlciBjb25zZW5zdXMgaXMKPj4+IG1h
ZGUgb24gdGhpcyB1QVBJLgo+Pj4KPj4+IEl0J3MgYmFzZWQgb24gYSBsZW5ndGh5IGRpc2N1c3Np
b24gc3RhcnRpbmcgZnJvbSBoZXJlOgo+Pj4gwqDCoMKgwqBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1pb21tdS8yMDIxMDMzMDEzMjgzMC5HTzIzNTYyODFAbnZpZGlhLmNvbS8KPj4+Cj4+
PiBJdCBlbmRzIHVwIHRvIGJlIGEgbG9uZyB3cml0aW5nIGR1ZSB0byBtYW55IHRoaW5ncyB0byBi
ZSBzdW1tYXJpemVkIGFuZAo+Pj4gbm9uLXRyaXZpYWwgZWZmb3J0IHJlcXVpcmVkIHRvIGNvbm5l
Y3QgdGhlbSBpbnRvIGEgY29tcGxldGUgcHJvcG9zYWwuCj4+PiBIb3BlIGl0IHByb3ZpZGVzIGEg
Y2xlYW4gYmFzZSB0byBjb252ZXJnZS4KPj4+Cj4+Cj4+IFsuLl0KPj4KPj4+Cj4+PiAvKgo+Pj4g
wqDCoCAqIFBhZ2UgZmF1bHQgcmVwb3J0IGFuZCByZXNwb25zZQo+Pj4gwqDCoCAqCj4+PiDCoMKg
ICogVGhpcyBpcyBUQkQuIENhbiBiZSBhZGRlZCBhZnRlciBvdGhlciBwYXJ0cyBhcmUgY2xlYXJl
ZCB1cC4gTGlrZWx5IGl0Cj4+PiDCoMKgICogd2lsbCBiZSBhIHJpbmcgYnVmZmVyIHNoYXJlZCBi
ZXR3ZWVuIHVzZXIva2VybmVsLCBhbiBldmVudGZkIHRvIG5vdGlmeQo+Pj4gwqDCoCAqIHRoZSB1
c2VyIGFuZCBhbiBpb2N0bCB0byBjb21wbGV0ZSB0aGUgZmF1bHQuCj4+PiDCoMKgICoKPj4+IMKg
wqAgKiBUaGUgZmF1bHQgZGF0YSBpcyBwZXIgSS9PIGFkZHJlc3Mgc3BhY2UsIGkuZS46IElPQVNJ
RCArIGZhdWx0aW5nX2FkZHIKPj4+IMKgwqAgKi8KPj4KPj4gSGksCj4+Cj4+IEl0IHNlZW1zIHRo
YXQgdGhlIGlvYXNpZCBoYXMgZGlmZmVyZW50IHVzYWdlIGluIGRpZmZlcmVudCBzaXR1YXRpb24s
IGl0IGNvdWxkCj4+IGJlIGRpcmVjdGx5IHVzZWQgaW4gdGhlIHBoeXNpY2FsIHJvdXRpbmcsIG9y
IGp1c3QgYSB2aXJ0dWFsIGhhbmRsZSB0aGF0IGluZGljYXRlcwo+PiBhIHBhZ2UgdGFibGUgb3Ig
YSB2UEFTSUQgdGFibGUgKHN1Y2ggYXMgdGhlIEdQQSBhZGRyZXNzIHNwYWNlLCBpbiB0aGUgc2lt
cGxlCj4+IHBhc3N0aHJvdWdoIGNhc2UsIHRoZSBETUEgaW5wdXQgdG8gSU9NTVUgd2lsbCBqdXN0
IGNvbnRhaW4gYSBTdHJlYW0gSUQsIG5vCj4+IFN1YnN0cmVhbSBJRCksIHJpZ2h0Pwo+Pgo+PiBB
bmQgQmFvbHUgc3VnZ2VzdGVkIHRoYXQgc2luY2Ugb25lIGRldmljZSBtaWdodCBjb25zdW1lIG11
bHRpcGxlIHBhZ2UgdGFibGVzLAo+PiBpdCdzIG1vcmUgcmVhc29uYWJsZSB0byBoYXZlIG9uZSBm
YXVsdCBoYW5kbGVyIHBlciBwYWdlIHRhYmxlLiBCeSB0aGlzLCBkbyB3ZQo+PiBoYXZlIHRvIG1h
aW50YWluIHN1Y2ggYW4gaW9hc2lkIGluZm8gbGlzdCBpbiB0aGUgSU9NTVUgbGF5ZXI/Cj4gCj4g
QXMgZGlzY3Vzc2VkIGVhcmxpZXIsIHRoZSBJL08gcGFnZSBmYXVsdCBhbmQgY2FjaGUgaW52YWxp
ZGF0aW9uIHBhdGhzCj4gd2lsbCBoYXZlICJkZXZpY2UgbGFiZWxzIiBzbyB0aGF0IHRoZSBpbmZv
cm1hdGlvbiBjb3VsZCBiZSBlYXNpbHkKPiB0cmFuc2xhdGVkIGFuZCByb3V0ZWQuCj4gCj4gU28g
aXQncyBsaWtlbHkgdGhlIHBlci1kZXZpY2UgZmF1bHQgaGFuZGxlciByZWdpc3RlcmluZyBBUEkg
aW4gaW9tbXUKPiBjb3JlIGNhbiBiZSBrZXB0LCBidXQgL2Rldi9pb2FzaWQgd2lsbCBiZSBncm93
biB3aXRoIGEgbGF5ZXIgdG8KPiB0cmFuc2xhdGUgYW5kIHByb3BhZ2F0ZSBJL08gcGFnZSBmYXVs
dCBpbmZvcm1hdGlvbiB0byB0aGUgcmlnaHQKPiBjb25zdW1lcnMuCgpZZWFoLCBoYXZpbmcgYSBn
ZW5lcmFsIHByZXByb2Nlc3Npbmcgb2YgdGhlIGZhdWx0cyBpbiBJT0FTSUQgc2VlbXMgdG8gYmUK
YSBkb2FibGUgZGlyZWN0aW9uLiBCdXQgc2luY2UgdGhlcmUgbWF5IGJlIG1vcmUgdGhhbiBvbmUg
Y29uc3VtZXIgYXQgdGhlCnNhbWUgdGltZSwgd2hvIGlzIHJlc3BvbnNpYmxlIGZvciByZWdpc3Rl
cmluZyB0aGUgcGVyLWRldmljZSBmYXVsdCBoYW5kbGVyPwoKVGhhbmtzLApTaGVubWluZwoKPiAK
PiBJZiB0aGluZ3MgZXZvbHZlIGluIHRoaXMgd2F5LCBwcm9iYWJseSB0aGUgU1ZBIEkvTyBwYWdl
IGZhdWx0IGFsc28gbmVlZHMKPiB0byBiZSBwb3J0ZWQgdG8gL2Rldi9pb2FzaWQuCj4gCj4+Cj4+
IFRoZW4gaWYgd2UgYWRkIGhvc3QgSU9QRiBzdXBwb3J0IChmb3IgdGhlIEdQQSBhZGRyZXNzIHNw
YWNlKSBpbiB0aGUgZnV0dXJlCj4+IChJIGhhdmUgc2VudCBhIHNlcmllcyBmb3IgdGhpcyBidXQg
aXQgYWltZWQgZm9yIFZGSU8sIEkgd2lsbCBjb252ZXJ0IGl0IGZvcgo+PiBJT0FTSUQgbGF0ZXIg
WzFdIDotKSksIGhvdyBjb3VsZCB3ZSBmaW5kIHRoZSBoYW5kbGVyIGZvciB0aGUgcmVjZWl2ZWQg
ZmF1bHQKPj4gZXZlbnQgd2hpY2ggb25seSBjb250YWlucyBhIFN0cmVhbSBJRC4uLiBEbyB3ZSBh
bHNvIGhhdmUgdG8gbWFpbnRhaW4gYQo+PiBkZXYodlBBU0lEKS0+aW9hc2lkIG1hcHBpbmcgaW4g
dGhlIElPTU1VIGxheWVyPwo+Pgo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3
b3JrL2NvdmVyLzE0MTAyMjMvCj4gCj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1Cj4gLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
