Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48DCC33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 14:12:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AC12084D
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 14:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPVqOGeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AC12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 351D885F2F;
	Wed, 15 Jan 2020 14:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKsvBx-VinZa; Wed, 15 Jan 2020 14:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 15F5A8392B;
	Wed, 15 Jan 2020 14:12:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB508C1D82;
	Wed, 15 Jan 2020 14:12:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 399B4C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2838385A4E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6T9xbiIZ0K1 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 14:12:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 21BE8859F1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 14:12:17 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id b137so8273355pga.6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PZek3JGPM1vXB2nTvmi63D8QiO8eK/60hwb1CSbq930=;
 b=mPVqOGeYhibIz9TGnzp4p1VCd9JkC2Rm2C0Xqqm9UHzT+6ttTYLT0iFoV+yYK98/+d
 EGpDbXADOPsqKFki2p0OzWLFtudEI/SDRpUJwrwTGqcPuTHUn9NggrqGXiz2/LK/gmbN
 EmIVATJAxSbIgSHWe0mK/iacaZE6xoF2MNjPLLN984R9BTh0bAgkw3TinfrVOnIU2Chx
 jbCjJx0hPXVPVcczP3EH26HxrdG1DZkIRx+faOrIVzZz1UKdkgFpPpSXgr12FsKWUA2b
 6tiSi+6HwAlpHpco7T4gsLLLtFWFPBqDz6JUdruy8UvrcMZiVNcZg1PyLe6b448TKWR2
 Q/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PZek3JGPM1vXB2nTvmi63D8QiO8eK/60hwb1CSbq930=;
 b=UCfpdMzAYk9eZQWiUIgcTxzzGAKygXJMSN0cHX7EYHkxElxTjxv6rZ2q29gGjbZ7bJ
 vhfYj0yKKr962alNt2EamHtpeKI6OWFzR/ygC8TKaDuWf6LjA4ZHSMz0SWWUYThvJc6z
 7tN/6CbtoEZtAttxNM29vV7cg6rZ2GV/kQTZrBH2XW6Z4u4i+UwWZFuuXe8b7kyl29cd
 o4oIfNJWtS9vwWhPqTr3rR8qEm36k4J6OrlZ684R3PUJjesj5/zqKsAloSF0/3uNkHj7
 8MwUYAfEBvE53aVle7cnUXFc+R3whNYEfi7wS0BBJBs2P4I0bUuPRktgcTvUcBArmnoK
 IpCg==
X-Gm-Message-State: APjAAAUm7nIs17uogEHzaxhI6nPRMvfg1N34m1G45X6P8dp5IFxlHOJx
 NfbwuLnSO3BgFZyDnB+C68xCkg==
X-Google-Smtp-Source: APXvYqz+1fhv2oIu7Q5NUTfjg997nHzUmXRYm0zUtyv5oSL0Ta9WdziTT+AWV3WUL5Qiv6W9AEjtdQ==
X-Received: by 2002:a63:201d:: with SMTP id g29mr34399921pgg.427.1579097536592; 
 Wed, 15 Jan 2020 06:12:16 -0800 (PST)
Received: from [10.60.0.74] ([104.238.63.136])
 by smtp.gmail.com with ESMTPSA id z30sm20954447pff.131.2020.01.15.06.12.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 06:12:15 -0800 (PST)
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
 <20200114145934.GA1960403@kroah.com>
 <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
 <20200115120212.GA3270387@kroah.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <750bb4b6-20a9-96b0-5801-5b8bff8cc3b5@linaro.org>
Date: Wed, 15 Jan 2020 22:11:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200115120212.GA3270387@kroah.com>
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

CgpPbiAyMDIwLzEvMTUg5LiL5Y2IODowMiwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+IE9u
IFdlZCwgSmFuIDE1LCAyMDIwIGF0IDA3OjE4OjM0UE0gKzA4MDAsIHpoYW5nZmVpIHdyb3RlOgo+
PiBIaSwgR3JlZwo+Pgo+PiBPbiAyMDIwLzEvMTQg5LiL5Y2IMTA6NTksIEdyZWcgS3JvYWgtSGFy
dG1hbiB3cm90ZToKPj4+IE9uIE1vbiwgSmFuIDEzLCAyMDIwIGF0IDExOjM0OjU1QU0gKzA4MDAs
IHpoYW5nZmVpIHdyb3RlOgo+Pj4+IEhpLCBHcmVnCj4+Pj4KPj4+PiBUaGFua3MgZm9yIHRoZSBy
ZXZpZXcuCj4+Pj4KPj4+PiBPbiAyMDIwLzEvMTIg5LiK5Y2IMzo0MCwgR3JlZyBLcm9haC1IYXJ0
bWFuIHdyb3RlOgo+Pj4+PiBPbiBTYXQsIEphbiAxMSwgMjAyMCBhdCAxMDo0ODozN0FNICswODAw
LCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4+Pj4+PiArc3RhdGljIGludCB1YWNjZV9mb3BzX29wZW4o
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+Pj4+Pj4gK3sKPj4+Pj4+
ICsJc3RydWN0IHVhY2NlX21tICp1YWNjZV9tbSA9IE5VTEw7Cj4+Pj4+PiArCXN0cnVjdCB1YWNj
ZV9kZXZpY2UgKnVhY2NlOwo+Pj4+Pj4gKwlzdHJ1Y3QgdWFjY2VfcXVldWUgKnE7Cj4+Pj4+PiAr
CWludCByZXQgPSAwOwo+Pj4+Pj4gKwo+Pj4+Pj4gKwl1YWNjZSA9IHhhX2xvYWQoJnVhY2NlX3hh
LCBpbWlub3IoaW5vZGUpKTsKPj4+Pj4+ICsJaWYgKCF1YWNjZSkKPj4+Pj4+ICsJCXJldHVybiAt
RU5PREVWOwo+Pj4+Pj4gKwo+Pj4+Pj4gKwlpZiAoIXRyeV9tb2R1bGVfZ2V0KHVhY2NlLT5wYXJl
bnQtPmRyaXZlci0+b3duZXIpKQo+Pj4+Pj4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4+Pj4+IFdoeSBh
cmUgeW91IHRyeWluZyB0byBncmFiIHRoZSBtb2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBwYXJlbnQg
ZGV2aWNlPwo+Pj4+PiBXaHkgaXMgdGhhdCBuZWVkZWQgYW5kIHdoYXQgaXMgdGhhdCBnb2luZyB0
byBoZWxwIHdpdGggaGVyZT8KPj4+Pj4KPj4+Pj4gVGhpcyBzaG91bGRuJ3QgYmUgbmVlZGVkIGFz
IHRoZSBtb2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBvd25lciBvZiB0aGUKPj4+Pj4gZmlsZW9wcyBm
b3IgdGhpcyBtb2R1bGUgaXMgaW5jcmVtZW50ZWQsIGFuZCB0aGUgInBhcmVudCIgbW9kdWxlIGRl
cGVuZHMKPj4+Pj4gb24gdGhpcyBtb2R1bGUsIHNvIGhvdyBjb3VsZCBpdCBiZSB1bmxvYWRlZCB3
aXRob3V0IHRoaXMgY29kZSBiZWluZwo+Pj4+PiB1bmxvYWRlZD8KPj4+Pj4KPj4+Pj4gWWVzLCBp
ZiB5b3UgYnVpbGQgdGhpcyBjb2RlIGludG8gdGhlIGtlcm5lbCBhbmQgdGhlICJwYXJlbnQiIGRy
aXZlciBpcyBhCj4+Pj4+IG1vZHVsZSwgdGhlbiB5b3Ugd2lsbCBub3QgaGF2ZSBhIHJlZmVyZW5j
ZSwgYnV0IHdoZW4geW91IHJlbW92ZSB0aGF0Cj4+Pj4+IHBhcmVudCBkcml2ZXIgdGhlIGRldmlj
ZSB3aWxsIGJlIHJlbW92ZWQgYXMgaXQgaGFzIHRvIGJlIHVucmVnaXN0ZXJlZAo+Pj4+PiBiZWZv
cmUgdGhhdCBwYXJlbnQgZHJpdmVyIGNhbiBiZSByZW1vdmVkIGZyb20gdGhlIHN5c3RlbSwgcmln
aHQ/Cj4+Pj4+Cj4+Pj4+IE9yIHdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/Cj4+Pj4gVGhlIHJlZmNv
dW50IGhlcmUgaXMgcHJldmVudGluZyBybW1vZCAicGFyZW50IiBtb2R1bGUgYWZ0ZXIgZmQgaXMg
b3BlbmVkLAo+Pj4+IHNpbmNlIHVzZXIgZHJpdmVyIGhhcyBtbWFwIGtlcm5lbCBtZW1vcnkgdG8g
dXNlciBzcGFjZSwgbGlrZSBtbWlvLCB3aGljaCBtYXkKPj4+PiBzdGlsbCBpbi11c2UuCj4+Pj4K
Pj4+PiBXaXRoIHRoZSByZWZjb3VudCBwcm90ZWN0aW9uLCBybW1vZCAicGFyZW50IiBtb2R1bGUg
d2lsbCBmYWlsIHVudGlsCj4+Pj4gYXBwbGljYXRpb24gZnJlZSB0aGUgZmQuCj4+Pj4gbG9nIGxp
a2U6IHJtbW9kOiBFUlJPUjogTW9kdWxlIGhpc2lfemlwIGlzIGluIHVzZQo+Pj4gQnV0IGlmIHRo
ZSAicGFyZW50IiBtb2R1bGUgaXMgdG8gYmUgdW5sb2FkZWQsIGl0IGhhcyB0byB1bnJlZ2lzdGVy
IHRoZQo+Pj4gImNoaWxkIiBkZXZpY2UgYW5kIHRoYXQgd2lsbCBjYWxsIHRoZSBkZXN0cnVjdG9y
IGluIGhlcmUgYW5kIHRoZW4geW91Cj4+PiB3aWxsIHRlYXIgZXZlcnl0aGluZyBkb3duIGFuZCBh
bGwgc2hvdWxkIGJlIGdvb2QuCj4+Pgo+Pj4gVGhlcmUncyBubyBuZWVkIHRvICJmb3JiaWQiIGEg
bW9kdWxlIGZyb20gYmVpbmcgdW5sb2FkZWQsIGV2ZW4gaWYgaXQgaXMKPj4+IGJlaW5nIHVzZWQu
ICBMb29rIGF0IGFsbCBuZXR3b3JraW5nIGRyaXZlcnMsIHRoZXkgd29yayB0aGF0IHdheSwgcmln
aHQ/Cj4+IFRoYW5rcyBHcmVnIGZvciB0aGUga2luZCBzdWdnZXN0aW9uLgo+Pgo+PiBJIHN0aWxs
IGhhdmUgb25lIHVuY2VydGFpbnR5Lgo+PiBEb2VzIHVhY2NlIGhhcyB0byBibG9jayBwcm9jZXNz
IGNvbnRpbnVlIGFjY2Vzc2luZyB0aGUgbW1hcHBlZCBhcmVhIHdoZW4KPj4gcmVtb3ZlICJwYXJl
bnQiIG1vZHVsZT8KPj4gVWFjY2UgY2FuIGJsb2NrIGRldmljZSBhY2Nlc3MgdGhlIHBoeXNpY2Fs
IG1lbW9yeSB3aGVuIHBhcmVudCBtb2R1bGUgY2FsbAo+PiB1YWNjZV9yZW1vdmUuCj4+IEJ1dCBh
cHBsaWNhdGlvbiBpcyBzdGlsbCBydW5uaW5nLCBhbmQgc3VwcG9zZSBpdCBpcyBub3QgdGhlIGtl
cm5lbCBkcml2ZXIncwo+PiByZXNwb25zaWJpbGl0eSB0byBjYWxsIHVubWFwLgo+Pgo+PiBJIGFt
IGxvb2tpbmcgZm9yIHNvbWUgZXhhbXBsZXMgaW4ga2VybmVsLAo+PiBsb29rcyB2ZmlvIGRvZXMg
bm90IGJsb2NrIHByb2Nlc3MgY29udGludWUgYWNjZXNzaW5nIHdoZW4KPj4gdmZpb191bnJlZ2lz
dGVyX2lvbW11X2RyaXZlciBlaXRoZXIuCj4+Cj4+IEluIG15IHRlc3QsIGFwcGxpY2F0aW9uIHdp
bGwga2VlcCB3YWl0aW5nIGFmdGVyIHJtbW9kIHBhcmVudCwgdW50aWwgY3RybCtjLAo+PiB3aGVu
IHVubWFwIGlzIGNhbGxlZC4KPj4gRHVyaW5nIHRoZSBwcm9jZXNzLCBrZXJuZWwgZG9lcyBub3Qg
cmVwb3J0IGFueSBlcnJvci4KPj4KPj4gRG8geW91IGhhdmUgYW55IGFkdmljZT8KPiBJcyB0aGVy
ZSBubyB3YXkgZm9yIHRoZSBrZXJuZWwgdG8gaW52YWxpZGF0ZSB0aGUgbWVtb3J5IGFuZCB0ZWxs
IHRoZQo+IHByb2Nlc3MgdG8gc3RvcD8gIHR0eSBkcml2ZXJzIGRvIHRoaXMgZm9yIHdoZW4gdGhl
eSBhcmUgcmVtb3ZlZCBmcm9tIHRoZQo+IHN5c3RlbS4KPgo+IEFueXdheSwgdGhpcyBpcyBhbGwg
dmVyeSByYXJlLCBubyBrZXJuZWwgbW9kdWxlIGlzIGV2ZXIgdW5sb2FkZWQgb24gYQo+IHJlYWwg
c3lzdGVtLCB0aGF0IGlzIG9ubHkgZm9yIHdoZW4gZGV2ZWxvcGVycyBhcmUgd29ya2luZyBvbiB0
aGVtLCBzbwo+IGl0J3MgcHJvYmFibHkgbm90IHRoYXQgYmlnIG9mIGFuIGlzc3VlLCByaWdodD8K
PgpUaGFua3MgR3JlZywgd2lsbCB1cGRhdGUgYSBuZXcgdmVyc2lvbiB3aGlsZSBpZ25vcmluZyB0
aGlzIGZpcnN0LgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
