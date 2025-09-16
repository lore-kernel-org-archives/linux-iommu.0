Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CD222585
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019385; cv=none; b=nyABHIDeyaNgce+Q5d4QP4lpZdqskDNatwzhM+Oh6oTA5Q9RScJyB6p6zJ7t0HACVPlr+5xOwOCIEfpIPTVNDf0bsTTnfuzvmg00Z+3zp44z3Z9aBxnzkCFUT4dKpwC7R3aTwQ/NxFHzC5VxSCyJB9a46kXIoeF6QriTK/3D0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019385; c=relaxed/simple;
	bh=zGeHbvbT6uC4yZIrD2BC4ijIEopsOpTEstLDg3X6cpo=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=Aq8zayZMJL12vv6eqp/zvEea/csxs5fA1F3jeOWCybZx0CctjQdNSxltE5rZZOIwW3PIXoyExTShfo9NRIwmM2e+nJiHTmp16UKi0x3aBeTnLtw4f9oX9J56KHbqr8BnlhNH9KtbiUIg66eUG+C5X09DKmRrBnUEWGEOmvn/MW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from LAPTOP-2KT3QRS7(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.egM8Sps_1758018443 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 18:27:24 +0800
Date: Tue, 16 Sep 2025 18:27:23 +0800
From: "guoyaxing@bosc.ac.cn" <guoyaxing@bosc.ac.cn>
To: will <will@kernel.org>
Cc: linux-riscv <linux-riscv@lists.infradead.org>, 
	iommu <iommu@lists.linux.dev>, 
	tjeznach <tjeznach@rivosinc.com>, 
	joro <joro@8bytes.org>, 
	robin.murphy <robin.murphy@arm.com>, 
	paul.walmsley <paul.walmsley@sifive.com>, 
	palmer <palmer@dabbelt.com>, 
	aou <aou@eecs.berkeley.edu>, 
	alex <alex@ghiti.fr>, 
	anxu <anxu@bosc.ac.cn>, 
	wangran <wangran@bosc.ac.cn>
Subject: Re: Re: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>, 
	<aMfsj1U7NY2m68T4@willie-the-truck>
X-Priority: 3
X-GUID: 23D66E4B-AE8C-482B-9FA9-143F3F246F53
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.306[cn]
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-ID: <202509161827232434929@bosc.ac.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksIFdpbGwKCgpGcm9tOsKgV2lsbCBEZWFjb24KCgoKRGF0ZTrCoDIwMjUtMDktMTXCoDE4OjM4
CgoKClRvOsKgWWF4aW5nIEd1bwoKCgpDQzrCoGxpbnV4LXJpc2N2OyBpb21tdTsgdGplem5hY2g7
IGpvcm87IHJvYmluLm11cnBoeTsgcGF1bC53YWxtc2xleTsgcGFsbWVyOyBhb3U7IGFsZXg7IGFu
eHU7IHdhbmdyYW4KCgoKU3ViamVjdDrCoFJlOiBbUEFUQ0ggdjEgMS8zXSBpb21tdS9yaXNjdjog
QWRkIGlvbW11IHBlcmYgZHJpdmVyCgoKCk9uIE1vbiwgU2VwIDE1LCAyMDI1IGF0IDEwOjA5OjA5
QU0gKzA4MDAsIFlheGluZyBHdW8gd3JvdGU6CgoKCj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBh
IHBlcmZvcm1hbmNlIG1vbml0b3IgZHJpdmVyIGZvciBSSVNDLVYgSU9NTVUKCgoKPj4gaW9ocG0g
aW1wbGVtZW50aW9ucyB0aGF0IHN1cHBvcnQgaGFyZHdhcmUgcGVyZm9ybWFuY2UgY291bnRlcnMu
CgoKCj4+IFRoZSBkcml2ZXIgZXhwb3NlIFJJU0MtVi1JT01NVS1zcGVjaWZpYyBwZXJmb3JtYW5j
ZSBldmVudHMgKGVnLiBjeWNsZXMsCgoKCj4+IHRsYiBtaXNzIC4uLil0aHJvdWdoIHRoZSBMaW51
eCBwZXJmIHN1YnN5c3RlbSwgZW5hYmxpbmcgZGV2ZWxvcGVycwoKCgo+PiB0byBwcm9maWxlIGFu
ZCBvcHRpbWl6ZSBJL08gdHJhbnNsYXRpb24gcGVyZm9ybWFuY2UuCgoKCj4+CgoKCj4+IEtleSBm
ZWF0dXJlczoKCgoKPj4gLSBJbXBsZW1lbnRzIGEgcGVyZiBQTVUgZHJpdmVyIGZvciBSSVNDLVYg
SU9NTVUuCgoKCj4+CgoKCj4+IC0gRXhwb3NlcyBJT01NVSBwZXJmIGV2ZW50cywgc3VjaCBhcyAn
Y3ljbGVzJywgJ3RsYl9taXNzJy4uLiB2aWEKCgoKPj7CoMKgIC9zeXMvZGV2aWNlcy9yaXNjdi1p
b21tdS1wbXUvZXZlbnRzLywgYWxsb3dpbmcgdXNlIHdpdGggcGVyZgoKCgo+PsKgwqAgdG9vbHM6
CgoKCj4+wqDCoMKgwqAgcGVyZiBzdGF0IC1DIDAgLWUgcmlzY3YtaW9tbXUtcG11L2N5Y2xlcy8g
Li4uCgoKCj4+wqDCoMKgwqAgcGVyZiBzdGF0IC1DIDAgLWUgcmlzY3YtaW9tbXUtcG11L3RsYl9t
aXNzLyAuLi4KCgoKPj7CoMKgwqDCoCAuLi4KCgoKPj4gLSBTdXBwb3J0cyBldmVudCBmaWx0ZXJp
bmcgdGhyb3VnaCBjb25maWd1cmVhYmxlIGF0dHJpYnV0ZXMgZXhwb3NlZAoKCgo+PsKgwqAgaW4g
L3N5cy9kZXZpY2VzL3Jpc2N2LWlvbW11LXBtdS9mb3JtYXQvLCBpbmNsdWRpbmc6CgoKCj4+wqDC
oCBkdl9nc2N2LCBwdl9wc2N277yMZGlkX2dzY2lk77yMcGlkX3BzY2lk77yMaWR0IChyaXNjdiBp
b21tdSBzcGVjIDUtMjMpLgoKCgo+PgoKCgo+PiAtIEltcGxlbWVudHMgb3ZlcmZsb3cgaW50ZXJy
dXB0IGhhbmRsaW5nLgoKCgo+PgoKCgo+PiAtIEFkZHMgZGV2aWNlIHRyZWUgYmluZGluZyBzdXBw
b3J0IHZpYSBvcHRpb25hbCAncG11LW5hbWUnIHByb3BlcnR5CgoKCj4+wqDCoCBhbGxvd2luZyBw
bGF0Zm9ybS1zcGVjaWZpYyBJT01NVSBpbXBsZW1lbnRhdGlvbnMgdG8gc3BlY2lmeSBhIGN1c3Rv
bQoKCgo+PsKgwqAgZGVmaW5lZCBldmVudCBJRCBsaXN0LiBJZiBub3QgcHJvdmlkZWQsIHRoZSBk
cml2ZXIgZGVmYXVsdHMgdG8gb25seQoKCgo+PsKgwqAgc3VwcG9ydGluZyAnY3ljbGVzJy4gV2hl
biBzZXQgdG8gJ2R1bW15JywgaXQgZW5hYmxlcyBhbGwgOSBzdGFuZGFyZAoKCgo+PsKgwqAgZXZl
bnQgSURzIGFzIGRlZmluZWQgaW4gcmlzY3YgaW9tbXUgc3BlYyg1LTIzKS4KCgoKPj4KCgoKPj4g
U2lnbmVkLW9mZi1ieTogWWF4aW5nIEd1byA8Z3VveWF4aW5nQGJvc2MuYWMuY24+CgoKCj4+IC0t
LQoKCgo+PsKgIGRyaXZlcnMvaW9tbXUvcmlzY3YvaW9tbXUtcGVyZi5jIHwgNTM1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKCgoKPj7CoCBkcml2ZXJzL2lvbW11L3Jpc2N2L2lvbW11
LXBlcmYuaCB8wqAgODggKysrKysKCgoKPj7CoCBkcml2ZXJzL2lvbW11L3Jpc2N2L2lvbW11LmjC
oMKgwqDCoMKgIHzCoMKgIDggKwoKCgo+PsKgIDMgZmlsZXMgY2hhbmdlZCwgNjMxIGluc2VydGlv
bnMoKykKCgoKPj7CoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pb21tdS9yaXNjdi9pb21t
dS1wZXJmLmMKCgoKPj7CoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pb21tdS9yaXNjdi9p
b21tdS1wZXJmLmgKCgoKwqAKCgoKPiBQTVUgZHJpdmVycyBhcmUgYmV0dGVyIHBsYWNlZCB1bmRl
ciBkcml2ZXJzL3BlcmYvCgoKCsKgCgoKCj4gKHRoZSBBcm0gU01NVXYzIFBNVSBkcml2ZXIgbGl2
ZXMgdGhlcmUsIGZvciBleGFtcGxlKS4KCgoKSSBkaWQgYSBxdWljayByZWFkaW5nIG9mIFNNTVUg
cG11IGRyaXZlciBpbiBkcml2ZXJzL3BlcmYvLiAgSG93ZXZlciwgSWYgdGhlIFJJU0MtViBJT01N
VSBQTVUgZHJpdmVyIGlzIHBsYWNlZCB1bmRlciBkcml2ZXJzL3BlcmYvIGFzIHRoZSBTTU1VIGRp
ZCwgaXQgd291bGQgY2F1c2UgYW4gb3ZlcmxhcCBpbiB0aGUgaW9tZW0gcmVzb3VyY2UgcmVnaW9u
IGJldHdlZW4gdGhlIHR3byBkZXZpY2VzKGlvbW11ICYgaW9tbXUgcG11KSwgYmVjYXVzZSBpdCBu
ZWVkcyB0byBzaGFyZSBpbnRlcnJ1cHQtcmVsYXRlZCByZWdpc3RlcnMgKHN1Y2ggYXMgdGhlIElQ
U1IgcmVnaXN0ZXIpIHdpdGggdGhlIG1haW4gSU9NTVUgZHJpdmVyLgoKWWF4aW5nIEd1bwoKCj4g
V2lsbAogCgoKCg==

