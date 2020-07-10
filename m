Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6D1C433E6
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05B620725
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLMJe+V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05B620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B90C18970B;
	Fri, 10 Jul 2020 17:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emGODKcpPP41; Fri, 10 Jul 2020 17:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BD8989A82;
	Fri, 10 Jul 2020 17:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E51C2C0890;
	Fri, 10 Jul 2020 17:29:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1723EC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 17:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0301C20524
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 17:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Ew68qUqNlBk for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 17:29:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by silver.osuosl.org (Postfix) with ESMTPS id CF7212050A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 17:29:47 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id w6so6932991ejq.6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dhYqHDXmVB851MO24k0xJG8pSyIioIjacD8y0LsCCxY=;
 b=dLMJe+V9OFFRHOT42hrZZ1af8nQv7C6RUMqJRqQTx5tKDOZ8GvnlINDSvRebp84+iU
 m7IQVo5KdPxMFgtHzn8b+huKWXTMhwT9YtcAEAjYMQA2ytWBrN/gts3Imut/Hysm0f86
 FMd6HXbnlMjLcq1Pu1reAqpngO8kLHyS10S+JLt06MgNOdupDkW2kNYqn2dDOkMsZS+L
 1xrS2mpxHCeQFfcdO5nV9spuB/E4DmmcsY/a88MrBRyF2I3DZp8wL4+L3eTUP0ZTPTQL
 iL1nofMyqqy/pfiAZW6rku3LfcG4tO0SCqavMgENEzHFSwiClEjGVHkrJd1tF783H9dh
 ALZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dhYqHDXmVB851MO24k0xJG8pSyIioIjacD8y0LsCCxY=;
 b=lD5iov64etzZLoDU+/eko6VthE6wolSnVbr2rhpEq67tK8gKgR7Yg24i8XlM8ea09I
 9X7/KdguQXl57itgqWXOZejqXS8RfxzfEh7k38eSUbOwBdbnCJLxSo7gAglwMhdhWmDk
 OvIb1N+1urkdk2wrZITDNkiGQW7RGz2RAp2bFHZ57vxJLlLklUxQO3rBp/M7PcBylXyv
 kDxmEJV4UZ87TLYvdxpyx59eYR7OEkzgFdg+6Hy7w8tVijgLCFLlQQV0hsoNT8d7gy/s
 cN3cHaJnX7dSz0ZtRPWGlmkGgXxNijtDiqlMQMNnNdhegYSgF1Yn1feVnl9JhBDCi7p6
 zvIg==
X-Gm-Message-State: AOAM530U60ryQrHwdny5Xw0bUbgjSqhp/kMFx1/w0Gu4L5ZZCokglk7U
 cc2rZoSfJCi8oJT8macXF2tyWv4KB57fVR1nWl0=
X-Google-Smtp-Source: ABdhPJyTnwMaj0fBe3xhHrqoUd5Au+DzxnbxORXfAamjJPmba1exXOGavNjGe0okwDqGFdHfQ8vRWv6iZ1kk1s3wtmM=
X-Received: by 2002:a17:906:c209:: with SMTP id
 d9mr38452213ejz.449.1594402186385; 
 Fri, 10 Jul 2020 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
 <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
In-Reply-To: <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 10 Jul 2020 10:29:27 -0700
Message-ID: <CAHbLzko9DtqTpamdGAZRtRm9fq8E-FQR_79SHso7SeheUjzEzA@mail.gmail.com>
Subject: Re: a question of split_huge_page
To: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
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

T24gRnJpLCBKdWwgMTAsIDIwMjAgYXQgMjozNSBBTSBBbGV4IFNoaSA8YWxleC5zaGlAbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4g5ZyoIDIwMjAvNy8xMCDkuIvljYgxOjI4LCBNaWthIFBl
bnR0aWzDpCDlhpnpgZM6Cj4gPgo+ID4KPiA+IE9uIDEwLjcuMjAyMCA3LjUxLCBBbGV4IFNoaSB3
cm90ZToKPiA+Pgo+ID4+IOWcqCAyMDIwLzcvMTAg5LiK5Y2IMTI6MDcsIEtpcmlsbCBBLiBTaHV0
ZW1vdiDlhpnpgZM6Cj4gPj4+IE9uIFRodSwgSnVsIDA5LCAyMDIwIGF0IDA0OjUwOjAyUE0gKzAx
MDAsIE1hdHRoZXcgV2lsY294IHdyb3RlOgo+ID4+Pj4gT24gVGh1LCBKdWwgMDksIDIwMjAgYXQg
MTE6MTE6MTFQTSArMDgwMCwgQWxleCBTaGkgd3JvdGU6Cj4gPj4+Pj4gSGkgS2lyaWxsICYgTWF0
dGhldywKPiA+Pj4+Pgo+ID4+Pj4+IEluIHRoZSBmdW5jIGNhbGwgY2hhaW4sIGZyb20gc3BsaXRf
aHVnZV9wYWdlKCkgdG8gbHJ1X2FkZF9wYWdlX3RhaWwoKSwKPiA+Pj4+PiBTZWVtcyB0YWlsIHBh
Z2VzIGFyZSBhZGRlZCB0byBscnUgbGlzdCBhdCBsaW5lIDk2MywgYnV0IGluIHRoaXMgc2NlbmFy
aW8KPiA+Pj4+PiB0aGUgaGVhZCBwYWdlIGhhcyBubyBscnUgYml0IGFuZCBpc24ndCBzZXQgdGhl
IGJpdCBsYXRlci4gV2h5IHdlIGRvIHRoaXM/Cj4gPj4+Pj4gb3IgZG8gSSBtaXNzIHN0aD8KPiA+
Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgd2UgZ2V0IHRvIHNwbGl0X2h1Z2VfcGFnZSgpIHdp
dGggYSBwYWdlIHRoYXQncwo+ID4+Pj4gbm90IG9uIGFuIExSVSBsaXN0LiAgQm90aCBhbm9ueW1v
dXMgYW5kIHBhZ2UgY2FjaGUgcGFnZXMgc2hvdWxkIGJlIG9uCj4gPj4+PiBhbiBMUlUgbGlzdC4g
IFdoYXQgYW0gSSBtaXNzaW5nPz4KPiA+Pgo+ID4+IFRoYW5rcyBhIGxvdCBmb3IgcXVpY2sgcmVw
bHkhCj4gPj4gV2hhdCBJIGFtIGNvbmZ1c2luZyBpcyB0aGUgY2FsbCBjaGFpbjogX19pb21tdV9k
bWFfYWxsb2NfcGFnZXMoKQo+ID4+IHRvIHNwbGl0X2h1Z2VfcGFnZSgpLCBpbiB0aGUgZnVuYywg
c3BsaXRlZCBwYWdlLAo+ID4+ICAgICAgcGFnZSA9IGFsbG9jX3BhZ2VzX25vZGUobmlkLCBhbGxv
Y19mbGFncywgb3JkZXIpOwo+ID4+IEFuZCBpZiB0aGUgcGFnZXMgd2VyZSBhZGRlZCBpbnRvIGxy
dSwgdGhleSBtYXliZSByZWNsYWltZWQgYW5kIGxvc3QsCj4gPj4gdGhhdCB3b3VsZCBiZSBhIHBh
bmljIGJ1Zy4gQnV0IGluIGZhY3QsIHRoaXMgbmV2ZXIgaGFwcGVuZWQgZm9yIGxvbmcgdGltZS4K
PiA+PiBBbHNvIEkgcHV0IGEgQlVHKCkgYXQgdGhlIGxpbmUsIGl0J3MgbmV2cmUgdHJpZ2dlcmVk
IGluIGx0cCwgYW5kIHJ1bl92bXRlc3RzCj4gPgo+ID4KPiA+IEluICBfX2lvbW11X2RtYV9hbGxv
Y19wYWdlcywgYWZ0ZXIgc3BsaXRfaHVnZV9wYWdlKCksICB3aG8gaXMgdGFraW5nIGEKPiA+IHJl
ZmVyZW5jZSBvbiB0YWlsIHBhZ2VzPyBTZWVtcyB0YWlsIHBhZ2VzIGFyZSBmcmVlZCBhbmQgdGhl
IGZ1bmN0aW9uCj4gPiBlcnJvcm5vdXNseSByZXR1cm5zIHRoZW0gaW4gcGFnZXNbXSBhcnJheSBm
b3IgdXNlPwo+ID4KPgo+IENDIEpvZXJnIGFuZCBpb21tdSBsaXN0LAo+Cj4gVGhhdCdzIGEgZ29v
ZCBxdWVzdGlvbi4gc2VlbXMgdGhlIHNwbGl0X2h1Z2VfcGFnZSB3YXMgbmV2ZXIgdHJpZ2dlcmVk
IGhlcmUsCj4gc2luY2UgdGhlIGZ1bmMgd291bGQgY2hlY2sgdGhlIFBhZ2VMb2NrIGZpcnN0LiBh
bmQgaGF2ZSBwYWdlLT5tYXBwaW5nIGFuZCBQYWdlQW5vbgo+IGNoZWNrLCBhbnkgb2YgdGhlbSBj
b3VsZG4ndCBiZSBtYXRjaGVkIGZvciB0aGUgYWxsb2NlZCBwYWdlLgo+Cj4gSGkgSm9lcmcsCj4g
d291bGQgeW91IGxpa2UgbG9vayBpbnRvIHRoaXM/IGRvIHdlIHN0aWxsIG5lZWQgdGhlIHNwbGl0
X2h1Z2VfcGFnZSgpIGhlcmU/CgpJIHRoaW5rIHRoaXMgaXMgdGhlIHNhbWUgcHJvYmxlbSB3aGlj
aCBoYXMgYmVlbiBkaXNjdXNzZWQgYSBjb3VwbGUgb2YKd2Vla3MgYWdvLiBQbGVhc2UgcmVmZXIg
dG86Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIwMjAwNjE5MDAxOTM4LkdBMTM1
OTY1QGNhcmJvbi5kaGNwLnRoZWZhY2Vib29rLmNvbS8KCkkgdGhpbmsgdGhlIGNvbmNsdXNpb24g
aXMgc3BsaXRfaHVnZV9wYWdlKCkgY2FuJ3QgYmUgdXNlZCBpbiB0aGlzIHBhdGgKYXQgYWxsLiBC
dXQgd2UgZGlkbid0IHJlYWNoIGEgZml4IHlldC4KCj4KPiBUaGFua3MKPiBBbGV4Cj4KPiBpbnQg
c3BsaXRfaHVnZV9wYWdlX3RvX2xpc3Qoc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCBsaXN0X2hl
YWQgKmxpc3QpCj4gewo+ICAgICAgICAgc3RydWN0IHBhZ2UgKmhlYWQgPSBjb21wb3VuZF9oZWFk
KHBhZ2UpOwo+ICAgICAgICAgc3RydWN0IGRlZmVycmVkX3NwbGl0ICpkc19xdWV1ZSA9IGdldF9k
ZWZlcnJlZF9zcGxpdF9xdWV1ZShoZWFkKTsKPiAgICAgICAgIHN0cnVjdCBhbm9uX3ZtYSAqYW5v
bl92bWEgPSBOVUxMOwo+ICAgICAgICAgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBO
VUxMOwo+ICAgICAgICAgaW50IGNvdW50LCBtYXBjb3VudCwgZXh0cmFfcGlucywgcmV0Owo+ICAg
ICAgICAgcGdvZmZfdCBlbmQ7Cj4KPiAgICAgICAgIFZNX0JVR19PTl9QQUdFKGlzX2h1Z2VfemVy
b19wYWdlKGhlYWQpLCBoZWFkKTsKPiAgICAgICAgIFZNX0JVR19PTl9QQUdFKCFQYWdlTG9ja2Vk
KGhlYWQpLCBoZWFkKTsgICAgICAgIDw9PQo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
