Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19145C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 08:07:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27342186A
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 08:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27342186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 824F287E84;
	Thu, 18 Jun 2020 08:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPOOzxiGeEJZ; Thu, 18 Jun 2020 08:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7300B87D6E;
	Thu, 18 Jun 2020 08:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB9BC07FF;
	Thu, 18 Jun 2020 08:07:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15FF5C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A94986B26
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5LiV4Ucu7psK for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 08:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E3D2E86203
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:05:58 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05I84GQo094657; Thu, 18 Jun 2020 04:05:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31r1qbcnx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 04:05:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05I84Tsu095683;
 Thu, 18 Jun 2020 04:05:26 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31r1qbcnwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 04:05:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I84kMX000783;
 Thu, 18 Jun 2020 08:05:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma02fra.de.ibm.com with ESMTP id 31r0dvr499-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 08:05:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05I85KSa50659410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 08:05:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2316A405C;
 Thu, 18 Jun 2020 08:05:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C8E3A405F;
 Thu, 18 Jun 2020 08:05:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.12.179])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2020 08:05:19 +0000 (GMT)
Subject: Re: [PATCH v2 02/12] ocxl: Change type of pasid to unsigned int
To: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>,
 Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-3-git-send-email-fenghua.yu@intel.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
Date: Thu, 18 Jun 2020 10:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592008893-9388-3-git-send-email-fenghua.yu@intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-18_04:2020-06-17,
 2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 cotscore=-2147483648 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180057
X-Mailman-Approved-At: Thu, 18 Jun 2020 08:07:50 +0000
Cc: iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
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

CgpMZSAxMy8wNi8yMDIwIMOgIDAyOjQxLCBGZW5naHVhIFl1IGEgw6ljcml0wqA6Cj4gUEFTSUQg
aXMgZGVmaW5lZCBhcyAiaW50IiBhbHRob3VnaCBpdCdzIGEgMjAtYml0IHZhbHVlIGFuZCBzaG91
bGRuJ3QgYmUKPiBuZWdhdGl2ZSBpbnQuIFRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0eXBlIGRlZmlu
ZWQgaW4gaW9tbXUsIGRlZmluZSBQQVNJRAo+IGFzICJ1bnNpZ25lZCBpbnQiLgoKCkl0IGxvb2tz
IGxpa2UgdGhpcyBwYXRjaCB3YXMgY29uc2lkZXJlZCBiZWNhdXNlIG9mIHRoZSB1c2Ugb2YgJ3Bh
c2lkJyBpbiAKdmFyaWFibGUgb3IgZnVuY3Rpb24gbmFtZXMuIFRoZSBvY3hsIGRyaXZlciBvbmx5
IG1ha2VzIHNlbnNlIG9uIHBvd2VycGMgCmFuZCBzaG91bGRuJ3QgY29tcGlsZSBvbiBhbnl0aGlu
ZyBlbHNlLCBzbyBpdCdzIHByb2JhYmx5IHVzZWxlc3MgaW4gdGhlIApjb250ZXh0IG9mIHRoYXQg
c2VyaWVzLgpUaGUgcGFzaWQgaGVyZSBpcyBkZWZpbmVkIGJ5IHRoZSBvcGVuY2FwaSBzcGVjaWZp
Y2F0aW9uIAooaHR0cHM6Ly9vcGVuY2FwaS5vcmcpLCBpdCBpcyBib3Jyb3dlZCBmcm9tIHRoZSBQ
Q0kgd29ybGQgYW5kIHlvdSBjb3VsZCAKYXJndWUgaXQgY291bGQgYmUgYW4gdW5zaWduZWQgaW50
LiBCdXQgdGhlbiBJIHRoaW5rIHRoZSBwYXRjaCBkb2Vzbid0IGdvIApmYXIgZW5vdWdoLiBCdXQg
Y29uc2lkZXJpbmcgaXQncyBub3QgdXNlZCBvbiB4ODYsIEkgdGhpbmsgdGhpcyBwYXRjaCBjYW4g
CmJlIGRyb3BwZWQuCgogICBGcmVkCgoKCj4gU3VnZ2VzdGVkLWJ5OiBUaG9tYXMgR2xlaXhuZXIg
PHRnbHhAbGludXRyb25peC5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBGZW5naHVhIFl1IDxmZW5naHVh
Lnl1QGludGVsLmNvbT4KPiBSZXZpZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwu
Y29tPgo+IC0tLQo+IHYyOgo+IC0gQ3JlYXRlIHRoaXMgbmV3IHBhdGNoIHRvIGRlZmluZSBQQVNJ
RCBhcyAidW5zaWduZWQgaW50IiBjb25zaXN0ZW50bHkgaW4KPiAgICBvY3hsIChUaG9tYXMpCj4g
Cj4gICBkcml2ZXJzL21pc2Mvb2N4bC9jb25maWcuYyAgICAgICAgfCAgMyArKy0KPiAgIGRyaXZl
cnMvbWlzYy9vY3hsL2xpbmsuYyAgICAgICAgICB8ICA2ICsrKy0tLQo+ICAgZHJpdmVycy9taXNj
L29jeGwvb2N4bF9pbnRlcm5hbC5oIHwgIDYgKysrLS0tCj4gICBkcml2ZXJzL21pc2Mvb2N4bC9w
YXNpZC5jICAgICAgICAgfCAgMiArLQo+ICAgZHJpdmVycy9taXNjL29jeGwvdHJhY2UuaCAgICAg
ICAgIHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0KPiAgIGluY2x1ZGUvbWlzYy9vY3hsLmggICAg
ICAgICAgICAgICB8ICA2ICsrKy0tLQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspLCAyMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwv
Y29uZmlnLmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb25maWcuYwo+IGluZGV4IGM4ZTE5YmZiNWVm
OS4uMjJkMDM0Y2FlZDNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5j
Cj4gKysrIGIvZHJpdmVycy9taXNjL29jeGwvY29uZmlnLmMKPiBAQCAtODA2LDcgKzgwNiw4IEBA
IGludCBvY3hsX2NvbmZpZ19zZXRfVEwoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHRsX2R2c2Vj
KQo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwob2N4bF9jb25maWdfc2V0X1RMKTsKPiAgIAo+
IC1pbnQgb2N4bF9jb25maWdfdGVybWluYXRlX3Bhc2lkKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGlu
dCBhZnVfY29udHJvbCwgaW50IHBhc2lkKQo+ICtpbnQgb2N4bF9jb25maWdfdGVybWluYXRlX3Bh
c2lkKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBhZnVfY29udHJvbCwKPiArCQkJCXVuc2lnbmVk
IGludCBwYXNpZCkKPiAgIHsKPiAgIAl1MzIgdmFsOwo+ICAgCXVuc2lnbmVkIGxvbmcgdGltZW91
dDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwvbGluay5jIGIvZHJpdmVycy9taXNj
L29jeGwvbGluay5jCj4gaW5kZXggNThkMTExYWZkOWY2Li45MzFmNmFlMDIyZGIgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9taXNjL29jeGwvbGluay5jCj4gKysrIGIvZHJpdmVycy9taXNjL29jeGwv
bGluay5jCj4gQEAgLTQ5Miw3ICs0OTIsNyBAQCBzdGF0aWMgdTY0IGNhbGN1bGF0ZV9jZmdfc3Rh
dGUoYm9vbCBrZXJuZWwpCj4gICAJcmV0dXJuIHN0YXRlOwo+ICAgfQo+ICAgCj4gLWludCBvY3hs
X2xpbmtfYWRkX3BlKHZvaWQgKmxpbmtfaGFuZGxlLCBpbnQgcGFzaWQsIHUzMiBwaWRyLCB1MzIg
dGlkciwKPiAraW50IG9jeGxfbGlua19hZGRfcGUodm9pZCAqbGlua19oYW5kbGUsIHVuc2lnbmVk
IGludCBwYXNpZCwgdTMyIHBpZHIsIHUzMiB0aWRyLAo+ICAgCQl1NjQgYW1yLCBzdHJ1Y3QgbW1f
c3RydWN0ICptbSwKPiAgIAkJdm9pZCAoKnhzbF9lcnJfY2IpKHZvaWQgKmRhdGEsIHU2NCBhZGRy
LCB1NjQgZHNpc3IpLAo+ICAgCQl2b2lkICp4c2xfZXJyX2RhdGEpCj4gQEAgLTU3Miw3ICs1NzIs
NyBAQCBpbnQgb2N4bF9saW5rX2FkZF9wZSh2b2lkICpsaW5rX2hhbmRsZSwgaW50IHBhc2lkLCB1
MzIgcGlkciwgdTMyIHRpZHIsCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChvY3hsX2xpbmtf
YWRkX3BlKTsKPiAgIAo+IC1pbnQgb2N4bF9saW5rX3VwZGF0ZV9wZSh2b2lkICpsaW5rX2hhbmRs
ZSwgaW50IHBhc2lkLCBfX3UxNiB0aWQpCj4gK2ludCBvY3hsX2xpbmtfdXBkYXRlX3BlKHZvaWQg
KmxpbmtfaGFuZGxlLCB1bnNpZ25lZCBpbnQgcGFzaWQsIF9fdTE2IHRpZCkKPiAgIHsKPiAgIAlz
dHJ1Y3Qgb2N4bF9saW5rICpsaW5rID0gKHN0cnVjdCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7
Cj4gICAJc3RydWN0IHNwYSAqc3BhID0gbGluay0+c3BhOwo+IEBAIC02MDgsNyArNjA4LDcgQEAg
aW50IG9jeGxfbGlua191cGRhdGVfcGUodm9pZCAqbGlua19oYW5kbGUsIGludCBwYXNpZCwgX191
MTYgdGlkKQo+ICAgCXJldHVybiByYzsKPiAgIH0KPiAgIAo+IC1pbnQgb2N4bF9saW5rX3JlbW92
ZV9wZSh2b2lkICpsaW5rX2hhbmRsZSwgaW50IHBhc2lkKQo+ICtpbnQgb2N4bF9saW5rX3JlbW92
ZV9wZSh2b2lkICpsaW5rX2hhbmRsZSwgdW5zaWduZWQgaW50IHBhc2lkKQo+ICAgewo+ICAgCXN0
cnVjdCBvY3hsX2xpbmsgKmxpbmsgPSAoc3RydWN0IG9jeGxfbGluayAqKSBsaW5rX2hhbmRsZTsK
PiAgIAlzdHJ1Y3Qgc3BhICpzcGEgPSBsaW5rLT5zcGE7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWlzYy9vY3hsL29jeGxfaW50ZXJuYWwuaCBiL2RyaXZlcnMvbWlzYy9vY3hsL29jeGxfaW50ZXJu
YWwuaAo+IGluZGV4IDM0NWJmODQzYTM4ZS4uM2NhOTgyYmE3NDcyIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvbWlzYy9vY3hsL29jeGxfaW50ZXJuYWwuaAo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hs
L29jeGxfaW50ZXJuYWwuaAo+IEBAIC00MSw3ICs0MSw3IEBAIHN0cnVjdCBvY3hsX2FmdSB7Cj4g
ICAJc3RydWN0IG9jeGxfYWZ1X2NvbmZpZyBjb25maWc7Cj4gICAJaW50IHBhc2lkX2Jhc2U7Cj4g
ICAJaW50IHBhc2lkX2NvdW50OyAvKiBvcGVuZWQgY29udGV4dHMgKi8KPiAtCWludCBwYXNpZF9t
YXg7IC8qIG1heGltdW0gbnVtYmVyIG9mIGNvbnRleHRzICovCj4gKwl1bnNpZ25lZCBpbnQgcGFz
aWRfbWF4OyAvKiBtYXhpbXVtIG51bWJlciBvZiBjb250ZXh0cyAqLwo+ICAgCWludCBhY3RhZ19i
YXNlOwo+ICAgCWludCBhY3RhZ19lbmFibGVkOwo+ICAgCXN0cnVjdCBtdXRleCBjb250ZXh0c19s
b2NrOwo+IEBAIC02OSw3ICs2OSw3IEBAIHN0cnVjdCBvY3hsX3hzbF9lcnJvciB7Cj4gICAKPiAg
IHN0cnVjdCBvY3hsX2NvbnRleHQgewo+ICAgCXN0cnVjdCBvY3hsX2FmdSAqYWZ1Owo+IC0JaW50
IHBhc2lkOwo+ICsJdW5zaWduZWQgaW50IHBhc2lkOwo+ICAgCXN0cnVjdCBtdXRleCBzdGF0dXNf
bXV0ZXg7Cj4gICAJZW51bSBvY3hsX2NvbnRleHRfc3RhdHVzIHN0YXR1czsKPiAgIAlzdHJ1Y3Qg
YWRkcmVzc19zcGFjZSAqbWFwcGluZzsKPiBAQCAtMTI4LDcgKzEyOCw3IEBAIGludCBvY3hsX2Nv
bmZpZ19jaGVja19hZnVfaW5kZXgoc3RydWN0IHBjaV9kZXYgKmRldiwKPiAgICAqIHBhc2lkOiB0
aGUgUEFTSUQgZm9yIHRoZSBBRlUgY29udGV4dAo+ICAgICogdGlkOiB0aGUgbmV3IHRocmVhZCBp
ZCBmb3IgdGhlIHByb2Nlc3MgZWxlbWVudAo+ICAgICovCj4gLWludCBvY3hsX2xpbmtfdXBkYXRl
X3BlKHZvaWQgKmxpbmtfaGFuZGxlLCBpbnQgcGFzaWQsIF9fdTE2IHRpZCk7Cj4gK2ludCBvY3hs
X2xpbmtfdXBkYXRlX3BlKHZvaWQgKmxpbmtfaGFuZGxlLCB1bnNpZ25lZCBpbnQgcGFzaWQsIF9f
dTE2IHRpZCk7Cj4gICAKPiAgIGludCBvY3hsX2NvbnRleHRfbW1hcChzdHJ1Y3Qgb2N4bF9jb250
ZXh0ICpjdHgsCj4gICAJCQlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSk7Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWlzYy9vY3hsL3Bhc2lkLmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9wYXNpZC5j
Cj4gaW5kZXggZDE0Y2I1NmU2OTIwLi5hMTUxZmM4ZjBiZWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9taXNjL29jeGwvcGFzaWQuYwo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL3Bhc2lkLmMKPiBA
QCAtODAsNyArODAsNyBAQCBzdGF0aWMgdm9pZCByYW5nZV9mcmVlKHN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQsIHUzMiBzdGFydCwgdTMyIHNpemUsCj4gICAKPiAgIGludCBvY3hsX3Bhc2lkX2FmdV9h
bGxvYyhzdHJ1Y3Qgb2N4bF9mbiAqZm4sIHUzMiBzaXplKQo+ICAgewo+IC0JaW50IG1heF9wYXNp
ZDsKPiArCXVuc2lnbmVkIGludCBtYXhfcGFzaWQ7Cj4gICAKPiAgIAlpZiAoZm4tPmNvbmZpZy5t
YXhfcGFzaWRfbG9nIDwgMCkKPiAgIAkJcmV0dXJuIC1FTk9TUEM7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWlzYy9vY3hsL3RyYWNlLmggYi9kcml2ZXJzL21pc2Mvb2N4bC90cmFjZS5oCj4gaW5k
ZXggMTdlMjFjYjJhZGRkLi4wMTllMmZjNjNiMWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9taXNj
L29jeGwvdHJhY2UuaAo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL3RyYWNlLmgKPiBAQCAtOSwx
MyArOSwxMyBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L3RyYWNlcG9pbnQuaD4KPiAgIAo+ICAgREVD
TEFSRV9FVkVOVF9DTEFTUyhvY3hsX2NvbnRleHQsCj4gLQlUUF9QUk9UTyhwaWRfdCBwaWQsIHZv
aWQgKnNwYSwgaW50IHBhc2lkLCB1MzIgcGlkciwgdTMyIHRpZHIpLAo+ICsJVFBfUFJPVE8ocGlk
X3QgcGlkLCB2b2lkICpzcGEsIHVuc2lnbmVkIGludCBwYXNpZCwgdTMyIHBpZHIsIHUzMiB0aWRy
KSwKPiAgIAlUUF9BUkdTKHBpZCwgc3BhLCBwYXNpZCwgcGlkciwgdGlkciksCj4gICAKPiAgIAlU
UF9TVFJVQ1RfX2VudHJ5KAo+ICAgCQlfX2ZpZWxkKHBpZF90LCBwaWQpCj4gICAJCV9fZmllbGQo
dm9pZCosIHNwYSkKPiAtCQlfX2ZpZWxkKGludCwgcGFzaWQpCj4gKwkJX19maWVsZCh1bnNpZ25l
ZCBpbnQsIHBhc2lkKQo+ICAgCQlfX2ZpZWxkKHUzMiwgcGlkcikKPiAgIAkJX19maWVsZCh1MzIs
IHRpZHIpCj4gICAJKSwKPiBAQCAtMzgsMjEgKzM4LDIxIEBAIERFQ0xBUkVfRVZFTlRfQ0xBU1Mo
b2N4bF9jb250ZXh0LAo+ICAgKTsKPiAgIAo+ICAgREVGSU5FX0VWRU5UKG9jeGxfY29udGV4dCwg
b2N4bF9jb250ZXh0X2FkZCwKPiAtCVRQX1BST1RPKHBpZF90IHBpZCwgdm9pZCAqc3BhLCBpbnQg
cGFzaWQsIHUzMiBwaWRyLCB1MzIgdGlkciksCj4gKwlUUF9QUk9UTyhwaWRfdCBwaWQsIHZvaWQg
KnNwYSwgdW5zaWduZWQgaW50IHBhc2lkLCB1MzIgcGlkciwgdTMyIHRpZHIpLAo+ICAgCVRQX0FS
R1MocGlkLCBzcGEsIHBhc2lkLCBwaWRyLCB0aWRyKQo+ICAgKTsKPiAgIAo+ICAgREVGSU5FX0VW
RU5UKG9jeGxfY29udGV4dCwgb2N4bF9jb250ZXh0X3JlbW92ZSwKPiAtCVRQX1BST1RPKHBpZF90
IHBpZCwgdm9pZCAqc3BhLCBpbnQgcGFzaWQsIHUzMiBwaWRyLCB1MzIgdGlkciksCj4gKwlUUF9Q
Uk9UTyhwaWRfdCBwaWQsIHZvaWQgKnNwYSwgdW5zaWduZWQgaW50IHBhc2lkLCB1MzIgcGlkciwg
dTMyIHRpZHIpLAo+ICAgCVRQX0FSR1MocGlkLCBzcGEsIHBhc2lkLCBwaWRyLCB0aWRyKQo+ICAg
KTsKPiAgIAo+ICAgVFJBQ0VfRVZFTlQob2N4bF90ZXJtaW5hdGVfcGFzaWQsCj4gLQlUUF9QUk9U
TyhpbnQgcGFzaWQsIGludCByYyksCj4gKwlUUF9QUk9UTyh1bnNpZ25lZCBpbnQgcGFzaWQsIGlu
dCByYyksCj4gICAJVFBfQVJHUyhwYXNpZCwgcmMpLAo+ICAgCj4gICAJVFBfU1RSVUNUX19lbnRy
eSgKPiAtCQlfX2ZpZWxkKGludCwgcGFzaWQpCj4gKwkJX19maWVsZCh1bnNpZ25lZCBpbnQsIHBh
c2lkKQo+ICAgCQlfX2ZpZWxkKGludCwgcmMpCj4gICAJKSwKPiAgIAo+IEBAIC0xMDcsMTEgKzEw
NywxMSBAQCBERUZJTkVfRVZFTlQob2N4bF9mYXVsdF9oYW5kbGVyLCBvY3hsX2ZhdWx0X2FjaywK
PiAgICk7Cj4gICAKPiAgIFRSQUNFX0VWRU5UKG9jeGxfYWZ1X2lycV9hbGxvYywKPiAtCVRQX1BS
T1RPKGludCBwYXNpZCwgaW50IGlycV9pZCwgdW5zaWduZWQgaW50IHZpcnEsIGludCBod19pcnEp
LAo+ICsJVFBfUFJPVE8odW5zaWduZWQgaW50IHBhc2lkLCBpbnQgaXJxX2lkLCB1bnNpZ25lZCBp
bnQgdmlycSwgaW50IGh3X2lycSksCj4gICAJVFBfQVJHUyhwYXNpZCwgaXJxX2lkLCB2aXJxLCBo
d19pcnEpLAo+ICAgCj4gICAJVFBfU1RSVUNUX19lbnRyeSgKPiAtCQlfX2ZpZWxkKGludCwgcGFz
aWQpCj4gKwkJX19maWVsZCh1bnNpZ25lZCBpbnQsIHBhc2lkKQo+ICAgCQlfX2ZpZWxkKGludCwg
aXJxX2lkKQo+ICAgCQlfX2ZpZWxkKHVuc2lnbmVkIGludCwgdmlycSkKPiAgIAkJX19maWVsZChp
bnQsIGh3X2lycSkKPiBAQCAtMTMzLDExICsxMzMsMTEgQEAgVFJBQ0VfRVZFTlQob2N4bF9hZnVf
aXJxX2FsbG9jLAo+ICAgKTsKPiAgIAo+ICAgVFJBQ0VfRVZFTlQob2N4bF9hZnVfaXJxX2ZyZWUs
Cj4gLQlUUF9QUk9UTyhpbnQgcGFzaWQsIGludCBpcnFfaWQpLAo+ICsJVFBfUFJPVE8odW5zaWdu
ZWQgaW50IHBhc2lkLCBpbnQgaXJxX2lkKSwKPiAgIAlUUF9BUkdTKHBhc2lkLCBpcnFfaWQpLAo+
ICAgCj4gICAJVFBfU1RSVUNUX19lbnRyeSgKPiAtCQlfX2ZpZWxkKGludCwgcGFzaWQpCj4gKwkJ
X19maWVsZCh1bnNpZ25lZCBpbnQsIHBhc2lkKQo+ICAgCQlfX2ZpZWxkKGludCwgaXJxX2lkKQo+
ICAgCSksCj4gICAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9taXNjL29jeGwuaCBiL2luY2x1ZGUv
bWlzYy9vY3hsLmgKPiBpbmRleCAwNmRkNTgzOWU0MzguLjVlY2EwNGM4ZGE5NyAxMDA2NDQKPiAt
LS0gYS9pbmNsdWRlL21pc2Mvb2N4bC5oCj4gKysrIGIvaW5jbHVkZS9taXNjL29jeGwuaAo+IEBA
IC00MjksNyArNDI5LDcgQEAgaW50IG9jeGxfY29uZmlnX3NldF9UTChzdHJ1Y3QgcGNpX2RldiAq
ZGV2LCBpbnQgdGxfZHZzZWMpOwo+ICAgICogZGVzaXJlZCBBRlUuIEl0IGNhbiBiZSBmb3VuZCBp
biB0aGUgQUZVIGNvbmZpZ3VyYXRpb24KPiAgICAqLwo+ICAgaW50IG9jeGxfY29uZmlnX3Rlcm1p
bmF0ZV9wYXNpZChzdHJ1Y3QgcGNpX2RldiAqZGV2LAo+IC0JCQkJaW50IGFmdV9jb250cm9sX29m
ZnNldCwgaW50IHBhc2lkKTsKPiArCQkJCWludCBhZnVfY29udHJvbF9vZmZzZXQsIHVuc2lnbmVk
IGludCBwYXNpZCk7Cj4gICAKPiAgIC8qCj4gICAgKiBSZWFkIHRoZSBjb25maWd1cmF0aW9uIHNw
YWNlIG9mIGEgZnVuY3Rpb24gYW5kIGZpbGwgaW4gYQo+IEBAIC00NjYsNyArNDY2LDcgQEAgdm9p
ZCBvY3hsX2xpbmtfcmVsZWFzZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCB2b2lkICpsaW5rX2hhbmRs
ZSk7Cj4gICAgKiAneHNsX2Vycl9kYXRhJyBpcyBhbiBhcmd1bWVudCBwYXNzZWQgdG8gdGhlIGFi
b3ZlIGNhbGxiYWNrLCBpZgo+ICAgICogZGVmaW5lZAo+ICAgICovCj4gLWludCBvY3hsX2xpbmtf
YWRkX3BlKHZvaWQgKmxpbmtfaGFuZGxlLCBpbnQgcGFzaWQsIHUzMiBwaWRyLCB1MzIgdGlkciwK
PiAraW50IG9jeGxfbGlua19hZGRfcGUodm9pZCAqbGlua19oYW5kbGUsIHVuc2lnbmVkIGludCBw
YXNpZCwgdTMyIHBpZHIsIHUzMiB0aWRyLAo+ICAgCQl1NjQgYW1yLCBzdHJ1Y3QgbW1fc3RydWN0
ICptbSwKPiAgIAkJdm9pZCAoKnhzbF9lcnJfY2IpKHZvaWQgKmRhdGEsIHU2NCBhZGRyLCB1NjQg
ZHNpc3IpLAo+ICAgCQl2b2lkICp4c2xfZXJyX2RhdGEpOwo+IEBAIC00NzQsNyArNDc0LDcgQEAg
aW50IG9jeGxfbGlua19hZGRfcGUodm9pZCAqbGlua19oYW5kbGUsIGludCBwYXNpZCwgdTMyIHBp
ZHIsIHUzMiB0aWRyLAo+ICAgLyoKPiAgICAqIFJlbW92ZSBhIFByb2Nlc3MgRWxlbWVudCBmcm9t
IHRoZSBTaGFyZWQgUHJvY2VzcyBBcmVhIGZvciBhIGxpbmsKPiAgICAqLwo+IC1pbnQgb2N4bF9s
aW5rX3JlbW92ZV9wZSh2b2lkICpsaW5rX2hhbmRsZSwgaW50IHBhc2lkKTsKPiAraW50IG9jeGxf
bGlua19yZW1vdmVfcGUodm9pZCAqbGlua19oYW5kbGUsIHVuc2lnbmVkIGludCBwYXNpZCk7Cj4g
ICAKPiAgIC8qCj4gICAgKiBBbGxvY2F0ZSBhbiBBRlUgaW50ZXJydXB0IGFzc29jaWF0ZWQgdG8g
dGhlIGxpbmsuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
