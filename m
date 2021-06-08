Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25222C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 08:55:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F9961263
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 08:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9961263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A20340321;
	Tue,  8 Jun 2021 08:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dena47eDhxaq; Tue,  8 Jun 2021 08:55:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5588D40371;
	Tue,  8 Jun 2021 08:55:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B5FDC000D;
	Tue,  8 Jun 2021 08:55:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 496FDC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 08:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D90A4018C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 08:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vy3LoGl3ZLKr for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 08:55:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05FF340109
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 08:55:26 +0000 (UTC)
Received: from [192.168.1.155] ([77.7.0.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MqJZl-1l3PJU3uj5-00nR3j; Tue, 08 Jun 2021 10:55:04 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Wang <jasowang@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
 <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
 <20210604115805.GG1002214@nvidia.com>
 <895671cc-5ef8-bc1a-734c-e9e2fdf03652@redhat.com>
 <20210607141424.GF1002214@nvidia.com>
 <1cf9651a-b8ee-11f1-1f70-db3492a76400@redhat.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <9a5b6675-e21a-cf62-6ea1-66c07e73e3ae@metux.net>
Date: Tue, 8 Jun 2021 10:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1cf9651a-b8ee-11f1-1f70-db3492a76400@redhat.com>
Content-Language: tl
X-Provags-ID: V03:K1:8kyLIALPf2tB8V1k8OkKPO+t0JzfF1nw6+qQyhnu0hXMra8y0xE
 6jTMAZv9U2q49s04k9XDHsGY7Zz+zj1PbDtCUSaFUayZkcDZhg5noOdzNDTmj9H5JfgBRxU
 tVmITHaGAVxeS/NootJaf9Wo7ND6rbtDzVmKjhhZZB0rh/Od2LmuGKGmpZUJBOU76UkahDH
 qjbSLLC8JG6uwi9xeZH+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NKHch6yJ0Zc=:rOP7klmWM3f3oIrFW9VpKr
 BBvV9RaWe6aDGtA16XwYrQ1FvLMQJgy+7wg1T/6mpmISE3kI7YbMzFteDBiF6Bh+QSEWYoAg2
 RhexYbCbDtd8B1PG7fUL8pxQhgWJUn3diCm5hVw1lAxrwI3UeyJPiFXCScCM70WacprM/ws+G
 UY35oxJu1qeyt7h5tbpNj6uHw2utJco6lAKKYKK4nMPQcedVrLp73PbZQEKhdQGsMHmWRhpAs
 ZFxgp3QPNWmGqa/0NazChPNcDsWJZ2tUuE4XMjSGHtDJfda8VdD6iQjPxZkZXA+3ouU7vRJhZ
 BM75tNyPemu2xLiD5SKq3Smg4DaLPhQZZgIhbXGld3sHVs5pGtZfXDHPjIyIBsYdK5Q1/4g/j
 szIm6tHXksp4KbolEcOf+SEjJ1dazkoNzXznRvFao7oxpSuwYV8bIJBsuTosFUdTpNck5omTL
 9B1TmZUX8SAc/S3jB4aJSDDHL72Ob833jj/WG8RWmKr2lh8A7eCyv0vwsRnKHelgu92Hu+jzR
 upIGX+uczX+fYEzNP2pysc=
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

T24gMDguMDYuMjEgMDM6MDAsIEphc29uIFdhbmcgd3JvdGU6CgpIaSBmb2xrcywKCj4gSnVzdCB0
byBtYWtlIHN1cmUgd2UgYXJlIGluIHRoZSBzYW1lIHBhZ2UuIFdoYXQgSSBtZWFudCBpcywgaWYg
dGhlIERNQSAKPiBiZWhhdmlvciBsaWtlIChuby1zbm9vcCkgaXMgZGV2aWNlIHNwZWNpZmljLiBU
aGVyZSdzIG5vIG5lZWQgdG8gbWFuZGF0ZSAKPiBhIHZpcnRpbyBnZW5lcmFsIGF0dHJpYnV0ZXMu
IFdlIGNhbiBkZXNjcmliZSBpdCBwZXIgZGV2aWNlLiBUaGUgZGV2aWNlcyAKPiBpbXBsZW1lbnRl
ZCBpbiB0aGUgY3VycmVudCBzcGVjIGRvZXMgbm90IHVzZSBub24tY29oZXJlbnQgRE1BIGRvZXNu
J3QgCj4gbWVhbiBhbnkgZnV0dXJlIGRldmljZXMgd29uJ3QgZG8gdGhhdC4gVGhlIGRyaXZlciBj
b3VsZCBjaG9vc2UgdG8gdXNlIAo+IHRyYW5zcG9ydCAoZS5nIFBDSSksIHBsYXRmb3JtIChBQ1BJ
KSBvciBkZXZpY2Ugc3BlY2lmaWMgKGdlbmVyYWwgdmlydGlvIAo+IGNvbW1hbmQpIHdheSB0byBk
ZXRlY3QgYW5kIGZsdXNoIGNhY2hlIHdoZW4gbmVjZXNzYXJ5LgoKTWF5YmUgSSd2ZSB0b3RhbGx5
IG1pc3VuZGVyc3Rvb2QgdGhlIHdob2xlIGlzc3VlLCBidXQgd2hhdCBJJ3ZlIGxlYXJuZWQKdG8g
ZmFyOgoKKiBpdCdzIGEgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZm9yIGNlcnRhaW4gc2NlbmFy
aW9zCiogd2hldGhlciBpdCBjYW4gYmUgdXNlZCBkZXBlbmRzIG9uIHRoZSBkZXZpY2VzIGFzIHdl
bGwgYXMgdGhlCiAgIHVuZGVybHlpbmcgdHJhbnNwb3J0IChjb21iaW5hdGlvbiBvZiBib3RoKQoq
IHdoZXRoZXIgaXQgc2hvdWxkIGJlIHVzZWQgKHdoZW4gcG9zc2libGUpIGNhbiBvbmx5IGJlIGRl
Y2lkZWQgYnkgdGhlCiAgIGRyaXZlcgoKQ29ycmVjdCA/CgpJIHRlbmQgdG8gYmVsaWV2ZSB0aGF0
J3Mgc29tZXRoaW5nIHRoYXQgdmlydGlvIGluZnJhc3RydWN0dXJlIHNob3VsZApoYW5kbGUgaW4g
YSBnZW5lcmljIHdheS4KCk1heWJlIHRoZSBkZXZpY2UgYXMgd2VsbCBhcyB0aGUgdHJhbnNwb3J0
IGNvdWxkIGFubm91bmNlIHRoZWlyCmNhcGFiaWxpdHkgKHdoaWNoIElNSE8gc2hvdWxkIGdvIHZp
YSB0aGUgdmlydGlvIHByb3RvY29sKSwgYW5kIGlmIGJvdGgKYXJlIGNhcGFibGUsIHRoZSAoZ3Vl
c3QncykgdmlydGlvIHN1YnN5cyB0ZWxscyB0aGUgZHJpdmVyIHdoZXRoZXIgaXQncwp1c2FibGUg
Zm9yIGEgc3BlY2lmaWMgZGV2aWNlLiBQZXJoYXBzIHdlIHNob3VsZCBhbHNvIGhhdmUgYSBtZWNo
YW5pc20KdG8gdGVsbCB0aGUgZGV2aWNlIHRoYXQgaXQncyBhY3R1YWxseSB1c2VkLgoKClNvcnJ5
LCBpZiBpJ20gY29tcGxldGVseSBvbiB0aGUgd3JvbmcgcGFnZSBhbmQganVzdCB0YWxraW5nIGp1
bmsgaGVyZSA6bwoKCi0tbXR4CgotLSAKLS0tCkhpbndlaXM6IHVudmVyc2NobMO8c3NlbHRlIEUt
TWFpbHMga8O2bm5lbiBsZWljaHQgYWJnZWjDtnJ0IHVuZCBtYW5pcHVsaWVydAp3ZXJkZW4gISBG
w7xyIGVpbmUgdmVydHJhdWxpY2hlIEtvbW11bmlrYXRpb24gc2VuZGVuIFNpZSBiaXR0ZSBpaHJl
bgpHUEcvUEdQLVNjaGzDvHNzZWwgenUuCi0tLQpFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29u
c3VsdApGcmVlIHNvZnR3YXJlIGFuZCBMaW51eCBlbWJlZGRlZCBlbmdpbmVlcmluZwppbmZvQG1l
dHV4Lm5ldCAtLSArNDktMTUxLTI3NTY1Mjg3Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
