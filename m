Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630FCC12002
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 01:51:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B12613C1
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 01:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B12613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89717404F4;
	Thu, 15 Jul 2021 01:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAAZu6Dz6zkQ; Thu, 15 Jul 2021 01:51:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1AEC5404AB;
	Thu, 15 Jul 2021 01:51:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA978C0010;
	Thu, 15 Jul 2021 01:51:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5F41C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D429D60B0B
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDNSfbftK_Hp for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:51:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CE8460763
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:51:19 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQHJJ1NH6zXtG7;
 Thu, 15 Jul 2021 09:45:36 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 09:51:14 +0800
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
To: Lu Baolu <baolu.lu@linux.intel.com>, Georgi Djakov <djakov@kernel.org>,
 Georgi Djakov <quic_c_gdjako@quicinc.com>, <will@kernel.org>,
 <robin.murphy@arm.com>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
 <4d466ea9-2c1a-2e19-af5b-0434441ee7cb@linux.intel.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <edfff22f-251d-e07d-fdbc-0eb00c821f15@hisilicon.com>
Date: Thu, 15 Jul 2021 09:51:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4d466ea9-2c1a-2e19-af5b-0434441ee7cb@linux.intel.com>
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org
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

CgrlnKggMjAyMS83LzE1IDk6MjMsIEx1IEJhb2x1IOWGmemBkzoKPiBPbiA3LzE0LzIxIDEwOjI0
IFBNLCBHZW9yZ2kgRGpha292IHdyb3RlOgo+PiBPbiAxNi4wNi4yMSAxNjozOCwgR2VvcmdpIERq
YWtvdiB3cm90ZToKPj4+IFdoZW4gdW5tYXBwaW5nIGEgYnVmZmVyIGZyb20gYW4gSU9NTVUgZG9t
YWluLCB0aGUgSU9NTVUgZnJhbWV3b3JrIAo+Pj4gdW5tYXBzCj4+PiB0aGUgYnVmZmVyIGF0IGEg
Z3JhbnVsZSBvZiB0aGUgbGFyZ2VzdCBwYWdlIHNpemUgdGhhdCBpcyBzdXBwb3J0ZWQgYnkKPj4+
IHRoZSBJT01NVSBoYXJkd2FyZSBhbmQgZml0cyB3aXRoaW4gdGhlIGJ1ZmZlci4gRm9yIGV2ZXJ5
IGJsb2NrIHRoYXQKPj4+IGlzIHVubWFwcGVkLCB0aGUgSU9NTVUgZnJhbWV3b3JrIHdpbGwgY2Fs
bCBpbnRvIHRoZSBJT01NVSBkcml2ZXIsIGFuZAo+Pj4gdGhlbiB0aGUgaW8tcGd0YWJsZSBmcmFt
ZXdvcmsgdG8gd2FsayB0aGUgcGFnZSB0YWJsZXMgdG8gZmluZCB0aGUgZW50cnkKPj4+IHRoYXQg
Y29ycmVzcG9uZHMgdG8gdGhlIElPVkEsIGFuZCB0aGVuIHVubWFwcyB0aGUgZW50cnkuCj4+Pgo+
Pj4gVGhpcyBjYW4gYmUgc3Vib3B0aW1hbCBpbiBzY2VuYXJpb3Mgd2hlcmUgYSBidWZmZXIgb3Ig
YSBwaWVjZSBvZiBhCj4+PiBidWZmZXIgY2FuIGJlIHNwbGl0IGludG8gc2V2ZXJhbCBjb250aWd1
b3VzIHBhZ2UgYmxvY2tzIG9mIHRoZSBzYW1lIAo+Pj4gc2l6ZS4KPj4+IEZvciBleGFtcGxlLCBj
b25zaWRlciBhbiBJT01NVSB0aGF0IHN1cHBvcnRzIDQgS0IgcGFnZSBibG9ja3MsIDIgTUIgCj4+
PiBwYWdlCj4+PiBibG9ja3MsIGFuZCAxIEdCIHBhZ2UgYmxvY2tzLCBhbmQgYSBidWZmZXIgdGhh
dCBpcyA0IE1CIGluIHNpemUgaXMgCj4+PiBiZWluZwo+Pj4gdW5tYXBwZWQgYXQgSU9WQSAwLiBU
aGUgY3VycmVudCBjYWxsLWZsb3cgd2lsbCByZXN1bHQgaW4gNCBpbmRpcmVjdCAKPj4+IGNhbGxz
LAo+Pj4gYW5kIDIgcGFnZSB0YWJsZSB3YWxrcywgdG8gdW5tYXAgMiBlbnRyaWVzIHRoYXQgYXJl
IG5leHQgdG8gZWFjaCAKPj4+IG90aGVyIGluCj4+PiB0aGUgcGFnZS10YWJsZXMsIHdoZW4gYm90
aCBlbnRyaWVzIGNvdWxkIGhhdmUgYmVlbiB1bm1hcHBlZCBpbiBvbmUgc2hvdAo+Pj4gYnkgY2xl
YXJpbmcgYm90aCBwYWdlIHRhYmxlIGVudHJpZXMgaW4gdGhlIHNhbWUgY2FsbC4KPj4+Cj4+PiBU
aGUgc2FtZSBvcHRpbWl6YXRpb24gaXMgYXBwbGljYWJsZSB0byBtYXBwaW5nIGJ1ZmZlcnMgYXMg
d2VsbCwgc28KPj4+IHRoZXNlIHBhdGNoZXMgaW1wbGVtZW50IGEgc2V0IG9mIGNhbGxiYWNrcyBj
YWxsZWQgdW5tYXBfcGFnZXMgYW5kCj4+PiBtYXBfcGFnZXMgdG8gdGhlIGlvLXBndGFibGUgY29k
ZSBhbmQgSU9NTVUgZHJpdmVycyB3aGljaCB1bm1hcHMgb3IgbWFwcwo+Pj4gYW4gSU9WQSByYW5n
ZSB0aGF0IGNvbnNpc3RzIG9mIGEgbnVtYmVyIG9mIHBhZ2VzIG9mIHRoZSBzYW1lCj4+PiBwYWdl
IHNpemUgdGhhdCBpcyBzdXBwb3J0ZWQgYnkgdGhlIElPTU1VIGhhcmR3YXJlLCBhbmQgYWxsb3dz
IGZvcgo+Pj4gbWFuaXB1bGF0aW5nIG11bHRpcGxlIHBhZ2UgdGFibGUgZW50cmllcyBpbiB0aGUg
c2FtZSBzZXQgb2YgaW5kaXJlY3QKPj4+IGNhbGxzLiBUaGUgcmVhc29uIGZvciBpbnRyb2R1Y2lu
ZyB0aGVzZSBjYWxsYmFja3MgaXMgdG8gZ2l2ZSBvdGhlciAKPj4+IElPTU1VCj4+PiBkcml2ZXJz
L2lvLXBndGFibGUgZm9ybWF0cyB0aW1lIHRvIGNoYW5nZSB0byB1c2luZyB0aGUgbmV3IAo+Pj4g
Y2FsbGJhY2tzLCBzbwo+Pj4gdGhhdCB0aGUgdHJhbnNpdGlvbiB0byB1c2luZyB0aGlzIGFwcHJv
YWNoIGNhbiBiZSBkb25lIHBpZWNlbWVhbC4KPj4KPj4gSGkgV2lsbCwKPj4KPj4gRGlkIHlvdSBn
ZXQgYSBjaGFuY2UgdG8gbG9vayBhdCB0aGlzIHBhdGNoc2V0PyBNb3N0IHBhdGNoZXMgYXJlIGFs
cmVhZHkKPj4gYWNrZWQvcmV2aWV3ZWQgYW5kIGFsbCBzdGlsbCBhcHBsaWVzIGNsZWFuIG9uIHJj
MS4KPgo+IEkgYWxzbyBoYXZlIHRoZSBvcHMtPlt1bl1tYXBfcGFnZXMgaW1wbGVtZW50YXRpb24g
Zm9yIHRoZSBJbnRlbCBJT01NVQo+IGRyaXZlci4gSSB3aWxsIHBvc3QgdGhlbSBvbmNlIHRoZSBp
b21tdS9jb3JlIHBhcnQgZ2V0IGFwcGxpZWQuCgpJIGFsc28gaW1wbGVtZW50IHRob3NlIGNhbGxi
YWNrcyBvbiBBUk0gU01NVVYzIGJhc2VkIG9uIHRoaXMgc2VyaWVzLCBhbmQgCnVzZSBkbWFfbWFw
X2JlbmNobWFyayB0byBoYXZlIGEgdGVzdCBvbgp0aGUgbGF0ZW5jeSBvZiBtYXAvdW5tYXAgYXMg
Zm9sbG93cywgYW5kIGkgdGhpbmsgaXQgcHJvbW90ZXMgbXVjaCBvbiB0aGUgCmxhdGVuY3kgb2Yg
bWFwL3VubWFwLiBJIHdpbGwgYWxzbyBwbGFuIHRvIHBvc3QKdGhlIGltcGxlbWVudGF0aW9ucyBm
b3IgQVJNIFNNTVVWMyBhZnRlciB0aGlzIHNlcmllcyBhcmUgYXBwbGllZC4KCnQgPSAxKHRocmVh
ZCA9IDEpOgogICAgICAgICAgICAgICAgICAgIGJlZm9yZSBvcHQodXMpICAgYWZ0ZXIgb3B0KHVz
KQpnPTEoNEsgc2l6ZSkgICAgICAgIDAuMS8xLjMgICAgICAgICAgMC4xLzAuOApnPTIoOEsgc2l6
ZSkgICAgICAgIDAuMi8xLjUgICAgICAgICAgMC4yLzAuOQpnPTQoMTZLIHNpemUpICAgICAgIDAu
My8xLjkgICAgICAgICAgMC4xLzEuMQpnPTgoMzJLIHNpemUpICAgICAgIDAuNS8yLjcgICAgICAg
ICAgMC4yLzEuNApnPTE2KDY0SyBzaXplKSAgICAgIDEuMC80LjUgICAgICAgICAgMC4yLzIuMApn
PTMyKDEyOEsgc2l6ZSkgICAgIDEuOC83LjkgICAgICAgICAgMC4yLzMuMwpnPTY0KDI1Nksgc2l6
ZSkgICAgIDMuNy8xNC44ICAgICAgICAgMC40LzYuMQpnPTEyOCg1MTJLIHNpemUpICAgIDcuMS8x
NC43ICAgICAgICAgMC41LzEwLjQKZz0yNTYoMU0gc2l6ZSkgICAgICAxNC4wLzUzLjkgICAgICAg
IDAuOC8xOS4zCmc9NTEyKDJNIHNpemUpICAgICAgMC4yLzAuOSAgICAgICAgICAwLjIvMC45Cmc9
MTAyNCg0TSBzaXplKSAgICAgMC41LzEuNSAgICAgICAgICAwLjQvMS4wCgp0ID0gMTAodGhyZWFk
ID0gMTApOgogICAgICAgICAgICAgICAgICAgIGJlZm9yZSBvcHQodXMpICAgYWZ0ZXIgb3B0KHVz
KQpnPTEoNEsgc2l6ZSkgICAgICAgIDAuMy83LjAgICAgICAgICAgMC4xLzUuOApnPTIoOEsgc2l6
ZSkgICAgICAgIDAuNC82LjcgICAgICAgICAgMC4zLzYuMApnPTQoMTZLIHNpemUpICAgICAgIDAu
NS82LjMgICAgICAgICAgMC4zLzUuNgpnPTgoMzJLIHNpemUpICAgICAgIDAuNS84LjMgICAgICAg
ICAgMC4yLzYuMwpnPTE2KDY0SyBzaXplKSAgICAgIDEuMC8xNy4zICAgICAgICAgMC4zLzEyLjQK
Zz0zMigxMjhLIHNpemUpICAgICAxLjgvMzYuMCAgICAgICAgIDAuMi8yNC4yCmc9NjQoMjU2SyBz
aXplKSAgICAgNC4zLzY3LjIgICAgICAgICAxLjIvNDYuNApnPTEyOCg1MTJLIHNpemUpICAgIDcu
OC85My43ICAgICAgICAgMS4zLzk0LjIKZz0yNTYoMU0gc2l6ZSkgICAgICAxNC43LzI4MC44ICAg
ICAgIDEuOC8xOTEuNQpnPTUxMigyTSBzaXplKSAgICAgIDMuNi8zLjIgICAgICAgICAgMS41LzIu
NQpnPTEwMjQoNE0gc2l6ZSkgICAgIDIuMC8zLjEgICAgICAgICAgMS44LzIuNgoKCj4KPiBCZXN0
IHJlZ2FyZHMsCj4gYmFvbHUKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGlvbW11IG1haWxpbmcgbGlzdAo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXUKPgo+IC4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
