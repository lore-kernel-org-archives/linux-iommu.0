Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747A4C10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F57A206BA
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Om5tuL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F57A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DD706BA0;
	Fri, 12 Apr 2019 11:36:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 12860AA5
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 11:36:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A25FE76D
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 11:36:51 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3CBXaUq064783; Fri, 12 Apr 2019 11:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-type :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=lvEATiOX/reCATWgKO5W5Jr5NeYIp6H11K9cRiCr+oc=;
	b=3Om5tuL+sXrbgrKgaPqX5oCSInll/0qfQCtJBKp9/VudEH16zU6toERWfGWlILXyN/ne
	7ZcfiHo6Ye/QP6IrzAImgBnXGwZd4rvStdStGiqUoGwA6tiu4ZYIt0WmUDPg9MMc1Akz
	tq4aU6bUYD1J4SFTKCQxDPixnxsHc0uMSlK3qA/PTbM9SWOvcn0EZgWRd2zcIEEdVAUJ
	9wz9+qVJSQ2Mc1TldhDdo6ij/sTnoVuN6/pLlTX3dDqaNIcweEDhf2R2ql4VKxqlex2m
	p10FZ4eJlHiEgFoUt+R1cRLfnD3JXxl4ShJzfjcs820cdyvO9Xkjt1upuXUgfEqDPEdA
	kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2rphmex51t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2019 11:36:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3CBY2Ac142174; Fri, 12 Apr 2019 11:34:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2rtd84g8yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2019 11:34:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3CBYhJD011836;
	Fri, 12 Apr 2019 11:34:44 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 12 Apr 2019 04:34:43 -0700
From: Dongli Zhang <dongli.zhang@oracle.com>
To: iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Subject: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
Date: Fri, 12 Apr 2019 19:38:26 +0800
Message-Id: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904120076
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904120076
Cc: dongli.zhang@oracle.com, joe.jin@oracle.com, linux-kernel@vger.kernel.org,
	haakon.bugge@oracle.com, robin.murphy@arm.com, hch@lst.de
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
Message-ID: <20190412113826.uGDC9OdAqPQBpwD0KJqWMWbm5M1WOhrMVwI8DA2cWck@z>

V2hlbiBzd2lvdGxiIGlzIGZ1bGwsIHRoZSBrZXJuZWwgd291bGQgcHJpbnQgaW9fdGxiX3VzZWQu
IEhvd2V2ZXIsIHRoZQpyZXN1bHQgbWlnaHQgYmUgaW5hY2N1cmF0ZSBhdCB0aGF0IHRpbWUgYmVj
YXVzZSB3ZSBoYXZlIGxlZnQgdGhlIGNyaXRpY2FsCnNlY3Rpb24gcHJvdGVjdGVkIGJ5IHNwaW5s
b2NrLgoKVGhlcmVmb3JlLCB3ZSBiYWNrdXAgdGhlIGlvX3RsYl91c2VkIGludG8gbG9jYWwgdmFy
aWFibGUgYmVmb3JlIGxlYXZpbmcKY3JpdGljYWwgc2VjdGlvbi4KCkZpeGVzOiA4M2NhMjU5NDg5
NDAgKCJzd2lvdGxiOiBkdW1wIHVzZWQgYW5kIHRvdGFsIHNsb3RzIHdoZW4gc3dpb3RsYiBidWZm
ZXIgaXMgZnVsbCIpClN1Z2dlc3RlZC1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3Jh
Y2xlLmNvbT4KU2lnbmVkLW9mZi1ieTogRG9uZ2xpIFpoYW5nIDxkb25nbGkuemhhbmdAb3JhY2xl
LmNvbT4KLS0tCiBrZXJuZWwvZG1hL3N3aW90bGIuYyB8IDcgKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwv
ZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jCmluZGV4IDg1N2U4MjMuLjZmNzYx
OWMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9kbWEvc3dpb3RsYi5jCisrKyBiL2tlcm5lbC9kbWEvc3dp
b3RsYi5jCkBAIC00NTIsNiArNDUyLDcgQEAgcGh5c19hZGRyX3Qgc3dpb3RsYl90YmxfbWFwX3Np
bmdsZShzdHJ1Y3QgZGV2aWNlICpod2RldiwKIAl1bnNpZ25lZCBsb25nIG1hc2s7CiAJdW5zaWdu
ZWQgbG9uZyBvZmZzZXRfc2xvdHM7CiAJdW5zaWduZWQgbG9uZyBtYXhfc2xvdHM7CisJdW5zaWdu
ZWQgbG9uZyB0bXBfaW9fdGxiX3VzZWQ7CiAKIAlpZiAobm9faW90bGJfbWVtb3J5KQogCQlwYW5p
YygiQ2FuIG5vdCBhbGxvY2F0ZSBTV0lPVExCIGJ1ZmZlciBlYXJsaWVyIGFuZCBjYW4ndCBub3cg
cHJvdmlkZSB5b3Ugd2l0aCB0aGUgRE1BIGJvdW5jZSBidWZmZXIiKTsKQEAgLTUzOCwxMCArNTM5
LDEyIEBAIHBoeXNfYWRkcl90IHN3aW90bGJfdGJsX21hcF9zaW5nbGUoc3RydWN0IGRldmljZSAq
aHdkZXYsCiAJfSB3aGlsZSAoaW5kZXggIT0gd3JhcCk7CiAKIG5vdF9mb3VuZDoKKwl0bXBfaW9f
dGxiX3VzZWQgPSBpb190bGJfdXNlZDsKKwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlvX3Rs
Yl9sb2NrLCBmbGFncyk7CiAJaWYgKCEoYXR0cnMgJiBETUFfQVRUUl9OT19XQVJOKSAmJiBwcmlu
dGtfcmF0ZWxpbWl0KCkpCi0JCWRldl93YXJuKGh3ZGV2LCAic3dpb3RsYiBidWZmZXIgaXMgZnVs
bCAoc3o6ICV6ZCBieXRlcyksIHRvdGFsICVsdSwgdXNlZCAlbHVcbiIsCi0JCQkgc2l6ZSwgaW9f
dGxiX25zbGFicywgaW9fdGxiX3VzZWQpOworCQlkZXZfd2Fybihod2RldiwgInN3aW90bGIgYnVm
ZmVyIGlzIGZ1bGwgKHN6OiAlemQgYnl0ZXMpLCB0b3RhbCAlbHUgKHNsb3RzKSwgdXNlZCAlbHUg
KHNsb3RzKVxuIiwKKwkJCSBzaXplLCBpb190bGJfbnNsYWJzLCB0bXBfaW9fdGxiX3VzZWQpOwog
CXJldHVybiBETUFfTUFQUElOR19FUlJPUjsKIGZvdW5kOgogCWlvX3RsYl91c2VkICs9IG5zbG90
czsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
