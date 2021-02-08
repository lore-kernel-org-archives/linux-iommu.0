Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B886C433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 15:00:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CF464E8A
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 15:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CF464E8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 61A148698B;
	Mon,  8 Feb 2021 15:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vs6wzzU40wWy; Mon,  8 Feb 2021 15:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A123F86796;
	Mon,  8 Feb 2021 15:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8721BC0891;
	Mon,  8 Feb 2021 15:00:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B589FC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 15:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A446286945
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 15:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G551Ze6UbHFj for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 15:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9621986796
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 15:00:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B19364E87;
 Mon,  8 Feb 2021 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612796427;
 bh=N2qAaEF+3vCal/IUAEMuWldnK28lwtVGBy4zy/3xQnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OBCVKGxgL7AwA/EBPZev3Yn27mzm1utXzMxQjebeNfn7XQ9PP/1E1llwkXFCxDjaF
 0QTh6X60Th1mWFCBEbY5TftVWTwblcsibLMyzEULPPdOkNjbnlEc6iPkBu33yYvSiw
 L8Dge0oeh+uNAQV4c29S7Yj9xWsJzRl9s754en4k=
Date: Mon, 8 Feb 2021 16:00:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] driver core: lift dma_default_coherent into common
 code
Message-ID: <YCFSCZz3qjdM5rJw@kroah.com>
References: <20210208145024.3320420-1-hch@lst.de>
 <20210208145024.3320420-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208145024.3320420-6-hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMDM6NTA6MjNQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6Cj4gTGlmdCB0aGUgZG1hX2RlZmF1bHRfY29oZXJlbnQgdmFyaWFibGUgZnJvbSB0
aGUgbWlwcyBhcmNoaXRlY3R1cmUgY29kZQo+IHRvIHRoZSBkcml2ZXIgY29yZS4gIFRoaXMgYWxs
b3dzIGFuIGFyY2hpdGVjdHVyZSB0byBzZGVmYXVsdCBhbGwgZGV2aWNlCj4gdG8gYmUgRE1BIGNv
aGVyZW50IGF0IHJ1biB0aW1lLCBldmVuIGlmIHRoZSBrZXJuZWwgaXMgYnVpbGQgd2l0aCBzdXBw
b3J0Cj4gZm9yIERNQSBub25jb2hlcmVudCBkZXZpY2UuICBCeSBhbGxvd2luZyBkZXZpY2VfaW5p
dGlhbGl6ZSB0byDRlWV0IHRoZQo+IC0+ZG1hX2NvaGVyZW50IGZpZWxkIHRvIHRoaXMgZGVmYXVs
dCB0aGUgYW1vdW50IG9mIGFyY2ggaG9va3MgcmVxdWlyZWQKPiBmb3IgdGhpcyBiZWhhdmlvciBj
YW4gYmUgZ3JlYXRseSByZWR1Y2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAbHN0LmRlPgoKQWNrZWQtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
