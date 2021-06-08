Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A3C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 10:44:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7986134F
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 10:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7986134F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95D1940302;
	Tue,  8 Jun 2021 10:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7uvEE_7YdMy; Tue,  8 Jun 2021 10:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE1C0402A4;
	Tue,  8 Jun 2021 10:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C054AC000D;
	Tue,  8 Jun 2021 10:44:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6784EC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 10:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40AAF606C5
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 10:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jkv-zCFZyoJE for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 10:44:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAA2B606D3
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 10:44:12 +0000 (UTC)
Received: from [192.168.1.155] ([77.7.0.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnJdC-1l7e5D1hvo-00jJJM; Tue, 08 Jun 2021 12:43:43 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <bb6846bf-bd3c-3802-e0d7-226ec9b33384@metux.net>
 <20210602172424.GD1002214@nvidia.com>
 <bd0f485c-5f70-b087-2a5a-d2fe6e16817d@metux.net>
 <20210604123054.GL1002214@nvidia.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <329fcd72-605a-fc10-1a8d-c3f2ac3be9a1@metux.net>
Date: Tue, 8 Jun 2021 12:43:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210604123054.GL1002214@nvidia.com>
Content-Language: tl
X-Provags-ID: V03:K1:kQlbcYVyqh7Kv3mxj3JGjk3dxcaEReaRMO1wJlQyxPkwqc3rlNB
 ty1P4s3Q1U8YMBl+PAGTd/B9xN3luktYAJUvcIm8MxNrn5Ufw3QW/pOSLFBXCidANQm2vOL
 Kf0ipNSyGmyjvOYlXaOs+iavgR+8to7ozNqxLBThWjyjeMPtyrDyKl4eF6lXS34Ejofrm6p
 wfyAMKuEHX4+5ky7Fwr4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nhyYPjt/oTs=:181063X6GaNOTval4U+P8Y
 cwsH0SmjAvrMHg8eLaYi+NgNCkjBaK49pcjziRRbc2+BTBWboMP1G/J6UGA1JZO4o0rkgiJRu
 js1Wg22BcB3fVTdJ8XE8KwKizdDPS/mUiTNloNqCDjgMVH0vBodTGeko3MzQ+1K2pbo4PxVqY
 pacCRkNxVyN4T88mjozcEpKiSYPcf4I29DPsjgKlvb+2dX1w01/bpnmZYZoApd7H9elPk1jYf
 FA/7iRSaojlhbDSqWViQX0cY6iufNvofS2ydC4paMpcH7mUXEPmNaKzxdw+io8RzhbL8pO+3K
 4TRWLInFEwbidBxYATrioZTqZ0N4hpCp/SvYDIfcNHiZjug8V0s7MpVr/6AdAPnHjSUXxAwHU
 f3BBAibd9lz3HbL12eZR4kIAFZDAYovq6GU08s1DtCbTzhUJirHdNHyixNjMC0yr7JmjWVv4k
 EkfU+sMCbj+4vxIa7lW+wuha41v3jnKCkDRiUIah6CNkFHkFkHddfO1LO8xkBbrN0KGw7hQZb
 pc4pd+imbUHacOaBdIOXCQ=
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

T24gMDQuMDYuMjEgMTQ6MzAsIEphc29uIEd1bnRob3JwZSB3cm90ZToKCkhpLAoKPiBDb250YWlu
ZXJzIGFscmVhZHkgbmVlZGVkIHRvIGRvIHRoaXMgdG9kYXkuIENvbnRhaW5lciBvcmNoZXN0cmF0
aW9uIGlzCj4gaGFyZC4KClllcywgYnV0IEkgaGF0ZSB0byBzZWUgZXZlbiBtb3JlIHdvcmsgdXBj
b21pbmcgaGVyZS4KCj4gWWVzLCAvZGV2L2lvYXNpZCBzaG91bGRuJ3QgZG8gYW55dGhpbmcgdW5s
ZXNzIHlvdSBoYXZlIGEgZGV2aWNlIHRvCj4gY29ubmVjdCBpdCB3aXRoLiBJbiB0aGlzIHdheSBp
dCBpcyBwcm9iYWJseSBzYWZlIHRvIHN0dWZmIGl0IGludG8KPiBldmVyeSBjb250YWluZXIuCgpP
a2F5LCBpZiB3ZSBjYW4gZ3VhcmFudGVlIHRoYXQsIEknbSBjb21wbGV0ZWx5IGZpbmUuCgo+Pj4g
SGF2aW5nIEZEcyBzcGF3biBvdGhlciBGRHMgaXMgcHJldHR5IHVnbHksIGl0IGRlZmVhdHMgdGhl
ICJldmVyeXRoaW5nCj4+PiBpcyBhIGZpbGUiIG1vZGVsIG9mIFVOSVguCj4+Cj4+IFVuZm9ydHVu
YXRlbHksIHRoaXMgaXMgYWxyZWFkeSBkZWZlYXRlZCBpbiBtYW55IG90aGVyIHBsYWNlcyA6KAo+
PiAoSSdkIGV2ZW4gY2xhaW0gdGhhdCBpb2N0bHMgYWxyZWFkeSBicmVhayBpdCA6cCkKPiAKPiBJ
IHRoaW5rIHlvdSBhcmUgcmVhY2hpbmcgYSBiaXQgOikKPiAKPj4gSXQgc2VlbXMgeW91ciBhcHBy
b2FjaCBhbHNvIGJyZWFrcyB0aGlzLCBzaW5jZSB3ZSBub3cgbmVlZCB0byBvcGVuIHR3bwo+PiBm
aWxlcyBpbiBvcmRlciB0byB0YWxrIHRvIG9uZSBkZXZpY2UuCj4gCj4gSXQgaXMgdHdvIGRldmlj
ZXMsIHRodXMgdHdvIGZpbGVzLgoKVHdvIHNlcGFyYXRlIHJlYWwgKGhhcmR3YXJlKSBkZXZpY2Vz
IG9yIGp1c3QgdHdvIGxvZ2ljYWwgZGV2aWNlIG5vZGVzID8KCgotLW10eAoKLS0gCi0tLQpIaW53
ZWlzOiB1bnZlcnNjaGzDvHNzZWx0ZSBFLU1haWxzIGvDtm5uZW4gbGVpY2h0IGFiZ2Vow7ZydCB1
bmQgbWFuaXB1bGllcnQKd2VyZGVuICEgRsO8ciBlaW5lIHZlcnRyYXVsaWNoZSBLb21tdW5pa2F0
aW9uIHNlbmRlbiBTaWUgYml0dGUgaWhyZW4KR1BHL1BHUC1TY2hsw7xzc2VsIHp1LgotLS0KRW5y
aWNvIFdlaWdlbHQsIG1ldHV4IElUIGNvbnN1bHQKRnJlZSBzb2Z0d2FyZSBhbmQgTGludXggZW1i
ZWRkZWQgZW5naW5lZXJpbmcKaW5mb0BtZXR1eC5uZXQgLS0gKzQ5LTE1MS0yNzU2NTI4NwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
