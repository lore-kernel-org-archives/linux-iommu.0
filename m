Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786FC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 10:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD956141B
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 10:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD956141B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 059B18420A;
	Fri,  4 Jun 2021 10:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZdU-GpdxOdX; Fri,  4 Jun 2021 10:45:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B492B84208;
	Fri,  4 Jun 2021 10:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 850A5C000E;
	Fri,  4 Jun 2021 10:45:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD9F4C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 10:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B732240163
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 10:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id faTTsGYJMgpL for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 10:45:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A84240104
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 10:45:03 +0000 (UTC)
Received: from [192.168.1.155] ([77.9.34.20]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXH3e-1lrzgc1R4Y-00YmfZ; Fri, 04 Jun 2021 12:44:32 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <bb6846bf-bd3c-3802-e0d7-226ec9b33384@metux.net>
 <20210602172424.GD1002214@nvidia.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <bd0f485c-5f70-b087-2a5a-d2fe6e16817d@metux.net>
Date: Fri, 4 Jun 2021 12:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210602172424.GD1002214@nvidia.com>
Content-Language: tl
X-Provags-ID: V03:K1:EoukDPcc2J/QT1D3boJAqDV3J9p3cqCtFNu4BEvhSOo+pu9OZsX
 DwBwLSc9+AiWMjMqEkc8DgpMYjdaXZ3udFjKV/t35j93kOSrcJS2O5rSy8bS4O9YWqrwJah
 eQ3aEeFMxZainqV/DPiuIeWIiAAeeoQNexILCOmEFhLNHZ/NUZBkuwfo46oactlC0K7Fada
 vDtxNQu+o6eAn++Bv+/eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QKgPDva5+wg=:eeMux13sB16S9C4PhjuoZD
 CtwoD8dWEh81W5fy1QPhYLQUS15Eyu4lv3ZTs3TJ1ftGLpHB2oin7q+5F1zibM1WVSzfdeScd
 uU0679MJoje4xsogtaueiuTQtRcF9QzF0/XvHjQzfWg0g+KGNEw58XxmgZulfIvcirFRfd0JS
 bDRA6Bz3nIU+Vhb20syeejdhTusBXSk3fj0k0p07MLmf3Aw9Su2r8ncxiz9zoFX04+i2yPQ4O
 9xQpYJA09Bamh3J5+sDfaH3BuXCmI5Uj1YN1YFPi1/3l9FGCN95CEX+PvIhQAQ3/MmkdZIvJG
 AGR70wW8AgrmjraQNoKhqd0CX0w1JHDhv1rd0feIIp/1VWd0xxSHnqyle4T2JlOBmNHY5PuWH
 /mT93AOHNqxmXXtc2D3+VCmGUYySMWbv1MyW00of6y0T07yKv3XmCL948iDJae4WYI826EjvO
 sSSSZUyu1ujzfih9pcDYtclYWtmKmNXkn3y9dqmlywTwqoL7hphFkBhxYGsE9vU/fGfUNaH3H
 PElzz4R4ACzW4c8fgPPEko=
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

T24gMDIuMDYuMjEgMTk6MjQsIEphc29uIEd1bnRob3JwZSB3cm90ZToKCkhpLAoKID4+IElmIEkg
dW5kZXJzdGFuZCB0aGlzIGNvcnJlY3RseSwgL2Rldi9pb2FzaWQgaXMgYSBraW5kIG9mICJjb21t
b24gCnN1cHBsaWVyIgogPj4gdG8gb3RoZXIgQVBJcyAvIGRldmljZXMuIFdoeSBjYW4ndCB0aGUg
ZmQgYmUgYWNxdWlyZWQgYnkgdGhlCiA+PiBjb25zdW1lciBBUElzIChlZy4ga3ZtLCB2ZmlvLCBl
dGMpID8KID4KID4gL2Rldi9pb2FzaWQgd291bGQgYmUgc2ltaWxhciB0byAvZGV2L3ZmaW8sIGFu
ZCBldmVyeXRoaW5nIGFscmVhZHkKID4gZGVhbHMgd2l0aCBleHBvc2luZyAvZGV2L3ZmaW8gYW5k
IC9kZXYvdmZpby9OIHRvZ2V0aGVyCiA+CiA+IEkgZG9uJ3Qgc2VlIGl0IGFzIGEgcHJvYmxlbSwg
anVzdCBtb3JlIHdvcmsuCgpPbmUgb2YgdGhlIHByb2JsZW1zIEknbSBzZWVpbmcgaXMgaW4gY29u
dGFpbmVyIGVudmlyb25tZW50czogd2hlbgpwYXNzaW5nIGluIGFuIHZmaW8gZGV2aWNlLCB3ZSBu
b3cgYWxzbyBuZWVkIHRvIHBhc3MgaW4gL2Rldi9pb2FzaWQsCnRodXMgaW5jcmVhc2luZyB0aGUg
Y29tcGxleGl0eSBpbiBjb250YWluZXIgc2V0dXAgKG9yIG9yY2hlc3RyYXRpb24pLgoKQW5kIGlu
IHN1Y2ggc2NlbmFyaW9zIHlvdSB1c3VhbGx5IHdhbnQgdG8gcGFzcyBpbiBvbmUgc3BlY2lmaWMg
ZGV2aWNlLApub3QgYWxsIG9mIHRoZSBzYW1lIGNsYXNzLCBhbmQgdXN1YWxseSBvcmNoZXN0cmF0
aW9uIHNoYWxsIHBpY2sgdGhlCm5leHQgZnJlZSBvbmUuCgpDYW4gd2UgbWFrZSBzdXJlIHRoYXQg
YSBwcm9jZXNzIGhhdmluZyBmdWxsIGFjY2VzcyB0byAvZGV2L2lvYXNpZAp3aGlsZSBvbmx5IHN1
cHBvc2VkIHRvIGhhdmUgdG8gc3BlY2lmaWMgY29uc3VtZXIgZGV2aWNlcywgY2FuJ3QgZG8KYW55
IGhhcm0gKGVnLiBpbmZsdWVuY2luZyBvdGhlciBjb250YWluZXJzIHRoYXQgbWlnaHQgdXNlIGEg
ZGlmZmVyZW50CmNvbnN1bWVyIGRldmljZSkgPwoKTm90ZSB0aGF0IHdlIGRvbid0IGhhdmUgZGV2
aWNlIG5hbWVzcGFjZXMgeWV0IChkZXZpY2UgaXNvbGF0aW9uIHN0aWxsCmhhcyB0byBiZSBkb25l
IHcvIGNvbXBsaWNhdGVkIGJwZiBtYWdpYykuIEknbSBhbHJlYWR5IHdvcmtpbmcgb24gdGhhdCwK
YnV0IGV2ZW4gInNpbXBsZSIgdGhpbmdzIGxpa2UgbG9vcGRldiBhbGxvY2F0aW9uIHR1cm5zIG91
dCB0byBiZSBub3QKZW50aXJlbHkgZWFzeS4KCiA+IEhhdmluZyBGRHMgc3Bhd24gb3RoZXIgRkRz
IGlzIHByZXR0eSB1Z2x5LCBpdCBkZWZlYXRzIHRoZSAiZXZlcnl0aGluZwogPiBpcyBhIGZpbGUi
IG1vZGVsIG9mIFVOSVguCgpVbmZvcnR1bmF0ZWx5LCB0aGlzIGlzIGFscmVhZHkgZGVmZWF0ZWQg
aW4gbWFueSBvdGhlciBwbGFjZXMgOigKKEknZCBldmVuIGNsYWltIHRoYXQgaW9jdGxzIGFscmVh
ZHkgYnJlYWsgaXQgOnApCgpJdCBzZWVtcyB5b3VyIGFwcHJvYWNoIGFsc28gYnJlYWtzIHRoaXMs
IHNpbmNlIHdlIG5vdyBuZWVkIHRvIG9wZW4gdHdvCmZpbGVzIGluIG9yZGVyIHRvIHRhbGsgdG8g
b25lIGRldmljZS4KCkJ5IHRoZSB3YXk6IG15IGlkZWEgZG9lcyBrZWVwIHRoZSAiZXZlcnl0aGlu
ZydzIGEgZmlsZSIgY29uY2VwdCAtIHdlCmp1c3QgaGF2ZSBhIGZpbGUgdGhhdCBhbGxvd3Mgb3Bl
bmluZyAic3ViLWZpbGVzIi4gV2VsbCwgaXQgd291bGQgYmUKYmV0dGVyIGlmIGRldmljZXMgY291
bGQgYWxzbyBoYXZlIGRpcmVjdG9yeSBzZW1hbnRpY3MuCgoKLS1tdHgKCi0tLQpIaW53ZWlzOiB1
bnZlcnNjaGzDvHNzZWx0ZSBFLU1haWxzIGvDtm5uZW4gbGVpY2h0IGFiZ2Vow7ZydCB1bmQgbWFu
aXB1bGllcnQKd2VyZGVuICEgRsO8ciBlaW5lIHZlcnRyYXVsaWNoZSBLb21tdW5pa2F0aW9uIHNl
bmRlbiBTaWUgYml0dGUgaWhyZW4KR1BHL1BHUC1TY2hsw7xzc2VsIHp1LgotLS0KRW5yaWNvIFdl
aWdlbHQsIG1ldHV4IElUIGNvbnN1bHQKRnJlZSBzb2Z0d2FyZSBhbmQgTGludXggZW1iZWRkZWQg
ZW5naW5lZXJpbmcKaW5mb0BtZXR1eC5uZXQgLS0gKzQ5LTE1MS0yNzU2NTI4NwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
