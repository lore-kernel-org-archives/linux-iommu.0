Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ACC433DF
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 23:19:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240B1207D5
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 23:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWVCuuhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240B1207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFCF386D81;
	Fri,  5 Jun 2020 23:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m+vdD6jF4SXK; Fri,  5 Jun 2020 23:19:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 456738683A;
	Fri,  5 Jun 2020 23:19:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A59AC0888;
	Fri,  5 Jun 2020 23:19:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1D07C016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 23:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC65525AB8
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 23:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ur5IizjfeQwH for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 23:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id A8ADF258C4
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 23:19:12 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1CC7207D0;
 Fri,  5 Jun 2020 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591399152;
 bh=pxsClvnIPBaS8ODkk62CMx4DJx6gcP1jIo9ANMgure4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=cWVCuuhZEXopJ/fy8/HaCu7gj+qdiUHK7yyWdnF7I+g00606Q27D/lHhs2F+KUUbI
 qPalWOJ7gwNYAzD0Zb2lhQotEE4HBkdYrzhA669gi2oRrAkyKg2JRbaRxC86n+xjd9
 CZzarVVqj34lwCRUNnhR0Wkc6VA4FmF+zD+p5VbA=
Date: Fri, 5 Jun 2020 18:19:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200605231909.GA1155454@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
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

T24gVGh1LCBKdW4gMDQsIDIwMjAgYXQgMDk6MzM6MDdQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IE9uIDIwMjAvNi8yIOS4iuWNiDE6NDEsIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gPiBP
biBUaHUsIE1heSAyOCwgMjAyMCBhdCAwOTozMzo0NEFNICswMjAwLCBKb2VyZyBSb2VkZWwgd3Jv
dGU6Cj4gPiA+IE9uIFdlZCwgTWF5IDI3LCAyMDIwIGF0IDAxOjE4OjQyUE0gLTA1MDAsIEJqb3Ju
IEhlbGdhYXMgd3JvdGU6Cj4gPiA+ID4gSXMgdGhpcyBzbG93ZG93biBzaWduaWZpY2FudD8gIFdl
IGFscmVhZHkgaXRlcmF0ZSBvdmVyIGV2ZXJ5IGRldmljZQo+ID4gPiA+IHdoZW4gYXBwbHlpbmcg
UENJX0ZJWFVQX0ZJTkFMIHF1aXJrcywgc28gaWYgd2UgdXNlZCB0aGUgZXhpc3RpbmcKPiA+ID4g
PiBQQ0lfRklYVVBfRklOQUwsIHdlIHdvdWxkbid0IGJlIGFkZGluZyBhIG5ldyBsb29wLiAgV2Ug
d291bGQgb25seSBiZQo+ID4gPiA+IGFkZGluZyB0d28gbW9yZSBpdGVyYXRpb25zIHRvIHRoZSBs
b29wIGluIHBjaV9kb19maXh1cHMoKSB0aGF0IHRyaWVzCj4gPiA+ID4gdG8gbWF0Y2ggcXVpcmtz
IGFnYWluc3QgdGhlIGN1cnJlbnQgZGV2aWNlLiAgSSBkb3VidCB0aGF0IHdvdWxkIGJlIGEKPiA+
ID4gPiBtZWFzdXJhYmxlIHNsb3dkb3duLgo+ID4gPiBJIGRvbid0IGtub3cgaG93IHNpZ25pZmlj
YW50IGl0IGlzLCBidXQgSSByZW1lbWJlciBwZW9wbGUgY29tcGxhaW5pbmcKPiA+ID4gYWJvdXQg
YWRkaW5nIG5ldyBQQ0kgcXVpcmtzIGJlY2F1c2UgaXQgdGFrZXMgdG9vIGxvbmcgZm9yIHRoZW0g
dG8gcnVuCj4gPiA+IHRoZW0gYWxsLiBUaGF0IHdhcyBpbiB0aGUgZGlzY3Vzc2lvbiBhYm91dCB0
aGUgcXVpcmsgZGlzYWJsaW5nIEFUUyBvbgo+ID4gPiBBTUQgU3RvbmV5IHN5c3RlbXMuCj4gPiA+
IAo+ID4gPiBTbyBpdCBwcm9iYWJseSBkZXBlbmRzIG9uIGhvdyBtYW55IFBDSSBkZXZpY2VzIGFy
ZSBpbiB0aGUgc3lzdGVtIHdoZXRoZXIKPiA+ID4gaXQgY2F1c2VzIGFueSBtZWFzdXJlYWJsZSBz
bG93ZG93bi4KPiA+IEkgZm91bmQgdGhpcyBbMV0gZnJvbSBQYXVsIE1lbnplbCwgd2hpY2ggd2Fz
IGEgc2xvd2Rvd24gY2F1c2VkIGJ5Cj4gPiBxdWlya191c2JfZWFybHlfaGFuZG9mZigpLiAgSSB0
aGluayB0aGUgcmVhbCBwcm9ibGVtIGlzIGluZGl2aWR1YWwKPiA+IHF1aXJrcyB0aGF0IHRha2Ug
YSBsb25nIHRpbWUuCj4gPiAKPiA+IFRoZSBQQ0lfRklYVVBfSU9NTVUgdGhpbmdzIHdlJ3JlIHRh
bGtpbmcgYWJvdXQgc2hvdWxkIGJlIGZhc3QsIGFuZCBvZgo+ID4gY291cnNlLCB0aGV5J3JlIG9u
bHkgcnVuIGZvciBtYXRjaGluZyBkZXZpY2VzIGFueXdheS4gIFNvIEknZCByYXRoZXIKPiA+IGtl
ZXAgdGhlbSBhcyBQQ0lfRklYVVBfRklOQUwgdGhhbiBhZGQgYSB3aG9sZSBuZXcgcGhhc2UuCj4g
PiAKPiBUaGFua3MgQmpvcm4gZm9yIHRha2luZyB0aW1lIGZvciB0aGlzLgo+IElmIHNvLCBpdCB3
b3VsZCBiZSBtdWNoIHNpbXBsZXIuCj4gCj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4g
QEAgLTI0MTgsNiArMjQxOCwxMCBAQCBpbnQgaW9tbXVfZndzcGVjX2luaXQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QKPiBmd25vZGVfaGFuZGxlICppb21tdV9md25vZGUsCj4gwqDCoMKgwqDC
oMKgwqAgZndzcGVjLT5pb21tdV9md25vZGUgPSBpb21tdV9md25vZGU7Cj4gwqDCoMKgwqDCoMKg
wqAgZndzcGVjLT5vcHMgPSBvcHM7Cj4gwqDCoMKgwqDCoMKgwqAgZGV2X2lvbW11X2Z3c3BlY19z
ZXQoZGV2LCBmd3NwZWMpOwo+ICsKPiArwqDCoMKgwqDCoMKgIGlmIChkZXZfaXNfcGNpKGRldikp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX2ZpeHVwX2RldmljZShwY2lfZml4
dXBfZmluYWwsIHRvX3BjaV9kZXYoZGV2KSk7Cj4gKwo+IAo+IFRoZW4gcGNpX2ZpeHVwX2ZpbmFs
IHdpbGwgYmUgY2FsbGVkIHR3aWNlLCB0aGUgZmlyc3QgaW4gcGNpX2J1c19hZGRfZGV2aWNlLgo+
IEhlcmUgaW4gaW9tbXVfZndzcGVjX2luaXQgaXMgdGhlIHNlY29uZCB0aW1lLCBzcGVjaWZpY2Fs
bHkgZm9yIGlvbW11X2Z3c3BlYy4KPiBXaWxsIHNlbmQgdGhpcyB3aGVuIDUuOC1yYzEgaXMgb3Bl
bi4KCldhaXQsIHRoaXMgd2hvbGUgZml4dXAgYXBwcm9hY2ggc2VlbXMgd3JvbmcgdG8gbWUuICBO
byBtYXR0ZXIgaG93IHlvdQpkbyB0aGUgZml4dXAsIGl0J3Mgc3RpbGwgYSBmaXh1cCwgd2hpY2gg
bWVhbnMgaXQgcmVxdWlyZXMgb25nb2luZwptYWludGVuYW5jZS4gIFN1cmVseSB3ZSBkb24ndCB3
YW50IHRvIGhhdmUgdG8gYWRkIHRoZSBWZW5kb3IvRGV2aWNlIElECmZvciBldmVyeSBuZXcgQU1C
QSBkZXZpY2UgdGhhdCBjb21lcyBhbG9uZywgZG8gd2U/CgpCam9ybgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
