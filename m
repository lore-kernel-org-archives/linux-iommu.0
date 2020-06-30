Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A04C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:07:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE5420771
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j8Q/Z4e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE5420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA47287E7D;
	Tue, 30 Jun 2020 10:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRwL+fY3sh5l; Tue, 30 Jun 2020 10:07:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 86583871E0;
	Tue, 30 Jun 2020 10:07:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78624C0865;
	Tue, 30 Jun 2020 10:07:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58D65C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4EC472262F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EdSAXeJ49F6S for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 10:07:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 17BE51FE2F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:07:30 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200630100728euoutp02eec89cdaf88bdb8078dfcd0555c927f4~dSmbRR97j2942629426euoutp02X
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:07:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200630100728euoutp02eec89cdaf88bdb8078dfcd0555c927f4~dSmbRR97j2942629426euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1593511648;
 bh=O/UBH/mKXDUvagNJHSuUhhTnnDt9JbXJsJdK+XPv5UI=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=j8Q/Z4e35QiEfKTKTCJwBL5aA7IF+lresLLZlOmyDg53EkTKpqLRcsa27diO0wyP6
 MCm1VO4ZWj8obBulZs/aCd6Rh37uhHpHRZ1cXs72rlrfPyi/qorGLNuiRFSxEI7m01
 /mnJTOahNA5rCJLLRVmOyoPHQMec176t7wRbIGUQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200630100728eucas1p2058324a11592705d20c19eb2d4431545~dSma8s2PL2152321523eucas1p2k;
 Tue, 30 Jun 2020 10:07:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 16.AF.05997.0EE0BFE5; Tue, 30
 Jun 2020 11:07:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200630100727eucas1p2c13e286da77ef5278226b3610faf0498~dSmakSGW83241632416eucas1p2M;
 Tue, 30 Jun 2020 10:07:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200630100727eusmtrp22b04e33a7a6e2b7d13c0605b6cc61d2e~dSmajTg-F0851908519eusmtrp2k;
 Tue, 30 Jun 2020 10:07:27 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-e6-5efb0ee08c13
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.F1.06314.FDE0BFE5; Tue, 30
 Jun 2020 11:07:27 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200630100726eusmtip2e8258a38457a6d6c86f351b866a6b807~dSmZiHLma0424204242eusmtip2D;
 Tue, 30 Jun 2020 10:07:26 +0000 (GMT)
Subject: Re: [PATCH v7 31/36] staging: tegra-vde: fix common struct sg_table
 related issues
To: Dmitry Osipenko <digetx@gmail.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <559970b6-e80f-90ec-7fb0-1fab742d99de@samsung.com>
Date: Tue, 30 Jun 2020 12:07:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200621070015.0cf833ab@dimatab>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SZ0xTURjNfauPhuKzoHzBQdIoRhNxEm6icRASn+GPfzSOgFR5AcJMy3QS
 ioMiCk6sWhBlyBApUAXFgcEWwUIEF+JAIIoJIrEiKyDtA+XfOec73/3OSS5Lys8xbmxoZIyg
 ilSGKxgpZXw23Lz8s9NowMru54443dJA4PKsMhpPGDNJ/KBpRIKLB7oQbvvdz2DNjTIG3yqu
 J3DOo3U4RZdLYWtbJ4ENXa9p3FpzlcGn7lTRONWqY3C+YYzAT35203i4Rk9tkvMl+hLEf3z4
 lOJrB3Movlr3QcIbilIZ/u7gZ5p/dK1Ewn9KMxF8xc2j/PvxLpI/97YA8fffJTF8uuYHw5+u
 LEL8L8PCbbN2S9cHCeGhcYJqxYZAaUh5s1YSfcY1of3jbyoJpThrkQML3FoofTVIapGUlXOF
 CIw/DIxIrAie3k2dIr8QFKfXoumVXrNmalCAwPzeQoikH8HllmHC5nLm/OHrsQHGhl04Dyio
 H6NtJpIbp6DwcQFlGzDcKtD2aSdNLCvjNsAVk5dNprjF8Ljztd0yZ/Kd03k59ndk3GxouNxt
 1x04T7A2dNhvkZw7aKqukCJ2hfbubHsg4MwsNH/JpcXYvjDUZCZE7AzfTZUSEc+HierpBQ2C
 TkupRCSnELQmZ02VXgcdlhF7UpJbCmU1K0R5M/T0Xkc2GTgneNs3WwzhBGeNl0hRlsHJ43LR
 7QE60+1/Z5+0vCQzkEI3o5puRh3djDq6/3dzEFWEXIVYdUSwoF4dKcR7qpUR6tjIYM/9UREG
 NPlVG8dN1nuoZmxfHeJYpHCUBVqGA+S0Mk6dGFGHgCUVLjKfF40BclmQMvGAoIraq4oNF9R1
 aB5LKVxla3J7/eVcsDJGCBOEaEE1PSVYB7ck5J5dccQnnj3gYKg8aPG9lR+VtqNK6renfXvs
 0KKMoIuVb0r6+hft4ne16realXqv0sDRT36HV/+JPhRWFhJjqp2LJGFe+i/UgsGmFDJzyc6B
 8/IdFwIUvm1bRk7sTj5jHFue8vzd0qyEet/6Hu+N3nuu5n9LOxvqlkgLfaXxLXkJHQpKHaJc
 tYxUqZV/AZvSq5+mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xe7r3+X7HGTxdomvRe+4kk8XGGetZ
 Lf5vm8hssefML3aL1R8fM1pc+fqezaJ58Xo2i5WrjzJZLNhvbdEyaxGLxZcrD5ksNj2+xmpx
 edccNoueDVtZLTq/zGKzWLbpD5PFwQ9PWC1+7prH4iDksWbeGkaPe/sOs3js/baAxWPnrLvs
 HptWdbJ5bP/2gNVj/9w17B73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0dv8js2jb8sqRo/P
 m+QC+KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
 Mjae72Iv6BevuHXvK0sDY4twFyMnh4SAicTLE81sXYxcHEICSxkl7p7sZIVIyEicnNYAZQtL
 /LnWBVX0llHiyffDYAlhgViJ560f2UBsEQE1ieVH/4DFmQX+sUh0HrGFaHjFKDGr+TU7SIJN
 wFCi6y3IJA4OXgE7idnHTUHCLAKqEgceXmMBsUWBZn67twVsJq+AoMTJmU/A4pwCehJfTt5h
 gphvJjFv80NmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy02
 1CtOzC0uzUvXS87P3cQITCHbjv3cvIPx0sbgQ4wCHIxKPLwJ537GCbEmlhVX5h5ilOBgVhLh
 dTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84HpLa8k3tDU0NzC0tDc2NzYzEJJnLdD
 4GCMkEB6YklqdmpqQWoRTB8TB6dUA2NJy7UwZ+GelgfhQS9qFp7cc/PyR9PP2jZNy5lE52xX
 PbHuaGe0l/ujQoUu8f/npweke3zhmHNS6HqD4eOwC1du3TD9s2hm5BWGyYt2JK0rOv34ybSf
 3687uudvXjI/NOXwrroj911PvjkVOVdGY6t9T3tJxt7jzStj/kkw16ocWfU5ZVWVVWSXEktx
 RqKhFnNRcSIA0AcX0DcDAAA=
X-CMS-MailID: 20200630100727eucas1p2c13e286da77ef5278226b3610faf0498
X-Msg-Generator: CA
X-RootMTR: 20200619103714eucas1p18db6efd1a380fc0bdb16174ee85036fa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103714eucas1p18db6efd1a380fc0bdb16174ee85036fa
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103714eucas1p18db6efd1a380fc0bdb16174ee85036fa@eucas1p1.samsung.com>
 <20200619103636.11974-32-m.szyprowski@samsung.com>
 <20200621070015.0cf833ab@dimatab>
Cc: devel@driverdev.osuosl.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

T24gMjEuMDYuMjAyMCAwNjowMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+INCSIEZyaSwgMTkg
SnVuIDIwMjAgMTI6MzY6MzEgKzAyMDAKPiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lA
c2Ftc3VuZy5jb20+INC/0LjRiNC10YI6Cj4KPj4gVGhlIERvY3VtZW50YXRpb24vRE1BLUFQSS1I
T1dUTy50eHQgc3RhdGVzIHRoYXQgdGhlIGRtYV9tYXBfc2coKQo+PiBmdW5jdGlvbiByZXR1cm5z
IHRoZSBudW1iZXIgb2YgdGhlIGNyZWF0ZWQgZW50cmllcyBpbiB0aGUgRE1BIGFkZHJlc3MKPj4g
c3BhY2UuIEhvd2V2ZXIgdGhlIHN1YnNlcXVlbnQgY2FsbHMgdG8gdGhlCj4+IGRtYV9zeW5jX3Nn
X2Zvcl97ZGV2aWNlLGNwdX0oKSBhbmQgZG1hX3VubWFwX3NnIG11c3QgYmUgY2FsbGVkIHdpdGgK
Pj4gdGhlIG9yaWdpbmFsIG51bWJlciBvZiB0aGUgZW50cmllcyBwYXNzZWQgdG8gdGhlIGRtYV9t
YXBfc2coKS4KPj4KPj4gc3RydWN0IHNnX3RhYmxlIGlzIGEgY29tbW9uIHN0cnVjdHVyZSB1c2Vk
IGZvciBkZXNjcmliaW5nIGEKPj4gbm9uLWNvbnRpZ3VvdXMgbWVtb3J5IGJ1ZmZlciwgdXNlZCBj
b21tb25seSBpbiB0aGUgRFJNIGFuZCBncmFwaGljcwo+PiBzdWJzeXN0ZW1zLiBJdCBjb25zaXN0
cyBvZiBhIHNjYXR0ZXJsaXN0IHdpdGggbWVtb3J5IHBhZ2VzIGFuZCBETUEKPj4gYWRkcmVzc2Vz
IChzZ2wgZW50cnkpLCBhcyB3ZWxsIGFzIHRoZSBudW1iZXIgb2Ygc2NhdHRlcmxpc3QgZW50cmll
czoKPj4gQ1BVIHBhZ2VzIChvcmlnX25lbnRzIGVudHJ5KSBhbmQgRE1BIG1hcHBlZCBwYWdlcyAo
bmVudHMgZW50cnkpLgo+Pgo+PiBJdCB0dXJuZWQgb3V0IHRoYXQgaXQgd2FzIGEgY29tbW9uIG1p
c3Rha2UgdG8gbWlzdXNlIG5lbnRzIGFuZAo+PiBvcmlnX25lbnRzIGVudHJpZXMsIGNhbGxpbmcg
RE1BLW1hcHBpbmcgZnVuY3Rpb25zIHdpdGggYSB3cm9uZyBudW1iZXIKPj4gb2YgZW50cmllcyBv
ciBpZ25vcmluZyB0aGUgbnVtYmVyIG9mIG1hcHBlZCBlbnRyaWVzIHJldHVybmVkIGJ5IHRoZQo+
PiBkbWFfbWFwX3NnKCkgZnVuY3Rpb24uCj4+Cj4+IFRvIGF2b2lkIHN1Y2ggaXNzdWVzLCBsZXRz
IHVzZSBhIGNvbW1vbiBkbWEtbWFwcGluZyB3cmFwcGVycyBvcGVyYXRpbmcKPj4gZGlyZWN0bHkg
b24gdGhlIHN0cnVjdCBzZ190YWJsZSBvYmplY3RzIGFuZCB1c2Ugc2NhdHRlcmxpc3QgcGFnZQo+
PiBpdGVyYXRvcnMgd2hlcmUgcG9zc2libGUuIFRoaXMsIGFsbW9zdCBhbHdheXMsIGhpZGVzIHJl
ZmVyZW5jZXMgdG8gdGhlCj4+IG5lbnRzIGFuZCBvcmlnX25lbnRzIGVudHJpZXMsIG1ha2luZyB0
aGUgY29kZSByb2J1c3QsIGVhc2llciB0byBmb2xsb3cKPj4gYW5kIGNvcHkvcGFzdGUgc2FmZS4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1
bmcuY29tPgo+PiBSZXZpZXdlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29t
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMgfCA0
ICsrLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9pb21t
dS5jCj4+IGIvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9pb21tdS5jIGluZGV4Cj4+
IDZhZjg2M2Q5MjEyMy4uYWRmOGRjN2VlMjVjIDEwMDY0NCAtLS0KPj4gYS9kcml2ZXJzL3N0YWdp
bmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMgKysrCj4+IGIvZHJpdmVycy9zdGFnaW5nL21lZGlh
L3RlZ3JhLXZkZS9pb21tdS5jIEBAIC0zNiw4ICszNiw4IEBAIGludAo+PiB0ZWdyYV92ZGVfaW9t
bXVfbWFwKHN0cnVjdCB0ZWdyYV92ZGUgKnZkZSwKPj4gICAJYWRkciA9IGlvdmFfZG1hX2FkZHIo
JnZkZS0+aW92YSwgaW92YSk7Cj4+ICAgCj4+IC0Jc2l6ZSA9IGlvbW11X21hcF9zZyh2ZGUtPmRv
bWFpbiwgYWRkciwgc2d0LT5zZ2wsIHNndC0+bmVudHMsCj4+IC0JCQkgICAgSU9NTVVfUkVBRCB8
IElPTU1VX1dSSVRFKTsKPj4gKwlzaXplID0gaW9tbXVfbWFwX3NndGFibGUodmRlLT5kb21haW4s
IGFkZHIsIHNndCwKPj4gKwkJCQkgSU9NTVVfUkVBRCB8IElPTU1VX1dSSVRFKTsKPj4gICAJaWYg
KCFzaXplKSB7Cj4+ICAgCQlfX2ZyZWVfaW92YSgmdmRlLT5pb3ZhLCBpb3ZhKTsKPj4gICAJCXJl
dHVybiAtRU5YSU87Cj4gQWhoLCBJIHNhdyB0aGUgYnVpbGQgZmFpbHVyZSByZXBvcnQuIFlvdSdy
ZSBjaGFuZ2luZyB0aGUgRE1BIEFQSSBpbgo+IHRoaXMgc2VyaWVzLCB3aGlsZSBETUEgQVBJIGlz
bid0IHVzZWQgYnkgdGhpcyBkcml2ZXIsIGl0IHVzZXMgSU9NTVUKPiBBUEkuIEhlbmNlIHRoZXJl
IGlzIG5vIG5lZWQgdG8gdG91Y2ggdGhpcyBjb2RlLiBTaW1pbGFyIHByb2JsZW0gaW4gdGhlCj4g
aG9zdDF4IGRyaXZlciBwYXRjaC4KClRoZSBpc3N1ZSBpcyBjYXVzZWQgYnkgdGhlIGxhY2sgb2Yg
aW9tbXVfbWFwX3NndGFibGUoKSBzdHViIHdoZW4gbm8gCklPTU1VIHN1cHBvcnQgaXMgY29uZmln
dXJlZC4gSSd2ZSBwb3N0ZWQgYSBwYXRjaCBmb3IgdGhpczoKCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyMDA2MzAwODE3NTYuMTg1MjYtMS1tLnN6eXByb3dza2lAc2Ftc3VuZy5jb20v
CgpUaGUgcGF0Y2ggZm9yIHRoaXMgZHJpdmVyIGlzIGZpbmUsIHdlIGhhdmUgdG8gd2FpdCB1bnRp
bCB0aGUgYWJvdmUgZml4IApnZXRzIG1lcmdlZCBhbmQgdGhlbiBpdCBjYW4gYmUgYXBwbGllZCBk
dXJpbmcgdGhlIG5leHQgcmVsZWFzZSBjeWNsZS4KCkJlc3QgcmVnYXJkcwotLSAKTWFyZWsgU3p5
cHJvd3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
