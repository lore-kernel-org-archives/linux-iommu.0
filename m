Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA23C07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 11:11:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254DB613E1
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 11:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254DB613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB595405D3;
	Fri,  9 Jul 2021 11:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfTTvRpTih8c; Fri,  9 Jul 2021 11:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6FD7405A0;
	Fri,  9 Jul 2021 11:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98543C001B;
	Fri,  9 Jul 2021 11:11:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3183DC001A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 11:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB730405C5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 11:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jmb0p7fntssE for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 11:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20E93405A7
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 11:11:47 +0000 (UTC)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GLqyn74LDz6J6X3;
 Fri,  9 Jul 2021 19:03:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 13:11:44 +0200
Received: from [10.47.93.40] (10.47.93.40) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Jul 2021
 12:11:43 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Robin Murphy <robin.murphy@arm.com>, Ming Lei <ming.lei@redhat.com>,
 <linux-nvme@lists.infradead.org>, Will Deacon <will@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
Date: Fri, 9 Jul 2021 12:04:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.93.40]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org
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

T24gMDkvMDcvMjAyMSAxMToyNiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IG4gMjAyMS0wNy0wOSAw
OTozOCwgTWluZyBMZWkgd3JvdGU6Cj4+IEhlbGxvLAo+Pgo+PiBJIG9ic2VydmVkIHRoYXQgTlZN
ZSBwZXJmb3JtYW5jZSBpcyB2ZXJ5IGJhZCB3aGVuIHJ1bm5pbmcgZmlvIG9uIG9uZQo+PiBDUFUo
YWFyY2g2NCkgaW4gcmVtb3RlIG51bWEgbm9kZSBjb21wYXJlZCB3aXRoIHRoZSBudm1lIHBjaSBu
dW1hIG5vZGUuCj4+Cj4+IFBsZWFzZSBzZWUgdGhlIHRlc3QgcmVzdWx0WzFdIDMyN0sgdnMuIDM0
LjlLLgo+Pgo+PiBMYXRlbmN5IHRyYWNlIHNob3dzIHRoYXQgb25lIGJpZyBkaWZmZXJlbmNlIGlz
IGluIGlvbW11X2RtYV91bm1hcF9zZygpLAo+PiAxMTExIG5zZWNzIHZzIDI1NDM3IG5zZWNzLgo+
IAo+IEFyZSB5b3UgYWJsZSB0byBkaWcgZG93biBmdXJ0aGVyIGludG8gdGhhdD8gaW9tbXVfZG1h
X3VubWFwX3NnKCkgaXRzZWxmIAo+IGRvZXNuJ3QgZG8gYW55dGhpbmcgcGFydGljdWxhcmx5IHNw
ZWNpYWwsIHNvIHdoYXRldmVyIG1ha2VzIGEgZGlmZmVyZW5jZSAKPiBpcyBwcm9iYWJseSBoYXBw
ZW5pbmcgYXQgYSBsb3dlciBsZXZlbCwgYW5kIEkgc3VzcGVjdCB0aGVyZSdzIHByb2JhYmx5IAo+
IGFuIFNNTVUgaW52b2x2ZWQuIElmIGZvciBpbnN0YW5jZSBpdCB0dXJucyBvdXQgdG8gZ28gYWxs
IHRoZSB3YXkgZG93biB0byAKPiBfX2FybV9zbW11X2NtZHFfcG9sbF91bnRpbF9jb25zdW1lZCgp
IGJlY2F1c2UgcG9sbGluZyBNTUlPIGZyb20gdGhlIAo+IHdyb25nIG5vZGUgaXMgc2xvdywgdGhl
cmUncyB1bmxpa2VseSB0byBiZSBtdWNoIHlvdSBjYW4gZG8gYWJvdXQgdGhhdCAKPiBvdGhlciB0
aGFuIHRoZSBnbG9iYWwgImdvIGZhc3RlciIga25vYnMgKGlvbW11LnN0cmljdCBhbmQgCj4gaW9t
bXUucGFzc3Rocm91Z2gpIHdpdGggdGhlaXIgYXNzb2NpYXRlZCBjb21wcm9taXNlcy4KClRoZXJl
IHdhcyBhbHNvIHRoZSBkaXNhYmxlX21zaXBvbGxpbmcgb3B0aW9uOgoKaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyNuNDIKCkJ1dCBJIGFt
IG5vdCBzdXJlIGlmIHRoYXQgcGxhdGZvcm0gZXZlbiBzdXBwb3J0cyBNU0kgcG9sbGluZyAob3Ig
aGFzIApzbW11IHYzKS4KCllvdSBjb3VsZCBhbHNvIHRyeSBpb21tdS5mb3JjZWRhYz0xIGNtZGxp
bmUgb3B0aW9uLiBCdXQgSSBkb3VidCBpdCB3aWxsIApoZWxwIHNpbmNlIHRoZSBpc3N1ZSB3YXMg
bWVudGlvbmVkIHRvIGJlIE5VTUEgcmVsYXRlZC4KCj4gCj4gUm9iaW4uCj4gCj4+IFsxXSBmaW8g
dGVzdCAmIHJlc3VsdHMKPj4KPj4gMSkgZmlvIHRlc3QgcmVzdWx0Ogo+Pgo+PiAtIHJ1biBmaW8g
b24gbG9jYWwgQ1BVCj4+IHRhc2tzZXQgLWMgMCB+L2dpdC90b29scy90ZXN0L252bWUvaW9fdXJp
bmcgMTAgMSAvZGV2L252bWUxbjEgNGsKPj4gKyBmaW8gLS1icz00ayAtLWlvZW5naW5lPWlvX3Vy
aW5nIC0tZml4ZWRidWZzIC0tcmVnaXN0ZXJmaWxlcyAtLWhpcHJpIAo+PiAtLWlvZGVwdGg9NjQg
LS1pb2RlcHRoX2JhdGNoX3N1Ym1pdD0xNiAtLWlvZGVwdGhfYmF0Y2hfY29tcGxldGVfbWluPTE2
IAo+PiAtLWZpbGVuYW1lPS9kZXYvbnZtZTFuMSAtLWRpcmVjdD0xIC0tcnVudGltZT0xMCAtLW51
bWpvYnM9MSAKPj4gLS1ydz1yYW5kcmVhZCAtLW5hbWU9dGVzdCAtLWdyb3VwX3JlcG9ydGluZwo+
Pgo+PiBJT1BTOiAzMjdLCj4+IGF2ZyBsYXRlbmN5IG9mIGlvbW11X2RtYV91bm1hcF9zZygpOiAx
MTExIG5zZWNzCj4+Cj4+Cj4+IC0gcnVuIGZpbyBvbiByZW1vdGUgQ1BVCj4+IHRhc2tzZXQgLWMg
ODAgfi9naXQvdG9vbHMvdGVzdC9udm1lL2lvX3VyaW5nIDEwIDEgL2Rldi9udm1lMW4xIDRrCj4+
ICsgZmlvIC0tYnM9NGsgLS1pb2VuZ2luZT1pb191cmluZyAtLWZpeGVkYnVmcyAtLXJlZ2lzdGVy
ZmlsZXMgLS1oaXByaSAKPj4gLS1pb2RlcHRoPTY0IC0taW9kZXB0aF9iYXRjaF9zdWJtaXQ9MTYg
LS1pb2RlcHRoX2JhdGNoX2NvbXBsZXRlX21pbj0xNiAKPj4gLS1maWxlbmFtZT0vZGV2L252bWUx
bjEgLS1kaXJlY3Q9MSAtLXJ1bnRpbWU9MTAgLS1udW1qb2JzPTEgCj4+IC0tcnc9cmFuZHJlYWQg
LS1uYW1lPXRlc3QgLS1ncm91cF9yZXBvcnRpbmcKPj4KPj4gSU9QUzogMzQuOUsKPj4gYXZnIGxh
dGVuY3kgb2YgaW9tbXVfZG1hX3VubWFwX3NnKCk6IDI1NDM3IG5zZWNzCj4+Cj4+IDIpIHN5c3Rl
bSBpbmZvCj4+IFtyb290QGFtcGVyZS1tdGphZGUtMDQgfl0jIGxzY3B1IHwgZ3JlcCBOVU1BCj4+
IE5VTUEgbm9kZShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyCj4+
IE5VTUEgbm9kZTAgQ1BVKHMpOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMC03OQo+PiBO
VU1BIG5vZGUxIENQVShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDgwLTE1OQo+Pgo+
PiBsc3BjaSB8IGdyZXAgTlZNZQo+PiAwMDAzOjAxOjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBj
b250cm9sbGVyOiBTYW1zdW5nIEVsZWN0cm9uaWNzIENvIAo+PiBMdGQgTlZNZSBTU0QgQ29udHJv
bGxlciBTTTk4MS9QTTk4MS9QTTk4Mwo+Pgo+PiBbcm9vdEBhbXBlcmUtbXRqYWRlLTA0IH5dIyBj
YXQgL3N5cy9ibG9jay9udm1lMW4xL2RldmljZS9kZXZpY2UvbnVtYV9ub2RlIAoKU2luY2UgaXQn
cyBhbXBlcmUsIEkgZ3Vlc3MgaXQncyBzbW11IHYzLgoKQlRXLCBpZiB5b3UgcmVtZW1iZXIsIEkg
ZGlkIHJhaXNlIGEgcGVyZm9ybWFuY2UgaXNzdWUgb2Ygc21tdXYzIHdpdGggCk5WTWUgYmVmb3Jl
OgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS9iMmE2ZTI2ZC02ZDBkLTdmMGQt
ZjIyMi01ODk4MTJmNzAxZDJAaHVhd2VpLmNvbS8KCkkgZGlkIGhhdmUgdGhpcyBzZXJpZXMgdG8g
aW1wcm92ZSBwZXJmb3JtYW5jZSBmb3Igc3lzdGVtcyB3aXRoIGxvdHMgb2YgCkNQVXMsIGxpa2Ug
YWJvdmUsIGJ1dCBub3QgYWNjZXB0ZWQ6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlv
bW11LzE1OTgwMTgwNjItMTc1NjA4LTEtZ2l0LXNlbmQtZW1haWwtam9obi5nYXJyeUBodWF3ZWku
Y29tLwoKVGhhbmtzLApKb2huCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
