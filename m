Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35571C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 06:01:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0EC20652
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SLm+tsby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0EC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A82E08794F;
	Tue, 10 Dec 2019 06:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jPR1B3TU9qlV; Tue, 10 Dec 2019 06:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2FE40878A8;
	Tue, 10 Dec 2019 06:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 198A0C1D7D;
	Tue, 10 Dec 2019 06:01:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABC8C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 06:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 136D385CB8
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 06:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8u9xfmut9om for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 06:01:53 +0000 (UTC)
X-Greylist: delayed 00:07:49 by SQLgrey-1.7.6
Received: from qq.com (smtpbg417.qq.com [183.3.226.222])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DAA8C85B12
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 06:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1575957178;
 bh=mGhAhm0kPrPwf7p5pVcAfN/hYwtbIoEqSzwI2gGXHbQ=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=SLm+tsbybe0+IQHxB0tQUNT4eA/asgiBx65wVnjhEl1px+D5ZxqOWzFaErSwdp/T4
 3LUimx7jvvw8b+DtoMVyt0ZRsFs+G0fDCerghaaWhoFN1Hhc9uicMANa5twONDrLhK
 xqScRebnYXTO8HJceILQh1M1GuiQztIDgh+TdaOE=
X-QQ-mid: esmtp5t1575957173t3inkduqo
Received: from [192.168.1.6] (unknown [36.5.192.233])
 by esmtp4.qq.com (ESMTP) with 
 id ; Tue, 10 Dec 2019 13:52:50 +0800 (CST)
X-QQ-SSF: 00000000000000L0ZI100000000000K
X-QQ-FEAT: LS2tEetiLaM2Bmy5aIyHqIBkjMfwW5O3ZnJ2d/XXNPZv6FgFvJ1deIJCtYOcg
 Hfjt8fyYo11d7TaL96UHngjJIj9iBjPou8mi3qvRDl/7j0vt00fkp7yHr9+7/ZyUrNtzztY
 Q6phTzNzhU15dkmH3Ac21WYMj0empT3LF0mcFZ7J9purT9ApbqFux3CJPyzXi2WfJgq1jMp
 fSLk6DPi0nYnIFtBaDi+7xUpDz/Cpfaez7WXMpshtc4GnP0dNDW9get4ZDqigc0AlHnkNgf
 ZvwlZBq65nxTU3rP/NHi+q/My/tFax9S3UQTQRWnOf8aPhDg4kQCE1YlU=
X-QQ-GoodBg: 0
Subject: Re: [PATCH v3 00/13] iommu: Add PASID support to Arm SMMUv3
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Message-ID: <56fb5aec-50ee-5bc0-dbd5-ff944080c62b@foxmail.com>+AA82B9158B64F7B8
Date: Tue, 10 Dec 2019 13:52:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

CgpPbiAyMDE5LzEyLzEwIOS4iuWNiDI6MDUsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToK
PiBBZGQgc3VwcG9ydCBmb3IgU3Vic3RyZWFtIElEIGFuZCBQQVNJRHMgdG8gdGhlIFNNTVV2MyBk
cml2ZXIuCj4gQ2hhbmdlcyBzaW5jZSB2MiBbMV06Cj4KPiAqIFNwbGl0IHByZXBhcmF0b3J5IHdv
cmsgaW50byBwYXRjaGVzIDUsIDYsIDggYW5kIDkuCj4KPiAqIEFkZGVkIHBhdGNoIDEuIE5vdCBz
dHJpY3RseSByZWxldmFudCwgYnV0IHNpbmNlIHdlJ3JlIG1vdmluZyB0aGUgRE1BCj4gICAgYWxs
b2NhdGlvbnMgYW5kIGFkZGluZyBhIG5ldyBvbmUsIHdlIG1pZ2h0IGFzIHdlbGwgY2xlYW4gdGhl
IGZsYWdzCj4gICAgZmlyc3QuCj4KPiAqIEZpeGVkIGEgZG91YmxlIGZyZWUgcmVwb3J0ZWQgYnkg
Sm9uYXRoYW4sIGFuZCBvdGhlciBzbWFsbAo+ICAgIGlzc3Vlcy4KPgo+ICogQWRkZWQgcGF0Y2gg
MTIuIFVwc3RyZWFtIGNvbW1pdCBjNmU5YWVmYmY5ZGIgKCJQQ0kvQVRTOiBSZW1vdmUgdW51c2Vk
Cj4gICAgUFJJIGFuZCBQQVNJRCBzdHVicyIpIHJlbW92ZWQgdGhlIHVudXNlZCBQQVNJRCBzdHVi
cy4gU2luY2UgdGhlIFNNTVUKPiAgICBkcml2ZXIgY2FuIGJlIGJ1aWx0IHdpdGhvdXQgUENJLCB0
aGUgc3R1YnMgYXJlIG5vdyBuZWVkZWQuCj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtaW9tbXUvMjAxOTExMDgxNTI1MDguNDAzOTE2OC0xLWplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZy8KPgo+IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciAoMTMpOgo+ICAgIGlvbW11L2FybS1zbW11
LXYzOiBEcm9wIF9fR0ZQX1pFUk8gZmxhZyBmcm9tIERNQSBhbGxvY2F0aW9uCj4gICAgZHQtYmlu
ZGluZ3M6IGRvY3VtZW50IFBBU0lEIHByb3BlcnR5IGZvciBJT01NVSBtYXN0ZXJzCj4gICAgaW9t
bXUvYXJtLXNtbXUtdjM6IFN1cHBvcnQgcGxhdGZvcm0gU1NJRAo+ICAgIEFDUEkvSU9SVDogU3Vw
cG9ydCBQQVNJRCBmb3IgcGxhdGZvcm0gZGV2aWNlcwo+ICAgIGlvbW11L2FybS1zbW11LXYzOiBQ
cmVwYXJlIGFybV9zbW11X3MxX2NmZyBmb3IgU1NJRCBzdXBwb3J0Cj4gICAgaW9tbXUvYXJtLXNt
bXUtdjM6IEFkZCBjb250ZXh0IGRlc2NyaXB0b3IgdGFibGVzIGFsbG9jYXRvcnMKPiAgICBpb21t
dS9hcm0tc21tdS12MzogQWRkIHN1cHBvcnQgZm9yIFN1YnN0cmVhbSBJRHMKPiAgICBpb21tdS9h
cm0tc21tdS12MzogUHJvcGF0ZSBzc2lkX2JpdHMKPiAgICBpb21tdS9hcm0tc21tdS12MzogSGFu
ZGxlIGZhaWx1cmUgb2YgYXJtX3NtbXVfd3JpdGVfY3R4X2Rlc2MoKQo+ICAgIGlvbW11L2FybS1z
bW11LXYzOiBBZGQgc2Vjb25kIGxldmVsIG9mIGNvbnRleHQgZGVzY3JpcHRvciB0YWJsZQo+ICAg
IGlvbW11L2FybS1zbW11LXYzOiBJbXByb3ZlIGFkZF9kZXZpY2UoKSBlcnJvciBoYW5kbGluZwo+
ICAgIFBDSS9BVFM6IEFkZCBQQVNJRCBzdHVicwo+ICAgIGlvbW11L2FybS1zbW11LXYzOiBBZGQg
c3VwcG9ydCBmb3IgUENJIFBBU0lECj4KClRoYW5rcyBKZWFuIGZvciBlbmFibGluZyB0aGUgc3Zh
IGZlYXR1cmUuCgpUaGUgc2VyaWVzIHRlc3RlZCB3ZWxsIG9uIEhpc2lsaWNvbiBwbGF0Zm9ybSBL
dW5QZW5nOTIwClRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9y
Zz4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
