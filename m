Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76177C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 17:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17E0C416FA;
	Tue, 15 Mar 2022 17:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ocyp7vrnkRl; Tue, 15 Mar 2022 17:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A649E41674;
	Tue, 15 Mar 2022 17:01:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 626E7C001A;
	Tue, 15 Mar 2022 17:01:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C079C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F31840217
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uypc8NRPDKiR for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64E9040012
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:01:47 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FGER9D019722; 
 Tue, 15 Mar 2022 17:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UOFhKzT17r8nHIqX6nZiw4Y/vWOMIJIOjcg3nyKy1QQ=;
 b=R3UGugpuMTgE6waYe6YGdG7UhuL+IOk70WHlR4rlVjJlpz2++90ODFIhl5VfmtPJuFgL
 yhXV5WhPBh9h49nAuLqAkUTVW/SfULAbLp7QObDFfeHnwm9JK8rk5hHdVTQLME5sAPXC
 rzjDKCAWn5MfgsQzP1LXeIoNc9aapdtfpYM3JcuLN1wB6Yr3rfGjXX0i/8zVtIcvVzrn
 apYAkwUgsIDTjA0WnuM0UT6q3K1zFF4KOk7ndyMMnsuJwcwY0xYI1p7l/SMFXrUbCwLr
 BTVapz29vWqrmm4AKhcRLwnC7rQmWmBtJK6w+dv2Y5ULXn9kLfRWjAGDlHC2RDgrAKvf Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etvbmcbww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 17:01:34 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22FGpTNY030717;
 Tue, 15 Mar 2022 17:01:34 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3etvbmcbw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 17:01:34 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FGxCYP013147;
 Tue, 15 Mar 2022 17:01:33 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma05wdc.us.ibm.com with ESMTP id 3erk59y3ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Mar 2022 17:01:32 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22FH1ViF33227018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 17:01:31 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56FCF6A051;
 Tue, 15 Mar 2022 17:01:31 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A9B6A047;
 Tue, 15 Mar 2022 17:01:28 +0000 (GMT)
Received: from [9.211.32.184] (unknown [9.211.32.184])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 15 Mar 2022 17:01:28 +0000 (GMT)
Message-ID: <99c7585c-47c5-9995-3fe6-c75f412b3479@linux.ibm.com>
Date: Tue, 15 Mar 2022 13:01:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 15/32] vfio: introduce KVM-owned IOMMU type
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
 <20220314194451.58266-16-mjrosato@linux.ibm.com>
 <20220314165033.6d2291a5.alex.williamson@redhat.com>
 <20220314231801.GN11336@nvidia.com>
 <BL1PR11MB5271DE700698C5FB11F5EEE78C109@BL1PR11MB5271.namprd11.prod.outlook.com>
 <72dd168c-dd40-356c-1fe5-02bdfca57d73@linux.ibm.com>
In-Reply-To: <72dd168c-dd40-356c-1fe5-02bdfca57d73@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N7tfK37i4kJI7EzIQuKp76cTvmkOIo_4
X-Proofpoint-ORIG-GUID: Ohnogp1Ve9NEPlsuNV3Iw-LKunz56h8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_08,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150104
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "david@redhat.com" <david@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vneethv@linux.ibm.com" <vneethv@linux.ibm.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
 "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "freude@linux.ibm.com" <freude@linux.ibm.com>,
 "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
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

T24gMy8xNS8yMiAxMDoxNyBBTSwgTWF0dGhldyBSb3NhdG8gd3JvdGU6Cj4gT24gMy8xNS8yMiAz
OjU3IEFNLCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+Cj4+PiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxNSwgMjAyMiA3OjE4IEFNCj4+
Pgo+Pj4gT24gTW9uLCBNYXIgMTQsIDIwMjIgYXQgMDQ6NTA6MzNQTSAtMDYwMCwgQWxleCBXaWxs
aWFtc29uIHdyb3RlOgo+Pj4KPj4+Pj4gKy8qCj4+Pj4+ICsgKiBUaGUgS1ZNX0lPTU1VIHR5cGUg
aW1wbGllcyB0aGF0IHRoZSBoeXBlcnZpc29yIHdpbGwgY29udHJvbCB0aGUKPj4+IG1hcHBpbmdz
Cj4+Pj4+ICsgKiByYXRoZXIgdGhhbiB1c2Vyc3BhY2UKPj4+Pj4gKyAqLwo+Pj4+PiArI2RlZmlu
ZSBWRklPX0tWTV9JT01NVcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTEKPj4+Pgo+Pj4+IFRoZW4g
d2h5IGlzIHRoaXMgaG9zdGVkIGluIHRoZSB0eXBlMSBjb2RlIHRoYXQgZXhwb3NlcyBhIHdpZGUg
dmFyaWV0eQo+Pj4+IG9mIHVzZXJzcGFjZSBpbnRlcmZhY2VzP8KgIFRoYW5rcywKPj4+Cj4+PiBJ
dCBpcyByZWFsbHkgYmFkbHkgbmFtZWQsIHRoaXMgaXMgdGhlIHJvb3QgbGV2ZWwgb2YgYSAyIHN0
YWdlIG5lc3RlZAo+Pj4gSU8gcGFnZSB0YWJsZSwgYW5kIHRoaXMgYXBwcm9hY2ggbmVlZGVkIGEg
c3BlY2lhbCBmbGFnIHRvIGRpc3Rpbmd1aXNoCj4+PiB0aGUgc2V0dXAgZnJvbSB0aGUgbm9ybWFs
IGlvbW11X2RvbWFpbi4KPj4+Cj4+PiBJZiB3ZSBkbyB0cnkgdG8gc3RpY2sgdGhpcyBpbnRvIFZG
SU8gaXQgc2hvdWxkIHByb2JhYmx5IHVzZSB0aGUKPj4+IFZGSU9fVFlQRTFfTkVTVElOR19JT01N
VSBpbnN0ZWFkIC0gaG93ZXZlciwgd2Ugd291bGQgbGlrZSB0byBkZWxldGUKPj4+IHRoYXQgZmxh
ZyBlbnRpcmVseSBhcyBpdCB3YXMgbmV2ZXIgZnVsbHkgaW1wbGVtZW50ZWQsIHdhcyBuZXZlciB1
c2VkLAo+Pj4gYW5kIGlzbid0IHBhcnQgb2Ygd2hhdCB3ZSBhcmUgcHJvcG9zaW5nIGZvciBJT01N
VSBuZXN0aW5nIG9uIEFSTQo+Pj4gYW55aG93LiAoU28gZmFyIEkndmUgZm91bmQgbm9ib2R5IHRv
IGV4cGxhaW4gd2hhdCB0aGUgcGxhbiBoZXJlIHdhcy4uKQo+Pj4KPj4+IFRoaXMgaXMgd2h5IEkg
c2FpZCB0aGUgc2Vjb25kIGxldmVsIHNob3VsZCBiZSBhbiBleHBsaWNpdCBpb21tdV9kb21haW4K
Pj4+IGFsbCBvbiBpdHMgb3duIHRoYXQgaXMgZXhwbGljaXRseSBjb3VwbGVkIHRvIHRoZSBLVk0g
dG8gcmVhZCB0aGUgcGFnZQo+Pj4gdGFibGVzLCBpZiBuZWNlc3NhcnkuCj4+Pgo+Pj4gQnV0IEkn
bSBub3Qgc3VyZSB0aGF0IHJlYWRpbmcgdGhlIHVzZXJzcGFjZSBpbyBwYWdlIHRhYmxlcyB3aXRo
IEtWTSBpcwo+Pj4gZXZlbiB0aGUgYmVzdCB0aGluZyB0byBkbyAtIHRoZSBpb21tdSBkcml2ZXIg
YWxyZWFkeSBoYXMgdGhlIHBpbm5lZAo+Pj4gbWVtb3J5LCBpdCB3b3VsZCBiZSBmYXN0ZXIgYW5k
IG1vcmUgbW9kdWxhciB0byB0cmF2ZXJzZSB0aGUgaW8gcGFnZQo+Pj4gdGFibGVzIHRocm91Z2gg
dGhlIHBmbnMgaW4gdGhlIHJvb3QgaW9tbXVfZG9tYWluIHRoYW4gYnkgaGF2aW5nIEtWTSBkbwo+
Pj4gdGhlIHRyYW5zbGF0aW9ucy4gTGV0cyBzZWUgd2hhdCBNYXR0aGV3IHNheXMuLgo+Pj4KPj4K
Pj4gUmVhZGluZyB0aGlzIHRocmVhZCBpdCdzIHNvcnQgb2YgbGlrZSBhbiBvcHRpbWl6YXRpb24g
dG8gc29mdHdhcmUgCj4+IG5lc3RpbmcuCj4gCj4gWWVzLCB3ZSB3YW50IHRvIGF2b2lkIGJyZWFr
aW5nIHRvIHVzZXJzcGFjZSBmb3IgYSB2ZXJ5IGZyZXF1ZW50IAo+IG9wZXJhdGlvbiAoUlBDSVQg
LyB1cGRhdGluZyBzaGFkb3cgbWFwcGluZ3MpCj4gCj4+IElmIHRoYXQgaXMgdGhlIGNhc2UgZG9l
cyBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gY29tcGxldGUgdGhlIGJhc2ljIGZvcm0KPj4gb2Ygc29m
dHdhcmUgbmVzdGluZyBmaXJzdCBhbmQgdGhlbiBhZGRzIHRoaXMgb3B0aW1pemF0aW9uPwo+Pgo+
PiBUaGUgYmFzaWMgZm9ybSB3b3VsZCBhbGxvdyB0aGUgdXNlcnNwYWNlIHRvIGNyZWF0ZSBhIHNw
ZWNpYWwgZG9tYWluCj4+IHR5cGUgd2hpY2ggcG9pbnRzIHRvIGEgdXNlci9ndWVzdCBwYWdlIHRh
YmxlIChsaWtlIGhhcmR3YXJlIG5lc3RpbmcpCj4+IGJ1dCBkb2Vzbid0IGluc3RhbGwgdGhlIHVz
ZXIgcGFnZSB0YWJsZSB0byB0aGUgSU9NTVUgaGFyZHdhcmUgKHVubGlrZQo+PiBoYXJkd2FyZSBu
ZXN0aW5nKS4gV2hlbiByZWNlaXZpbmcgaW52YWxpZGF0ZSBjbWQgZnJvbSB1c2Vyc3BhY2UgPiB0
aGUgCj4+IGlvbW11IGRyaXZlciB3YWxrcyB0aGUgdXNlciBwYWdlIHRhYmxlICgxc3QtbGV2ZWwp
IGFuZCB0aGUgcGFyZW50Cj4+IHBhZ2UgdGFibGUgKDJuZC1sZXZlbCkgdG8gZ2VuZXJhdGUgYSBz
aGFkb3cgbWFwcGluZyBmb3IgdGhlCj4+IGludmFsaWRhdGVkIHJhbmdlIGluIHRoZSBub24tbmVz
dGVkIGhhcmR3YXJlIHBhZ2UgdGFibGUgb2YgdGhpcwo+PiBzcGVjaWFsIGRvbWFpbiB0eXBlLgo+
Pgo+PiBPbmNlIHRoYXQgd29ya3Mgd2hhdCB0aGlzIHNlcmllcyBkb2VzIGp1c3QgY2hhbmdlcyB0
aGUgbWF0dGVyIG9mCj4+IGhvdyB0aGUgaW52YWxpZGF0ZSBjbWQgaXMgdHJpZ2dlcmVkLiBQcmV2
aW91c2x5IGlvbW11IGRyaXZlciByZWNlaXZlcwo+PiBpbnZhbGlkYXRlIGNtZCBmcm9tIFFlbXUg
KHZpYSBpb21tdWZkIHVBUEkpIHdoaWxlIG5vdyByZWNlaXZpbmcKPj4gdGhlIGNtZCBmcm9tIGt2
bSAodmlhIGlvbW11ZmQga0FQSSkgdXBvbiBpbnRlcmNlcHRpb24gb2YgUlBDSVQuCj4+IMKgRnJv
bSB0aGlzIGFuZ2xlIG9uY2UgdGhlIGNvbm5lY3Rpb24gYmV0d2VlbiBpb21tdWZkIGFuZCBrdm0g
ZmQKPj4gaXMgZXN0YWJsaXNoZWQgdGhlcmUgaXMgZXZlbiBubyBkaXJlY3QgdGFsayBiZXR3ZWVu
IGlvbW11IGRyaXZlciBhbmQKPj4ga3ZtLgo+IAo+IEJ1dCBzb21ldGhpbmcgc29tZXdoZXJlIHN0
aWxsIG5lZWRzIHRvIGJlIHJlc3BvbnNpYmxlIGZvciAKPiBwaW5uaW5nL3VucGlubmluZyBvZiB0
aGUgZ3Vlc3QgdGFibGUgZW50cmllcyB1cG9uIGVhY2ggUlBDSVQgCj4gaW50ZXJjZXB0aW9uLsKg
IGUuZy4gdGhlIFJQQ0lUIGludGVyY2VwdCBjYW4gaGFwcGVuIGJlY2F1c2UgdGhlIGd1ZXN0IAo+
IHdhbnRzIHRvIGludmFsaWRhdGUgc29tZSBvbGQgbWFwcGluZ3Mgb3IgaGFzIGdlbmVyYXRlZCBz
b21lIG5ldyBtYXBwaW5ncyAKPiBvdmVyIGEgcmFuZ2UsIHNvIHdlIG11c3Qgc2hhZG93IHRoZSBu
ZXcgbWFwcGluZ3MgKGJ5IHBpbm5pbmcgdGhlIGd1ZXN0IAo+IGVudHJpZXMgYW5kIHBsYWNpbmcg
dGhlbSBpbiB0aGUgaG9zdCBoYXJkd2FyZSB0YWJsZSAvIHVucGlubmluZyAKPiBpbnZhbGlkYXRl
ZCBvbmVzIGFuZCBjbGVhcmluZyB0aGVpciBlbnRyeSBpbiB0aGUgaG9zdCBoYXJkd2FyZSB0YWJs
ZSkuCj4gCgpPSywgdGhpcyBnb3QgY2xhcmlmaWVkIGJ5IEphc29uIGluIGFub3RoZXIgdGhyZWFk
OiBXaGF0IEkgd2FzIG1pc3NpbmcgCmhlcmUgd2FzIGFuIGFzc3VtcHRpb24gdGhhdCB0aGUgMXN0
LWxldmVsIGhhcyBhbHJlYWR5IG1hcHBlZCBhbmQgcGlubmVkIAphbGwgb2YgZ3Vlc3QgcGh5c2lj
YWwgYWRkcmVzcyBzcGFjZTsgaW4gdGhhdCBjYXNlIHRoZXJlJ3Mgbm8gbmVlZCB0byAKaW52b2tl
IHBpbi91bnBpbiBvcGVyYXRpb25zIGFnYWluc3QgYSBrdm0gZnJvbSB3aXRoaW4gdGhlIGlvbW11
IGRvbWFpbiAKKHRoaXMgc2VyaWVzIGFzLWlzIGRvZXMgbm90IHBpbiBhbGwgb2YgdGhlIGd1ZXN0
IHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2U7IAppdCBkb2VzIHBpbnMvdW5waW5zIG9uLWRlbWFuZCBh
dCBSUENJVCB0aW1lKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
