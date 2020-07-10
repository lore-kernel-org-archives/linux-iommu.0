Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD506C433E1
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 11:40:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5653B20748
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 11:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5653B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10820888AB;
	Fri, 10 Jul 2020 11:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gl4zUs93bPkx; Fri, 10 Jul 2020 11:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60FB2887AB;
	Fri, 10 Jul 2020 11:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD87C0890;
	Fri, 10 Jul 2020 11:40:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 578A5C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 09:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 398DE894CF
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 09:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZDJ4TXckDMGC for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 09:35:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 12D5F894D3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 09:35:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07484; MF=alex.shi@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0U2H8hSR_1594373729; 
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com
 fp:SMTPD_---0U2H8hSR_1594373729) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Jul 2020 17:35:30 +0800
Subject: Re: a question of split_huge_page
To: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Matthew Wilcox <willy@infradead.org>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
From: Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
Date: Fri, 10 Jul 2020 17:34:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
X-Mailman-Approved-At: Fri, 10 Jul 2020 11:40:06 +0000
Cc: Hugh Dickins <hughd@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
 Johannes Weiner <hannes@cmpxchg.org>
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

5ZyoIDIwMjAvNy8xMCDkuIvljYgxOjI4LCBNaWthIFBlbnR0aWzDpCDlhpnpgZM6Cj4gCj4gCj4g
T24gMTAuNy4yMDIwIDcuNTEsIEFsZXggU2hpIHdyb3RlOgo+Pgo+PiDlnKggMjAyMC83LzEwIOS4
iuWNiDEyOjA3LCBLaXJpbGwgQS4gU2h1dGVtb3Yg5YaZ6YGTOgo+Pj4gT24gVGh1LCBKdWwgMDks
IDIwMjAgYXQgMDQ6NTA6MDJQTSArMDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4+Pj4gT24g
VGh1LCBKdWwgMDksIDIwMjAgYXQgMTE6MTE6MTFQTSArMDgwMCwgQWxleCBTaGkgd3JvdGU6Cj4+
Pj4+IEhpIEtpcmlsbCAmIE1hdHRoZXcsCj4+Pj4+Cj4+Pj4+IEluIHRoZSBmdW5jIGNhbGwgY2hh
aW4sIGZyb20gc3BsaXRfaHVnZV9wYWdlKCkgdG8gbHJ1X2FkZF9wYWdlX3RhaWwoKSwKPj4+Pj4g
U2VlbXMgdGFpbCBwYWdlcyBhcmUgYWRkZWQgdG8gbHJ1IGxpc3QgYXQgbGluZSA5NjMsIGJ1dCBp
biB0aGlzIHNjZW5hcmlvCj4+Pj4+IHRoZSBoZWFkIHBhZ2UgaGFzIG5vIGxydSBiaXQgYW5kIGlz
bid0IHNldCB0aGUgYml0IGxhdGVyLiBXaHkgd2UgZG8gdGhpcz8KPj4+Pj4gb3IgZG8gSSBtaXNz
IHN0aD8KPj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHdlIGdldCB0byBzcGxpdF9odWdlX3Bh
Z2UoKSB3aXRoIGEgcGFnZSB0aGF0J3MKPj4+PiBub3Qgb24gYW4gTFJVIGxpc3QuICBCb3RoIGFu
b255bW91cyBhbmQgcGFnZSBjYWNoZSBwYWdlcyBzaG91bGQgYmUgb24KPj4+PiBhbiBMUlUgbGlz
dC4gIFdoYXQgYW0gSSBtaXNzaW5nPz4gCj4+Cj4+IFRoYW5rcyBhIGxvdCBmb3IgcXVpY2sgcmVw
bHkhCj4+IFdoYXQgSSBhbSBjb25mdXNpbmcgaXMgdGhlIGNhbGwgY2hhaW46IF9faW9tbXVfZG1h
X2FsbG9jX3BhZ2VzKCkKPj4gdG8gc3BsaXRfaHVnZV9wYWdlKCksIGluIHRoZSBmdW5jLCBzcGxp
dGVkIHBhZ2UsCj4+IAlwYWdlID0gYWxsb2NfcGFnZXNfbm9kZShuaWQsIGFsbG9jX2ZsYWdzLCBv
cmRlcik7Cj4+IEFuZCBpZiB0aGUgcGFnZXMgd2VyZSBhZGRlZCBpbnRvIGxydSwgdGhleSBtYXli
ZSByZWNsYWltZWQgYW5kIGxvc3QsCj4+IHRoYXQgd291bGQgYmUgYSBwYW5pYyBidWcuIEJ1dCBp
biBmYWN0LCB0aGlzIG5ldmVyIGhhcHBlbmVkIGZvciBsb25nIHRpbWUuCj4+IEFsc28gSSBwdXQg
YSBCVUcoKSBhdCB0aGUgbGluZSwgaXQncyBuZXZyZSB0cmlnZ2VyZWQgaW4gbHRwLCBhbmQgcnVu
X3ZtdGVzdHMKPiAKPiAKPiBJbsKgIF9faW9tbXVfZG1hX2FsbG9jX3BhZ2VzLCBhZnRlciBzcGxp
dF9odWdlX3BhZ2UoKSzCoCB3aG8gaXMgdGFraW5nIGEKPiByZWZlcmVuY2Ugb24gdGFpbCBwYWdl
cz8gU2VlbXMgdGFpbCBwYWdlcyBhcmUgZnJlZWQgYW5kIHRoZSBmdW5jdGlvbgo+IGVycm9ybm91
c2x5IHJldHVybnMgdGhlbSBpbiBwYWdlc1tdIGFycmF5IGZvciB1c2U/Cj4gCgpDQyBKb2VyZyBh
bmQgaW9tbXUgbGlzdCwKClRoYXQncyBhIGdvb2QgcXVlc3Rpb24uIHNlZW1zIHRoZSBzcGxpdF9o
dWdlX3BhZ2Ugd2FzIG5ldmVyIHRyaWdnZXJlZCBoZXJlLApzaW5jZSB0aGUgZnVuYyB3b3VsZCBj
aGVjayB0aGUgUGFnZUxvY2sgZmlyc3QuIGFuZCBoYXZlIHBhZ2UtPm1hcHBpbmcgYW5kIFBhZ2VB
bm9uCmNoZWNrLCBhbnkgb2YgdGhlbSBjb3VsZG4ndCBiZSBtYXRjaGVkIGZvciB0aGUgYWxsb2Nl
ZCBwYWdlLgoKSGkgSm9lcmcsCndvdWxkIHlvdSBsaWtlIGxvb2sgaW50byB0aGlzPyBkbyB3ZSBz
dGlsbCBuZWVkIHRoZSBzcGxpdF9odWdlX3BhZ2UoKSBoZXJlPwoKVGhhbmtzCkFsZXgKCmludCBz
cGxpdF9odWdlX3BhZ2VfdG9fbGlzdChzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IGxpc3RfaGVh
ZCAqbGlzdCkKewogICAgICAgIHN0cnVjdCBwYWdlICpoZWFkID0gY29tcG91bmRfaGVhZChwYWdl
KTsKICAgICAgICBzdHJ1Y3QgZGVmZXJyZWRfc3BsaXQgKmRzX3F1ZXVlID0gZ2V0X2RlZmVycmVk
X3NwbGl0X3F1ZXVlKGhlYWQpOwogICAgICAgIHN0cnVjdCBhbm9uX3ZtYSAqYW5vbl92bWEgPSBO
VUxMOwogICAgICAgIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gTlVMTDsKICAgICAg
ICBpbnQgY291bnQsIG1hcGNvdW50LCBleHRyYV9waW5zLCByZXQ7CiAgICAgICAgcGdvZmZfdCBl
bmQ7CgogICAgICAgIFZNX0JVR19PTl9QQUdFKGlzX2h1Z2VfemVyb19wYWdlKGhlYWQpLCBoZWFk
KTsKICAgICAgICBWTV9CVUdfT05fUEFHRSghUGFnZUxvY2tlZChoZWFkKSwgaGVhZCk7CTw9PQo+
IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
