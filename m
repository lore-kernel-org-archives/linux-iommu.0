Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB14C433E2
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 07:28:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28478206F0
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 07:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28478206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DBB6785691;
	Mon, 31 Aug 2020 07:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uQrPpcODXQmC; Mon, 31 Aug 2020 07:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3C60B85640;
	Mon, 31 Aug 2020 07:28:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3CEC0052;
	Mon, 31 Aug 2020 07:28:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B8CCC0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 71D2185691
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPx5NP4WOxi2 for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 07:27:57 +0000 (UTC)
X-Greylist: delayed 00:08:00 by SQLgrey-1.7.6
Received: from smtpout1.mo804.mail-out.ovh.net
 (smtpout1.mo804.mail-out.ovh.net [79.137.123.220])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E090685640
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 07:27:56 +0000 (UTC)
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.109])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 22A425C3E15E;
 Mon, 31 Aug 2020 09:19:51 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 31 Aug
 2020 09:19:50 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0048ffa53fc-3ec1-4d58-9d47-755bfa5a545f,
 2EE828B6C747801E22191638F8886DA5C8443DB5) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 5/5] powerpc: use the generic dma_ops_bypass mode
To: Christoph Hellwig <hch@lst.de>
References: <20200708152449.316476-1-hch@lst.de>
 <20200708152449.316476-6-hch@lst.de>
 <505bcc1d-01a7-9655-88e1-ebddd0b94d56@kaod.org>
 <20200831064038.GB27617@lst.de>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9492229c-c6ea-6fd2-0424-f82fd259e7d8@kaod.org>
Date: Mon, 31 Aug 2020 09:19:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831064038.GB27617@lst.de>
Content-Language: en-US
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: cbc152a6-6b20-466e-80d8-dab2c3638054
X-Ovh-Tracer-Id: 11859948143990049665
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggv
Cc: linuxppc-dev@lists.ozlabs.org, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <brouer@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, aacraid@microsemi.com,
 Robin Murphy <robin.murphy@arm.com>
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

T24gOC8zMS8yMCA4OjQwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBTdW4sIEF1
ZyAzMCwgMjAyMCBhdCAxMTowNDoyMUFNICswMjAwLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToK
Pj4gSGVsbG8sCj4+Cj4+IE9uIDcvOC8yMCA1OjI0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPj4+IFVzZSB0aGUgRE1BIEFQSSBieXBhc3MgbWVjaGFuaXNtIGZvciBkaXJlY3Qgd2luZG93
IG1hcHBpbmdzLiAgVGhpcyB1c2VzCj4+PiBjb21tb24gY29kZSBhbmQgc3BlZWQgdXAgdGhlIGRp
cmVjdCBtYXBwaW5nIGNhc2UgYnkgYXZvaWRpbmcgaW5kaXJlY3QKPj4+IGNhbGxzIGp1c3Qgd2hl
biBub3QgdXNpbmcgZG1hIG9wcyBhdCBhbGwuICBJdCBhbHNvIGZpeGVzIGEgcHJvYmxlbSB3aGVy
ZQo+Pj4gdGhlIHN5bmNfKiBtZXRob2RzIHdlcmUgdXNpbmcgdGhlIGJ5cGFzcyBjaGVjayBmb3Ig
RE1BIGFsbG9jYXRpb25zLCBidXQKPj4+IHRob3NlIGFyZSBwYXJ0IG9mIHRoZSBzdHJlYW1pbmcg
b3BzLgo+Pj4KPj4+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIGxvc2VzIHRoZSBETUFfQVRUUl9XRUFL
X09SREVSSU5HIG92ZXJyaWRlLCB3aGljaAo+Pj4gaGFzIG5ldmVyIGJlZW4gd2VsbCBkZWZpbmVk
LCBhcyBpcyBvbmx5IHVzZWQgYnkgYSBmZXcgZHJpdmVycywgd2hpY2gKPj4+IElJUkMgbmV2ZXIg
c2hvd2VkIHVwIGluIHRoZSB0eXBpY2FsIENlbGwgYmxhZGUgc2V0dXBzIHRoYXQgYXJlIGFmZmVj
dGVkCj4+PiBieSB0aGUgb3JkZXJpbmcgd29ya2Fyb3VuZC4KPj4+Cj4+PiBGaXhlczogZWZkMTc2
YTA0YmVmICgicG93ZXJwYy9wc2VyaWVzL2RtYTogQWxsb3cgU1dJT1RMQiIpCj4+PiBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPj4+IC0tLQo+Pj4gIGFyY2gv
cG93ZXJwYy9LY29uZmlnICAgICAgICAgICAgICB8ICAxICsKPj4+ICBhcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vZGV2aWNlLmggfCAgNSAtLQo+Pj4gIGFyY2gvcG93ZXJwYy9rZXJuZWwvZG1hLWlv
bW11LmMgICB8IDkwICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDg2IGRlbGV0aW9ucygtKQo+Pgo+PiBJIGFtIHNl
ZWluZyBjb3JydXB0aW9ucyBvbiBhIGNvdXBsZSBvZiBQT1dFUjkgc3lzdGVtcyAoYm9zdG9uKSB3
aGVuCj4+IHN0cmVzc2VkIHdpdGggSU8uIHN0cmVzcy1uZyBnaXZlcyBzb21lIHJlc3VsdHMgYnV0
IEkgaGF2ZSBmaXJzdCBzZWVuCj4+IGl0IHdoZW4gY29tcGlsaW5nIHRoZSBrZXJuZWwgaW4gYSBn
dWVzdCBhbmQgdGhpcyBpcyBzdGlsbCB0aGUgYmVzdCB3YXkKPj4gdG8gcmFpc2UgdGhlIGlzc3Vl
Lgo+Pgo+PiBUaGVzZSBzeXN0ZW1zIGhhdmUgb2YgYSBTQVMgQWRhcHRlYyBjb250cm9sbGVyIDoK
Pj4KPj4gICAwMDAzOjAxOjAwLjAgU2VyaWFsIEF0dGFjaGVkIFNDU0kgY29udHJvbGxlcjogQWRh
cHRlYyBTZXJpZXMgOCAxMkcgU0FTL1BDSWUgMyAocmV2IDAxKQo+Pgo+PiBXaGVuIHRoZSBmYWls
dXJlIG9jY3VycywgdGhlIFBPV0VSUEMgRUVIIGludGVycnVwdCBmaXJlcyBhbmQgZHVtcHMKPj4g
bG93bGV2ZWwgUEhCNCByZWdpc3RlcnMgYW1vbmcgd2hpY2ggOgo+PiAJCQkJCSAgCj4+ICAgWyAy
MTc5LjI1MTA2OTQ5MCwzXSBQSEIjMDAwM1swOjNdOiAgICAgICAgICAgcGhiRXJyb3JTdGF0dXMg
PSAwMDAwMDI4MDAwMDAwMDAwCj4+ICAgWyAyMTc5LjI1MTExNzQ3NiwzXSBQSEIjMDAwM1swOjNd
OiAgICAgIHBoYkZpcnN0RXJyb3JTdGF0dXMgPSAwMDAwMDIwMDAwMDAwMDAwCj4+Cj4+IFRoZSBi
aXRzIHJhaXNlZCBpZGVudGlmeSBhIFBQQyAnVENFJyBlcnJvciwgd2hpY2ggbWVhbnMgaXQgaXMg
cmVsYXRlZAo+PiB0byBETUFzLiBTZWUgYmVsb3cgZm9yIG1vcmUgZGV0YWlscy4KPj4KPj4KPj4g
UmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggImZpeGVzIiB0aGUgaXNzdWUgYnV0IGl0IGlzIHByb2JhYmx5
IGVsc2Ugd2hlcmUsCj4+IGluIHNvbWUgb3RoZXIgbGF5ZXJzIG9yIGluIHRoZSBhYWNyYWlkIGRy
aXZlci4gSG93IHNob3VsZCBJIHByb2NlZWQgCj4+IHRvIGdldCBtb3JlIGluZm9ybWF0aW9uID8K
PiAKPiBUaGUgYWFjcmFpZCBETUEgbWFza3MgbG9vayBsaWtlIGEgbWVzcy4gIENhbiB5b3UgdHJ5
IHRoZSBoYWNrCj4gYmVsb3cgYW5kIHNlZSBpdCBpdCBoZWxwcz8KCk5vIGVmZmVjdC4gVGhlIHN5
c3RlbSBjcmFzaGVzIHRoZSBzYW1lLiBCdXQgQWxleGV5IHNwb3R0ZWQgc29tZSBpc3N1ZSAKd2l0
aCBzd2lvdGxiLgoKQy4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
