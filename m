Return-Path: <SRS0=99fx=3M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D8C33CAA
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 21:27:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95E121D7E
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 21:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PwBvHXWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95E121D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6922D87647;
	Thu, 23 Jan 2020 21:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93MjgCQ+Js9T; Thu, 23 Jan 2020 21:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 929A08764A;
	Thu, 23 Jan 2020 21:27:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A255C18DD;
	Thu, 23 Jan 2020 21:27:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47AF1C0174
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 21:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2D6D92035B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 21:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3+BS0SvLYqq1 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jan 2020 21:27:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 487182034A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 21:27:18 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id g12so58900ild.2
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Rlz3hvUu+9u2oNJYG4g2Rw59Iz8hixxTpHD2vCOcLXo=;
 b=PwBvHXWcPbHsFtHuoq3AUL5vFUZnWEbflYLFA0fa+kpnrYlFYyZ0WNPhmm0JH5IX20
 wOJlpK/ta+WU/QC7YYY/nAK98YO4OkEzz+mMqfx2W1MeL5DIBZGjjs2GThFWLbmP4ZXO
 BWndEWvmKE617UUJcuQWCt1gg1wDNoy4ZugQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rlz3hvUu+9u2oNJYG4g2Rw59Iz8hixxTpHD2vCOcLXo=;
 b=CX27izDek4Ys1yVIq0GkZuGN+pMCVc+hepNJIUQGVy0hdEUd5j1nBrThDhm2XFruub
 OxRRLqT+8ZBrw2Dn1lZpzJ6iPgyqgPqNEEhjGDhqAE6y0avzgj/apbGrCwHWCu9/FBBc
 JeZUQdCp5yEuurEy+8TsOktk76IFcjtgpUUoN2kSZ+z3mo0OaAK7JMVqLJyIKS4kXP3Q
 9SdVbnYYlIKkCh/nR3efb7nfN+KrDiJgPY+7Y+AzJtAfmQR9DAmoPtUoXtCsuUJQIi5j
 PrUiSoIkJakO2/RORtE4JAVYJHvHkAto4bLaRio1EyymWE6lOj7gPbz6Rvx3nI8TpCKG
 Lvzw==
X-Gm-Message-State: APjAAAUeXyGhA1vj1TbZXKny4x83wwhNr1DwWLyrB03Z6kbyFkjnMOEd
 exesvu8vfzp6qWewzy5RWuH3y71I
X-Google-Smtp-Source: APXvYqzlBlohdIzyH1fQ7g2B5f1t9VHWWDYOQC2BgsHZYkufZHxwNvX/yEX1sbKHcfdWI3OzYGhGPQ==
X-Received: by 2002:a05:6e02:cc5:: with SMTP id c5mr249989ilj.47.1579814837406; 
 Thu, 23 Jan 2020 13:27:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id i11sm701592ion.1.2020.01.23.13.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 13:27:16 -0800 (PST)
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
 <20200117100829.GE15760@8bytes.org>
 <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
 <24a46b0f-33d7-5f94-661a-80f035213892@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d7b8aa31-ded5-082e-0324-91b6277507ba@linuxfoundation.org>
Date: Thu, 23 Jan 2020 14:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24a46b0f-33d7-5f94-661a-80f035213892@linuxfoundation.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
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

T24gMS8yMS8yMCA4OjMyIEFNLCBTaHVhaCBLaGFuIHdyb3RlOgo+IE9uIDEvMjAvMjAgNzoxMCBQ
TSwgU3VyYXZlZSBTdXRoaWt1bHBhbml0IHdyb3RlOgo+PiBPbiAxLzE3LzIwMjAgNTowOCBQTSwg
Sm9lcmcgUm9lZGVsIHdyb3RlOgo+Pj4gQWRkaW5nIFN1cmF2ZWUsIHdobyB3cm90ZSB0aGUgSU9N
TVUgUGVyZiBDb3VudGVyIGNvZGUuCj4+Pgo+Pj4gT24gVHVlLCBKYW4gMTQsIDIwMjAgYXQgMDg6
MTI6MjBBTSAtMDcwMCwgU2h1YWggS2hhbiB3cm90ZToKPj4+PiBpbml0X2lvbW11X3BlcmZfY3Ry
KCkgY2xvYmJlcnMgdGhlIHJlZ2lzdGVyIHdoZW4gaXQgY2hlY2tzIHdyaXRlIGFjY2Vzcwo+Pj4+
IHRvIElPTU1VIHBlcmYgY291bnRlcnMgYW5kIGZhaWxzIHRvIHJlc3RvcmUgd2hlbiB0aGV5IGFy
ZSB3cml0YWJsZS4KPj4+Pgo+Pj4+IEFkZCBzYXZlIGFuZCByZXN0b3JlIHRvIGZpeCBpdC4KPj4+
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNodWFoIEtoYW48c2toYW5AbGludXhmb3VuZGF0aW9uLm9y
Zz4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMgfCAyMiAr
KysrKysrKysrKysrKysrLS0tLS0tCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCj4+PiBTdXJhdmVlLCBjYW4geW91IHBsZWFzZSByZXZpZXcg
dGhpcyBwYXRjaD8KPj4+Cj4+Cj4+IFRoaXMgbG9va3Mgb2suIERvZXMgdGhpcyBmaXggY2VydGFp
biBpc3N1ZXM/IE9yIGlzIHRoaXMganVzdCBmb3Igc2FuaXR5Lgo+IAo+IEkgZGlkbid0IG5vdGlj
ZSBhbnkgcHJvYmxlbXMuIENvdW50ZXJzIGFyZW4ndCB3cml0YWJsZSBvbiBteSBzeXN0ZW0uCj4g
SG93ZXZlciwgaXQgY2VydGFpbmx5IGxvb2tzIGxpa2UgYSBib2cgc2luY2UgcmVnaXN0ZXJzIGFy
ZW4ndCByZXN0b3JlZAo+IGxpa2UgaW4gb3RoZXIgcGxhY2VzIGluIHRoaXMgZmlsZSB3aGVyZSBz
dWNoIGNoZWNrcyBhcmUgZG9uZSBvbiBvdGhlcgo+IHJlZ2lzdGVycy4KPiAKPiBJIHNlZSAyIGJh
bmtzIGFuZCA0IGNvdW50ZXJzIG9uIG15IHN5c3RlbS4gSXMgaXQgc3VmZmljaWVudCB0byBjaGVj
awo+IHRoZSBmaXJzdCBiYW5rIGFuZCBmaXJzdCBjb3VudGVyPyBJbiBvdGhlciB3b3JkcywgaWYg
dGhlIGZpcnN0IG9uZQo+IGlzbid0IHdyaXRhYmxlLCBhcmUgYWxsIGNvdW50ZXJzIG5vbi13cml0
YWJsZT8KPiAKPiBTaG91bGQgd2UgcmVhZCB0aGUgY29uZmlnIGZpcnN0IGFuZCB0aGVuLCB0cnkg
dG8gc2VlIGlmIGFueSBvZiB0aGUKPiBjb3VudGVycyBhcmUgd3JpdGFibGU/IEkgaGF2ZSBhIHBh
dGNoIHRoYXQgZG9lcyB0aGF0LCBJIGNhbiBzZW5kIGl0Cj4gb3V0IGZvciByZXZpZXcuCj4gCj4+
Cj4+IFJldmlld2VkLWJ5OiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxw
YW5pdEBhbWQuY29tPgoKSm9lcmcsCgpQbGVhc2UgZG9uJ3QgcHVsbCB0aGlzIGluLiBJIGludHJv
ZHVjZWQgYSBidWcgaW4gdGhpcyBwYXRjaC4gSXQgYWx3YXlzCnJldHVybnMgYW1kX2lvbW11X3Bj
X3ByZXNlbnQgZmFsc2UgZXZlbiB3aGVuIGl0IGNhbiB3cml0ZSB0byB0aGUKY291bnRlcnMuIE15
IGJhZC4KCkkgd2lsbCBzZW5kIHYyLgoKdGhhbmtzLAotLSBTaHVhaApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
