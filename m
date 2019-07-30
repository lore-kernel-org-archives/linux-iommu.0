Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF983C0650F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 11:28:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2DD2087F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 11:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2DD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2742D2C0A;
	Tue, 30 Jul 2019 11:28:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E487D2BFD
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 11:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 400B1D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 11:22:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B350228;
	Tue, 30 Jul 2019 04:22:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B416E3F575;
	Tue, 30 Jul 2019 04:22:26 -0700 (PDT)
Subject: Re: Failure to recreate virtual functions
To: Lu Baolu <baolu.lu@linux.intel.com>, Vlad Buslov <vladbu@mellanox.com>
References: <vbf8sskwyiv.fsf@mellanox.com>
	<d4166595-ec4a-fc4a-3b5f-463b79c42936@linux.intel.com>
	<vbfzhkx9n32.fsf@mellanox.com>
	<838a00c4-d5bd-08db-e39c-5f00686858b5@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6ece232e-3fe8-4bd9-cd4b-c8d90a106a30@arm.com>
Date: Tue, 30 Jul 2019 12:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <838a00c4-d5bd-08db-e39c-5f00686858b5@linux.intel.com>
Content-Language: en-GB
Cc: Maor Gottlieb <maorg@mellanox.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ran Rozenstein <ranro@mellanox.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMzAvMDcvMjAxOSAwNToyOCwgTHUgQmFvbHUgd3JvdGU6Cj4gSGksCj4gCj4gT24gNy8yOS8x
OSA2OjA1IFBNLCBWbGFkIEJ1c2xvdiB3cm90ZToKPj4gT24gU2F0IDI3IEp1bCAyMDE5IGF0IDA1
OjE1LCBMdSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+wqAgd3JvdGU6Cj4+PiBIaSBW
aWxhZCwKPj4+Cj4+PiBPbiA3LzI3LzE5IDEyOjMwIEFNLCBWbGFkIEJ1c2xvdiB3cm90ZToKPj4+
PiBIaSBMdSBCYW9sdSwKPj4+Pgo+Pj4+IE91ciBtbHg1IGRyaXZlciBmYWlscyB0byByZWNyZWF0
ZSBWRnMgd2hlbiBjbWRsaW5lIGluY2x1ZGVzCj4+Pj4gImludGVsX2lvbW11PW9uIGlvbW11PXB0
IiBhZnRlciByZWNlbnQgbWVyZ2Ugb2YgcGF0Y2ggc2V0ICJpb21tdS92dC1kOgo+Pj4+IERlbGVn
YXRlIERNQSBkb21haW4gdG8gZ2VuZXJpYyBpb21tdSIuIEkndmUgYmlzZWN0ZWQgdGhlIGZhaWx1
cmUgdG8KPj4+PiBwYXRjaCBiNzI5Nzc4M2MyYmIgKCJpb21tdS92dC1kOiBSZW1vdmUgZHVwbGlj
YXRlZCBjb2RlIGZvciBkZXZpY2UKPj4+PiBob3RwbHVnIikuIEhlcmUgaXMgdGhlIGRtZXNnIGxv
ZyBmb3IgZm9sbG93aW5nIGNhc2U6IGVuYWJsZSBzd2l0Y2hkZXYKPj4+PiBtb2RlLCBzZXQgbnVt
YmVyIG9mIFZGcyB0byAwLCB0aGVuIHNldCBpdCBiYWNrIHRvIGFueSB2YWx1ZQo+Pj4+PiAwLgo+
Pj4+IFvCoCAyMjMuNTI1MjgyXSBtbHg1X2NvcmUgMDAwMDo4MTowMC4wOiBFLVN3aXRjaDogRS1T
d2l0Y2ggZW5hYmxlIAo+Pj4+IFNSSU9WOiBudmZzKDIpIG1vZGUgKDEpCj4+Pj4gW8KgIDIyMy41
NjIwMjddIG1seDVfY29yZSAwMDAwOjgxOjAwLjA6IEUtU3dpdGNoOiBTUklPViBlbmFibGVkOiAK
Pj4+PiBhY3RpdmUgdnBvcnRzKDMpCj4+Pj4gW8KgIDIyMy42NjM3NjZdIHBjaSAwMDAwOjgxOjAw
LjI6IFsxNWIzOjEwMWFdIHR5cGUgMDAgY2xhc3MgMHgwMjAwMDAKPj4+PiBbwqAgMjIzLjY2Mzg2
NF0gcGNpIDAwMDA6ODE6MDAuMjogZW5hYmxpbmcgRXh0ZW5kZWQgVGFncwo+Pj4+IFvCoCAyMjMu
NjY1MTQzXSBwY2kgMDAwMDo4MTowMC4yOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNTIKPj4+PiBb
wqAgMjIzLjY2NTIxNV0gcGNpIDAwMDA6ODE6MDAuMjogVXNpbmcgaW9tbXUgZGlyZWN0IG1hcHBp
bmcKPj4+PiBbwqAgMjIzLjY2NTc3MV0gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMjogZW5hYmxpbmcg
ZGV2aWNlICgwMDAwIC0+IDAwMDIpCj4+Pj4gW8KgIDIyMy42NjU4OTBdIG1seDVfY29yZSAwMDAw
OjgxOjAwLjI6IGZpcm13YXJlIHZlcnNpb246IDE2LjI2LjE0OAo+Pj4+IFvCoCAyMjMuODg5OTA4
XSBtbHg1X2NvcmUgMDAwMDo4MTowMC4yOiBSYXRlIGxpbWl0OiAxMjcgcmF0ZXMgYXJlIAo+Pj4+
IHN1cHBvcnRlZCwgcmFuZ2U6IDBNYnBzIHRvIDk3NjU2TWJwcwo+Pj4+IFvCoCAyMjMuODk2NDM4
XSBtbHg1X2NvcmUgMDAwMDo4MTowMC4yOiBNTFg1RTogU3RyZFJxKDEpIFJxU3ooOCkgCj4+Pj4g
U3RyZFN6KDIwNDgpIFJ4Q3FlQ21wcnNzKDApCj4+Pj4gW8KgIDIyMy44OTY2MzZdIG1seDVfY29y
ZSAwMDAwOjgxOjAwLjI6IEFzc2lnbmVkIHJhbmRvbSBNQUMgYWRkcmVzcyAKPj4+PiA1NjoxZjo5
NTplMDo1MTpkNgo+Pj4+IFvCoCAyMjQuMDEyOTA1XSBtbHg1X2NvcmUgMDAwMDo4MTowMC4yIGVu
czFmMHYwOiByZW5hbWVkIGZyb20gZXRoMAo+Pj4+IFvCoCAyMjQuMDQxNjUxXSBwY2kgMDAwMDo4
MTowMC4zOiBbMTViMzoxMDFhXSB0eXBlIDAwIGNsYXNzIDB4MDIwMDAwCj4+Pj4gW8KgIDIyNC4w
NDE3MTFdIHBjaSAwMDAwOjgxOjAwLjM6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MKPj4+PiBbwqAg
MjI0LjA0MzY2MF0gcGNpIDAwMDA6ODE6MDAuMzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDUzCj4+
Pj4gW8KgIDIyNC4wNDM3MzhdIHBjaSAwMDAwOjgxOjAwLjM6IFVzaW5nIGlvbW11IGRpcmVjdCBt
YXBwaW5nCj4+Pj4gW8KgIDIyNC4wNDQxOTZdIG1seDVfY29yZSAwMDAwOjgxOjAwLjM6IGVuYWJs
aW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQo+Pj4+IFvCoCAyMjQuMDQ0Mjk4XSBtbHg1X2NvcmUg
MDAwMDo4MTowMC4zOiBmaXJtd2FyZSB2ZXJzaW9uOiAxNi4yNi4xNDgKPj4+PiBbwqAgMjI0LjI2
ODA5OV0gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMzogUmF0ZSBsaW1pdDogMTI3IHJhdGVzIGFyZSAK
Pj4+PiBzdXBwb3J0ZWQsIHJhbmdlOiAwTWJwcyB0byA5NzY1Nk1icHMKPj4+PiBbwqAgMjI0LjI3
NDk4M10gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMzogTUxYNUU6IFN0cmRScSgxKSBScVN6KDgpIAo+
Pj4+IFN0cmRTeigyMDQ4KSBSeENxZUNtcHJzcygwKQo+Pj4+IFvCoCAyMjQuMjc1MTk1XSBtbHg1
X2NvcmUgMDAwMDo4MTowMC4zOiBBc3NpZ25lZCByYW5kb20gTUFDIGFkZHJlc3MgCj4+Pj4gYTY6
MWU6NTY6MGE6ZDk6ZjIKPj4+PiBbwqAgMjI0LjM4ODM1OV0gbWx4NV9jb3JlIDAwMDA6ODE6MDAu
MyBlbnMxZjB2MTogcmVuYW1lZCBmcm9tIGV0aDAKPj4+PiBbwqAgMjM2LjMyNTAyN10gbWx4NV9j
b3JlIDAwMDA6ODE6MDAuMDogRS1Td2l0Y2g6IGRpc2FibGUgU1JJT1Y6IAo+Pj4+IGFjdGl2ZSB2
cG9ydHMoMykgbW9kZSgxKQo+Pj4+IFvCoCAyMzYuMzYyNzY2XSBtbHg1X2NvcmUgMDAwMDo4MTow
MC4wOiBFLVN3aXRjaDogRS1Td2l0Y2ggZW5hYmxlIAo+Pj4+IFNSSU9WOiBudmZzKDIpIG1vZGUg
KDIpCj4+Pj4gW8KgIDIzNy4yOTAwNjZdIG1seDVfY29yZSAwMDAwOjgxOjAwLjA6IE1MWDVFOiBT
dHJkUnEoMSkgUnFTeig4KSAKPj4+PiBTdHJkU3ooMjA0OCkgUnhDcWVDbXByc3MoMCkKPj4+PiBb
wqAgMjM3LjM1MDIxNV0gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMDogTUxYNUU6IFN0cmRScSgxKSBS
cVN6KDgpIAo+Pj4+IFN0cmRTeigyMDQ4KSBSeENxZUNtcHJzcygwKQo+Pj4+IFvCoCAyMzcuMzcz
MDUyXSBtbHg1X2NvcmUgMDAwMDo4MTowMC4wIGVuczFmMDogcmVuYW1lZCBmcm9tIGV0aDAKPj4+
PiBbwqAgMjM3LjM5MDc2OF0gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMDogTUxYNUU6IFN0cmRScSgx
KSBScVN6KDgpIAo+Pj4+IFN0cmRTeigyMDQ4KSBSeENxZUNtcHJzcygwKQo+Pj4+IFvCoCAyMzcu
NDQ3ODQ2XSBlbnMxZjBfMDogcmVuYW1lZCBmcm9tIGV0aDAKPj4+PiBbwqAgMjM3LjQ2MDM5OV0g
bWx4NV9jb3JlIDAwMDA6ODE6MDAuMDogRS1Td2l0Y2g6IFNSSU9WIGVuYWJsZWQ6IAo+Pj4+IGFj
dGl2ZSB2cG9ydHMoMykKPj4+PiBbwqAgMjM3LjUyNjg4MF0gZW5zMWYwXzE6IHJlbmFtZWQgZnJv
bSBldGgxCj4+Pj4gW8KgIDI0OC45NTM4NzNdIHBjaSAwMDAwOjgxOjAwLjI6IFJlbW92aW5nIGZy
b20gaW9tbXUgZ3JvdXAgNTIKPj4+PiBbwqAgMjQ4Ljk1NDExNF0gcGNpIDAwMDA6ODE6MDAuMzog
UmVtb3ZpbmcgZnJvbSBpb21tdSBncm91cCA1Mwo+Pj4+IFvCoCAyNDkuOTYwNTcwXSBtbHg1X2Nv
cmUgMDAwMDo4MTowMC4wOiBFLVN3aXRjaDogZGlzYWJsZSBTUklPVjogCj4+Pj4gYWN0aXZlIHZw
b3J0cygzKSBtb2RlKDIpCj4+Pj4gW8KgIDI1MC4zMTkxMzVdIG1seDVfY29yZSAwMDAwOjgxOjAw
LjA6IE1MWDVFOiBTdHJkUnEoMSkgUnFTeig4KSAKPj4+PiBTdHJkU3ooMjA0OCkgUnhDcWVDbXBy
c3MoMCkKPj4+PiBbwqAgMjUwLjU1OTQzMV0gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMCBlbnMxZjA6
IHJlbmFtZWQgZnJvbSBldGgwCj4+Pj4gW8KgIDI1OC44MTkxNjJdIG1seDVfY29yZSAwMDAwOjgx
OjAwLjA6IEUtU3dpdGNoOiBFLVN3aXRjaCBlbmFibGUgCj4+Pj4gU1JJT1Y6IG52ZnMoMikgbW9k
ZSAoMSkKPj4+PiBbwqAgMjU4LjgzMTYyNV0gbWx4NV9jb3JlIDAwMDA6ODE6MDAuMDogRS1Td2l0
Y2g6IFNSSU9WIGVuYWJsZWQ6IAo+Pj4+IGFjdGl2ZSB2cG9ydHMoMykKPj4+PiBbwqAgMjU4Ljkz
NjE2MF0gcGNpIDAwMDA6ODE6MDAuMjogWzE1YjM6MTAxYV0gdHlwZSAwMCBjbGFzcyAweDAyMDAw
MAo+Pj4+IFvCoCAyNTguOTM2MjU4XSBwY2kgMDAwMDo4MTowMC4yOiBlbmFibGluZyBFeHRlbmRl
ZCBUYWdzCj4+Pj4gW8KgIDI1OC45Mzc0MzhdIHBjaSAwMDAwOjgxOjAwLjI6IEZhaWxlZCB0byBh
ZGQgdG8gaW9tbXUgZ3JvdXAgNTI6IC0xNgo+Pj4gSXQgc2VlbXMgdGhhdCBhbiBFQlVTWSBlcnJv
ciByZXR1cm5lZCBmcm9tIGlvbW11X2dyb3VwX2FkZF9kZXZpY2UoKS4gQ2FuCj4+PiB5b3UgcGxl
YXNlIGhhY2sgc29tZSBkZWJ1ZyBtZXNzYWdlcyBpbiBpb21tdV9ncm91cF9hZGRfZGV2aWNlKCkg
c28gdGhhdAo+Pj4gd2UgY2FuIGtub3cgd2hlcmUgdGhlIEVCVVNZIHJldHVybnM/Cj4+Pgo+Pj4g
QmVzdCByZWdhcmRzLAo+Pj4gQmFvbHUKPj4gVGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQgYnkg
X19pb21tdV9hdHRhY2hfZGV2aWNlKCkuCj4+Cj4gCj4gVGhhbmtzIQo+IAo+IEl0IGxvb2tzIGxp
a2UgdGhlIHN5c3RlbSBoYXMgYWxyZWFkeSBhIGRvbWFpbiBmb3Igc3BlY2lmaWMgcGNpIGJkZgo+
IGRldmljZS4gRG9lcyB0aGlzIFZGIHNoYXJlIHRoZSBiZGYgd2l0aCBvdGhlciBkZXZpY2VzPyBP
ciBoYXMgYmVlbgo+IHByZXZpb3VzbHkgY3JlYXRlZCwgYW5kIHN5c3RlbSBmYWlsZWQgdG8gZ2V0
IGNoYW5jZSB0byByZW1vdmUgaXQ/CgpBdCBhIGdsYW5jZSwgaXQgbG9va3MgbGlrZSBpdCBtaWdo
dCBiZSBkb3duIHRvIAppbnRlbF9pb21tdV9yZW1vdmVfZGV2aWNlKCkgbm90IGNhbGxpbmcgZG1h
cl9yZW1vdmVfb25lX2Rldl9pbmZvKCkgbGlrZSAKdGhlIG9sZCBub3RpZmllciBkaWQuIElmIHRo
ZSBncm91cCBpcyBnZXR0aW5nIHRvcm4gZG93biBhbmQgcmVjcmVhdGVkLCAKYnV0IHRoZSBkcml2
ZXIgc3RpbGwgaGFzIGEgc3RhbGUgcG9pbnRlciB0byB0aGUgb2xkIGRlZmF1bHQgZG9tYWluIApj
YWNoZWQsIHdoaWNoIGRtYXJfaW5zZXJ0X29uZV9kZXZfaW5mbygpIGZpbmRzIGFuZCByZXR1cm5z
LCB0aGF0IHdvdWxkIApzZWVtIHRvIGV4cGxhaW4gdGhlIG9ic2VydmVkIGJlaGF2aW91ci4KClJv
YmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
