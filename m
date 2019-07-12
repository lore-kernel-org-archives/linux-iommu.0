Return-Path: <SRS0=rccM=VJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64748C742A8
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 05:51:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36587208E4
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 05:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36587208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0587D5654;
	Fri, 12 Jul 2019 05:51:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D9E37564B
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 05:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D86C883
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 05:41:13 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6C5bevJ015254
	for <iommu@lists.linux-foundation.org>; Fri, 12 Jul 2019 01:41:12 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2tpj96kwp5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 12 Jul 2019 01:41:12 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <bauerman@linux.ibm.com>;
	Fri, 12 Jul 2019 06:41:11 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
	by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 12 Jul 2019 06:41:07 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
	[9.57.199.109])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x6C5f5vh40042908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 12 Jul 2019 05:41:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ECDB112061;
	Fri, 12 Jul 2019 05:41:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2586A112064;
	Fri, 12 Jul 2019 05:41:01 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.149.188])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2019 05:41:00 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: x86@kernel.org
Subject: [PATCH 0/3] Remove x86-specific code from generic headers
Date: Fri, 12 Jul 2019 02:36:28 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19071205-0060-0000-0000-0000035D6D9B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011413; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01230955; UDB=6.00648415;
	IPR=6.01012239; 
	MB=3.00027687; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 05:41:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071205-0061-0000-0000-00004A1B8F54
Message-Id: <20190712053631.9814-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-12_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=993 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907120058
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGVsbG8sCgpCb3RoIHBvd2VycGPCuSBhbmQgczM5MMKyIGFyZSBhZGRpbmcgPGFzbS9tZW1fZW5j
cnlwdC5oPiBoZWFkZXJzLiBDdXJyZW50bHksCnRoZXkgaGF2ZSB0byBzdXBwbHkgZGVmaW5pdGlv
bnMgZm9yIGZ1bmN0aW9ucyBhbmQgbWFjcm9zIHdoaWNoIG9ubHkgaGF2ZSBhCm1lYW5pbmcgb24g
eDg2OiBzbWVfbWVfbWFzaywgc21lX2FjdGl2ZSgpIGFuZCBzZXZfYWN0aXZlKCkuCgpDaHJpc3Rv
cGggSGVsbHdpZyBtYWRlIGEgc3VnZ2VzdGlvbiB0byAiY2xlYW4gdXAgdGhlIEtjb25maWcgYW5k
IGdlbmVyaWMKaGVhZGVycyBiaXRzIGZvciBtZW1vcnkgZW5jcnlwdGlvbiBzbyB0aGF0IHdlIGRv
bid0IG5lZWQgYWxsIHRoaXMKYm9pbGVycGxhdGUgY29kZSIsIGFuZCB0aGlzIGlzIHdoYXQgdGhp
cyBzZXJpZXMgZG9lcy4KCkFmdGVyIHRoaXMgcGF0Y2ggc2V0LCB0aGlzIGlzIHBvd2VycGMncyA8
YXNtL21lbV9lbmNyeXB0Lmg+OgoKICAgICNpZm5kZWYgX0FTTV9QT1dFUlBDX01FTV9FTkNSWVBU
X0gKICAgICNkZWZpbmUgX0FTTV9QT1dFUlBDX01FTV9FTkNSWVBUX0gKCiAgICAjaW5jbHVkZSA8
YXNtL3N2bS5oPgoKICAgIHN0YXRpYyBpbmxpbmUgYm9vbCBtZW1fZW5jcnlwdF9hY3RpdmUodm9p
ZCkKICAgIHsKCSAgICByZXR1cm4gaXNfc2VjdXJlX2d1ZXN0KCk7CiAgICB9CgogICAgc3RhdGlj
IGlubGluZSBib29sIGZvcmNlX2RtYV91bmVuY3J5cHRlZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAg
ICB7CgkgICAgcmV0dXJuIGlzX3NlY3VyZV9ndWVzdCgpOwogICAgfQoKICAgIGludCBzZXRfbWVt
b3J5X2VuY3J5cHRlZCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcyk7CiAgICBpbnQg
c2V0X21lbW9yeV9kZWNyeXB0ZWQodW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMpOwoK
ICAgICNlbmRpZiAvKiBfQVNNX1BPV0VSUENfTUVNX0VOQ1JZUFRfSCAqLwoKSSBkb24ndCBoYXZl
IGEgd2F5IHRvIHRlc3QgU01FIG5vciBTRVYsIHNvIHRoZSBwYXRjaGVzIGhhdmUgb25seSBiZWVu
IGJ1aWxkCnRlc3RlZC4gVGhleSBhc3N1bWUgdGhlIHByZXNlbmNlIG9mIHRoZSBmb2xsb3dpbmcg
dHdvIGNvbW1pdHM6CgpDb21taXQgNGViNWZlYzMxZTYxICgiZnMvcHJvYy92bWNvcmU6IEVuYWJs
ZSBkdW1waW5nIG9mIGVuY3J5cHRlZCBtZW1vcnkKd2hlbiBTRVYgd2FzIGFjdGl2ZSIpLCB3aGlj
aCBpcyBub3cgaW4gTGludXMnIG1hc3RlciBicmFuY2g7CgpDb21taXQgZTY3YTVlZDFmODZmICgi
ZG1hLWRpcmVjdDogRm9yY2UgdW5lbmNyeXB0ZWQgRE1BIHVuZGVyIFNNRSBmb3IKY2VydGFpbiBE
TUEgbWFza3MiKSwgd2hpY2ggaXMgaW4gZG1hLW1hcHBpbmcvZm9yLW5leHQgYW5kIGNvbWVzIGZy
b20gdGhpcwpwYXRjaDoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzEwYjgz
ZDlmZjMxYmNhODhlOTRkYTJmZjM0ZTMwNjE5ZWIzOTYwNzguMTU2Mjc4NTEyMy5naXQudGhvbWFz
LmxlbmRhY2t5QGFtZC5jb20vCgpUaGlhZ28gSnVuZyBCYXVlcm1hbm4gKDMpOgogIHg4Ni9LY29u
ZmlnOiBNb3ZlIEFSQ0hfSEFTX01FTV9FTkNSWVBUIHRvIGFyY2gvS2NvbmZpZwogIERNQSBtYXBw
aW5nOiBNb3ZlIFNNRSBoYW5kbGluZyB0byB4ODYtc3BlY2lmaWMgZmlsZXMKICBmcy9jb3JlL3Zt
Y29yZTogTW92ZSBzZXZfYWN0aXZlKCkgcmVmZXJlbmNlIHRvIHg4NiBhcmNoIGNvZGUKCiBhcmNo
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKysrCiBhcmNoL3g4Ni9LY29uZmln
ICAgICAgICAgICAgICAgICAgIHwgIDUgKystLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmggfCAgNyArKysrKysrCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5o
IHwgMTAgKysrKysrKysrKwogYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuYyAgICB8ICA1
ICsrKysrCiBmcy9wcm9jL3ZtY29yZS5jICAgICAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0K
IGluY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oICAgICAgICAgfCAxNCArKysrKysrKysrKysrKwog
aW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5oICAgICAgICB8IDE1ICstLS0tLS0tLS0tLS0tLQog
a2VybmVsL2RtYS9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAzICsrKwoga2VybmVsL2RtYS9t
YXBwaW5nLmMgICAgICAgICAgICAgICB8ICA0ICsrLS0KIGtlcm5lbC9kbWEvc3dpb3RsYi5jICAg
ICAgICAgICAgICAgfCAgMyArLS0KIDExIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyks
IDI1IGRlbGV0aW9ucygtKQoKLS0gCgrCuSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eHBw
Yy1kZXYvMjAxOTA1MjEwNDQ5MTIuMTM3NS0xMi1iYXVlcm1hbkBsaW51eC5pYm0uY29tLwrCsiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAxOTA2MTIxMTEyMzYuOTk1MzgtMi1wYXNpY0Bs
aW51eC5pYm0uY29tLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
