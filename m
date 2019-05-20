Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00831C04E87
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 16:31:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AF320815
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 16:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AF320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D553E3E;
	Mon, 20 May 2019 16:31:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7266BE3B
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 16:31:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ACD567ED
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 16:31:46 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4KGQrbZ011535
	for <iommu@lists.linux-foundation.org>; Mon, 20 May 2019 12:31:45 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2skxsp2w0k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Mon, 20 May 2019 12:31:45 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Mon, 20 May 2019 17:31:13 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 20 May 2019 17:31:11 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4KGV9e150528352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 20 May 2019 16:31:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A68DA4051;
	Mon, 20 May 2019 16:31:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B172CA407B;
	Mon, 20 May 2019 16:31:08 +0000 (GMT)
Received: from [9.145.24.80] (unknown [9.145.24.80])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 May 2019 16:31:08 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
To: Cornelia Huck <cohuck@redhat.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
	<1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
	<20190517104143.240082b5@x1.home>
	<92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
	<ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
	<20190520162737.7560ad7c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 20 May 2019 18:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520162737.7560ad7c.cohuck@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052016-0020-0000-0000-0000033EA611
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052016-0021-0000-0000-000021917F18
Message-Id: <23f6a739-be4f-7eda-2227-2994fdc2325a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-20_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905200106
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, sebott@linux.vnet.ibm.com,
	walling@linux.ibm.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
	Alex Williamson <alex.williamson@redhat.com>,
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

T24gMjAvMDUvMjAxOSAxNjoyNywgQ29ybmVsaWEgSHVjayB3cm90ZToKPiBPbiBNb24sIDIwIE1h
eSAyMDE5IDEzOjE5OjIzICswMjAwCj4gUGllcnJlIE1vcmVsIDxwbW9yZWxAbGludXguaWJtLmNv
bT4gd3JvdGU6Cj4gCj4+IE9uIDE3LzA1LzIwMTkgMjA6MDQsIFBpZXJyZSBNb3JlbCB3cm90ZToK
Pj4+IE9uIDE3LzA1LzIwMTkgMTg6NDEsIEFsZXggV2lsbGlhbXNvbiB3cm90ZToKPj4+PiBPbiBG
cmksIDE3IE1heSAyMDE5IDE4OjE2OjUwICswMjAwCj4+Pj4gUGllcnJlIE1vcmVsIDxwbW9yZWxA
bGludXguaWJtLmNvbT4gd3JvdGU6Cj4+Pj4gICAKPj4+Pj4gV2UgaW1wbGVtZW50IHRoZSBjYXBh
YmlsaXR5IGludGVyZmFjZSBmb3IgVkZJT19JT01NVV9HRVRfSU5GTy4KPj4+Pj4KPj4+Pj4gV2hl
biBjYWxsaW5nIHRoZSBpb2N0bCwgdGhlIHVzZXIgbXVzdCBzcGVjaWZ5Cj4+Pj4+IFZGSU9fSU9N
TVVfSU5GT19DQVBBQklMSVRJRVMgdG8gcmV0cmlldmUgdGhlIGNhcGFiaWxpdGllcyBhbmQKPj4+
Pj4gbXVzdCBjaGVjayBpbiB0aGUgYW5zd2VyIGlmIGNhcGFiaWxpdGllcyBhcmUgc3VwcG9ydGVk
Lgo+Pj4+Pgo+Pj4+PiBUaGUgaW9tbXUgZ2V0X2F0dHIgY2FsbGJhY2sgd2lsbCBiZSB1c2VkIHRv
IHJldHJpZXZlIHRoZSBzcGVjaWZpYwo+Pj4+PiBhdHRyaWJ1dGVzIGFuZCBmaWxsIHRoZSBjYXBh
YmlsaXRpZXMuCj4+Pj4+Cj4+Pj4+IEN1cnJlbnRseSB0d28gWi1QQ0kgc3BlY2lmaWMgY2FwYWJp
bGl0aWVzIHdpbGwgYmUgcXVlcmllZCBhbmQKPj4+Pj4gZmlsbGVkIGJ5IHRoZSB1bmRlcmx5aW5n
IFogc3BlY2lmaWMgczM5MF9pb21tdToKPj4+Pj4gVkZJT19JT01NVV9JTkZPX0NBUF9RRk4gZm9y
IHRoZSBQQ0kgcXVlcnkgZnVuY3Rpb24gYXR0cmlidXRlcwo+Pj4+PiBhbmQKPj4+Pj4gVkZJT19J
T01NVV9JTkZPX0NBUF9RR1JQIGZvciB0aGUgUENJIHF1ZXJ5IGZ1bmN0aW9uIGdyb3VwLgo+Pj4+
Pgo+Pj4+PiBPdGhlciBhcmNoaXRlY3R1cmVzIG1heSBhZGQgbmV3IGNhcGFiaWxpdGllcyBpbiB0
aGUgc2FtZSB3YXkKPj4+Pj4gYWZ0ZXIgZW5oYW5jaW5nIHRoZSBhcmNoaXRlY3R1cmUgc3BlY2lm
aWMgSU9NTVUgZHJpdmVyLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmUgTW9yZWwg
PHBtb3JlbEBsaW51eC5pYm0uY29tPgo+Pj4+PiAtLS0KPj4+Pj4gIMKgIGRyaXZlcnMvdmZpby92
ZmlvX2lvbW11X3R5cGUxLmMgfCAxMjIKPj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQo+Pj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDEyMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZmaW8vdmZp
b19pb21tdV90eXBlMS5jCj4+Pj4+IGIvZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYwo+
Pj4+PiBpbmRleCBkMGY3MzFjLi45NDM1NjQ3IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3Zm
aW8vdmZpb19pb21tdV90eXBlMS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmZpby92ZmlvX2lvbW11
X3R5cGUxLmMKPj4+Pj4gQEAgLTE2NTgsNiArMTY1OCw5NyBAQCBzdGF0aWMgaW50Cj4+Pj4+IHZm
aW9fZG9tYWluc19oYXZlX2lvbW11X2NhY2hlKHN0cnVjdCB2ZmlvX2lvbW11ICppb21tdSkKPj4+
Pj4gIMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+Pj4gIMKgIH0KPj4+Pj4gK3N0YXRpYyBpbnQg
dmZpb19pb21tdV90eXBlMV96cGNpX2ZuKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2ZmlvX2lu
Zm9fY2FwICpjYXBzLCBzaXplX3Qgc2l6ZSkKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCBzdHJ1Y3Qg
dmZpb19pb21tdV90eXBlMV9pbmZvX3BjaWZuICppbmZvX2ZuOwo+Pj4+PiArwqDCoMKgIGludCBy
ZXQ7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBpbmZvX2ZuID0ga3phbGxvYyhzaXplLCBHRlBfS0VS
TkVMKTsKPj4+Pj4gK8KgwqDCoCBpZiAoIWluZm9fZm4pCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVOT01FTTsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHJldCA9IGlvbW11X2RvbWFpbl9n
ZXRfYXR0cihkb21haW4sIERPTUFJTl9BVFRSX1pQQ0lfRk4sCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmaW5mb19mbi0+cmVzcG9uc2UpOwo+Pj4+Cj4+Pj4g
V2hhdCBlbnN1cmVzIHRoYXQgdGhlICdzdHJ1Y3QgY2xwX3JzcF9xdWVyeV9wY2knIHJldHVybmVk
IGZyb20gdGhpcwo+Pj4+IGdldF9hdHRyIHJlbWFpbnMgY29uc2lzdGVudCB3aXRoIGEgJ3N0cnVj
dCB2ZmlvX2lvbW11X3BjaV9mdW5jdGlvbic/Cj4+Pj4gV2h5IGRvZXMgdGhlIGxhdHRlciBjb250
YWlucyBzbyBtYW55IHJlc2VydmVkIGZpZWxkcyAoYmV5b25kIHNpbXBseQo+Pj4+IGFsaWdubWVu
dCkgZm9yIGEgdXNlciBBUEk/wqAgV2hhdCBmaWVsZHMgb2YgdGhlc2Ugc3RydWN0dXJlcyBhcmUK
Pj4+PiBhY3R1YWxseSB1c2VmdWwgdG8gdXNlcnNwYWNlP8KgIFNob3VsZCBhbnkgZmllbGRzIG5v
dCBiZSBleHBvc2VkIHRvIHRoZQo+Pj4+IHVzZXI/wqAgQXJlbid0IEJBUiBzaXplcyByZWR1bmRh
bnQgdG8gd2hhdCdzIGF2YWlsYWJsZSB0aHJvdWdoIHRoZSB2ZmlvCj4+Pj4gUENJIEFQST/CoCBJ
J20gYWZyYWlkIHRoYXQgc2ltcGx5IHJlZGVmaW5pbmcgYW4gaW50ZXJuYWwgc3RydWN0dXJlIGFz
Cj4+Pj4gdGhlIEFQSSBsZWF2ZXMgYSBsb3QgdG8gYmUgZGVzaXJlZCB0b28uwqAgVGhhbmtzLAo+
Pj4+Cj4+Pj4gQWxleAo+Pj4+ICAgCj4+PiBIaSBBbGV4LAo+Pj4KPj4+IEkgc2ltcGx5IHVzZWQg
dGhlIHN0cnVjdHVyZSByZXR1cm5lZCBieSB0aGUgZmlybXdhcmUgdG8gYmUgc3VyZSB0byBiZQo+
Pj4gY29uc2lzdGVudCB3aXRoIGZ1dHVyZSBldm9sdXRpb25zIGFuZCBmYWNpbGl0YXRlIHRoZSBj
b3B5IGZyb20gQ0xQIGFuZAo+Pj4gdG8gdXNlcmxhbmQuCj4+Pgo+Pj4gSWYgeW91IHByZWZlciwg
YW5kIEkgdW5kZXJzdGFuZCB0aGF0IHRoaXMgaXMgdGhlIGNhc2UsIEkgY2FuIGRlZmluZSBhCj4+
PiBzcGVjaWZpYyBWRklPX0lPTU1VIHN0cnVjdHVyZSB3aXRoIG9ubHkgdGhlIGZpZWxkcyByZWxl
dmFudCB0byB0aGUgdXNlciwKPj4+IGxlYXZpbmcgZnV0dXJlIGVuaGFuY2VtZW50IG9mIHRoZSB1
c2VyJ3MgaW50ZXJmYWNlIGJlaW5nIGltcGxlbWVudGVkIGluCj4+PiBhbm90aGVyIGtlcm5lbCBw
YXRjaCB3aGVuIHRoZSB0aW1lIGhhcyBjb21lLgo+Pj4KPj4+IEluIGZhY3QsIHRoZSBzdHJ1Y3Qg
d2lsbCBoYXZlIGFsbCBkZWZpbmVkIGZpZWxkcyBJIHVzZWQgYnV0IG5vdCB0aGUgQkFSCj4+PiBz
aXplIGFuZCBhZGRyZXNzIChhdCBsZWFzdCBmb3Igbm93IGJlY2F1c2UgdGhlcmUgYXJlIHNwZWNp
YWwgY2FzZXMgd2UgZG8KPj4+IG5vdCBzdXBwb3J0IHlldCB3aXRoIGJhcnMpLgo+Pj4gQWxsIHRo
ZSByZXNlcnZlZCBmaWVsZHMgY2FuIGdvIGF3YXkuCj4+Pgo+Pj4gSXMgaXQgbW9yZSBjb25mb3Jt
IHRvIHlvdXIgaWRlYT8KPj4+Cj4+PiBBbHNvIEkgaGF2ZSAyIGludGVyZmFjZXM6Cj4+Pgo+Pj4g
czM5MF9pb21tdS5nZXRfYXR0ciA8LUkxLT4gVkZJT19JT01NVSA8LUkyLT4gdXNlcmxhbmQKPj4+
Cj4+PiBEbyB5b3UgcHJlZmVyOgo+Pj4gLSAyIGRpZmZlcmVudCBzdHJ1Y3R1cmVzLCBubyBDTFAg
cmF3IHN0cnVjdHVyZQo+Pj4gLSB0aGUgQ0xQIHJhdyBzdHJ1Y3R1cmUgZm9yIEkxIGFuZCBhIFZG
SU8gc3BlY2lmaWMgc3RydWN0dXJlIGZvciBJMgo+IAo+IDxlbnRlcmluZyBmcm9tIHRoZSBzaWRl
bGluZT4KPiAKPiBJSVVDLCBnZXRfYXR0ciBleHRyYWN0cyB2YXJpb3VzIGRhdGEgcG9pbnRzIHZp
YSBjbHAsIGFuZCB3ZSB0aGVuIG1ha2UKPiBpdCBhdmFpbGFibGUgdG8gdXNlcnNwYWNlLiBUaGUg
Y2xwIGludGVyZmFjZSBuZWVkcyB0byBiZSBhYnN0cmFjdGVkCj4gYXdheSBhdCBzb21lIHBvaW50
Li4uIG9uZSBxdWVzdGlvbiBmcm9tIG1lOiBJcyB0aGVyZSBhIGNoYW5jZSB0aGF0Cj4gc29tZW9u
ZSBlbHNlIG1heSB3YW50IHRvIG1ha2UgdXNlIG9mIHRoZSB1c2Vyc3BhY2UgaW50ZXJmYWNlIChl
eHRyYQo+IGluZm9ybWF0aW9uIGFib3V0IGEgZnVuY3Rpb24pPyBJZiB5ZXMsIEknZCBleHBlY3Qg
dGhlIGdldF9hdHRyIHRvCj4gb2J0YWluIHNvbWUga2luZCBvZiBwb3J0YWJsZSBpbmZvcm1hdGlv
biBhbHJlYWR5IChiYXNpY2FsbHkgeW91ciB0aGlyZAo+IG9wdGlvbiwgYmVsb3cpLgoKWWVzLCBz
ZWVtcyB0aGUgbW9zdCByZWFzb25hYmxlLgpJbiB0aGlzIGNhc2UgSSBuZWVkIHRvIHNoYXJlIHRo
ZSBzdHJ1Y3R1cmUgZGVmaW5pdGlvbiBiZXR3ZWVuOgp1c2Vyc3BhY2UgdGhyb3VnaCB2ZmlvLmgK
dmZpb19pb21tdSAodGhpcyBpcyBvYnZpb3VzKQpzMzkwX2lvbW11CgpJdCBpcyB0aGlzIHRoaXJk
IGluY2x1ZGUgd2hpY2ggbWFkZSBtZSBkb3VidC4KQnV0IHdoZW4geW91IHJlIGZvcm11bGF0ZSBp
dCBpdCBsb29rcyB0aGUgbW9yZSByZWFzb25hYmxlIGJlY2F1c2UgdGhlcmUgCmFyZSBtdWNoIGxl
c3MgY2hhbmdlcy4KClRoYW5rcyBmb3IgdGhlIGhlbHAsIEkgc3RhcnQgdGhpcyB3YXksIHN0aWxs
IHdhaXQgb25lIGRheSBvciB0d28gdG8gc2VlIAppZiBhbnkgY29tbWVudCBhZ2FpbnN0IHRoaXMg
c29sdXRpb24gY29tZXMgYW5kIHNlbmQgdGhlIHVwZGF0ZS4KClRoYW5rcywKUGllcnJlCgo+IAo+
Pgo+PiBIaSBBbGV4LAo+Pgo+PiBJIGFtIGJhY2sgYWdhaW4gb24gdGhpcy4KPj4gVGhpcyBzb2x1
dGlvbiBoZXJlIGFib3ZlIHNlZW1zIHRvIG1lIHRoZSBiZXN0IG9uZSBidXQgaW4gdGhpcyB3YXkg
SSBtdXN0Cj4+IGluY2x1ZGUgUzM5MCBzcGVjaWZpYyBpbmNsdWRlIGluc2lkZSB0aGUgaW9tbXVf
dHlwZTEsIHdoaWNoIGlzIEFGQUlVIG5vdAo+PiBhIGdvb2QgdGhpbmcuCj4+IEl0IHNlZW1zIHRo
YXQgdGhlIHBvd2VycGMgYXJjaGl0ZWN0dXJlIHVzZSBhIHNvbHV0aW9uIHdpdGggYSBkZWRpY2F0
ZWQKPj4gVkZJT19JT01NVSwgdGhlIHZmaW9faW9tbXVfc3Bhcl90Y2UuCj4+Cj4+IFdvdWxkbid0
IGl0IGJlIGEgc29sdXRpb24gZm9yIHMzOTAgdG9vLCB0byB1c2UgdGhlIHZmaW9faW9tbXVfdHlw
ZTEgYXMgYQo+PiBiYXNpcyB0byBoYXZlIGEgczM5MCBkZWRpY2F0ZWQgc29sdXRpb24uCj4+IFRo
ZW4gaXQgYmVjb21lcyBlYXNpZXIgdG8gaGF2ZSBvbiBvbmUgc2lkZSB0aGUgczM5MF9pb21tdSBp
bnRlcmZhY2UsCj4+IFMzOTAgc3BlY2lmaWMsIGFuZCBvbiB0aGUgb3RoZXIgc2lkZSBhIFZGSU8g
aW50ZXJmYWNlIHdpdGhvdXQgYSBibGluZAo+PiBjb3B5IG9mIHRoZSBmaXJtd2FyZSB2YWx1ZXMu
Cj4gCj4gSWYgbm9ib2R5IGVsc2Ugd291bGQgd2FudCB0aGlzIGV4YWN0IGludGVyZmFjZSwgaXQg
bWlnaHQgYmUgYSBzb2x1dGlvbi4KPiBJdCB3b3VsZCBzdGlsbCBiZSBiZXR0ZXIgbm90IHRvIGVu
Y29kZSBjbHAgZGF0YSBleHBsaWNpdGx5IGluIHRoZQo+IHVzZXJzcGFjZSBpbnRlcmZhY2UuCj4g
Cj4+Cj4+IERvIHlvdSB0aGluayBpdCBpcyBhIHZpYWJsZSBzb2x1dGlvbj8KPj4KPj4gVGhhbmtz
LAo+PiBQaWVycmUKPj4KPj4KPj4KPj4+IC0gdGhlIHNhbWUgVkZJTyBzdHJ1Y3R1cmUgZm9yIGJv
dGggSTEgYW5kIEkyCj4gCgoKLS0gClBpZXJyZSBNb3JlbApMaW51eC9LVk0vUUVNVSBpbiBCw7Zi
bGluZ2VuIC0gR2VybWFueQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
