Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11D2C43217
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 14:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D43D60B77;
	Mon,  7 Mar 2022 14:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K296YmgS40rH; Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B8FA60C1F;
	Mon,  7 Mar 2022 14:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECB05C008E;
	Mon,  7 Mar 2022 14:21:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E135C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E24D9405DF
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=benyossef-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cz-vDnSDCOXU for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 13:13:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A688D40470
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:13:17 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id l2so11320095ybe.8
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 05:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=benyossef-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FTOQLkPABjgFHbcpYh08NxXX3AnkIW8zDVxaxnJ63AA=;
 b=DcLYhdXta5yl8UjuFS/qcxIrxj4lqv9WyXc3/4S1ZfTA8qudVdOqOdtdNpJMh1qdof
 Z5ftjB+ehud2ofGMkDW6hVsPdsxvCOjZ/KA7pgDY12xY9Oigd3KsPHKfESy263khNi7/
 XVKs1s6U/dLC+N61e2D5BZGBGx38mYU78J6V/0KQWEi+JdAieZAqV8rGuOdc22jnqUxZ
 XD0z6sLwo5GMK0UpVzOw9JRI8LRLKdE/xG/nToRr22qZJ+M/LCUp/uWvZi0I1J4P1jdT
 wIKiJNWDrecTVLsOGttHwnSdbKob/edeHZbo6T5d6s517KcS2oA6GUQVQ0KrfyVuJjAy
 FFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FTOQLkPABjgFHbcpYh08NxXX3AnkIW8zDVxaxnJ63AA=;
 b=qRHKyS7l7GziEbQcVT1WrjWCQBP9mFxmgK9XA4ivgv+piokv9+aItTB9sxq09SjS+o
 BD8R5WVjxHQ7Cx62Xcj83Hi1g4jItvz5RRKEkw2EIF7I0I5tOA6dUVg9GeJuhxNYeFLY
 PlfIiImRDizA/WpIpGUlBCWMlZfbWJklZ6sEwMjx6DnYMpvTZVPcSUYd7zwFQjSlPGhN
 gSzbkqTyiGZDCg0/5ZTCTpRqLaleJt6t9wDM6tOh9jMsFKa67A/d9Nk1L3WA7okLCK3M
 A9smFPFnoClJ0z2oZzOhq7qS2FhNtfw1FCZBOybeup6ewWlpGhPAjb5gyA95n9xsOjVE
 rvnQ==
X-Gm-Message-State: AOAM5332gf9mJtczZRcoU/x/qMpMN5xt1N6QWVx7GtMACybb2Gkfh5Hq
 xwHufGz4spPI6i+SIwj4aVrJnV4nkEeVdEGNqvLrjw==
X-Google-Smtp-Source: ABdhPJzwr0HyjzESewd0ZLqGIIXTOlieb/gEYoK49h1Rd5QKtQQsd809tOBlz8U2SyCY5D/c2nGkNyO3lxaUCXyAKDk=
X-Received: by 2002:a25:e0c7:0:b0:629:182a:4b75 with SMTP id
 x190-20020a25e0c7000000b00629182a4b75mr7234257ybg.539.1646658796453; Mon, 07
 Mar 2022 05:13:16 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
 <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
 <CAOtvUMedqSNKx9Aah0R_aAyjKO0pn4K75MrCnbh_zX+Zw9vRQA@mail.gmail.com>
 <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
In-Reply-To: <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 7 Mar 2022 15:13:05 +0200
Message-ID: <CAOtvUMcp8X9Zex9QE3qz5mKVR9MC3kdUymO1oXVdUc=k1NcwXA@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Mon, 07 Mar 2022 14:21:57 +0000
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

T24gTW9uLCBNYXIgNywgMjAyMiBhdCAzOjAzIFBNIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5
QGFybS5jb20+IHdyb3RlOgo+Cj4gT24gMjAyMi0wMy0wNyAxMjo0NywgR2lsYWQgQmVuLVlvc3Nl
ZiB3cm90ZToKPiA+IE9uIE1vbiwgTWFyIDcsIDIwMjIgYXQgMjozNiBQTSBSb2JpbiBNdXJwaHkg
PHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToKPiA+Pgo+ID4+IE9uIDIwMjItMDMtMDcgMTI6
MTcsIEdpbGFkIEJlbi1Zb3NzZWYgd3JvdGU6Cj4gPj4+IE9uIE1vbiwgTWFyIDcsIDIwMjIgYXQg
MToxNCBQTSBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToKPiA+Pj4K
PiA+Pj4+IFRoZSAib3ZlcmxhcCIgaXMgaW4gdGhlIHNlbnNlIG9mIGhhdmluZyBtb3JlIHRoYW4g
b25lIG1hcHBpbmcgd2l0aGluIHRoZQo+ID4+Pj4gc2FtZSBjYWNoZWxpbmU6Cj4gPj4+Pgo+ID4+
Pj4gWyAgMTQyLjQ1ODEyMF0gRE1BLUFQSTogYWRkX2RtYV9lbnRyeSBzdGFydCBQPWJhNzlmMjAw
IE49YmE3OWYKPiA+Pj4+IEQ9YmE3OWYyMDAgTD0xMCBETUFfRlJPTV9ERVZJQ0UgYXR0cnM9MAo+
ID4+Pj4gWyAgMTQyLjQ1ODE1Nl0gRE1BLUFQSTogYWRkX2RtYV9lbnRyeSBzdGFydCBQPTQ0NWRj
MDEwIE49NDQ1ZGMKPiA+Pj4+IEQ9NDQ1ZGMwMTAgTD0xMCBETUFfVE9fREVWSUNFIGF0dHJzPTAK
PiA+Pj4+IFsgIDE0Mi40NTgxNzhdIHN1bjhpLXNzIDFjMTUwMDAuY3J5cHRvOiBTUkMgMC8xLzEg
NDQ1ZGMwMDAgbGVuPTE2IGJpPTAKPiA+Pj4+IFsgIDE0Mi40NTgyMTVdIHN1bjhpLXNzIDFjMTUw
MDAuY3J5cHRvOiBEU1QgMC8xLzEgYmE3OWYyMDAgbGVuPTE2IGJpPTAKPiA+Pj4+IFsgIDE0Mi40
NTgyMzRdIERNQS1BUEk6IGFkZF9kbWFfZW50cnkgc3RhcnQgUD1iYTc5ZjIxMCBOPWJhNzlmCj4g
Pj4+PiBEPWJhNzlmMjEwIEw9MTAgRE1BX0ZST01fREVWSUNFIGF0dHJzPTAKPiA+Pj4+Cj4gPj4+
PiBUaGlzIGFjdHVhbGx5IGlsbHVzdHJhdGVzIGV4YWN0bHkgdGhlIHJlYXNvbiB3aHkgdGhpcyBp
cyB1bnN1cHBvcnRhYmxlLgo+ID4+Pj4gYmE3OWYyMDAgaXMgbWFwcGVkIGZvciBETUFfRlJPTV9E
RVZJQ0UsIHRoZXJlZm9yZSBzdWJzZXF1ZW50bHkgbWFwcGluZwo+ID4+Pj4gYmE3OWYyMTAgZm9y
IERNQV9UT19ERVZJQ0UgbWF5IGNhdXNlIHRoZSBjYWNoZWxpbmUgY292ZXJpbmcgdGhlIHJhbmdl
Cj4gPj4+PiBiYTc5ZjIwMC1iYTc5ZjIzZiB0byBiZSB3cml0dGVuIGJhY2sgb3ZlciB0aGUgdG9w
IG9mIGRhdGEgdGhhdCB0aGUKPiA+Pj4+IGRldmljZSBoYXMgYWxyZWFkeSBzdGFydGVkIHRvIHdy
aXRlIHRvIG1lbW9yeS4gSGVsbG8gZGF0YSBjb3JydXB0aW9uLgo+ID4+Pj4KPiA+Pj4+IFNlcGFy
YXRlIERNQSBtYXBwaW5ncyBzaG91bGQgYmUgZnJvbSBzZXBhcmF0ZSBtZW1vcnkgYWxsb2NhdGlv
bnMsCj4gPj4+PiByZXNwZWN0aW5nIEFSQ0hfRE1BX01JTkFMSUdOLgo+ID4+Pgo+ID4+PiBobW0u
Li4gSSBrbm93IEknbSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLCBidXQgaG93IGRvZXMgdGhpcyBh
bGlnbiB3aXRoCj4gPj4+IHRoZSBmb2xsb3dpbmcgZnJvbSBhY3RpdmVfY2FjaGVsaW5lX2luc2Vy
dCgpIGluIGtlcm5lbC9kbWEvZGVidWcuYyA/Cj4gPj4+Cj4gPj4+ICAgICAgICAgICAvKiBJZiB0
aGUgZGV2aWNlIGlzIG5vdCB3cml0aW5nIG1lbW9yeSB0aGVuIHdlIGRvbid0IGhhdmUgYW55Cj4g
Pj4+ICAgICAgICAgICAgKiBjb25jZXJucyBhYm91dCB0aGUgY3B1IGNvbnN1bWluZyBzdGFsZSBk
YXRhLiAgVGhpcyBtaXRpZ2F0ZXMKPiA+Pj4gICAgICAgICAgICAqIGxlZ2l0aW1hdGUgdXNhZ2Vz
IG9mIG92ZXJsYXBwaW5nIG1hcHBpbmdzLgo+ID4+PiAgICAgICAgICAgICovCj4gPj4+ICAgICAg
ICAgICBpZiAoZW50cnktPmRpcmVjdGlvbiA9PSBETUFfVE9fREVWSUNFKQo+ID4+PiAgICAgICAg
ICAgICAgICAgICByZXR1cm4gMDsKPiA+Pgo+ID4+IEl0J3MgT0sgdG8gaGF2ZSBtdWx0aXBsZSBt
YXBwaW5ncyB0aGF0IGFyZSAqYWxsKiBETUFfVE9fREVWSUNFLCB3aGljaAo+ID4+IGxvb2tzIHRv
IGJlIHRoZSBjYXNlIHRoYXQgdGhpcyBjaGVjayB3YXMgaW50ZW5kZWQgdG8gYWxsb3cuIEhvd2V2
ZXIgSQo+ID4+IHRoaW5rIHlvdSdyZSByaWdodCB0aGF0IGl0IHNob3VsZCBzdGlsbCBhY3R1YWxs
eSBjaGVjayBmb3IgY29uZmxpY3RpbmcKPiA+PiBkaXJlY3Rpb25zIGJldHdlZW4gdGhlIG5ldyBl
bnRyeSBhbmQgYW55IGV4aXN0aW5nIG9uZXMsIG90aGVyd2lzZSBpdAo+ID4+IGVuZHMgdXAgYSBi
aXQgdG9vIGxlbmllbnQuCj4gPj4KPiA+PiBDaGVlcnMsCj4gPj4gUm9iaW4uCj4gPgo+ID4gSSB1
bmRlcnN0YW5kIHdoYXQgeW91IGFyZSBzYXlpbmcgYWJvdXQgd2h5IGNoZWNraW5nIGZvciBjb25m
bGljdGluZwo+ID4gZGlyZWN0aW9ucyBtYXkgYmUgYSBnb29kIHRoaW5nLCBidXQgZ2l2ZW4gdGhh
dCB0aGUgY29kZSBpcyBhcyBpdCBpcwo+ID4gcmlnaHQgbm93LCBob3cgYXJlIHdlIHNlZWluZyB0
aGUgd2FybmluZyBmb3IgdHdvIG1hcHBpbmcgdGhhdCBvbmUgb2YKPiA+IHRoZW0gaXMgRE1BX1RP
X0RFVklDRT8KPgo+IEJlY2F1c2UgaXQncyB0aGUgc2Vjb25kIG9uZSB0aGF0IGlzbid0LiBUaGUg
d2FybmluZyBpcyB0cmlnZ2VyZWQgYnkKPiBhZGRpbmcgdGhlIERNQV9GUk9NX0RFVklDRSBlbnRy
eSwgd2hpY2ggKmlzKiBjaGVja2VkLCBhbmQgZmluZHMgdGhlCj4gRE1BX1RPX0RFVklDRSBlbnRy
eSBhbHJlYWR5IHByZXNlbnQuIFdoYXQncyBub3QgZ3JlYXQgaXMgdGhhdCBpZiB0aG9zZQo+IHR3
byBtYXBwaW5ncyBoYXBwZW5lZCB0byBiZSBtYWRlIGluIHRoZSBvcHBvc2l0ZSBvcmRlciB0aGVu
IGl0IHdvdWxkIGJlCj4gbWlzc2VkIGVudGlyZWx5LgoKUGxlYXNlIGFjY2VwdCBteSBzaW5jZXJl
IGFwb2xvZ2llcyBpZiBJJ20gYmVpbmcgZGFmdCAsIGJ1dCBoZXJlIGlzIHRoZQpjb2RlIGZvciBh
ZGRfZG1hX2VudHJ5KCk6CgpzdGF0aWMgdm9pZCBhZGRfZG1hX2VudHJ5KHN0cnVjdCBkbWFfZGVi
dWdfZW50cnkgKmVudHJ5LCB1bnNpZ25lZCBsb25nIGF0dHJzKQp7CiAgICAgICAgc3RydWN0IGhh
c2hfYnVja2V0ICpidWNrZXQ7CiAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsKICAgICAgICBp
bnQgcmM7CgogICAgICAgIGJ1Y2tldCA9IGdldF9oYXNoX2J1Y2tldChlbnRyeSwgJmZsYWdzKTsK
ICAgICAgICBoYXNoX2J1Y2tldF9hZGQoYnVja2V0LCBlbnRyeSk7CiAgICAgICAgcHV0X2hhc2hf
YnVja2V0KGJ1Y2tldCwgZmxhZ3MpOwoKICAgICAgICByYyA9IGFjdGl2ZV9jYWNoZWxpbmVfaW5z
ZXJ0KGVudHJ5KTsKICAgICAgICBpZiAocmMgPT0gLUVOT01FTSkgewogICAgICAgICAgICAgICAg
cHJfZXJyKCJjYWNoZWxpbmUgdHJhY2tpbmcgRU5PTUVNLCBkbWEtZGVidWcgZGlzYWJsZWRcbiIp
OwogICAgICAgICAgICAgICAgZ2xvYmFsX2Rpc2FibGUgPSB0cnVlOwogICAgICAgIH0gZWxzZSBp
ZiAocmMgPT0gLUVFWElTVCAmJiAhKGF0dHJzICYgRE1BX0FUVFJfU0tJUF9DUFVfU1lOQykpIHsK
ICAgICAgICAgICAgICAgIGVycl9wcmludGsoZW50cnktPmRldiwgZW50cnksCiAgICAgICAgICAg
ICAgICAgICAgICAgICJjYWNoZWxpbmUgdHJhY2tpbmcgRUVYSVNULCBvdmVybGFwcGluZwptYXBw
aW5ncyBhcmVuJ3Qgc3VwcG9ydGVkXG4iKTsKICAgICAgICB9Cn0KCkNsZWFybHkgd2UgZ2V0IHRv
IGFjdGl2ZV9jYWNoZWxpbmVfaW5zZXJ0KCkgdW5jb25kaXRpb25hbGx5LgoKSGVyZSBpcyB0aGUg
Y29kZSBvZiBhY3RpdmVfY2FjaGVsaW5lX2luc2VydCgpOgoKc3RhdGljIGludCBhY3RpdmVfY2Fj
aGVsaW5lX2luc2VydChzdHJ1Y3QgZG1hX2RlYnVnX2VudHJ5ICplbnRyeSkKewogICAgICAgIHBo
eXNfYWRkcl90IGNsbiA9IHRvX2NhY2hlbGluZV9udW1iZXIoZW50cnkpOwogICAgICAgIHVuc2ln
bmVkIGxvbmcgZmxhZ3M7CiAgICAgICAgaW50IHJjOwoKICAgICAgICAvKiBJZiB0aGUgZGV2aWNl
IGlzIG5vdCB3cml0aW5nIG1lbW9yeSB0aGVuIHdlIGRvbid0IGhhdmUgYW55CiAgICAgICAgICog
Y29uY2VybnMgYWJvdXQgdGhlIGNwdSBjb25zdW1pbmcgc3RhbGUgZGF0YS4gIFRoaXMgbWl0aWdh
dGVzCiAgICAgICAgICogbGVnaXRpbWF0ZSB1c2FnZXMgb2Ygb3ZlcmxhcHBpbmcgbWFwcGluZ3Mu
CiAgICAgICAgICovCiAgICAgICAgaWYgKGVudHJ5LT5kaXJlY3Rpb24gPT0gRE1BX1RPX0RFVklD
RSkKICAgICAgICAgICAgICAgIHJldHVybiAwOwoKICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgm
cmFkaXhfbG9jaywgZmxhZ3MpOwogICAgICAgIHJjID0gcmFkaXhfdHJlZV9pbnNlcnQoJmRtYV9h
Y3RpdmVfY2FjaGVsaW5lLCBjbG4sIGVudHJ5KTsKICAgICAgICBpZiAocmMgPT0gLUVFWElTVCkK
ICAgICAgICAgICAgICAgIGFjdGl2ZV9jYWNoZWxpbmVfaW5jX292ZXJsYXAoY2xuKTsKICAgICAg
ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZyYWRpeF9sb2NrLCBmbGFncyk7CgogICAgICAgIHJl
dHVybiByYzsKfQoKQ2xlYXJseSB0aGUgY2hlY2sgZm9yIGRpcmVjdGlvbiBoYXBwZW5zIEJFRk9S
RSB3ZSBldmVyIGF0dGVtcHQgdG8gYWRkCnRoZSBjYWNoZWxpbmUgdHJhY2tpbmcgZGF0YS4KClNv
IGl0IHNob3VsZG4ndCBtYXR0ZXIgYXQgYWxsIHdoaWNoIGlzIGZpcnN0IGFuZCB3aGljaCBpcyBz
ZWNvbmQuLi4gOi0oCgpJIGtub3cgSSdtIG1pc3Npbmcgc29tZXRoaW5nLiBCdXQgd2hhdD8KClRo
YW5rcywKR2lsYWQKCi0tIApHaWxhZCBCZW4tWW9zc2VmCkNoaWVmIENvZmZlZSBEcmlua2VyCgp2
YWx1ZXMgb2YgzrIgd2lsbCBnaXZlIHJpc2UgdG8gZG9tIQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
