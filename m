Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C8C433E0
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 13:15:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDF120760
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 13:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="SmB/X2pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDF120760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4AFC487F18;
	Thu, 16 Jul 2020 13:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85gZd6h3FD5n; Thu, 16 Jul 2020 13:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C03A387D71;
	Thu, 16 Jul 2020 13:15:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA307C0893;
	Thu, 16 Jul 2020 13:15:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF0C0C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 13:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4CAD88BD4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 13:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7irxSIVN-Bye for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 13:15:13 +0000 (UTC)
X-Greylist: delayed 00:17:46 by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4902D88B87
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 13:15:13 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id q17so3668016pfu.8
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a2Z0NyBzSRfYPlTqQi5HC5Y/ZVbqT0rGo94ALPxovzk=;
 b=SmB/X2ptMLN6Gh28Aa1yG24xaAVEeCpLhMr2iyuzGOTVrugnhWM1xvD/ugry/VvPZt
 eBJSCTqtYpRYDYKlyF0KkdJlKNyIHywxoSLf9LaVEOWbumxa9Ayj4KTIA4wITulEZvYS
 wK3OQIn4XaNcDh0xP9KeVgHZ9jML6mGH1D3miOz/z7jtGjeNt/bWPaedkA9eLFDSsuTM
 NbfcGz++6PL52tLhylCYVajWFt0Jk+ji1XeXbCEWf5RQA1mpFJQVJ9eKWLFLiWrHeuDS
 PBDgUPTKzqLHwgjSJcl5TV6y++HVe2Xnan9bKzstyoDqZSS0Gj7zl3Y+2mcu1NQYj8d2
 kHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a2Z0NyBzSRfYPlTqQi5HC5Y/ZVbqT0rGo94ALPxovzk=;
 b=FrhwErAH8NwI9hs9UNh5tcwVFqTeFV7Fh8jtAF1EQK8BA4D1+dW3i/UDAJPdRujPtN
 h6PhT4a0TZjWwtI3X4zRMIurbBPefddH7URGc/ereMTjMBhK3+usjvmBr+sRmi3Db38J
 bQ7bwaUAIsRw6xmUhIi9AwTIHPUS0mKmBdwu2SDaL116Qu906VOlUeS1/t3ejFF+uQzV
 XcrEaC9ndcIGdEoZ5yk/vErKXVBXMt/DF06DjZPOr5tyk919EW18uakoRB9coxJHrF5k
 5Kv+KhNOKYGrKWQASty8hPhPfAycuQCK/ffAyrbJ+wJ3IGORgDfMZnqsPzIABG4yCg7b
 3lrA==
X-Gm-Message-State: AOAM530NijFdQ+VwBrX7zRIz2BRVkQRa1iXpBqu0V0Dnnc8DyTYW0/eN
 vaK2ZSnsLfenexGDymkEgFaolkNAc98oBvjduD9JFEIjw0A=
X-Google-Smtp-Source: ABdhPJxMytH+NnNlQOn18gFigcvdXRMSyJe5kNmIjQVXJv41s/Kb4YrRfwI56uD/iLzp1GAHBqKKWpn7i7KV+arkG7Y=
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr3940006qvf.247.1594903772528; 
 Thu, 16 Jul 2020 05:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200715070649.18733-1-tn@semihalf.com>
 <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
 <20200716120202.GA7485@willie-the-truck>
In-Reply-To: <20200716120202.GA7485@willie-the-truck>
From: Marcin Wojtas <mw@semihalf.com>
Date: Thu, 16 Jul 2020 14:49:21 +0200
Message-ID: <CAPv3WKc5hNhDCjgrX8uuJJm9MRS520QcD1NYTY1LWFHEBqJMfg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
To: =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>
Cc: devicetree@vger.kernel.org, kernel-team@android.com,
 Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org
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

Y3p3LiwgMTYgbGlwIDIwMjAgbyAxNDowMiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPiBu
YXBpc2HFgihhKToKPgo+IE9uIFRodSwgSnVsIDE2LCAyMDIwIGF0IDAxOjAwOjQzUE0gKzAxMDAs
IFdpbGwgRGVhY29uIHdyb3RlOgo+ID4gT24gV2VkLCAxNSBKdWwgMjAyMCAwOTowNjo0NSArMDIw
MCwgVG9tYXN6IE5vd2lja2kgd3JvdGU6Cj4gPiA+IFRoZSBzZXJpZXMgaXMgbWVhbnQgdG8gc3Vw
cG9ydCBTTU1VIGZvciBBUDgwNiBhbmQgYSB3b3JrYXJvdW5kCj4gPiA+IGZvciBhY2Nlc3Npbmcg
QVJNIFNNTVUgNjRiaXQgcmVnaXN0ZXJzIGlzIHRoZSBnaXN0IG9mIGl0Lgo+ID4gPgo+ID4gPiBG
b3IgdGhlIHJlY29yZCwgQVAtODA2IGNhbid0IGFjY2VzcyBTTU1VIHJlZ2lzdGVycyB3aXRoIDY0
Yml0IHdpZHRoLgo+ID4gPiBUaGlzIHBhdGNoZXMgc3BsaXQgdGhlIHJlYWRxL3dyaXRlcSBpbnRv
IHR3byAzMmJpdCBhY2Nlc3NlcyBpbnN0ZWFkCj4gPiA+IGFuZCB1cGRhdGUgRFQgYmluZGluZ3Mu
Cj4gPiA+Cj4gPiA+IFsuLi5dCj4gPgo+ID4gQXBwbGllZCB0byB3aWxsIChmb3Itam9lcmcvYXJt
LXNtbXUvdXBkYXRlcyksIHRoYW5rcyEKPiA+Cj4gPiBbMS8zXSBpb21tdS9hcm0tc21tdTogQ2Fs
bCBjb25maWd1cmF0aW9uIGltcGwgaG9vayBiZWZvcmUgY29uc3VtaW5nIGZlYXR1cmVzCj4gPiAg
ICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3dpbGwvYy82YTc5YTVhMzg0MmIKPiA+IFsyLzNd
IGlvbW11L2FybS1zbW11OiBXb3JrYXJvdW5kIGZvciBNYXJ2ZWxsIEFybWFkYS1BUDgwNiBTb0Mg
ZXJyYXR1bSAjNTgyNzQzCj4gPiAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3dpbGwvYy9m
MmQ5ODQ4YWViOWYKPiA+IFszLzNdIGR0LWJpbmRpbmdzOiBhcm0tc21tdTogYWRkIGNvbXBhdGli
bGUgc3RyaW5nIGZvciBNYXJ2ZWxsIEFybWFkYS1BUDgwNiBTTU1VLTUwMAo+ID4gICAgICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy93aWxsL2MvZTg1ZTg0ZDE5YjlkCj4KPiAobm90ZSB0aGF0IEkg
bGVmdCBwYXRjaCA0IGZvciBhcm0tc29jLCBhcyB0aGF0J3MganVzdCB1cGRhdGluZyAuZHRzIGZp
bGVzKQo+CgpIaSBHcmVnb3J5LAoKQ2FuIHlvdSBwbGVhc2UgaGVscCB3aXRoIHRoZSByZXZpZXcv
bWVyZ2Ugb2YgcGF0Y2ggIzQ/CgpCZXN0IHJlZ2FyZHMsCk1hcmNpbgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
