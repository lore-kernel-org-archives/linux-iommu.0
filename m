Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D90C07E99
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 11:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A228613D1
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 11:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A228613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30BBE83760;
	Mon,  5 Jul 2021 11:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlBiqMWmfMqc; Mon,  5 Jul 2021 11:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 28C58836C3;
	Mon,  5 Jul 2021 11:40:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F30ADC0010;
	Mon,  5 Jul 2021 11:40:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF975C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 11:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE86D40478
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 11:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfCCDBgF0O8m for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 11:40:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B33A54048D
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 11:40:31 +0000 (UTC)
Received: from [IPv6:2a01:e0a:4cb:a870:e614:ab69:6d29:3012] (unknown
 [IPv6:2a01:e0a:4cb:a870:e614:ab69:6d29:3012])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: benjamin.gaignard)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C82701F42CA4;
 Mon,  5 Jul 2021 12:40:26 +0100 (BST)
Subject: Re: [PATCH v2] iommu: rockchip: Fix physical address decoding
To: will@kernel.org, robh+dt@kernel.org, heiko@sntech.de, xxm@rock-chips.com, 
 robin.murphy@arm.com, joro@8bytes.org, dan.carpenter@oracle.com
References: <20210618130047.547986-1-benjamin.gaignard@collabora.com>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <e2c3d5c2-3f45-90b9-1b55-54df133a952f@collabora.com>
Date: Mon, 5 Jul 2021 13:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618130047.547986-1-benjamin.gaignard@collabora.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

CkxlIDE4LzA2LzIwMjEgw6AgMTU6MDAsIEJlbmphbWluIEdhaWduYXJkIGEgw6ljcml0wqA6Cj4g
UmVzdG9yZSBiaXRzIDM5IHRvIDMyIGF0IGNvcnJlY3QgcG9zaXRpb24uCj4gSXQgcmV2ZXJzZXMg
dGhlIG9wZXJhdGlvbiBkb25lIGluIHJrX2RtYV9hZGRyX2R0ZV92MigpLgo+Cj4gRml4ZXM6IGM1
NTM1NmM1MzRhYSAoImlvbW11OiByb2NrY2hpcDogQWRkIHN1cHBvcnQgZm9yIGlvbW11IHYyIikK
Pgo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQGNv
bGxhYm9yYS5jb20+CgpHZW50bGUgcGluZyBvbiB0aGlzIHBhdGNoIDotKQoKUmVnYXJkcywKQmVu
amFtaW4KCj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11LmMgfCA2ICsrKyst
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11LmMgYi9kcml2ZXJzL2lv
bW11L3JvY2tjaGlwLWlvbW11LmMKPiBpbmRleCA5NGI5ZDhlNWI5YTQwLi45ZmViZmI3ZjMwMjVi
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYwo+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYwo+IEBAIC01NDQsMTIgKzU0NCwxNCBAQCBzdGF0
aWMgaW5saW5lIHUzMiBya19kbWFfYWRkcl9kdGUoZG1hX2FkZHJfdCBkdF9kbWEpCj4gICB9Cj4g
ICAKPiAgICNkZWZpbmUgRFRfSElfTUFTSyBHRU5NQVNLX1VMTCgzOSwgMzIpCj4gKyNkZWZpbmUg
RFRFX0JBU0VfSElfTUFTSyBHRU5NQVNLKDExLCA0KQo+ICAgI2RlZmluZSBEVF9TSElGVCAgIDI4
Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgcGh5c19hZGRyX3QgcmtfZHRlX2FkZHJfcGh5c192Mih1
MzIgYWRkcikKPiAgIHsKPiAtCXJldHVybiAocGh5c19hZGRyX3QpKGFkZHIgJiBSS19EVEVfUFRf
QUREUkVTU19NQVNLKSB8Cj4gLQkgICAgICAgKChhZGRyICYgRFRfSElfTUFTSykgPDwgRFRfU0hJ
RlQpOwo+ICsJdTY0IGFkZHI2NCA9IGFkZHI7Cj4gKwlyZXR1cm4gKHBoeXNfYWRkcl90KShhZGRy
NjQgJiBSS19EVEVfUFRfQUREUkVTU19NQVNLKSB8Cj4gKwkgICAgICAgKChhZGRyNjQgJiBEVEVf
QkFTRV9ISV9NQVNLKSA8PCBEVF9TSElGVCk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUg
dTMyIHJrX2RtYV9hZGRyX2R0ZV92MihkbWFfYWRkcl90IGR0X2RtYSkKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
