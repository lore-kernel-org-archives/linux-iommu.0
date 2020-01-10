Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE8C33CA2
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 11:30:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141EA2072E
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t4sfiSEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141EA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CB03188402;
	Fri, 10 Jan 2020 11:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjNna-K0JOfM; Fri, 10 Jan 2020 11:30:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D3117883FA;
	Fri, 10 Jan 2020 11:30:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C54CCC1D7D;
	Fri, 10 Jan 2020 11:30:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F09A1C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 11:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E9D7D86F87
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 11:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8+3P5QgzkL7e for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 11:29:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from qq.com (smtpbg417.qq.com [183.3.226.222])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C82E4866F6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1578655773;
 bh=aoR2WXh8/O75PZWRAqoPM1EMz1ky3WYTTZ/yYpxtMOQ=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=t4sfiSEgAHmrinn63D7bO21dBC8i1S6F5TcKQ1rCFd8M+48gdsTQMoyZsQ3FkGiSN
 73ax+x86M2WEI5yFxULO07FvsSgZy5fEu7sqya5m+iiTSjnXSH6Ubd+mDaErmA7MCB
 hyeDzbEDeolfw03HzKVtcsSXRkXiEuhesZzAoPdk=
X-QQ-mid: esmtp3t1578655769tgy2kjbvw
Received: from [192.168.1.13] (unknown [36.57.147.241])
 by esmtp4.qq.com (ESMTP) with 
 id ; Fri, 10 Jan 2020 19:29:27 +0800 (CST)
X-QQ-SSF: B0000000000000M0ZI100000000000K
X-QQ-FEAT: tvtHwrVUWtlZyMizP6pUKTwQovgsuWdMS8yORgPHBT+TkiUfvyXx8vvh2poJ6
 KtQCE0uwSJWjWVmURJc1BT1BOM0J9EnSZ6E5UvGkpLrA3S4sbChBOGN5vOd01XY7yZirkIJ
 3KJq37Aow9ozhJTxLFhnA0jSxVxQsVpxF6eN/Bq/FMKS5/+RRW0d0KXj+rBiDK/1fAhg0Jt
 K12Z7tAMqp4lhJeMv/B6xHfJkKxwoy1SJ0bTQP2o7qyUoad0D0xq4FMSeHJG+QA5o95QDHq
 wO/ZipBQrW+PTPW8wUvnPnbNPCysl8GG4pyk4hGaZErXdMXPpedMzRaSz05CGlywA+aaLyw
 QytjW89
X-QQ-GoodBg: 0
Subject: Re: [PATCH v10 0/4] Add uacce module for Accelerator
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 zhangfei <zhangfei.gao@linaro.org>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <20200109174952.000051e1@Huawei.com>
 <9b87edca-dd4e-3fe2-5acd-11f7381593ed@linaro.org>
 <20200110100818.0000151a@Huawei.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Message-ID: <ed522c0d-4276-28b2-c554-257a95390942@foxmail.com>+11751F6C14AA28E9
Date: Fri, 10 Jan 2020 19:29:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110100818.0000151a@Huawei.com>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
Cc: jean-philippe <jean-philippe@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
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

CgpPbiAyMDIwLzEvMTAg5LiL5Y2INjowOCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPiBPbiBG
cmksIDEwIEphbiAyMDIwIDE1OjAzOjI1ICswODAwCj4gemhhbmdmZWkgPHpoYW5nZmVpLmdhb0Bs
aW5hcm8ub3JnPiB3cm90ZToKPgo+PiBPbiAyMDIwLzEvMTAg5LiK5Y2IMTo0OSwgSm9uYXRoYW4g
Q2FtZXJvbiB3cm90ZToKPj4+IE9uIE1vbiwgMTYgRGVjIDIwMTkgMTE6MDg6MTMgKzA4MDAKPj4+
IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+IHdyb3RlOgo+Pj4gICAKPj4+
PiBVYWNjZSAoVW5pZmllZC9Vc2VyLXNwYWNlLWFjY2Vzcy1pbnRlbmRlZCBBY2NlbGVyYXRvciBG
cmFtZXdvcmspIHRhcmdldHMgdG8KPj4+PiBwcm92aWRlIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3Np
bmcgKFNWQSkgYmV0d2VlbiBhY2NlbGVyYXRvcnMgYW5kIHByb2Nlc3Nlcy4KPj4+PiBTbyBhY2Nl
bGVyYXRvciBjYW4gYWNjZXNzIGFueSBkYXRhIHN0cnVjdHVyZSBvZiB0aGUgbWFpbiBjcHUuCj4+
Pj4gVGhpcyBkaWZmZXJzIGZyb20gdGhlIGRhdGEgc2hhcmluZyBiZXR3ZWVuIGNwdSBhbmQgaW8g
ZGV2aWNlLCB3aGljaCBzaGFyZQo+Pj4+IGRhdGEgY29udGVudCByYXRoZXIgdGhhbiBhZGRyZXNz
Lgo+Pj4+IEJlY2F1c2Ugb2YgdW5pZmllZCBhZGRyZXNzLCBoYXJkd2FyZSBhbmQgdXNlciBzcGFj
ZSBvZiBwcm9jZXNzIGNhbiBzaGFyZQo+Pj4+IHRoZSBzYW1lIHZpcnR1YWwgYWRkcmVzcyBpbiB0
aGUgY29tbXVuaWNhdGlvbi4KPj4+Pgo+Pj4+IFVhY2NlIGlzIGludGVuZGVkIHRvIGJlIHVzZWQg
d2l0aCBKZWFuIFBoaWxpcHBlIEJydWNrZXIncyBTVkEKPj4+PiBwYXRjaHNldFsxXSwgd2hpY2gg
ZW5hYmxlcyBJTyBzaWRlIHBhZ2UgZmF1bHQgYW5kIFBBU0lEIHN1cHBvcnQuCj4+Pj4gV2UgaGF2
ZSBrZWVwIHZlcmlmeWluZyB3aXRoIEplYW4ncyBzdmEgcGF0Y2hzZXQgWzJdCj4+Pj4gV2UgYWxz
byBrZWVwIHZlcmlmeWluZyB3aXRoIEVyaWMncyBTTU1VdjMgTmVzdGVkIFN0YWdlIHBhdGNoZXMg
WzNdCj4+PiBIaSBaaGFuZ2ZlaSBHYW8sCj4+Pgo+Pj4gSnVzdCB0byBjaGVjayBteSB1bmRlcnN0
YW5kaW5nLi4uCj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXQgaXMgbm90IGRlcGVuZGVudCBvbiBlaXRo
ZXIgMiBvciAzPwo+Pj4KPj4+IFRvIHVzZSBpdCBvbiBvdXIgaGFyZHdhcmUsIHdlIG5lZWQgMiwg
YnV0IHRoZSBpbnRlcmZhY2VzIHVzZWQgYXJlIGFscmVhZHkKPj4+IHVwc3RyZWFtLCBzbyB0aGlz
IGNvdWxkIG1vdmUgZm9yd2FyZHMgaW4gcGFyYWxsZWwuCj4+Pgo+Pj4gICAKPj4gWWVzLAo+PiBw
YXRjaCAxLCAyIGlzIGZvciB1YWNjZS4KPj4gcGF0Y2ggMywgNCBpcyBhbiBleGFtcGxlIHVzaW5n
IHVhY2NlLCB3aGljaCBoYXBwZW4gdG8gYmUgY3J5cHRvLgo+IFNvcnJ5LCBJIHdhc24ndCBjbGVh
ciBlbm91Z2guCj4KPiBRdWVzdGlvbiBpcyB3aGV0aGVyIHdlIG5lZWQgSmVhbidzIHN2YSBwYXRj
aCBzZXQgWzJdIHRvIG1lcmdlIHRoaXM/ClNpbmNlIHRoZSBzdmEgYXBpIGFyZSBhbHJlYWR5IG1l
cmdlZCwgdGhlIHBhdGNoc2V0IGNhbiBiZSBidWlsZCB3aXRob3V0IApwcm9ibGVtLCBzbyBubyBk
ZXBlbmRlbmN5LgoKVGhvdWdoIGluIG9yZGVyIHRvIG1ha2Ugc3ZhIHdvcmssIHdlIG5lZWQgSmVh
bidzIHN2YSBwYXRjaCB0b2dldGhlciwgCndoaWNoIGlzIGluIHJldmlld2luZwpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDE5MTIxOTE2MzAzMy4yNjA4MTc3LTEtamVhbi1w
aGlsaXBwZUBsaW5hcm8ub3JnLwoKQW5kIHdpdGggdGhpcyBwYXRjaHNldCwgd2UgY2FuIGFsc28g
ZWFzaWVyIHZlcmlmeSBzdmEuCgpTbyBJIHRoaW5rIHRoZXkgY2FuIGdvIGluZGVwZW5kZW50bHku
CgpUaGFua3MKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
