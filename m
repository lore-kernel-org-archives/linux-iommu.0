Return-Path: <SRS0=j10w=PY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85122C433EF
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 12:04:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9545161262
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 12:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9545161262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CB086152C;
	Fri,  5 Nov 2021 12:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tO0uf6z-Gbvi; Fri,  5 Nov 2021 12:04:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4796960745;
	Fri,  5 Nov 2021 12:04:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C472C0019;
	Fri,  5 Nov 2021 12:04:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F27AC000E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 12:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75D3C40179
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 12:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id duG7Ln4EB_eL for <iommu@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 12:04:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66BE8401D0
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 12:04:24 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8e7.dynamic.kabel-deutschland.de
 [95.90.232.231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7AEEE61EA191E;
 Fri,  5 Nov 2021 13:04:22 +0100 (CET)
Message-ID: <0f86c80b-aa6b-e1fd-5fda-0a4e4093250d@molgen.mpg.de>
Date: Fri, 5 Nov 2021 13:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)s
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
In-Reply-To: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

RGVhciBMaW51eCBmb2xrcywKCgpBbSAwNS4xMS4yMSB1bSAxMjo1NiBzY2hyaWViIFBhdWwgTWVu
emVsOgoKPiBPbiBhIFBvd2VyRWRnZSBUNDQwLzAyMUtDRCwgQklPUyAyLjExLjIgMDQvMjIvMjAy
MSwgTGludXggNS4xMC43MCB0YWtlcyAKPiBhbG1vc3QgZml2ZSBzZWNvbmRzIHRvIGluaXRpYWxp
emUgUENJLiBBY2NvcmRpbmcgdG8gdGhlIHRpbWVzdGFtcHMsIDEuNSAKPiBzIGFyZSBmcm9tIGFz
c2lnbmluZyB0aGUgUENJIGRldmljZXMgdG8gdGhlIDE0MiBJT01NVSBncm91cHMuCj4gCj4gYGBg
Cj4gJCBsc3BjaSB8IHdjIC1sCj4gMjgxCj4gJCBkbWVzZwo+IFvigKZdCj4gW8KgwqDCoCAyLjkx
ODQxMV0gUENJOiBVc2luZyBob3N0IGJyaWRnZSB3aW5kb3dzIGZyb20gQUNQSTsgaWYgbmVjZXNz
YXJ5LCB1c2UgInBjaT1ub2NycyIgYW5kIHJlcG9ydCBhIGJ1Zwo+IFvCoMKgwqAgMi45MzM4NDFd
IEFDUEk6IEVuYWJsZWQgNSBHUEVzIGluIGJsb2NrIDAwIHRvIDdGCj4gW8KgwqDCoCAyLjk3Mzcz
OV0gQUNQSTogUENJIFJvb3QgQnJpZGdlIFtQQzAwXSAoZG9tYWluIDAwMDAgW2J1cyAwMC0xNl0p
Cj4gW8KgwqDCoCAyLjk4MDM5OF0gYWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBPUyBzdXBwb3J0cyBb
RXh0ZW5kZWRDb25maWcgQVNQTSBDbG9ja1BNIFNlZ21lbnRzIE1TSSBIUFgtVHlwZTNdCj4gW8Kg
wqDCoCAyLjk4OTQ1N10gYWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBwbGF0Zm9ybSBkb2VzIG5vdCBz
dXBwb3J0IFtMVFJdCj4gW8KgwqDCoCAyLjk5NTQ1MV0gYWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBP
UyBub3cgY29udHJvbHMgW1BNRSBQQ0llQ2FwYWJpbGl0eV0KPiBbwqDCoMKgIDMuMDAxMzk0XSBh
Y3BpIFBOUDBBMDg6MDA6IEZBRFQgaW5kaWNhdGVzIEFTUE0gaXMgdW5zdXBwb3J0ZWQsIAo+IHVz
aW5nIEJJT1MgY29uZmlndXJhdGlvbgo+IFvCoMKgwqAgMy4wMTA1MTFdIFBDSSBob3N0IGJyaWRn
ZSB0byBidXMgMDAwMDowMAo+IFvigKZdCj4gW8KgwqDCoCA2LjIzMzUwOF0gc3lzdGVtIDAwOjA1
OiBbaW/CoCAweDEwMDAtMHgxMGZlXSBoYXMgYmVlbiByZXNlcnZlZAo+IFvCoMKgwqAgNi4yMzk0
MjBdIHN5c3RlbSAwMDowNTogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIg
KGFjdGl2ZSkKPiBbwqDCoMKgIDYuMjM5OTA2XSBwbnA6IFBuUCBBQ1BJOiBmb3VuZCA2IGRldmlj
ZXMKPiBb4oCmXQo+IFvCoMKgwqAgNi45ODkwMTZdIHBjaSAwMDAwOmQ3OjA1LjA6IGRpc2FibGVk
IGJvb3QgaW50ZXJydXB0cyBvbiBkZXZpY2UgWzgwODY6MjAzNF0KPiBbwqDCoMKgIDYuOTk2MDYz
XSBQQ0k6IENMUyAwIGJ5dGVzLCBkZWZhdWx0IDY0Cj4gW8KgwqDCoCA3LjAwMDAwOF0gVHJ5aW5n
IHRvIHVucGFjayByb290ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uCj4gW8KgwqDCoCA3LjA2NTI4
MV0gRnJlZWluZyBpbml0cmQgbWVtb3J5OiA1MTM2Swo+IFvigKZdCj4gW8KgwqDCoCA3LjA3OTA5
OF0gRE1BUjogZG1hcjc6IFVzaW5nIFF1ZXVlZCBpbnZhbGlkYXRpb24KPiBbwqDCoMKgIDcuMDgz
OTgzXSBwY2kgMDAwMDowMDowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMAo+IFvigKZdCj4g
W8KgwqDCoCA4LjUzNzgwOF0gcGNpIDAwMDA6ZDc6MTcuMTogQWRkaW5nIHRvIGlvbW11IGdyb3Vw
IDE0MQo+IFvCoMKgwqAgOC41NzExOTFdIERNQVI6IEludGVsKFIpIFZpcnR1YWxpemF0aW9uIFRl
Y2hub2xvZ3kgZm9yIERpcmVjdGVkIEkvTwo+IFvCoMKgwqAgOC41Nzc2MThdIFBDSS1ETUE6IFVz
aW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9yIElPIChTV0lPVExCKQo+IFvigKZdCj4g
YGBgCj4gCj4gSXMgdGhlcmUgYW55dGhpbmcgdGhhdCBjb3VsZCBiZSBkb25lIHRvIHJlZHVjZSB0
aGUgdGltZT8KCkkgY3JlYXRlZCBhbiBpc3N1ZSBhdCB0aGUgS2VybmVsLm9yZyBCdWd6aWxsYSwg
YW5kIGF0dGFjaGVkIHRoZSBvdXRwdXQgCm9mIGBkbWVzZ2AgdGhlcmUgWzFdLgoKCktpbmQgcmVn
YXJkcywKClBhdWwKCgpbMV06IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjE0OTUzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
