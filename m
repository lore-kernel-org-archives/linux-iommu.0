Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB708C48BE8
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 00:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC34613C2
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 00:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC34613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE80C415DC;
	Thu, 17 Jun 2021 00:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yTFxfh6kTaui; Thu, 17 Jun 2021 00:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79B0B415C6;
	Thu, 17 Jun 2021 00:27:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5965CC000E;
	Thu, 17 Jun 2021 00:27:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0D13C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 00:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC03283CA7
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 00:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FFwwypvQ_qiG for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 00:27:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B23F583C93
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 00:27:44 +0000 (UTC)
Received: by mail-qt1-x82b.google.com with SMTP id v6so3372437qta.9
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=KIvX93fO1J/dtkzHBZn8boN5+A8/IK0ceANMVQz1H7w=;
 b=qyWGlEfBCmuW1vkYP1a/17mpWZwFwo2b5T6H+eLhobsEMeZT9UI2+HPorM9Gaxj2TJ
 K+Pmp82x05L9FQvOlDVvPBw8SU6Id7yv/C5zy8Pu/j195dQDGp7mIDjoTA+f+4t9SX8A
 56+ONe+Ce1iadJJrIdcf0xlCKR2r0bFVDuP708nvc7PQL5ioQf7Xl1S0jDNnky2J9cLr
 WN7uqwghTSmqJHcsO9rWBJO7clEh5DG+MocU4I7rnYOowVJkXo8ozuNW1LaG/Mz4b6e9
 ylqKMrlWM2mtHfrykRQND+VsO9m/Xe9moKN42gmu+XTbXxQNOLm0V9FweP67GI93V7jd
 Jw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=KIvX93fO1J/dtkzHBZn8boN5+A8/IK0ceANMVQz1H7w=;
 b=TfKsstygu1Vv2qU7nC1cclzPJUPB1XWle5uNx19HgGhIX9o7U2neEk8wVps5EpiI4U
 ybRwQXdgTChSJqbI0eOb5pjkMkvgPfj5l4jrUBCeGN8kO8OdU05VDxST/g2RU60Ec92t
 LPeUaOCbXRLXBrPNmx8htA+8D5zB8tsoDUk1xtF5I8a/OoxTMBfL54hw3Z0ZhAyjfh2E
 5IiKymKA/nk7rU/Fst/ANESlVAEZ4ohHFfcBuhaF6NbZXy1IAgMi4kBOb2F9Jyv3I16R
 D1FXCeGKkp8a0iKN5DiAl3BbpkJFujgJSWzYSYD3G4lN4/w2z7QpvyMjlWJePGPXajES
 75/A==
X-Gm-Message-State: AOAM533oh4sSsC8lI5tRmbdjFX5f0wrj/j5vtqkPV1k5vT5tCebYlNZa
 bNh6BepBVtFQ5m/2+bereeA=
X-Google-Smtp-Source: ABdhPJw3JMIhmiMleh1odDPpGbOyCHN65qWDrIoPtWJ7bPJpDzLoarpEgqHnr4snhp+s2K9Zkc/uIA==
X-Received: by 2002:ac8:7d0c:: with SMTP id g12mr2469507qtb.248.1623889663317; 
 Wed, 16 Jun 2021 17:27:43 -0700 (PDT)
Received: from fedora (cpe-24-59-204-221.twcny.res.rr.com. [24.59.204.221])
 by smtp.gmail.com with ESMTPSA id o12sm668710qki.44.2021.06.16.17.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 17:27:42 -0700 (PDT)
Date: Wed, 16 Jun 2021 20:27:39 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YMqW+/gQvM+uWUTw@fedora>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de> <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
Cc: Dominique MARTINET <dominique.martinet@atmark-techno.com>,
 Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Peter Gonda <pgonda@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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

T24gV2VkLCBKdW4gMTYsIDIwMjEgYXQgMDE6NDk6NTRQTSAtMDcwMCwgSmlhbnhpb25nIEdhbyB3
cm90ZToKPiBPbiBGcmksIEp1biAxMSwgMjAyMSBhdCAzOjM1IEFNIEtvbnJhZCBSemVzenV0ZWsg
V2lsawo+IDxrb25yYWQud2lsa0BvcmFjbGUuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmksIEp1
biAxMSwgMjAyMSBhdCAwODoyMTo1M0FNICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToK
PiA+ID4gT24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMDU6NTI6MDdQTSArMDMwMCwgSG9yaWEgR2Vh
bnTEgyB3cm90ZToKPiA+ID4gPiBJJ3ZlIG5vdGljZWQgdGhlIGZhaWx1cmUgYWxzbyBpbiB2NS4x
MCBhbmQgdjUuMTEgc3RhYmxlIGtlcm5lbHMsCj4gPiA+ID4gc2luY2UgdGhlIHBhdGNoIHNldCBo
YXMgYmVlbiBiYWNrcG9ydGVkLgo+ID4gPgo+ID4gPiBGWUksIHRoZXJlIGhhcyBiZWVuIGEgcGF0
Y2ggb24gdGhlIGxpc3QgdGhhdCBzaG91bGQgaGF2ZSBmaXhlZCB0aGlzCj4gPiA+IGZvciBhYm91
dCBhIG1vbnRoOgo+ID4gPgo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21t
dS8yMDIxMDUxMDA5MTgxNi5HQTIwODRAbHN0LmRlL1QvI20wZDBkZjY0OTAzNTBhMDhkY2MyNGM5
MDg2YzhlZGMxNjViNDAyZDZmCj4gPiA+Cj4gPiA+IGJ1dCBpdCBzZWVtcyBsaWtlIGl0IG5ldmVy
IGdvdCBwaWNrZWQgdXAuCj4gPgo+ID4gSmlhbnhpb25nLAo+ID4gV291bGQgeW91IGJlIHVwIGZv
ciB0ZXN0aW5nIHRoaXMgcGF0Y2ggb24geW91ciBOVk1lIHJpZyBwbGVhc2U/IEkgZG9uJ3QKPiA+
IGZvcnNlZSBhIHByb2JsZW0uLiBidXQganVzdCBpbiBjYXNlCj4gPgo+IEkgaGF2ZSB0ZXN0ZWQg
dGhlIGF0dGFjaGVkIHBhdGNoIGFuZCBpdCBnZW5lcmF0ZXMgYW4gZXJyb3Igd2hlbgo+IGZvcm1h
dHRpbmcgYSBkaXNrIHRvIHhmcyBmb3JtYXQgaW4gUmhlbCA4IGVudmlyb25tZW50OgoKVGhhbmsg
eW91IGZvciB0ZXN0aW5nIHRoYXQgLSBhbmQgdGhpcyBpcyBhIGJ1bW1lciBpbmRlZWQuCgpKaWFu
eGlvbmcsCkhvdyB1bmlxdWUgaXMgdGhpcyBOVk1lPyBTaG91bGQgSSBiZSBhYmxlIHRvIHJlcHJv
ZHVjZSB0aGlzIHdpdGggYW55CnR5cGUgb3IgaXMgaXQgc3BlY2lmaWMgdG8gR29vZ2xlIENsb3Vk
PwoKRG9taW5pcXVlLCBIb3JpYSwKCkFyZSB0aG9zZSBjcnlwdG8gZGV2aWNlcyBzb21laG93IGVh
c2lseSBhdmFpbGFibGUgdG8gdGVzdCBvdXQgdGhlCnBhdGNoZXM/CgpQLlMuCk1vc3QgdW5mb3J0
dW5hdGUgdGltaW5nIC0gSSBhbSBvdXQgaW4gcnVyYWwgYXJlYXMgaW4gVVMgd2l0aCBub3QgZ3Jl
YXQKSW50ZXJuZXQsIHNvIHdvbid0IGJlIGFibGUgdG8gZ2V0IGZ1bGx5IGRvd24gdG8gdGhpcyB1
bnRpbCBNb25kYXkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
