Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C5C10F0E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:47:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0AA20693
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 06:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhF7Fogm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0AA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25757A7F;
	Mon, 15 Apr 2019 06:47:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 89A53A5E
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:47:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76B76823
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 06:47:09 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3F6iIjT148277; Mon, 15 Apr 2019 06:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=/5Uxmide7W9gl7rmjYHhYH9XEi+gX7190BWTpclzFg0=;
	b=nhF7FogmvUEp7PhklKxgrbRR+GLZ2Eoj1Po5389TnGlbSp58m1B78QaIIK3SkasRK7oq
	0WpcwhaMZyNn1OIRhH60yD36ovmzfy4NI1ej9pFAYLXC06WpKN668LA6JFv3bf9b52gA
	WEwjRXhp5Aeceg3kd924YRBggi0Bi+brz1OWDvNaisM85HoJ1+QKAqdU1SEEgTRLL8m4
	0kbK8Z/HThkU3eW9gFi8DguQjYnGzBJNms6o88Nr7W6juseQnugt7f0MZ/N7iZV0O+ef
	+L08yrzswqmrnAmgyWjY4VHtDQuNu7bwmTPl00r4NJ4eXf2UPb/bVVX30ZRrUwZA4/7q
	aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2ru76t4pty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 06:47:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3F6k6jl110089; Mon, 15 Apr 2019 06:47:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2rv2tu0p7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 06:47:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3F6l2gx031609;
	Mon, 15 Apr 2019 06:47:02 GMT
Received: from [10.182.69.106] (/10.182.69.106)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 14 Apr 2019 23:47:02 -0700
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
To: Joe Jin <joe.jin@oracle.com>, iommu@lists.linux-foundation.org,
	konrad.wilk@oracle.com
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
	<5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
Date: Mon, 15 Apr 2019 14:50:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150045
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150045
Cc: haakon.bugge@oracle.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	hch@lst.de
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415065049.7jay10jRa_mY1-y4_TF4xNa6POc5hwgAtscgLDm9DyQ@z>

QXMgdGhlIHBhdGNoIHRvIGJlIGZpeGVkIGlzIHN0aWxsIGluIEtvbnJhZCdzIG93biB0cmVlLCBJ
IHdpbGwgc2VuZCB0aGUgdjIgZm9yCnRoZSBwYXRjaCB0byBiZSBmaXhlZCwgaW5zdGVhZCBvZiBh
biBpbmNyZW1lbnRhbCBmaXguCgpEb25nbGkgWmhhbmcKCk9uIDQvMTIvMTkgMTA6MTMgUE0sIEpv
ZSBKaW4gd3JvdGU6Cj4gSSdtIGdvb2QgdG8gaGF2ZSB0aGlzIHBhdGNoLCB3aGljaCBoZWxwcyBp
ZGVudGlmeSB0aGUgY2F1c2Ugb2YgZmFpbHVyZSBpcwo+IGZyYWdtZW50YXRpb24gb3IgaXQgcmVh
bGx5IGJlZW4gdXNlZCB1cC4KPiAKPiBPbiA0LzEyLzE5IDQ6MzggQU0sIERvbmdsaSBaaGFuZyB3
cm90ZToKPj4gV2hlbiBzd2lvdGxiIGlzIGZ1bGwsIHRoZSBrZXJuZWwgd291bGQgcHJpbnQgaW9f
dGxiX3VzZWQuIEhvd2V2ZXIsIHRoZQo+PiByZXN1bHQgbWlnaHQgYmUgaW5hY2N1cmF0ZSBhdCB0
aGF0IHRpbWUgYmVjYXVzZSB3ZSBoYXZlIGxlZnQgdGhlIGNyaXRpY2FsCj4+IHNlY3Rpb24gcHJv
dGVjdGVkIGJ5IHNwaW5sb2NrLgo+Pgo+PiBUaGVyZWZvcmUsIHdlIGJhY2t1cCB0aGUgaW9fdGxi
X3VzZWQgaW50byBsb2NhbCB2YXJpYWJsZSBiZWZvcmUgbGVhdmluZwo+PiBjcml0aWNhbCBzZWN0
aW9uLgo+Pgo+PiBGaXhlczogODNjYTI1OTQ4OTQwICgic3dpb3RsYjogZHVtcCB1c2VkIGFuZCB0
b3RhbCBzbG90cyB3aGVuIHN3aW90bGIgYnVmZmVyIGlzIGZ1bGwiKQo+PiBTdWdnZXN0ZWQtYnk6
IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6
IERvbmdsaSBaaGFuZyA8ZG9uZ2xpLnpoYW5nQG9yYWNsZS5jb20+Cj4gCj4gUmV2aWV3ZWQtYnk6
IEpvZSBKaW4gPGpvZS5qaW5Ab3JhY2xlLmNvbT4gCj4gCj4gVGhhbmtzLAo+IEpvZQo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
