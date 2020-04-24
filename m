Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C3C2BA1A
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 11:20:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7D206D4
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 11:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7D206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C2D672044B;
	Fri, 24 Apr 2020 11:20:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kXfJJMkDLVsc; Fri, 24 Apr 2020 11:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 451F820336;
	Fri, 24 Apr 2020 11:20:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 239CEC089E;
	Fri, 24 Apr 2020 11:20:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36E61C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 11:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 153E98854A
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 11:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPn8Ac+dQigH for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 11:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id F26F98852A
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 11:20:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0519B1FB;
 Fri, 24 Apr 2020 04:20:41 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 848ED3F6CF;
 Fri, 24 Apr 2020 04:20:40 -0700 (PDT)
Subject: Re: iommu_iova slab eats too much memory
To: Bin <anole1949@gmail.com>, iommu@lists.linux-foundation.org
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
Date: Fri, 24 Apr 2020 12:20:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
Content-Language: en-GB
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

T24gMjAyMC0wNC0yNCAxOjQwIGFtLCBCaW4gd3JvdGU6Cj4gSGVsbG8/IGFueW9uZSB0aGVyZT8K
PiAKPiBCaW4gPGFub2xlMTk0OUBnbWFpbC5jb20+IOS6jjIwMjDlubQ05pyIMjPml6Xlkajlm5sg
5LiL5Y2INToxNOWGmemBk++8mgo+IAo+PiBGb3JnZXQgdG8gbWVudGlvbiwgSSd2ZSBhbHJlYWR5
IGRpc2FibGVkIHRoZSBzbGFiIG1lcmdlLCBzbyB0aGlzIGlzIHdoYXQKPj4gaXQgaXMuCj4+Cj4+
IEJpbiA8YW5vbGUxOTQ5QGdtYWlsLmNvbT4g5LqOMjAyMOW5tDTmnIgyM+aXpeWRqOWbmyDkuIvl
jYg1OjEx5YaZ6YGT77yaCj4+Cj4+PiBIZXksIGd1eXM6Cj4+Pgo+Pj4gSSdtIHJ1bm5pbmcgYSBi
YXRjaCBvZiBDb3JlT1MgYm94ZXMsIHRoZSBsc2JfcmVsZWFzZSBpczoKPj4+Cj4+PiBgYGAKPj4+
ICMgY2F0IC9ldGMvbHNiLXJlbGVhc2UKPj4+IERJU1RSSUJfSUQ9IkNvbnRhaW5lciBMaW51eCBi
eSBDb3JlT1MiCj4+PiBESVNUUklCX1JFTEVBU0U9MjMwMy4zLjAKPj4+IERJU1RSSUJfQ09ERU5B
TUU9IlJoeW9saXRlIgo+Pj4gRElTVFJJQl9ERVNDUklQVElPTj0iQ29udGFpbmVyIExpbnV4IGJ5
IENvcmVPUyAyMzAzLjMuMCAoUmh5b2xpdGUpIgo+Pj4gYGBgCj4+Pgo+Pj4gYGBgCj4+PiAjIHVu
YW1lIC1hCj4+PiBMaW51eCBjbG91ZC13b3JrZXItMjUgNC4xOS44Ni1jb3Jlb3MgIzEgU01QIE1v
biBEZWMgMiAyMDoxMzozOCAtMDAgMjAxOQo+Pj4geDg2XzY0IEludGVsKFIpIFhlb24oUikgQ1BV
IEU1LTI2NDAgdjIgQCAyLjAwR0h6IEdlbnVpbmVJbnRlbCBHTlUvTGludXgKPj4+IGBgYAo+Pj4g
UmVjZW50bHksIEkgZm91bmQgbXkgdm1zIGNvbnN0ZW50bHkgYmVpbmcga2lsbGVkIGR1ZSB0byBP
T00sIGFuZCBhZnRlcgo+Pj4gZGlnZ2luZyBpbnRvIHRoZSBwcm9ibGVtLCBJIGZpbmFsbHkgcmVh
bGl6ZWQgdGhhdCB0aGUga2VybmVsIGlzIGxlYWtpbmcKPj4+IG1lbW9yeS4KPj4+Cj4+PiBIZXJl
J3MgbXkgc2xhYmluZm86Cj4+Pgo+Pj4gICBBY3RpdmUgLyBUb3RhbCBPYmplY3RzICglIHVzZWQp
ICAgIDogODM4MTgzMDYgLyA4NDE5MTYwNyAoOTkuNiUpCj4+PiAgIEFjdGl2ZSAvIFRvdGFsIFNs
YWJzICglIHVzZWQpICAgICAgOiAxMzM2MjkzIC8gMTMzNjI5MyAoMTAwLjAlKQo+Pj4gICBBY3Rp
dmUgLyBUb3RhbCBDYWNoZXMgKCUgdXNlZCkgICAgIDogMTUyIC8gMjE3ICg3MC4wJSkKPj4+ICAg
QWN0aXZlIC8gVG90YWwgU2l6ZSAoJSB1c2VkKSAgICAgICA6IDU4Mjg3NjguMDhLIC8gNTk5Njg0
OC43MksgKDk3LjIlKQo+Pj4gICBNaW5pbXVtIC8gQXZlcmFnZSAvIE1heGltdW0gT2JqZWN0IDog
MC4wMUsgLyAwLjA3SyAvIDIzLjI1Swo+Pj4KPj4+ICAgIE9CSlMgQUNUSVZFICBVU0UgT0JKIFNJ
WkUgIFNMQUJTIE9CSi9TTEFCIENBQ0hFIFNJWkUgTkFNRQo+Pj4KPj4+IDgwMjUzODg4IDgwMjUz
ODg4IDEwMCUgICAgMC4wNksgMTI1Mzk2NyAgICAgICA2NCAgIDUwMTU4NjhLIGlvbW11X2lvdmEK
CkRvIHlvdSByZWFsbHkgaGF2ZSBhIHBlYWsgZGVtYW5kIG9mIH44MCBtaWxsaW9uIHNpbXVsdGFu
ZW91cyBETUEgCmJ1ZmZlcnMsIG9yIGlzIHNvbWUgZHJpdmVyIGxlYWtpbmcgRE1BIG1hcHBpbmdz
PwoKUm9iaW4uCgo+Pj4gNDg5NDcyIDQ4OTEyMyAgOTklICAgIDAuMDNLICAgMzgyNCAgICAgIDEy
OCAgICAgMTUyOTZLIGttYWxsb2MtMzIKPj4+Cj4+PiAyOTc0NDQgMjcxMTEyICA5MSUgICAgMC4x
OUsgICA3MDgyICAgICAgIDQyICAgICA1NjY1NksgZGVudHJ5Cj4+Pgo+Pj4gMjU0NDAwIDI1Mjc4
NCAgOTklICAgIDAuMDZLICAgMzk3NSAgICAgICA2NCAgICAgMTU5MDBLIGFub25fdm1hX2NoYWlu
Cj4+Pgo+Pj4gMjIyNTI4ICAzOTI1NSAgMTclICAgIDAuNTBLICAgNjk1NCAgICAgICAzMiAgICAx
MTEyNjRLIGttYWxsb2MtNTEyCj4+Pgo+Pj4gMjAyNDgyIDIwMTgxNCAgOTklICAgIDAuMTlLICAg
NDgyMSAgICAgICA0MiAgICAgMzg1NjhLIHZtX2FyZWFfc3RydWN0Cj4+Pgo+Pj4gMjAwMTkyIDIw
MDE5MiAxMDAlICAgIDAuMDFLICAgIDM5MSAgICAgIDUxMiAgICAgIDE1NjRLIGttYWxsb2MtOAo+
Pj4KPj4+IDE3MDUyOCAxNjkzNTkgIDk5JSAgICAwLjI1SyAgIDUzMjkgICAgICAgMzIgICAgIDQy
NjMySyBmaWxwCj4+Pgo+Pj4gMTU4MTQ0IDE1MzUwOCAgOTclICAgIDAuMDZLICAgMjQ3MSAgICAg
ICA2NCAgICAgIDk4ODRLIGttYWxsb2MtNjQKPj4+Cj4+PiAxNDk5MTQgMTQ5MzY1ICA5OSUgICAg
MC4wOUsgICAzMjU5ICAgICAgIDQ2ICAgICAxMzAzNksgYW5vbl92bWEKPj4+Cj4+PiAxNDY2NDAg
MTQzMTIzICA5NyUgICAgMC4xMEsgICAzNzYwICAgICAgIDM5ICAgICAxNTA0MEsgYnVmZmVyX2hl
YWQKPj4+Cj4+PiAxMzAzNjggIDMyNzkxICAyNSUgICAgMC4wOUsgICAzMTA0ICAgICAgIDQyICAg
ICAxMjQxNksga21hbGxvYy05Ngo+Pj4KPj4+IDEyOTc1MiAxMjk3NTIgMTAwJSAgICAwLjA3SyAg
IDIzMTcgICAgICAgNTYgICAgICA5MjY4SyBBY3BpLU9wZXJhbmQKPj4+Cj4+PiAxMDU0NjggMTA1
MTA2ICA5OSUgICAgMC4wNEsgICAxMDM0ICAgICAgMTAyICAgICAgNDEzNksKPj4+IHNlbGludXhf
aW5vZGVfc2VjdXJpdHkKPj4+ICAgNzMwODAgIDczMDgwIDEwMCUgICAgMC4xM0sgICAyNDM2ICAg
ICAgIDMwICAgICAgOTc0NEsga2VybmZzX25vZGVfY2FjaGUKPj4+Cj4+PiAgIDcyMzYwICA3MDI2
MSAgOTclICAgIDAuNTlLICAgMTM0MCAgICAgICA1NCAgICAgNDI4ODBLIGlub2RlX2NhY2hlCj4+
Pgo+Pj4gICA3MTA0MCAgNzEwNDAgMTAwJSAgICAwLjEySyAgIDIyMjAgICAgICAgMzIgICAgICA4
ODgwSyBldmVudHBvbGxfZXBpCj4+Pgo+Pj4gICA2ODA5NiAgNTkyNjIgIDg3JSAgICAwLjAySyAg
ICAyNjYgICAgICAyNTYgICAgICAxMDY0SyBrbWFsbG9jLTE2Cj4+Pgo+Pj4gICA1MzY1MiAgNTM2
NTIgMTAwJSAgICAwLjA0SyAgICA1MjYgICAgICAxMDIgICAgICAyMTA0SyBwZGVfb3BlbmVyCj4+
Pgo+Pj4gICA1MDQ5NiAgMzE2NTQgIDYyJSAgICAyLjAwSyAgIDMxNTYgICAgICAgMTYgICAgMTAw
OTkySyBrbWFsbG9jLTIwNDgKPj4+Cj4+PiAgIDQ2MjQyICA0NjI0MiAxMDAlICAgIDAuMTlLICAg
MTEwMSAgICAgICA0MiAgICAgIDg4MDhLIGNyZWRfamFyCj4+Pgo+Pj4gICA0NDQ5NiAgNDMwMTMg
IDk2JSAgICAwLjY2SyAgICA5MjcgICAgICAgNDggICAgIDI5NjY0SyBwcm9jX2lub2RlX2NhY2hl
Cj4+Pgo+Pj4gICA0NDM1MiAgNDQzNTIgMTAwJSAgICAwLjA2SyAgICA2OTMgICAgICAgNjQgICAg
ICAyNzcySyB0YXNrX2RlbGF5X2luZm8KPj4+Cj4+PiAgIDQzNTE2ICA0MzQ3MSAgOTklICAgIDAu
NjlLICAgIDk0NiAgICAgICA0NiAgICAgMzAyNzJLIHNvY2tfaW5vZGVfY2FjaGUKPj4+Cj4+PiAg
IDM3ODU2ICAyNzYyNiAgNzIlICAgIDEuMDBLICAgMTE4MyAgICAgICAzMiAgICAgMzc4NTZLIGtt
YWxsb2MtMTAyNAo+Pj4KPj4+ICAgMzY3MzYgIDM2NzM2IDEwMCUgICAgMC4wN0sgICAgNjU2ICAg
ICAgIDU2ICAgICAgMjYyNEsgZXZlbnRwb2xsX3B3cQo+Pj4KPj4+ICAgMzQwNzYgIDMxMjgyICA5
MSUgICAgMC41N0sgICAxMjE3ICAgICAgIDI4ICAgICAxOTQ3MksgcmFkaXhfdHJlZV9ub2RlCj4+
Pgo+Pj4gICAzMzY2MCAgMzA1MjggIDkwJSAgICAxLjA1SyAgIDExMjIgICAgICAgMzAgICAgIDM1
OTA0SyBleHQ0X2lub2RlX2NhY2hlCj4+Pgo+Pj4gICAzMjc2MCAgMzA5NTkgIDk0JSAgICAwLjE5
SyAgICA3ODAgICAgICAgNDIgICAgICA2MjQwSyBrbWFsbG9jLTE5Mgo+Pj4KPj4+ICAgMzIwMjgg
IDMyMDI4IDEwMCUgICAgMC4wNEsgICAgMzE0ICAgICAgMTAyICAgICAgMTI1NksgZXh0NF9leHRl
bnRfc3RhdHVzCj4+Pgo+Pj4gICAzMDA0OCAgMzAwNDggMTAwJSAgICAwLjI1SyAgICA5MzkgICAg
ICAgMzIgICAgICA3NTEySyBza2J1ZmZfaGVhZF9jYWNoZQo+Pj4KPj4+ICAgMjg3MzYgIDI4NzM2
IDEwMCUgICAgMC4wNksgICAgNDQ5ICAgICAgIDY0ICAgICAgMTc5NksgZnNfY2FjaGUKPj4+Cj4+
PiAgIDI0NzAyICAyNDcwMiAxMDAlICAgIDAuNjlLICAgIDUzNyAgICAgICA0NiAgICAgMTcxODRL
IGZpbGVzX2NhY2hlCj4+Pgo+Pj4gICAyMzgwOCAgMjM4MDggMTAwJSAgICAwLjY2SyAgICA0OTYg
ICAgICAgNDggICAgIDE1ODcySyBvdmxfaW5vZGUKPj4+Cj4+PiAgIDIzMTA0ICAyMjk0NSAgOTkl
ICAgIDAuMTJLICAgIDcyMiAgICAgICAzMiAgICAgIDI4ODhLIGttYWxsb2MtMTI4Cj4+Pgo+Pj4g
ICAyMjcyNCAgMjEzMDcgIDkzJSAgICAwLjY5SyAgICA0OTQgICAgICAgNDYgICAgIDE1ODA4SyBz
aG1lbV9pbm9kZV9jYWNoZQo+Pj4KPj4+ICAgMjE0NzIgIDIxNDcyIDEwMCUgICAgMC4xMksgICAg
NjcxICAgICAgIDMyICAgICAgMjY4NEsgc2VxX2ZpbGUKPj4+Cj4+PiAgIDE5OTA0ICAxOTkwNCAx
MDAlICAgIDEuMDBLICAgIDYyMiAgICAgICAzMiAgICAgMTk5MDRLIFVOSVgKPj4+Cj4+PiAgIDE3
MzQwICAxNzM0MCAxMDAlICAgIDEuMDZLICAgIDU3OCAgICAgICAzMCAgICAgMTg0OTZLIG1tX3N0
cnVjdAo+Pj4KPj4+ICAgMTU5ODAgIDE1OTgwIDEwMCUgICAgMC4wMksgICAgIDk0ICAgICAgMTcw
ICAgICAgIDM3NksgYXZ0YWJfbm9kZQo+Pj4KPj4+ICAgMTQwNzAgIDE0MDcwIDEwMCUgICAgMS4w
NksgICAgNDY5ICAgICAgIDMwICAgICAxNTAwOEsgc2lnbmFsX2NhY2hlCj4+Pgo+Pj4gICAxMzI0
OCAgMTMyNDggMTAwJSAgICAwLjEySyAgICA0MTQgICAgICAgMzIgICAgICAxNjU2SyBwaWQKPj4+
Cj4+PiAgIDEyMTI4ICAxMTc3NyAgOTclICAgIDAuMjVLICAgIDM3OSAgICAgICAzMiAgICAgIDMw
MzJLIGttYWxsb2MtMjU2Cj4+Pgo+Pj4gICAxMTAwOCAgMTEwMDggMTAwJSAgICAwLjAySyAgICAg
NDMgICAgICAyNTYgICAgICAgMTcySwo+Pj4gc2VsaW51eF9maWxlX3NlY3VyaXR5Cj4+PiAgIDEw
ODEyICAxMDgxMiAxMDAlICAgIDAuMDRLICAgIDEwNiAgICAgIDEwMiAgICAgICA0MjRLIEFjcGkt
TmFtZXNwYWNlCj4+Pgo+Pj4gVGhlc2UgaW5mb3JtYXRpb24gc2hvd3MgdGhhdCB0aGUgJ2lvbW11
X2lvdmEnIGlzIHRoZSB0b3AgbWVtb3J5IGNvbnN1bWVyLgo+Pj4gSW4gb3JkZXIgdG8gb3B0aW1p
emUgdGhlIG5ldHdvcmsgcGVyZm9ybWVuY2Ugb2YgT3BlbnN0YWNrIHZpcnR1YWwgbWFjaGluZXMs
Cj4+PiBJIGVuYWJsZWQgdGhlIHZ0LWQgZmVhdHVyZSBpbiBiaW9zIGFuZCBzcmlvdiBmZWF0dXJl
IG9mIEludGVsIDgyNTk5IDEwRwo+Pj4gTklDLiBJJ20gYXNzdW1pbmcgdGhpcyBpcyB0aGUgcm9v
dCBjYXVzZSBvZiB0aGlzIGlzc3VlLgo+Pj4KPj4+IElzIHRoZXJlIGFueXRoaW5nIEkgY2FuIGRv
IHRvIGZpeCBpdD8KPj4+Cj4+Cj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
