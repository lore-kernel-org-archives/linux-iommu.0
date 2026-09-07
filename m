Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com [220.197.31.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDE416878
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766807; cv=none; b=YcYyk30afA7y7JWaKD6o09YglNg957k7LN2raGE/CEMPboqMWy+CL1CnCoWgOzMM5xTub3VSYQALAiVuB1XfMfeecsIBHXqcd+0LBCytjGZnv2ic9Og04R/JHkHwJi0U3HCkMQjpzTMHh4Sax9rDH4FjUkkav7Kre+lXyJ1NQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766807; c=relaxed/simple;
	bh=FETyHV5oNdwe2B+5dMcqMzeGfptPLJBq55LFY+oJtxI=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=YsN3al8SgnA77t7CZXpc7Sp3o1B7EsTYcqeVn+hwtuQTemoyTSPp5EkgsmuGaQHzX/Tetdrr2YRzLYTpHTjZgFV/JYogsLwVqqAFzaedZkrxphPRUfnh1OHp6D5wwmTd/VN6zXrgOGgVjK48IKgfchQindcvFWgqRI207Qs6slI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=220.197.31.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAoAJADfK4tx**u*ymw4P4pP.3.1788766489184.Hmail.zhouruizhe@resnics.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Frank Li <Frank.li@oss.nxp.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZG9jczogZG1hLWFwaTogcmVxdWlyZSBjaGVja2luZyBETUEgbWFzayBzZXR1cCBlcnJvcnM=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <20260907054733.GA31481@lst.de>
References: <20260907054400.1088151-1-zhouruizhe@resnics.com> <20260907054733.GA31481@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from zhouruizhe@resnics.com( [103.23.89.253] ) by ajax-webmail ( [127.0.0.1] ) ; Mon, 7 Sep 2026 15:34:49 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
Date: Mon, 7 Sep 2026 15:34:49 +0800 (GMT+08:00)
X-HM-Tid: 0aa07ab8203402eekunm82ad2a0a8e0f
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMdz8H/g99eSjsmp79ug4TtUOfceK239+6Wx8rS
	Mt4AmfBcwCFqZ+1IZEb/P4yrJDw3D5ktAxUewQQNUzChlx4Ph2Q2L9LR/RpKEmchiGgC4lZSc7VZ
	8kfhB+Z9K1dTvdgjh2PPkTjttTX9Ls/rO9ypA=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ04eVh1PTB4YTk9LTE0YSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0hVSUhVQ0JVSU5IWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG

Cj5Gcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPkRhdGU6IDIwMjYtMDktMDcg
MTM6NDc6MzMKPlRvOiAgUnVpemhlIFpob3UgPHpob3VydWl6aGVAcmVzbmljcy5jb20+Cj5DYzog
IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4sUm9iaW4gTXVycGh5
IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4sSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4s
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+LEZyYW5rIExpIDxGcmFuay5saUBvc3Mubnhw
LmNvbT4sU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4sUmFuZHkgRHVubGFw
IDxyZD51bmxhcEBpbmZyYWRlYWQub3JnPixsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnLGlvbW11
QGxpc3RzLmxpbnV4LmRldixsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj5TdWJqZWN0OiBS
ZTogW1BBVENIXSBkb2NzOiBkbWEtYXBpOiByZXF1aXJlIGNoZWNraW5nIERNQSBtYXNrIHNldHVw
IGVycm9ycz5PbiBNb24sIFNlcCAwNywgMjAyNiBhdCAwMTo0NDowMFBNICswODAwLCBSdWl6aGUg
WmhvdSB3cm90ZToKPj4gVGhlIERNQSBIT1dUTyBzYXlzIGRtYV9zZXRfbWFza19hbmRfY29oZXJl
bnQoKSBjYW5ub3QgZmFpbCBmb3IKPj4gRE1BX0JJVF9NQVNLKDY0KSwgYW5kIG1vcmUgZ2VuZXJh
bGx5IGZvciBtYXNrcyB3aWRlciB0aGFuIDMyIGJpdHMuIEl0Cj4+IGNvbnNlcXVlbnRseSByZWNv
bW1lbmRzIGNhbGxzIHRvIGRpc2NhcmQgdGhlIGNoZWNrIGZvciByZXR1cm4gdmFsdWUuCj4+IAo+
PiBUaGUgZ2VuZXJpYyBkaXJlY3QtRE1BIHBhdGggZG9lcyBhY2NlcHQgZXZlcnkgbWFzayBvZiBh
dCBsZWFzdCAzMiBiaXRzLAo+PiBidXQgdGhhdCBpcyBub3QgYW4gQVBJLXdpZGUgc3VjY2VzcyBn
dWFyYW50ZWUuIEJhY2tlbmQgY2FsbGJhY2tzIGNhbgo+PiByZWplY3Qgd2lkZXIgbWFza3M6IGli
bWVidXNfZG1hX3N1cHBvcnRlZCgpIGFuZAo+PiB4ZW5fZ3JhbnRfZG1hX3N1cHBvcnRlZCgpIGFj
Y2VwdCBvbmx5IERNQV9CSVRfTUFTSyg2NCksIHNvIGEgNDAtYml0IG1hc2sKPj4gZmFpbHMuCj4K
PlBsZWFzZSBmaXggdGhlbSBhcyB0aGV5IGJyZWFrIHRoZSB2ZXJ5IHNlbnNpYmxlIEFQSSBndWFy
YW50ZWVzCj5pbnN0ZWFkIG9mIG9mZmljaWFsbHkgc2FuY3Rpb25pbmcgdGhpcyBiZWhhdmlvci4K
CkknbSBzZW5kaW5nIHRoaXMgYmVjYXVzZSBteSBhdWRpdCB0ZWxscyBtZSB0aGF0IHRoZXJlIGFy
ZSBtdWx0aXBsZSBjYXNlcwp3aGVyZSBhID4zMiBiaXQgc2V0IG1hc2sgY2FsbCB3b3VsZCBmYWls
LiBBbmQgdGhhdCBkaXJlY3RseSBjb250cmFkaWN0cyB0aGUKZG9jdW1lbnQuIEkgaGF2ZSBubyBj
bHVlIHRoYXQgdGhlc2UgbXVsdGlwbGUgYmFja2VuZHMgYnJlYWsgdGhlCkFQSSBndWFyYW50ZWUs
IGFuZCB3aGV0aGVyIHRoZXNlIGJhY2tlbmRzIGFyZSByZXF1aXJlZCB0byBkbyB3aGF0IHRoZXkg
ZG8gbm93LiAKTWF5YmUgd2Ugc2hvdWxkIGNjIHRoZSBwZW9wbGUgdGhhdCBtYWludGFpbiB0aGVz
ZSBhbmQgZ2V0IHRoZWlyIGlucHV0PwpNb3Jlb3ZlciwgSSdtIHNlbmRpbmcgdGhpcyB0byBhc2sg
b25lIHNwZWNpZmljIHRoaW5nOgpBY2NvcmRpbmcgdG8gbXkgYXVkaXQsID4zMiBiaXQgc2V0IG9w
IGNhbiBmYWlsLCB3aGljaCBtZWFucyB0aGF0IGRyaXZlcnMgc2hvdWxkCmNoZWNrIHRoZWlyIHJl
dHVybiB2YWx1ZSwgd2hpY2ggaGFwcGVucyB0byBiZSB0aGUgYmVoYXZpb3VyIGFkb3B0ZWQgYnkg
bW9zdAppbi10cmVlIGRyaXZlcnMsIHdoaWNoIGNvbnRyYWRpY3RzIHRoZSBIT1dUTyBndWlkZS4g
U2hvdWxkIHRoZSBkcml2ZXIgcmV0YWluIHRoZQpyZXR1cm4gdmFsdWUgY2hlY2sgb3Igbm90PwoK
Pgo+PiAKPj4gRXZlbiBETUFfQklUX01BU0soNjQpIGNhbiBmYWlsIHdoZW4gRE1BIHNldHVwIGlz
IHVuYXZhaWxhYmxlIG9yCj4+IGluY29uc2lzdGVudC4gRm9yIGV4YW1wbGUsIGRtYV9kdW1teV9z
dXBwb3J0ZWQoKSByZWplY3RzIGV2ZXJ5IG1hc2suCj4KPlNvPyAgRGlkIHlvdSBhY3R1YWxseSB0
cnkgdG8gdW5kZXJzdGFuZCB0aGlzIGNvZGUgb3IgaXMgdGhpcyBqdXN0IGR1bWIKPmFnZW50IHdv
cms/Cj4KClllcywgYW5kIHRvIG15IGJlc3QgdW5kZXJzdGFuZGluZ3MgdGhhdCB0aGlzIG1lYW5z
ICJETUEgYmVpbmcgdW5hdmFpbGFibGUiLgpBbmQgdGhhdCBpcyBhbm90aGVyIHJlYXNvbiBmb3Ig
ZHJpdmVycyB0byBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mCmRtYV9zZXRfbWFza19hbmRfY29o
ZXJlbnQoKS4KCg==
