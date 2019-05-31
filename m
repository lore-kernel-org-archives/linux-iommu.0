Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2868BC04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 17:05:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049EC26CC5
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 17:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049EC26CC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B7C97182B;
	Fri, 31 May 2019 17:05:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5296F17EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 17:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E39B83A
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 17:03:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 91664ACC4;
	Fri, 31 May 2019 17:03:49 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] Prerequisites for NXP LS104xA SMMU enablement
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
	<d086216f-f3fc-c88a-3891-81e84e8bdb01@suse.de>
	<VI1PR04MB5134BFA391D8FF013762882FEC190@VI1PR04MB5134.eurprd04.prod.outlook.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <19cc3230-33b0-e465-6317-590780b33efa@suse.de>
Date: Fri, 31 May 2019 19:03:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5134BFA391D8FF013762882FEC190@VI1PR04MB5134.eurprd04.prod.outlook.com>
Content-Language: en-US
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Roy Pledge <roy.pledge@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"jocke@infinera.com" <joakim.tjernlund@infinera.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Camelia Alexandra Groza <camelia.groza@nxp.com>,
	Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGVsbG8gTGF1cmVudGl1LAoKQW0gMzEuMDUuMTkgdW0gMTg6NDYgc2NocmllYiBMYXVyZW50aXUg
VHVkb3I6Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEFuZHJlYXMgRsOk
cmJlciA8YWZhZXJiZXJAc3VzZS5kZT4KPj4gU2VudDogRnJpZGF5LCBNYXkgMzEsIDIwMTkgNzox
NSBQTQo+Pgo+PiBIaSBMYXVyZW50aXUsCj4+Cj4+IEFtIDMwLjA1LjE5IHVtIDE2OjE5IHNjaHJp
ZWIgbGF1cmVudGl1LnR1ZG9yQG54cC5jb206Cj4+PiBUaGlzIHBhdGNoIHNlcmllcyBjb250YWlu
cyBzZXZlcmFsIGZpeGVzIGluIHByZXBhcmF0aW9uIGZvciBTTU1VCj4+PiBzdXBwb3J0IG9uIE5Y
UCBMUzEwNDNBIGFuZCBMUzEwNDZBIGNoaXBzLiBPbmNlIHRoZXNlIGdldCBwaWNrZWQgdXAsCj4+
PiBJJ2xsIHN1Ym1pdCB0aGUgYWN0dWFsIFNNTVUgZW5hYmxlbWVudCBwYXRjaGVzIGNvbnNpc3Rp
bmcgaW4gdGhlCj4+PiByZXF1aXJlZCBkZXZpY2UgdHJlZSBjaGFuZ2VzLgo+Pgo+PiBIYXZlIHlv
dSB0aG91Z2h0IHRocm91Z2ggd2hhdCB3aWxsIGhhcHBlbiBpZiB0aGlzIHBhdGNoIG9yZGVyaW5n
IGlzIG5vdAo+PiBwcmVzZXJ2ZWQ/IEluIHBhcnRpY3VsYXIsIGEgdXNlciBpbnN0YWxsaW5nIGEg
ZnV0dXJlIFUtQm9vdCB1cGRhdGUgd2l0aAo+PiB0aGUgRFRCIGJpdHMgYnV0IGJvb3RpbmcgYSBz
dGFibGUga2VybmVsIHdpdGhvdXQgdGhpcyBwYXRjaCBzZXJpZXMgLQo+PiB3b3VsZG4ndCB0aGF0
IHJlZ3Jlc3MgZHBhYSB0aGVuIGZvciBvdXIgY3VzdG9tZXJzPwo+Pgo+IAo+IFRoZXNlIGFyZSBm
aXhlcyBmb3IgaXNzdWVzIHRoYXQgcG9wcGVkIG91dCBhZnRlciBlbmFibGluZyBTTU1VLiAKPiBJ
IGRvIG5vdCBleHBlY3QgdGhlbSB0byBicmVhayBhbnl0aGluZy4KClRoYXQgd2FzIG5vdCBteSBx
dWVzdGlvbiEgWW91J3JlIG1pc3NpbmcgbXkgcG9pbnQ6IEFsbCB5b3VyIHBhdGNoZXMgYXJlCmxh
Y2tpbmcgYSBGaXhlcyBoZWFkZXIgaW4gdGhlaXIgY29tbWl0IG1lc3NhZ2UsIGZvciBiYWNrcG9y
dGluZyB0aGVtLCB0bwphdm9pZCBfeW91ciBEVCBwYXRjaGVzXyBicmVha2luZyB0aGUgZHJpdmVy
IG9uIHN0YWJsZSBicmFuY2hlcyEKClJlZ2FyZHMsCkFuZHJlYXMKCi0tIApTVVNFIExpbnV4IEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQpHRjogRmVsaXggSW1l
bmTDtnJmZmVyLCBNYXJ5IEhpZ2dpbnMsIFNyaSBSYXNpYWgKSFJCIDIxMjg0IChBRyBOw7xybmJl
cmcpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
