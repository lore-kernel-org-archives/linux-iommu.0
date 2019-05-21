Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E721C04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 12:46:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DBC2173E
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 12:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DBC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EFBF7B50;
	Tue, 21 May 2019 12:46:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D54F0B4B
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 12:46:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4FFEE27B
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 12:46:16 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4LCgIom122361
	for <iommu@lists.linux-foundation.org>; Tue, 21 May 2019 08:46:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2smg4dm5dp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Tue, 21 May 2019 08:46:15 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Tue, 21 May 2019 13:46:13 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 21 May 2019 13:46:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4LCk70438469882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 21 May 2019 12:46:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F052AA4055;
	Tue, 21 May 2019 12:46:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FBEA405B;
	Tue, 21 May 2019 12:46:06 +0000 (GMT)
Received: from [9.152.222.56] (unknown [9.152.222.56])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 21 May 2019 12:46:06 +0000 (GMT)
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
To: Cornelia Huck <cohuck@redhat.com>
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
	<1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
	<20190517104143.240082b5@x1.home>
	<92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
	<ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
	<20190520162737.7560ad7c.cohuck@redhat.com>
	<23f6a739-be4f-7eda-2227-2994fdc2325a@linux.ibm.com>
	<20190520122352.73082e52@x1.home>
	<9dc0a8de-b850-df21-e3b7-21b7c2a373a3@linux.ibm.com>
	<20190521131120.0b2afb37.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 21 May 2019 14:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521131120.0b2afb37.cohuck@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052112-0016-0000-0000-0000027DF974
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052112-0017-0000-0000-000032DAE368
Message-Id: <6216c287-c741-0600-d5b7-cbdaf2214661@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-21_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=911 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905210080
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

T24gMjEvMDUvMjAxOSAxMzoxMSwgQ29ybmVsaWEgSHVjayB3cm90ZToKPiBPbiBUdWUsIDIxIE1h
eSAyMDE5IDExOjE0OjM4ICswMjAwCj4gUGllcnJlIE1vcmVsIDxwbW9yZWxAbGludXguaWJtLmNv
bT4gd3JvdGU6Cj4gCj4+IDEpIEEgc2hvcnQgZGVzY3JpcHRpb24sIG9mIHpQQ0kgZnVuY3Rpb25z
IGFuZCBncm91cHMKPj4KPj4gSU4gWiwgUENJIGNhcmRzLCBsZWF2ZSBiZWhpbmQgYW4gYWRhcHRl
ciBiZXR3ZWVuIHN1YmNoYW5uZWxzIGFuZCBQQ0kuCj4+IFdlIGFjY2VzcyBQQ0kgY2FyZHMgdGhy
b3VnaCAyIHdheXM6Cj4+IC0gZGVkaWNhdGVkIFBDSSBpbnN0cnVjdGlvbnMgKHBjaV9sb2FkL3Bj
aV9zdG9yZS9wY2kvc3RvcmVfYmxvY2spCj4+IC0gRE1BCj4gCj4gUXVpY2sgcXVlc3Rpb246IFdo
YXQgYWJvdXQgdGhlIG5ldyBwY2kgaW5zdHJ1Y3Rpb25zPyBBbnl0aGluZyB0aGF0Cj4gbmVlZHMg
dG8gYmUgY29uc2lkZXJlZCB0aGVyZT8KCk5vIGFuZCB5ZXMuCgpObyBiZWNhdXNlIHRoZXkgc2hv
dWxkIGJlIHVzZWQgd2hlbiBwY2lfe2xvYWQsc3RvcixzdG9yZV9ibG9ja30gYXJlIAppbnRlcnBy
ZXRlZCBBRkFJVS4KQW5kIGN1cnJlbnRseSB3ZSBvbmx5IHVzZSBpbnRlcmNlcHRpb24uCgpZZXMs
IGJlY2F1c2UsIHRoZSBDTFAgcGFydCwgdXNlIHRvIHNldHVwIHRoZSB0cmFuc2xhdGlvbnMgSUlV
QywgKGRvIG5vdCAKYXNrIG1lIGZvciBkZXRhaWxzIG5vdyksIHdpbGwgbmVlZCB0byBiZSByZS1p
c3N1ZWQgYnkgdGhlIGtlcm5lbCBhZnRlciAKc29tZSBtb2RpZmljYXRpb25zIGFuZCB0aGlzIHdp
bGwgYWxzbyBuZWVkIGEgd2F5IGZyb20gUUVNVSBTMzkwIFBDSSBkb3duIAp0byB0aGUgWlBDSSBk
cml2ZXIuCldheSB0aGF0IEkgdHJ5IHRvIHNldHVwIHdpdGggdGhpcyBwYXRjaC4KClNvIGFuc3dl
ciBpcyBub3Qgbm93IGJ1dCB3ZSBzaG91bGQga2VlcCBpbiBtaW5kIHRoYXQgd2Ugd2lsbCAKZGVm
aW5pdGl2ZWx5IG5lZWQgYSB3YXkgZG93biB0byB0aGUgenBjaSBsb3cgbGV2ZWwgaW4gdGhlIGhv
c3QuCgo+IAo+PiBXZSByZWNlaXZlIGV2ZW50cyB0aHJvdWdoCj4+IC0gQWRhcHRlciBpbnRlcnJ1
cHRzCj4gCj4gTm90ZSBmb3IgdGhlIG5vbi1zMzkwIGZvbGtzOiBUaGVzZSBhcmUgKEkvTykgaW50
ZXJydXB0cyB0aGF0IGFyZSBub3QKPiB0aWVkIHRvIGEgc3BlY2lmaWMgZGV2aWNlLiBNU0ktWCBp
cyBtYXBwZWQgdG8gdGhpcy4KPiAKPj4gLSBDSFNDIGV2ZW50cwo+IAo+IEFub3RoZXIgbm90ZSBm
b3IgdGhlIG5vbi1zMzkwIGZvbGtzOiBUaGlzIGlzIGEgbm90aWZpY2F0aW9uIG1lY2hhbmlzbQo+
IHRoYXQgaXMgdXNpbmcgbWFjaGluZSBjaGVjayBpbnRlcnJ1cHRzOyBtb3JlIGluZm9ybWF0aW9u
IGlzIHJldHJpZXZlZAo+IHZpYSBhIHNwZWNpYWwgaW5zdHJ1Y3Rpb24gKGNoc2MpLgo+IAoKdGhh
bmtzLCBpdCBpcyB5ZXMgYmV0dGVyIHRvIGV4cGxhaW4gYmV0dGVyIDopCgo+Pgo+PiBUaGUgYWRh
cHRlciBwcm9wb3NlIGFuIElPTU1VIHRvIHByb3RlY3QgdGhlIERNQQo+PiBhbmQgdGhlIGludGVy
cnVwdCBoYW5kbGluZyBnb2VzIHRocm91Z2ggYSBNU0lYIGxpa2UgaW50ZXJmYWNlIGhhbmRsZWQg
YnkKPj4gdGhlIGFkYXB0ZXIuCj4+Cj4+IFRoZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgUENJIGRv
IHRoZSBpbnRlcmZhY2UgYmV0d2VlbiB0aGUgc3RhbmRhcmQgUENJCj4+IGxldmVsIGFuZCB0aGUg
elBDSSBmdW5jdGlvbiAoUENJICsgRE1BL0lPTU1VL0ludGVycnVwdCkKPj4KPj4gVG8gaGFuZGxl
IHRoZSBjb21tdW5pY2F0aW9uIHRocm91Z2ggdGhlICJ6UENJIHdheSIgdGhlIENMUCBpbnRlcmZh
Y2UKPj4gcHJvdmlkZXMgaW5zdHJ1Y3Rpb25zIHRvIHJldHJpZXZlIGluZm9ybWF0aW9ucyBmcm9t
IHRoZSBhZGFwdGVycy4KPj4KPj4gVGhlcmUgYXJlIGRpZmZlcmVudCBncm91cCBvZiBmdW5jdGlv
bnMgaGF2aW5nIHNhbWUgZnVuY3Rpb25hbGl0aWVzLgo+Pgo+PiBjbHBfbGlzdCBnaXZlIHVzIGEg
bGlzdCBmcm9tIHpQQ0kgZnVuY3Rpb25zCj4+IGNscF9xdWVyeV9wY2lfZnVuY3Rpb24gcmV0dXJu
cyBpbmZvcm1hdGlvbnMgc3BlY2lmaWMgdG8gYSBmdW5jdGlvbgo+PiBjbHBfcXVlcnlfZ3JvdXAg
cmV0dXJucyBpbmZvcm1hdGlvbiBvbiBhIGZ1bmN0aW9uIGdyb3VwCj4+Cj4+Cj4+IDIpIFdoeSBk
byB3ZSBuZWVkIGl0IGluIHRoZSBndWVzdAo+Pgo+PiBXZSBuZWVkIHRvIHByb3ZpZGUgdGhlIGd1
ZXN0IHdpdGggaW5mb3JtYXRpb24gb24gdGhlIGFkYXB0ZXJzIGFuZCB6UENJCj4+IGZ1bmN0aW9u
cyByZXR1cm5lZCBieSB0aGUgY2xwX3F1ZXJ5IGluc3RydWN0aW9uIHNvIHRoYXQgdGhlIGd1ZXN0
J3MKPj4gZHJpdmVyIGdldHMgdGhlIHJpZ2h0IGluZm9ybWF0aW9uIG9uIGhvdyB0aGUgd2F5IHRv
IHRoZSB6UENJIGZ1bmN0aW9uCj4+IGhhcyBiZWVuIGJ1aWx0IGluIHRoZSBob3N0Lgo+Pgo+Pgo+
PiBXaGVuIGEgZ3Vlc3QgaXNzdWVzIHRoZSBDTFAgaW5zdHJ1Y3Rpb25zIHdlIGludGVyY2VwdCB0
aGUgY2xwIGNvbW1hbmQgaW4KPj4gUUVNVSBhbmQgd2UgbmVlZCB0byBmZWVkIHRoZSByZXNwb25z
ZSB3aXRoIHRoZSByaWdodCB2YWx1ZXMgZm9yIHRoZSBndWVzdC4KPj4gVGhlICJyaWdodCIgdmFs
dWVzIGFyZSBub3QgdGhlIHJhdyBDTFAgcmVzcG9uc2UgdmFsdWVzOgo+Pgo+PiAtIHNvbWUgaWRl
bnRpZmllciBtdXN0IGJlIHZpcnR1YWxpemVkLCBsaWtlIFVJRCBhbmQgRklELAo+Pgo+PiAtIHNv
bWUgdmFsdWVzIG11c3QgbWF0Y2ggd2hhdCB0aGUgaG9zdCByZWNlaXZlZCBmcm9tIHRoZSBDTFAg
cmVzcG9uc2UsCj4+IGxpa2UgdGhlIHNpemUgb2YgdGhlIHRyYW5zbWl0ZWQgYmxvY2tzLCB0aGUg
RE1BIEFkZHJlc3MgU3BhY2UgTWFzaywKPj4gbnVtYmVyIG9mIGludGVycnVwdCwgTVNJQQo+Pgo+
PiAtIHNvbWUgb3RoZXIgbXVzdCBtYXRjaCB3aGF0IHRoZSBob3N0IGhhbmRsZWQgd2l0aCB0aGUg
YWRhcHRlciBhbmQKPj4gZnVuY3Rpb24sIHRoZSBzdGFydCBhbmQgZW5kIG9mIERNQSwKPj4KPj4g
LSBzb21lIHdoYXQgdGhlIGhvc3QgSU9NTVUgZHJpdmVyIHN1cHBvcnRzIChmcmFtZSBzaXplKSwK
Pj4KPj4KPj4KPj4gMykgV2UgaGF2ZSB0aHJlZSBkaWZmZXJlbnQgd2F5IHRvIGdldCBUaGlzIGlu
Zm9ybWF0aW9uOgo+Pgo+PiBUaGUgUENJIExpbnV4IGludGVyZmFjZSBpcyBhIHN0YW5kYXJkIFBD
SSBpbnRlcmZhY2UgYW5kIHNvbWUgWiBzcGVjaWZpYwo+PiBpbmZvcm1hdGlvbiBpcyBhdmFpbGFi
bGUgaW4gc3lzZnMuCj4+IE5vdCBhbGwgdGhlIGluZm9ybWF0aW9uIG5lZWRlZCB0byBiZSByZXR1
cm5lZCBpbnNpZGUgdGhlIENMUCByZXNwb25zZSBpcwo+PiBhdmFpbGFibGUuCj4+IFNvIHdlIGNh
biBub3QgdXNlIHRoZSBzeXNmcyBpbnRlcmZhY2UgdG8gZ2V0IGFsbCB0aGUgaW5mb3JtYXRpb24u
Cj4+Cj4+IFRoZXJlIGlzIGEgQ0xQIGlvY3RsIGludGVyZmFjZSBidXQgdGhpcyBpbnRlcmZhY2Ug
aXMgbm90IHNlY3VyZSBpbiB0aGF0Cj4+IGl0IHJldHVybnMgdGhlIGluZm9ybWF0aW9uIGZvciBh
bGwgYWRhcHRlcnMgaW4gdGhlIHN5c3RlbS4KPj4KPj4gVGhlIFZGSU8gaW50ZXJmYWNlIG9mZmVy
cyB0aGUgYWR2YW50YWdlIHRvIHBvaW50IHRvIGEgc2luZ2xlIFBDSQo+PiBmdW5jdGlvbiwgc28g
bW9yZSBzZWN1cmUgdGhhbiB0aGUgY2xwIGlvY3RsIGludGVyZmFjZS4KPj4gQ291cGxlZCB3aXRo
IHRoZSBzMzkwX2lvbW11IHdlIGdldCBhY2Nlc3MgdG8gdGhlIHpQQ0kgQ0xQIGluc3RydWN0aW9u
Cj4+IGFuZCB0byB0aGUgdmFsdWVzIGhhbmRsZWQgYnkgdGhlIHpQQ0kgZHJpdmVyLgo+Pgo+Pgo+
PiA0KSBVbnRpbCBub3cgd2UgdXNlZCB0byBmaWxsIHRoZSBDTFAgcmVzcG9uc2UgdG8gdGhlIGd1
ZXN0IGluc2lkZSBRRU1VCj4+IHdpdGggZml4ZWQgdmFsdWVzIGNvcnJlc3BvbmRpbmcgdG8gdGhl
IG9ubHkgUENJIGNhcmQgd2Ugc3VwcG9ydGVkLgo+PiBUbyBzdXBwb3J0IG5ldyBjYXJkcyB3ZSBu
ZWVkIHRvIGdldCB0aGUgcmlnaHQgdmFsdWVzIGZyb20gdGhlIGtlcm5lbCBvdXQuCj4gCj4gSUlS
QywgdGhlIGN1cnJlbnQgY29kZSBmaWxscyBpbiB2YWx1ZXMgdGhhdCBtYWtlIHNlbnNlIGZvciBv
bmUgc3BlY2lmaWMKPiB0eXBlIG9mIGNhcmQgb25seSwgcmlnaHQ/Cgp5ZXMsIHJpZ2h0Cgo+IFdl
IGFsc28gdXNlIHRoZSBzYW1lIHZhbHVlcyBmb3IgZW11bGF0ZWQKPiBjYXJkcyAodmlydGlvKTsg
SSBhc3N1bWUgdGhhdCB0aGV5IGFyZSBub3QgY29tcGxldGVseSB3ZWlyZCBmb3IgdGhhdAo+IGNh
c2UuLi4KPiAKCk5vIHRoZXkgYXJlIG5vdC4KCkZvciBlbXVsYXRlZCBjYXJkcywgYWxsIGlzIGRv
bmUgaW5zaWRlIFFFTVUsIHdlIGRvIG5vdCBuZWVkIGtlcm5lbCAKYWNjZXNzLCB0aGUgZW11bGF0
ZWQgY2FyZHMgZ2V0IGEgc3BlY2lmaWMgZW11bGF0aW9uIGZ1bmN0aW9uIGFuZCBncm91cCAKYXNz
aWduZWQgd2l0aCBwcmUtZGVmaW5lZCB2YWx1ZXMuCgpJIHNlbnQgYSBRRU1VIHBhdGNoIHJlbGF0
ZWQgdG8gdGhpcy4KRXZlbiB0aGUga2VybmVsIGludGVyZmFjZSB3aWxsIGNoYW5nZSB3aXRoIHRo
ZSBjaGFuZ2VzIGluIHRoZSBrZXJuZWwgCnBhdGNoLCB0aGUgZW11bGF0aW9uIHNob3VsZCBjb250
aW51ZSBpbiB0aGlzIHdheS4KClJlZ2FyZHMsClBpZXJyZQoKCgoKCgoKCgoKLS0gClBpZXJyZSBN
b3JlbApMaW51eC9LVk0vUUVNVSBpbiBCw7ZibGluZ2VuIC0gR2VybWFueQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
