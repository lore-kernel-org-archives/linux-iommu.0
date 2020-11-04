Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285FC388F7
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 08:31:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753B720781
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 08:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753B720781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D277F86880;
	Wed,  4 Nov 2020 08:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VEajjqFGHgQt; Wed,  4 Nov 2020 08:31:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CBDCF8685B;
	Wed,  4 Nov 2020 08:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD0E8C088B;
	Wed,  4 Nov 2020 08:31:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68D73C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 552BE86C3A
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZrpZ7aDbgQae for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 08:31:33 +0000 (UTC)
X-Greylist: delayed 00:15:39 by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A0BB86BBE
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:31:33 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CQzvp6CMhz67HRq;
 Wed,  4 Nov 2020 16:14:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 4 Nov 2020 09:15:50 +0100
Received: from [10.210.165.147] (10.210.165.147) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 4 Nov 2020 08:15:49 +0000
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot fills
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
 <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
 <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c409594a-0ae1-d8cd-ddee-226d739eed5b@huawei.com>
Date: Wed, 4 Nov 2020 08:15:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.165.147]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
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

SGkgUm9iaW4sCgo+PiAtIHRoZW4gY3B1MywgY3B1NCwgYW5kIHNvIG9uLgo+PiAtIFdlIGNhbiBk
byB0aGlzIGZvciBhbGwgQ1BVcyBpbiB0aGUgc3lzdGVtLCBzbyB0b3RhbCBDUFUgcmNhY2hlIGdy
b3dzIAo+PiBmcm9tIHplcm8gLT4gI0NQVXMgKiAxMjggKiAyLiBZZXQgbm8gRE1BIG1hcHBpbmcg
bGVha3MuCj4gCj4gSSBnZXQgdGhhdC4gVGhhdCdzIHRoZSBpbml0aWFsIHdhcm0tdXAgcGhhc2Ug
SSBhbGx1ZGVkIHRvIGJlbG93LiBJbiBhbiAKPiBldmVuIHNpbXBsZXIgZXhhbXBsZSwgYWxsb2Nh
dGluZyBvbiBDUFUgQSBhbmQgZnJlZWluZyBvbiBDUFUgQiB3aWxsIAo+IGluZGVlZCBtb3ZlIElP
VkFzIGZyb20gdGhlIHRyZWUgaW50byBtYWdhemluZXMgd2l0aG91dCByZXVzZSwgYnV0IG9ubHkg
Cj4gdXAgdG8gYSBwb2ludC4gRXZlbnR1YWxseSwgQ1BVIEIncyBjYWNoZSBmaWxscyB1cCBhbmQg
cHVzaGVzIGEgbWFnYXppbmUgCj4gaW50byB0aGUgZGVwb3QsIGFuZCBhdCAqdGhhdCogcG9pbnQg
dGhpbmdzIHJlYWNoIGEgc3RlYWR5IHN0YXRlLCBzaW5jZSAKPiB0aGUgbmV4dCBhbGxvY2F0aW9u
IG9uIENQVSBBIHdpbGwgdGhlbiBwdWxsIHRoYXQgbWFnYXppbmUgZnJvbSB0aGUgZGVwb3QgCj4g
YW5kIHByb2NlZWQgdG8gYWxsb2NhdGUgZnJvbSB0aGVyZS4gSWYgYWxsb2NzIGFuZCBmcmVlcyBz
dGF5IHBlcmZlY3RseSAKPiBiYWxhbmNlZCwgdGhlIHdvcmtpbmcgc2V0IGlzIHRoZW4gMyBtYWdh
emluZXMuIFllcywgdGhlIGRlcG90IGNhbiBmaWxsIAo+IHVwIGlmIHRoZSBudW1iZXIgb2YgSU9W
QXMgdGhhdCBDUFUgQiBmcmVlcyBhdCBvbmNlIGJlZm9yZSBDUFUgQSAKPiByZWFsbG9jYXRlcyB0
aGVtIGlzIGNvbXBhcmFibGUgdG8gdGhlIHRvdGFsIGRlcG90IGNhcGFjaXR5LCBidXQgaXQgY2Fu
J3QgCj4gcmVhc29uYWJseSAqc3RheSogZnVsbCB1bmxlc3MgQ1BVIEEgc3RvcHMgYWxsb2NhdGlu
ZyBhbHRvZ2V0aGVyLgo+IAo+PiBTb21ldGhpbmcgc2ltaWxhciBjYW4gaGFwcGVuIGluIG5vcm1h
bCB1c2UsIHdoZXJlIHRoZSBzY2hlZHVsZXIgCj4+IHJlbG9jYXRlcyBwcm9jZXNzZXMgYWxsIG92
ZXIgdGhlIENQVXMgaW4gdGhlIHN5c3RlbSBhcyB0aW1lIGdvZXMgYnksIAo+PiB3aGljaCBjYXVz
ZXMgdGhlIHRvdGFsIHJjYWNoZSBzaXplIHRvIGNvbnRpbnVlIHRvIGdyb3cuIEFuZCBpbiAKPj4g
YWRkaXRpb24gdG8gdGhpcywgdGhlIGdsb2JhbCBkZXBvdCBjb250aW51ZXMgdG8gZ3JvdyB2ZXJ5
IHNsb3dseSBhcyAKPj4gd2VsbC4gQnV0IHdoZW4gaXQgZG9lcyBmaWxsICh0aGUgZ2xvYmFsIGRl
cG90LCB0aGF0IGlzKSwgYW5kIHdlIHN0YXJ0IAo+PiB0byBmcmVlIG1hZ2F6aW5lcyB0byBtYWtl
IHNwYWNlIOKAkyBhcyBpcyBjdXJyZW50IHBvbGljeSAtIHRoYXQncyB2ZXJ5IAo+PiBzbG93IGFu
ZCBjYXVzZXMgdGhlIHBlcmZvcm1hbmNlIGRyb3AuCj4gCj4gU3VyZSwgYnV0IGhvdyBkb2VzIGl0
IHRoZW4gY29uc2lzdGVudGx5ICpyZW1haW4qIGluIHRoYXQgc3RhdGU/IEFuZCAKPiAqd2h5KiBk
b2VzIHRoZSBkZXBvdCBzbG93bHkgYW5kIHN0ZWFkaWx5IGdyb3cgaW4gdGhlIGZpcnN0IHBsYWNl
IGlmIAo+IGFsbG9jIGFuZCBmcmVlIGFyZSB1bHRpbWF0ZWx5IGJhbGFuY2VkPyAKClNvIHNvbWUg
a2V5IGluZm8gSSBtaXNzZWQgc2hhcmluZyB3YXMgdGhhdCB3ZSBvbmx5IHNlZSB0aGlzIGlzc3Vl
IGZvciAKbm9uLXN0cmljdCBtb2RlLiBGb3Igc3RyaWN0IG1vZGUsIHRoZSByY2FjaGUgb2NjdXBh
bmN5IHN0YXlzIHF1aXRlIApjb21wYWN0LCBhbmQgZG9lcyBub3QgZ3JvdyBsaWtlIHdlIHNlZSBm
b3Igbm9uLXN0cmljdCBtb2RlLgoKSSBoYXZlIHNvbWUgKHZlcnkgbGFyZ2UpIGtlcm5lbCBsb2dz
IGluIHdoaWNoIGFsbCB0aGUgQ1BVIGFuZCBkZXBvdCAKcmNhY2hlIG9jY3VwYW5jeSBsZXZlbHMg
YXJlIHBlcmlvZGljYWxseSBkdW1wZWQsIGFuZCB3aGVyZSB5b3UgY2FuIGdldCAKYW4gaWRlYSBv
ZiB0aGUgdHJlbmQuCgpJJ20gb24gdmFjYXRpb24gdG9kYXksIHNvIEkgY2FuIHNoYXJlIHRoZW0g
dG9tb3Jyb3cuCgo+IEkgY2FuIGdldCB0aGUgZGVwb3Qgc3dpbmdpbmcgCj4gYmV0d2VlbiBmdWxs
IGFuZCBlbXB0eSBpZiBpdCdzIHNpbXBseSB0b28gc21hbGwgdG8gYm91bmNlIG1hZ2F6aW5lcyAK
PiBiZXR3ZWVuIGEgbGFyZ2UgbnVtYmVyIG9mICJDUFUgQSJzIGFuZCAiQ1BVIEIicywgYnV0IGFn
YWluLCB0aGF0J3MgCj4gc3VyZWx5IGdvaW5nIHRvIHNob3cgYXMgcmVwZWF0ZWQgcGVyZm9ybWFu
Y2Ugc3dpbmdzIGJldHdlZW4gYmFkIGF0IGVhY2ggCj4gZW5kIGFuZCBnb29kIGluIHRoZSBtaWRk
bGUsIG5vdCBhIHN0ZWFkeSBkZWdyYWRhdGlvbi4KClllYWgsIHNvIEkgc2VlIHRoZSBkZXBvdCBt
YXggc2l6ZSAoMzIpIGlzIGFkZXF1YXRlIGluIHNpemUsIHN1Y2ggdGhhdCAKdGhpcyBkb2VzIG5v
dCBoYXBwZW4uCgo+IAo+Pj4gTm93IGluZGVlZCB0aGF0IGNvdWxkIGhhcHBlbiBvdmVyIHRoZSBz
aG9ydCB0ZXJtIGlmIElPVkFzIGFyZSBhbGxvY2F0ZWQKPj4+IGFuZCBmcmVlZCBhZ2FpbiBpbiBn
aWFudCBiYXRjaGVzIGxhcmdlciB0aGFuIHRoZSB0b3RhbCBnbG9iYWwgY2FjaGUKPj4+IGNhcGFj
aXR5LCBidXQgdGhhdCB3b3VsZCBzaG93IGEgY3ljbGljIGJlaGF2aW91ciAtIHdoZW4gYWN0aXZp
dHkgc3RhcnRzLAo+Pj4gZXZlcnl0aGluZyBpcyBmaXJzdCBhbGxvY2F0ZWQgc3RyYWlnaHQgZnJv
bSB0aGUgdHJlZSwgdGhlbiB3aGVuIGl0IGVuZHMKPj4+IHRoZSBjYWNoZXMgd291bGQgZ2V0IG92
ZXJ3aGVsbWVkIGJ5IHRoZSBsYXJnZSBidXJzdCBvZiBmcmVlaW5nIGFuZCBzdGFydAo+Pj4gaGF2
aW5nIHRvIHJlbGVhc2UgdGhpbmdzIGJhY2sgdG8gdGhlIHRyZWUsIGJ1dCBldmVudHVhbGx5IHRo
YXQgd291bGQKPj4+IHN0b3Agb25jZSBldmVyeXRoaW5nICppcyogZnJlZWQsIHRoZW4gd2hlbiBh
Y3Rpdml0eSBiZWdpbnMgYWdhaW4gdGhlCj4+PiBuZXh0IHJvdW5kIG9mIGFsbG9jYXRpbmcgd291
bGQgaW5oZXJlbnRseSBjbGVhciBvdXQgYWxsIHRoZSBjYWNoZXMKPj4+IGJlZm9yZSBnb2luZyBh
bnl3aGVyZSBuZWFyIHRoZSB0cmVlLiAKPj4KPj4gQnV0IHRoZXJlIGlzIG5vIGNsZWFyaW5nLiBB
IENQVSB3aWxsIGtlZXAgdGhlIElPVkEgY2FjaGVkIAo+PiBpbmRlZmluaXRlbHksIGV2ZW4gd2hl
biB0aGVyZSBpcyBubyBhY3RpdmUgRE1BIG1hcHBpbmcgcHJlc2VudCBhdCBhbGwuCj4gCj4gU3Vy
ZSwgdGhlIHBlcmNwdSBjYWNoZXMgY2FuIGJ1ZmZlciBJT1ZBcyBmb3IgYW4gaW5kZWZpbml0ZSBh
bW91bnQgb2YgCj4gdGltZSBkZXBlbmRpbmcgb24gaG93IG1hbnkgQ1BVcyBhcmUgYWN0aXZlLCBi
dXQgdGhlIGRlcG90IHVzYWdlIGlzIHN0aWxsIAo+IGFic29sdXRlbHkgcmVwcmVzZW50YXRpdmUg
b2YgdGhlIHRvdGFsIHdvcmtpbmcgc2V0IGZvciB3aGljaGV2ZXIgQ1BVcyAKPiAqYXJlKiBhY3Rp
dmUuIEluIHRoaXMgd2hvbGUgZGlzY3Vzc2lvbiBJJ20gYmFzaWNhbGx5IGp1c3QgY29uc2lkZXJp
bmcgCj4gdGhlIHBlcmNwdSBjYWNoZXMgYXMgcGlwZWxpbmUgc3RhZ2VzIGZvciBzZXJpYWxpc2lu
ZyBJT1ZBcyBpbnRvIGFuZCBvdXQgCj4gb2YgbWFnYXppbmVzLiBJdCdzIHRoZSBtb3Rpb24gb2Yg
bWFnYXppbmVzIHRoYXQncyB0aGUgaW50ZXJlc3RpbmcgcGFydC4KPiAKPiBJZiB0aGUgZGVwb3Qg
a2VlcHMgY29udGludWFsbHkgZmlsbGluZyB1cCwgKnNvbWUqIENQVXMgYXJlIGZyZWVpbmcgCj4g
ZW5vdWdoIElPVkFzIHRvIHB1c2ggb3V0IGZ1bGwgbWFnYXppbmVzLCBhbmQgdGhvc2UgSU9WQXMg
aGF2ZSB0byBjb21lIAo+IGZyb20gc29tZXdoZXJlLCBzbyAqc29tZSogQ1BVcyBhcmUgYWxsb2Nh
dGluZywgYW5kIHRob3NlIENQVXMgY2FuJ3QgCj4gYWxsb2NhdGUgZm9yZXZlciB3aXRob3V0IHRh
a2luZyBtYWdhemluZXMgYmFjayBvdXQgb2YgdGhlIGRlcG90ICh0aGF0J3MgCj4gdGhlICJjbGVh
cmluZyBvdXQiIEkgbWVhbnQpLiBTb21ldGhpbmcgYWJvdXQgYSBzdGVhZHkgZGVncmFkYXRpb24g
dGhhdCAKPiBuZXZlciBzaG93cyBhbnkgc2lnbiBvZiByZWNvdmVyeSAoZXZlbiBwZXJpb2RpY2Fs
bHkpIGp1c3QgZG9lc24ndCBzZWVtIAo+IHRvIGFkZCB1cC4KPiAKPiBBbnl3YXksIGJ5IG5vdyBJ
IHRoaW5rIGl0IHdvdWxkIGJlIG1vc3QgaW50ZXJlc3RpbmcgdG8gZ2V0IHJpZCBvZiB0aGlzIAo+
IGJvdHRsZW5lY2sgY29tcGxldGVseSByYXRoZXIgdGhhbiBkYW5jZSBhcm91bmQgYm9kZ2luZyBp
dCwgYW5kIHNlZSB3aGF0IAo+IGhhcHBlbnMgaWYgd2Ugc2ltcGx5IGxldCB0aGUgZGVwb3QgZ3Jv
dyB0byBmaXQgdGhlIG1heGltdW0gd29ya2luZyBzZXQsIAo+IHNvIEkgZGlkIHRoaXM6Cj4gCj4g
aHR0cHM6Ly9naXRsYWIuYXJtLmNvbS9saW51eC1hcm0vbGludXgtcm0vLS9jb21taXRzL2lvbW11
L2lvdmEKPiAKPiBPbmx5IGNvbXBpbGUtdGVzdGVkLCBzbyBwcm9iYWJseSBmdWxsIG9mIHRyaXZp
YWwgYnVncywgYnV0IEknbSBjdXJpb3VzIAo+IHRvIHNlZSBpZiB0aGUgc2xpZ2h0IGV4dHJhIG92
ZXJoZWFkIHRvIGRlcG90IG1hbmFnZW1lbnQgaXMgbm90aWNlYWJsZSBpbiAKPiBub3JtYWwgY2Fz
ZXMuCgpTbyBhbGxvd2luZyB0aGUgZGVwb3Qgc2l6ZSB0byBncm93IHVuYm91bmRlZCBzaG91bGQg
c29sdmUgdGhhdCBpbW1lZGlhdGUgCmlzc3VlLgoKSG93ZXZlciwgSSdkIGxpa2UgdG8gc2VlIGEg
bW92ZSBpbiB0aGUgb3Bwb3NpdGUgZGlyZWN0aW9uLCB0aGF0IGlzIHRvIAp0cmltIHRoZSByY2Fj
aGVzIGF0IHNvbWUgaW50ZXJ2YWxzLiBJbmRlZWQsIHdpdGggYW4gYXBwcmVjaWFibGUgCmZyZXF1
ZW5jeSwgSU9WQSByY2FjaGUgYWxsb2NhdGlvbiByZXF1ZXN0cyBtYXkgbm90IGJlIHNhdGlzZmll
ZCBkdWUgdG8gCnNpemUgbGltaXQgLSB3ZSBzZWUgdGhpcyBmb3Igb3VyIHNhbWUgc3RvcmFnZSBz
Y2VuYXJpbywgd2hlcmUgc29tZSBJT1ZBIApyZXF1ZXN0cyBhcmUgPiAyMDBLIGluIHNpemUsIGFu
ZCBtdXN0IHVzZSB0aGUgdHJlZS4gU28gYWxsb3dpbmcgdGhlIApyY2FjaGVzIHRvIGdyb3cgZnVy
dGhlciBqdXN0IG1ha2VzIGhhbmRsaW5nIHRoZXNlIHJlcXVlc3RzIHNsb3dlci4KClRoYW5rcywK
Sm9obgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
