Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCC2C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 11:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C76E683118;
	Wed, 11 May 2022 11:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZ8vB00EeE19; Wed, 11 May 2022 11:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 99FC6832C9;
	Wed, 11 May 2022 11:09:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D11CC0032;
	Wed, 11 May 2022 11:09:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FA10C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 11:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E77E40201
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 11:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkteEdilD1EJ for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 11:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5F7D401B3
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 11:09:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dmitry.osipenko) with ESMTPSA id A7E7B1F44DCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652267343;
 bh=F9aAPWfKvLN/c3HoUZUVVOQ9jz//gwR/ofGKu2nHses=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W12X3oJhsrpQE2DhSrbaWvWpfAdag8EHWZTe0B4BjVG5fVofba5zM6AwqURgE2xit
 G9sJQhKpL5Lyo4YWhOxwOG8SRrENRfkKeEihosn8zGLLwzAInYCBTg24pri6K5Wkzm
 ROAc6s6qMvVe35i0rWFGctTEGVUhwszS5KdKNRtZWe7E9AaDTDa/gaiIbsp2T604vi
 lQtYbkGWo0zS/4XtbXV/VbB7Ud2LSjWRexmYPIToQz+WYbzOkE/vFnAUFWc0AHLsUW
 NAPHxYUaNdksd30zWcFIl6/+Xto1CdT5o8GmtPsk9k2BN0C2KpYvYXG1TSVRc+KZj6
 n8r2YQnQOZf1w==
Message-ID: <a0c7e954-ee3f-74fd-cfea-9b6dbce924dc@collabora.com>
Date: Wed, 11 May 2022 14:08:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/tegra: Stop using iommu_present()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com
References: <1f7c304a79b8b8dd5d4716786cae7502a0cc31f5.1649684782.git.robin.murphy@arm.com>
 <add31812-50d5-6cb0-3908-143c523abd37@collabora.com>
 <63c021c4-57de-38fe-e48f-a308088d235b@arm.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <63c021c4-57de-38fe-e48f-a308088d235b@arm.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com
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

T24gNS80LzIyIDE0OjUyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNS0wNCAwMTo1
MiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBPbiA0LzExLzIyIDE2OjQ2LCBSb2JpbiBNdXJw
aHkgd3JvdGU6Cj4+PiBAQCAtMTA5Miw2ICsxMDkyLDE5IEBAIHN0YXRpYyBib29sIGhvc3QxeF9k
cm1fd2FudHNfaW9tbXUoc3RydWN0Cj4+PiBob3N0MXhfZGV2aWNlICpkZXYpCj4+PiDCoMKgwqDC
oMKgIHN0cnVjdCBob3N0MXggKmhvc3QxeCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYtPmRldi5wYXJl
bnQpOwo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW47Cj4+PiDCoCAr
wqDCoMKgIC8qIEZvciBzdGFydGVycywgdGhpcyBpcyBtb290IGlmIG5vIElPTU1VIGlzIGF2YWls
YWJsZSAqLwo+Pj4gK8KgwqDCoCBpZiAoIWRldmljZV9pb21tdV9tYXBwZWQoJmRldi0+ZGV2KSkK
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+Cj4+IFVuZm9ydHVuYXRlbHkgdGhp
cyByZXR1cm5zIGZhbHNlIG9uIFQzMCB3aXRoIGVuYWJsZWQgSU9NTVUgYmVjYXVzZSB3ZQo+PiBk
b24ndCB1c2UgSU9NTVUgZm9yIEhvc3QxeCBvbiBUMzAgWzFdIHRvIG9wdGltaXplIHBlcmZvcm1h
bmNlLiBXZSBjYW4ndAo+PiBjaGFuZ2UgaXQgdW50aWwgd2Ugd2lsbCB1cGRhdGUgZHJpdmVycyB0
byBzdXBwb3J0IEhvc3QxeC1kZWRpY2F0ZWQKPj4gYnVmZmVycy4KPiAKPiBIdWgsIHNvIGlzIGRl
di0+ZGV2IGhlcmUgbm90IHRoZSBEUk0gZGV2aWNlPyBJZiBpdCBpcywgYW5kCj4gZGV2aWNlX2lv
bW11X21hcHBlZCgpIHJldHVybnMgZmFsc2UsIHRoZW4gdGhlIGxhdGVyIGlvbW11X2F0dGFjaF9n
cm91cCgpCj4gY2FsbCBpcyBnb2luZyB0byBmYWlsIGFueXdheSwgc28gdGhlcmUncyBub3QgbXVj
aCBwb2ludCBhbGxvY2F0aW5nIGEKPiBkb21haW4uIElmIGl0J3Mgbm90LCB0aGVuIHdoYXQgdGhl
IGhlY2sgaXMgaG9zdDF4X2RybV93YW50c19pb21tdSgpCj4gYWN0dWFsbHkgdGVzdGluZyBmb3I/
CgpUaGUgZGV2LT5kZXYgaXMgdGhlIGhvc3QxeCBkZXZpY2UgYW5kIGl0J3MgdGhlIERSTSBkZXZp
Y2UuCgpUaGUgaW9tbXVfYXR0YWNoX2dyb3VwKCkgaXMgY2FsbGVkIGZvciB0aGUgRFJNIHN1Yi1k
ZXZpY2VzIChjbGllbnRzIGluCnRoZSBUZWdyYSBkcml2ZXIpLCB3aGljaCBhcmUgdGhlIGRldmlj
ZXMgc2l0dGluZyBvbiB0aGUgaG9zdDF4IGJ1cy4KClRoZXJlIGlzIG5vIHNpbmdsZSBHUFUgZGV2
aWNlIG9uIFRlZ3JhLCBpbnN0ZWFkIGl0J3MgY29tcG9zZWQgb2YKaW5kZXBlbmRlbnQgR1BVIGVu
Z2luZXMgYW5kIGRpc3BsYXkgY29udHJvbGxlcnMgdGhhdCBhcmUgY29ubmVjdGVkIHRvCnRoZSBo
b3N0MXggYnVzLgoKSG9zdDF4IGFsc28gaGFzIGNoYW5uZWwgRE1BIGVuZ2luZXMgdGhhdCBhcmUg
dXNlZCBieSBEUk0gZHJpdmVyLiBXZQpkb24ndCBoYXZlIGRlZGljYXRlZCBkZXZpY2VzIGZvciB0
aGUgaG9zdDF4IERNQSwgdGhlcmUgaXMgc2luZ2xlIGhvc3QxeApkcml2ZXIgdGhhdCBtYW5hZ2Vz
IGhvc3QxeCBidXMgYW5kIERNQS4KCi0tIApCZXN0IHJlZ2FyZHMsCkRtaXRyeQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
