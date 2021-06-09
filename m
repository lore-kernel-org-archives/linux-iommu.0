Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F30C48BDF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:52:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A1E6101A
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A1E6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68549402E0;
	Wed,  9 Jun 2021 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6fcI2OZzFvx; Wed,  9 Jun 2021 08:52:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EB25400D4;
	Wed,  9 Jun 2021 08:52:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36FDEC000D;
	Wed,  9 Jun 2021 08:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C53DFC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B340E40269
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N7qH2g-YwzbR for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:52:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77D4140238
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:52:24 +0000 (UTC)
Received: from [192.168.1.155] ([77.9.120.3]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MaIGB-1lo04d0Q0D-00WDfS; Wed, 09 Jun 2021 10:51:54 +0200
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <20210608190022.GM1002214@nvidia.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
Date: Wed, 9 Jun 2021 10:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608190022.GM1002214@nvidia.com>
Content-Language: tl
X-Provags-ID: V03:K1:129gpDF0BUiljAKLG/lQM9gOvQsLJNYv6mn4lsTL3Y6scaycnu6
 FPVYBAyrjnF1UY5uwjcf4oFw4beloQnySFsPKYbawZfN6tAapAsVHo2QgL4R4yFkhCoiQly
 iyPTJnWT8Mwi7XapNxHe64Lv15irUjL5dqbROpopaoobxzsl59SG2wsiJeu+82nnrgqc/7a
 JUvZonTmpEByKtCFMeFWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:POLH6n9P4zc=:r5TZcQVPFRF4PjIFhtEtsc
 dD3FDxLNBDMLgWG/MNRgaoxxjZoeGAnDFNrL5n572RnYavwM9FfniMfqfMegke/Kgg+e/KzJa
 9LT9KniwqqSJEplpR6p60i0ubJxhUj61aitZlsxUKoHu1+cYuoLonSFnlHgOXXC3zFb7sKL/l
 5+N8urVp3aD+42CMom3DQmR/OhngLKKh+hlZaij3jykJCSIz47lO9KJuXFI+YhvVENVR+ioig
 WZT63ZCSIX6xP1GiD1irLtO7PWirac5YLkWT77v6fAqAq7TwBbrQ5aSJndaBXoRp894v5mq+A
 hxHvxDh5Ac4N20dRUBxzHcjupjmrO/qFNOsUIZXrvj6wkMw2LhuGnb9V7NHPk8ut4K8TtSMzz
 NftmcBDo+y4gl+xa7jJC9dAZA2MJKxdMtOURjbYeDGaoHWYoYYUAaW9hKpmQVqPUOVzVXdpKb
 BnL/wbMl256p27IIfNXK9nADHPcn4funqrbusWTku0lTWHysNztTXM0dDN+uqFCyfGjMB/61y
 SDR8IC7P1tGKRZkANhzhfE=
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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

T24gMDguMDYuMjEgMjE6MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToKCj4gRWcgSSBjYW4gZG8g
b3BlbigpIG9uIGEgZmlsZSBhbmQgSSBnZXQgdG8ga2VlcCB0aGF0IEZELiBJIGdldCB0byBrZWVw
Cj4gdGhhdCBGRCBldmVuIGlmIHNvbWVvbmUgbGF0ZXIgZG9lcyBjaG1vZCgpIG9uIHRoYXQgZmls
ZSBzbyBJIGNhbid0Cj4gb3BlbiBpdCBhZ2Fpbi4KPiAKPiBUaGVyZSBhcmUgbG90cyBvZiBleGFt
cGxlcyB3aGVyZSBhIG9uZSB0aW1lIGFjY2VzcyBjb250cm9sIGNoZWNrCj4gcHJvdmlkZXMgY29u
dGludWluZyBhY2Nlc3MgdG8gYSByZXNvdXJjZS4gSSBmZWVsIHRoZSBvbmdvaW5nIHByb29mIGlz
Cj4gdGhlIHJhcml0eSBpbiBVbml4Li4gJ3Jldm9rZScgaXMgYW4gdW5jb21tb24gY29uY2VwdCBp
biBVbml4Li4KClllcywgaXQncyBldmVuIHBvc3NpYmxlIHRoYXQgc29tZWJvZHkgdy8gcHJpdmls
ZWdlcyBvcGVucyBhbiBmZCBhbmQKaGFuZHMgaXQgb3ZlciB0byBzb21lYm9keSB1bnByaXZpbGVn
ZWQgKGVnLiB2aWEgdW5peCBzb2NrZXQpLiBUaGlzIGlzCmEgdmVyeSBiYXNpYyB1bml4IGNvbmNl
cHQuIElmIHNvbWUgKGFscmVhZHkgb3BlbmVkKSBmZCBub3cgc3VkZGVubHkKYmVoYXZlcyBkaWZm
ZXJlbnRseSBiYXNlZCBvbiB0aGUgY3VycmVudCBjYWxsZXIsIHRoYXQgd291bGQgYmUgYSBicmVh
awp3aXRoIHRyYWRpdGlvbmFsIHVuaXggc2VtYW50aWNzLgoKCi0tbXR4CgotLSAKLS0tCkhpbndl
aXM6IHVudmVyc2NobMO8c3NlbHRlIEUtTWFpbHMga8O2bm5lbiBsZWljaHQgYWJnZWjDtnJ0IHVu
ZCBtYW5pcHVsaWVydAp3ZXJkZW4gISBGw7xyIGVpbmUgdmVydHJhdWxpY2hlIEtvbW11bmlrYXRp
b24gc2VuZGVuIFNpZSBiaXR0ZSBpaHJlbgpHUEcvUEdQLVNjaGzDvHNzZWwgenUuCi0tLQpFbnJp
Y28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdApGcmVlIHNvZnR3YXJlIGFuZCBMaW51eCBlbWJl
ZGRlZCBlbmdpbmVlcmluZwppbmZvQG1ldHV4Lm5ldCAtLSArNDktMTUxLTI3NTY1Mjg3Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
