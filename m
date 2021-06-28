Return-Path: <SRS0=XPcP=LW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2491BC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 13:20:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B571161C6C
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 13:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B571161C6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81A9640140;
	Mon, 28 Jun 2021 13:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PkLfOCA_8Mj0; Mon, 28 Jun 2021 13:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B80540003;
	Mon, 28 Jun 2021 13:20:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD6E4C0010;
	Mon, 28 Jun 2021 13:20:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9A60C000E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 13:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C474C831E3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 13:20:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ds9kBzViT5tF for <iommu@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:20:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80DE183143
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 13:20:47 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GD7Sf0NGFzZhp4;
 Mon, 28 Jun 2021 21:17:38 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 21:20:42 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 21:20:42 +0800
From: Xingang Wang <wangxingang5@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20210604190430.GA2220179@bjorn-Precision-5520>
 <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com>
Date: Mon, 28 Jun 2021 21:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, robh@kernel.org,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-pci@vger.kernel.org, will@kernel.org
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

SGkgQmpvcm4sCgpJIHdvdWxkIGxpa2UgdG8gYWRkIG1vcmUgZXhwbGFuYXRpb24gYWJvdXQgd2hh
dCBwcm9ibGVtIHRoaXMgcGF0Y2gKZml4ZWQuCgpJIGFtIHRlc3RpbmcgdGhlIFNWQS92U1ZBIHNl
cmllcyBwYXRjaGVzIHdyaXR0ZW4gYnkgQEplYW4gYW5kIEBCcnVja2VyLgpJIHRlc3Qgd2l0aCB0
aGUgZm9sbG93aW5nIHFlbXUgY29tbWFuZCBsaW5lLCB3aXRoIGEgaGlzaWxpY29uIFNFQyBkZXZp
Y2UKYXR0YWNoZWQgb24gYSBwY2llLXJvb3QtcG9ydC4KCiRRRU1VL3FlbXUtc3lzdGVtLWFhcmNo
NjQgXAogICAgIC1lbmFibGUta3ZtIFwKICAgICAta2VybmVsICRMSU5VWC9hcmNoL2FybTY0L2Jv
b3QvSW1hZ2UgXAogICAgIC1tIDE2RyBcCiAgICAgLXNtcCBjb3Jlcz04LHRocmVhZHM9MSxzb2Nr
ZXRzPTIgCVwKICAgICAtbWFjaGluZSB2aXJ0LGtlcm5lbF9pcnFjaGlwPW9uLGdpYy12ZXJzaW9u
PTMsaW9tbXU9c21tdXYzIFwKICAgICAtZGV2aWNlIApwY2llLXJvb3QtcG9ydCxwb3J0PTB4OCxj
aGFzc2lzPTEsaWQ9cGNpLjEsYnVzPXBjaWUuMCxhZGRyPTB4MSBcCiAgICAgLWRldmljZSB2Zmlv
LXBjaSxob3N0PTc1OjAwLjAsYnVzPXBjaS4xLGFkZHI9MHgwLGlkPWFjYzIgXAogICAgIC1uZXQg
bm9uZSBcCiAgICAgLWluaXRyZCAuL21mcy5jcGlvLmd6IFwKICAgICAtY3B1IGhvc3QgXAogICAg
IC1ub2dyYXBoaWMgXAogICAgIC1hcHBlbmQgInJkaW5pdD1pbml0IGNvbnNvbGU9dHR5QU1BMCBl
YXJseWNvbj1wbDAxMSwweDkwMDAwMDAiIFwKCkFuZCBJIGdvdCB0aGUgZ3Vlc3QgUENJIGNvbmZp
Z3VyYXRpb246CjAwOjAwLjAgQ2xhc3MgMDYwMDogRGV2aWNlIDFiMzY6MDAwOCAJCSMgcm9vdCBi
dXMKMDA6MDEuMCBDbGFzcyAwNjA0OiBEZXZpY2UgMWIzNjowMDBjIAkJIyByb290IHBvcnQKCUNh
cGFiaWxpdGllczogWzE0OCB2MV0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMKCQlBQ1NDYXA6CVNy
Y1ZhbGlkKyBUcmFuc0JsaysgUmVxUmVkaXIrIENtcGx0UmVkaXIrIFVwc3RyZWFtRndkKyAKRWdy
ZXNzQ3RybC0gRGlyZWN0VHJhbnMrCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNCbGstIFJlcVJl
ZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gCkVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJ
S2VybmVsIGRyaXZlciBpbiB1c2U6IHBjaWVwb3J0CjAxOjAwLjAgQ2xhc3MgMTAwMDogRGV2aWNl
IDE5ZTU6YTI1NSAocmV2IDIxKSAJIyBTRUMKClRoZSBQQ0kgY29uZmlndXJhdGlvbiBzaG93cyB0
aGF0IHRoZSBBQ1Mgb2YgdGhlIHBjaWUgcm9vdCBwb3J0IGlzCm5vdCBlbmFibGVkLCB3aGlsZSBp
dCBzaG91bGQgaGF2ZS4KClRoZW4gd2hlbiBJIGluc21vZCBkZXZpY2UgZHJpdmVyIGFuZCBpbml0
IHRoZSBTVkEgZmVhdHVyZSwgSSBnb3QKClsgICAyNC4zNDI0NTBdIGhpc2lfc2VjMiAwMDAwOjAx
OjAwLjA6IGNhbm5vdCBhdHRhY2ggdG8gaW5jb21wYXRpYmxlIApkb21haW4gKDAgU1NJRCBiaXRz
ICE9IDEwKQpbICAgMjQuMzQzNzMxXSBoaXNpX3NlYzIgMDAwMDowMTowMC4wOiBGYWlsZWQgdG8g
YWRkIHRvIGlvbW11IGdyb3VwIDA6IC0yMgpbICAgMjQuMzQ1MjQzXSBoaXNpX3NlYzIgMDAwMDow
MTowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKcWVtdS1zeXN0ZW0tYWFyY2g2
NDogdmZpb19lbmFibGVfdmVjdG9ycyBmYWlsZWQgdG8gcmVnaXN0ZXIgUzEgTVNJIApiaW5kaW5n
IGZvciB2ZWN0b3IgMCgtMikKcWVtdS1zeXN0ZW0tYWFyY2g2NDogdmZpbzogRXJyb3I6IEZhaWxl
ZCB0byBzZXR1cCBNU0kgZmRzOiBJbnRlcnJ1cHRlZCAKc3lzdGVtIGNhbGwKcWVtdS1zeXN0ZW0t
YWFyY2g2NDogdmZpbzogRXJyb3I6IEZhaWxlZCB0byBlbmFibGUgTVNJCgpJIGZpZ3VyZWQgb3V0
IHRoYXQgdGhpcyBlcnJvciBvY2N1cnMgaW4gdGhlIGFybV9zbW11X2F0dGFjaF9kZXYKd2hlbiBj
aGVja2luZyBzc2lkX2JpdHMgZm9yIFNWQSBmZWF0dXJlLAp0aGUgbWFzdGVyLT5zc2lkX2JpdHMg
IT0gc21tdV9kb21haW4tPnMxX2NmZy5zMWNkbWF4IGNhdXNlZCB0aGlzIApwcm9ibGVtLiBUaGlz
IGlzIGJlY3Vhc2UgdGhlIEFDUyBvZiBwY2llLXJvb3QtcG9ydCBpcyBub3QgZW5hYmxlZCwgdGhl
IApwY2llLXJvb3QtcG9ydCBhbmQgU0VDIGRldmljZSBzaGFyZSB0aGUgc2FtZSBkb21haW4uCkFu
ZCBTRUMncyBzc2lkX2JpdHMgaXMgMTAsIHdoaWxlIHBjaWUtcm9vdC1wb3J0J3MgczFjZG1heCBp
cyB6ZXJvLCB0aGlzIApjYXVzZSB0aGUgcHJvYmxlbS4KCkFuZCBhYm91dCB3aHkgdGhlIEFDUyBp
cyBub3QgZW5hYmxlZCBpbiBrZXJuZWwsIEkgaGF2ZSBleHBsYWluZWQgYXMgdGhlIApmb2xsb3dp
bmc6CgpPbiAyMDIxLzYvNyAyMDo1OCwgWGluZ2FuZyBXYW5nIHdyb3RlOgo+IE9uIDIwMjEvNi81
IDM6MDQsIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4+IFsrY2MgSm9obiwgd2hvIHRlc3RlZCA2YmY2
YzI0NzIwZDNdCj4+Cj4+IE9uIEZyaSwgTWF5IDIxLCAyMDIxIGF0IDAzOjAzOjI0QU0gKzAwMDAs
IFdhbmcgWGluZ2FuZyB3cm90ZToKPj4+IEZyb206IFhpbmdhbmcgV2FuZyA8d2FuZ3hpbmdhbmc1
QGh1YXdlaS5jb20+Cj4+Pgo+Pj4gV2hlbiBib290aW5nIHdpdGggZGV2aWNldHJlZSwgdGhlIHBj
aV9yZXF1ZXN0X2FjcygpIGlzIGNhbGxlZCBhZnRlciB0aGUKPj4+IGVudW1lcmF0aW9uIGFuZCBp
bml0aWFsaXphdGlvbiBvZiBQQ0kgZGV2aWNlcywgdGh1cyB0aGUgQUNTIGlzIG5vdAo+Pj4gZW5h
YmxlZC4gQW5kIEFDUyBzaG91bGQgYmUgZW5hYmxlZCB3aGVuIElPTU1VIGlzIGRldGVjdGVkIGZv
ciB0aGUKPj4+IFBDSSBob3N0IGJyaWRnZSwgc28gYWRkIGNoZWNrIGZvciBJT01NVSBiZWZvcmUg
cHJvYmUgb2YgUENJIGhvc3QgYW5kIAo+Pj4gY2FsbAo+Pj4gcGNpX3JlcXVlc3RfYWNzKCkgdG8g
bWFrZSBzdXJlIEFDUyB3aWxsIGJlIGVuYWJsZWQgd2hlbiBlbnVtZXJhdGluZyBQQ0kKPj4+IGRl
dmljZXMuCj4+Cj4+IEknbSBoYXBweSB0byBhcHBseSB0aGlzLCBidXQgSSdtIGEgbGl0dGxlIHB1
enpsZWQgYWJvdXQgNmJmNmMyNDcyMGQzCj4+ICgiaW9tbXUvb2Y6IFJlcXVlc3QgQUNTIGZyb20g
dGhlIFBDSSBjb3JlIHdoZW4gY29uZmlndXJpbmcgSU9NTVUKPj4gbGlua2FnZSIpLsKgIEl0IHdh
cyB0ZXN0ZWQgYW5kIGZpeGVkIGEgcHJvYmxlbSwgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZAo+PiBo
b3cuCj4+Cj4+IDZiZjZjMjQ3MjBkMyBhZGRlZCB0aGUgY2FsbCB0byBwY2lfcmVxdWVzdF9hY3Mo
KSBpbgo+PiBvZl9pb21tdV9jb25maWd1cmUoKSBzbyBpdCBjdXJyZW50bHkgbG9va3MgbGlrZSB0
aGlzOgo+Pgo+PiDCoMKgIG9mX2lvbW11X2NvbmZpZ3VyZShkZXYsIC4uLikKPj4gwqDCoCB7Cj4+
IMKgwqDCoMKgIGlmIChkZXZfaXNfcGNpKGRldikpCj4+IMKgwqDCoMKgwqDCoCBwY2lfcmVxdWVz
dF9hY3MoKTsKPj4KPj4gcGNpX3JlcXVlc3RfYWNzKCkgc2V0cyBwY2lfYWNzX2VuYWJsZSwgd2hp
Y2ggdGVsbHMgdXMgdG8gZW5hYmxlIEFDUwo+PiB3aGVuIGVudW1lcmF0aW5nIFBDSSBkZXZpY2Vz
IGluIHRoZSBmdXR1cmUuwqAgQnV0IHdlIG9ubHkgY2FsbAo+PiBwY2lfcmVxdWVzdF9hY3MoKSBp
ZiB3ZSBhbHJlYWR5ICpoYXZlKiBhIFBDSSBkZXZpY2UuCj4+Cj4+IFNvIG1heWJlIDZiZjZjMjQ3
MjBkMyBmaXhlZCBhIHByb2JsZW0gZm9yICpzb21lKiBQQ0kgZGV2aWNlcywgYnV0IG5vdAo+PiBh
bGw/wqAgRS5nLiwgZGlkIHdlIGNhbGwgb2ZfaW9tbXVfY29uZmlndXJlKCkgZm9yIG9uZSBQQ0kg
ZGV2aWNlIGJlZm9yZQo+PiBlbnVtZXJhdGluZyB0aGUgcmVzdD8KPj4KPiBJIHRlc3QgdGhlIGtl
cm5lbCBvbiBhbiBhcm0gcGxhdGZvcm0gd2l0aCBxZW11Ogo+IAo+IHFlbXUtc3lzdGVtLWFhcmNo
NjQgXAo+ICDCoC1jcHUgaG9zdCBcCj4gIMKgLWtlcm5lbCBhcmNoL2FybTY0L2Jvb3QvSW1hZ2Ug
XAo+ICDCoC1lbmFibGUta3ZtIFwKPiAgwqAtbSA4RyBcCj4gIMKgLXNtcCAyLHNvY2tldHM9Mixj
b3Jlcz0xLHRocmVhZHM9McKgwqDCoMKgIFwKPiAgwqAtbWFjaGluZSB2aXJ0LGtlcm5lbF9pcnFj
aGlwPW9uLGdpYy12ZXJzaW9uPTMsaW9tbXU9c21tdXYzXAo+ICDCoC1pbml0cmQgcm9vdGZzLmNw
aW8uZ3ogXAo+ICDCoC1ub2dyYXBoaWMgXAo+ICDCoC1hcHBlbmQgInJkaW5pdD1pbml0IGNvbnNv
bGU9dHR5QU1BMCBlYXJseWNvbj1wbDAxMSwweDkwMDAwMDAgbm9rYXNsciIgXAo+ICDCoC1kZXZp
Y2UgcGNpZS1yb290LXBvcnQscG9ydD0weDEsY2hhc3Npcz0xLGlkPXBjaS4xLGFkZHI9MHg4IFwK
PiAgwqAtbmV0ZGV2IHVzZXIsaWQ9aG9zdG5ldDAgXAo+ICDCoC1kZXZpY2UgCj4gdmlydGlvLW5l
dC1wY2ksbmV0ZGV2PWhvc3RuZXQwLGlkPW5ldDAsbWFjPTA4OjEzOjNhOjVhOjIyOjViLGJ1cz1w
Y2kuMSxhZGRyPTB4MCAKPiBcCj4gCj4gQW5kIGZpbmQgdGhhdCB0aGUgb2ZfaW9tbXVfY29uZmln
dXJlIGlzIGNhbGxlZCBhZnRlciB0aGUgZW51bWVyYXRpb24KPiBvZiB0aGUgcGNpZS1yb290LXBv
cnQuIEFuZCB0aGlzIG1pZ2h0IG9ubHkgaW5mZWN0IHRoZSBmaXJzdCBkZXZpY2UsIHdoZW4gCj4g
ZW51bWVyYXRpbmcKPiB0aGUgcmVzdCBkZXZpY2VzLCB0aGUgcGNpX2Fjc19lbmFibGUgaGFzIGFs
cmVhZHkgYmUgZW5hYmxlZC4KPiAKPiBCdXQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHBjaV9hY3Nf
ZW5hYmxlIHdpbGwgYWx3YXlzIGJlIHNldCBiZWZvcmUgYWxsIAo+IFBDSSBkZXZpY2VzLAo+IGl0
IHdvdWxkIGJlIGJldHRlciB0byBzZXQgaXQgaW4gaW5pdGlhbGl6YXRpb24gb2YgUENJIGJyaWRn
ZXMuCj4gCj4gVGhhbmtzCj4gCj4gWGluZ2FuZwo+IAo+Pj4gRml4ZXM6IDZiZjZjMjQ3MjBkMzMg
KCJpb21tdS9vZjogUmVxdWVzdCBBQ1MgZnJvbSB0aGUgUENJIGNvcmUgd2hlbgo+Pj4gY29uZmln
dXJpbmcgSU9NTVUgbGlua2FnZSIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBYaW5nYW5nIFdhbmcgPHdh
bmd4aW5nYW5nNUBodWF3ZWkuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11L29mX2lv
bW11LmMgfCAxIC0KPj4+IMKgIGRyaXZlcnMvcGNpL29mLmPCoMKgwqDCoMKgwqDCoMKgIHwgOCAr
KysrKysrLQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvb2ZfaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvb2ZfaW9tbXUuYwo+Pj4gaW5kZXggYTlkMmRmMDAxMTQ5Li41NGExNGRhMjQy
Y2MgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L29mX2lvbW11LmMKPj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvb2ZfaW9tbXUuYwo+Pj4gQEAgLTIwNSw3ICsyMDUsNiBAQCBjb25zdCBzdHJ1
Y3QgaW9tbXVfb3BzICpvZl9pb21tdV9jb25maWd1cmUoc3RydWN0IAo+Pj4gZGV2aWNlICpkZXYs
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAubnAgPSBtYXN0ZXJfbnAsCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgfTsKPj4+IC3CoMKgwqDCoMKgwqDCoCBwY2lfcmVxdWVzdF9hY3MoKTsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBwY2lfZm9yX2VhY2hfZG1hX2FsaWFzKHRvX3Bj
aV9kZXYoZGV2KSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgb2ZfcGNpX2lvbW11X2luaXQsICZpbmZvKTsKPj4+IMKgwqDCoMKgwqAgfSBl
bHNlIHsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9vZi5jIGIvZHJpdmVycy9wY2kvb2Yu
Ywo+Pj4gaW5kZXggZGE1YjQxNGQ1ODVhLi4yMzEzYzNmODQ4YjAgMTAwNjQ0Cj4+PiAtLS0gYS9k
cml2ZXJzL3BjaS9vZi5jCj4+PiArKysgYi9kcml2ZXJzL3BjaS9vZi5jCj4+PiBAQCAtNTgxLDkg
KzU4MSwxNSBAQCBzdGF0aWMgaW50IAo+Pj4gcGNpX3BhcnNlX3JlcXVlc3Rfb2ZfcGNpX3Jhbmdl
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+PiDCoCBpbnQgZGV2bV9vZl9wY2lfYnJpZGdlX2luaXQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgCj4+PiBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZSkK
Pj4+IMKgIHsKPj4+IC3CoMKgwqAgaWYgKCFkZXYtPm9mX25vZGUpCj4+PiArwqDCoMKgIHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsKPj4+ICsKPj4+ICvCoMKgwqAgaWYg
KCFub2RlKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4gK8KgwqDCoCAvKiBE
ZXRlY3QgSU9NTVUgYW5kIG1ha2Ugc3VyZSBBQ1Mgd2lsbCBiZSBlbmFibGVkICovCj4+PiArwqDC
oMKgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgImlvbW11LW1hcCIpKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHBjaV9yZXF1ZXN0X2FjcygpOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCBicmlk
Z2UtPnN3aXp6bGVfaXJxID0gcGNpX2NvbW1vbl9zd2l6emxlOwo+Pj4gwqDCoMKgwqDCoCBicmlk
Z2UtPm1hcF9pcnEgPSBvZl9pcnFfcGFyc2VfYW5kX21hcF9wY2k7Cj4+PiAtLSAKPj4+IDIuMTku
MQo+Pj4KPj4gLgo+Pgo+IAo+IC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
