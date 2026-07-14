Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CB304972
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993992; cv=none; b=GRrqbDl56BubYM5LGa/HlKljoXiLSve6qyUeKrq+YeoL4D4lgVZFuOhWMOjvHz7llZCvQiL2yIBeUFiKvEfNREr4Pe9WccqcqzzbvRHYxQg99GWYM3PlKzkgevY6wPbz1+biN+YHWZAUSTn7VScTFeoikpqv5LsiS054K/B4FZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993992; c=relaxed/simple;
	bh=6Iim7g8dumMqFgO+Fl+JQvR5beMLCmuD59HrJ/odyoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=T1SD4PetH50Oyas77RkD4j+4HIg/zieprHbu23cfzpLMX8fpoVXyrl6VUAT8ISXEF5uS4jYB3FrsOxNQlLdshuJiM6Od1CaejyMJM4Nqk2bp0nrEKfdyak89xkJDIWwMYdBzBS3gEq2sZTaypSAKbSApi3rcG5/MLRVHcb65PTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LrcOXjkf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LrcOXjkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=6Iim7g8dumMqFgO+Fl+JQvR5beMLCmuD59HrJ/odyoE=; b=L
	rcOXjkfCqbebsiaYx8XoRhFxoIwffoIIAeN51OVuRXnKRn7po33HHIEoG5GlyQm2
	+43q8r3lmCHnIgr/RLbglWKke9sbokqvVTVqR7vmAhkB1F2h84TUUZWM+dSe5j46
	9j1dX3qhnqHksaJd3eZNdrtKNeXJf+A0Cyd6NH0RjI=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Tue, 14 Jul 2026 09:52:47 +0800
 (CST)
Date: Tue, 14 Jul 2026 09:52:47 +0800 (CST)
From: "Xiong Weimin" <15927021679@163.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Baolu Lu" <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	jean-philippe@linaro.org, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re:Re: Re: [PATCH] iommu/virtio: Report faults via
 report_iommu_fault()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260713114541.GG674038@nvidia.com>
References: <20260713010442.331096-1-15927021679@163.com>
 <5a220346-2beb-4456-881c-27b9825d9cc3@linux.intel.com>
 <aa9aeb3.65c5.19f5a7f59c8.Coremail.15927021679@163.com>
 <20260713114541.GG674038@nvidia.com>
X-NTES-SC: AL_Qu2TAfWSvEEt4Saebekckk8Ugeg8Xsewsvgh249ec/8Eti30+AcGdm9jI0vR8sOpOxyGjSi2UTVlzvhfT4N1HwXTIBzV2lLgtSeH+iRoTQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <43149e0f.1709.19f5e53a43c.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dygvCgDnJ+JwllVqCzAdAA--.8598W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0hCxOmpVlnAmeAAA3O
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpUaGFua3MgSmFzb24sIHVuZGVyc3Rvb2QuCgoKSSBkb24ndCB3YW50IHRvIGFkZCBhIG5ldyBj
YWxsZXIgb2YgYW4gQVBJIHRoYXQgaXMgYmVpbmcgcGhhc2VkIG91dC4KU2luY2UgdGhlcmUgaXMg
bm8gY29uY3JldGUgaW4tdHJlZSBjb25zdW1lciBmb3IgdGhpcyBkcml2ZXIncyBmYXVsdApoYW5k
bGVyIHRvZGF5LCBJIHdpbGwgZHJvcCB0aGlzIHBhdGNoIGZyb20gdGhlIGN1cnJlbnQgc2VyaWVz
LgoKCklmIGZhdWx0IHJlcG9ydGluZyBpcyBuZWVkZWQgZm9yIHRoaXMgZHJpdmVyIGxhdGVyLCB3
b3VsZCB0aGUgcHJlZmVycmVkCmRpcmVjdGlvbiBiZSB0aGUgbmV3ZXIgZGV2aWNlIGZhdWx0IHBh
dGgsIGUuZy4gaW9tbXVfcmVwb3J0X2RldmljZV9mYXVsdCgpLyAKZG9tYWluLT5pb3BmX2hhbmRs
ZXIsIG9yIHNob3VsZCB0aGlzIHNpbXBseSBiZSBsZWZ0IHRvIHRoZSBJT01NVSBkcml2ZXIKbG9n
Z2luZyB1bmxlc3MgdGhlcmUgaXMgYSByZWFsIGluLXRyZWUgY29uc3VtZXI/CgoKVGhhbmtzLApX
ZWltaW4KCkF0IDIwMjYtMDctMTMgMTk6NDU6NDEsICJKYXNvbiBHdW50aG9ycGUiIDxqZ2dAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj5PbiBNb24sIEp1bCAxMywgMjAyNiBhdCAwNDowMjowM1BNICswODAw
LCBYaW9uZyBXZWltaW4gd3JvdGU6Cj4KPj4gVGhlIGNvbnN1bWVyIGlzIHdob2V2ZXIgcmVnaXN0
ZXJlZCBhIGZhdWx0IGhhbmRsZXIgb24gdGhlIElPTU1VIGRvbWFpbgo+PiB2aWEgaW9tbXVfc2V0
X2ZhdWx0X2hhbmRsZXIoKSChqiB0aGUgc2FtZSBwYXRoIHVzZWQgYnkgb3RoZXIgSU9NTVUKPj4g
ZHJpdmVycyAoZS5nLiBBUk0gU01NVSwgQU1ELCBNVEspIHdoZW4gdGhleSBjYWxsIHJlcG9ydF9p
b21tdV9mYXVsdCgpLgo+Cj5JIHdhbnQgdG8gcmVtb3ZlIHRoaXMgb2xkIEFQSSBhbmQgcG9zdGVk
IGEgc2VyaWVzIGEgd2hpbGUgYmFjayB0bwo+cmVtb3ZlIGl0IGZyb20gc29tZSBkcml2ZXJzIHdo
ZXJlIGl0IGlzIG5ldmVyIHVzZWQuCj4KPklmIHlvdSBkb24ndCBoYXZlIGFuIGFjdHVhbCBjb25j
cmV0ZSBpbi10cmVlIHVzZSB0aGVuIHBsZWFzZSBkb24ndCBhZGQKPm5ldyBjYWxsZXJzIGZvciB0
aGlzIHN0dWZmLgo+Cj5KYXNvbgo=
