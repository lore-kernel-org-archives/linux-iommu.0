Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0EEC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 08:39:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A490524671
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 08:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQYZd/ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A490524671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28B52860F9;
	Tue, 17 Nov 2020 08:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VyC2c7HiC1C; Tue, 17 Nov 2020 08:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E06285CFE;
	Tue, 17 Nov 2020 08:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43D3DC0891;
	Tue, 17 Nov 2020 08:39:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D61AC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 08:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2976020386
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 08:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSDwQKzfXl20 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 08:39:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id ABEBF20009
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605602393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1R2Oej2qk/ViRPwh0/U2GX+OhMC9Ake3lJNa//gEoY=;
 b=HQYZd/ixoJ4B7rSYEPU2qXK4v4UAL+UQGuW9lhU1llfxDw3srrM9BEqreor5YxdFQuWHCx
 NydQSkoC6R1AQT5gNDQ++vXj44ASPr79R7OHFjWXzQ/GCby53iqSWyTlseuHsL3KIUziQG
 QOAn1ix8a9jCnJ4LBn39DrcJ8jQC0Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-5KeOuAeIMG6pvM2MHmcMaw-1; Tue, 17 Nov 2020 03:39:49 -0500
X-MC-Unique: 5KeOuAeIMG6pvM2MHmcMaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 706FC8030C7;
 Tue, 17 Nov 2020 08:39:47 +0000 (UTC)
Received: from [10.36.113.230] (ovpn-113-230.ams2.redhat.com [10.36.113.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67925D9CC;
 Tue, 17 Nov 2020 08:39:39 +0000 (UTC)
Subject: Re: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20200414150607.28488-1-eric.auger@redhat.com>
 <eb27f625-ad7a-fcb5-2185-5471e4666f09@linaro.org>
 <06fe02f7-2556-8986-2f1e-dcdf59773b8c@redhat.com>
 <c7786a2a314e4c4ab37ef157ddfa23af@huawei.com>
 <3858dd8c-ee55-b0d7-96cc-3c047ba8f652@redhat.com>
 <9e323c4668e94ea89beec3689376b893@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a96395ff-09c2-8839-7a72-7b4031b5a5f4@redhat.com>
Date: Tue, 17 Nov 2020 09:39:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9e323c4668e94ea89beec3689376b893@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>
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

SGkgU2hhbWVlciwKCk9uIDUvMTMvMjAgNTo1NyBQTSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9k
aSB3cm90ZToKPiBIaSBFcmljLAo+IAo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBG
cm9tOiBBdWdlciBFcmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQo+PiBTZW50OiAx
MyBNYXkgMjAyMCAxNDoyOQo+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsKPj4gWmhhbmdmZWkgR2FvIDx6aGFuZ2Zl
aS5nYW9AbGluYXJvLm9yZz47IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsKPj4gaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7Cj4+
IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IGt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHU7IHdpbGxA
a2VybmVsLm9yZzsKPj4gam9yb0A4Ynl0ZXMub3JnOyBtYXpAa2VybmVsLm9yZzsgcm9iaW4ubXVy
cGh5QGFybS5jb20KPj4gQ2M6IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgYWxleC53aWxsaWFt
c29uQHJlZGhhdC5jb207Cj4+IGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tOyB5aS5sLmxp
dUBpbnRlbC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsKPj4gdG5Ac2VtaWhhbGYuY29t
OyBiYmh1c2hhbjJAbWFydmVsbC5jb20KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDAvMTNd
IFNNTVV2MyBOZXN0ZWQgU3RhZ2UgU2V0dXAgKElPTU1VIHBhcnQpCj4+Cj4gWy4uLl0KPiAKPj4+
Pj4gWWVzIHRoYXQncyBub3JtYWwgdGhpcyBzZXJpZXMgaXMgbm90IG1lYW50IHRvIHN1cHBvcnQg
dlNWTSBhdCB0aGlzIHN0YWdlLgo+Pj4+Pgo+Pj4+PiBJIGludGVuZCB0byBhZGQgdGhlIG1pc3Np
bmcgcGllY2VzIGR1cmluZyB0aGUgbmV4dCB3ZWVrcy4KPj4+Pgo+Pj4+IFRoYW5rcyBmb3IgdGhh
dC4gSSBoYXZlIG1hZGUgYW4gYXR0ZW1wdCB0byBhZGQgdGhlIHZTVkEgYmFzZWQgb24KPj4+PiB5
b3VyIHYxMCArIEpQQnMgc3ZhIHBhdGNoZXMuIFRoZSBob3N0IGtlcm5lbCBhbmQgUWVtdSBjaGFu
Z2VzIGNhbgo+Pj4+IGJlIGZvdW5kIGhlcmVbMV1bMl0uCj4+Pj4KPj4+PiBUaGlzIGJhc2ljYWxs
eSBhZGRzIG11bHRpcGxlIHBhc2lkIHN1cHBvcnQgb24gdG9wIG9mIHlvdXIgY2hhbmdlcy4KPj4+
PiBJIGhhdmUgZG9uZSBzb21lIGJhc2ljIHNhbml0eSB0ZXN0aW5nIGFuZCB3ZSBoYXZlIHNvbWUg
aW5pdGlhbCBzdWNjZXNzCj4+Pj4gd2l0aCB0aGUgemlwIHZmIGRldiBvbiBvdXIgRDA2IHBsYXRm
b3JtLiBQbGVhc2Ugbm90ZSB0aGF0IHRoZSBTVEFMTCBldmVudCBpcwo+Pj4+IG5vdCB5ZXQgc3Vw
cG9ydGVkIHRob3VnaCwgYnV0IHdvcmtzIGZpbmUgaWYgd2UgbWxvY2soKSBndWVzdCB1c3IgbWVt
Lgo+Pj4KPj4+IEkgaGF2ZSBhZGRlZCBTVEFMTCBzdXBwb3J0IGZvciBvdXIgdlNWQSBwcm90b3R5
cGUgYW5kIGl0IHNlZW1zIHRvIGJlCj4+PiB3b3JraW5nKG9uIG91ciBoYXJkd2FyZSkuIEkgaGF2
ZSB1cGRhdGVkIHRoZSBrZXJuZWwgYW5kIHFlbXUgYnJhbmNoZXMKPj4gd2l0aAo+Pj4gdGhlIHNh
bWVbMV1bMl0uIEkgc2hvdWxkIHdhcm4geW91IHRob3VnaCB0aGF0IHRoZXNlIGFyZSBwcm90b3R5
cGUgY29kZSBhbmQgSQo+PiBhbSBwcmV0dHkKPj4+IG11Y2ggcmUtdXNpbmcgdGhlIFZGSU9fSU9N
TVVfU0VUX1BBU0lEX1RBQkxFIGludGVyZmFjZSBmb3IgYWxtb3N0Cj4+IGV2ZXJ5dGhpbmcuCj4+
PiBCdXQgdGhvdWdodCBvZiBzaGFyaW5nLCBpbiBjYXNlIGlmIGl0IGlzIHVzZWZ1bCBzb21laG93
IS4KPj4KPj4gVGhhbmsgeW91IGFnYWluIGZvciBzaGFyaW5nIHRoZSBQT0MuIEkgbG9va2VkIGF0
IHRoZSBrZXJuZWwgYW5kIFFFTVUKPj4gYnJhbmNoZXMuCj4+Cj4+IEhlcmUgYXJlIHNvbWUgcHJl
bGltaW5hcnkgY29tbWVudHM6Cj4+IC0gImFybS1zbW11LXYzOiBSZXNldCBTMlRUQiB3aGlsZSBz
d2l0Y2hpbmcgYmFjayBmcm9tIG5lc3RlZCBzdGFnZSI6ICBhcwo+PiB5b3UgbWVudGlvbm5lZCBT
MlRUQiByZXNldCBub3cgaXMgZmVhdHVyZWQgaW4gdjExCj4gCj4gWWVzLgo+IAo+PiAtICJhcm0t
c21tdS12MzogQWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIHBhc2lkIGluIG5lc3RlZCBtb2RlIjog
SSBjb3VsZAo+PiBlYXNpbHkgaW50ZWdyYXRlIHRoaXMgaW50byBteSBzZXJpZXMuIFVwZGF0ZSB0
aGUgaW9tbXUgYXBpIGZpcnN0IGFuZAo+PiBwYXNzIG11bHRpcGxlIENEIGluZm8gaW4gYSBzZXBh
cmF0ZSBwYXRjaAo+IAo+IE9rLgppbiB2MTIsIEkgYWRkZWQKW1BBVENIIHYxMiAxNC8xNV0gaW9t
bXUvc21tdXYzOiBBY2NlcHQgY29uZmlncyB3aXRoIG1vcmUgdGhhbiBvbmUKY29udGV4dCBkZXNj
cmlwdG9yCgpJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIGFkZCBzMWNkbWF4IGFkZGl0aW9uIGFz
IHdlIGFscmVhZHkgaGF2ZQpwYXNpZF9iaXRzIHdoaWNoIHNob3VsZCBkbyB0aGUgam9iLgoKPj4g
LSAiYXJtLXNtbXUtdjM6IEFkZCBzdXBwb3J0IHRvIEludmFsaWRhdGUgQ0QiOiBDRCBpbnZhbGlk
YXRpb24gc2hvdWxkIGJlCj4+IGNhc2NhZGVkIHRvIGhvc3QgdGhyb3VnaCB0aGUgUEFTSUQgY2Fj
aGUgaW52YWxpZGF0aW9uIHVhcGkgKG5vIHBiIHlvdQo+PiB3YXJuZWQgdXMgZm9yIHRoZSBQT0Mg
eW91IHNpbXBseSB1c2VkIFZGSU9fSU9NTVVfU0VUX1BBU0lEX1RBQkxFKS4gSQo+PiB0aGluayBJ
IHNob3VsZCBhZGQgdGhpcyBzdXBwb3J0IGluIG15IG9yaWdpbmFsIHNlcmllcyBhbHRob3VnaCBp
dCBkb2VzCj4+IG5vdCBzZWVtIHRvIHRyaWdnZXIgYW55IGlzc3VlIHVwIHRvIG5vdy4KPiAKPiBB
Z3JlZS4gQ2FjaGUgaW52YWxpZGF0aW9uIHVhcGkgaXMgYSBiZXR0ZXIgaW50ZXJmYWNlIGZvciB0
aGlzLiBBbHNvIEkgZG9u4oCZdCB0aGluawo+IHRoaXMgbWF0dGVycyBmb3Igbm9uLXZzdmEgY2Fz
ZXMgYXMgR3Vlc3Qga2VybmVsIHRhYmxlL0NEKHBhc2lkIDApIHdpbGwgbmV2ZXIKPiBnZXQgaW52
YWxpZGF0ZWQuIAppbiB2MTIgSSBhZGRlZCBbUEFUQ0ggdjEyIDE1LzE1XSBpb21tdS9zbW11djM6
IEFkZCBQQVNJRCBjYWNoZQppbnZhbGlkYXRpb24gcGVyIFBBU0lELiBJIGhhdmUgbm90IHRlc3Rl
ZCBpdCB0aG91Z2guCj4gCj4+IC0gImFybS1zbW11LXYzOiBSZW1vdmUgZHVwbGljYXRpb24gb2Yg
ZmF1bHQgcHJvcGFnYXRpb24iLiBJIHVuZGVyc3RhbmQKPj4gdGhlIHRyYW5zY29kZSBpcyBkb25l
IHNvbWV3aGVyZSBlbHNlIHdpdGggU1ZBIGJ1dCB3ZSBzdGlsbCBuZWVkIHRvIGRvIGl0Cj4+IGlm
IGEgc2luZ2xlIENEIGlzIHVzZWQsIHJpZ2h0PyBJIHdpbGwgcmV2aWV3IHRoZSBTVkEgY29kZSB0
byBiZXR0ZXIKPj4gdW5kZXJzdGFuZC4KClNpbmNlIEkgaGF2ZSByZWJhc2Ugb24gNS4xMC1yYzQg
eW91IHdpbGwgc3RpbGwgaGF2ZSB0aGlzIGR1cGxpY2F0aW9uIHRvCmhhbmRsZS4KPiAKPiBIbW0u
Lm5vdCBzdXJlLiBOZWVkIHRvIHRha2UgYW5vdGhlciBsb29rIHRvIHNlZSB3aGV0aGVyIHdlIG5l
ZWQgYSBzcGVjaWFsCj4gaGFuZGxpbmcgZm9yIHNpbmdsZSBDRCBvciBub3QuCj4gCj4+IC0gZm9y
IHRoZSBTVEFMTCByZXNwb25zZSBpbmplY3Rpb24gSSB3b3VsZCB0ZW5kIHRvIHVzZSBhIG5ldyBW
RklPIHJlZ2lvbgo+PiBmb3IgcmVzcG9uc2VzLiBBdCB0aGUgbW9tZW50IHRoZXJlIGlzIGEgc2lu
Z2xlIFZGSU8gcmVnaW9uIGZvciByZXBvcnRpbmcKPj4gdGhlIGZhdWx0LgoKaW4gdjEyIEkgYWRk
ZWQgYSBuZXcgVkZJTyByZWdpb24gdG8gaW5qZWN0IHlvdXIgZmF1bHQuIFRoaXMgd2FzIHRlc3Rl
ZAp3aXRoIGR1bW15IGV2ZW50IGluamVjdGlvbiwgdGhpcyBzaG91bGQgd29yayBwcm9wZXJseS4K
CklmIHdlIGNsZWFybHkgaWRlbnRpZnkgYWxsIHRoZSBwdWJsaWMgZGVwZW5kZW5jaWVzIG5lZWRl
ZCBmb3IgdlNWQS9BUk0gSQpjYW4gaGVscCB5b3UgcmVzcGlubmluZyBvbiB0b3Agb2YgdGhlbQoK
VGhhbmtzCgpFcmljCj4gCj4gU3VyZS4gVGhhdCB3aWxsIGJlIG11Y2ggY2xlYW5lciBhbmQgcHJv
YmFibHkgaW1wcm92ZSB0aGUgY29udGV4dCBzd2l0Y2gKPiBsYXRlbmN5LiBBbm90aGVyIHRoaW5n
IEkgbm90ZWQgd2l0aCBTVEFMTCBpcyB0aGF0IHBhc2lkX3ZhbGlkIGZsYWcgbmVlZHMgdG8gYmUK
PiB0YWtlbiBjYXJlIGluIHRoZSBTVkEga2VybmVsIHBhdGguIAo+IAo+ICJpb21tdTogUmVtb3Zl
IHBhc2lkIHZhbGlkaXR5IGNoZWNrIGZvciBTVEFMTCBtb2RlbCBwYWdlIHJlc3BvbnNlIG1zZyIK
PiBOb3Qgc3VyZSB0aGlzIG9uZSBpcyBhIHByb3BlciB3YXkgdG8gaGFuZGxlIHRoaXMuCj4gIAo+
PiBPbiBRRU1VIHNpZGU6Cj4+IC0gSSBhbSBjdXJyZW50bHkgd29ya2luZyBvbiAzLjIgcmFuZ2Ug
aW52YWxpZGF0aW9uIHN1cHBvcnQgd2hpY2ggaXMKPj4gbmVlZGVkIGZvciBEUERLL1ZGSU8KPj4g
LSBXaGlsZSBhdCBpdCBJIHdpbGwgbG9vayBhdCBob3cgdG8gaW5jcmVtZW50YWxseSBpbnRyb2R1
Y2Ugc29tZSBvZiB0aGUKPj4gZmVhdHVyZXMgeW91IG5lZWQgaW4gdGhpcyBzZXJpZXMuCj4gCj4g
T2suIAo+IAo+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBhdCB0aGUgUE9DLgo+IAo+IENoZWVy
cywKPiBTaGFtZWVyCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
