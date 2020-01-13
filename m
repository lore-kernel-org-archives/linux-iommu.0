Return-Path: <SRS0=W82T=3C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD96C32771
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 03:35:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994B5206D6
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 03:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+FPJXn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994B5206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 420EF86FF8;
	Mon, 13 Jan 2020 03:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Se9AA2KTT8+G; Mon, 13 Jan 2020 03:35:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9985F86F21;
	Mon, 13 Jan 2020 03:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D997C1D85;
	Mon, 13 Jan 2020 03:35:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3055C077D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 03:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A5E1B86FF8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 03:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FBKeglIThi8m for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jan 2020 03:35:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6CC1986F21
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 03:35:21 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id 4so4173453pfz.9
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jan 2020 19:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xFqcxE7gzA9H12FKOdbMb//B/oYmfZK/RzAcHl+CnTs=;
 b=k+FPJXn+qDrc8Rv9GkbgTYmLV+c06ODhfg3UhsWFDxASC2rDKBsa5hPArKfSnHOiHf
 SiqlCOxOzq9cRabPerK7MdccjmcZQQqUHr2ENSp13QJ2VYuqA+dCtQri/vOUCtYve+4N
 AdsmmYGs2PctIv6buQ3S2tTWv/krI5/wFhyhKQd/xrBZSxjlsdI+/ZM9XoGe9y/wdc45
 WdtqH8HGpuq7/0MpnZxHh1QWEUyQ9CK5sCVbvZvGRdDEy1YF8XxySFRhTKPlbKh4FMzg
 qTb2Q7X//1CY+5EHEEXdNPyHCSpbf6OEWnK25vSgDkemlto12Le5Ftx4cxIgFJpTfKJo
 +qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xFqcxE7gzA9H12FKOdbMb//B/oYmfZK/RzAcHl+CnTs=;
 b=BtOZp4Bnh7UM1OsVGzRe7ESXr7fKpBU+gmDAbZUfnlnoLoKr5bw2QDbI621c0MHtpL
 dFHsPFL9FjfKqNUFzXsB+hoRUpAlFIVDi/Jt1FrWAJstSkrD9/nz+3bIEA6zJbBNJbaS
 9gkttesVldwNjRKYvP1y0hnICaJGb03rFyFmf+EkHvlgClLp+ZDwL44GdaYXm99h1qDB
 24J2cI04dkHxm9TRjl5AgFq/4N6DFnP/W4Cxyi7xz4YLlbEFdesrUQOk/wB6+xkkmDlC
 s7Msk12GXe4wQo2gmzEyZDb3AvBTc27rAlJoJkrlRuERiKPPTogaUtYiC84EUdP8YRWK
 Diow==
X-Gm-Message-State: APjAAAVxnYzQmOS5tlWXFpSsrOG56vebTW7ubONGppRaLIA8puydu+aC
 /bkupWMyP56eTTKOuQ/pfaEiCg==
X-Google-Smtp-Source: APXvYqyqrcJ6o1XIvrpDQ5dkfiQ1M/tSGBDgRllqQQCfDUJXDziAz94M3vBA0n9IcAGZZQJU78RI2A==
X-Received: by 2002:aa7:982d:: with SMTP id q13mr17816648pfl.152.1578886521046; 
 Sun, 12 Jan 2020 19:35:21 -0800 (PST)
Received: from ?IPv6:240e:362:498:8200:f030:f64d:8b7a:5e5a?
 ([240e:362:498:8200:f030:f64d:8b7a:5e5a])
 by smtp.gmail.com with ESMTPSA id i23sm11662197pfo.11.2020.01.12.19.35.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 12 Jan 2020 19:35:20 -0800 (PST)
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
Date: Mon, 13 Jan 2020 11:34:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200111194006.GD435222@kroah.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
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

SGksIEdyZWcKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCk9uIDIwMjAvMS8xMiDkuIrljYgzOjQw
LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gT24gU2F0LCBKYW4gMTEsIDIwMjAgYXQgMTA6
NDg6MzdBTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+PiArc3RhdGljIGludCB1YWNjZV9m
b3BzX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+PiArewo+
PiArCXN0cnVjdCB1YWNjZV9tbSAqdWFjY2VfbW0gPSBOVUxMOwo+PiArCXN0cnVjdCB1YWNjZV9k
ZXZpY2UgKnVhY2NlOwo+PiArCXN0cnVjdCB1YWNjZV9xdWV1ZSAqcTsKPj4gKwlpbnQgcmV0ID0g
MDsKPj4gKwo+PiArCXVhY2NlID0geGFfbG9hZCgmdWFjY2VfeGEsIGltaW5vcihpbm9kZSkpOwo+
PiArCWlmICghdWFjY2UpCj4+ICsJCXJldHVybiAtRU5PREVWOwo+PiArCj4+ICsJaWYgKCF0cnlf
bW9kdWxlX2dldCh1YWNjZS0+cGFyZW50LT5kcml2ZXItPm93bmVyKSkKPj4gKwkJcmV0dXJuIC1F
Tk9ERVY7Cj4gV2h5IGFyZSB5b3UgdHJ5aW5nIHRvIGdyYWIgdGhlIG1vZHVsZSByZWZlcmVuY2Ug
b2YgdGhlIHBhcmVudCBkZXZpY2U/Cj4gV2h5IGlzIHRoYXQgbmVlZGVkIGFuZCB3aGF0IGlzIHRo
YXQgZ29pbmcgdG8gaGVscCB3aXRoIGhlcmU/Cj4KPiBUaGlzIHNob3VsZG4ndCBiZSBuZWVkZWQg
YXMgdGhlIG1vZHVsZSByZWZlcmVuY2Ugb2YgdGhlIG93bmVyIG9mIHRoZQo+IGZpbGVvcHMgZm9y
IHRoaXMgbW9kdWxlIGlzIGluY3JlbWVudGVkLCBhbmQgdGhlICJwYXJlbnQiIG1vZHVsZSBkZXBl
bmRzCj4gb24gdGhpcyBtb2R1bGUsIHNvIGhvdyBjb3VsZCBpdCBiZSB1bmxvYWRlZCB3aXRob3V0
IHRoaXMgY29kZSBiZWluZwo+IHVubG9hZGVkPwo+Cj4gWWVzLCBpZiB5b3UgYnVpbGQgdGhpcyBj
b2RlIGludG8gdGhlIGtlcm5lbCBhbmQgdGhlICJwYXJlbnQiIGRyaXZlciBpcyBhCj4gbW9kdWxl
LCB0aGVuIHlvdSB3aWxsIG5vdCBoYXZlIGEgcmVmZXJlbmNlLCBidXQgd2hlbiB5b3UgcmVtb3Zl
IHRoYXQKPiBwYXJlbnQgZHJpdmVyIHRoZSBkZXZpY2Ugd2lsbCBiZSByZW1vdmVkIGFzIGl0IGhh
cyB0byBiZSB1bnJlZ2lzdGVyZWQKPiBiZWZvcmUgdGhhdCBwYXJlbnQgZHJpdmVyIGNhbiBiZSBy
ZW1vdmVkIGZyb20gdGhlIHN5c3RlbSwgcmlnaHQ/Cj4KPiBPciB3aGF0IGFtIEkgbWlzc2luZyBo
ZXJlPwpUaGUgcmVmY291bnQgaGVyZSBpcyBwcmV2ZW50aW5nIHJtbW9kICJwYXJlbnQiIG1vZHVs
ZSBhZnRlciBmZCBpcyBvcGVuZWQsCnNpbmNlIHVzZXIgZHJpdmVyIGhhcyBtbWFwIGtlcm5lbCBt
ZW1vcnkgdG8gdXNlciBzcGFjZSwgbGlrZSBtbWlvLCB3aGljaCAKbWF5IHN0aWxsIGluLXVzZS4K
CldpdGggdGhlIHJlZmNvdW50IHByb3RlY3Rpb24sIHJtbW9kICJwYXJlbnQiIG1vZHVsZSB3aWxs
IGZhaWwgdW50aWwgCmFwcGxpY2F0aW9uIGZyZWUgdGhlIGZkLgpsb2cgbGlrZTogcm1tb2Q6IEVS
Uk9SOiBNb2R1bGUgaGlzaV96aXAgaXMgaW4gdXNlCj4KPj4gK3N0YXRpYyB2b2lkIHVhY2NlX3Jl
bGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQo+PiArewo+PiArCXN0cnVjdCB1YWNjZV9kZXZpY2Ug
KnVhY2NlID0gdG9fdWFjY2VfZGV2aWNlKGRldik7Cj4+ICsKPj4gKwlrZnJlZSh1YWNjZSk7Cj4+
ICsJdWFjY2UgPSBOVUxMOwo+IFRoYXQgbGluZSBkaWRuJ3QgZG8gYW55dGhpbmcgOikKWWVzLCB0
aGlzIGlzIGEgbWlzdGFrZS4KSXQgaXMgdXAgdG8gY2FsbGVyIHRvIHNldCB0byBOVUxMIHRvIHBy
ZXZlbnQgcmVsZWFzZSBtdWx0aSB0aW1lcy4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
