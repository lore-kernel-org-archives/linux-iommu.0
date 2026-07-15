Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AE2836E
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081755; cv=none; b=VrvNxW5LS0vx0y+tfW/4CRPHJ5aqtvch5f6cNd7AyTq/Vluf6BH/AcxuV+5nWj/e9zn1t1IT3+J2fJeH8R+dADgE6D3NyPyFNBgDRbV45Zc+dL5UqsY5wt3iTVCZWQ6n3W2SMPcwm8gmxnUBmuXsmHw11JxJXYLmHSIYdrL0ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081755; c=relaxed/simple;
	bh=cvJo62jzo8GEatvtucWOxHpxMBXHaV5+0ux4r3mR61w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FaEJtM7OcKnhlWhLDhvXmIO6BRHDyZ0pbBtwC0RMevtm3VNm5lR0tuyMtcgoUhRirm2K3Oz9y258tTpbZQZ0V9GtXTeW44WX5X8sOZdZrheB9YGjJdFukjsDzKGUn3bI0glori/TU6DXdOxgbS4aDfNwwn8SUqE9mLGm64RPE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y2H+oczY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y2H+oczY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=cvJo62jzo8GEatvtucWOxHpxMBXHaV5+0ux4r3mR61w=; b=Y
	2H+oczYwtZRM8xJdVBxNUaZmDL2QDXI14xVVXb6EY4GfR7l+/fir+zus0Wa9Ih9/
	4Wr1uu/+qZOthWa7DOO7nXqsJLWV5SBiLlsVmaUtBJ9q5uG0BwwgeshY+E7fIdSB
	zxEgQbrHN+NO/rv9fn1bDj8+bwZoKsYoDyWgAULxvg=
Received: from xiongwm2026$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Wed, 15 Jul 2026 10:15:03 +0800
 (CST)
Date: Wed, 15 Jul 2026 10:15:03 +0800 (CST)
From: xiongwm2026  <xiongwm2026@163.com>
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: "Pranjal Shrivastava" <praan@google.com>,
	"Will Deacon" <will@kernel.org>, "Joerg Roedel" <joro@8bytes.org>,
	"Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
	"Rob Clark" <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re:Re: [PATCH v1 0/4] iommu: Fix device lookup lifetime and probe
 cleanup
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <0e405cb3-1227-4ad2-96ff-aa0db3124381@arm.com>
References: <20260714060930.220277-1-xiongwm2026@163.com>
 <alZCbIIuawpugaQe@google.com>
 <0e405cb3-1227-4ad2-96ff-aa0db3124381@arm.com>
X-NTES-SC: AL_Qu2TBvyTvk8r5SSZYukckk8Ugeg8Xsewsvgh249ec/4EmyzdyAcGXkRiO2PO1vm+DhyhuTyzfwlA7OdxRZVbBl9ZsUbd7u3gDD92HriihQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <78f42e18.1be7.19f638e6201.Coremail.xiongwm2026@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSgvCgDn7xwo7VZqYlMeAA--.733W
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQi1RWpW7Sg5eAAA3N
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBQcmFuamFsLCBIaSBSb2JpbiwKCgoKVGhhbmtzIGEgbG90IGZvciB0aGUgY2FyZWZ1bCBy
ZXZpZXcgYW5kIGZvciBjbGFyaWZ5aW5nIHRoZQpyZWZjb3VudCBzZW1hbnRpY3MgaGVyZS4KCgpJ
IHNlZSBJIGNvbmZsYXRlZCB0aGUgZXh0cmEgcmVmZXJlbmNlIHRha2VuIGJ5CmJ1c19maW5kX2Rl
dmljZSooKSB3aXRoIG9iamVjdCBsaWZldGltZS4gUHV0dGluZyB0aGF0CnJlZmVyZW5jZSBhZnRl
ciB0aGUgbG9va3VwIGlzIG1lYW50IHRvIHJlc3RvcmUgdGhlIHByZS1maW5kCmJhbGFuY2U7IGl0
IGRvZXMgbm90IGJ5IGl0c2VsZiBpbXBseSB0aGF0IHRoZSBkZXZpY2UgaXMgZ29uZQpvciB0aGF0
IGxhdGVyIHVzZSBvZiBkcml2ZXIgcHJpdmF0ZSBkYXRhIGlzIGEgdXNlLWFmdGVyLXB1dC4KQXMg
eW91IGJvdGggcG9pbnRlZCBvdXQsIGEgcHV0IHRoYXQgcmVhY2hlcyB6ZXJvIGluc2lkZSBwcm9i
ZQp3b3VsZCBwb2ludCBhdCBhIGRlZXBlciBvd25lcnNoaXAgYnVnIGVsc2V3aGVyZSwgd2hpY2gg
SSBoYXZlCm5vdCBkZW1vbnN0cmF0ZWQuCgoKSSBkbyBub3QgY3VycmVudGx5IGhhdmUgYSBLQVNB
TiByZXBvcnQsIG9vcHMsIG9yIG90aGVyCmZhaWxpbmcgbG9nIHRoYXQgc2hvd3MgYSBjb25jcmV0
ZSBicmVha2FnZSBmb3IgdGhlc2UgcGF0aHMuCkdpdmVuIHRoYXQsIEkgd2lsbCBub3QgcHVyc3Vl
IHRoZSAibG9va3VwIGxpZmV0aW1lIiBmcmFtaW5nCmZ1cnRoZXIgYW5kIHdpbGwgZHJvcCB0aGlz
IHNlcmllcyBhcyBwcm9wb3NlZC4KCgpSb2JpbjogaWYgdXNlZnVsIGFzIGEgZm9sbG93LXVwLCBJ
IGNhbiBzZW5kIGEgc21hbGwgY2xlYW51cAp0aGF0IHJlbW92ZXMgdGhlIG5vdy1yZWR1bmRhbnQg
TlVMTCBjaGVja3MgYWZ0ZXIKMTdkZTNmNWZkZDM1ICgiaW9tbXU6IFJldGlyZSBidXMgb3BzIiks
IHdpdGhvdXQgY2xhaW1pbmcgYQpsaWZldGltZSBmaXguIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5
b3Ugd291bGQgbGlrZSB0aGF0LgoKClRoYW5rcyBhZ2FpbiBmb3IgdGhlIGV4cGxhbmF0aW9uLgoK
CkJlc3QgcmVnYXJkcywKV2VpbWluCgoKQXQgMjAyNi0wNy0xNCAyMzo1Njo1MCwgIlJvYmluIE11
cnBoeSIgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToKPk9uIDE0LzA3LzIwMjYgMzowNiBw
bSwgUHJhbmphbCBTaHJpdmFzdGF2YSB3cm90ZToKPj4gT24gVHVlLCBKdWwgMTQsIDIwMjYgYXQg
MDI6MDk6MjZQTSArMDgwMCwgd2VpbWluIHhpb25nIHdyb3RlOgo+Pj4gRml4IGEgZmV3IElPTU1V
IGRyaXZlciBsaWZldGltZSBhbmQgZXJyb3ItcGF0aCBpc3N1ZXMgZm91bmQgd2hpbGUKPj4+IGF1
ZGl0aW5nIGZ3bm9kZS1iYXNlZCBkZXZpY2UgbG9va3VwIGFuZCBwcm9iZSBjbGVhbnVwIHBhdGhz
Lgo+Pj4KPj4+IFRoZSBmaXJzdCB0aHJlZSBwYXRjaGVzIGF2b2lkIGRlcml2aW5nIGRyaXZlciBw
cml2YXRlIGRhdGEgYWZ0ZXIKPj4+IGRyb3BwaW5nIHRoZSBkZXZpY2UgcmVmZXJlbmNlIHJldHVy
bmVkIGJ5IGJ1c19maW5kX2RldmljZV9ieV9md25vZGUoKS4KPj4+IFRoZXkgYWxzbyBtYWtlIHRo
ZSBBUk0gU01NVSB2MiBhbmQgVlNJIHByb2JlIHBhdGhzIGZhaWwgY2xlYW5seSB3aGVuIHRoZQo+
Pj4gSU9NTVUgbG9va3VwIGZhaWxzLgo+PiAKPj4gSSdtIG5vdCBzdXJlIGlmIHRoYXQncyByZWFs
bHkgbmVlZGVkPyBBbGwgdGhlc2UgZHJpdmVycyBhcmUgZG9pbmcgaXMKPj4gZHJvcHBpbmcgdGhl
ICJleHRyYSIgcmVmY291bnQgKGluY3JlbWVudGVkIGJ5IGNhbGxpbmcgZmluZF9kZXZpY2UpICBi
YWNrCj4+IHRvIHRoZSBzdGF0ZSAqYmVmb3JlKiB0aGUgZndub2RlIGZ1bmN0aW9uIGNhbGwuIElm
IHlvdSBmaW5kIHRoYXQgdGhpcwo+PiBwdXRfZGV2aWNlIGNhdXNlZCB0aGUgY291bnQgdG8gZHJv
cCB0byAwLCBJIGJlbGlldmUgdGhhdCdzIHRoZSByZWFsCj4+IHByb2JsZW0vYnVnLiBUaGVzZSBm
d25vZGUgZnVuY3Rpb25zIGFyZSB1c3VhbGx5IGNhbGxlZCBpbiBwcm9iZSBhbmQgdGhlCj4+IHJl
ZmNvdW50IHNob3VsZG4ndCBiZSAwIGluc2lkZSBwcm9iZS4KPj4gCj4+IENvdWxkIHlvdSBzaGFy
ZSB5b3VyIG9ic2VydmF0aW9uIC8gZmFpbGluZyBsb2dzIHdoZXJlIHRoaXMgZmFpbHM/IE1heWJl
Cj4+IHNvbWV0aGluZyBlbHNlIGlzIHdyb25nIHdpdGggdGhlIHN5c3RlbT8KPgo+SSBkb24ndCBo
YXZlIGFueSB0cmFjZSBvZiB0aGUgb3JpZ2luYWwgcGF0Y2hlcyAodGhhbmtzLCBNaWNyb3NvZnQu
Li4pIAo+YnV0IGxvb2tpbmcgb24gbG9yZSwgeWVzIHRoZXNlICJsaWZldGltZSIgY29uY2VybnMg
YXJlIHNwdXJpb3VzOyBpdCdzIAo+anVzdCBhIHBhcnRpY3VsYXIgc2l0dWF0aW9uIHdoZXJlIGR1
ZSB0byB0aGUgQVBJLCB0aGUgZHJpdmVycyBhcmUgdGFraW5nIAo+YSBzbGlnaHRseSByb3VuZGFi
b3V0IHJvdXRlIHRvIGxvb2sgdXAgdGhlaXIgb3duIHZhbGlkIGRldmljZSBpbnN0YW5jZS4KPgo+
VGhlIElPTU1VIGRldmljZSBtdXN0IGFscmVhZHkgaGF2ZSBhdCBsZWFzdCBvbmUgaGVsZCByZWZl
cmVuY2UgZnJvbSB3YXkgCj5iYWNrIGluIGl0cyBkZXZpY2VfaW5pdGlhbGlzZSgpLCB3aGljaCB3
aWxsIG5vdCBiZSByZWxlYXNlZCB1bmxlc3MgYW5kIAo+dW50aWwgZGV2aWNlX3VucmVnaXN0ZXIo
KSBpcyBjYWxsZWQgKHdoaWNoIGlzIHByb2JhYmx5IG5ldmVyIGZvciBhIAo+bm9uLWhvdHBsdWdn
YWJsZSBwbGF0Zm9ybSBkZXZpY2Ugb25jZSBpdCBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgY3JlYXRl
ZCkuIAo+SWYgc29tZW9uZSB1bnJlZ2lzdGVyZWQgYSBwbGF0Zm9ybSBkZXZpY2Ugd2hpbGUgaXQg
c3RpbGwgaGFkIGEgZHJpdmVyIAo+Ym91bmQsIG9yIHRoZSBJT01NVSBkcml2ZXIgY291bGQgYmUg
dW5ib3VuZCB3aXRob3V0IHVucmVnaXN0ZXJpbmcgdGhlIAo+aW9tbXVfZGV2aWNlIHRocm91Z2gg
d2hpY2ggaXRzIC0+b2ZfeGxhdGUgb3IgLT5wcm9iZV9kZXZpY2UgY291bGQgYmUgCj5jYWxsZWQs
IHNvIG1hbnkgb3RoZXIgdGhpbmdzIHdvdWxkIGJlIGJsb3dpbmcgdXAgYWxyZWFkeSB0aGF0IHRo
aXMgd291bGQgCj5zdGlsbCBiZSBpcnJlbGV2YW50Lgo+Cj5TaW5jZSAxN2RlM2Y1ZmRkMzUgKCJp
b21tdTogUmV0aXJlIGJ1cyBvcHMiKSB0aGVzZSBsb29rdXBzIHNob3VsZCBhbHNvIAo+bmV2ZXIg
cmV0dXJuIE5VTEwgZm9yIHRoZSBzYW1lIHJlYXNvbnMsIHNvIGRvIGZlZWwgZnJlZSB0byBjbGVh
biB1cCAKPnRob3NlIHJlZHVuZGFudCBjaGVja3MgaWYgaXQgaGVscHMgbWFrZSB0aGluZ3MgYSBi
aXQgY2xlYXJlci4KPgo+VGhhbmtzLAo+Um9iaW4uCg==
