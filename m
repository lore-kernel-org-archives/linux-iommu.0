Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E779FC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 09:37:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642D864E85
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 09:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642D864E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 24DCC86F21;
	Tue,  9 Feb 2021 09:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Of2BfSo96xee; Tue,  9 Feb 2021 09:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 84B8481BB9;
	Tue,  9 Feb 2021 09:37:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B086C0891;
	Tue,  9 Feb 2021 09:37:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65ADAC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 09:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 554BD87371
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 09:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vqXN0+PpQ615 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BE047872B2
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 09:37:48 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E804D64E27;
 Tue,  9 Feb 2021 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612863468;
 bh=3uhgNxvkQ3DE4szNXNrRNOmM42w+TvFbEvvc39Kp9o8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dnM8UoIu7vjUquwOGgLNI/nFIs7c5cxhJzUlDrEgEcxaM71P1VbXUNr75slYvIvip
 JxniosSVimGPVVpFt1UW4dNP6DywhSeOr4E8K+/y/jp/U1BlN9NKoE4b81YZyYVsS4
 TOZQ8fJ6UIH5YGUd0osrd5uxargdhmbZrAwT4234=
Date: Tue, 9 Feb 2021 10:37:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <YCJX6QFQ4hsNRrFj@kroah.com>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
 <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 zhangfei.gao@linaro.org, Andrew Morton <akpm@linux-foundation.org>,
 liguozhu@hisilicon.com, linux-arm-kernel@lists.infradead.org
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

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDU6MTc6NDZQTSArMDgwMCwgWmhvdSBXYW5nIHdyb3Rl
Ogo+IE9uIDIwMjEvMi84IDY6MDIsIEFuZHkgTHV0b21pcnNraSB3cm90ZToKPiA+IAo+ID4gCj4g
Pj4gT24gRmViIDcsIDIwMjEsIGF0IDEyOjMxIEFNLCBaaG91IFdhbmcgPHdhbmd6aG91MUBoaXNp
bGljb24uY29tPiB3cm90ZToKPiA+Pgo+ID4+IO+7v1NWQShzaGFyZSB2aXJ0dWFsIGFkZHJlc3Mp
IG9mZmVycyBhIHdheSBmb3IgZGV2aWNlIHRvIHNoYXJlIHByb2Nlc3MgdmlydHVhbAo+ID4+IGFk
ZHJlc3Mgc3BhY2Ugc2FmZWx5LCB3aGljaCBtYWtlcyBtb3JlIGNvbnZlbmllbnQgZm9yIHVzZXIg
c3BhY2UgZGV2aWNlCj4gPj4gZHJpdmVyIGNvZGluZy4gSG93ZXZlciwgSU8gcGFnZSBmYXVsdHMg
bWF5IGhhcHBlbiB3aGVuIGRvaW5nIERNQQo+ID4+IG9wZXJhdGlvbnMuIEFzIHRoZSBsYXRlbmN5
IG9mIElPIHBhZ2UgZmF1bHQgaXMgcmVsYXRpdmVseSBiaWcsIERNQQo+ID4+IHBlcmZvcm1hbmNl
IHdpbGwgYmUgYWZmZWN0ZWQgc2V2ZXJlbHkgd2hlbiB0aGVyZSBhcmUgSU8gcGFnZSBmYXVsdHMu
Cj4gPj4gRnJvbSBhIGxvbmcgdGVybSB2aWV3LCBETUEgcGVyZm9ybWFuY2Ugd2lsbCBiZSBub3Qg
c3RhYmxlLgo+ID4+Cj4gPj4gSW4gaGlnaC1wZXJmb3JtYW5jZSBJL08gY2FzZXMsIGFjY2VsZXJh
dG9ycyBtaWdodCB3YW50IHRvIHBlcmZvcm0KPiA+PiBJL08gb24gYSBtZW1vcnkgd2l0aG91dCBJ
TyBwYWdlIGZhdWx0cyB3aGljaCBjYW4gcmVzdWx0IGluIGRyYW1hdGljYWxseQo+ID4+IGluY3Jl
YXNlZCBsYXRlbmN5LiBDdXJyZW50IG1lbW9yeSByZWxhdGVkIEFQSXMgY291bGQgbm90IGFjaGll
dmUgdGhpcwo+ID4+IHJlcXVpcmVtZW50LCBlLmcuIG1sb2NrIGNhbiBvbmx5IGF2b2lkIG1lbW9y
eSB0byBzd2FwIHRvIGJhY2t1cCBkZXZpY2UsCj4gPj4gcGFnZSBtaWdyYXRpb24gY2FuIHN0aWxs
IHRyaWdnZXIgSU8gcGFnZSBmYXVsdC4KPiA+Pgo+ID4+IFZhcmlvdXMgZHJpdmVycyB3b3JraW5n
IHVuZGVyIHRyYWRpdGlvbmFsIG5vbi1TVkEgbW9kZSBhcmUgdXNpbmcKPiA+PiB0aGVpciBvd24g
c3BlY2lmaWMgaW9jdGwgdG8gZG8gcGluLiBTdWNoIGlvY3RsIGNhbiBiZSBzZWVuIGluIHY0bDIs
Cj4gPj4gZ3B1LCBpbmZpbmliYW5kLCBtZWRpYSwgdmZpbywgZXRjLiBEcml2ZXJzIGFyZSB1c3Vh
bGx5IGRvaW5nIGRtYQo+ID4+IG1hcHBpbmcgd2hpbGUgZG9pbmcgcGluLgo+ID4+Cj4gPj4gQnV0
LCBpbiBTVkEgbW9kZSwgcGluIGNvdWxkIGJlIGEgY29tbW9uIG5lZWQgd2hpY2ggaXNuJ3QgbmVj
ZXNzYXJpbHkKPiA+PiBib3VuZCB3aXRoIGFueSBkcml2ZXJzLCBhbmQgbmVpdGhlciBpcyBkbWEg
bWFwcGluZyBuZWVkZWQgYnkgZHJpdmVycwo+ID4+IHNpbmNlIGRldmljZXMgYXJlIHVzaW5nIHRo
ZSB2aXJ0dWFsIGFkZHJlc3Mgb2YgQ1BVLiBUaHVzLCBJdCBpcyBiZXR0ZXIKPiA+PiB0byBpbnRy
b2R1Y2UgYSBuZXcgY29tbW9uIHN5c2NhbGwgZm9yIGl0Lgo+ID4+Cj4gPj4gVGhpcyBwYXRjaCBs
ZXZlcmFnZXMgdGhlIGRlc2lnbiBvZiB1c2VyZmF1bHRmZCBhbmQgYWRkcyBtZW1waW5mZCBmb3Ig
cGluCj4gPj4gdG8gYXZvaWQgbWVzc2luZyB1cCBtbV9zdHJ1Y3QuIEEgZmQgd2lsbCBiZSBnb3Qg
YnkgbWVtcGluZmQsIHRoZW4gdXNlcgo+ID4+IHNwYWNlIGNhbiBkbyBwaW4vdW5waW4gcGFnZXMg
YnkgaW9jdGxzIG9mIHRoaXMgZmQsIGFsbCBwaW5uZWQgcGFnZXMgdW5kZXIKPiA+PiBvbmUgZmls
ZSB3aWxsIGJlIHVucGlubmVkIGluIGZpbGUgcmVsZWFzZSBwcm9jZXNzLiBMaWtlIHBpbiBwYWdl
IGNhc2VzIGluCj4gPj4gb3RoZXIgcGxhY2VzLCBjYW5fZG9fbWxvY2sgaXMgdXNlZCB0byBjaGVj
ayBwZXJtaXNzaW9uIGFuZCBpbnB1dAo+ID4+IHBhcmFtZXRlcnMuCj4gPiAKPiA+IAo+ID4gQ2Fu
IHlvdSBkb2N1bWVudCB3aGF0IHRoZSBzeXNjYWxsIGRvZXM/Cj4gCj4gV2lsbCBhZGQgcmVsYXRl
ZCBkb2N1bWVudCBpbiBEb2N1bWVudGF0aW9uL3ZtLgoKQSBtYW5wYWdlIGlzIGFsd2F5cyBnb29k
LCBhbmQgd2lsbCBiZSByZXF1aXJlZCBldmVudHVhbGx5IDopCgp0aGFua3MsCgpncmVnIGstaApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
