Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC76C433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 13:21:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B767D61A06
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 13:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B767D61A06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51A6C41460;
	Fri, 26 Mar 2021 13:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFcySKmeZIoH; Fri, 26 Mar 2021 13:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D074F40F3E;
	Fri, 26 Mar 2021 13:21:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6490C000E;
	Fri, 26 Mar 2021 13:21:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADA0C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 13:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBC9B40F57
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 13:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9LIhOwkqqeY for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 13:21:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86E7240F3E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 13:21:16 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id o10so7617560lfb.9
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A6XtyG3Wn1a5AnO2KjSc1MQN2Z4quULAuafK+/TEggc=;
 b=HoMJE5A+7i7FjCQ/J7e5/mNmJCguJTxZQNLgzmZfCdv07gSnDvg6v6c8p0Guy7gISG
 a/vMooxlcZ16P5JoLPMxRxTJ4w1yNm7ksYCAIt2NInp+fh/NkeSc4tJeOhpxysROX6i0
 CT+4eX4Gxiq+cAifK8dxRfIXhFU9F+brsb34eF9Xy0JTsUF0QScb68kxONxotUNvS80P
 3/sqH5KHshtwsf2+t/ITVMYNjjR7WmmZPbIkQEWWJ9BJ0gjV+LhS7wGvuRFGIMgvVhlc
 aS0mGT0+tJZQPFYLhDJwDvDqEvXGeGEnnOPycbDjzXzk3vW2bzVg26q99oxv7pxc+C0r
 hHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A6XtyG3Wn1a5AnO2KjSc1MQN2Z4quULAuafK+/TEggc=;
 b=bdW5iIG5dnG2ai9WF8tWnLi0Bph86lJgdLFgDE8wAMtgN6ejaLttmpDsQrai6FHIh2
 NGxtAhNfv0ZQKVm8A1rzkqRRy9Oi5RXeWhv1zJT4S1q5sPeqEPzc/QHsdhpc+Qi4KWb/
 Z43d2K0EapymfdUOiSco5ya+V5bOfSi36ywixCU7g0x1v41HuFOOlHkplKq4AH+1F+Mg
 wRCx25mnZQBplY6dr+ZETQafXIpIfESdyfCFyS3s0i4l0kNmk3Z9wWdGq8MRv/Z4otgd
 YBez9m9hJNji/1VM4J6JDNfw5WNoLUYuswFem1vGqLwdLfsq/4RZDgLXUce8THeyHfDF
 QmyA==
X-Gm-Message-State: AOAM533wO3Z99SISYAjVpHEY5YXoH6/Ttzy0S+QIzTa3y1s3wSPwgi5i
 69QevoAa5KsuZwRtmeYC4LI=
X-Google-Smtp-Source: ABdhPJxlfVpm0M4G46VyhSui8CkG/ReEs3Bx03J69qCUEJ38QEw7RkNRwQora0kC214itkFb0gNcFQ==
X-Received: by 2002:ac2:5211:: with SMTP id a17mr8137499lfl.192.1616764874351; 
 Fri, 26 Mar 2021 06:21:14 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:99a9:a10:76ff:fe69:21b6?
 ([2a00:1370:814d:99a9:a10:76ff:fe69:21b6])
 by smtp.googlemail.com with ESMTPSA id x6sm873210lfn.11.2021.03.26.06.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 06:21:13 -0700 (PDT)
Subject: Re: [PATCH 1/9] memory: tegra: Move internal data structures into
 separate header
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <20210325130332.778208-2-thierry.reding@gmail.com>
 <ca70b07a-608a-51b3-3c30-ff04bdf8bcc0@gmail.com>
 <YFyxtq6cwIJNr/Y5@orome.fritz.box>
 <4f1e0859-60b9-0ded-a4b8-70e06dd5a905@gmail.com>
Message-ID: <a2c0155e-23b7-db7c-7bf3-1203750edace@gmail.com>
Date: Fri, 26 Mar 2021 16:21:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4f1e0859-60b9-0ded-a4b8-70e06dd5a905@gmail.com>
Content-Language: en-US
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MjUuMDMuMjAyMSAxOToxMSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjUuMDMuMjAy
MSAxODo1MiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4gT24gVGh1LCBNYXIgMjUsIDIw
MjEgYXQgMDY6MTI6NTFQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4gMjUuMDMu
MjAyMSAxNjowMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4+PiBGcm9tOiBUaGllcnJ5
IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+Pj4+Cj4+Pj4gRnJvbSBUZWdyYTIwIHRocm91
Z2ggVGVncmEyMTAsIGVpdGhlciB0aGUgR0FSVCBvciBTTU1VIGRyaXZlcnMgbmVlZAo+Pj4+IGFj
Y2VzcyB0byB0aGUgaW50ZXJuYWxzIG9mIHRoZSBtZW1vcnkgY29udHJvbGxlciBkcml2ZXIgYmVj
YXVzZSB0aGV5IGFyZQo+Pj4+IHRpZ2h0bHkgY291cGxlZCAoaW4gZmFjdCwgdGhlIEdBUlQgYW5k
IFNNTVUgYXJlIHBhcnQgb2YgdGhlIG1lbW9yeQo+Pj4+IGNvbnRyb2xsZXIpLiBPbiBsYXRlciBj
aGlwcywgYSBzZXBhcmF0ZSBoYXJkd2FyZSBibG9jayBpbXBsZW1lbnRzIHRoZQo+Pj4+IFNNTVUg
ZnVuY3Rpb25hbGl0eSwgc28gdGhpcyBpcyBubyBsb25nZXIgbmVlZGVkLiBIb3dldmVyLCB3ZSBz
dGlsbCB3YW50Cj4+Pj4gdG8gcmV1c2Ugc29tZSBvZiB0aGUgZXhpc3RpbmcgaW5mcmFzdHJ1Y3R1
cmUgb24gbGF0ZXIgY2hpcHMsIHNvIHNwbGl0Cj4+Pj4gdGhlIG1lbW9yeSBjb250cm9sbGVyIGlu
dGVybmFscyBpbnRvIGEgc2VwYXJhdGUgaGVhZGVyIGZpbGUgdG8gYXZvaWQKPj4+PiBjb25mbGlj
dHMgd2l0aCB0aGUgaW1wbGVtZW50YXRpb24gb24gbmV3ZXIgY2hpcHMuCj4+Pj4KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+Pj4+IC0tLQo+
Pj4+ICBkcml2ZXJzL2lvbW11L3RlZ3JhLWdhcnQuYyAgICAgIHwgIDIgKy0KPj4+PiAgZHJpdmVy
cy9pb21tdS90ZWdyYS1zbW11LmMgICAgICB8ICAyICstCj4+Pj4gIGRyaXZlcnMvbWVtb3J5L3Rl
Z3JhL21jLmggICAgICAgfCAgMiArLQo+Pj4+ICBkcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdyYTE4
Ni5jIHwgMTIgKysrKy0tLQo+Pj4+ICBpbmNsdWRlL3NvYy90ZWdyYS9tYy1pbnRlcm5hbC5oIHwg
NjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4gIGluY2x1ZGUvc29jL3Rl
Z3JhL21jLmggICAgICAgICAgfCA1MCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+ICA2
IGZpbGVzIGNoYW5nZWQsIDcyIGluc2VydGlvbnMoKyksIDU4IGRlbGV0aW9ucygtKQo+Pj4+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9zb2MvdGVncmEvbWMtaW50ZXJuYWwuaAo+Pj4KPj4+
IFdoYXQgYWJvdXQgdG8gbWFrZSBUMTg2IHRvIHJlLXVzZSB0aGUgZXhpc3RpbmcgdGVncmFfbWMg
c3RydWN0PyBTZWVtcwo+Pj4gdGhlcmUgaXMgbm90aGluZyBzcGVjaWFsIGluIHRoYXQgc3RydWN0
IHdoaWNoIGRvZXNuJ3QgZml0IGZvciB0aGUgbmV3ZXIKPj4+IFNvQ3MuIFBsZWFzZSBub3RpY2Ug
dGhhdCBib3RoIFNNTVUgYW5kIEdBUlQgYXJlIGFscmVhZHkgb3B0aW9uYWwgYW5kIGFsbAo+Pj4g
dGhlIFNvQyBkaWZmZXJlbmNlcyBhcmUgc3BlY2lmaWVkIHdpdGhpbiB0aGUgdGVncmFfbWNfc29j
LiBJdCBsb29rcyB0bwo+Pj4gbWUgdGhhdCB0aGlzIGNvdWxkIGJlIGEgbXVjaCBuaWNlciBhbmQg
Y2xlYW5lciB2YXJpYW50Lgo+Pgo+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IG11Y2ggb2YgdGhlIGlu
dGVyZXN0aW5nIGJpdHMgaW4gdGVncmFfbWNfc29jIGFyZQo+PiBiYXNpY2FsbHkgaW5jb21wYXRp
YmxlIGJldHdlZW4gdGhlIHR3by4gRm9yIGluc3RhbmNlIHRoZSB0ZWdyYV9tY19jbGllbnQKPj4g
YW5kIHRlZ3JhMTg2X21jX2NsaWVudCBzdHJ1Y3R1cmVzLCB3aGlsZSB0aGV5IGhhdmUgdGhlIHNh
bWUgcHVycG9zZSwKPj4gaGF2ZSBjb21wbGV0ZWx5IGRpZmZlcmVudCBjb250ZW50LiBJIGRpZG4n
dCBzZWUgYSB3YXkgdG8gdW5pZnkgdGhhdAo+PiB3aXRob3V0IG92ZXJseSBjb21wbGljYXRpbmcg
dGhpbmdzIGJ5IG1ha2luZyBoYWxmIG9mIHRoZSBmaWVsZHMKPj4gYmFzaWNhbGx5IG9wdGlvbmFs
IG9uIG9uZSBvciB0aGUgb3RoZXIgU29DIGdlbmVyYXRpb24uCj4gCj4gVGhlIGFkZGl0aW9uYWwg
ZmllbGRzIGFyZW4ndCBwcm9ibGVtIGZvciBUMjAsIHdoaWNoIGRvZXNuJ3QgbmVlZCBtb3N0IG9m
Cj4gdGhlIGZpZWxkcy4gSSdkIHRyeSB0byBnbyB3aXRoIHRoZSBhZGRpdGlvbmFsIGZpZWxkcyBm
b3Igbm93IGFuZCBzZWUgaG93Cj4gaXQgd2lsbCBsb29rIGxpa2UsIGlmIGl0IHdpbGwgYmUgYm90
aGVyaW5nIHRvbyBtdWNoLCB0aGVuIHdlIG1heQo+IGNvbnNpZGVyIHRvIHJlZmFjdG9yIHRoZSBk
cml2ZXJzIG1vcmUgdGhvcm91Z2hseSAobGF0ZXIgb24sIGluIGEKPiBzZXBhcmF0ZSBzZXJpZXMp
LCB3aXRoIGEgYmV0dGVyL25pY2VyIHNlcGFyYXRpb24gYW5kIHRha2luZyBpbnRvIGFjY291bnQK
PiBhIHBvdGVudGlhbCBtb2R1bGFyaXphdGlvbiBzdXBwb3J0IGJ5IHRoZSBNQyBkcml2ZXJzLgo+
IAo+IFVzaW5nIGEgdW5pb24gZm9yIHRoZSBleGNsdXNpdmUgZmllbGRzIGFsc28gY291bGQgd29y
aywgYWx0aG91Z2ggYWx3YXlzCj4gbmVlZCB0byBiZSBleHRyYSBjYXJlZnVsIHdpdGggdGhlIHVu
aW9ucy4KPiAKPj4gTWF5YmUgb25lIG9wdGlvbiB3b3VsZCBiZSB0byBzcGxpdCB0ZWdyYV9tYyBp
bnRvIGEgdGVncmFfbWNfY29tbW9uIGFuZAo+PiB0aGVuIGRlcml2ZSB0ZWdyYV9tYyBhbmQgdGVn
cmExODZfbWMgZnJvbSB0aGF0LiBUaGF0IHdheSB3ZSBjb3VsZCBzaGFyZQo+PiB0aGUgY29tbW9u
IGJpdHMgd2hpbGUgc3RpbGwgbGV0dGluZyB0aGUgY2hpcC1zcGVjaWZpYyBkaWZmZXJlbmNlcyBi
ZQo+PiBoYW5kbGVkIHNlcGFyYXRlbHkuCj4gCj4gQnV0IGlzbid0IHRlZ3JhX21jIGFscmVhZHkg
YSBzdXBlcnNldCBvZiB0ZWdyYTE4Nl9tYz8gSSB0aGluayB0aGUKPiB0ZWdyYTE4Nl9tY19jbGll
bnQgaXMgdGhlIG1haW4gZGlmZmVyZW5jZSBoZXJlLgo+IAoKQW5vdGhlciB0aGluZyB3ZSBjb3Vs
ZCBkbyBpcyB0byBvcHRpbWl6ZSB0aGUgc2l6ZSBvZiB0ZWdyYV9tY19jbGllbnQsIGJ1dCBub3Qg
c3VyZSB3aGV0aGVyIGl0J3Mgd29ydGh3aGlsZSB0byBjYXJlIGFib3V0IGV4dHJhIH4zS0Igb2Yg
ZGF0YS4KClRoaXMgc2xpbXMgZG93biB0ZWdyYV9tY19jbGllbnQgYnkgdHdvIHRpbWVzOgoKIGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5jIGIvZHJpdmVycy9tZW1vcnkvdGVn
cmEvbWMuYwppbmRleCBlZGVhOWIyYjQwNmUuLjFkNjUyYmZjNmI0NCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9tZW1vcnkvdGVncmEvbWMuYworKysgYi9kcml2ZXJzL21lbW9yeS90ZWdyYS9tYy5jCkBA
IC0zMTcsMTEgKzMxNywxMSBAQCBzdGF0aWMgaW50IHRlZ3JhX21jX3NldHVwX2xhdGVuY3lfYWxs
b3dhbmNlKHN0cnVjdCB0ZWdyYV9tYyAqbWMpCiAJLyogd3JpdGUgbGF0ZW5jeSBhbGxvd2FuY2Ug
ZGVmYXVsdHMgKi8KIAlmb3IgKGkgPSAwOyBpIDwgbWMtPnNvYy0+bnVtX2NsaWVudHM7IGkrKykg
ewogCQljb25zdCBzdHJ1Y3QgdGVncmFfbWNfbGEgKmxhID0gJm1jLT5zb2MtPmNsaWVudHNbaV0u
bGE7Ci0JCXUzMiB2YWx1ZTsKKwkJdTMyIHZhbHVlLCBsYV9tYXNrID0gbGEtPm1hc2ssIGxhX2Rl
ZiA9IGxhLT5kZWY7CiAKIAkJdmFsdWUgPSBtY19yZWFkbChtYywgbGEtPnJlZyk7Ci0JCXZhbHVl
ICY9IH4obGEtPm1hc2sgPDwgbGEtPnNoaWZ0KTsKLQkJdmFsdWUgfD0gKGxhLT5kZWYgJiBsYS0+
bWFzaykgPDwgbGEtPnNoaWZ0OworCQl2YWx1ZSAmPSB+KGxhX21hc2sgPDwgbGEtPnNoaWZ0KTsK
KwkJdmFsdWUgfD0gKGxhX2RlZiAmIGxhX21hc2spIDw8IGxhLT5zaGlmdDsKIAkJbWNfd3JpdGVs
KG1jLCB2YWx1ZSwgbGEtPnJlZyk7CiAJfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS90
ZWdyYS90ZWdyYTMwLmMgYi9kcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdyYTMwLmMKaW5kZXggNDYz
MzJmYTgyZDEwLi5lY2YwNTQ4NGQ2NTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVtb3J5L3RlZ3Jh
L3RlZ3JhMzAuYworKysgYi9kcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdyYTMwLmMKQEAgLTExNTcs
NyArMTE1Nyw3IEBAIHN0YXRpYyB2b2lkIHRlZ3JhMzBfbWNfdHVuZV9jbGllbnRfbGF0ZW5jeShz
dHJ1Y3QgdGVncmFfbWMgKm1jLAogCXUzMiBhcmJfdG9sZXJhbmNlX2NvbXBlbnNhdGlvbl9uc2Vj
LCBhcmJfdG9sZXJhbmNlX2NvbXBlbnNhdGlvbl9kaXY7CiAJY29uc3Qgc3RydWN0IHRlZ3JhX21j
X2xhICpsYSA9ICZjbGllbnQtPmxhOwogCXVuc2lnbmVkIGludCBmaWZvX3NpemUgPSBjbGllbnQt
PmZpZm9fc2l6ZTsKLQl1MzIgYXJiX25zZWMsIGxhX3RpY2tzLCB2YWx1ZTsKKwl1MzIgYXJiX25z
ZWMsIGxhX3RpY2tzLCB2YWx1ZSwgbGFfbWFzazsKIAogCS8qIHNlZSAxOC40LjEgQ2xpZW50IENv
bmZpZ3VyYXRpb24gaW4gVGVncmEzIFRSTSB2MDNwICovCiAJaWYgKGJhbmR3aWR0aF9tYnl0ZXNf
c2VjKQpAQCAtMTIxNCwxMSArMTIxNCwxMiBAQCBzdGF0aWMgdm9pZCB0ZWdyYTMwX21jX3R1bmVf
Y2xpZW50X2xhdGVuY3koc3RydWN0IHRlZ3JhX21jICptYywKIAkgKiBjbGllbnQgbWF5IHdhaXQg
aW4gdGhlIEVNRU0gYXJiaXRlciBiZWZvcmUgaXQgYmVjb21lcyBhIGhpZ2gtcHJpb3JpdHkKIAkg
KiByZXF1ZXN0LgogCSAqLworCWxhX21hc2sgPSBsYS0+bWFzazsKIAlsYV90aWNrcyA9IGFyYl9u
c2VjIC8gbWMtPnRpY2s7Ci0JbGFfdGlja3MgPSBtaW4obGFfdGlja3MsIGxhLT5tYXNrKTsKKwls
YV90aWNrcyA9IG1pbihsYV90aWNrcywgbGFfbWFzayk7CiAKIAl2YWx1ZSA9IG1jX3JlYWRsKG1j
LCBsYS0+cmVnKTsKLQl2YWx1ZSAmPSB+KGxhLT5tYXNrIDw8IGxhLT5zaGlmdCk7CisJdmFsdWUg
Jj0gfihsYV9tYXNrIDw8IGxhLT5zaGlmdCk7CiAJdmFsdWUgfD0gbGFfdGlja3MgPDwgbGEtPnNo
aWZ0OwogCW1jX3dyaXRlbChtYywgdmFsdWUsIGxhLT5yZWcpOwogfQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9zb2MvdGVncmEvbWMuaCBiL2luY2x1ZGUvc29jL3RlZ3JhL21jLmgKaW5kZXggZDJmYmU2
YThiMjViLi5lN2E5OTRkMTZjOGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvc29jL3RlZ3JhL21jLmgK
KysrIGIvaW5jbHVkZS9zb2MvdGVncmEvbWMuaApAQCAtMTgsOCArMTgsOCBAQCBzdHJ1Y3QgZGV2
aWNlOwogc3RydWN0IHBhZ2U7CiAKIHN0cnVjdCB0ZWdyYV9zbW11X2VuYWJsZSB7Ci0JdW5zaWdu
ZWQgaW50IHJlZzsKLQl1bnNpZ25lZCBpbnQgYml0OworCXUxNiByZWc7CisJdTggYml0OwogfTsK
IAogc3RydWN0IHRlZ3JhX21jX3RpbWluZyB7CkBAIC0zMCwyMiArMzAsMjIgQEAgc3RydWN0IHRl
Z3JhX21jX3RpbWluZyB7CiAKIC8qIGxhdGVuY3kgYWxsb3dhbmNlICovCiBzdHJ1Y3QgdGVncmFf
bWNfbGEgewotCXVuc2lnbmVkIGludCByZWc7Ci0JdW5zaWduZWQgaW50IHNoaWZ0OwotCXVuc2ln
bmVkIGludCBtYXNrOwotCXVuc2lnbmVkIGludCBkZWY7CisJdTE2IHJlZzsKKwl1OCBzaGlmdDsK
Kwl1OCBtYXNrOworCXU4IGRlZjsKIH07CiAKIHN0cnVjdCB0ZWdyYV9tY19jbGllbnQgewotCXVu
c2lnbmVkIGludCBpZDsKIAljb25zdCBjaGFyICpuYW1lOwotCXVuc2lnbmVkIGludCBzd2dyb3Vw
OwogCi0JdW5zaWduZWQgaW50IGZpZm9fc2l6ZTsKKwl1OCBpZDsKKwl1OCBzd2dyb3VwOworCXUx
NiBmaWZvX3NpemU7CiAKIAlzdHJ1Y3QgdGVncmFfc21tdV9lbmFibGUgc21tdTsKIAlzdHJ1Y3Qg
dGVncmFfbWNfbGEgbGE7Ci19OworfSBfX3BhY2tlZDsKIAogc3RydWN0IHRlZ3JhX3NtbXVfc3dn
cm91cCB7CiAJY29uc3QgY2hhciAqbmFtZTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
