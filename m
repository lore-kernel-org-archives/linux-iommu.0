Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6B1C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 09:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E257283134;
	Tue, 17 May 2022 09:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58kIBACOvDb5; Tue, 17 May 2022 09:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC3AE83118;
	Tue, 17 May 2022 09:37:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 965ADC0032;
	Tue, 17 May 2022 09:37:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15B2AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0437140899
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQH0y4sMIGfj for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 09:37:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1F3240896
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 09:37:37 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id m62so10087266wme.5
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=d6bpt5PhKRS2nxh0KH3QMhV6usmzH2DoiTgMOR5LKlY=;
 b=b95mzv+H1fuom7FJmC5IfYzMBegHp5UBQ93ReG8v5w1FBMrlb3IHdgH+K+PfL9Gd7a
 6g9FRa1kg7PHBBhHlD94UTtBvuefUsFv18XedpdLjT1OpKJz8PZewsKTc6oS+kGFN43a
 fUbTeu5OmuB0RVNCWdGgcc2RpA2yTU6UnbZWqS/kwBNPG9fvUCiolyyYlKT/QlCZScKJ
 9/vLKty7wbn1iGRJXUTcDRqvLCkwzxC/lcX0xCD8lLyujq/z1l+xlFLpKhej7uCqFDMu
 4yvOSeNEriQaUaFY8AjkwoWbHJXRG7uMxJLGNVzExOsM4Nlqw+cit3za2IQMHyqdPSPj
 ZUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=d6bpt5PhKRS2nxh0KH3QMhV6usmzH2DoiTgMOR5LKlY=;
 b=1j62F99EuTnc3u72J3v4HGZrdkc9HqG2aL9n8zfPkwXhbP4zTLx+g9WWf0WwzxOJg7
 TShcTy7tntI6FzeL/n6PBokOF7qFmRSs2nCKuMPetT/8LHHz2uxmSB2f/uSqILbiTQYP
 Mu5mpe+a7s+YyANor4LzyxCA0wDl2SSooD5fdSP8oP93YqOVtLAjYs3u0/C7qUPW70F8
 q/Xtqi8EAJkEujv8kQw8ifL+gWFOdnsWD/+XH94pZI9CEIPX75RTgRapZYABJVxr9sNG
 0Y2fDH8ao1k/8x0mfgUiZpPCw561XPl4jxo/A/JngF+lYAtHkDS5qOeJy2cIoiixbHVe
 Y2gA==
X-Gm-Message-State: AOAM530h8w6x/ggK0HC94OtnbkcOwjRw7en+LctWULvZsfvVYHmrIemz
 M/y+Y83b04UDHCZG4oXh6IU=
X-Google-Smtp-Source: ABdhPJwQh+M0XoRHAjimlls7kwZEYt3NwpazeP5chnIi40MWbi4V+CLn1u5VVlKkgebvBjEFtn02fw==
X-Received: by 2002:a05:600c:3549:b0:394:89ba:e1be with SMTP id
 i9-20020a05600c354900b0039489bae1bemr20344806wmq.181.1652780255954; 
 Tue, 17 May 2022 02:37:35 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c224100b0039706782e06sm1372542wmm.33.2022.05.17.02.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 May 2022 02:37:35 -0700 (PDT)
Message-ID: <8a3079d2-1a2f-43ff-9072-91083a025c7b@gmail.com>
Date: Tue, 17 May 2022 11:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] iommu: mtk_iommu: Add support for MT6795 Helio X10
 M4Us
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-3-angelogioacchino.delregno@collabora.com>
 <38e38006662b52631a2145228444b9d70f9eb2c6.camel@mediatek.com>
 <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
Cc: devicetree@vger.kernel.org, martin.botka@somainline.org,
 paul.bouchara@somainline.org, konrad.dybcio@somainline.org,
 linux-kernel@vger.kernel.org, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht,
 krzysztof.kozlowski+dt@linaro.org, marijn.suijten@somainline.org,
 phone-devel@vger.kernel.org, will@kernel.org, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

CgpPbiAxNy8wNS8yMDIyIDExOjI2LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToK
PiBJbCAxNy8wNS8yMiAxMTowOCwgWW9uZyBXdSBoYSBzY3JpdHRvOgo+PiBPbiBGcmksIDIwMjIt
MDUtMTMgYXQgMTc6MTQgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOgo+
Pj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBNNFVzIGZvdW5kIGluIHRoZSBNVDY3OTUgSGVsaW8gWDEw
IFNvQy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
Cj4+PiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+Cj4+PiAtLS0KPj4+
IMKgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyMCArKysrKysrKysrKysrKysrKysrLQo+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMKPj4+IGluZGV4IDcxYjJhY2U3NGNkNi4uM2Q4MDJkZDNmMzc3IDEwMDY0
NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYwo+Pj4gQEAgLTE1Nyw2ICsxNTcsNyBAQAo+Pj4gwqAgZW51bSBtdGtf
aW9tbXVfcGxhdCB7Cj4+PiDCoMKgwqDCoMKgIE00VV9NVDI3MTIsCj4+PiDCoMKgwqDCoMKgIE00
VV9NVDY3NzksCj4+PiArwqDCoMKgIE00VV9NVDY3OTUsCj4+PiDCoMKgwqDCoMKgIE00VV9NVDgx
NjcsCj4+PiDCoMKgwqDCoMKgIE00VV9NVDgxNzMsCj4+PiDCoMKgwqDCoMKgIE00VV9NVDgxODMs
Cj4+PiBAQCAtOTUzLDcgKzk1NCw4IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29u
c3Qgc3RydWN0Cj4+PiBtdGtfaW9tbXVfZGF0YSAqZGF0YSwgdW5zaWduZWQgaW50IGJhbgo+Pj4g
wqDCoMKgwqDCoMKgICogR2xvYmFsIGNvbnRyb2wgc2V0dGluZ3MgYXJlIGluIGJhbmswLiBNYXkg
cmUtaW5pdCB0aGVzZQo+Pj4gZ2xvYmFsIHJlZ2lzdGVycwo+Pj4gwqDCoMKgwqDCoMKgICogc2lu
Y2Ugbm8gc3VyZSBpZiB0aGVyZSBpcyBiYW5rMCBjb25zdW1lcnMuCj4+PiDCoMKgwqDCoMKgwqAg
Ki8KPj4+IC3CoMKgwqAgaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQgPT0gTTRVX01UODE3
Mykgewo+Pj4gK8KgwqDCoCBpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ2
Nzk1IHx8Cj4+PiArwqDCoMKgwqDCoMKgwqAgZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBN
NFVfTVQ4MTczKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmVndmFsID0gRl9NTVVfUFJFRkVU
Q0hfUlRfUkVQTEFDRV9NT0QgfAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGX01N
VV9URl9QUk9UX1RPX1BST0dSQU1fQUREUl9NVDgxNzM7Cj4+PiDCoMKgwqDCoMKgIH0gZWxzZSB7
Cj4+PiBAQCAtMTEzOCw2ICsxMTQwLDkgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3Ry
dWN0Cj4+PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2Fz
ZSBNNFVfTVQyNzEyOgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcCA9ICJtZWRpYXRl
ayxtdDI3MTItaW5mcmFjZmciOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBNNFVfTVQ2Nzk1Ogo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcCA9ICJtZWRpYXRlayxtdDY3OTUtaW5mcmFjZmciOwo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBNNFVfTVQ4MTcz
Ogo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcCA9ICJtZWRpYXRlayxtdDgxNzMtaW5m
cmFjZmciOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiBAQCAtMTQw
NCw2ICsxNDA5LDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YQo+
Pj4gbXQ2Nzc5X2RhdGEgPSB7Cj4+PiDCoMKgwqDCoMKgIC5sYXJiaWRfcmVtYXDCoCA9IHt7MH0s
IHsxfSwgezJ9LCB7M30sIHs1fSwgezcsIDh9LCB7MTB9LCB7OX19LAo+Pj4gwqAgfTsKPj4+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ2Nzk1X2RhdGEgPSB7Cj4+
PiArwqDCoMKgIC5tNHVfcGxhdMKgwqDCoMKgID0gTTRVX01UNjc5NSwKPj4+ICvCoMKgwqAgLmZs
YWdzwqDCoMKgwqDCoMKgwqDCoMKgID0gSEFTXzRHQl9NT0RFIHwgSEFTX0JDTEsgfCBSRVNFVF9B
WEkgfAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEFTX0xFR0FDWV9JVlJQX1BBRERSIHwg
TVRLX0lPTU1VX1RZUEVfTU0sCj4+PiArwqDCoMKgIC5pbnZfc2VsX3JlZ8KgID0gUkVHX01NVV9J
TlZfU0VMX0dFTjEsCj4+PiArwqDCoMKgIC5iYW5rc19udW3CoMKgwqAgPSAxLAo+Pj4gK8KgwqDC
oCAuYmFua3NfZW5hYmxlID0ge3RydWV9LAo+Pj4gK8KgwqDCoCAuaW92YV9yZWdpb27CoCA9IHNp
bmdsZV9kb21haW4sCj4+PiArwqDCoMKgIC5pb3ZhX3JlZ2lvbl9uciA9IEFSUkFZX1NJWkUoc2lu
Z2xlX2RvbWFpbiksCj4+PiArwqDCoMKgIC5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7MX0sIHsyfSwg
ezN9LCB7NH19LCAvKiBMaW5lYXIgbWFwcGluZy4KPj4+ICovCj4+PiArfTsKPj4KPj4gVGhpcyBp
cyBuZWFybHkgc2FtZSB3aXRoIG10ODE3M19kYXRhLiBtdDgxNzMgaGFzIG9uZSBtb3JlIGxhcmIg
dGhhbgo+PiBtdDY3OTUsIGl0cyBsYXJiaWRfcmVtYXAgaXMgYWxzbyBvayBmb3IgbXQ2Nzk1Lgo+
Pgo+IAo+IEkgdGhpbmsgdGhhdCB3ZSBzaG91bGQgYmUgZXhwbGljaXQgYWJvdXQgdGhlIGxhcmJp
ZF9yZW1hcCBwcm9wZXJ0eSwKPiBzaW5jZSBtdDY3OTUgaGFzIG9uZSBsZXNzIGxhcmIsIHdlIHNo
b3VsZCBleHBsaWNpdGx5IHNheSB0aGF0IGxpa2UKPiBJIGRpZCB0aGVyZS4uLiB0aGF0J3Mgb25s
eSBmb3IgaHVtYW4gcmVhZGFiaWxpdHkgSSBhZG1pdCAuLi4gYnV0LAo+IHN0aWxsLCBJIHdvdWxk
bid0IHdhbnQgdG8gc2VlIHBlb3BsZSB0aGlua2luZyB0aGF0IE1UNjc5NSBoYXMgNiBMQVJCcwo+
IGJlY2F1c2UgdGhleSd2ZSByZWFkIHRoYXQgbGFyYmlkX3JlbWFwIGhhdmluZyA2IGVudHJpZXMu
Cj4gCj4+IHRodXMgaXQgbG9va3Mgd2UgY291bGQgdXNlIG10ODE3MyBhcyB0aGUgYmFja3dhcmQg
Y29tcGF0aWJsZS4KPj4gwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3OTUtbTR1
IiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAibWVkaWF0ZWssbXQ4MTcz
LW00dSI7Cj4+Cj4+IEFmdGVyIHRoaXMsIHRoZSBvbmx5IHRoaW5nIGlzIGFib3V0ICJtZWRpYXRl
ayxtdDY3OTUtaW5mcmFjZmciLiB3ZSBoYXZlCj4+IHRvIHRyeSBhZ2FpbiB3aXRoIG1lZGlhdGVr
LG10Njc5NS1pbmZyYWNmZyBhZnRlciBtZWRpYXRlayxtdDgxNzMtCj4+IGluZnJhY2ZnIGZhaWwu
IEkgdGhpbmsgd2Ugc2hvdWxkIGFsbG93IHRoZSBiYWNrd2FyZCBjYXNlIGluIDRHQiBtb2RlCj4+
IGp1ZGdtZW50IGlmIHdlIGhhdmUuCj4+Cj4+IFdoYXQncyB5b3VyIG9waW5pb24/IG9yIHNvbWUg
b3RoZXIgc3VnZ2VzdGlvbj8KPj4gVGhhbmtzLgo+IAo+IEkga25vdywgSSBtYXkgaGF2ZSBhIHBs
YW4gZm9yIHRoYXQsIGJ1dCBJIHdhbnRlZCB0byBoYXZlIGEgZ29vZCByZWFzb24gdG8KPiBwcm9w
b3NlIHN1Y2ggYSB0aGluZywgYXMgaWYgaXQncyBqdXN0IGFib3V0IHR3byBTb0NzIG5lZWRpbmcg
dGhhdCwgdGhlcmUKPiB3b3VsZCBiZSBubyBnb29kIHJlYXNvbiB0byBnZXQgdGhpbmdzIGRvbmUg
ZGlmZmVyZW50bHkuCj4gCj4gLi4uc28sIGluIG9yZGVyIHRvIHByb3ZpZGUgYSBnb29kIGNsZWFu
dXAsIHdlIGhhdmUgdHdvIHBvc3NpYmxlIHJvYWRzIHRvCj4gZm9sbG93IGhlcmU6IGVpdGhlciB3
ZSBhZGQgYSBnZW5lcmljICJtZWRpYXRlayxpbmZyYWNmZyIgY29tcGF0aWJsZSB0byB0aGUKPiBp
bmZyYSBub2RlIChidXQgSSBkb24ndCBsaWtlIHRoYXQpLCBvciB3ZSBjYW4gZG8gaXQgbGlrZSBp
dCB3YXMgcHJldmlvdXNseQo+IGRvbmUgaW4gbXRrLXBtLWRvbWFpbnMuYyAoSSBwcmVmZXIgdGhh
dCBhcHByb2FjaCk6Cj4gCj4gaW9tbXU6IGlvbW11QHNvbWV3aGVyZSB7Cj4gIMKgwqDCoMKgLi4u
IHNvbWV0aGluZyAuLi4KPiAgwqDCoMKgwqBtZWRpYXRlayxpbmZyYWNmZyA9IDwmaW5mcmFjZmc+
Owo+IH07Cj4gCj4gaW5mcmFjZmcgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxl
KG5vZGUsICJtZWRpYXRlayxpbmZyYWNmZyIpOwo+IGlmIChJU19FUlIoaW5mcmFjZmcpKSB7Cj4g
IMKgwqDCoMKgLyogdHJ5IHdpdGggdGhlIG9sZGVyIHdheSAqLwo+ICDCoMKgwqDCoHN3aXRjaCAo
Li4uKSB7Cj4gIMKgwqDCoMKgY2FzZSAuLi4uIHAgPSAibWVkaWF0ZWssbXQyNzEyLWluZnJhY2Zn
IjsKPiAgwqDCoMKgwqAuLi4gYmxhaCBibGFoIC4uLgo+ICDCoMKgwqDCoH0KPiAgwqDCoMKgwqAv
KiBsZWdhY3kgYWxzbyBmYWlsZWQsIG91Y2ghICovCj4gIMKgwqDCoMKgaWYgKElTX0VSUihpbmZy
YWNmZykpCj4gIMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKGluZnJhY2ZnKTsKPiB9Cj4g
Cj4gcmV0ID0gcmVnbWFwX3JlYWQgLi4uIGV0YyBldGMgZXRjCj4gCgpJIHByZWZlciB0aGF0IGFw
cHJvYWNoIGFzIHdlbGwuCgpSZWdhcmRzLApNYXR0aGlhcwoKPiBDaGVlcnMsCj4gQW5nZWxvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
