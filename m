Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC49C35656
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 14:56:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E45206E2
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 14:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E45206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8083984BF3;
	Fri, 21 Feb 2020 14:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4zMRciReZob; Fri, 21 Feb 2020 14:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC41E863F2;
	Fri, 21 Feb 2020 14:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D059DC07FE;
	Fri, 21 Feb 2020 14:56:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B179C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 14:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 84CB920133
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 14:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2yO1ns2ugdJX for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 14:56:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by silver.osuosl.org (Postfix) with ESMTPS id 7B8DF20116
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 14:56:13 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01LEoplG125346
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 09:56:12 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yadge0w41-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 09:56:12 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
 Fri, 21 Feb 2020 14:56:10 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Feb 2020 14:56:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01LEu3jL46924190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2020 14:56:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C874B4C046;
 Fri, 21 Feb 2020 14:56:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 424374C04E;
 Fri, 21 Feb 2020 14:56:03 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Feb 2020 14:56:03 +0000 (GMT)
Date: Fri, 21 Feb 2020 15:56:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022114-0020-0000-0000-000003AC5719
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022114-0021-0000-0000-000022046169
Message-Id: <20200221155602.4de41fa7.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-21_04:2020-02-21,
 2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210114
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpLCAyMSBGZWIgMjAyMCAxNDoyMjoyNiArMDgwMApKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gCj4gT24gMjAyMC8yLzIxIOS4iuWNiDEyOjA2LCBIYWxpbCBQ
YXNpYyB3cm90ZToKPiA+IEN1cnJlbnRseSBpZiBvbmUgaW50ZW5kcyB0byBydW4gYSBtZW1vcnkg
cHJvdGVjdGlvbiBlbmFibGVkIFZNIHdpdGgKPiA+IHZpcnRpbyBkZXZpY2VzIGFuZCBsaW51eCBh
cyB0aGUgZ3Vlc3QgT1MsIG9uZSBuZWVkcyB0byBzcGVjaWZ5IHRoZQo+ID4gVklSVElPX0ZfSU9N
TVVfUExBVEZPUk0gZmxhZyBmb3IgZWFjaCB2aXJ0aW8gZGV2aWNlIHRvIG1ha2UgdGhlIGd1ZXN0
Cj4gPiBsaW51eCB1c2UgdGhlIERNQSBBUEksIHdoaWNoIGluIHR1cm4gaGFuZGxlcyB0aGUgbWVt
b3J5Cj4gPiBlbmNyeXB0aW9uL3Byb3RlY3Rpb24gc3R1ZmYgaWYgdGhlIGd1ZXN0IGRlY2lkZXMg
dG8gdHVybiBpdHNlbGYgaW50bwo+ID4gYSBwcm90ZWN0ZWQgb25lLiBUaGlzIGhvd2V2ZXIgbWFr
ZXMgbm8gc2Vuc2UgZHVlIHRvIG11bHRpcGxlIHJlYXNvbnM6Cj4gPiAqIFRoZSBkZXZpY2UgaXMg
bm90IGNoYW5nZWQgYnkgdGhlIGZhY3QgdGhhdCB0aGUgZ3Vlc3QgUkFNIGlzCj4gPiBwcm90ZWN0
ZWQuIFRoZSBzbyBjYWxsZWQgSU9NTVUgYnlwYXNzIHF1aXJrIGlzIG5vdCBhZmZlY3RlZC4KPiA+
ICogVGhpcyB1c2FnZSBpcyBub3QgY29uZ3J1ZW50IHdpdGggIHN0YW5kYXJkaXNlZCBzZW1hbnRp
Y3Mgb2YKPiA+IFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNLiBHdWVzdCBtZW1vcnkgcHJvdGVjdGVk
IGlzIGFuIG9ydGhvZ29uYWwgcmVhc29uCj4gPiBmb3IgdXNpbmcgRE1BIEFQSSBpbiB2aXJ0aW8g
KG9ydGhvZ29uYWwgd2l0aCByZXNwZWN0IHRvIHdoYXQgaXMKPiA+IGV4cHJlc3NlZCBieSBWSVJU
SU9fRl9JT01NVV9QTEFURk9STSkuCj4gPgo+ID4gVGhpcyBzZXJpZXMgYWltcyB0byBkZWNvdXBs
ZSAnaGF2ZSB0byB1c2UgRE1BIEFQSSBiZWNhdXNlIG15IChndWVzdCkgUkFNCj4gPiBpcyBwcm90
ZWN0ZWQnIGFuZCAnaGF2ZSB0byB1c2UgRE1BIEFQSSBiZWNhdXNlIHRoZSBkZXZpY2UgdG9sZCBt
ZQo+ID4gVklSVElPX0ZfSU9NTVVfUExBVEZPUk0nLgo+ID4KPiA+IFBsZWFzZSBmaW5kIG1vcmUg
ZGV0YWlsZWQgZXhwbGFuYXRpb25zIGFib3V0IHRoZSBjb25jZXB0dWFsIGFzcGVjdHMgaW4KPiA+
IHRoZSBpbmRpdmlkdWFsIHBhdGNoZXMuIFRoZXJlIGlzIGhvd2V2ZXIgYWxzbyBhIHZlcnkgcHJh
Y3RpY2FsIHByb2JsZW0KPiA+IHRoYXQgaXMgYWRkcmVzc2VkIGJ5IHRoaXMgc2VyaWVzLgo+ID4K
PiA+IEZvciB2aG9zdC1uZXQgdGhlIGZlYXR1cmUgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0gaGFz
IHRoZSBmb2xsb3dpbmcgc2lkZQo+ID4gZWZmZWN0IFRoZSB2aG9zdCBjb2RlIGFzc3VtZXMgaXQg
dGhlIGFkZHJlc3NlcyBvbiB0aGUgdmlydGlvIGRlc2NyaXB0b3IKPiA+IHJpbmcgYXJlIG5vdCBn
dWVzdCBwaHlzaWNhbCBhZGRyZXNzZXMgYnV0IGlvdmEncywgYW5kIGluc2lzdHMgb24gZG9pbmcg
YQo+ID4gdHJhbnNsYXRpb24gb2YgdGhlc2UgcmVnYXJkbGVzcyBvZiB3aGF0IHRyYW5zcG9ydCBp
cyB1c2VkIChlLmcuIHdoZXRoZXIKPiA+IHdlIGVtdWxhdGUgYSBQQ0kgb3IgYSBDQ1cgZGV2aWNl
KS4gKEZvciBkZXRhaWxzIHNlZSBjb21taXQgNmIxZTZjYzc4NTViCj4gPiAidmhvc3Q6IG5ldyBk
ZXZpY2UgSU9UTEIgQVBJIi4pIE9uIHMzOTAgdGhpcyByZXN1bHRzIGluIHNldmVyZQo+ID4gcGVy
Zm9ybWFuY2UgZGVncmFkYXRpb24gKGMuYS4gZmFjdG9yIDEwKS4KPiAKPiAKPiBEbyB5b3Ugc2Vl
IGEgY29uc2lzdGVudCBkZWdyYWRhdGlvbiBvbiB0aGUgcGVyZm9ybWFuY2UsIG9yIGl0IG9ubHkg
Cj4gaGFwcGVuIHdoZW4gZm9yIGR1cmluZyB0aGUgYmVnaW5uaW5nIG9mIHRoZSB0ZXN0Pwo+IAoK
QUZBSUsgdGhlIGRlZ3JhZGF0aW9uIGlzIGNvbnNpc3RlbnQuCgo+IAo+ID4gQlRXIHdpdGggY2N3
IEkvTyB0aGVyZSBpcwo+ID4gKGFyY2hpdGVjdHVyYWxseSkgbm8gSU9NTVUsIHNvIHRoZSB3aG9s
ZSBhZGRyZXNzIHRyYW5zbGF0aW9uIG1ha2VzIG5vCj4gPiBzZW5zZSBpbiB0aGUgY29udGV4dCBv
ZiB2aXJ0aW8tY2N3Lgo+IAo+IAo+IEkgc3VzcGVjdCB3ZSBjYW4gZG8gb3B0aW1pemF0aW9uIGlu
IHFlbXUgc2lkZS4KPiAKPiBFLmcgc2VuZCBtZW10YWJsZSBlbnRyeSB2aWEgSU9UTEIgQVBJIHdo
ZW4gdklPTU1VIGlzIG5vdCBlbmFibGVkLgo+IAo+IElmIHRoaXMgbWFrZXMgc2Vuc2UsIEkgY2Fu
IGRyYWZ0IHBhdGNoIHRvIHNlZSBpZiB0aGVyZSdzIGFueSBkaWZmZXJlbmNlLgoKRnJhbmtseSBJ
IHdvdWxkIHByZWZlciB0byBhdm9pZCBJT1ZBcyBvbiB0aGUgZGVzY3JpcHRvciByaW5nIChhbmQg
dGhlCnRoZW4gbmVjZXNzYXJ5IHRyYW5zbGF0aW9uKSBmb3IgdmlydGlvLWNjdyBhbHRvZ2V0aGVy
LiBCdXQgTWljaGFlbAp2b2ljZWQgaGlzIG9waW5pb24gdGhhdCB3ZSBzaG91bGQgbWFuZGF0ZSBG
X0lPTU1VX1BMQVRGT1JNIGZvciBkZXZpY2VzCnRoYXQgY291bGQgYmUgdXNlZCB3aXRoIGd1ZXN0
cyBydW5uaW5nIGluIHByb3RlY3RlZCBtb2RlLiBJIGRvbid0IHNoYXJlCmhpcyBvcGluaW9uLCBi
dXQgdGhhdCdzIGFuIG9uZ29pbmcgZGlzY3Vzc2lvbi4KClNob3VsZCB3ZSBlbmQgdXAgaGF2aW5n
IHRvIGRvIHRyYW5zbGF0aW9uIGZyb20gSU9WQSBpbiB2aG9zdCwgd2UgYXJlCnZlcnkgaW50ZXJl
c3RlZCBpbiB0aGF0IHRyYW5zbGF0aW9uIGJlaW5nIGZhc3QgYW5kIGVmZmljaWVudC4KCkluIHRo
YXQgc2Vuc2Ugd2Ugd291bGQgYmUgdmVyeSBoYXBweSB0byB0ZXN0IGFueSBvcHRpbWl6YXRpb24g
dGhhdCBhaW0KaW50byB0aGF0IGRpcmVjdGlvbi4KClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlv
dXIgaW5wdXQhCgpSZWdhcmRzLApIYWxpbAoKPiAKPiBUaGFua3MKPiAKPiAKPiA+Cj4gPiBIYWxp
bCBQYXNpYyAoMik6Cj4gPiAgICBtbTogbW92ZSBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSB0byBt
ZW1fZW5jcnlwdC5oCj4gPiAgICB2aXJ0aW86IGxldCB2aXJ0aW8gdXNlIERNQSBBUEkgd2hlbiBn
dWVzdCBSQU0gaXMgcHJvdGVjdGVkCj4gPgo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jIHwgIDMgKysrCj4gPiAgIGluY2x1ZGUvbGludXgvZG1hLWRpcmVjdC5oICAgfCAgOSAtLS0t
LS0tLS0KPiA+ICAgaW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5oICB8IDEwICsrKysrKysrKysK
PiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+
ID4KPiA+Cj4gPiBiYXNlLWNvbW1pdDogY2E3ZTFmZDEwMjZjNWFmNmE1MzNiNGI1NDQ3ZTFkMmYx
NTNlMjhmMgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
