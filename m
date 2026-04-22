Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696B340D9A
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840285; cv=none; b=oOT/MsoLzbyrsS7U105NtEpDAKfFB/0tFjgY2PRr0W0DN9JG6QDhbKU99NQ70UdKNjkcQ6qrGB+l6081bl9/z4okQ5FlgcLJi5Td9AC1Je4d09C+UenHdjuuFapF6eLmef3lkukDL9e7PDbpqPtBHBm2QTiwkdUJd0aTfLRqvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840285; c=relaxed/simple;
	bh=fS2QBWs2obdiLzxAoZ0EJnbYRNECZXvcOmREgencDsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhvyzKyaDbD2OnY1pBv+jeM2ofqWxfp42O023i4E2TRfEx8eGEexi8JicpVAoXs2Rrg468AknHuuqhTtQQNm0WulaYZ88JagBhO0epqbfJi8LLnn4IJajlFC+yPLKRP9jvSk1Bz9hHB8+xirhPq3tKjQzoctw5+2+senutLeLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Z1HdLQNn; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Z1HdLQNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1776840282; x=1808376282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fS2QBWs2obdiLzxAoZ0EJnbYRNECZXvcOmREgencDsI=;
  b=Z1HdLQNn2lKqI5fwkbf2StBG70n6cfuhwa/u9qFYqrqz3zsdvYL3RzXD
   zNh+t8wzgwRih51L+9qiWdpyoMhorD3Ob+1k4/UcOHeeBFSRkbUkVw4GC
   vr9kKK6zkQoxg2j41NMO2C0G9VSEj62lM/iEF9Um0ZMIypKvfZCUOMBnf
   1dbQDBIPMADG5D4E2uHz/LQlRyKPUvxuPD0o+/AFJeMQon6xtlru+hS24
   meaD1uwTja1ocAVohe/SnhTcGUstPFovXfcnJdrEWb7n0DSX8JogaeXLP
   fbC9BDYK3zKCSWp5t15sfNBDnHg0iPKyWT3JWp91yIf8uIgKaZLq6v/uj
   g==;
X-CSE-ConnectionGUID: wVTeWmHYSoCCAFjgXUCPeg==
X-CSE-MsgGUID: +HvSaA9xRrqsZCPGoSILhQ==
X-IronPort-AV: E=Sophos;i="6.23,192,1770595200"; 
   d="scan'208";a="17712173"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:44:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:9319]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id bbe86f27-fd78-401d-abb1-03ac4b44e654; Wed, 22 Apr 2026 06:44:38 +0000 (UTC)
X-Farcaster-Flow-ID: bbe86f27-fd78-401d-abb1-03ac4b44e654
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 22 Apr 2026 06:44:36 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 22 Apr 2026
 06:44:34 +0000
Date: Wed, 22 Apr 2026 06:44:31 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Zeev Zilberman
	<zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260420124032.GO2577880@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: base64

T24gTW9uLCBBcHIgMjAsIDIwMjYgYXQgMDk6NDA6MzJBTSAtMDMwMCBKYXNvbiBHdW50aG9ycGUg
d3JvdGU6Cj4gT24gTW9uLCBBcHIgMjAsIDIwMjYgYXQgMTI6MzI6MDFQTSArMDAwMCwgRXZhbmdl
bG9zIFBldHJvbmdvbmFzIHdyb3RlOgo+ID4gV2hlbiB0aGUgaGFyZHdhcmUgYWR2ZXJ0aXNlcyBi
b3RoIFN0YWdlIDEgYW5kIFN0YWdlIDIgdHJhbnNsYXRpb24sIHRoZQo+ID4gZHJpdmVyIHByZWZl
cnMgU3RhZ2UgMSBmb3IgRE1BIGRvbWFpbiBhbGxvY2F0aW9uIGFuZCBvbmx5IGZhbGxzIGJhY2sg
dG8KPiA+IFN0YWdlIDIgaWYgU3RhZ2UgMSBpcyBub3Qgc3VwcG9ydGVkLgo+ID4gCj4gPiBTb21l
IGNvbmZpZ3VyYXRpb25zIG1heSB3YW50IHRvIGZvcmNlIFN0YWdlIDIgdHJhbnNsYXRpb24gZXZl
biB3aGVuIHRoZQo+ID4gaGFyZHdhcmUgc3VwcG9ydHMgU3RhZ2UgMS4gCj4gCj4gV2h5PyBZb3Ug
cmVhbGx5IG5lZWQgdG8gZXhwbGFpbiB3aHkgZm9yIGEgcGF0Y2ggbGlrZSB0aGlzLgo+IAo+IElm
IHRoZXJlIHJlYWxseSBpcyBzb21lIEhXIGlzc3VlIEkgdGhpbmsgaXQgaXMgbW9yZSBhcHByb3By
aWF0ZSB0byBnZXQKPiBhbiBJT1JUIGZsYWcgb3IgSURSIGRldGVjdGlvbiB0aGF0IHRoZSBIVyBo
YXMgYSBwcm9ibGVtLgoKSXQncyBub3QgYSBoYXJkd2FyZSBidWcgdGhlcmUncyBubyBJT1JUIG9y
IElEUiBiaXQgdGhhdCB3b3VsZCBtYWtlIHNlbnNlCmhlcmUuCgpUaGUgbW90aXZhdGlvbiBpcyBs
aXZlIHVwZGF0ZSBvZiB0aGUgaHlwZXJ2aXNvcjogd2Ugd2FudCB0byBrZXhlYyBpbnRvIGEKbmV3
IGtlcm5lbCB3aGlsZSBrZWVwaW5nIERNQSBmcm9tIHBhc3N0aHJvdWdoIGRldmljZXMgZmxvd2lu
Zywgd2hpY2gKbWVhbnMgdGhlIFNNTVUncyB0cmFuc2xhdGlvbiBzdGF0ZSBoYXMgdG8gc3Vydml2
ZSB0aGUgaGFuZG92ZXIuIFRoZSBMaXZlClVwZGF0ZSBPcmNoZXN0cmF0b3Igd29yayBbMV0gYW5k
IHRoZSBpbi1wcm9ncmVzc8KgICJpb21tdTogQWRkIGxpdmUKdXBkYXRlIHN0YXRlIHByZXNlcnZh
dGlvbiIgc2VyaWVzIFsyXSBhcmUgYnVpbGRpbmcgZXhhY3RseSB0aGlzIHBsdW1iaW5nCm9uIHRv
cCBvZiBLSE87IFsyXSdzIGNvdmVyIGxldHRlciBjYWxscyBvdXQgQXJtIFNNTVV2MyBzdXBwb3J0
IGFzIGZ1dHVyZQp3b3JrLCBhbmQgYW4gZWFybGllciBSRkMgZnJvbSBBbWF6b24gWzNdIHNrZXRj
aGVkIHRoZSBzYW1lIGlkZWEgZm9yCmlvbW11ZmQuCgpGb3IgdGhpcyB1c2UgY2FzZSwgU3RhZ2Ug
MiBpcyBtYXRlcmlhbGx5IGVhc2llciB0byBwZXJzaXN0IHRoYW4gU3RhZ2UgMSwKZm9yIHN0cnVj
dHVyYWwgcmF0aGVyIHRoYW4gcGVyZm9ybWFuY2UgcmVhc29uczogQW4gUzIgU1RFIGNhcnJpZXMg
dGhlCndob2xlIHRyYW5zbGF0aW9uIGNvbmZpZ3VyYXRpb24gaW5saW5lLiBUbyBoYW5kIG92ZXIg
YW4gUzIgZG9tYWluLCB0aGUKcHJlLWtleGVjIGtlcm5lbCBvbmx5IG5lZWRzIHRvIHByZXNlcnZl
IHRoZSBzdHJlYW0gdGFibGUgcGFnZXMgYW5kIHRoZQpTMiBwZ3RhYmxlIHBhZ2VzLiBBbiBTMSBT
VEUgcG9pbnRzIGF0IGEgQ29udGV4dCBEZXNjcmlwdG9yIHRhYmxlIGFuZCBhcwphIHJlc3VsdCBQ
ZXJzaXN0aW5nIFMxIHRoZXJlZm9yZSByZXF1aXJlcyBwcmVzZXJ2aW5nIHRoZSBDRCB0YWJsZSBw
YWdlcwp0b28sIGFuZCBiZWNhdXNlIHRoZSBDRCBpcyBrZXllZCBieSBBU0lEIGNvb3JkaW5hdGlu
ZyBBU0lEIGlkZW50aXR5CmFjcm9zcyB0aGUgaGFuZG92ZXIuCgpJbiB0aGUgbG9uZyB0ZXJtIHRo
ZSBwbGFuIHNob3VsZCBiZSB0byBwZXJzaXN0IGJvdGggc3RhZ2VzLgpIb3dldmVyLCB1bnRpbCBh
IHBhdGNoIHNlcmllcyB0aGF0IHByb3Blcmx5IGludHJvZHVjZXMgU01NVSBzdXBwb3J0IGZvcgpp
cyBkZXZlbG9wZWQvcG9zdGVkIHdlIHdvdWxkIGxpa2UgdG8gZXhwZXJpbWVudCB3aXRoIFMxK1My
LWNhcGFibGUKaGFyZHdhcmUgd2l0aCBhbiBlYXNpZXIgdG8gaW1wbGVtZW50IGhhbmRvdmVyIG1h
Y2hpbmVyeSwgdGhhdCByZWxpZXMgb24KUzIgdHJhbnNsYXRpb25zLgoKWzFdIGh0dHBzOi8vbHdu
Lm5ldC9BcnRpY2xlcy8xMDIxNDQyLyDigJQgTGl2ZSBVcGRhdGUgT3JjaGVzdHJhdG9yClsyXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjAyMDMyMjA5NDguMjE3NjE1Ny0xLXNraGF3
YWphQGdvb2dsZS5jb20vIOKAlApbUEFUQ0ggMDAvMTRdIGlvbW11OiBBZGQgbGl2ZSB1cGRhdGUg
c3RhdGUgcHJlc2VydmF0aW9uClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5
MTYxMTMxMDIuNzEwNTIyLTEtamdvd2Fuc0BhbWF6b24uY29tLyDigJQgW1JGQwpQQVRDSCAwMC8x
M10gU3VwcG9ydCBpb21tdShmZCkgcGVyc2lzdGVuY2UgZm9yIGxpdmUgdXBkYXRlCgo+IEphc29u
CgpLaW5kIFJlZ2FyZHMsCkV2YW5nZWxvcwoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3Bt
ZW50IENlbnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4K
R2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0aWVnZXIKRWlu
Z2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBC
ClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==

