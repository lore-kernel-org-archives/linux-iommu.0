Return-Path: <SRS0=UGLm=VK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17949C742A7
	for <iommu@archiver.kernel.org>; Sat, 13 Jul 2019 04:54:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70EA208E4
	for <iommu@archiver.kernel.org>; Sat, 13 Jul 2019 04:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70EA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9074C699E;
	Sat, 13 Jul 2019 04:54:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B237B5C28
	for <iommu@lists.linux-foundation.org>;
	Sat, 13 Jul 2019 04:46:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 12011CF
	for <iommu@lists.linux-foundation.org>;
	Sat, 13 Jul 2019 04:46:15 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6D4fZIg086192
	for <iommu@lists.linux-foundation.org>; Sat, 13 Jul 2019 00:46:15 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2tq7v61129-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Sat, 13 Jul 2019 00:46:15 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <bauerman@linux.ibm.com>;
	Sat, 13 Jul 2019 05:46:14 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
	by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sat, 13 Jul 2019 05:46:09 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x6D4k80Q56164730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 13 Jul 2019 04:46:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F21D0BE051;
	Sat, 13 Jul 2019 04:46:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B303BE04F;
	Sat, 13 Jul 2019 04:46:03 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.135.203])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2019 04:46:03 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: x86@kernel.org
Subject: [PATCH 0/3] Remove x86-specific code from generic headers
Date: Sat, 13 Jul 2019 01:45:51 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19071304-0012-0000-0000-0000174F2918
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011418; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01231409; UDB=6.00648690;
	IPR=6.01012701; 
	MB=3.00027699; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-13 04:46:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071304-0013-0000-0000-0000580BA0F3
Message-Id: <20190713044554.28719-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-13_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907130055
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
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

SGVsbG8sCgpUaGlzIHZlcnNpb24gbW9zdGx5IGNoYW5nZXMgcGF0Y2ggMi8zLCByZW1vdmluZyBk
bWFfY2hlY2tfbWFzaygpIGZyb20Ka2VybmVsL2RtYS9tYXBwaW5nLmMgYXMgc3VnZ2VzdGVkIGJ5
IENocmlzdG9waCBIZWxsd2lnLCBhbmQgYWxzbyBhZGFwdGluZwpzMzkwJ3MgPGFzbS9tZW1fZW5j
cnlwdC5oPi4gVGhlcmUncyBhbHNvIGEgc21hbGwgY2hhbmdlIGluIHBhdGNoIDEvMyBhcwptZW50
aW9uZWQgaW4gdGhlIGNoYW5nZWxvZyBiZWxvdy4KClBhdGNoIDMvMyBtYXkgb3IgbWF5IG5vdCBu
ZWVkIHRvIGNoYW5nZSBzMzkwIGNvZGUgZGVwZW5kaW5nIG9uIGhvdyBUb20KTGVuZGFja3kncyBw
YXRjaCBpcyBmaXhlZCB0byBhdm9pZCBicmVha2luZyB0aGF0IGFyY2hpdGVjdHVyZSwgc28gSSBo
YXZlbid0Cm1hZGUgYW55IGNoYW5nZXMgZm9yIG5vdy4KClRoZXNlIHBhdGNoZXMgYXJlIGFwcGxp
ZWQgb24gdG9wIG9mIHRvZGF5J3MgbWFzdGVyIHdoaWNoIGF0IHRoZSB0aW1lIHdhcyBhdApjb21t
aXQgOTc4N2FlZDU3ZGQzICgiY29yZXNpZ2h0OiBNYWtlIHRoZSBjb3Jlc2lnaHRfZGV2aWNlX2Z3
bm9kZV9tYXRjaApkZWNsYXJhdGlvbidzIGZ3bm9kZSBwYXJhbWV0ZXIgY29uc3QiKSwgcGx1cyBh
IGNoZXJyeS1waWNrIG9mIGNvbW1pdAplNjdhNWVkMWY4NmYgKCJkbWEtZGlyZWN0OiBGb3JjZSB1
bmVuY3J5cHRlZCBETUEgdW5kZXIgU01FIGZvciBjZXJ0YWluIERNQQptYXNrcyIpLCB3aGljaCBp
cyBpbiBkbWEtbWFwcGluZy9mb3ItbmV4dCBhbmQgY29tZXMgZnJvbSB0aGlzIHBhdGNoOgoKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMTBiODNkOWZmMzFiY2E4OGU5NGRhMmZm
MzRlMzA2MTllYjM5NjA3OC4xNTYyNzg1MTIzLmdpdC50aG9tYXMubGVuZGFja3lAYW1kLmNvbS8K
CkkgZG9uJ3QgaGF2ZSBhIHdheSB0byB0ZXN0IFNNRSwgU0VWLCBub3IgczM5MCdzIFBFRiBzbyB0
aGUgcGF0Y2hlcyBoYXZlIG9ubHkKYmVlbiBidWlsZCB0ZXN0ZWQuCgpPcmlnaW5hbCBjb3ZlciBs
ZXR0ZXIgYmVsb3c6CgpCb3RoIHBvd2VycGPCuSBhbmQgczM5MMKyIGFyZSBhZGRpbmcgPGFzbS9t
ZW1fZW5jcnlwdC5oPiBoZWFkZXJzLiBDdXJyZW50bHksCnRoZXkgaGF2ZSB0byBzdXBwbHkgZGVm
aW5pdGlvbnMgZm9yIGZ1bmN0aW9ucyBhbmQgbWFjcm9zIHdoaWNoIG9ubHkgaGF2ZSBhCm1lYW5p
bmcgb24geDg2OiBzbWVfbWVfbWFzaywgc21lX2FjdGl2ZSgpIGFuZCBzZXZfYWN0aXZlKCkuCgpD
aHJpc3RvcGggSGVsbHdpZyBtYWRlIGEgc3VnZ2VzdGlvbiB0byAiY2xlYW4gdXAgdGhlIEtjb25m
aWcgYW5kIGdlbmVyaWMKaGVhZGVycyBiaXRzIGZvciBtZW1vcnkgZW5jcnlwdGlvbiBzbyB0aGF0
IHdlIGRvbid0IG5lZWQgYWxsIHRoaXMKYm9pbGVycGxhdGUgY29kZSIsIGFuZCB0aGlzIGlzIHdo
YXQgdGhpcyBwYXRjaCBkb2VzLgoKQWZ0ZXIgdGhpcyBwYXRjaCBzZXQsIHRoaXMgaXMgcG93ZXJw
YydzIDxhc20vbWVtX2VuY3J5cHQuaD46CgogICAgI2lmbmRlZiBfQVNNX1BPV0VSUENfTUVNX0VO
Q1JZUFRfSAogICAgI2RlZmluZSBfQVNNX1BPV0VSUENfTUVNX0VOQ1JZUFRfSAoKICAgICNpbmNs
dWRlIDxhc20vc3ZtLmg+CgogICAgc3RhdGljIGlubGluZSBib29sIG1lbV9lbmNyeXB0X2FjdGl2
ZSh2b2lkKQogICAgewoJICAgIHJldHVybiBpc19zZWN1cmVfZ3Vlc3QoKTsKICAgIH0KCiAgICBz
dGF0aWMgaW5saW5lIGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRl
dikKICAgIHsKCSAgICByZXR1cm4gaXNfc2VjdXJlX2d1ZXN0KCk7CiAgICB9CgogICAgaW50IHNl
dF9tZW1vcnlfZW5jcnlwdGVkKHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBhZ2VzKTsKICAg
IGludCBzZXRfbWVtb3J5X2RlY3J5cHRlZCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdl
cyk7CgogICAgI2VuZGlmIC8qIF9BU01fUE9XRVJQQ19NRU1fRU5DUllQVF9IICovCgpDaGFuZ2Vs
b2cKClNpbmNlIHYxOgoKLSBQYXRjaCAieDg2LHMzOTA6IE1vdmUgQVJDSF9IQVNfTUVNX0VOQ1JZ
UFQgZGVmaW5pdGlvbiB0byBhcmNoL0tjb25maWciCiAgLSBSZW1vdmUgZGVmaW5pdGlvbiBvZiBB
UkNIX0hBU19NRU1fRU5DUllQVCBmcm9tIHMzOTAvS2NvbmZpZyBhcyB3ZWxsLgogIC0gUmV3b3Jk
ZWQgcGF0Y2ggdGl0bGUgYW5kIG1lc3NhZ2UgYSBsaXR0bGUgYml0LgoKLSBQYXRjaCAiRE1BIG1h
cHBpbmc6IE1vdmUgU01FIGhhbmRsaW5nIHRvIHg4Ni1zcGVjaWZpYyBmaWxlcyIKICAtIEFkYXB0
IHMzOTAncyA8YXNtL21lbV9lbmNyeXB0Lmg+IGFzIHdlbGwuCiAgLSBSZW1vdmUgZG1hX2NoZWNr
X21hc2soKSBmcm9tIGtlcm5lbC9kbWEvbWFwcGluZy5jLiBTdWdnZXN0ZWQgYnkKICAgIENocmlz
dG9waCBIZWxsd2lnLgoKLS0gCgrCuSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eHBwYy1k
ZXYvMjAxOTA1MjEwNDQ5MTIuMTM3NS0xMi1iYXVlcm1hbkBsaW51eC5pYm0uY29tLwrCsiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAxOTA2MTIxMTEyMzYuOTk1MzgtMi1wYXNpY0BsaW51
eC5pYm0uY29tLwoKVGhpYWdvIEp1bmcgQmF1ZXJtYW5uICgzKToKICB4ODYsczM5MDogTW92ZSBB
UkNIX0hBU19NRU1fRU5DUllQVCBkZWZpbml0aW9uIHRvIGFyY2gvS2NvbmZpZwogIERNQSBtYXBw
aW5nOiBNb3ZlIFNNRSBoYW5kbGluZyB0byB4ODYtc3BlY2lmaWMgZmlsZXMKICBmcy9jb3JlL3Zt
Y29yZTogTW92ZSBzZXZfYWN0aXZlKCkgcmVmZXJlbmNlIHRvIHg4NiBhcmNoIGNvZGUKCiBhcmNo
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICsrKwogYXJjaC9zMzkwL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgfCAgMyAtLS0KIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9tZW1f
ZW5jcnlwdC5oIHwgIDQgKy0tLQogYXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
fCAgNCArLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oICB8IDEwICsrKysr
KysrKysKIGFyY2gveDg2L2tlcm5lbC9jcmFzaF9kdW1wXzY0LmMgICAgIHwgIDUgKysrKysKIGZz
L3Byb2Mvdm1jb3JlLmMgICAgICAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0KIGluY2x1ZGUv
bGludXgvY3Jhc2hfZHVtcC5oICAgICAgICAgIHwgMTQgKysrKysrKysrKysrKysKIGluY2x1ZGUv
bGludXgvbWVtX2VuY3J5cHQuaCAgICAgICAgIHwgMTUgKy0tLS0tLS0tLS0tLS0tCiBrZXJuZWwv
ZG1hL21hcHBpbmcuYyAgICAgICAgICAgICAgICB8ICA4IC0tLS0tLS0tCiBrZXJuZWwvZG1hL3N3
aW90bGIuYyAgICAgICAgICAgICAgICB8ICAzICstLQogMTEgZmlsZXMgY2hhbmdlZCwgNDAgaW5z
ZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
