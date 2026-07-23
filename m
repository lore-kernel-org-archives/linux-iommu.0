Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049130BF69
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777112; cv=none; b=WgmAYLvbNpIafvHJuH0ubWN/8d3akf9NvUzADTHDqrN/E15s47KUkGdjHzQ2Y2FzS8fI2KPmdZMFb42g9EXyyrtbIDY4c0sgIAg9zqG6TxJTlLCYPrBRwshtMpiiIHnKRfMfzfKmMQ8ZTl3vxn93A8cQwscxb1swbtkQQPdfQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777112; c=relaxed/simple;
	bh=1UN7C0fK0fJmjVpLzOE52hlhKm9fO3l/YRKJ9BTDRSs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-Reply-To:
	 References:Message-Id:Date; b=R/Ddom0+eveRMKcsVSFR4dIS6oz9IoN/Lqd587OOQlxStqzzaqk9ovp+zbqC0dFjtkDv9F3AQVIvmEkVvIRTSabpnGBpnsnaJeM3DzFYY3eHnPO9UURGfAaE+tRJ8GQFenA4H2c0wl+GcbIQn2KC9e/KXIbRqUnt1DDEHKYo/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IGsPYUbA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IGsPYUbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
	Message-Id:Date; bh=1UN7C0fK0fJmjVpLzOE52hlhKm9fO3l/YRKJ9BTDRSs=;
	b=IGsPYUbALmHC/4sSwIS3LgYoCmz86BFipasQevtA8PgRMTc6MAKK3f9IFUO6d+
	ko9UvALDyQWscmhYx8w020aieqzr8kax4ypL3nI6+g0hO57P+5fwkj5tqigDDf6s
	On3Jx9I968mJIQIjeHzNFA8ULeKiIt90jUlcQor24xz+Y=
Received: from [127.0.1.1] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnfhp+iWFq43qNIg--.20117S2;
	Thu, 23 Jul 2026 11:24:46 +0800 (CST)
Content-Type: multipart/mixed; boundary="===============2756315878551801467=="
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Xiong Weimin <xiongwm2026@163.com>
To: iommu@lists.linux.dev
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: =?utf-8?q?=5BPATCH_v3_0/2=5D_iommu/virtio=3A_Probe_fixes_for_proper_driver_state?=
In-Reply-To: <20260714025913.2042-1-xiongweimin@kylinos.cn>
References: <20260714025913.2042-1-xiongweimin@kylinos.cn>
X-CM-TRANSID:PygvCgCnfhp+iWFq43qNIg--.20117S2
Message-Id:<6A61897E.2B9DC0.17686@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUSf-PDUUUU
Date: Thu, 23 Jul 2026 11:24:46 +0800 (CST)
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7x50BGphiX4zjAAA3C

--===============2756315878551801467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0000-cover-letter.patch"

RnJvbTogWGlvbmcgV2VpbWluIDx4aW9uZ3dlaW1pbkBreWxpbm9zLmNuPgpTdWJqZWN0OiBbUEFU
Q0ggdjMgMC8yXSBpb21tdS92aXJ0aW86IFByb2JlIGZpeGVzIGZvciBwcm9wZXIgZHJpdmVyIHN0
YXRlCkluLVJlcGx5LVRvOiA8MjAyNjA3MTQwMjU5MTMuMjA0Mi0xLXhpb25nd2VpbWluQGt5bGlu
b3MuY24+ClJlZmVyZW5jZXM6IDwyMDI2MDcxNDAyNTkxMy4yMDQyLTEteGlvbmd3ZWltaW5Aa3ls
aW5vcy5jbj4KClRoaXMgaXMgdjMgb2YgdGhlIHBhdGNoIHNlcmllcy4gdjIgaXMgbm93IG9ic29s
ZXRlLgoKQ2hhbmdlcyBzaW5jZSB2MjoKLSBSZWJhc2VkIG9udG8gbGF0ZXN0IHVwc3RyZWFtCi0g
UGF0Y2ggMyAoIlJlamVjdCBzaG9ydCBldmVudCBidWZmZXJzIikgaGFzIGJlZW4gZHJvcHBlZCBh
cyBpdCB3YXMKICBpbmRlcGVuZGVudGx5IHN1Ym1pdHRlZCBieSBYdSBSYW8KLSBBcyBzdWdnZXN0
ZWQgYnkgV2lsbCBEZWFjb24sIG1vZGlmaWVkIHZpb21tdV9pbml0X3ZxcygpIHRvIHRha2UgdmRl
dgogIGluc3RlYWQgb2YgdmlvbW11LCBzaW5jZSB0aGV5IGFyZSBub3cgbGlua2VkIHZpYSB2ZGV2
LT5wcml2CgotLS0KClhpb25nIFdlaW1pbiAoMik6CiAgaW9tbXUvdmlydGlvOiBTZXQgZHJpdmVy
IGRhdGEgYmVmb3JlIGVuYWJsaW5nIHZpcnRxdWV1ZXMKICBpb21tdS92aXJ0aW86IEhhbmRsZSBp
b21tdV9kZXZpY2VfcmVnaXN0ZXIoKSBmYWlsdXJlcwoKIGRyaXZlcnMvaW9tbXUvdmlydGlvLWlv
bW11LmMgfCAxNyArKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQoKLS0KCjIuNDMuMAoK

--===============2756315878551801467==--

