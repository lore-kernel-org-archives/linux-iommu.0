Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF001C04AAF
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 11:19:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC6720815
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 11:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC6720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47468CBA;
	Mon, 20 May 2019 11:19:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2897CB5
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 11:19:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD70B892
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 11:19:33 +0000 (UTC)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4KBI268115184
	for <iommu@lists.linux-foundation.org>; Mon, 20 May 2019 07:19:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2skrbeqk4c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Mon, 20 May 2019 07:19:32 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Mon, 20 May 2019 12:19:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 20 May 2019 12:19:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4KBJOY747841290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 20 May 2019 11:19:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C60AE051;
	Mon, 20 May 2019 11:19:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E9EAE045;
	Mon, 20 May 2019 11:19:23 +0000 (GMT)
Received: from [9.145.24.80] (unknown [9.145.24.80])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 May 2019 11:19:23 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
From: Pierre Morel <pmorel@linux.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
	<1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
	<20190517104143.240082b5@x1.home>
	<92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
Date: Mon, 20 May 2019 13:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052011-0020-0000-0000-0000033E8C6A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052011-0021-0000-0000-0000219162BD
Message-Id: <ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-20_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=926 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905200080
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, sebott@linux.vnet.ibm.com,
	walling@linux.ibm.com, linux-kernel@vger.kernel.org,
	borntraeger@de.ibm.com, iommu@lists.linux-foundation.org,
	schwidefsky@de.ibm.com, robin.murphy@arm.com, gerald.schaefer@de.ibm.com
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

T24gMTcvMDUvMjAxOSAyMDowNCwgUGllcnJlIE1vcmVsIHdyb3RlOgo+IE9uIDE3LzA1LzIwMTkg
MTg6NDEsIEFsZXggV2lsbGlhbXNvbiB3cm90ZToKPj4gT24gRnJpLCAxNyBNYXkgMjAxOSAxODox
Njo1MCArMDIwMAo+PiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5pYm0uY29tPiB3cm90ZToK
Pj4KPj4+IFdlIGltcGxlbWVudCB0aGUgY2FwYWJpbGl0eSBpbnRlcmZhY2UgZm9yIFZGSU9fSU9N
TVVfR0VUX0lORk8uCj4+Pgo+Pj4gV2hlbiBjYWxsaW5nIHRoZSBpb2N0bCwgdGhlIHVzZXIgbXVz
dCBzcGVjaWZ5Cj4+PiBWRklPX0lPTU1VX0lORk9fQ0FQQUJJTElUSUVTIHRvIHJldHJpZXZlIHRo
ZSBjYXBhYmlsaXRpZXMgYW5kCj4+PiBtdXN0IGNoZWNrIGluIHRoZSBhbnN3ZXIgaWYgY2FwYWJp
bGl0aWVzIGFyZSBzdXBwb3J0ZWQuCj4+Pgo+Pj4gVGhlIGlvbW11IGdldF9hdHRyIGNhbGxiYWNr
IHdpbGwgYmUgdXNlZCB0byByZXRyaWV2ZSB0aGUgc3BlY2lmaWMKPj4+IGF0dHJpYnV0ZXMgYW5k
IGZpbGwgdGhlIGNhcGFiaWxpdGllcy4KPj4+Cj4+PiBDdXJyZW50bHkgdHdvIFotUENJIHNwZWNp
ZmljIGNhcGFiaWxpdGllcyB3aWxsIGJlIHF1ZXJpZWQgYW5kCj4+PiBmaWxsZWQgYnkgdGhlIHVu
ZGVybHlpbmcgWiBzcGVjaWZpYyBzMzkwX2lvbW11Ogo+Pj4gVkZJT19JT01NVV9JTkZPX0NBUF9R
Rk4gZm9yIHRoZSBQQ0kgcXVlcnkgZnVuY3Rpb24gYXR0cmlidXRlcwo+Pj4gYW5kCj4+PiBWRklP
X0lPTU1VX0lORk9fQ0FQX1FHUlAgZm9yIHRoZSBQQ0kgcXVlcnkgZnVuY3Rpb24gZ3JvdXAuCj4+
Pgo+Pj4gT3RoZXIgYXJjaGl0ZWN0dXJlcyBtYXkgYWRkIG5ldyBjYXBhYmlsaXRpZXMgaW4gdGhl
IHNhbWUgd2F5Cj4+PiBhZnRlciBlbmhhbmNpbmcgdGhlIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBJ
T01NVSBkcml2ZXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJlIE1vcmVsIDxwbW9yZWxA
bGludXguaWJtLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlw
ZTEuYyB8IDEyMiAKPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jIAo+Pj4g
Yi9kcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jCj4+PiBpbmRleCBkMGY3MzFjLi45NDM1
NjQ3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYwo+Pj4g
KysrIGIvZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYwo+Pj4gQEAgLTE2NTgsNiArMTY1
OCw5NyBAQCBzdGF0aWMgaW50IAo+Pj4gdmZpb19kb21haW5zX2hhdmVfaW9tbXVfY2FjaGUoc3Ry
dWN0IHZmaW9faW9tbXUgKmlvbW11KQo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gwqAg
fQo+Pj4gK3N0YXRpYyBpbnQgdmZpb19pb21tdV90eXBlMV96cGNpX2ZuKHN0cnVjdCBpb21tdV9k
b21haW4gKmRvbWFpbiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgdmZpb19pbmZvX2NhcCAqY2Fwcywgc2l6ZV90IHNpemUpCj4+PiArewo+Pj4gK8Kg
wqDCoCBzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9pbmZvX3BjaWZuICppbmZvX2ZuOwo+Pj4gK8Kg
wqDCoCBpbnQgcmV0Owo+Pj4gKwo+Pj4gK8KgwqDCoCBpbmZvX2ZuID0ga3phbGxvYyhzaXplLCBH
RlBfS0VSTkVMKTsKPj4+ICvCoMKgwqAgaWYgKCFpbmZvX2ZuKQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PTUVNOwo+Pj4gKwo+Pj4gK8KgwqDCoCByZXQgPSBpb21tdV9kb21haW5fZ2V0
X2F0dHIoZG9tYWluLCBET01BSU5fQVRUUl9aUENJX0ZOLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZpbmZvX2ZuLT5yZXNwb25zZSk7Cj4+Cj4+IFdoYXQgZW5z
dXJlcyB0aGF0IHRoZSAnc3RydWN0IGNscF9yc3BfcXVlcnlfcGNpJyByZXR1cm5lZCBmcm9tIHRo
aXMKPj4gZ2V0X2F0dHIgcmVtYWlucyBjb25zaXN0ZW50IHdpdGggYSAnc3RydWN0IHZmaW9faW9t
bXVfcGNpX2Z1bmN0aW9uJz8KPj4gV2h5IGRvZXMgdGhlIGxhdHRlciBjb250YWlucyBzbyBtYW55
IHJlc2VydmVkIGZpZWxkcyAoYmV5b25kIHNpbXBseQo+PiBhbGlnbm1lbnQpIGZvciBhIHVzZXIg
QVBJP8KgIFdoYXQgZmllbGRzIG9mIHRoZXNlIHN0cnVjdHVyZXMgYXJlCj4+IGFjdHVhbGx5IHVz
ZWZ1bCB0byB1c2Vyc3BhY2U/wqAgU2hvdWxkIGFueSBmaWVsZHMgbm90IGJlIGV4cG9zZWQgdG8g
dGhlCj4+IHVzZXI/wqAgQXJlbid0IEJBUiBzaXplcyByZWR1bmRhbnQgdG8gd2hhdCdzIGF2YWls
YWJsZSB0aHJvdWdoIHRoZSB2ZmlvCj4+IFBDSSBBUEk/wqAgSSdtIGFmcmFpZCB0aGF0IHNpbXBs
eSByZWRlZmluaW5nIGFuIGludGVybmFsIHN0cnVjdHVyZSBhcwo+PiB0aGUgQVBJIGxlYXZlcyBh
IGxvdCB0byBiZSBkZXNpcmVkIHRvby7CoCBUaGFua3MsCj4+Cj4+IEFsZXgKPj4KPiBIaSBBbGV4
LAo+IAo+IEkgc2ltcGx5IHVzZWQgdGhlIHN0cnVjdHVyZSByZXR1cm5lZCBieSB0aGUgZmlybXdh
cmUgdG8gYmUgc3VyZSB0byBiZSAKPiBjb25zaXN0ZW50IHdpdGggZnV0dXJlIGV2b2x1dGlvbnMg
YW5kIGZhY2lsaXRhdGUgdGhlIGNvcHkgZnJvbSBDTFAgYW5kIAo+IHRvIHVzZXJsYW5kLgo+IAo+
IElmIHlvdSBwcmVmZXIsIGFuZCBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIGlzIHRoZSBjYXNlLCBJ
IGNhbiBkZWZpbmUgYSAKPiBzcGVjaWZpYyBWRklPX0lPTU1VIHN0cnVjdHVyZSB3aXRoIG9ubHkg
dGhlIGZpZWxkcyByZWxldmFudCB0byB0aGUgdXNlciwgCj4gbGVhdmluZyBmdXR1cmUgZW5oYW5j
ZW1lbnQgb2YgdGhlIHVzZXIncyBpbnRlcmZhY2UgYmVpbmcgaW1wbGVtZW50ZWQgaW4gCj4gYW5v
dGhlciBrZXJuZWwgcGF0Y2ggd2hlbiB0aGUgdGltZSBoYXMgY29tZS4KPiAKPiBJbiBmYWN0LCB0
aGUgc3RydWN0IHdpbGwgaGF2ZSBhbGwgZGVmaW5lZCBmaWVsZHMgSSB1c2VkIGJ1dCBub3QgdGhl
IEJBUiAKPiBzaXplIGFuZCBhZGRyZXNzIChhdCBsZWFzdCBmb3Igbm93IGJlY2F1c2UgdGhlcmUg
YXJlIHNwZWNpYWwgY2FzZXMgd2UgZG8gCj4gbm90IHN1cHBvcnQgeWV0IHdpdGggYmFycykuCj4g
QWxsIHRoZSByZXNlcnZlZCBmaWVsZHMgY2FuIGdvIGF3YXkuCj4gCj4gSXMgaXQgbW9yZSBjb25m
b3JtIHRvIHlvdXIgaWRlYT8KPiAKPiBBbHNvIEkgaGF2ZSAyIGludGVyZmFjZXM6Cj4gCj4gczM5
MF9pb21tdS5nZXRfYXR0ciA8LUkxLT4gVkZJT19JT01NVSA8LUkyLT4gdXNlcmxhbmQKPiAKPiBE
byB5b3UgcHJlZmVyOgo+IC0gMiBkaWZmZXJlbnQgc3RydWN0dXJlcywgbm8gQ0xQIHJhdyBzdHJ1
Y3R1cmUKPiAtIHRoZSBDTFAgcmF3IHN0cnVjdHVyZSBmb3IgSTEgYW5kIGEgVkZJTyBzcGVjaWZp
YyBzdHJ1Y3R1cmUgZm9yIEkyCgpIaSBBbGV4LAoKSSBhbSBiYWNrIGFnYWluIG9uIHRoaXMuClRo
aXMgc29sdXRpb24gaGVyZSBhYm92ZSBzZWVtcyB0byBtZSB0aGUgYmVzdCBvbmUgYnV0IGluIHRo
aXMgd2F5IEkgbXVzdCAKaW5jbHVkZSBTMzkwIHNwZWNpZmljIGluY2x1ZGUgaW5zaWRlIHRoZSBp
b21tdV90eXBlMSwgd2hpY2ggaXMgQUZBSVUgbm90IAphIGdvb2QgdGhpbmcuCkl0IHNlZW1zIHRo
YXQgdGhlIHBvd2VycGMgYXJjaGl0ZWN0dXJlIHVzZSBhIHNvbHV0aW9uIHdpdGggYSBkZWRpY2F0
ZWQgClZGSU9fSU9NTVUsIHRoZSB2ZmlvX2lvbW11X3NwYXJfdGNlLgoKV291bGRuJ3QgaXQgYmUg
YSBzb2x1dGlvbiBmb3IgczM5MCB0b28sIHRvIHVzZSB0aGUgdmZpb19pb21tdV90eXBlMSBhcyBh
IApiYXNpcyB0byBoYXZlIGEgczM5MCBkZWRpY2F0ZWQgc29sdXRpb24uClRoZW4gaXQgYmVjb21l
cyBlYXNpZXIgdG8gaGF2ZSBvbiBvbmUgc2lkZSB0aGUgczM5MF9pb21tdSBpbnRlcmZhY2UsIApT
MzkwIHNwZWNpZmljLCBhbmQgb24gdGhlIG90aGVyIHNpZGUgYSBWRklPIGludGVyZmFjZSB3aXRo
b3V0IGEgYmxpbmQgCmNvcHkgb2YgdGhlIGZpcm13YXJlIHZhbHVlcy4KCkRvIHlvdSB0aGluayBp
dCBpcyBhIHZpYWJsZSBzb2x1dGlvbj8KClRoYW5rcywKUGllcnJlCgoKCj4gLSB0aGUgc2FtZSBW
RklPIHN0cnVjdHVyZSBmb3IgYm90aCBJMSBhbmQgSTIKPiAKPiBUaGFuayB5b3UgaWYgeW91IGNv
dWxkIGdpdmUgbWUgYSBkaXJlY3Rpb24gZm9yIHRoaXMuCj4gCj4gVGhhbmtzIGZvciB0aGUgY29t
bWVudHMsIGFuZCB0aGFua3MgYSBsb3QgdG8gaGF2ZSBhbnN3ZXJlZCBzbyBxdWlja2x5Lgo+IAo+
IFBpZXJyZQo+IAo+IAo+IAo+IAo+IAo+IAo+IAoKCi0tIApQaWVycmUgTW9yZWwKTGludXgvS1ZN
L1FFTVUgaW4gQsO2YmxpbmdlbiAtIEdlcm1hbnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
