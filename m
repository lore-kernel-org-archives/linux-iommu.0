Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602DCC04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 18:04:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6442168B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 18:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6442168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02C11B4B;
	Fri, 17 May 2019 18:04:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A297DAEF
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 98B31836
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:04:42 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4HHw1tB050088
	for <iommu@lists.linux-foundation.org>; Fri, 17 May 2019 14:04:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2shysbw2pq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 17 May 2019 14:04:41 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Fri, 17 May 2019 19:04:39 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 May 2019 19:04:36 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4HI4Y8p47644864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 17 May 2019 18:04:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF81FAE051;
	Fri, 17 May 2019 18:04:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DBA4AE045;
	Fri, 17 May 2019 18:04:34 +0000 (GMT)
Received: from [9.145.153.112] (unknown [9.145.153.112])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2019 18:04:33 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
To: Alex Williamson <alex.williamson@redhat.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
	<1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
	<20190517104143.240082b5@x1.home>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 May 2019 20:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517104143.240082b5@x1.home>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051718-0028-0000-0000-0000036ED32E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051718-0029-0000-0000-0000242E734F
Message-Id: <92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-17_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905170106
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

T24gMTcvMDUvMjAxOSAxODo0MSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+IE9uIEZyaSwgMTcg
TWF5IDIwMTkgMTg6MTY6NTAgKzAyMDAKPiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5pYm0u
Y29tPiB3cm90ZToKPiAKPj4gV2UgaW1wbGVtZW50IHRoZSBjYXBhYmlsaXR5IGludGVyZmFjZSBm
b3IgVkZJT19JT01NVV9HRVRfSU5GTy4KPj4KPj4gV2hlbiBjYWxsaW5nIHRoZSBpb2N0bCwgdGhl
IHVzZXIgbXVzdCBzcGVjaWZ5Cj4+IFZGSU9fSU9NTVVfSU5GT19DQVBBQklMSVRJRVMgdG8gcmV0
cmlldmUgdGhlIGNhcGFiaWxpdGllcyBhbmQKPj4gbXVzdCBjaGVjayBpbiB0aGUgYW5zd2VyIGlm
IGNhcGFiaWxpdGllcyBhcmUgc3VwcG9ydGVkLgo+Pgo+PiBUaGUgaW9tbXUgZ2V0X2F0dHIgY2Fs
bGJhY2sgd2lsbCBiZSB1c2VkIHRvIHJldHJpZXZlIHRoZSBzcGVjaWZpYwo+PiBhdHRyaWJ1dGVz
IGFuZCBmaWxsIHRoZSBjYXBhYmlsaXRpZXMuCj4+Cj4+IEN1cnJlbnRseSB0d28gWi1QQ0kgc3Bl
Y2lmaWMgY2FwYWJpbGl0aWVzIHdpbGwgYmUgcXVlcmllZCBhbmQKPj4gZmlsbGVkIGJ5IHRoZSB1
bmRlcmx5aW5nIFogc3BlY2lmaWMgczM5MF9pb21tdToKPj4gVkZJT19JT01NVV9JTkZPX0NBUF9R
Rk4gZm9yIHRoZSBQQ0kgcXVlcnkgZnVuY3Rpb24gYXR0cmlidXRlcwo+PiBhbmQKPj4gVkZJT19J
T01NVV9JTkZPX0NBUF9RR1JQIGZvciB0aGUgUENJIHF1ZXJ5IGZ1bmN0aW9uIGdyb3VwLgo+Pgo+
PiBPdGhlciBhcmNoaXRlY3R1cmVzIG1heSBhZGQgbmV3IGNhcGFiaWxpdGllcyBpbiB0aGUgc2Ft
ZSB3YXkKPj4gYWZ0ZXIgZW5oYW5jaW5nIHRoZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgSU9NTVUg
ZHJpdmVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5p
Ym0uY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jIHwgMTIy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMTIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMgYi9kcml2ZXJzL3ZmaW8vdmZpb19pb21t
dV90eXBlMS5jCj4+IGluZGV4IGQwZjczMWMuLjk0MzU2NDcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMKPj4gKysrIGIvZHJpdmVycy92ZmlvL3ZmaW9faW9t
bXVfdHlwZTEuYwo+PiBAQCAtMTY1OCw2ICsxNjU4LDk3IEBAIHN0YXRpYyBpbnQgdmZpb19kb21h
aW5zX2hhdmVfaW9tbXVfY2FjaGUoc3RydWN0IHZmaW9faW9tbXUgKmlvbW11KQo+PiAgIAlyZXR1
cm4gcmV0Owo+PiAgIH0KPj4gICAKPj4gK3N0YXRpYyBpbnQgdmZpb19pb21tdV90eXBlMV96cGNp
X2ZuKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4gKwkJCQkgICAgc3RydWN0IHZmaW9f
aW5mb19jYXAgKmNhcHMsIHNpemVfdCBzaXplKQo+PiArewo+PiArCXN0cnVjdCB2ZmlvX2lvbW11
X3R5cGUxX2luZm9fcGNpZm4gKmluZm9fZm47Cj4+ICsJaW50IHJldDsKPj4gKwo+PiArCWluZm9f
Zm4gPSBremFsbG9jKHNpemUsIEdGUF9LRVJORUwpOwo+PiArCWlmICghaW5mb19mbikKPj4gKwkJ
cmV0dXJuIC1FTk9NRU07Cj4+ICsKPj4gKwlyZXQgPSBpb21tdV9kb21haW5fZ2V0X2F0dHIoZG9t
YWluLCBET01BSU5fQVRUUl9aUENJX0ZOLAo+PiArCQkJCSAgICAmaW5mb19mbi0+cmVzcG9uc2Up
Owo+IAo+IFdoYXQgZW5zdXJlcyB0aGF0IHRoZSAnc3RydWN0IGNscF9yc3BfcXVlcnlfcGNpJyBy
ZXR1cm5lZCBmcm9tIHRoaXMKPiBnZXRfYXR0ciByZW1haW5zIGNvbnNpc3RlbnQgd2l0aCBhICdz
dHJ1Y3QgdmZpb19pb21tdV9wY2lfZnVuY3Rpb24nPwo+IFdoeSBkb2VzIHRoZSBsYXR0ZXIgY29u
dGFpbnMgc28gbWFueSByZXNlcnZlZCBmaWVsZHMgKGJleW9uZCBzaW1wbHkKPiBhbGlnbm1lbnQp
IGZvciBhIHVzZXIgQVBJPyAgV2hhdCBmaWVsZHMgb2YgdGhlc2Ugc3RydWN0dXJlcyBhcmUKPiBh
Y3R1YWxseSB1c2VmdWwgdG8gdXNlcnNwYWNlPyAgU2hvdWxkIGFueSBmaWVsZHMgbm90IGJlIGV4
cG9zZWQgdG8gdGhlCj4gdXNlcj8gIEFyZW4ndCBCQVIgc2l6ZXMgcmVkdW5kYW50IHRvIHdoYXQn
cyBhdmFpbGFibGUgdGhyb3VnaCB0aGUgdmZpbwo+IFBDSSBBUEk/ICBJJ20gYWZyYWlkIHRoYXQg
c2ltcGx5IHJlZGVmaW5pbmcgYW4gaW50ZXJuYWwgc3RydWN0dXJlIGFzCj4gdGhlIEFQSSBsZWF2
ZXMgYSBsb3QgdG8gYmUgZGVzaXJlZCB0b28uICBUaGFua3MsCj4gCj4gQWxleAo+IApIaSBBbGV4
LAoKSSBzaW1wbHkgdXNlZCB0aGUgc3RydWN0dXJlIHJldHVybmVkIGJ5IHRoZSBmaXJtd2FyZSB0
byBiZSBzdXJlIHRvIGJlIApjb25zaXN0ZW50IHdpdGggZnV0dXJlIGV2b2x1dGlvbnMgYW5kIGZh
Y2lsaXRhdGUgdGhlIGNvcHkgZnJvbSBDTFAgYW5kIAp0byB1c2VybGFuZC4KCklmIHlvdSBwcmVm
ZXIsIGFuZCBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIGlzIHRoZSBjYXNlLCBJIGNhbiBkZWZpbmUg
YSAKc3BlY2lmaWMgVkZJT19JT01NVSBzdHJ1Y3R1cmUgd2l0aCBvbmx5IHRoZSBmaWVsZHMgcmVs
ZXZhbnQgdG8gdGhlIHVzZXIsIApsZWF2aW5nIGZ1dHVyZSBlbmhhbmNlbWVudCBvZiB0aGUgdXNl
cidzIGludGVyZmFjZSBiZWluZyBpbXBsZW1lbnRlZCBpbiAKYW5vdGhlciBrZXJuZWwgcGF0Y2gg
d2hlbiB0aGUgdGltZSBoYXMgY29tZS4KCkluIGZhY3QsIHRoZSBzdHJ1Y3Qgd2lsbCBoYXZlIGFs
bCBkZWZpbmVkIGZpZWxkcyBJIHVzZWQgYnV0IG5vdCB0aGUgQkFSIApzaXplIGFuZCBhZGRyZXNz
IChhdCBsZWFzdCBmb3Igbm93IGJlY2F1c2UgdGhlcmUgYXJlIHNwZWNpYWwgY2FzZXMgd2UgZG8g
Cm5vdCBzdXBwb3J0IHlldCB3aXRoIGJhcnMpLgpBbGwgdGhlIHJlc2VydmVkIGZpZWxkcyBjYW4g
Z28gYXdheS4KCklzIGl0IG1vcmUgY29uZm9ybSB0byB5b3VyIGlkZWE/CgpBbHNvIEkgaGF2ZSAy
IGludGVyZmFjZXM6CgpzMzkwX2lvbW11LmdldF9hdHRyIDwtSTEtPiBWRklPX0lPTU1VIDwtSTIt
PiB1c2VybGFuZAoKRG8geW91IHByZWZlcjoKLSAyIGRpZmZlcmVudCBzdHJ1Y3R1cmVzLCBubyBD
TFAgcmF3IHN0cnVjdHVyZQotIHRoZSBDTFAgcmF3IHN0cnVjdHVyZSBmb3IgSTEgYW5kIGEgVkZJ
TyBzcGVjaWZpYyBzdHJ1Y3R1cmUgZm9yIEkyCi0gdGhlIHNhbWUgVkZJTyBzdHJ1Y3R1cmUgZm9y
IGJvdGggSTEgYW5kIEkyCgpUaGFuayB5b3UgaWYgeW91IGNvdWxkIGdpdmUgbWUgYSBkaXJlY3Rp
b24gZm9yIHRoaXMuCgpUaGFua3MgZm9yIHRoZSBjb21tZW50cywgYW5kIHRoYW5rcyBhIGxvdCB0
byBoYXZlIGFuc3dlcmVkIHNvIHF1aWNrbHkuCgpQaWVycmUKCgoKCgoKCi0tIApQaWVycmUgTW9y
ZWwKTGludXgvS1ZNL1FFTVUgaW4gQsO2YmxpbmdlbiAtIEdlcm1hbnkKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
