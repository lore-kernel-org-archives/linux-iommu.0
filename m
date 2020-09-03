Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A5C2BD11
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:26:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46255206C0
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="jTX0D2LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46255206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3AADA86AB3;
	Thu,  3 Sep 2020 20:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6-WoibvB--I; Thu,  3 Sep 2020 20:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3344F86A99;
	Thu,  3 Sep 2020 20:26:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DA2DC07FF;
	Thu,  3 Sep 2020 20:26:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A493CC0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 82BBC2E137
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xx6KCiLSMKEo for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:26:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 35EF22E132
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:26:16 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id f142so4312851qke.13
 for <iommu@lists.linux-foundation.org>; Thu, 03 Sep 2020 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p/4sQnk4LDU0vEMICLGI8YxUkH7zUmXMxzaLJO9DsUE=;
 b=jTX0D2LBXHRBcuOwqcAasj+KSaNnjkEJZm90jn7kGvrXT3thDR4BsuVPXCXWJc1r4G
 MUfQz2Ireo5Y1SuHNlQlI37x1cgni4bnoLOGNOoWk4NfSVg7IWcNZDTCqe2n/1wdzU6u
 VeLOEFERqXzxA4RnAisGksUbyVhSTtHWglogE7iZCkf90ngqBejKI/QWQ020B913aGtY
 z2QN1ettqEOH/CAzUC5gkBRWwWY0Qmwme1pZxqn64bieqHtrfD2tjVlbKdUL/expWyym
 QXGa6ojP5o2pP/m3EM1i+OH7JhYbrQKEdsbm/e6/Nh8UclFQgRjVTCkP+sDPY2DKRiJa
 AY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p/4sQnk4LDU0vEMICLGI8YxUkH7zUmXMxzaLJO9DsUE=;
 b=tfILBhwwmHdE28fYJwlDE24FYAaym42WZPOOKCJ3EFGasVOCzf78IN6ImpQnXbb3Tx
 oUzW0lEFgaujLv9SHHlUFrSEE1WtQgF0wFpIgscpthENxtQuP7lWOI3CDjVRl2OhFQAm
 LNyuOPes6FWvPhaHgbiSWx2A2AaVb1PjWUo/OjuEOjM1Hf1NoEosjhjD3L4QCou1/w+Y
 3+oOHqU2/9plUStM+JEZgLoFxJqSmz13a3D2TlM3qGwgNw7d1ASd1/oxlgzk50iiBdcN
 48K4IVEo1r0gqyIWPebjo+3bGu6Ec9hWDgg/YRwlhc45JJmW5t+9J71F9JbB7KuicMqj
 sKwA==
X-Gm-Message-State: AOAM532x7xgytzlWz3ffLQaBEj7QY+lv3neL3Bbvm4y9ywehlDsywyip
 g98P1W/hQLjzTLSVOmugby2kudlaEQi+3Q==
X-Google-Smtp-Source: ABdhPJza5VhQenwItzg0Zm+cN6BPSuCX6Nay7DN36KO2xgXqJ4aPd8+o5/LZkXB4gPTqBOocgl5YTg==
X-Received: by 2002:ac8:178d:: with SMTP id o13mr1281828qtj.103.1599164372346; 
 Thu, 03 Sep 2020 13:19:32 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home
 (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
 by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:19:31 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2 0/5] Convert the intel iommu driver to the dma-iommu api
Date: Thu,  3 Sep 2020 21:18:32 +0100
Message-Id: <20200903201839.7327-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

VGhpcyBwYXRjaHNldCBjb252ZXJ0cyB0aGUgaW50ZWwgaW9tbXUgZHJpdmVyIHRvIHRoZSBkbWEt
aW9tbXUgYXBpLgoKV2hpbGUgY29udmVydGluZyB0aGUgZHJpdmVyIEkgZXhwb3NlZCBhIGJ1ZyBp
biB0aGUgaW50ZWwgaTkxNSBkcml2ZXIgd2hpY2ggY2F1c2VzIGEgaHVnZSBhbW91bnQgb2YgYXJ0
aWZhY3RzIG9uIHRoZSBzY3JlZW4gb2YgbXkgbGFwdG9wLiBZb3UgY2FuIHNlZSBhIHBpY3R1cmUg
b2YgaXQgaGVyZToKaHR0cHM6Ly9naXRodWIuY29tL3BpcHB5MzYwL2tlcm5lbFBhdGNoZXMvYmxv
Yi9tYXN0ZXIvSU1HXzIwMTkxMjE5XzIyNTkyMi5qcGcKClRoaXMgaXNzdWUgaXMgaW4gdGhlIGk5
MTUgZHJpdmVyIGFuZCBpcyBjYXVzZWQgYnkgdGhlIGRyaXZlciBub3QgcmVzcGVjdGluZyB0aGUg
cmV0dXJuIHZhbHVlIG9mIHRoZSBkbWFfbWFwX29wczo6bWFwX3NnIGZ1bmN0aW9uLgoKV2UgdGFs
a2VkIGFib3V0IHRoaXMgaW4gdGhpcyBtaWNyb2NvbmZlcmVuY2U6Cmh0dHBzOi8vbGludXhwbHVt
YmVyc2NvbmYub3JnL2V2ZW50LzcvY29udHJpYnV0aW9ucy84NDYvCmFuZCBjYW1lIHRvIHRoZSBj
b25jbHVzaW9uIHRoYXQgd2Ugc2hvdWxkIGFkZCBhbiBhdHRyaWJ1dGUgdG8gZGlzYWJsZSBjb21i
aW5pbmcgc2cgc2VnbWVudHMgaW4gdGhlIGRtYS1pb21tdSBhcGkgKGluIHRoZSBfX2ZpbmFsaXNl
X3NnIGZ1bmN0aW9uKS4gVGhpcyB3aWxsIHdvcmsgYXMgYSB0ZW1wb3JhcnkgZml4IGFuZCBhbGxv
dyB1cyB0byBjb252ZXJ0IHRoZSBpbnRlbCBpb21tdSBkcml2ZXIgdG8gdGhlIGRtYS1pb21tdSBw
YXRoIHdoaWxlIHdlIHdhaXQgZm9yIHRoZSBpOTE1IGRyaXZlciB0byBiZSByZXdyaXR0ZW4gdG8g
cmVzcGVjdCB0aGUgcmV0dXJuIHZhbHVlIG9mIG1hcF9zZy4gSSBoYXZlbid0IGRvbmUgdGhpcyB3
b3JrIHlldCBhbmQgd29uJ3QgaGF2ZSB0aW1lIHRvIGRvIGl0LiBJZiBzb21lb25lIGVsc2UgY291
bGQgdGFrZSB0aGlzIG9uIHRoYXQgd291bGQgYmUgZ3JlYXQuCgpUbyBhbGxvdyBteSBwYXRjaCBz
ZXQgdG8gYmUgdGVzdGVkIEkgaGF2ZSBhZGRlZCBhIHBhdGNoICh0aGUgIkRPIE5PVCBNRVJHRS4u
LiIgcGF0Y2gpIGluIHRoaXMgc2VyaWVzIHRvIGRpc2FibGUgY29tYmluaW5nIHNnIHNlZ21lbnRz
IGluIHRoZSBkbWEtaW9tbXUgYXBpIHdoaWNoIGZpeGVzIHRoZSBidWcgYnV0IGl0IGRvZXNuJ3Qg
Zml4IHRoZSBhY3R1YWwgcHJvYmxlbS4KCkFzIHBhcnQgb2YgdGhpcyBwYXRjaCBzZXJpZXMgSSBj
b3BpZWQgdGhlIGludGVsIGJvdW5jZSBidWZmZXIgY29kZSB0byB0aGUgZG1hLWlvbW11IHBhdGgu
IFRoZSBhZGRpdGlvbiBvZiB0aGUgYm91bmNlIGJ1ZmZlciBjb2RlIHRvb2sgbWUgYnkgc3VycHJp
c2UuIEkgZGlkIG1vc3Qgb2YgbXkgZGV2ZWxvcG1lbnQgb24gdGhpcyBwYXRjaCBzZXJpZXMgYmVm
b3JlIHRoZSBib3VuY2UgYnVmZmVyIGNvZGUgd2FzIGFkZGVkIGFuZCBteSByZWltcGxlbWVudGF0
aW9uIGluIHRoZSBkbWEtaW9tbXUgcGF0aCBpcyB2ZXJ5IHJ1c2hlZCBhbmQgbm90IHByb3Blcmx5
IHRlc3RlZCBidXQgSeKAmW0gcnVubmluZyBvdXQgb2YgdGltZSB0byB3b3JrIG9uIHRoaXMgcGF0
Y2ggc2V0LgoKT24gdG9wIG9mIHRoYXQgSSBhbHNvIGRpZG7igJl0IHBvcnQgb3ZlciB0aGUgaW50
ZWwgdHJhY2luZyBjb2RlIGZyb20gdGhpcyBjb21taXQ6Cmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9jb21taXQvM2I1MzAzNGMyNjhkNTUwZDllODUyMmU2MTNhMTRhYjUzYjg4NDBk
OCNkaWZmLTZiM2U3YzQ5OTNmMDVlNzYzMzFlNDYzYWIxZmM4N2UxClNvIGFsbCB0aGUgd29yayBp
biB0aGF0IGNvbW1pdCBpcyBub3cgd2FzdGVkLiBUaGUgY29kZSB3aWxsIG5lZWQgdG8gYmUgcmVt
b3ZlZCBhbmQgcmVpbXBsZW1lbnRlZCBpbiB0aGUgZG1hLWlvbW11IHBhdGguIEkgd291bGQgbGlr
ZSB0byB0YWtlIHRoZSB0aW1lIHRvIGRvIHRoaXMgYnV0IEkgcmVhbGx5IGRvbuKAmXQgaGF2ZSB0
aGUgdGltZSBhdCB0aGUgbW9tZW50IGFuZCBJIHdhbnQgdG8gZ2V0IHRoZXNlIGNoYW5nZXMgb3V0
IGJlZm9yZSB0aGUgaW9tbXUgY29kZSBjaGFuZ2VzIGFueSBtb3JlLgoKVW5mb3J0dW5hdGVseSBJ
IG5vIGxvbmdlciBoYXZlIGVub3VnaCBzcGFyZSB0aW1lIHRvIGNvbnRpbnVlIHRvIHdvcmsgb24v
cmViYXNlIHRoaXMgcGF0Y2ggc2VyaWVzLiBTbyB0aGlzIHdpbGwgbW9zdCBsaWtlbHkgYmUgdGhl
IGxhc3QgcGF0Y2ggc2VyaWVzIGZyb20gbWUgZm9yIHRoZSBpbnRlbCBkbWEtaW9tbXUgY29udmVy
c2lvbi4KCkNoYW5nZS1sb2c6CnYyOgotUmViYXNlIG9uIHRvcCBvZiB0aGUgbGF0ZXN0IHN0YWdp
bmcgYnJhbmNoCi1tb3ZlIHRoZSBmcmVlbGlzdCBwYXJhbWV0ZXIgdG8gaW9tbXVfaW90bGJfZ2F0
aGVyCgpTaWduZWQtb2ZmLWJ5OiBUb20gTXVycGh5IDxtdXJwaHl0N0B0Y2QuaWU+CgpUb20gTXVy
cGh5ICg1KToKICBpb21tdTogSGFuZGxlIGZyZWVsaXN0cyB3aGVuIHVzaW5nIGRlZmVycmVkIGZs
dXNoaW5nIGluIGlvbW11IGRyaXZlcnMKICBpb21tdTogQWRkIGlvbW11X2RtYV9mcmVlX2NwdV9j
YWNoZWRfaW92YXMgZnVuY3Rpb24KICBpb21tdTogYWxsb3cgdGhlIGRtYS1pb21tdSBhcGkgdG8g
dXNlIGJvdW5jZSBidWZmZXJzCiAgaW9tbXUvdnQtZDogQ29udmVydCBpbnRlbCBpb21tdSBkcml2
ZXIgdG8gdGhlIGlvbW11IG9wcwogIERPIE5PVCBNRVJHRTogaW9tbXU6IGRpc2FibGUgbGlzdCBh
cHBlbmRpbmcgaW4gZG1hLWlvbW11CgogZHJpdmVycy9pb21tdS9LY29uZmlnICAgICAgIHwgICAx
ICsKIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgICB8IDE2OSArKysrKy0tLQogZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jIHwgODA1ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQogZHJpdmVycy9pb21tdS9pb21tdS5jICAgICAgIHwgIDEwICsKIGluY2x1ZGUvbGludXgv
ZG1hLWlvbW11LmggICB8ICAgMyArCiBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgICAgfCAgIDgg
KwogNiBmaWxlcyBjaGFuZ2VkLCAyMjIgaW5zZXJ0aW9ucygrKSwgNzc0IGRlbGV0aW9ucygtKQoK
LS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
