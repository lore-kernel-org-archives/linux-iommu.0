Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253FC04E87
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 08:18:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFE420848
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 08:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFE420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 96B65949;
	Fri, 17 May 2019 08:18:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 661575A8
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 08:18:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2B7B387D
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 08:18:41 +0000 (UTC)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4H8Ga67036487
	for <iommu@lists.linux-foundation.org>; Fri, 17 May 2019 04:18:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2shs428tcd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 17 May 2019 04:18:39 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Fri, 17 May 2019 09:18:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 May 2019 09:18:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4H8IYlF28573942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 17 May 2019 08:18:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23B9DAE068;
	Fri, 17 May 2019 08:18:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8153EAE05F;
	Fri, 17 May 2019 08:18:33 +0000 (GMT)
Received: from [9.145.153.112] (unknown [9.145.153.112])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2019 08:18:33 +0000 (GMT)
Subject: Re: [PATCH 2/4] vfio: vfio_iommu_type1: Define
	VFIO_IOMMU_INFO_CAPABILITIES
To: Alex Williamson <alex.williamson@redhat.com>
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
	<1557476555-20256-3-git-send-email-pmorel@linux.ibm.com>
	<20190516123100.529f06be@x1.home>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 May 2019 10:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516123100.529f06be@x1.home>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051708-0028-0000-0000-0000036EA8E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051708-0029-0000-0000-0000242E46EB
Message-Id: <ce6c7c44-b406-00d1-cf40-0dae6a6ed563@linux.ibm.com>
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

T24gMTYvMDUvMjAxOSAyMDozMSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+IE9uIEZyaSwgMTAg
TWF5IDIwMTkgMTA6MjI6MzMgKzAyMDAKPiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5pYm0u
Y29tPiB3cm90ZToKPiAKPj4gVG8gdXNlIHRoZSBWRklPX0lPTU1VX0dFVF9JTkZPIHRvIHJldHJp
ZXZlIElPTU1VIHNwZWNpZmljIGluZm9ybWF0aW9uLAo+PiB3ZSBkZWZpbmUgYSBuZXcgZmxhZyBW
RklPX0lPTU1VX0lORk9fQ0FQQUJJTElUSUVTIGluIHRoZQo+PiB2ZmlvX2lvbW11X3R5cGUxX2lu
Zm8gc3RydWN0dXJlIGFuZCB0aGUgYXNzb2NpYXRlZCBjYXBhYmlsaXR5Cj4+IGluZm9ybWF0aW9u
IGJsb2NrLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmUgTW9yZWwgPHBtb3JlbEBsaW51eC5p
Ym0uY29tPgo+PiAtLS0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmZpby5oIHwgMTAgKysrKysr
KysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmZpby5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZmaW8u
aAo+PiBpbmRleCA4ZjEwNzQ4Li44ZjY4ZTBmIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvdmZpby5oCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92ZmlvLmgKPj4gQEAgLTcx
NSw2ICs3MTUsMTYgQEAgc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfaW5mbyB7Cj4+ICAgCV9fdTMy
CWZsYWdzOwo+PiAgICNkZWZpbmUgVkZJT19JT01NVV9JTkZPX1BHU0laRVMgKDEgPDwgMCkJLyog
c3VwcG9ydGVkIHBhZ2Ugc2l6ZXMgaW5mbyAqLwo+PiAgIAlfX3U2NAlpb3ZhX3Bnc2l6ZXM7CQkv
KiBCaXRtYXAgb2Ygc3VwcG9ydGVkIHBhZ2Ugc2l6ZXMgKi8KPj4gKyNkZWZpbmUgVkZJT19JT01N
VV9JTkZPX0NBUEFCSUxJVElFUyAoMSA8PCAxKSAgLyogc3VwcG9ydCBjYXBhYmlsaXRpZXMgaW5m
byAqLwo+PiArCV9fdTY0ICAgY2FwX29mZnNldDsgICAgIC8qIE9mZnNldCB3aXRoaW4gaW5mbyBz
dHJ1Y3Qgb2YgZmlyc3QgY2FwICovCj4+ICt9Owo+PiArCj4+ICsjZGVmaW5lIFZGSU9fSU9NTVVf
SU5GT19DQVBfUUZOCQkxCj4+ICsjZGVmaW5lIFZGSU9fSU9NTVVfSU5GT19DQVBfUUdSUAkyCj4g
Cj4gRGVzY3JpcHRpb25zPwo+IAo+PiArCj4+ICtzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9pbmZv
X2Jsb2NrIHsKPj4gKwlzdHJ1Y3QgdmZpb19pbmZvX2NhcF9oZWFkZXIgaGVhZGVyOwo+PiArCV9f
dTMyIGRhdGFbXTsKPj4gICB9Owo+PiAgIAo+PiAgICNkZWZpbmUgVkZJT19JT01NVV9HRVRfSU5G
TyBfSU8oVkZJT19UWVBFLCBWRklPX0JBU0UgKyAxMikKPiAKPiBUaGlzIGlzIGp1c3QgYSBibG9i
IG9mIGRhdGEsIHdoYXQncyB0aGUgQVBJPyAgSG93IGRvIHdlIHJldmlzaW9uIGl0Pwo+IEhvdyBk
b2VzIHRoZSB1c2VyIGtub3cgaG93IHRvIGludGVycHJldCBpdD8gIER1bXBpbmcga2VybmVsIGlu
dGVybmFsCj4gc3RydWN0dXJlcyBvdXQgdG8gdXNlcnNwYWNlIGxpa2UgdGhpcyBpcyBub3QgYWNj
ZXB0YWJsZSwgZGVmaW5lIGEgdXNlcgo+IEFQSS4gVGhhbmtzLAo+IAo+IEFsZXgKPiAKClRoYW5r
cyBBbGV4IGZvciB0aGUgY29tbWVudHMuCkkgd2lsbCBhZGQgdGhlIGRlY3JpcHRpb24gYW5kIHRo
ZSB1c2VyIEFQSSBmb3IgdGhlIG5leHQgaXRlcmF0aW9uLgoKUmVnYXJkcywKUGllcnJlCgoKCgot
LSAKUGllcnJlIE1vcmVsCkxpbnV4L0tWTS9RRU1VIGluIELDtmJsaW5nZW4gLSBHZXJtYW55Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
