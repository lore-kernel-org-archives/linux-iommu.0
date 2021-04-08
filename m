Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD46C43460
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:20:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E4E6101B
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E4E6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1162401C1;
	Thu,  8 Apr 2021 14:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRr_jUTAnJgQ; Thu,  8 Apr 2021 14:20:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A70C440100;
	Thu,  8 Apr 2021 14:20:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 930D9C000C;
	Thu,  8 Apr 2021 14:20:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6019C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C421341875
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUQbdWvrscuk for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:20:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 474C441863
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:25 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id n8so4364713lfh.1
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6ZUCnaK/xfsxPOQ2rbUPGAW6lKLbLTcOBL5UmGQ3BRA=;
 b=bMF34VHNGxUVn9JbInOqXPCz4CByZeQfYkeeFnl0kcfNHeCKviOxyjEzDdkywsQ2GF
 zRUKduzjhd9RMG1AgnQ8IWMweHH8Twvq/U4Ni5sTEpyFyFMqbzj0HukEdCaewvqrsK8+
 ngovfgYSgo8wMOAfxUJXmMj4v6WSAOWlGTdNdS6pOTsk1ePFaC6DdUv/vqAQfp6uswuH
 2b+W55x4kie+Qm6Iime4EPsrw40AYESASX3VAQwxl+7duikXrCj4dqKg1SkNbLfy0ddg
 ga105BfsBcCcXXWgTccIWnSKeRHnTQZw0GUX8oQTSFx+8zn0i74st1XQLpIhMSyuQT8R
 mKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6ZUCnaK/xfsxPOQ2rbUPGAW6lKLbLTcOBL5UmGQ3BRA=;
 b=IORLRGOD4lROf73w8E//dRG5GyULZDoiOx0z452Oo4D1mCMRpft/HGIYaAmCJxf65G
 9yZsG7ZMKYZE0WCztHOaQ68vtc3lNLzFX3Xht/+RuwwtO8g7r/DfSLA5Ju1bkSnwpTma
 4dTfE/cXScUxz7Pt7GyCh66NaJD7DIMHvwAN9FUVda7omVrcH3lx7LhmJlNt1EhSdrlt
 SJu2ommLBAw13Ll7y3hYpfV2tqYuWB06Qa2eXqPTRWcDMK39ciDhnzO1KhdgpkJ/ozlL
 03h4BWRov8RLBI750wOKJoD73GgeBs00XLnwm77na6OmacU5JggIPb1D8sGOEQkfloYL
 l7dg==
X-Gm-Message-State: AOAM5331SHiPX2BBq/LLjcgx5JXub2VYuX5SAtJBVjy9K95wnBg/snhu
 9/Qbmx03XPQ0rqZL3ZXiFyw=
X-Google-Smtp-Source: ABdhPJxwOqizkMYPEJb5Y07w8gboGa1QxZdvdT15fW63P7IpYeBenOuiUMuuRcf7YmnyjiuytoptNg==
X-Received: by 2002:ac2:4e6d:: with SMTP id y13mr3990767lfs.509.1617891623227; 
 Thu, 08 Apr 2021 07:20:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru.
 [109.252.193.85])
 by smtp.googlemail.com with ESMTPSA id l12sm2857687lji.122.2021.04.08.07.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Apr 2021 07:20:22 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display
 clients
To: Thierry Reding <thierry.reding@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210408094241.GA31714@Asurada-Nvidia> <YG8EiUXkgPTZsfIY@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <44d67d66-d6d0-bd9a-9eb9-71d7acc07183@gmail.com>
Date: Thu, 8 Apr 2021 17:20:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG8EiUXkgPTZsfIY@orome.fritz.box>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

MDguMDQuMjAyMSAxNjoyNiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBUaHUsIEFw
ciAwOCwgMjAyMSBhdCAwMjo0Mjo0MkFNIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6Cj4+IE9u
IE1vbiwgTWFyIDI5LCAyMDIxIGF0IDAyOjMyOjU1QU0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3
cm90ZToKPj4+IEFsbCBjb25zdW1lci1ncmFkZSBBbmRyb2lkIGFuZCBDaHJvbWVib29rIGRldmlj
ZXMgc2hvdyBhIHNwbGFzaCBzY3JlZW4KPj4+IG9uIGJvb3QgYW5kIHRoZW4gZGlzcGxheSBpcyBs
ZWZ0IGVuYWJsZWQgd2hlbiBrZXJuZWwgaXMgYm9vdGVkLiBUaGlzCj4+PiBiZWhhdmlvdXIgaXMg
dW5hY2NlcHRhYmxlIGluIGEgY2FzZSBvZiBpbXBsaWNpdCBJT01NVSBkb21haW5zIHRvIHdoaWNo
Cj4+PiBkZXZpY2VzIGFyZSBhdHRhY2hlZCBkdXJpbmcga2VybmVsIGJvb3Qgc2luY2UgZGV2aWNl
cywgbGlrZSBkaXNwbGF5Cj4+PiBjb250cm9sbGVyLCBtYXkgcGVyZm9ybSBETUEgYXQgdGhhdCB0
aW1lLiBXZSBjYW4gd29yayBhcm91bmQgdGhpcyBwcm9ibGVtCj4+PiBieSBkZWZlcnJpbmcgdGhl
IGVuYWJsZSBvZiBTTU1VIHRyYW5zbGF0aW9uIGZvciBhIHNwZWNpZmljIGRldmljZXMsCj4+PiBs
aWtlIGEgZGlzcGxheSBjb250cm9sbGVyLCB1bnRpbCB0aGUgZmlyc3QgSU9NTVUgbWFwcGluZyBp
cyBjcmVhdGVkLAo+Pj4gd2hpY2ggd29ya3MgZ29vZCBlbm91Z2ggaW4gcHJhY3RpY2UgYmVjYXVz
ZSBieSB0aGF0IHRpbWUgaC93IGlzIGFscmVhZHkKPj4+IHN0b3BwZWQuCj4+Pgo+Pj4gU2lnbmVk
LW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPgo+Pgo+PiBGb3IgYm90
aCBwYXRjaGVzOgo+PiBBY2tlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwu
Y29tPgo+PiBUZXN0ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWlsLmNvbT4K
Pj4KPj4gVGhlIFdBUiBsb29rcyBnb29kIHRvIG1lLiBQZXJoYXBzIFRoaWVycnkgd291bGQgZ2l2
ZSBzb21lIGlucHV0LgoKTmljb2xpbiwgdGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGhlbHAh
Cgo+PiBBbm90aGVyIHRvcGljOgo+PiBJIHRoaW5rIHRoaXMgbWF5IGhlbHAgd29yayBhcm91bmQg
dGhlIG1jLWVycm9ycywgd2hpY2ggd2UgaGF2ZQo+PiBiZWVuIGZhY2luZyBvbiBUZWdyYTIxMCBh
bHNvIHdoZW4gd2UgZW5hYmxlIElPTU1VX0RPTUFJTl9ETUEuCj4+IChhdHRhY2hlZCBhIHRlc3Qg
cGF0Y2ggcmViYXNpbmcgb24gdGhlc2UgdHdvKQo+IAo+IFVnaC4uLiB0aGF0J3MgZXhhY3RseSB3
aGF0IEkgd2FzIGFmcmFpZCBvZi4gTm93IGV2ZXJ5Ym9keSBpcyBnb2luZyB0bwo+IHRoaW5rIHRo
YXQgd2UgY2FuIGp1c3Qgd29yayBhcm91bmQgdGhpcyBpc3N1ZSB3aXRoIGRyaXZlci1zcGVjaWZp
YyBTTU1VCj4gaGFja3MuLi4KPiAKPj4gSG93ZXZlciwgR1BVIHdvdWxkIGFsc28gcmVwb3J0IGVy
cm9ycyB1c2luZyBETUEgZG9tYWluOgo+Pgo+PiAgbm91dmVhdSA1NzAwMDAwMC5ncHU6IGFjcjog
ZmlybXdhcmUgdW5hdmFpbGFibGUKPj4gIG5vdXZlYXUgNTcwMDAwMDAuZ3B1OiBwbXU6IGZpcm13
YXJlIHVuYXZhaWxhYmxlCj4+ICBub3V2ZWF1IDU3MDAwMDAwLmdwdTogZ3I6IGZpcm13YXJlIHVu
YXZhaWxhYmxlCj4+ICB0ZWdyYS1tYyA3MDAxOTAwMC5tZW1vcnktY29udHJvbGxlcjogZ3B1c3Jk
OiByZWFkIEAweDAwMDAwMDAwZmZmYmUyMDA6IFNlY3VyaXR5IHZpb2xhdGlvbiAoVHJ1c3Rab25l
IHZpb2xhdGlvbikKPj4gIG5vdXZlYXUgNTcwMDAwMDAuZ3B1OiBEUk06IGZhaWxlZCB0byBjcmVh
dGUga2VybmVsIGNoYW5uZWwsIC0yMgo+PiAgdGVncmEtbWMgNzAwMTkwMDAubWVtb3J5LWNvbnRy
b2xsZXI6IGdwdXNyZDogcmVhZCBAMHgwMDAwMDAwMGZmZmFkMDAwOiBTZWN1cml0eSB2aW9sYXRp
b24gKFRydXN0Wm9uZSB2aW9sYXRpb24pCj4+ICBub3V2ZWF1IDU3MDAwMDAwLmdwdTogZmlmbzog
U0NIRURfRVJST1IgMjAgW10KPj4gIG5vdXZlYXUgNTcwMDAwMDAuZ3B1OiBmaWZvOiBTQ0hFRF9F
UlJPUiAyMCBbXQo+Pgo+PiBMb29raW5nIGF0IHRoZSBhZGRyZXNzLCBzZWVtcyB0aGF0IEdQVSBh
bGxvY2F0ZWQgbWVtb3J5IGluIDMyLWJpdAo+PiBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlIGJlaGlu
ZCBTTU1VLCBzbyBhIHZpb2xhdGlvbiBoYXBwZW5lZCBhZnRlcgo+PiB0dXJuaW5nIG9uIERNQSBk
b21haW4gSSBndWVzcy4uLiAKPiAKPiBUaGUgcHJvYmxlbSB3aXRoIEdQVSBpcy4uLiBleHRyYSBj
b21wbGljYXRlZC4gWW91J3JlIGdldHRpbmcgdGhlc2UKPiBmYXVsdHMgYmVjYXVzZSB5b3UncmUg
ZW5hYmxpbmcgdGhlIElPTU1VLWJhY2tlZCBETUEgQVBJLCB3aGljaCB0aGVuCj4gY2F1c2VzIHRo
ZSBOb3V2ZWF1IGRyaXZlciBhbGxvY2F0ZSBidWZmZXJzIHVzaW5nIHRoZSBETUEgQVBJIGluc3Rl
YWQgb2YKPiBleHBsaWNpdGx5IGFsbG9jYXRpbmcgcGFnZXMgYW5kIHRoZW4gbWFwcGluZyB0aGVt
IHVzaW5nIHRoZSBJT01NVSBBUEkuCj4gSG93ZXZlciwgdGhlcmUgYXJlIGFkZGl0aW9uYWwgcGF0
Y2hlcyBuZWVkZWQgdG8gdGVhY2ggTm91dmVhdSBhYm91dCBob3cKPiB0byBkZWFsIHdpdGggU01N
VSBhbmQgdGhvc2UgaGF2ZW4ndCBiZWVuIG1lcmdlZCB5ZXQuIEkndmUgZ290IHByb3RvdHlwZXMK
PiBvZiB0aGlzLCBidXQgYmVmb3JlIHRoZSB3aG9sZSBmcmFtZWJ1ZmZlciBjYXJ2ZW91dCBwYXNz
aW5nIHdvcmsgbWFrZXMKPiBwcm9ncmVzcyB0aGVyZSdzIGxpdHRsZSBzZW5zZSBpbiBtb3Zpbmcg
aW5kaXZpZHVhbCBwaWVjZXMgZm9yd2FyZC4KPiAKPiBPbmUgbW9yZSBub3QgdG8gdHJ5IGFuZCBj
dXQgY29ybmVycy4gV2Uga25vdyB3aGF0IHRoZSByaWdodCBzb2x1dGlvbiBpcywKPiBldmVuIGlm
IGl0IHRha2VzIGEgbG90IG9mIHdvcmsuIEknbSB3aWxsaW5nIHRvIGFjayB0aGlzIHBhdGNoLCBv
ciBzb21lCj4gdmVyc2lvbiBvZiBpdCwgYnV0IG9ubHkgYXMgYSB3YXkgb2Ygd29ya2luZyBhcm91
bmQgdGhpbmdzIHdlIGhhdmUgbm8KPiByZWFsaXN0aWMgY2hhbmNlIG9mIGZpeGluZyBwcm9wZXJs
eSBhbnltb3JlLiBJIHN0aWxsIHRoaW5rIGl0IHdvdWxkIGJlCj4gYmVzdCBpZiB3ZSBjb3VsZCBk
ZXJpdmUgaWRlbnRpdHkgbWFwcGluZ3MgZnJvbSBjb21tYW5kLWxpbmUgYXJndW1lbnRzIG9uCj4g
dGhlc2UgcGxhdGZvcm1zIGJlY2F1c2UgSSB0aGluayBtb3N0IG9mIHRoZW0gd2lsbCBhY3R1YWxs
eSBzZXQgdGhhdCwgYW5kCj4gdGhlbiB0aGUgc29sdXRpb24gYmVjb21lcyBhdCBsZWFzdCB1bmlm
b3JtIGF0IHRoZSBTTU1VIGxldmVsLgo+IAo+IEZvciBUZWdyYTIxMCBJJ3ZlIGFscmVhZHkgbGFp
ZCBvdXQgYSBwYXRoIHRvIGEgc29sdXRpb24gdGhhdCdzIGdvaW5nIHRvCj4gYmUgZ2VuZXJpYyBh
bmQgZXh0ZW5kIHRvIFRlZ3JhMTg2IGFuZCBsYXRlciBhcyB3ZWxsLgoKV2Ugc3RpbGwgaGF2ZSBp
c3N1ZXMgaW4gdGhlIERSTSBhbmQgb3RoZXIgZHJpdmVycyB0aGF0IGRvbid0IGFsbG93IHVzIHRv
CmZsaXAgT04gdGhlIElPTU1VX0RPTUFJTl9ETUEgc3VwcG9ydC4KCk15IHBhdGNoIGFkZHJlc3Nl
cyB0aGUgaXNzdWUgd2l0aCB0aGUgQVJNX0RNQV9VU0VfSU9NTVUgb3B0aW9uLCB3aGljaAphbGxv
Y2F0ZXMgdGhlIHVubWFuYWdlZCBkb21haW4gZm9yIERNQSBwdXJwb3NlcyBvbiBBUk0zMiwgY2F1
c2luZyB0aGUKdHJvdWJsZSBpbiB0aGUgbXVsdGlwbGF0Zm9ybSBrZXJuZWwgY29uZmlndXJhdGlv
biBzaW5jZSBpdCdzIG5vdApwb3NzaWJsZSB0byBvcHQtb3V0IGZyb20gQVJNX0RNQV9VU0VfSU9N
TVUgaW4gdGhpcyBjYXNlLiBQZXJoYXBzIHRoaXMKbmVlZHMgdG8gYmUgY2xhcmlmaWVkIGluIHRo
ZSBjb21taXQgbWVzc2FnZS4KCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjEy
LXJjNi9zb3VyY2UvYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYyNMMjA3OAoKaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTItcmM2L3NvdXJjZS9kcml2ZXJzL2lvbW11L2lvbW11
LmMjTDE5MjkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
