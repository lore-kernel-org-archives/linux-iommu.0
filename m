Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59265C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 09:01:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D91D207E8
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 09:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="onCoAOhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D91D207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 132F186B12;
	Wed, 27 May 2020 09:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a-yt_2jc5TeC; Wed, 27 May 2020 09:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A18B981BDF;
	Wed, 27 May 2020 09:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D981C0881;
	Wed, 27 May 2020 09:01:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C618C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ED30C8781C
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dd0HdwmxyMlw for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 09:01:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F13538774C
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:01:44 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5CC1F20723;
 Wed, 27 May 2020 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590570104;
 bh=Ly0PPgLoVOdP2MHz53CmBLAFstCS5mfpl1WpLZ15gps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=onCoAOhnzHO9z1pUO0//RWYJLmKfFMRTqXoBIY+gdObr+17e6nwXXsvWN0RMThy9e
 uwLwAnL2f9xW9oLDKOWZn/Nzmaln1ON7ULTIQPpaM1zsoyYnkrxXXpwhUkArhx2hE2
 yEEIJrw8f7A1SPpbRQGH1EvlHjbsZMtVrqHdWmVk=
Date: Wed, 27 May 2020 11:01:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/2] PCI: Introduce PCI_FIXUP_IOMMU
Message-ID: <20200527090142.GC179718@kroah.com>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
 <20200526144644.GA20784@infradead.org>
 <39144dc0-3b04-3127-978b-bd8487dd06e0@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39144dc0-3b04-3127-978b-bd8487dd06e0@linaro.org>
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kenneth-lee-2012@foxmail.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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

T24gVHVlLCBNYXkgMjYsIDIwMjAgYXQgMTE6MDk6NTdQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IEhpLCBDaHJpc3RvcGgKPiAKPiBPbiAyMDIwLzUvMjYg5LiL5Y2IMTA6NDYsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOgo+ID4gT24gVHVlLCBNYXkgMjYsIDIwMjAgYXQgMDc6NDk6MDhQ
TSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+ID4gPiBTb21lIHBsYXRmb3JtIGRldmljZXMg
YXBwZWFyIGFzIFBDSSBidXQgYXJlIGFjdHVhbGx5IG9uIHRoZSBBTUJBIGJ1cywKPiA+ID4gYW5k
IHRoZXkgbmVlZCBmaXh1cCBpbiBkcml2ZXJzL3BjaS9xdWlya3MuYyBoYW5kbGluZyBpb21tdV9m
d25vZGUuCj4gPiA+IEhlcmUgaW50cm9kdWNpbmcgUENJX0ZJWFVQX0lPTU1VLCB3aGljaCBpcyBj
YWxsZWQgYWZ0ZXIgaW9tbXVfZndub2RlCj4gPiA+IGlzIGFsbG9jYXRlZCwgaW5zdGVhZCBvZiBy
ZXVzaW5nIFBDSV9GSVhVUF9GSU5BTCBzaW5jZSBpdCB3aWxsIHNsb3cKPiA+ID4gZG93biBpb21t
dSBwcm9iaW5nIGFzIGFsbCBkZXZpY2VzIGluIGZpeHVwIGZpbmFsIGxpc3Qgd2lsbCBiZQo+ID4g
PiByZXByb2Nlc3NlZC4KPiA+IFdobyBpcyBnb2luZyB0byB1c2UgdGhpcz8gIEkgZG9uJ3Qgc2Vl
IGEgc2luZ2xlIHVzZXIgaW4gdGhlIHNlcmllcy4KPiBXZSB3aWxsIGFkZCBpb21tdSBmaXh1cCBp
biBkcml2ZXJzL3BjaS9xdWlya3MuYywgaGFuZGxpbmcKPiAKPiBmd3NwZWMtPmNhbl9zdGFsbCwg
d2hpY2ggaXMgaW50cm9kdWNlZCBpbgo+IAo+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2xpbnV4LXBjaS9tc2c5NDU1OS5odG1sCj4gCj4gVW5mb3J0dW5hdGVseSwgdGhlIHBhdGNoIGRv
ZXMgbm90IGNhdGNoIHY1LjgsIHNvIHdlIGhhdmUgdG8gd2FpdC4KPiBBbmQgd2Ugd2FudCB0byBj
aGVjayB3aGV0aGVyIHRoaXMgaXMgYSByaWdodCBtZXRob2QgdG8gc29sdmUgdGhpcyBpc3N1ZS4K
CldlIGNhbid0IHRha2UgbmV3IGFwaXMgd2l0aG91dCBhIHJlYWwgdXNlciwgc28gcGxlYXNlIHN1
Ym1pdCB0aGVtIGFsbCBhdApvbmNlLgoKdGhhbmtzLAoKZ3JlZyBrLWgKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
