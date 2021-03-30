Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D93C433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 09:25:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878896198F
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 09:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878896198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 307846062A;
	Tue, 30 Mar 2021 09:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dQ3euEE5wEA; Tue, 30 Mar 2021 09:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 200D8605D9;
	Tue, 30 Mar 2021 09:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02841C000C;
	Tue, 30 Mar 2021 09:25:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C851C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08A53402AC
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cf5Elc59FrVu for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 09:25:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73EF14013A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 09:25:29 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C02B61874;
 Tue, 30 Mar 2021 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617096329;
 bh=pFRMil+ubXqsoigpwqV+Iqv6W6fxomkJa57PKQzBACk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FDMA/Ka8EJhkG+u+AUjdZb6S1q3XTKN5z6hGaLBl0J0m3PwpCq8euanmupb0dnKgN
 LHRle8oi1tsWvVqpGlxXqqM8DDjjTNbXUMKmcFC4GRV2738nm4twZE8zfuNDaz8mmw
 A5b/vG1pW1QoOtX3o8wN133sfzn4YGqxcqQtUFnwu0FrYtPC53ulABUymE/j4k8Mjn
 wx3b01d3MqR4fYDhL6T9MQUGUiUGUgJGAj18xayVmRrIvH4Kn5khZ/bc9mZlYnXWqm
 dSbc5iE/sppdGh8N2GtFUEJhvSe+d5QDTmxMLUxyvEPuF/aH5WSBjbHfc/9DvH0C2T
 +msRocxTNuuYg==
Date: Tue, 30 Mar 2021 10:25:24 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Add a check to avoid invalid iotlb sync
Message-ID: <20210330092523.GA5050@willie-the-truck>
References: <1616826190-77035-1-git-send-email-chenxiang66@hisilicon.com>
 <20210329144554.GA4203@willie-the-truck>
 <2b0b7a7d-7162-bef9-9730-cbe3767d14f9@hisilicon.com>
 <f4c1cc18-6b5a-575b-92ee-fc4357d72d17@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4c1cc18-6b5a-575b-92ee-fc4357d72d17@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org
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

T24gVHVlLCBNYXIgMzAsIDIwMjEgYXQgMTA6MDQ6NTNBTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IE9uIDIwMjEtMDMtMzAgMDI6MjIsIGNoZW54aWFuZyAoTSkgd3JvdGU6Cj4gPiBIaSBX
aWxsLAo+ID4gCj4gPiAKPiA+IOWcqCAyMDIxLzMvMjkgMjI6NDUsIFdpbGwgRGVhY29uIOWGmemB
kzoKPiA+ID4gT24gU2F0LCBNYXIgMjcsIDIwMjEgYXQgMDI6MjM6MTBQTSArMDgwMCwgY2hlbnhp
YW5nIHdyb3RlOgo+ID4gPiA+IEZyb206IFhpYW5nIENoZW4gPGNoZW54aWFuZzY2QGhpc2lsaWNv
bi5jb20+Cj4gPiA+ID4gCj4gPiA+ID4gQ3VycmVudGx5IGl0IHdpbGwgc2VuZCBhIGlvdGxiIHN5
bmMgYXQgZW5kIG9mIGlvbW11IHVubWFwIGV2ZW4gaWYKPiA+ID4gPiBpb3RsYl9nYXRoZXIgaXMg
bm90IHZhbGlkIChpb3RsYl9nYXRoZXItPnBnc2l6ZSA9IDApLiBBY3R1YWxseSBpdCBpcyBub3QK
PiA+ID4gPiBuZWNlc3NhcnksIHNvIGFkZCBhIGNoZWNrIHRvIGF2b2lkIGludmFsaWQgaW90bGIg
c3luYy4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZyBDaGVuIDxjaGVueGlh
bmc2NkBoaXNpbGljb24uY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+IMKgIGluY2x1ZGUvbGludXgv
aW9tbXUuaCB8IDMgKysrCj4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQo+ID4gPiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9p
bmNsdWRlL2xpbnV4L2lvbW11LmgKPiA+ID4gPiBpbmRleCA5Y2E2ZTZiLi42YWZhNjFiIDEwMDY0
NAo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+ID4gPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvaW9tbXUuaAo+ID4gPiA+IEBAIC01MjksNiArNTI5LDkgQEAgc3RhdGljIGlubGlu
ZSB2b2lkCj4gPiA+ID4gaW9tbXVfZmx1c2hfaW90bGJfYWxsKHN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbikKPiA+ID4gPiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfaW90bGJfc3luYyhz
dHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqaW90bGJfZ2F0aGVy
KQo+ID4gPiA+IMKgIHsKPiA+ID4gPiArwqDCoMKgIGlmICghaW90bGJfZ2F0aGVyLT5wZ3NpemUp
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+ID4gSW4gd2hpY2ggY2lyY3Vtc3Rh
bmNlcyBkb2VzIHRoaXMgb2NjdXI/Cj4gPiA+IAo+ID4gPiBXaWxsCj4gPiAKPiA+IFdoZW4gaW9t
bXVfdW5tYXAsIGl0IGluaXRpYWxpemVzIGlvdGxiX2dhdGhlciAodGhlbiBpb3RsYl9nYXRoZXIt
PnBnc2l6ZQo+ID4gPSAwKS4KPiA+IElmIHRoZSB1bm1hcCBzaXplID0gQVJNX0xQQUVfQkxPQ0tf
U0laRShsdmwpICYmIGlvcHRlX2xlYWYoKSwgaXQgd2lsbAo+ID4gZmlsbCB0aGUgaW90bGJfZ2F0
aGVyIChzZXQgaW90bGJfZ2F0aGVyLT5wZ3NpemUgPSBncmFudWxlKTsKPiA+IGJ1dCBpZiB0aGUg
dW5tYXAgc2l6ZSA9IEFSTV9MUEFFX0JMT0NLX1NJWkUobHZsKSAmJiAhaW9wdGVfbGVhZigpICh0
bGIKPiA+IGZsdXNoIHdhbGsgc2l0dWF0aW9uKSwgaW90bGJfZ2F0aGVyIGlzIG5vdCBmaWxsZWQg
KGlvdGxiX2dhdGhlci0+cGdzaXplCj4gPiA9IDApLAo+ID4gaXQgd2lsbCBzdGlsbCBzZW5kIGlv
bW11X2lvdGxiX3N5bmMoZG9tYWluLCAmaW90bGJfZ2F0aGVyKSB3aGljaCBpcwo+ID4gYWN0dWFs
bHkgaW52YWxpZCBpb3RsYiBzeW5jIGF0IGxhc3QuCj4gCj4gSSBndWVzcyB0aGlzIGNhbiBoYXBw
ZW4gaW4gRE1BIEFQSSB1c2FnZSBpZiB3ZSd2ZSBwcmV2aW91c2x5IG1hcHBlZCBhCj4gYmxvY2sn
cyB3b3J0aCBvZiBzY2F0dGVybGlzdCBwYWdlcyBpbnRvIGEgYmxvY2stPXNpemVkIElPVkEgcmVn
aW9uLCBidXQgdGhpcwo+IGlzIG5vdCB0aGUgcGxhY2UgdG8gZG8gYW55dGhpbmcgYWJvdXQgaXQu
IFRoZSBtYWluIHRoaW5nIHRoaXMgcGF0Y2ggd2lsbCBkbwo+IGlzIGJyZWFrIGFsbCB0aGUgb3Ro
ZXIgZHJpdmVycyB0aGF0IGltcGxlbWVudCAuaW90bGJfc3luYyBidXQgZG8gbm90IHVzZQo+IGlv
dGxiX2dhdGhlci4KPiAKPiBCeSBhbGwgbWVhbnMgb3B0aW1pc2UgU01NVXYzJ3Mgc3luYyBiZWhh
dmlvdXIsIGJ1dCB0aGUgb25seSB2YWxpZCBwbGFjZSB0bwo+IGRvIHRoYXQgaXMgaW4gU01NVXYz
J3Mgb3duIHN5bmMgY2FsbGJhY2suIFRoZXNlIHBhcnRpY3VsYXIgZGV0YWlscyBhcmUKPiBiZXlv
bmQgd2hhdCB0aGUgSU9NTVUgY29yZSBrbm93cyBhYm91dC4KClllcywgdGhhdCdzIHdoZXJlIEkg
d2FzIGhlYWRpbmcuIENoZW54aWFuZywgcGxlYXNlIGNvdWxkIHlvdSBzZW5kIGEgdjIKd2l0aCB0
aGUgY2hlY2sgaW5zaWRlIGFybV9zbW11X2lvdGxiX3N5bmMoKSBpbnN0ZWFkPwoKVGhhbmtzLAoK
V2lsbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
