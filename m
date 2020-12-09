Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9DDC433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 12:11:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0D323B81
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 12:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0D323B81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1BC9F20778;
	Wed,  9 Dec 2020 12:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0+ZC-0wKPzhf; Wed,  9 Dec 2020 12:11:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B107B204BC;
	Wed,  9 Dec 2020 12:11:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D355C0FA7;
	Wed,  9 Dec 2020 12:11:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9462C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 12:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CD0AB86CF6
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 12:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7ZBxxkFOl6s for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:11:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 498BB86CDB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 12:11:27 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CrbVV5wThzhXm7;
 Wed,  9 Dec 2020 20:10:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 20:11:14 +0800
Subject: Re: [RESEND PATCH v3 3/4] iommu/iova: Flush CPU rcache for when a
 depot fills
To: John Garry <john.garry@huawei.com>, <robin.murphy@arm.com>,
 <joro@8bytes.org>, <will@kernel.org>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-4-git-send-email-john.garry@huawei.com>
 <76e057e3-9db8-21fc-3a8a-b9e924a95cf4@huawei.com>
 <851ba6cf-8f4c-74dc-3666-ee6d547999d3@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <552fd9c5-d3dd-e1b3-d7e8-2a30904f22c4@huawei.com>
Date: Wed, 9 Dec 2020 20:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <851ba6cf-8f4c-74dc-3666-ee6d547999d3@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Cc: xiyou.wangcong@gmail.com, iommu@lists.linux-foundation.org,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org
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

CgpPbiAyMDIwLzEyLzkgMTk6MjIsIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMDkvMTIvMjAyMCAw
OToxMywgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyMDIwLzExLzE3
IDE4OjI1LCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4gTGVpemhlbiByZXBvcnRlZCBzb21lIHRpbWUg
YWdvIHRoYXQgSU9WQSBwZXJmb3JtYW5jZSBtYXkgZGVncmFkZSBvdmVyIHRpbWUKPj4+IFswXSwg
YnV0IHVuZm9ydHVuYXRlbHkgaGlzIHNvbHV0aW9uIHRvIGZpeCB0aGlzIHByb2JsZW0gd2FzIG5v
dCBnaXZlbgo+Pj4gYXR0ZW50aW9uLgo+Pj4KPj4+IFRvIHN1bW1hcml6ZSwgdGhlIGlzc3VlIGlz
IHRoYXQgYXMgdGltZSBnb2VzIGJ5LCB0aGUgQ1BVIHJjYWNoZSBhbmQgZGVwb3QKPj4+IHJjYWNo
ZSBjb250aW51ZSB0byBncm93LiBBcyBzdWNoLCBJT1ZBIFJCIHRyZWUgYWNjZXNzIHRpbWUgYWxz
byBjb250aW51ZXMKPj4+IHRvIGdyb3cuCj4+Pgo+Pj4gQXQgYSBjZXJ0YWluIHBvaW50LCBhIGRl
cG90IG1heSBiZWNvbWUgZnVsbCwgYW5kIGFsc28gc29tZSBDUFUgcmNhY2hlcyBtYXkKPj4+IGFs
c28gYmUgZnVsbCB3aGVuIGluc2VydGluZyBhbm90aGVyIElPVkEgaXMgYXR0ZW1wdGVkLiBGb3Ig
dGhpcyBzY2VuYXJpbywKPj4+IGN1cnJlbnRseSB0aGUgImxvYWRlZCIgQ1BVIHJjYWNoZSBpcyBm
cmVlZCBhbmQgYSBuZXcgb25lIGlzIGNyZWF0ZWQuIFRoaXMKPj4+IGZyZWVpbmcgbWVhbnMgdGhh
dCBtYW55IElPVkFzIGluIHRoZSBSQiB0cmVlIG5lZWQgdG8gYmUgZnJlZWQsIHdoaWNoCj4+PiBt
YWtlcyBJTyB0aHJvdWdocHV0IHBlcmZvcm1hbmNlIGZhbGwgb2ZmIGEgY2xpZmYgaW4gc29tZSBz
dG9yYWdlIHNjZW5hcmlvczoKPj4+Cj4+PiBKb2JzOiAxMiAoZj0xMik6IFtSUlJSUlJSUlJSUlJd
IFswLjAlIGRvbmVdIFs2MzE0TUIvMEtCLzBLQiAvc10gWzE2MTZLLzAvMCBpb3BzXQo+Pj4gSm9i
czogMTIgKGY9MTIpOiBbUlJSUlJSUlJSUlJSXSBbMC4wJSBkb25lXSBbNTY2OU1CLzBLQi8wS0Ig
L3NdIFsxNDUxSy8wLzAgaW9wc10KPj4+IEpvYnM6IDEyIChmPTEyKTogW1JSUlJSUlJSUlJSUl0g
WzAuMCUgZG9uZV0gWzYwMzFNQi8wS0IvMEtCIC9zXSBbMTU0NEsvMC8wIGlvcHNdCj4+PiBKb2Jz
OiAxMiAoZj0xMik6IFtSUlJSUlJSUlJSUlJdIFswLjAlIGRvbmVdIFs2NjczTUIvMEtCLzBLQiAv
c10gWzE3MDhLLzAvMCBpb3BzXQo+Pj4gSm9iczogMTIgKGY9MTIpOiBbUlJSUlJSUlJSUlJSXSBb
MC4wJSBkb25lXSBbNjcwNU1CLzBLQi8wS0IgL3NdIFsxNzE3Sy8wLzAgaW9wc10KPj4+IEpvYnM6
IDEyIChmPTEyKTogW1JSUlJSUlJSUlJSUl0gWzAuMCUgZG9uZV0gWzYwMzFNQi8wS0IvMEtCIC9z
XSBbMTU0NEsvMC8wIGlvcHNdCj4+PiBKb2JzOiAxMiAoZj0xMik6IFtSUlJSUlJSUlJSUlJdIFsw
LjAlIGRvbmVdIFs2NzYxTUIvMEtCLzBLQiAvc10gWzE3MzFLLzAvMCBpb3BzXQo+Pj4gSm9iczog
MTIgKGY9MTIpOiBbUlJSUlJSUlJSUlJSXSBbMC4wJSBkb25lXSBbNjcwNU1CLzBLQi8wS0IgL3Nd
IFsxNzE3Sy8wLzAgaW9wc10KPj4+IEpvYnM6IDEyIChmPTEyKTogW1JSUlJSUlJSUlJSUl0gWzAu
MCUgZG9uZV0gWzY2ODVNQi8wS0IvMEtCIC9zXSBbMTcxMUsvMC8wIGlvcHNdCj4+PiBKb2JzOiAx
MiAoZj0xMik6IFtSUlJSUlJSUlJSUlJdIFswLjAlIGRvbmVdIFs2MTc4TUIvMEtCLzBLQiAvc10g
WzE1ODJLLzAvMCBpb3BzXQo+Pj4gSm9iczogMTIgKGY9MTIpOiBbUlJSUlJSUlJSUlJSXSBbMC4w
JSBkb25lXSBbNjczMU1CLzBLQi8wS0IgL3NdIFsxNzIzSy8wLzAgaW9wc10KPj4+IEpvYnM6IDEy
IChmPTEyKTogW1JSUlJSUlJSUlJSUl0gWzAuMCUgZG9uZV0gWzIzODdNQi8wS0IvMEtCIC9zXSBb
NjExSy8wLzAgaW9wc10KPj4+IEpvYnM6IDEyIChmPTEyKTogW1JSUlJSUlJSUlJSUl0gWzAuMCUg
ZG9uZV0gWzI2ODlNQi8wS0IvMEtCIC9zXSBbNjg4Sy8wLzAgaW9wc10KPj4+IEpvYnM6IDEyIChm
PTEyKTogW1JSUlJSUlJSUlJSUl0gWzAuMCUgZG9uZV0gWzIyNzhNQi8wS0IvMEtCIC9zXSBbNTgz
Sy8wLzAgaW9wc10KPj4+IEpvYnM6IDEyIChmPTEyKTogW1JSUlJSUlJSUlJSUl0gWzAuMCUgZG9u
ZV0gWzEyODhNQi8wS0IvMEtCIC9zXSBbMzMwSy8wLzAgaW9wc10KPj4+IEpvYnM6IDEyIChmPTEy
KTogW1JSUlJSUlJSUlJSUl0gWzAuMCUgZG9uZV0gWzE2MzJNQi8wS0IvMEtCIC9zXSBbNDE4Sy8w
LzAgaW9wc10KPj4+IEpvYnM6IDEyIChmPTEyKTogW1JSUlJSUlJSUlJSUl0gWzAuMCUgZG9uZV0g
WzE3NjVNQi8wS0IvMEtCIC9zXSBbNDUySy8wLzAgaW9wc10KPj4+Cj4+PiBBbmQgY29udGludWUg
aW4gdGhpcyBmYXNoaW9uLCB3aXRob3V0IHJlY292ZXJpbmcuIE5vdGUgdGhhdCBpbiB0aGlzCj4+
PiBleGFtcGxlIGl0IHdhcyByZXF1aXJlZCB0byB3YWl0IDE2IGhvdXJzIGZvciB0aGlzIHRvIG9j
Y3VyLiBBbHNvIG5vdGUgdGhhdAo+Pj4gSU8gdGhyb3VnaHB1dCBhbHNvIGJlY29tZXMgZ3JhZHVh
bGx5IGJlY29tZXMgbW9yZSB1bnN0YWJsZSBsZWFkaW5nIHVwIHRvCj4+PiB0aGlzIHBvaW50Lgo+
Pj4KPj4+IFRoaXMgcHJvYmxlbSBpcyBvbmx5IHNlZW4gZm9yIG5vbi1zdHJpY3QgbW9kZS4gRm9y
IHN0cmljdCBtb2RlLCB0aGUgcmNhY2hlcwo+Pj4gc3RheSBxdWl0ZSBjb21wYWN0Lgo+Pj4KPj4+
IEFzIGEgc29sdXRpb24gdG8gdGhpcyBpc3N1ZSwganVkZ2UgdGhhdCB0aGUgSU9WQSBjYWNoZXMg
aGF2ZSBncm93biB0b28gYmlnCj4+PiB3aGVuIGNhY2hlZCBtYWdhemluZXMgbmVlZCB0byBiZSBm
cmVlLCBhbmQganVzdCBmbHVzaCBhbGwgdGhlIENQVXMgcmNhY2hlcwo+Pj4gaW5zdGVhZC4KPj4+
Cj4+PiBUaGUgZGVwb3QgcmNhY2hlcywgaG93ZXZlciwgYXJlIG5vdCBmbHVzaGVkLCBhcyB0aGV5
IGNhbiBiZSB1c2VkIHRvCj4+PiBpbW1lZGlhdGVseSByZXBsZW5pc2ggYWN0aXZlIENQVXMuCj4+
Pgo+Pj4gSW4gZnV0dXJlLCBzb21lIElPVkEgY29tcGFjdGlvbiBjb3VsZCBiZSBpbXBsZW1lbnRl
ZCB0byBzb2x2ZSB0aGUKPj4+IGluc3RhYmlsdHkgaXNzdWUsIHdoaWNoIEkgZmlndXJlIGNvdWxk
IGJlIHF1aXRlIGNvbXBsZXggdG8gaW1wbGVtZW50Lgo+Pj4KPj4+IFswXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1pb21tdS8yMDE5MDgxNTEyMTEwNC4yOTE0MC0zLXRodW5kZXIubGVp
emhlbkBodWF3ZWkuY29tLwo+Pj4KPj4+IEFuYWx5emVkLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5s
ZWl6aGVuQGh1YXdlaS5jb20+Cj4+PiBSZXBvcnRlZC1ieTogWGlhbmcgQ2hlbiA8Y2hlbnhpYW5n
NjZAaGlzaWxpY29uLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gR2FycnkgPGpvaG4uZ2Fy
cnlAaHVhd2VpLmNvbT4KPiAKPiBUaGFua3MgZm9yIGhhdmluZyBhIGxvb2sKPiAKPj4+IC0tLQo+
Pj4gwqAgZHJpdmVycy9pb21tdS9pb3ZhLmMgfCAxNiArKysrKystLS0tLS0tLS0tCj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+
Pj4gaW5kZXggMWYzZjBmOGIxMmUwLi4zODYwMDUwNTVhY2EgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL2lvbW11L2lvdmEuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+IEBAIC05
MDEsNyArOTAxLDYgQEAgc3RhdGljIGJvb2wgX19pb3ZhX3JjYWNoZV9pbnNlcnQoc3RydWN0IGlv
dmFfZG9tYWluICppb3ZhZCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgaW92YV9yY2FjaGUgKnJjYWNoZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGlvdmFfcGZuKQo+Pj4gwqAgewo+Pj4gLcKgwqDC
oCBzdHJ1Y3QgaW92YV9tYWdhemluZSAqbWFnX3RvX2ZyZWUgPSBOVUxMOwo+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgaW92YV9jcHVfcmNhY2hlICpjcHVfcmNhY2hlOwo+Pj4gwqDCoMKgwqDCoCBib29s
IGNhbl9pbnNlcnQgPSBmYWxzZTsKPj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsK
Pj4+IEBAIC05MjMsMTMgKzkyMiwxMiBAQCBzdGF0aWMgYm9vbCBfX2lvdmFfcmNhY2hlX2luc2Vy
dChzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoY3B1X3JjYWNoZS0+bG9hZGVkKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjYWNoZS0+ZGVwb3RbcmNhY2hlLT5kZXBvdF9zaXpl
KytdID0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3B1X3JjYWNoZS0+bG9hZGVkOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIHsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFnX3RvX2Zy
ZWUgPSBjcHVfcmNhY2hlLT5sb2FkZWQ7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNhbl9pbnNlcnQgPSB0cnVlOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjcHVfcmNhY2hlLT5sb2FkZWQgPSBuZXdfbWFnOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnJjYWNo
ZS0+bG9jayk7Cj4+PiAtCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfcmNhY2hlLT5s
b2FkZWQgPSBuZXdfbWFnOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FuX2luc2VydCA9
IHRydWU7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWNhbl9pbnNlcnQpCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvdmFfbWFnYXppbmVfZnJlZShuZXdfbWFn
KTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgIEBAIC05
MzgsMTAgKzkzNiw4IEBAIHN0YXRpYyBib29sIF9faW92YV9yY2FjaGVfaW5zZXJ0KHN0cnVjdCBp
b3ZhX2RvbWFpbiAqaW92YWQsCj4+PiDCoCDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmNwdV9yY2FjaGUtPmxvY2ssIGZsYWdzKTsKPj4+IMKgIC3CoMKgwqAgaWYgKG1hZ190b19m
cmVlKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaW92YV9tYWdhemluZV9mcmVlX3BmbnMobWFnX3Rv
X2ZyZWUsIGlvdmFkKTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBpb3ZhX21hZ2F6aW5lX2ZyZWUobWFn
X3RvX2ZyZWUpOwo+PiBtYWdfdG9fZnJlZSBoYXMgYmVlbiBzdHJpcHBlZCBvdXQsIHRoYXQncyB3
aHkgbG9jayBwcm90ZWN0aW9uIGlzIG5vdCByZXF1aXJlZCBoZXJlLgo+Pgo+Pj4gLcKgwqDCoCB9
Cj4+PiArwqDCoMKgIGlmICghY2FuX2luc2VydCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBmcmVlX2Fs
bF9jcHVfY2FjaGVkX2lvdmFzKGlvdmFkKTsKPj4gTG9jayBwcm90ZWN0aW9uIHJlcXVpcmVkLgo+
IAo+IEJ1dCB3ZSBoYXZlIHRoZSBwZXItQ1BVIHJjYWNoZSBsb2NraW5nIGFnYWluIGluIGZyZWVf
Y3B1X2NhY2hlZF9pb3ZhcygpICh3aGljaCBpcyBjYWxsZWQgcGVyLUNQVSBmcm9tIGZyZWVfYWxs
X2NwdV9jYWNoZWRfaW92YXMoKSkuCj4gCj4gb2s/IE9yIHNvbWUgb3RoZXIgbG9jayB5b3UgbWVh
bj8KCk9oLCBTb3JyeSwgdGhpbmsgb2YgZnVuY3Rpb24gZnJlZV9jcHVfY2FjaGVkX2lvdmFzKCkg
YXMgZnVuY3Rpb24gZnJlZV9pb3ZhX3JjYWNoZXMoKS4KClJldmlld2VkLWJ5OiBaaGVuIExlaSA8
dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+Cgo+IAo+IENoZWVycywKPiBKb2huCj4gCj4+Cj4+
PiDCoCDCoMKgwqDCoMKgIHJldHVybiBjYW5faW5zZXJ0Owo+Pj4gwqAgfQo+Pj4KPj4KPj4gLgo+
Pgo+IAo+IAo+IC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
