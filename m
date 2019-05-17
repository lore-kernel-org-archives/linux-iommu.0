Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A706CC04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 08:22:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8133920818
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 08:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8133920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39AB79EE;
	Fri, 17 May 2019 08:22:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 740635A8
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 08:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 67D0787B
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 08:22:26 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4H8I7RA033691
	for <iommu@lists.linux-foundation.org>; Fri, 17 May 2019 04:22:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2shr31kwye-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 17 May 2019 04:22:25 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Fri, 17 May 2019 09:17:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 May 2019 09:17:19 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4H8HIE849741984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 17 May 2019 08:17:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F4CAE055;
	Fri, 17 May 2019 08:17:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D004AE053;
	Fri, 17 May 2019 08:17:17 +0000 (GMT)
Received: from [9.145.153.112] (unknown [9.145.153.112])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2019 08:17:17 +0000 (GMT)
Subject: Re: [PATCH 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
To: Alex Williamson <alex.williamson@redhat.com>
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
	<1557476555-20256-5-git-send-email-pmorel@linux.ibm.com>
	<20190516124026.415bf671@x1.home>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 May 2019 10:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516124026.415bf671@x1.home>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051708-0028-0000-0000-0000036EA8CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051708-0029-0000-0000-0000242E46CE
Message-Id: <29209ea1-be49-47bc-c258-6e87da055fac@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-17_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905170056
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, sebott@linux.vnet.ibm.com,
	walling@linux.ibm.com, linux-kernel@vger.kernel.org,
	borntraeger@de.ibm.com, iommu@lists.linux-foundation.org,
	schwidefsky@de.ibm.com, gerald.schaefer@de.ibm.com
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
Reply-To: pmorel@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMTYvMDUvMjAxOSAyMDo0MCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+IE9uIEZyaSwgMTAg
TWF5IDIwMTkgMTA6MjI6MzUgKzAyMDAKPiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5pYm0u
Y29tPiB3cm90ZToKPiAKPj4gV2UgaW1wbGVtZW50IGEgY2FwYWJpbGl0eSBpbnRlcmNhZmUgZm9y
IFZGSU9fSU9NTVVfR0VUX0lORk8gYW5kIGFkZCB0aGUKPj4gZmlyc3QgY2FwYWJpbGl0eTogVkZJ
T19JT01NVV9JTkZPX0NBUEFCSUxJVElFUy4KPj4KPj4gV2hlbiBjYWxsaW5nIHRoZSBpb2N0bCwg
dGhlIHVzZXIgbXVzdCBzcGVjaWZ5Cj4+IFZGSU9fSU9NTVVfSU5GT19DQVBBQklMSVRJRVMgdG8g
cmV0cmlldmUgdGhlIGNhcGFiaWxpdGllcyBhbmQgbXVzdCBjaGVjawo+PiBpbiB0aGUgYW5zd2Vy
IGlmIGNhcGFiaWxpdGllcyBhcmUgc3VwcG9ydGVkLgo+PiBPbGRlciBrZXJuZWwgd2lsbCBub3Qg
Y2hlY2sgbm9yIHNldCB0aGUgVkZJT19JT01NVV9JTkZPX0NBUEFCSUxJVElFUyBpbgo+PiB0aGUg
ZmxhZ3Mgb2YgdmZpb19pb21tdV90eXBlMV9pbmZvLgo+Pgo+PiBUaGUgaW9tbXUgZ2V0X2F0dHIg
Y2FsbGJhY2sgd2lsbCBiZSBjYWxsZWQgdG8gcmV0cmlldmUgdGhlIHNwZWNpZmljCj4+IGF0dHJp
YnV0ZXMgYW5kIGZpbGwgdGhlIGNhcGFiaWxpdGllcywgVkZJT19JT01NVV9JTkZPX0NBUF9RRk4g
Zm9yIHRoZQo+PiBQQ0kgcXVlcnkgZnVuY3Rpb24gYXR0cmlidXRlcyBhbmQgVkZJT19JT01NVV9J
TkZPX0NBUF9RR1JQIGZvciB0aGUKPj4gUENJIHF1ZXJ5IGZ1bmN0aW9uIGdyb3VwLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5pYm0uY29tPgo+PiAtLS0K
Pj4gICBkcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jIHwgOTUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOTQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL3Zm
aW9faW9tbXVfdHlwZTEuYyBiL2RyaXZlcnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMKPj4gaW5k
ZXggZDBmNzMxYy4uZjdmODEyMCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZmlvL3ZmaW9faW9t
bXVfdHlwZTEuYwo+PiArKysgYi9kcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jCj4+IEBA
IC0xNjU4LDYgKzE2NTgsNzAgQEAgc3RhdGljIGludCB2ZmlvX2RvbWFpbnNfaGF2ZV9pb21tdV9j
YWNoZShzdHJ1Y3QgdmZpb19pb21tdSAqaW9tbXUpCj4+ICAgCXJldHVybiByZXQ7Cj4+ICAgfQo+
PiAgIAo+PiAraW50IHZmaW9faW9tbXVfdHlwZTFfY2FwcyhzdHJ1Y3QgdmZpb19pb21tdSAqaW9t
bXUsIHN0cnVjdCB2ZmlvX2luZm9fY2FwICpjYXBzLAo+PiArCQkJICBzaXplX3Qgc2l6ZSkKPj4g
K3sKPj4gKwlzdHJ1Y3QgdmZpb19kb21haW4gKmQ7Cj4+ICsJc3RydWN0IHZmaW9faW9tbXVfdHlw
ZTFfaW5mb19ibG9jayAqaW5mb19mbjsKPj4gKwlzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9pbmZv
X2Jsb2NrICppbmZvX2dycDsKPj4gKwl1bnNpZ25lZCBsb25nIHRvdGFsX3NpemUsIGZuX3NpemUs
IGdycF9zaXplOwo+PiArCWludCByZXQ7Cj4+ICsKPj4gKwlkID0gbGlzdF9maXJzdF9lbnRyeSgm
aW9tbXUtPmRvbWFpbl9saXN0LCBzdHJ1Y3QgdmZpb19kb21haW4sIG5leHQpOwo+PiArCWlmICgh
ZCkKPj4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4+ICsJLyogVGhlIHNpemUgb2YgdGhlc2UgY2FwYWJp
bGl0aWVzIGFyZSBkZXZpY2UgZGVwZW5kZW50ICovCj4+ICsJZm5fc2l6ZSA9IGlvbW11X2RvbWFp
bl9nZXRfYXR0cihkLT5kb21haW4sCj4+ICsJCQkJCURPTUFJTl9BVFRSX1pQQ0lfRk5fU0laRSwg
TlVMTCk7Cj4+ICsJaWYgKGZuX3NpemUgPCAwKQo+PiArCQlyZXR1cm4gZm5fc2l6ZTsKPiAKPiBX
aGF0IGlmIG5vbi1aIGFyY2hzIHdhbnQgdG8gdXNlIHRoaXM/ICBUaGUgZnVuY3Rpb24gaXMgYXJj
aGl0ZWN0ZWQKPiBzcGVjaWZpY2FsbHkgZm9yIHRoaXMgb25lIHVzZSBjYXNlLCBmYWlsIGlmIGFu
eSBjb21wb25lbnQgaXMgbm90IHRoZXJlCj4gd2hpY2ggbWVhbnMgaXQgcmVxdWlyZXMgYSByZS13
cml0ZSB0byBhZGQgZnVydGhlciBzdXBwb3J0LiAgSWYKPiBaUENJX0ZOX1NJWkUgaXNuJ3Qgc3Vw
cG9ydCwgbW92ZSBvbiB0byB0aGUgbmV4dCB0aGluZy4KCnllcywgY2xlYXIuCgo+IAo+PiArCWZu
X3NpemUgKz0gIHNpemVvZihzdHJ1Y3QgdmZpb19pbmZvX2NhcF9oZWFkZXIpOwo+PiArCXRvdGFs
X3NpemUgPSBmbl9zaXplOwo+IAo+IEhlcmUgdG9vLCB0b3RhbF9zaXplIHNob3VsZCBiZSBpbml0
aWFsaXplZCB0byB6ZXJvIGFuZCBlYWNoIHNlY3Rpb24gKz0KPiB0aGUgc2l6ZSB0aGV5J2QgbGlr
ZSB0byBhZGQuCgp0aGFua3MsIGNsZWFyIHRvby4KCj4gCj4+ICsKPj4gKwlncnBfc2l6ZSA9IGlv
bW11X2RvbWFpbl9nZXRfYXR0cihkLT5kb21haW4sCj4+ICsJCQkJCSBET01BSU5fQVRUUl9aUENJ
X0dSUF9TSVpFLCBOVUxMKTsKPj4gKwlpZiAoZ3JwX3NpemUgPCAwKQo+PiArCQlyZXR1cm4gZ3Jw
X3NpemU7Cj4+ICsJZ3JwX3NpemUgKz0gIHNpemVvZihzdHJ1Y3QgdmZpb19pbmZvX2NhcF9oZWFk
ZXIpOwo+PiArCXRvdGFsX3NpemUgKz0gZ3JwX3NpemU7Cj4+ICsKPj4gKwkvKiBUZWxsIGNhbGxl
ciB0byBjYWxsIHVzIHdpdGggYSBncmVhdGVyIGJ1ZmZlciAqLwo+PiArCWlmICh0b3RhbF9zaXpl
ID4gc2l6ZSkgewo+PiArCQljYXBzLT5zaXplID0gdG90YWxfc2l6ZTsKPj4gKwkJcmV0dXJuIDA7
Cj4+ICsJfQo+PiArCj4+ICsJaW5mb19mbiA9IGt6YWxsb2MoZm5fc2l6ZSwgR0ZQX0tFUk5FTCk7
Cj4+ICsJaWYgKCFpbmZvX2ZuKQo+PiArCQlyZXR1cm4gLUVOT01FTTsKPiAKPiBNYXliZSBmbl9z
aXplIHdhcyB6ZXJvIGJlY2F1c2Ugd2UncmUgbm90IG9uIFouCj4gCj4+ICsJcmV0ID0gaW9tbXVf
ZG9tYWluX2dldF9hdHRyKGQtPmRvbWFpbiwKPj4gKwkJCQkgICAgRE9NQUlOX0FUVFJfWlBDSV9G
TiwgJmluZm9fZm4tPmRhdGEpOwo+IAo+IEtlcm5lbCBpbnRlcm5hbCBzdHJ1Y3R1cmVzICE9IHVz
ZXIgYXBpLiAgVGhhbmtzLAo+IAo+IEFsZXgKClRoYW5rcyBhIGxvdCBBbGV4LApJIHVuZGVyc3Rh
bmQgdGhlIGNvbmNlcm5zLCBJIHdhcyB0b28gZm9jdXNzZWQgb24gWiwgSSB3aWxsIHJld29yayB0
aGlzIAphcyB5b3Ugc2FpZDoKLSBkZWZpbml0aW9uIG9mIHRoZSB1c2VyIEFQSSBhbmQKLSB0YWtl
IGNhcmUgdGhhdCBhbm90aGVyIGFyY2hpdGVjdHVyZSBtYXkgd2FudCB0byB1c2UgdGhlIGludGVy
ZmFjZS4KClJlZ2FyZHMsClBpZXJyZQoKCgotLSAKUGllcnJlIE1vcmVsCkxpbnV4L0tWTS9RRU1V
IGluIELDtmJsaW5nZW4gLSBHZXJtYW55CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
