Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC9C10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAE020850
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P6a0VI7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAE020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C27A514DC;
	Fri, 12 Apr 2019 14:14:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8EBDEF12
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 14:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 385ECF4
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 14:14:08 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3CEAcBf192576; Fri, 12 Apr 2019 14:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=bGNr2bNF9zPMPBOf6iXYHxRclpUpvUUNKwzCvvoEZns=;
	b=P6a0VI7z7akJn0xpbERiwcIcSOohvx2IWYCIB+54018Sd4jHZ9Dh2DSfVu+dNKkmnLMP
	TYDJ0OLy2P8mwjdMOGLDdz5hxnwvluOzPjc8B/oImopZRQSghphXfc9C+Hw/G/6LJUm9
	S6zGMr8rHM4e6uO5ZwOWQ9eX1P2a4VbzeelZi6+PsYiAk1FbdNLOuKkUda6/hKjky1NT
	A+JqN6DQbnkiMbB9lcBp8JSfLMqWvg/JyMS+3sUPx3Q3tSVS9ZlC27ZSIcx9hzsuKdic
	NE9vg+K7bBm7o5pWuIy7tkPi7nJCBxZJFU7lbwmEJvANAMw1AkNlEmLmaJp2pXPqtiG6
	ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2rpkhterkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2019 14:14:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3CEDBlE093705; Fri, 12 Apr 2019 14:14:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2rtqnp3y4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2019 14:14:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3CEE01r005826;
	Fri, 12 Apr 2019 14:14:00 GMT
Received: from [10.211.46.126] (/10.211.46.126)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 12 Apr 2019 07:14:00 -0700
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
To: Dongli Zhang <dongli.zhang@oracle.com>, iommu@lists.linux-foundation.org, 
	konrad.wilk@oracle.com
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
From: Joe Jin <joe.jin@oracle.com>
Message-ID: <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
Date: Fri, 12 Apr 2019 07:13:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
	Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904120094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904120093
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
Message-ID: <20190412141359.FjXuTGGKnMKcmiy3aoAbBMWHqeqW13A6IvGmoNyR-mQ@z>

SSdtIGdvb2QgdG8gaGF2ZSB0aGlzIHBhdGNoLCB3aGljaCBoZWxwcyBpZGVudGlmeSB0aGUgY2F1
c2Ugb2YgZmFpbHVyZSBpcwpmcmFnbWVudGF0aW9uIG9yIGl0IHJlYWxseSBiZWVuIHVzZWQgdXAu
CgpPbiA0LzEyLzE5IDQ6MzggQU0sIERvbmdsaSBaaGFuZyB3cm90ZToKPiBXaGVuIHN3aW90bGIg
aXMgZnVsbCwgdGhlIGtlcm5lbCB3b3VsZCBwcmludCBpb190bGJfdXNlZC4gSG93ZXZlciwgdGhl
Cj4gcmVzdWx0IG1pZ2h0IGJlIGluYWNjdXJhdGUgYXQgdGhhdCB0aW1lIGJlY2F1c2Ugd2UgaGF2
ZSBsZWZ0IHRoZSBjcml0aWNhbAo+IHNlY3Rpb24gcHJvdGVjdGVkIGJ5IHNwaW5sb2NrLgo+IAo+
IFRoZXJlZm9yZSwgd2UgYmFja3VwIHRoZSBpb190bGJfdXNlZCBpbnRvIGxvY2FsIHZhcmlhYmxl
IGJlZm9yZSBsZWF2aW5nCj4gY3JpdGljYWwgc2VjdGlvbi4KPiAKPiBGaXhlczogODNjYTI1OTQ4
OTQwICgic3dpb3RsYjogZHVtcCB1c2VkIGFuZCB0b3RhbCBzbG90cyB3aGVuIHN3aW90bGIgYnVm
ZmVyIGlzIGZ1bGwiKQo+IFN1Z2dlc3RlZC1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VA
b3JhY2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEb25nbGkgWmhhbmcgPGRvbmdsaS56aGFuZ0Bv
cmFjbGUuY29tPgoKUmV2aWV3ZWQtYnk6IEpvZSBKaW4gPGpvZS5qaW5Ab3JhY2xlLmNvbT4gCgpU
aGFua3MsCkpvZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
