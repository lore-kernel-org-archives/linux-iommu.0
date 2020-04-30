Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D52C47247
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:18:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564FD206D9
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZwiFYpXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564FD206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3187E8876A;
	Thu, 30 Apr 2020 14:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSyldBzg1Ps4; Thu, 30 Apr 2020 14:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B9C8C88761;
	Thu, 30 Apr 2020 14:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A148FC0864;
	Thu, 30 Apr 2020 14:18:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6A2C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8318D86DAC
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D7p1dPo-gXAT for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:18:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 13EB286D6A
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:18:02 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200430141800euoutp023cf1ff32b541f479aed65f9ce9fbc113~KnqwWZKlX1604416044euoutp02s
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:18:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200430141800euoutp023cf1ff32b541f479aed65f9ce9fbc113~KnqwWZKlX1604416044euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588256280;
 bh=Z+oh5N3Ek1AghjVaQH7O5XlCcDcgpiLe+Q7GQMjj1mg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=ZwiFYpXpEXy7rRHwsceOOMVvLVKLbB6qV9P9hoL4hLcaYJVb7hEjMgpafm7w7dXxd
 RXnzCrRuI5wQvyJw3glMO6Ixt7SR/+XDluztK8AZOevBqW5C3LPqv9yxVK1CioY179
 udu5fgIZIVyqc7PGyUIf+hq5H7J7ukV+K2kVS4B4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200430141800eucas1p2a3b0536d2ca46bbdd1d4968c735697e9~KnqwCUmmL1824518245eucas1p2p;
 Thu, 30 Apr 2020 14:18:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.98.61286.81EDAAE5; Thu, 30
 Apr 2020 15:18:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200430141759eucas1p102b34d44f2609df319407319579c51df~KnqvoafPg3210532105eucas1p15;
 Thu, 30 Apr 2020 14:17:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200430141759eusmtrp25453ff865a35d48094f4735251daf6fd~Knqvns_Kh2413924139eusmtrp2t;
 Thu, 30 Apr 2020 14:17:59 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-6a-5eaade18456b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.2C.07950.71EDAAE5; Thu, 30
 Apr 2020 15:17:59 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200430141758eusmtip23b7b53901a212a41ae18f56a0ee60c01~Knqu4Y9D80720207202eusmtip2T;
 Thu, 30 Apr 2020 14:17:58 +0000 (GMT)
Subject: Re: [Intel-gfx] [RFC 06/17] drm: i915: fix sg_table nents vs.
 orig_nents misuse
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9ffdaa30-aaf2-f25b-9837-265d66a95a88@samsung.com>
Date: Thu, 30 Apr 2020 16:17:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <88c841d0-c64c-f1db-b91a-2c4fe7097ccf@linux.intel.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRzlu3e7u65mt9Xw14OCUUFBmr24UIwe/nGJogdRZFnNuq1Ip+2m
 pkEt7cXSkiyWS6ZENZur1bTa1Bpb1HJDCa01TTNRUIdmtCkpZLndHv53zvnO+X6/8/GRuLRX
 OJs8pj7JatTKNDkhFjx7M9q0FD6b9y+rChF0UVMDRt+znhPRT25ZhXS+20vQ74eHCPpB1WuM
 vl1cjdEVzjV0+H0XRtu6/UK6pbaMoF3feoS0tyMkoj3jeetiGYvRgph2fz3BPB/5ImSMDduZ
 zisejKm+e5b5NN6NMyUBE2LqWrUEc7XGjJiQbd62KcnitYfZtGPZrCZBcVB8tLw5IMx0rj51
 3lGCadFYvA7FkECtBMfjH0IdEpNSqhLBi1IfwZMwAseXmj8khKDQdgHpEBmN3DApeN2EYOhn
 EI9cJaWGJhJVCyJ4BpUMlz7U4RHTTMqOwJ1/IUpwqg8DoyskirgIKhF0gzoigiWUAm4GKgQR
 LKAWQq/LEp0mo1JA79/JW6ZDQ2lP1BJDbYS3rZ3RKE7Nh4Knt3Eex0FbTznGdysioa52H4+T
 wPqwDPF4BgQ9NSIez4VfjohfPIELEHQ1PRTxpBBBS/6tP4k10N40RkQWwqnFYK1N4OX1cN/Z
 JuBfJRYCg9P5HWLh+jM9zssSuHxRyrsXgcHz6N9Y17tmvBjJDZOaGSa1MUxqY/g/twIJzCiO
 zeLSVSyXqGZz4jllOpelVsUfyki3oYnv5xv3fLej4eZUN6JIJJ8qIW3m/VKhMpvLTXcjIHH5
 TElXyoQkOazMzWM1GQc0WWks50ZzSIE8TrLiTn+KlFIpT7LHWTaT1fw9xciY2VpUGq7k9rSW
 hWv758hGTd7X1SWbJKuc142KpJxrpzcsc6QObLw066PgUHDEI9s62pwE0lz7qw6zLHvK5b3L
 g92KxsC2xbtI/5YdlmmbW7SyI7sdBcbiM1/rU+3aDn0jKE60Dwy3/lrhUOU0tg8OtKny/C+t
 3l51p9Gn91nnP+qTC7ijysQluIZT/gZP4h52egMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xe7ri91bFGSxeom3Re+4kk8XS9Y3s
 FhtnrGe1aDp0is3iytf3bBYrVx9lspg9YTOTxYL91hZfrjxkstj0+BqrxeVdc9gsDn54wmpx
 6u5ndovj/6oc+DzWzFvD6HHn2h42j+3fHrB6zDsZ6HG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6b
 DWwefVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OS
 mpNZllqkb5eglzH/0g3Wgv1mFS07JzM1MP7S62Lk4JAQMJGYstyui5GLQ0hgKaPEl479TF2M
 nEBxGYmT0xpYIWxhiT/Xutggit4yStz6voYZJCEsECXRfnU3mC0isINR4vTbPJAiZoEXTBLH
 JrRDdfxjlPj+owOsik3AUKLrLcgoTg5eATuJqTcWsIDYLAKqEs8PrmEEOUlUIFai5aImRImg
 xMmZT8BKOAWcJU7cvA/WyixgJjFv80NmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllI
 WhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjPdtx35u2cHY9S74EKMAB6MSDy/HplVx
 QqyJZcWVuYcYJTiYlUR4H8YChXhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmIrySuINTQ3N
 LSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwFuSrak08FRaeeGXC9XNHdLrn
 ztzWVrNTPplDmaUj8eTGoL2eXExhxqIrv0xw28/6MWzOlYWZC50jbz9+1Kn6VuwN06FYhY6z
 Eqbqwq+WzOF5xml0gf/sPCuX6WUyLvPY8kPP8Cfcte3ftKJyWvCVuZ/3ly6fbpzHfv71m60C
 ii0x9ckWoq2iSizFGYmGWsxFxYkADKnRcQ0DAAA=
X-CMS-MailID: 20200430141759eucas1p102b34d44f2609df319407319579c51df
X-Msg-Generator: CA
X-RootMTR: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132025eucas1p21580e634500a3e85564551cddf168b4a@eucas1p2.samsung.com>
 <20200428132005.21424-7-m.szyprowski@samsung.com>
 <88c841d0-c64c-f1db-b91a-2c4fe7097ccf@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

SGkKCk9uIDI4LjA0LjIwMjAgMTY6MjcsIFR2cnRrbyBVcnN1bGluIHdyb3RlOgo+Cj4gT24gMjgv
MDQvMjAyMCAxNDoxOSwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPj4gVGhlIERvY3VtZW50YXRp
b24vRE1BLUFQSS1IT1dUTy50eHQgc3RhdGVzIHRoYXQgZG1hX21hcF9zZyByZXR1cm5zIHRoZQo+
PiBudW1lciBvZiB0aGUgY3JlYXRlZCBlbnRyaWVzIGluIHRoZSBETUEgYWRkcmVzcyBzcGFjZS4g
SG93ZXZlciB0aGUKPj4gc3Vic2VxdWVudCBjYWxscyB0byBkbWFfc3luY19zZ19mb3Jfe2Rldmlj
ZSxjcHV9IGFuZCBkbWFfdW5tYXBfc2cgCj4+IG11c3QgYmUKPj4gY2FsbGVkIHdpdGggdGhlIG9y
aWdpbmFsIG51bWJlciBvZiBlbnRyaWVzIHBhc3NlZCB0byBkbWFfbWFwX3NnLiBUaGUKPj4gc2df
dGFibGUtPm5lbnRzIGluIHR1cm4gaG9sZHMgdGhlIHJlc3VsdCBvZiB0aGUgZG1hX21hcF9zZyBj
YWxsIGFzIAo+PiBzdGF0ZWQKPj4gaW4gaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oLiBBZGFw
dCB0aGUgY29kZSB0byBvYmV5IHRob3NlIHJ1bGVzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNYXJl
ayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1hYnVmLmPCoMKgwqDCoMKgwqAgfCAxMyAr
KysrKysrLS0tLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9pbnRl
cm5hbC5jwqDCoMKgwqAgfMKgIDQgKystLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0v
aTkxNV9nZW1fcmVnaW9uLmPCoMKgwqDCoMKgwqAgfMKgIDQgKystLQo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uY8KgwqDCoMKgwqDCoMKgIHzCoCA1ICsrKy0t
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9zZWxmdGVzdHMvaHVnZV9wYWdlcy5jwqAg
fCAxMCArKysrKy0tLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9zZWxmdGVzdHMv
bW9ja19kbWFidWYuYyB8wqAgNSArKystLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9p
bnRlbF9nZ3R0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMiArKysrKystLS0tLS0KPj4g
wqAgZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9nZW1fZ3R0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDEyICsrKysrKystLS0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1
X3NjYXR0ZXJsaXN0LmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKystLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vaTkxNS9zZWxmdGVzdHMvc2NhdHRlcmxpc3QuY8KgwqDCoMKgIHzCoCA4ICsrKyst
LS0tCj4+IMKgIDEwIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2Vt
X2RtYWJ1Zi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9kbWFidWYu
Ywo+PiBpbmRleCA3ZGI1YTc5Li5kODI5ODUyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1hYnVmLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jCj4+IEBAIC0zNiwyMSArMzYsMjIgQEAgc3RhdGljIHN0
cnVjdCBzZ190YWJsZSAKPj4gKmk5MTVfZ2VtX21hcF9kbWFfYnVmKHN0cnVjdCBkbWFfYnVmX2F0
dGFjaG1lbnQgKmF0dGFjaG1lCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl91bnBpbl9w
YWdlczsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIC3CoMKgwqAgcmV0ID0gc2dfYWxsb2NfdGFibGUo
c3QsIG9iai0+bW0ucGFnZXMtPm5lbnRzLCBHRlBfS0VSTkVMKTsKPj4gK8KgwqDCoCByZXQgPSBz
Z19hbGxvY190YWJsZShzdCwgb2JqLT5tbS5wYWdlcy0+b3JpZ19uZW50cywgR0ZQX0tFUk5FTCk7
Cj4+IMKgwqDCoMKgwqAgaWYgKHJldCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX2Zy
ZWU7Cj4+IMKgIMKgwqDCoMKgwqAgc3JjID0gb2JqLT5tbS5wYWdlcy0+c2dsOwo+PiDCoMKgwqDC
oMKgIGRzdCA9IHN0LT5zZ2w7Cj4+IC3CoMKgwqAgZm9yIChpID0gMDsgaSA8IG9iai0+bW0ucGFn
ZXMtPm5lbnRzOyBpKyspIHsKPj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgb2JqLT5tbS5wYWdl
cy0+b3JpZ19uZW50czsgaSsrKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzZ19zZXRfcGFnZShk
c3QsIHNnX3BhZ2Uoc3JjKSwgc3JjLT5sZW5ndGgsIDApOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
ZHN0ID0gc2dfbmV4dChkc3QpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3JjID0gc2dfbmV4dChz
cmMpOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgLcKgwqDCoCBpZiAoIWRtYV9tYXBfc2dfYXR0cnMo
YXR0YWNobWVudC0+ZGV2LAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dC0+c2dsLCBzdC0+bmVudHMsIGRpciwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRE1BX0FUVFJfU0tJUF9DUFVfU1lOQykpIHsKPj4gK8KgwqDCoCBzdC0+bmVudHMgPSBk
bWFfbWFwX3NnX2F0dHJzKGF0dGFjaG1lbnQtPmRldiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3QtPnNnbCwgc3QtPm9yaWdfbmVudHMsIGRpciwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRE1BX0FUVFJfU0tJUF9DUFVf
U1lOQyk7Cj4+ICvCoMKgwqAgaWYgKCFzdC0+bmVudHMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHJldCA9IC1FTk9NRU07Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9mcmVlX3NnOwo+
PiDCoMKgwqDCoMKgIH0KPj4gQEAgLTc0LDcgKzc1LDcgQEAgc3RhdGljIHZvaWQgaTkxNV9nZW1f
dW5tYXBfZG1hX2J1ZihzdHJ1Y3QgCj4+IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNobWVudCwK
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2k5MTVfZ2VtX29iamVjdCAqb2JqID0gCj4+IGRtYV9i
dWZfdG9fb2JqKGF0dGFjaG1lbnQtPmRtYWJ1Zik7Cj4+IMKgIMKgwqDCoMKgwqAgZG1hX3VubWFw
X3NnX2F0dHJzKGF0dGFjaG1lbnQtPmRldiwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2ctPnNnbCwgc2ctPm5lbnRzLCBkaXIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNnLT5zZ2wsIHNnLT5vcmlnX25lbnRzLCBkaXIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIERNQV9BVFRSX1NLSVBfQ1BVX1NZTkMpOwo+PiDCoMKgwqDCoMKgIHNnX2Zy
ZWVfdGFibGUoc2cpOwo+PiDCoMKgwqDCoMKgIGtmcmVlKHNnKTsKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9pbnRlcm5hbC5jIAo+PiBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9pbnRlcm5hbC5jCj4+IGluZGV4IGNiYmZmODEuLmE4
ZWJmZGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9p
bnRlcm5hbC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9pbnRl
cm5hbC5jCj4+IEBAIC03Myw3ICs3Myw3IEBAIHN0YXRpYyBpbnQgCj4+IGk5MTVfZ2VtX29iamVj
dF9nZXRfcGFnZXNfaW50ZXJuYWwoc3RydWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iaikKPj4g
wqDCoMKgwqDCoCB9Cj4+IMKgIMKgwqDCoMKgwqAgc2cgPSBzdC0+c2dsOwo+PiAtwqDCoMKgIHN0
LT5uZW50cyA9IDA7Cj4+ICvCoMKgwqAgc3QtPm5lbnRzID0gc3QtPm9yaWdfbmVudHMgPSAwOwo+
PiDCoMKgwqDCoMKgIHNnX3BhZ2Vfc2l6ZXMgPSAwOwo+PiDCoCDCoMKgwqDCoMKgIGRvIHsKPj4g
QEAgLTk0LDcgKzk0LDcgQEAgc3RhdGljIGludCAKPj4gaTkxNV9nZW1fb2JqZWN0X2dldF9wYWdl
c19pbnRlcm5hbChzdHJ1Y3QgZHJtX2k5MTVfZ2VtX29iamVjdCAqb2JqKQo+PiDCoCDCoMKgwqDC
oMKgwqDCoMKgwqAgc2dfc2V0X3BhZ2Uoc2csIHBhZ2UsIFBBR0VfU0laRSA8PCBvcmRlciwgMCk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzZ19wYWdlX3NpemVzIHw9IFBBR0VfU0laRSA8PCBvcmRl
cjsKPj4gLcKgwqDCoMKgwqDCoMKgIHN0LT5uZW50cysrOwo+PiArwqDCoMKgwqDCoMKgwqAgc3Qt
Pm5lbnRzID0gc3QtPm9yaWdfbmVudHMgPSBzdC0+bmVudHMgKyAxOwo+PiDCoCDCoMKgwqDCoMKg
wqDCoMKgwqAgbnBhZ2VzIC09IDEgPDwgb3JkZXI7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IW5wYWdlcykgewo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVf
Z2VtX3JlZ2lvbi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9yZWdp
b24uYwo+PiBpbmRleCAxNTE1Mzg0Li41OGNhNTYwIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fcmVnaW9uLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZ2VtL2k5MTVfZ2VtX3JlZ2lvbi5jCj4+IEBAIC01Myw3ICs1Myw3IEBACj4+IMKgwqDC
oMKgwqAgR0VNX0JVR19PTihsaXN0X2VtcHR5KGJsb2NrcykpOwo+PiDCoCDCoMKgwqDCoMKgIHNn
ID0gc3QtPnNnbDsKPj4gLcKgwqDCoCBzdC0+bmVudHMgPSAwOwo+PiArwqDCoMKgIHN0LT5uZW50
cyA9IHN0LT5vcmlnX25lbnRzID0gMDsKPj4gwqDCoMKgwqDCoCBzZ19wYWdlX3NpemVzID0gMDsK
Pj4gwqDCoMKgwqDCoCBwcmV2X2VuZCA9IChyZXNvdXJjZV9zaXplX3QpLTE7Cj4+IMKgIEBAIC03
OCw3ICs3OCw3IEBACj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNnLT5sZW5ndGgg
PSBibG9ja19zaXplOwo+PiDCoCAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdC0+bmVudHMrKzsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3QtPm5lbnRzID0gc3QtPm9yaWdfbmVudHMgPSBz
dC0+bmVudHMgKyAxOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2ctPmxlbmd0aCArPSBibG9ja19zaXplOwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzZ19kbWFfbGVuKHNnKSArPSBibG9ja19zaXplOwo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMgCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMKPj4gaW5kZXggNWQ1ZDdlZS4u
ODUxYTczMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2Vt
X3NobWVtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVt
LmMKPj4gQEAgLTgwLDcgKzgwLDcgQEAgc3RhdGljIGludCBzaG1lbV9nZXRfcGFnZXMoc3RydWN0
IAo+PiBkcm1faTkxNV9nZW1fb2JqZWN0ICpvYmopCj4+IMKgwqDCoMKgwqAgbm9yZWNsYWltIHw9
IF9fR0ZQX05PUkVUUlkgfCBfX0dGUF9OT1dBUk47Cj4+IMKgIMKgwqDCoMKgwqAgc2cgPSBzdC0+
c2dsOwo+PiAtwqDCoMKgIHN0LT5uZW50cyA9IDA7Cj4+ICvCoMKgwqAgc3QtPm5lbnRzID0gc3Qt
Pm9yaWdfbmVudHMgPSAwOwo+PiDCoMKgwqDCoMKgIHNnX3BhZ2Vfc2l6ZXMgPSAwOwo+PiDCoMKg
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCBwYWdlX2NvdW50OyBpKyspIHsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnN0IHVuc2lnbmVkIGludCBzaHJpbmtbXSA9IHsKPj4gQEAgLTE0MCw3ICsxNDAs
OCBAQCBzdGF0aWMgaW50IHNobWVtX2dldF9wYWdlcyhzdHJ1Y3QgCj4+IGRybV9pOTE1X2dlbV9v
YmplY3QgKm9iaikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZ19wYWdl
X3NpemVzIHw9IHNnLT5sZW5ndGg7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2cgPSBzZ19uZXh0KHNnKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdC0+bmVudHMrKzsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3QtPm5lbnRzID0gc3QtPm9yaWdfbmVudHMgPSBzdC0+bmVudHMgKyAxOwo+Cj4gQSBi
aXQgaGlnaGVyIHVwLCBub3Qgc2hvd24gaW4gdGhlIHBhdGNoLCB3ZSBoYXZlIGFsbG9jYXRlZCBh
IHRhYmxlIHZpYSAKPiBzZ19hbGxvY190YWJsZSBnaXZpbmcgaXQgYSBwZXNzaW1pc3RpYyBtYXgg
bmVudHMsIHNvbWV0aW1lcyBtdWNoIAo+IGxhcmdlciB0aGFuIHRoZSBzdC0+bmVudHMgdGhpcyBs
b29wcyB3aWxsIGNyZWF0ZS4gQnV0IG9yaWdfbmVudHMgaGFzIAo+IGJlZW4gbm93IGJlZW4gb3Zl
cndyaXR0ZW4uIFdpbGwgdGhhdCBsZWFrIG1lbW9yeSBjb21lIHNnX3RhYmxlX2ZyZWU/CgpJbmRl
ZWQgdGhpcyB3aWxsIGxlYWsgbWVtb3J5LiBJJ20gbWlzc2VkIHRoYXQgc2dfdHJpbSgpIHdpbGwg
YWRqdXN0IApuZW50cyBhbmQgb3JpZ19uZW50cy4KCkkgd2lsbCBkcm9wIHRob3NlIGNoYW5nZXMg
YXMgdGhleSBhcmUgb25seSBhIGNyZWF0aXZlIChvciBoYWNreSkgd2F5IG9mIAp1c2luZyBzZ190
YWJsZSBhbmQgc2NhdHRlcmxpc3RzLgoKPiBBcyBtaW5pbXVtIGl0IHdpbGwgbmVyZiBvdXIgaTkx
NV9zZ190cmltIG9wdGltaXphdGlvbiBhIGJpdCBsb3dlciAKPiBkb3duLCBhbHNvIG5vdCBzaG93
biBpbiB0aGUgZGlmZi4KPgo+ID4gWy4uLl0KCkJlc3QgcmVnYXJkcwotLSAKTWFyZWsgU3p5cHJv
d3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
