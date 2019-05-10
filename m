Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6563CC04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 14:45:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CADD21479
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 14:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CADD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D9DF7BE7;
	Fri, 10 May 2019 14:45:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 74EC5AC7
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 14:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BF5ECCF
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 14:45:24 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4AEh4mQ135612
	for <iommu@lists.linux-foundation.org>; Fri, 10 May 2019 10:45:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sda14v5mj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 10 May 2019 10:45:23 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Fri, 10 May 2019 15:45:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 15:45:18 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4AEjHIQ56688666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 14:45:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0692A40F2;
	Fri, 10 May 2019 14:45:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38372A40C1;
	Fri, 10 May 2019 14:45:16 +0000 (GMT)
Received: from [9.145.187.238] (unknown [9.145.187.238])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 14:45:16 +0000 (GMT)
Subject: Re: [PATCH 1/4] s390: pci: Exporting access to CLP PCI function and
	PCI group
To: Robin Murphy <robin.murphy@arm.com>, sebott@linux.vnet.ibm.com
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
	<1557476555-20256-2-git-send-email-pmorel@linux.ibm.com>
	<a06ffd83-5fde-8c6e-b25b-bd4163d4cd5f@arm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 10 May 2019 16:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a06ffd83-5fde-8c6e-b25b-bd4163d4cd5f@arm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051014-0016-0000-0000-0000027A60B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051014-0017-0000-0000-000032D71C91
Message-Id: <289bdf82-75ba-4ba4-9362-dd8fc721cfc8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100102
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, walling@linux.ibm.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
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

T24gMTAvMDUvMjAxOSAxMjoyMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDEwLzA1LzIwMTkg
MDk6MjIsIFBpZXJyZSBNb3JlbCB3cm90ZToKPj4gRm9yIHRoZSBnZW5lcmljIGltcGxlbWVudGF0
aW9uIG9mIFZGSU8gUENJIHdlIG5lZWQgdG8gcmV0cmlldmUKPj4gdGhlIGhhcmR3YXJlIGNvbmZp
Z3VyYXRpb24gZm9yIHRoZSBQQ0kgZnVuY3Rpb25zIGFuZCB0aGUKPj4gUENJIGZ1bmN0aW9uIGdy
b3Vwcy4KPj4KPj4gV2UgbW9kaWZ5IHRoZSBpbnRlcm5hbCBmdW5jdGlvbiB1c2luZyBDTFAgUXVl
cnkgUENJIGZ1bmN0aW9uIGFuZAo+PiBDTFAgcXVlcnkgUENJIGZ1bmN0aW9uIGdyb3VwIHNvIHRo
YXQgdGhleSBjYW4gYmUgY2FsbGVkIGZyb20KPj4gb3V0c2lkZSB0aGUgUzM5MCBhcmNoaXRlY3R1
cmUgUENJIGNvZGUgYW5kIHByZWZpeCB0aGUgdHdvCj4+IGZ1bmN0aW9ucyB3aXRoICJ6ZGV2IiB0
byBtYWtlIGNsZWFyIHRoYXQgdGhleSBjYW4gYmUgY2FsbGVkCj4+IGtub3dpbmcgb25seSB0aGUg
YXNzb2NpYXRlZCB6ZGV2aWNlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmUgTW9yZWwgPHBt
b3JlbEBsaW51eC5pYm0uY29tPgo+PiBSZXZpZXdlZC1ieTogU2ViYXN0aWFuIE90dCA8c2Vib3R0
QGxpbnV4LmlibS5jb20+Cj4+IC0tLQo+PiDCoCBhcmNoL3MzOTAvaW5jbHVkZS9hc20vcGNpLmgg
fMKgIDMgKysKPj4gwqAgYXJjaC9zMzkwL3BjaS9wY2lfY2xwLmPCoMKgwqDCoCB8IDcyIAo+PiAr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gwqAgMiBmaWxl
cyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9wY2kuaCBiL2FyY2gvczM5MC9pbmNsdWRlL2Fz
bS9wY2kuaAo+PiBpbmRleCAzMDViZWZkLi5lNjZiMjQ2IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3Mz
OTAvaW5jbHVkZS9hc20vcGNpLmgKPj4gKysrIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL3BjaS5o
Cj4+IEBAIC0yNjEsNCArMjYxLDcgQEAgY3B1bWFza19vZl9wY2lidXMoY29uc3Qgc3RydWN0IHBj
aV9idXMgKmJ1cykKPj4gwqAgI2VuZGlmIC8qIENPTkZJR19OVU1BICovCj4+ICtpbnQgemRldl9x
dWVyeV9wY2lfZm5ncnAoc3RydWN0IHpwY2lfZGV2ICp6ZGV2LAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBjbHBfcmVxX3JzcF9xdWVyeV9wY2lfZ3JwICpycmIpOwo+PiAraW50
IHpkZXZfcXVlcnlfcGNpX2ZuKHN0cnVjdCB6cGNpX2RldiAqemRldiwgc3RydWN0IAo+PiBjbHBf
cmVxX3JzcF9xdWVyeV9wY2kgKnJyYik7Cj4+IMKgICNlbmRpZgo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9zMzkwL3BjaS9wY2lfY2xwLmMgYi9hcmNoL3MzOTAvcGNpL3BjaV9jbHAuYwo+PiBpbmRleCAz
YTM2YjA3Li40YWU1ZDc3IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3MzOTAvcGNpL3BjaV9jbHAuYwo+
PiArKysgYi9hcmNoL3MzOTAvcGNpL3BjaV9jbHAuYwo+PiBAQCAtMTEzLDMyICsxMTMsMTggQEAg
c3RhdGljIHZvaWQgY2xwX3N0b3JlX3F1ZXJ5X3BjaV9mbmdycChzdHJ1Y3QgCj4+IHpwY2lfZGV2
ICp6ZGV2LAo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgfQo+PiAtc3RhdGljIGludCBjbHBfcXVlcnlf
cGNpX2ZuZ3JwKHN0cnVjdCB6cGNpX2RldiAqemRldiwgdTggcGZnaWQpCj4+ICtpbnQgemRldl9x
dWVyeV9wY2lfZm5ncnAoc3RydWN0IHpwY2lfZGV2ICp6ZGV2LAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBjbHBfcmVxX3JzcF9xdWVyeV9wY2lfZ3JwICpycmIpCj4+IMKgIHsK
Pj4gLcKgwqDCoCBzdHJ1Y3QgY2xwX3JlcV9yc3BfcXVlcnlfcGNpX2dycCAqcnJiOwo+PiAtwqDC
oMKgIGludCByYzsKPj4gLQo+PiAtwqDCoMKgIHJyYiA9IGNscF9hbGxvY19ibG9jayhHRlBfS0VS
TkVMKTsKPj4gLcKgwqDCoCBpZiAoIXJyYikKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5P
TUVNOwo+PiAtCj4+IMKgwqDCoMKgwqAgbWVtc2V0KHJyYiwgMCwgc2l6ZW9mKCpycmIpKTsKPj4g
wqDCoMKgwqDCoCBycmItPnJlcXVlc3QuaGRyLmxlbiA9IHNpemVvZihycmItPnJlcXVlc3QpOwo+
PiDCoMKgwqDCoMKgIHJyYi0+cmVxdWVzdC5oZHIuY21kID0gQ0xQX1FVRVJZX1BDSV9GTkdSUDsK
Pj4gwqDCoMKgwqDCoCBycmItPnJlc3BvbnNlLmhkci5sZW4gPSBzaXplb2YocnJiLT5yZXNwb25z
ZSk7Cj4+IC3CoMKgwqAgcnJiLT5yZXF1ZXN0LnBmZ2lkID0gcGZnaWQ7Cj4+ICvCoMKgwqAgcnJi
LT5yZXF1ZXN0LnBmZ2lkID0gemRldi0+cGZnaWQ7Cj4+IC3CoMKgwqAgcmMgPSBjbHBfcmVxKHJy
YiwgQ0xQX0xQU19QQ0kpOwo+PiAtwqDCoMKgIGlmICghcmMgJiYgcnJiLT5yZXNwb25zZS5oZHIu
cnNwID09IENMUF9SQ19PSykKPj4gLcKgwqDCoMKgwqDCoMKgIGNscF9zdG9yZV9xdWVyeV9wY2lf
Zm5ncnAoemRldiwgJnJyYi0+cmVzcG9uc2UpOwo+PiAtwqDCoMKgIGVsc2Ugewo+PiAtwqDCoMKg
wqDCoMKgwqAgenBjaV9lcnIoIlEgUENJIEZHUlA6XG4iKTsKPj4gLcKgwqDCoMKgwqDCoMKgIHpw
Y2lfZXJyX2NscChycmItPnJlc3BvbnNlLmhkci5yc3AsIHJjKTsKPj4gLcKgwqDCoMKgwqDCoMKg
IHJjID0gLUVJTzsKPj4gLcKgwqDCoCB9Cj4+IC3CoMKgwqAgY2xwX2ZyZWVfYmxvY2socnJiKTsK
Pj4gLcKgwqDCoCByZXR1cm4gcmM7Cj4+ICvCoMKgwqAgcmV0dXJuIGNscF9yZXEocnJiLCBDTFBf
TFBTX1BDSSk7Cj4+IMKgIH0KPj4gK0VYUE9SVF9TWU1CT0woemRldl9xdWVyeV9wY2lfZm5ncnAp
Owo+IAo+IEFGQUlDUyBpdCdzIG9ubHkgdGhlIElPTU1VIGRyaXZlciBpdHNlbGYgd2hpY2ggbmVl
ZHMgdG8gY2FsbCB0aGVzZS4gVGhhdCAKPiBjYW4ndCBiZSBidWlsdCBhcyBhIG1vZHVsZSwgc28g
eW91IHNob3VsZG4ndCBuZWVkIGV4cGxpY2l0IGV4cG9ydHMgLSB0aGUgCj4gaGVhZGVyIGRlY2xh
cmF0aW9uIGlzIGVub3VnaC4KPiAKPiBSb2Jpbi4KClRoaXMgaXMgcmlnaHQgYW5kIHNlZWluZyB0
aGUgcG9pbnRlciB0eXBlIG9ubHkgelBDSSBhbmQgczM5MGlvbW11IGNhbiAKbWFrZSB1c2Ugb2Yg
aXQuCklmIG5vYm9keSBoYXMgYW5vdGhlciBwb2ludCBvZiB2aWV3IEkgd2lsbCByZW1vdmUgdGhl
IGV4cG9ydCBvbiB0aGUKbmV4dCBpdGVyYXRpb24uCgpUaGFua3MsClBpZXJyZQoKPiAKPj4gwqAg
c3RhdGljIGludCBjbHBfc3RvcmVfcXVlcnlfcGNpX2ZuKHN0cnVjdCB6cGNpX2RldiAqemRldiwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNscF9yc3Bf
cXVlcnlfcGNpICpyZXNwb25zZSkKPj4gQEAgLTE3NCwzMiArMTYwLDUwIEBAIHN0YXRpYyBpbnQg
Y2xwX3N0b3JlX3F1ZXJ5X3BjaV9mbihzdHJ1Y3QgCj4+IHpwY2lfZGV2ICp6ZGV2LAo+PiDCoMKg
wqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IC1zdGF0aWMgaW50IGNscF9xdWVyeV9wY2lfZm4o
c3RydWN0IHpwY2lfZGV2ICp6ZGV2LCB1MzIgZmgpCj4+ICtpbnQgemRldl9xdWVyeV9wY2lfZm4o
c3RydWN0IHpwY2lfZGV2ICp6ZGV2LCBzdHJ1Y3QgCj4+IGNscF9yZXFfcnNwX3F1ZXJ5X3BjaSAq
cnJiKQo+PiArewo+PiArCj4+ICvCoMKgwqAgbWVtc2V0KHJyYiwgMCwgc2l6ZW9mKCpycmIpKTsK
Pj4gK8KgwqDCoCBycmItPnJlcXVlc3QuaGRyLmxlbiA9IHNpemVvZihycmItPnJlcXVlc3QpOwo+
PiArwqDCoMKgIHJyYi0+cmVxdWVzdC5oZHIuY21kID0gQ0xQX1FVRVJZX1BDSV9GTjsKPj4gK8Kg
wqDCoCBycmItPnJlc3BvbnNlLmhkci5sZW4gPSBzaXplb2YocnJiLT5yZXNwb25zZSk7Cj4+ICvC
oMKgwqAgcnJiLT5yZXF1ZXN0LmZoID0gemRldi0+Zmg7Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4g
Y2xwX3JlcShycmIsIENMUF9MUFNfUENJKTsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0woemRldl9x
dWVyeV9wY2lfZm4pOwo+PiArCj4+ICtzdGF0aWMgaW50IGNscF9xdWVyeV9wY2koc3RydWN0IHpw
Y2lfZGV2ICp6ZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGNscF9yZXFfcnNwX3F1
ZXJ5X3BjaSAqcnJiOwo+PiArwqDCoMKgIHN0cnVjdCBjbHBfcmVxX3JzcF9xdWVyeV9wY2lfZ3Jw
ICpncnJiOwo+PiDCoMKgwqDCoMKgIGludCByYzsKPj4gwqDCoMKgwqDCoCBycmIgPSBjbHBfYWxs
b2NfYmxvY2soR0ZQX0tFUk5FTCk7Cj4+IMKgwqDCoMKgwqAgaWYgKCFycmIpCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4gLcKgwqDCoCBtZW1zZXQocnJiLCAwLCBzaXpl
b2YoKnJyYikpOwo+PiAtwqDCoMKgIHJyYi0+cmVxdWVzdC5oZHIubGVuID0gc2l6ZW9mKHJyYi0+
cmVxdWVzdCk7Cj4+IC3CoMKgwqAgcnJiLT5yZXF1ZXN0Lmhkci5jbWQgPSBDTFBfUVVFUllfUENJ
X0ZOOwo+PiAtwqDCoMKgIHJyYi0+cmVzcG9uc2UuaGRyLmxlbiA9IHNpemVvZihycmItPnJlc3Bv
bnNlKTsKPj4gLcKgwqDCoCBycmItPnJlcXVlc3QuZmggPSBmaDsKPj4gLQo+PiAtwqDCoMKgIHJj
ID0gY2xwX3JlcShycmIsIENMUF9MUFNfUENJKTsKPj4gLcKgwqDCoCBpZiAoIXJjICYmIHJyYi0+
cmVzcG9uc2UuaGRyLnJzcCA9PSBDTFBfUkNfT0spIHsKPj4gLcKgwqDCoMKgwqDCoMKgIHJjID0g
Y2xwX3N0b3JlX3F1ZXJ5X3BjaV9mbih6ZGV2LCAmcnJiLT5yZXNwb25zZSk7Cj4+IC3CoMKgwqDC
oMKgwqDCoCBpZiAocmMpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiAt
wqDCoMKgwqDCoMKgwqAgcmMgPSBjbHBfcXVlcnlfcGNpX2ZuZ3JwKHpkZXYsIHJyYi0+cmVzcG9u
c2UucGZnaWQpOwo+PiAtwqDCoMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqAgcmMgPSB6ZGV2X3F1ZXJ5
X3BjaV9mbih6ZGV2LCBycmIpOwo+PiArwqDCoMKgIGlmIChyYyB8fCBycmItPnJlc3BvbnNlLmhk
ci5yc3AgIT0gQ0xQX1JDX09LKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB6cGNpX2VycigiUSBQ
Q0kgRk46XG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHpwY2lfZXJyX2NscChycmItPnJlc3Bv
bnNlLmhkci5yc3AsIHJjKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJjID0gLUVJTzsKPj4gK8Kg
wqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCByYyA9IGNs
cF9zdG9yZV9xdWVyeV9wY2lfZm4oemRldiwgJnJyYi0+cmVzcG9uc2UpOwo+PiArwqDCoMKgIGlm
IChyYykKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiArCj4+ICvCoMKgwqAgZ3JyYiA9
IChzdHJ1Y3QgY2xwX3JlcV9yc3BfcXVlcnlfcGNpX2dycCAqKXJyYjsKPj4gK8KgwqDCoCByYyA9
IHpkZXZfcXVlcnlfcGNpX2ZuZ3JwKHpkZXYsIGdycmIpOwo+PiArwqDCoMKgIGlmIChyYyB8fCBn
cnJiLT5yZXNwb25zZS5oZHIucnNwICE9IENMUF9SQ19PSykgewo+PiArwqDCoMKgwqDCoMKgwqAg
enBjaV9lcnIoIlEgUENJIEZHUlA6XG4iKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHpwY2lfZXJyX2Ns
cChncnJiLT5yZXNwb25zZS5oZHIucnNwLCByYyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCByYyA9IC1F
SU87Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4gK8KgwqDCoCB9Cj4+ICvCoMKgwqAg
Y2xwX3N0b3JlX3F1ZXJ5X3BjaV9mbmdycCh6ZGV2LCAmZ3JyYi0+cmVzcG9uc2UpOwo+PiArCj4+
IMKgIG91dDoKPj4gwqDCoMKgwqDCoCBjbHBfZnJlZV9ibG9jayhycmIpOwo+PiDCoMKgwqDCoMKg
IHJldHVybiByYzsKPj4gQEAgLTIxOSw3ICsyMjMsNyBAQCBpbnQgY2xwX2FkZF9wY2lfZGV2aWNl
KHUzMiBmaWQsIHUzMiBmaCwgaW50IAo+PiBjb25maWd1cmVkKQo+PiDCoMKgwqDCoMKgIHpkZXYt
PmZpZCA9IGZpZDsKPj4gwqDCoMKgwqDCoCAvKiBRdWVyeSBmdW5jdGlvbiBwcm9wZXJ0aWVzIGFu
ZCB1cGRhdGUgemRldiAqLwo+PiAtwqDCoMKgIHJjID0gY2xwX3F1ZXJ5X3BjaV9mbih6ZGV2LCBm
aCk7Cj4+ICvCoMKgwqAgcmMgPSBjbHBfcXVlcnlfcGNpKHpkZXYpOwo+PiDCoMKgwqDCoMKgIGlm
IChyYykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3I7Cj4+Cj4gCgoKLS0gClBpZXJy
ZSBNb3JlbApMaW51eC9LVk0vUUVNVSBpbiBCw7ZibGluZ2VuIC0gR2VybWFueQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
