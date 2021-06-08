Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B8C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 10:51:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B9961278
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 10:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B9961278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DE746065D;
	Tue,  8 Jun 2021 10:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhQrY6pjc7aZ; Tue,  8 Jun 2021 10:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E49B6606D3;
	Tue,  8 Jun 2021 10:51:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFE0BC000D;
	Tue,  8 Jun 2021 10:51:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC5AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 10:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A60E383BD6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 10:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FRgGz97MSYTc for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 10:51:01 +0000 (UTC)
X-Greylist: delayed 00:05:16 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB57C83BD4
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 10:51:00 +0000 (UTC)
Received: from [192.168.1.155] ([77.7.0.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLA6m-1m7Xt120cU-00IBqQ; Tue, 08 Jun 2021 12:45:17 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
 <20210601173138.GM1002214@nvidia.com>
 <f69137e3-0f60-4f73-a0ff-8e57c79675d5@redhat.com>
 <20210602172154.GC1002214@nvidia.com>
 <51e060a3-fc59-0a13-5955-71692b14eed8@metux.net>
 <20210607180144.GL1002214@nvidia.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <633b00c1-b388-856a-db71-8d74e52c2702@metux.net>
Date: Tue, 8 Jun 2021 12:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607180144.GL1002214@nvidia.com>
Content-Language: tl
X-Provags-ID: V03:K1:rKi//4YjvppFqCI3qhiJgU+YGO1eL25Ke0yqyFYXtckbUqQ7e6S
 kKA+xhIO32fHiJKkew3aWBnuNdpx3nAxl3dHU6jeEPDxDNyp5z4ltzkpYR3Bn4LfD8iPBcv
 AO4CpuQLNBTnWt6wcmFrDC06a/FL8VrvsN2vRd+z7sEJJDE8nOOfUW2DkOkUSWZQNvR0gis
 h/Z0w+/XmgIVqxtNGERpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMV74mVdH9A=:5OT3j+xg06y9zym3Jtkh5J
 wqP3xkeHmrwBASOmDsXXFfESmeiAHWyFhCUDVvdSMEYGVajoBtMAR0Th5EjVbKhKCABwmRVV+
 iPtkZBxKjD3PzYDPxrJLbXtAMViVUsVygp9IcFh+Xpp0NalJh2WEDf7ITctacwbpyGU+gAahp
 ajfhlCM1dDyyD4Sa/w2/KwxyJqfsIna3UejbS+ZBcZlIygCCVc2LdgBBrJhewJfpeuyWmW5gt
 8548cnHJSbgFH6Vax5GljIbCtpgpxTEkF+gnIZpQJyqnQOHl6euRlEUv6p/humUuH4G4iCLUg
 c/xCWU0Bi+lt9QGrlaqvZlyLXdAAkk0c0Jyhrx20lsMVbQcYHaYIHKqwxw/7aI2lb3jmyuWs6
 ijWcZeNJV71mZp0AbCgsxq5dDXxMZdESt15xi3IMYyQPjNipzQkGdGVLoy3pdyM4Jg7jzcBek
 2QsrFHXuwtSwyrPf1DBQ8DdmFvsJtmIkKZS2OR2yNqZvgWQgIGhLAcbQalMLIKm9x1J3QpoWj
 B1EVAbnl3cb69wGiparXJM=
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

T24gMDcuMDYuMjEgMjA6MDEsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiA8c2hydWc+IGl0IGlz
IHdoYXQgaXQgaXMsIHNlbGVjdCBoYXMgYSBmaXhlZCBzaXplIGJpdG1hcCBvZiBGRCAjcyBhbmQK
PiBhIGhhcmQgdXBwZXIgYm91bmQgb24gdGhhdCBzaXplIGFzIHBhcnQgb2YgdGhlIGdsaWJjIEFC
SSAtIGNhbid0IGJlCj4gZml4ZWQuCgppbiBnbGliYyBBQkkgPyBVdXV1aCEKCgotLW10eAoKLS0g
Ci0tLQpIaW53ZWlzOiB1bnZlcnNjaGzDvHNzZWx0ZSBFLU1haWxzIGvDtm5uZW4gbGVpY2h0IGFi
Z2Vow7ZydCB1bmQgbWFuaXB1bGllcnQKd2VyZGVuICEgRsO8ciBlaW5lIHZlcnRyYXVsaWNoZSBL
b21tdW5pa2F0aW9uIHNlbmRlbiBTaWUgYml0dGUgaWhyZW4KR1BHL1BHUC1TY2hsw7xzc2VsIHp1
LgotLS0KRW5yaWNvIFdlaWdlbHQsIG1ldHV4IElUIGNvbnN1bHQKRnJlZSBzb2Z0d2FyZSBhbmQg
TGludXggZW1iZWRkZWQgZW5naW5lZXJpbmcKaW5mb0BtZXR1eC5uZXQgLS0gKzQ5LTE1MS0yNzU2
NTI4NwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
