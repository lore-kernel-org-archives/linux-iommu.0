Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5CC433B4
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 07:39:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8B1613BD
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 07:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8B1613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F76040271;
	Mon, 26 Apr 2021 07:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OVDCwWJTTLlA; Mon, 26 Apr 2021 07:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 63D42401E3;
	Mon, 26 Apr 2021 07:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA1BC000E;
	Mon, 26 Apr 2021 07:39:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0CEFC000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E314402B5
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LjkwnxlnsXE4 for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 07:39:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BEEB4029F
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:39:28 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id 4so26926073lfp.11
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4x5tRF7HTHU6jnLJwm1CHDLupwBUyqj6xcR0SHL/i2Y=;
 b=U94b76338mQDuCwPjjXcxuRR+LS8qwlxBg3fcGw3WhyM0J3ty/C+nCE14HVnlPZ7Ed
 7Su+9lVB4crNKUx/FToCIru2kibDav2YCUDYuNoX17HytlvfTkY+DFkszZjqXdkLYmOj
 FDbBgwN8DyFOtIMCasOLwhio+JoeHRum9qKsD/BFI6yxPGr0gl1TZ0Qgf2WdzwWnsLTl
 FfR3FQk6YgpbFU9YgUBxljcEWj90q6fmgev1U5cdZp3x66s7PXK+EstK9PcRT0eaTlYW
 slgm5gsyJ41RbU2X5yY/zt1f8mQP3J4W5aytiGOxBsXLhkplJ2dkOCoxF43ocpJa3C6H
 F4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4x5tRF7HTHU6jnLJwm1CHDLupwBUyqj6xcR0SHL/i2Y=;
 b=AR94yMD2aStvX6IEDKR/lLQeSgNX4WGwSDRZQciqR/RqeWT6xWtKaUOPAkeIpUvWMJ
 zeWnvyHeFQ+v8nx+i1pSSq69H/bLR70e3iqZP2pPgNQoXcbcMcq+IyhAvGlhQvOyiOot
 /P5F4mHK5B5Vw79Poms3I9jkTgpVzEiYnLWNucayxNZaqOnQQsgkPMv7mMIQCY6fny3U
 amo00sStpqo+jeUUXwwQJkK35JbzUrPiHwEnNd9AnPrkQlTP7d2W1KKuklDEDjknazbq
 6Yl6kqATvo+QnUEiNraR4XzvNvycZK68UdAiH3+Bn7389U1LTDV63kt4VZav2eXWx4bN
 IAng==
X-Gm-Message-State: AOAM530a9aJV9bGuPdUeIvDVQtIwOh9Iqy8/6b//UgJZaSEUp/I9XxgH
 vGGLZaVxc2Uy9kNPos9XC2k=
X-Google-Smtp-Source: ABdhPJz9hvSQ4kEn15pg4GdXhHEmP9dU+nu4iURs7wnT5KqepvkOcPZyRizzupf9HviKy/JMZf0maw==
X-Received: by 2002:a19:ed13:: with SMTP id y19mr12118860lfy.338.1619422766438; 
 Mon, 26 Apr 2021 00:39:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-102.dynamic.spd-mgts.ru.
 [109.252.193.102])
 by smtp.googlemail.com with ESMTPSA id d15sm1329008lfn.7.2021.04.26.00.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 00:39:26 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
 <20210401085549.GA31146@Asurada-Nvidia>
 <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
 <d01ccde4-5fa9-2aa7-c28b-b3899cc54c54@collabora.com>
 <724e683f-5317-cdf7-7351-fcfd42b7b607@gmail.com>
 <5ec2be61-a70e-e3b1-9267-414793c32a04@gmail.com>
 <YIZocTpPPM0vF4Wk@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <19834018-4ac7-a8fd-f7df-199128b04e4e@gmail.com>
Date: Mon, 26 Apr 2021 10:39:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIZocTpPPM0vF4Wk@orome.fritz.box>
Content-Language: en-US
Cc: Guillaume Tucker <guillaume.tucker@collabora.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

MjYuMDQuMjAyMSAxMDoxNCwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBTYXQsIEFw
ciAyNCwgMjAyMSBhdCAxMToyNzoxMFBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+
IDIzLjA0LjIwMjEgMTg6MjMsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+Pj4gMjMuMDQu
MjAyMSAxODowMSwgR3VpbGxhdW1lIFR1Y2tlciDQv9C40YjQtdGCOgo+Pj4+IE9uIDAyLzA0LzIw
MjEgMTU6NDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+Pj4gMDEuMDQuMjAyMSAxMTo1NSwg
Tmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+Pj4+PiBPbiBNb24sIE1hciAyOSwgMjAyMSBhdCAw
MjozMjo1NkFNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4+Pj4gVGhlIHByZXZp
b3VzIGNvbW1pdCBmaXhlcyBwcm9ibGVtIHdoZXJlIGRpc3BsYXkgY2xpZW50IHdhcyBhdHRhY2hp
bmcgdG9vCj4+Pj4+Pj4gZWFybHkgdG8gSU9NTVUgZHVyaW5nIGtlcm5lbCBib290IGluIGEgbXVs
dGktcGxhdGZvcm0ga2VybmVsIGNvbmZpZ3VyYXRpb24KPj4+Pj4+PiB3aGljaCBlbmFibGVzIENP
TkZJR19BUk1fRE1BX1VTRV9JT01NVT15LiBUaGUgd29ya2Fyb3VuZCB0aGF0IGhlbHBlZCB0bwo+
Pj4+Pj4+IGRlZmVyIHRoZSBJT01NVSBhdHRhY2htZW50IGZvciBOeWFuIEJpZyBDaHJvbWVib29r
IGlzbid0IG5lZWRlZCBhbnltb3JlLAo+Pj4+Pj4+IHJldmVydCBpdC4KPj4+Pj4+Cj4+Pj4+PiBT
b3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuIEkgaGF2ZSBiZWVuIGJ1c3kgd2l0aCBkb3duc3RyZWFt
IHRhc2tzLgo+Pj4+Pj4KPj4+Pj4+IEkgd2lsbCBnaXZlIHRoZW0gYSB0cnkgYnkgdGhlIGVuZCBv
ZiB0aGUgd2Vlay4gWWV0LCBwcm9iYWJseSBpdCdkCj4+Pj4+PiBiZSBiZXR0ZXIgdG8gaW5jbHVk
ZSBHdWlsbGF1bWUgYWxzbyBhcyBoZSBoYXMgdGhlIE55YW4gcGxhdGZvcm0uCj4+Pj4+Pgo+Pj4+
Pgo+Pj4+PiBJbmRlZWQsIHRoYW5rcy4gQWx0aG91Z2gsIEknbSBwcmV0dHkgc3VyZSB0aGF0IGl0
J3MgdGhlIHNhbWUgaXNzdWUgd2hpY2gKPj4+Pj4gSSByZXByb2R1Y2VkIG9uIE5leHVzIDcuCj4+
Pj4+Cj4+Pj4+IEd1aWxsYXVtZSwgY291bGQgeW91IHBsZWFzZSBnaXZlIGEgdGVzdCB0byB0aGVz
ZSBwYXRjaGVzIG9uIE55YW4gQmlnPwo+Pj4+PiBUaGVyZSBzaG91bGQgYmUgbm8gRU1FTSBlcnJv
cnMgaW4gdGhlIGtlcm5lbCBsb2cgd2l0aCB0aGlzIHBhdGNoZXMuCj4+Pj4+Cj4+Pj4+IGh0dHBz
Oi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC10ZWdyYS9saXN0Lz9zZXJpZXM9
MjM2MjE1Cj4+Pj4KPj4+PiBTbyBzb3JyeSBmb3IgdGhlIHZlcnkgbGF0ZSByZXBseS4gIEkgaGF2
ZSB0cmllZCB0aGUgcGF0Y2hlcyBidXQKPj4+PiBoaXQgc29tZSBpc3N1ZXMgb24gbGludXgtbmV4
dCwgaXQncyBub3QgcmVhY2hpbmcgYSBsb2dpbiBwcm9tcHQKPj4+PiB3aXRoIG5leHQtMjAyMTA0
MjIuICBTbyBJIHRoZW4gdHJpZWQgd2l0aCBuZXh0LTIwMjEwNDE5IHdoaWNoCj4+Pj4gZG9lcyBi
b290IGJ1dCBzaG93cyB0aGUgSU9NTVUgZXJyb3I6Cj4+Pj4KPj4+PiA8Nj5bICAgIDIuOTk1MzQx
XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEKPj4+PiA8ND5b
ICAgIDMuMDAxMDcwXSBGYWlsZWQgdG8gYXR0YWNoZWQgZGV2aWNlIDU0MjAwMDAwLmRjIHRvIElP
TU1VX21hcHBpbmcgIAo+Pj4+Cj4+Pj4gICBodHRwczovL2xhdmEuY29sbGFib3JhLmNvLnVrL3Nj
aGVkdWxlci9qb2IvMzU3MDA1MiNMMTEyMAo+Pj4+Cj4+Pj4gVGhlIGJyYW5jaCBJJ20gdXNpbmcg
d2l0aCB0aGUgcGF0Y2hlcyBhcHBsaWVkIGNhbiBiZSBmb3VuZCBoZXJlOgo+Pj4+Cj4+Pj4gICBo
dHRwczovL2dpdGxhYi5jb2xsYWJvcmEuY29tL2d0dWNrZXIvbGludXgvLS9jb21taXRzL25leHQt
MjAyMTA0MTktbnlhbi1iaWctZHJtLXJlYWQvCj4+Pj4KPj4+PiBIb3BlIHRoaXMgaGVscHMsIGxl
dCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueXRoaW5nIGVsc2UgdG8gYmUKPj4+PiB0ZXN0ZWQuCj4+
Pgo+Pj4KPj4+IEhlbGxvIEd1aWxsYXVtZSwKPj4+Cj4+PiBUaGUgY3VycmVudCBsaW51eC1uZXh0
IGRvZXNuJ3QgYm9vdCBvbiBhbGwgQVJNIChBRkFJSyksIHRoZSBvbGRlcgo+Pj4gbmV4dC0yMDIx
MDQxMyB3b3Jrcy4gVGhlIGFib3ZlIG1lc3NhZ2Ugc2hvdWxkIGJlIHVucmVsYXRlZCB0byB0aGUg
Ym9vdAo+Pj4gcHJvYmxlbS4gSXQgc2hvdWxkIGJlIG9rYXkgdG8gaWdub3JlIHRoYXQgbWVzc2Fn
ZSBhcyBpdCBzaG91bGQgYmUKPj4+IGhhcm1sZXNzIGluIHlvdXJzIGNhc2UuCj4+Pgo+Pgo+PiBB
bHRob3VnaCwgdGhlIDIwMjEwNDE5IHNob3VsZCBiZSBnb29kLgo+Pgo+PiBUaGllcnJ5LCBkbyB5
b3Uga25vdyB3aGF0IHRob3NlIFNPUiBhbmQgTm91dmVhdSBpc3N1ZXMgYXJlIGFib3V0Pwo+IAo+
IFRoZXJlJ3MgYSB1c2UtYWZ0ZXItZnJlZSAodGhvdWdoIGl0J3MgcmVhbGx5IGEgdXNlLWJlZm9y
ZS1pbml0KSBpc3N1ZSBpbgo+IGxpbnV4LW5leHQgYXQgdGhlIG1vbWVudCwgYnV0IGEgZml4IGhh
cyBiZWVuIHN1Z2dlc3RlZC4gVGhlIGZpeCBmb3IgdGhpcwo+IGFsb25nIHdpdGggYW4gYWRkaXRp
b25hbCBsZWFrIHBsdWcgaXMgaGVyZToKPiAKPiAJaHR0cDovL3BhdGNod29yay5vemxhYnMub3Jn
L3Byb2plY3QvbGludXgtdGVncmEvbGlzdC8/c2VyaWVzPTI0MDU2OQoKTmljZSwgdGhhbmsgeW91
LiBNYXliZSBHdWlsbGF1bWUgY291bGQgZ2l2ZSBpdCBhIHRlc3QuCgo+IEknbSBub3QgYXdhcmUg
b2YgYW55IE5vdXZlYXUgaXNzdWVzLiBXaGF0IHZlcnNpb24gYW5kIHBsYXRmb3JtIGFyZSB0aG9z
ZQo+IGhhcHBlbmluZyBvbj8gQXJlIHRoZXJlIGFueSBsb2dzPyBJIGNhbid0IHNlZW0gdG8gZmlu
ZCB0aGVtIGluIHRoaXMKPiB0aHJlYWQuCgpUaGlzIGFsbCBpcyBvbiBOeWFuIEJpZyB1c2luZyBs
aW51eC1uZXh0LTIwMjEwNDE5LiBUaGVyZSBpcyBhIGxpbmsgdG8gdGhlIGZ1bGwgbG9nIGFib3Zl
LgoKSSBzZWUgdGhpcyBOb3V2ZWF1IGZhaWx1cmU6Cgo8Nj5bICAgMTkuMzIzMTEzXSBub3V2ZWF1
IDU3MDAwMDAwLmdwdTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDIKPDY+WyAgIDE5LjMyMzYxNV0g
bm91dmVhdSA1NzAwMDAwMC5ncHU6IE5WSURJQSBHSzIwQSAoMGVhMDAwYTEpCjw2PlsgICAxOS4z
MjM2NjhdIG5vdXZlYXUgNTcwMDAwMDAuZ3B1OiBpbWVtOiB1c2luZyBJT01NVQo8Mz5bICAgMTku
MzIzNzk1XSBub3V2ZWF1IDU3MDAwMDAwLmdwdTogZ3IgY3RvciBmYWlsZWQ6IC0yCjw0PlsgICAx
OS4zMjM5ODNdIG5vdXZlYXU6IHByb2JlIG9mIDU3MDAwMDAwLmdwdSBmYWlsZWQgd2l0aCBlcnJv
ciAtMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
