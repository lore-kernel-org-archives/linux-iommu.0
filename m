Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196F2DC76A
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750560; cv=none; b=uIFz8QX6B/jAPlY0RIUtejwRoInoQx8QpDBIkqulD63z8NzGM1OvfIWqZCMfJoIfEUTCCxg18/JvUVIylALJADDMlCCgcMo2Mffqjz5+Td/nZi9+Jj5Y0Hz+v4LXWeS7CaWQZmGF6DrHbIBG+2aGwVB7KcTOYm98hdAvQWJszfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750560; c=relaxed/simple;
	bh=1CyfhVRQxNK/yVMUenTp805vzmLDvR80K9a16wU38XI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=V91ZRQGZQmKw/WxJbqzoBn4p4Qr7azJTHYb6Dn7zseBN8NBMZyQueaZJ9xzZ0r18QpmkYxuCOH/8pa+jenlLAhviOTReRWkmvW0DPSqF40/P0ARGao3CcYiZNZH4cfJr5QNFW3VEbwxZTGwrjL0fEINNDqEbFNjlDNlbGHHpL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn; spf=pass smtp.mailfrom=ict.ac.cn; arc=none smtp.client-ip=159.226.251.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ict.ac.cn
Received: from chenglingfei22s$ict.ac.cn ( [58.206.203.86] ) by
 ajax-webmail-APP-09 (Coremail) ; Wed, 29 Oct 2025 23:03:29 +0800
 (GMT+08:00)
Date: Wed, 29 Oct 2025 23:03:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenglingfei <chenglingfei22s@ict.ac.cn>
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: "zhang bruce" <brucezhang5337@gmail.com>, joro@8bytes.org, 
	will@kernel.org, iommu@lists.linux.dev
Subject: Re: Re: Question about IOMMU and streaming DMA
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <ddb99a47-3869-4605-8404-807cdcb2d07e@arm.com>
References: <CAJZPk7T0K51zBKNNQXw2qx9OYrPa8BJ6jQTvOM-YrxwBndPbzQ@mail.gmail.com>
 <ddb99a47-3869-4605-8404-807cdcb2d07e@arm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <60384f06.45d09.19a307ed38d.Coremail.chenglingfei22s@ict.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:swCowAD3qEDBLAJpNjgBAA--.13757W
X-CM-SenderInfo: xfkh0wpolqwwthlsj2g6lf3hldfou0/1tbiDAgKDmkB2Wr4NQABsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoiUm9iaW4gTXVycGh5IiA8cm9iaW4ubXVycGh5QGFybS5jb20+IHdyb3Rl77yaCiZndDsgT24g
MjAyNS0xMC0yOCAxMjo0NSBwbSwgemhhbmcgYnJ1Y2Ugd3JvdGU6CiZndDsgJmd0OyBIZWxsbywK
Jmd0OyAmZ3Q7IAomZ3Q7ICZndDsgVGhlIGRyaXZlciBpbnZva2VzIHRoZSBkbWFfc3luY19zaW5n
bGVfZm9yX2NwdSBBUEkgdG8gYWNjZXNzIHRoZQomZ3Q7ICZndDsgY3VycmVudCBzdGF0ZSBvZiB0
aGUgZG1hX2J1ZmZlciBkYXRhLgomZ3Q7ICZndDsgSG93ZXZlciwgZG1hX3N5bmNfc3luY19zaW5n
bGVfZm9yX2NwdSBkb2VzIG5vdCB1bm1hcCB0aGUgSU9NTVUKJmd0OyAmZ3Q7IG1hcHBpbmcuIElu
IHRoaXMgY2FzZSwgd2hpbGUgdGhlCiZndDsgJmd0OyBkcml2ZXIgaXMgcmVhZGluZyB0aGUgZG1h
X2J1ZmZlciBkYXRhLCBjYW4gdGhlIGRldmljZSBzdGlsbCBtb2RpZnkgdGhlCiZndDsgJmd0OyBk
YXRhIGNvbmN1cnJlbnRseT8KJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgSWYgdGhlIElPTU1VIG1hcHBp
bmcgcmVtYWlucyB2YWxpZCwgaG93IGlzIHRoZSBvd25lcnNoaXAgb2YgdGhlIGJ1ZmZlcgomZ3Q7
ICZndDsgdHJhbnNmZXJyZWQgZnJvbSB0aGUgZGV2aWNlIHRvIHRoZSBDUFUgWzFdPwomZ3Q7IAom
Z3Q7IFRoZSBzYW1lIHdheSBpdCBpcyB3aGVuIHRoZXJlIGlzIG5vIElPTU1VIGF0IGFsbC4gQ29u
c2lkZXIgdGhhdCBhIAomZ3Q7IHN5bmNfZm9yX2RldmljZSBkb2Vzbid0IHVubWFwIHRoZSBDUFUn
cyB2aWV3KHMpIG9mIHRoZSBidWZmZXIgZWl0aGVyIC0gCiZndDsgdGhlICJvd25lcnNoaXAiIGhl
cmUgaXMgcHVyZWx5IGEgbG9naWNhbCBub3Rpb24gYmV0d2VlbiB0aGUgZGV2aWNlIAomZ3Q7IGRy
aXZlciBhbmQgdGhlIGhhcmR3YXJlIGl0IGNvbnRyb2xzLiBJdCdzIG5vdCB0aGUgSU9NTVUgbGF5
ZXIncyAKJmd0OyByZXNwb25zaWJpbGl0eSB0byB0cnkgdG8gcG9saWNlIHdoZXRoZXIgZHJpdmVy
cyBhcmUgbWFraW5nIHVzZSBvZiB0aGVpciAKJmd0OyBvd24gRE1BIGJ1ZmZlcnMgYXBwcm9wcmlh
dGVseTsgdGhlIElPTU1VJ3MgbWFpbiByb2xlIGlzIHRvIHByZXZlbnQgdGhlIAomZ3Q7IGRldmlj
ZSBmcm9tIGFjY2Vzc2luZyBhbnkgb3RoZXIgbWVtb3J5IHRoYXQgKmlzbid0KiBvbmUgb2YgaXRz
IAomZ3Q7IGN1cnJlbnRseS1tYXBwZWQgRE1BIGJ1ZmZlcnMuCiZndDsgCiZndDsgVGhhbmtzLAom
Z3Q7IFJvYmluLgomZ3Q7IAomZ3Q7ICZndDsgCiZndDsgJmd0OyBbMV1odHRwczovL2x3bi5uZXQv
QXJ0aWNsZXMvNzU3ODAvCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IEJlc3QgcmVnYXJkcyEKClNvLCBj
YW4gd2UgdW5kZXJzdGFuZCBpdCB0aGlzIHdheTogbWFpbnRhaW5pbmcgYW5kIHVzaW5nIHN0cmVh
bWluZyAKRE1BIHRvIGF2b2lkIHNlY3VyaXR5IGlzc3VlcyBsaWtlIGRvdWJsZSBmZXRjaCBhbmQg
VE9DVE9VIGlzIHRoZQpyZXNwb25zaWJpbGl0eSBvZiBlYWNoIGRldmljZSBkcml2ZXIsIGFuZCB0
aGUgTGludXgga2VybmVsIGRvZXMgbm90IHByb3ZpZGUKYSBzZXQgb2YgQVBJIHRvIGd1YXJhbnRl
ZSBzdWNoIGxvZ2ljYWwgb3duZXJzaGlwPwoKVGhhbmtzLCAKQ2hlbmcgTGluZ2ZlaS48L3JvYmlu
Lm11cnBoeUBhcm0uY29tPg==
