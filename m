Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF81CC83000
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 01:04:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0522082E
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 01:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AgHK/cFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0522082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6BB8A23C58;
	Thu, 30 Apr 2020 01:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9n18ff5rmu4; Thu, 30 Apr 2020 01:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C5832357A;
	Thu, 30 Apr 2020 01:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF346C0865;
	Thu, 30 Apr 2020 01:04:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E40CC0172
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 01:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 92F1087CAB
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 01:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2UmxgiQ7qIx for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 01:04:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6760487BE0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 01:04:32 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id t20so3622419qtq.13
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=nHd4t1dxAGq6mLJOxoRUU+Fay7yLnL9/fA8P7+mfDpQ=;
 b=AgHK/cFgIOfkFmmQJ2HHgpg3mx5clBmVW8MSgmXFicJyCJ7uFPspAVHR0NEiw9NKoI
 gep34agHPjs5RuEmiYWHSn+KyGhnMiDOdm2q0JfUMqqaV/P6rJ0s1LLiTktKWnJPcD7L
 DV2ThlelvfRAnYXjfKYFJIjuY/jQ8d27bN7IBHRgXqNlQedc7yhrytKpevi+SzGJibw/
 7ZqEpkp+LVWoZ3Q+jRu0nFJJT24qXdvadNF23JNoMuP8+aI7uNU1szKkiw33VIDiKPLC
 klezXWYEPlNEOjtem1Ra/HmwgV5jOSGB5Vhp5i2dUuzwwaro53RAyZAesvGtOyahi1ht
 YsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=nHd4t1dxAGq6mLJOxoRUU+Fay7yLnL9/fA8P7+mfDpQ=;
 b=Zh0dcHQdmhE0gfq6uOS5kZH73DqofkphpOC+NxPN+btCRok6S6fVhppZ1ThkBplSRf
 deZ9ezwcZNdxxNdlsAEBf2dY76oJPfB95vgrGPZQylIAVGIVftxLpPRtOSSuUNA6ilSy
 udv5TqdtvfH+MkfA1ScRmx8ICOqZVsE2PhrDxETPNsEFj5kFaQbLmskESEZvLbcqCu+W
 8tEA53wbkpIjkckYgoVLi1x8Ua4BcbCJ7eys3ciUxmZxvDobJpVTeZPVkgaMMmhm9QuJ
 M0ofjz4DZL4fhyZtta91hNJFV5IstXV/capxQ4U7b5yd0TX9M7euMgK0QpQ2wNs0V75x
 kSLA==
X-Gm-Message-State: AGi0PubaGPPo+QfEI0dvQahO+Vw5SQ/S1XLhblRo5Z22xPLCuCIrbU+N
 RT+q/mCZQvxPh8zrngD0iliKkQ==
X-Google-Smtp-Source: APiQypIinv6LGmMaBvcDc2ShRyQ8bG/OhOfqiG0k/1Z4rM4tPxtPlwHvvLLjHt/GZvL/0oAqyQ51KA==
X-Received: by 2002:aed:3aa3:: with SMTP id o32mr1207048qte.364.1588208671328; 
 Wed, 29 Apr 2020 18:04:31 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id h6sm739542qtd.79.2020.04.29.18.04.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Apr 2020 18:04:30 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200429112014.GN21900@8bytes.org>
Date: Wed, 29 Apr 2020 21:04:29 -0400
Message-Id: <4B6E0A22-C301-43C9-A8ED-AB473342463C@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
 <20200429112014.GN21900@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Cgo+IE9uIEFwciAyOSwgMjAyMCwgYXQgNzoyMCBBTSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRl
cy5vcmc+IHdyb3RlOgo+IAo+IE9uIE1vbiwgQXByIDIwLCAyMDIwIGF0IDA5OjI2OjEyQU0gLTA0
MDAsIFFpYW4gQ2FpIHdyb3RlOgo+PiBObyBkaWNlLiBUaGVyZSBjb3VsZCBiZSBzb21lIG90aGVy
IHJhY2VzLiBGb3IgZXhhbXBsZSwKPiAKPiBDYW4geW91IHBsZWFzZSB0ZXN0IHRoaXMgYnJhbmNo
Ogo+IAo+IAlodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9q
b3JvL2xpbnV4LmdpdC9sb2cvP2g9YW1kLWlvbW11LWZpeGVzCj4gCj4gSXQgaGFzIHRoZSBwcmV2
aW91cyBmaXggaW4gaXQgYW5kIGEgY291cGxlIG1vcmUgdG8gbWFrZSBzdXJlIHRoZQo+IGRldmlj
ZS10YWJsZSBpcyB1cGRhdGVkIGFuZCBmbHVzaGVkIGJlZm9yZSBpbmNyZWFzZV9hZGRyZXNzX3Nw
YWNlKCkKPiB1cGRhdGVzIGRvbWFpbi0+cHRfcm9vdC4KCkl0IGxvb2tzIHByb21pc2luZyBhcyBp
dCBzdXJ2aXZlcyBmb3IgYSBkYXnigJlzIHN0cmVzcyB0ZXN0aW5nLiBJ4oCZbGwga2VlcCBpdCBy
dW5uaW5nIGZvciBhIGZldyBkYXlzIHRvIGJlIHN1cmUuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
