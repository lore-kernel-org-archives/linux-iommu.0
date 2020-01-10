Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0221C33C99
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:05:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71242082E
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="RtleYrjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71242082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A94518841A;
	Fri, 10 Jan 2020 07:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PiWevK6yyIjm; Fri, 10 Jan 2020 07:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0061883B6;
	Fri, 10 Jan 2020 07:04:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6C6EC1D7D;
	Fri, 10 Jan 2020 07:04:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA7E6C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D923284EED
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rgHBsCmCPqvU for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 07:04:45 +0000 (UTC)
X-Greylist: delayed 00:07:35 by SQLgrey-1.7.6
Received: from qq.com (smtpbg415.qq.com [113.96.223.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4C42D84C09
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1578639395;
 bh=HD16XS95tQ9X/1iUd1BvTp7ZtREDOniTgxQuYGDr9OE=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=RtleYrjG9U15nQb5ve0wejsr8GPv2HqFopIenjW7q8sbksqEkvn4m643anGBnJWrL
 dpHahxktuxt8x2DHSFYwVjjKDFBnPY9A/Ljsc+IRZSk/0Zh0GEnN5Zudureio/R3BC
 GfrIv59p0KPROiikZ3M/0rU/iV6UfdV+pHWw02CA=
X-QQ-mid: esmtp4t1578639392tqilpdapx
Received: from [10.151.2.174] (unknown [45.135.186.75])
 by esmtp4.qq.com (ESMTP) with 
 id ; Fri, 10 Jan 2020 14:55:41 +0800 (CST)
X-QQ-SSF: B0000000000000M0ZI100000000000K
X-QQ-FEAT: muhurRMRtviNKg8cdjJUgMINmccIjHau1Grkh8vsRZLb037YNJgz1P66fSprP
 zA3QGV02n4UIQsl0MXIK/pnksKGPv56yEtkiTkT19fJrxO3mX8Wo5Fcp9Mge9Z8/fRPdCK6
 gS3mHPTV8SPgM2N4FIRJCU+c+A9jziV0zJp5j+D/M1sowK9p+tECYrxhTCnYZ6l032fO/ao
 I972ZSz+y2YCVSMpGwoKP/8U+ST2pQRApfhXXcqzaN53WRI5SsNRTvESDHjD8QKZfWZ5i+2
 TOduyM5mhtyEhTrQ69I2nGo2EbVsRvSced6F49MOhWHQdO4WG5TAGEHLwXYnAndPobt/sst
 84ev+68
X-QQ-GoodBg: 0
Subject: Re: [PATCH v10 2/4] uacce: add uacce driver
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Kenneth Lee <liguozhu@hisilicon.com>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <1576465697-27946-3-git-send-email-zhangfei.gao@linaro.org>
 <20200109173819.00003cbf@Huawei.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Message-ID: <8a9b535f-ce48-f991-ecd7-44fdf6ebdfe7@foxmail.com>+6673A01A3F7CB8BE
Date: Fri, 10 Jan 2020 14:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109173819.00003cbf@Huawei.com>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

CgpPbiAyMDIwLzEvMTAg5LiK5Y2IMTozOCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPiBPbiBN
b24sIDE2IERlYyAyMDE5IDExOjA4OjE1ICswODAwCj4gWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZz4gd3JvdGU6Cj4KPj4gRnJvbTogS2VubmV0aCBMZWUgPGxpZ3Vvemh1QGhp
c2lsaWNvbi5jb20+Cj4+Cj4+IFVhY2NlIChVbmlmaWVkL1VzZXItc3BhY2UtYWNjZXNzLWludGVu
ZGVkIEFjY2VsZXJhdG9yIEZyYW1ld29yaykgdGFyZ2V0cyB0bwo+PiBwcm92aWRlIFNoYXJlZCBW
aXJ0dWFsIEFkZHJlc3NpbmcgKFNWQSkgYmV0d2VlbiBhY2NlbGVyYXRvcnMgYW5kIHByb2Nlc3Nl
cy4KPj4gU28gYWNjZWxlcmF0b3IgY2FuIGFjY2VzcyBhbnkgZGF0YSBzdHJ1Y3R1cmUgb2YgdGhl
IG1haW4gY3B1Lgo+PiBUaGlzIGRpZmZlcnMgZnJvbSB0aGUgZGF0YSBzaGFyaW5nIGJldHdlZW4g
Y3B1IGFuZCBpbyBkZXZpY2UsIHdoaWNoIHNoYXJlCj4+IG9ubHkgZGF0YSBjb250ZW50IHJhdGhl
ciB0aGFuIGFkZHJlc3MuCj4+IFNpbmNlIHVuaWZpZWQgYWRkcmVzcywgaGFyZHdhcmUgYW5kIHVz
ZXIgc3BhY2Ugb2YgcHJvY2VzcyBjYW4gc2hhcmUgdGhlCj4+IHNhbWUgdmlydHVhbCBhZGRyZXNz
IGluIHRoZSBjb21tdW5pY2F0aW9uLgo+Pgo+PiBVYWNjZSBjcmVhdGUgYSBjaHJkZXYgZm9yIGV2
ZXJ5IHJlZ2lzdHJhdGlvbiwgdGhlIHF1ZXVlIGlzIGFsbG9jYXRlZCB0bwo+PiB0aGUgcHJvY2Vz
cyB3aGVuIHRoZSBjaHJkZXYgaXMgb3BlbmVkLiBUaGVuIHRoZSBwcm9jZXNzIGNhbiBhY2Nlc3Mg
dGhlCj4+IGhhcmR3YXJlIHJlc291cmNlIGJ5IGludGVyYWN0IHdpdGggdGhlIHF1ZXVlIGZpbGUu
IEJ5IG1tYXAgdGhlIHF1ZXVlCj4+IGZpbGUgc3BhY2UgdG8gdXNlciBzcGFjZSwgdGhlIHByb2Nl
c3MgY2FuIGRpcmVjdGx5IHB1dCByZXF1ZXN0cyB0byB0aGUKPj4gaGFyZHdhcmUgd2l0aG91dCBz
eXNjYWxsIHRvIHRoZSBrZXJuZWwgc3BhY2UuCj4+Cj4+IFRoZSBJT01NVSBjb3JlIG9ubHkgdHJh
Y2tzIG1tPC0+ZGV2aWNlIGJvbmRzIGF0IHRoZSBtb21lbnQsIGJlY2F1c2UgaXQKPj4gb25seSBu
ZWVkcyB0byBoYW5kbGUgSU9UTEIgaW52YWxpZGF0aW9uIGFuZCBQQVNJRCB0YWJsZSBlbnRyaWVz
LiBIb3dldmVyCj4+IHVhY2NlIG5lZWRzIGEgZmluZXIgZ3JhbnVsYXJpdHkgc2luY2UgbXVsdGlw
bGUgcXVldWVzIGZyb20gdGhlIHNhbWUKPj4gZGV2aWNlIGNhbiBiZSBib3VuZCB0byBhbiBtbS4g
V2hlbiB0aGUgbW0gZXhpdHMsIGFsbCBib3VuZCBxdWV1ZXMgbXVzdAo+PiBiZSBzdG9wcGVkIHNv
IHRoYXQgdGhlIElPTU1VIGNhbiBzYWZlbHkgY2xlYXIgdGhlIFBBU0lEIHRhYmxlIGVudHJ5IGFu
ZAo+PiByZWFsbG9jYXRlIHRoZSBQQVNJRC4KPj4KPj4gQW4gaW50ZXJtZWRpYXRlIHN0cnVjdCB1
YWNjZV9tbSBsaW5rcyB1YWNjZSBkZXZpY2VzIGFuZCBxdWV1ZXMuCj4+IE5vdGUgdGhhdCBhbiBt
bSBtYXkgYmUgYm91bmQgdG8gbXVsdGlwbGUgZGV2aWNlcyBidXQgYW4gdWFjY2VfbW0KPj4gc3Ry
dWN0dXJlIG9ubHkgZXZlciBiZWxvbmdzIHRvIGEgc2luZ2xlIGRldmljZSwgYmVjYXVzZSB3ZSBk
b24ndCBuZWVkCj4+IGFueXRoaW5nIG1vcmUgY29tcGxleCAoaWYgbXVsdGlwbGUgZGV2aWNlcyBh
cmUgYm91bmQgdG8gb25lIG1tLCB0aGVuCj4+IHdlJ2xsIGNyZWF0ZSBvbmUgdWFjY2VfbW0gZm9y
IGVhY2ggYm9uZCkuCj4+Cj4+ICAgICAgICAgIHVhY2NlX2RldmljZSAtLSstLSB1YWNjZV9tbSAt
LSstLSB1YWNjZV9xdWV1ZQo+PiAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAnLS0gdWFjY2VfcXVldWUKPj4gICAgICAgICAgICAgICAgICAgICAgICAgfAo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAnLS0gdWFjY2VfbW0gLS0rLS0gdWFjY2VfcXVldWUKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tIHVhY2NlX3F1ZXVlCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICctLSB1YWNjZV9xdWV1ZQo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBLZW5uZXRoIExlZSA8bGlndW96aHVAaGlzaWxpY29uLmNvbT4KPj4gU2ln
bmVkLW9mZi1ieTogWmFpYm8gWHUgPHh1emFpYm9AaHVhd2VpLmNvbT4KPj4gU2lnbmVkLW9mZi1i
eTogWmhvdSBXYW5nIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTog
SmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4+IFNpZ25l
ZC1vZmYtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+Cj4gSGksCj4K
PiBUd28gc21hbGwgdGhpbmdzIEknZCBtaXNzZWQgcHJldmlvdXNseS4gIEZpeCB0aG9zZSBhbmQg
Zm9yCj4gd2hhdCBpdCdzIHdvcnRoCj4KPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8
Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPgpUaGFua3MgSm9uYXRoYW4KPgo+PiAtLS0KPj4g
ICBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci11YWNjZSB8ICAzNyArKwo+
PiAgIGRyaXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsK
Pj4gICBkcml2ZXJzL21pc2MvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
Cj4+ICAgZHJpdmVycy9taXNjL3VhY2NlL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgMTMg
Kwo+PiAgIGRyaXZlcnMvbWlzYy91YWNjZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAy
ICsKPj4gICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYyAgICAgICAgICAgICAgICAgICB8IDYy
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICBpbmNsdWRlL2xpbnV4L3VhY2NlLmgg
ICAgICAgICAgICAgICAgICAgICAgICB8IDE2MSArKysrKysrCj4+ICAgaW5jbHVkZS91YXBpL21p
c2MvdWFjY2UvdWFjY2UuaCAgICAgICAgICAgICAgfCAgMzggKysKPj4gICA4IGZpbGVzIGNoYW5n
ZWQsIDg4MSBpbnNlcnRpb25zKCspCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLXVhY2NlCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbWlzYy91YWNjZS9LY29uZmlnCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbWlzYy91YWNjZS9NYWtlZmlsZQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21p
c2MvdWFjY2UvdWFjY2UuYwo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3Vh
Y2NlLmgKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL21pc2MvdWFjY2UvdWFj
Y2UuaAo+Pgo+IC4uLgo+PiArCj4+ICtXaGF0OiAgICAgICAgICAgL3N5cy9jbGFzcy91YWNjZS88
ZGV2X25hbWU+L2F2YWlsYWJsZV9pbnN0YW5jZXMKPj4gK0RhdGU6ICAgICAgICAgICBEZWMgMjAx
OQo+PiArS2VybmVsVmVyc2lvbjogIDUuNgo+PiArQ29udGFjdDogICAgICAgIGxpbnV4LWFjY2Vs
ZXJhdG9yc0BsaXN0cy5vemxhYnMub3JnCj4+ICtEZXNjcmlwdGlvbjogICAgQXZhaWxhYmxlIGlu
c3RhbmNlcyBsZWZ0IG9mIHRoZSBkZXZpY2UKPj4gKyAgICAgICAgICAgICAgICBSZXR1cm4gLUVO
T0RFViBpZiB1YWNjZV9vcHMgZ2V0X2F2YWlsYWJsZV9pbnN0YW5jZXMgaXMgbm90IHByb3ZpZGVk
Cj4+ICsKPiBTZWUgYmVsb3cuICBJdCBkb2Vzbid0ICJyZXR1cm4iIGl0IHByaW50cyBpdCBjdXJy
ZW50bHkuCldpbGwgdXBkYXRlIHRvCid1bmtub3duJyBpZiB1YWNjZV9vcHMgZ2V0X2F2YWlsYWJs
ZV9pbnN0YW5jZXMgaXMgbm90IHByb3ZpZGVkCj4KPiAuLi4KPgo+PiArc3RhdGljIGludCB1YWNj
ZV9mb3BzX21tYXAoc3RydWN0IGZpbGUgKmZpbGVwLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSkKPj4gK3sKPj4gKwlzdHJ1Y3QgdWFjY2VfcXVldWUgKnEgPSBmaWxlcC0+cHJpdmF0ZV9kYXRh
Owo+PiArCXN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlID0gcS0+dWFjY2U7Cj4+ICsJc3RydWN0
IHVhY2NlX3FmaWxlX3JlZ2lvbiAqcWZyOwo+PiArCWVudW0gdWFjY2VfcWZydCB0eXBlID0gVUFD
Q0VfTUFYX1JFR0lPTjsKPj4gKwlpbnQgcmV0ID0gMDsKPj4gKwo+PiArCWlmICh2bWEtPnZtX3Bn
b2ZmIDwgVUFDQ0VfTUFYX1JFR0lPTikKPj4gKwkJdHlwZSA9IHZtYS0+dm1fcGdvZmY7Cj4+ICsJ
ZWxzZQo+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4gKwo+PiArCXFmciA9IGt6YWxsb2Moc2l6ZW9m
KCpxZnIpLCBHRlBfS0VSTkVMKTsKPj4gKwlpZiAoIXFmcikKPj4gKwkJcmV0dXJuIC1FTk9NRU07
Cj4+ICsKPj4gKwl2bWEtPnZtX2ZsYWdzIHw9IFZNX0RPTlRDT1BZIHwgVk1fRE9OVEVYUEFORCB8
IFZNX1dJUEVPTkZPUks7Cj4+ICsJdm1hLT52bV9vcHMgPSAmdWFjY2Vfdm1fb3BzOwo+PiArCXZt
YS0+dm1fcHJpdmF0ZV9kYXRhID0gcTsKPj4gKwlxZnItPnR5cGUgPSB0eXBlOwo+PiArCj4+ICsJ
bXV0ZXhfbG9jaygmdWFjY2VfbXV0ZXgpOwo+PiArCj4+ICsJaWYgKHEtPnN0YXRlICE9IFVBQ0NF
X1FfSU5JVCAmJiBxLT5zdGF0ZSAhPSBVQUNDRV9RX1NUQVJURUQpIHsKPj4gKwkJcmV0ID0gLUVJ
TlZBTDsKPj4gKwkJZ290byBvdXRfd2l0aF9sb2NrOwo+PiArCX0KPj4gKwo+PiArCWlmIChxLT5x
ZnJzW3R5cGVdKSB7Cj4+ICsJCXJldCA9IC1FRVhJU1Q7Cj4+ICsJCWdvdG8gb3V0X3dpdGhfbG9j
azsKPj4gKwl9Cj4+ICsKPj4gKwlzd2l0Y2ggKHR5cGUpIHsKPj4gKwljYXNlIFVBQ0NFX1FGUlRf
TU1JTzoKPj4gKwkJaWYgKCF1YWNjZS0+b3BzLT5tbWFwKSB7Cj4+ICsJCQlyZXQgPSAtRUlOVkFM
Owo+PiArCQkJZ290byBvdXRfd2l0aF9sb2NrOwo+PiArCQl9Cj4+ICsKPj4gKwkJcmV0ID0gdWFj
Y2UtPm9wcy0+bW1hcChxLCB2bWEsIHFmcik7Cj4+ICsJCWlmIChyZXQpCj4+ICsJCQlnb3RvIG91
dF93aXRoX2xvY2s7Cj4+ICsKPj4gKwkJYnJlYWs7Cj4+ICsKPj4gKwljYXNlIFVBQ0NFX1FGUlRf
RFVTOgo+PiArCQlpZiAodWFjY2UtPmZsYWdzICYgVUFDQ0VfREVWX1NWQSkgewo+PiArCQkJaWYg
KCF1YWNjZS0+b3BzLT5tbWFwKSB7Cj4+ICsJCQkJcmV0ID0gLUVJTlZBTDsKPj4gKwkJCQlnb3Rv
IG91dF93aXRoX2xvY2s7Cj4+ICsJCQl9Cj4+ICsKPj4gKwkJCXJldCA9IHVhY2NlLT5vcHMtPm1t
YXAocSwgdm1hLCBxZnIpOwo+PiArCQkJaWYgKHJldCkKPj4gKwkJCQlnb3RvIG91dF93aXRoX2xv
Y2s7Cj4+ICsJCX0KPiBTbGlnaHRseSBvZGQgY29ybmVyIGNhc2UsIGJ1dCB3aGF0IHN0b3BzIHVz
IGdldHRpbmcgaGVyZSB3aXRoCj4gdGhlIFVBQ0NFX0RFVl9TVkEgZmxhZyBub3Qgc2V0PyAgSWYg
dGhhdCBoYXBwZW5lZCBJJ2QgZXhwZWN0IHRvCj4gcmV0dXJuIGFuIGVycm9yIGJ1dCBsb29rcyBs
aWtlIHdlIHJldHVybiAwLgpUaGUgY2hlY2sgd2l0aCBmbGFnIFVBQ0NFX0RFVl9TVkEgY2FuIGJl
IHJlbW92ZWQgaGVyZSwgbm9uLXN2YSBhbHNvIGhhcyAKZHVzIHJlZ2lvbi4KV2UgaGF2ZSByZW1v
dmVkIHRoZSBjaGVjayB3aGVuIHdlIGFkZCBub24tc3ZhIHN1cHBvcnQuCj4gLi4uCj4KPj4gK3N0
YXRpYyBzc2l6ZV90IGF2YWlsYWJsZV9pbnN0YW5jZXNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYs
Cj4+ICsJCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAo+PiArCQkJCQljaGFyICpi
dWYpCj4+ICt7Cj4+ICsJc3RydWN0IHVhY2NlX2RldmljZSAqdWFjY2UgPSB0b191YWNjZV9kZXZp
Y2UoZGV2KTsKPj4gKwlpbnQgdmFsID0gLUVOT0RFVjsKPj4gKwo+PiArCWlmICh1YWNjZS0+b3Bz
LT5nZXRfYXZhaWxhYmxlX2luc3RhbmNlcykKPj4gKwkJdmFsID0gdWFjY2UtPm9wcy0+Z2V0X2F2
YWlsYWJsZV9pbnN0YW5jZXModWFjY2UpOwo+PiArCj4+ICsJcmV0dXJuIHNwcmludGYoYnVmLCAi
JWRcbiIsIHZhbCk7Cj4gSXQncyB1bnVzdWFsIHRvIHBhc3MgYW4gZXJyb3IgdmFsdWUgYmFjayBh
cyBhIHN0cmluZy4KPiBJJ2QgZXhwZWN0IHNvbWUgbG9naWMgbGlrZS4uCj4KPiAJaWYgKHZhbCA8
IDApCj4gCQlyZXR1cm4gdmFsOwo+Cj4gCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCB2YWwp
Owo+Cj4gTm90ZSB0aGlzIGlzIHRoZSBkb2N1bWVudGVkIGJlaGF2aW9yICJyZXR1cm5zIC1FTk9E
RVYiLgpJZiByZXR1cm4gLUVOT0RFViwKY2F0IC9zeXMvY2xhc3MvdWFjY2UvaGlzaV96aXAtMC9h
dmFpbGFibGVfaW5zdGFuY2VzCmNhdDogL3N5cy9jbGFzcy91YWNjZS9oaXNpX3ppcC0wL2F2YWls
YWJsZV9pbnN0YW5jZXM6IE5vIHN1Y2ggZGV2aWNlCgpJIHRoaW5rIHByaW50ICJ1bmtub3duIiBt
YXliZSBiZXR0ZXIsIGxpa2UgY3B1ZnJlcS5jCgogwqDCoMKgwqDCoMKgwqAgaWYgKHVhY2NlLT5v
cHMtPmdldF9hdmFpbGFibGVfaW5zdGFuY2VzKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLAp1YWNjZS0+b3BzLT5nZXRfYXZhaWxhYmxl
X2luc3RhbmNlcyh1YWNjZSkpOwoKIMKgwqDCoMKgwqDCoMKgIHJldHVybiBzcHJpbnRmKGJ1Ziwg
InVua25vd25cbiIpOwoKVGhhbmtzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
