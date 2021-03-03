Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5264CC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 02:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB1D65040
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 02:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB1D65040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C86040198;
	Thu,  4 Mar 2021 02:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BG66iS7u08co; Thu,  4 Mar 2021 02:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B6C143100;
	Thu,  4 Mar 2021 02:03:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39EC5C000A;
	Thu,  4 Mar 2021 02:03:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80F90C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 02:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 631176E750
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 02:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ip_3aeyv4lsA for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 02:03:37 +0000 (UTC)
X-Greylist: delayed 02:09:13 by SQLgrey-1.8.0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DA32606CB
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 02:03:37 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id 18so31934962lff.6
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 18:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5LbPB3SpTXsri4vi58yOUepQCtx4lRVynCRCrXYDWhk=;
 b=iBM34Nq5+BjX+uL4bxGvM1OldEbB8bsiriV6mA0YdKunWfydVZxt3BQE8NZkBQ5A4l
 MUsL+8TPfqMlgKLk7mtcz6iLPwP4DQlmmmwqCUTpSXLeTBGsvA9iynKHaNeS8lGv2d1t
 I1zQlao/FYaW2hTwuANkJNvihvwp00XYtwjwfTPrY0YoVYwPCQIbyhe6P3IGSU5dHAyE
 MziklxFAWZqwEgtjlr0FiyJywx5DJYw5vhS1HGoAeZdCjtIxS10kyKaYtxQA+Iy7zZy+
 Qs+IZqqznZE8DF3EPcwZBbA9pQEbo9htOdISZ3cn/DsR3sX+9vRSkSDQ9ZNcMkMHjvoX
 WVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5LbPB3SpTXsri4vi58yOUepQCtx4lRVynCRCrXYDWhk=;
 b=GUCkAwU8yjg2+/RZ+pJhQFSqMx/ZFGF60QsmbmJkM7AspzkSBP/11SJxJwvnMZuA/j
 X9j4jbSCxliQYhKv6uiIxgbEQlbOQgJKMPSw+KeD5WbYW2UkWPa96uZW1eh6Tus9FhKX
 j4lJZVtegocHbYS/tHX2gwHi3TYR4xmKg3UlN7C6JKFxCCmAJ3vBEpyOn81WOQmVRXpK
 txUftjhqYaXnU7w7nMSEIWL6x2lNMK+mTHYxhlaNpelxpSG3AN26M3hG2OjOj7BVo+0e
 q4JQUKmBdssSgf6//wL14hSbz/XCFmlkFK1AXYSsbwRwIv2mEwQQ4ijuNi6s/4A73FZK
 ot2Q==
X-Gm-Message-State: AOAM5336mlRbF4pIgD1yv0rVafEhql0hQ6LPkJmKqoQT7gbbqFpDoQem
 TCrQIeafAAPT3IJXudUs7yUaz7fC1GA=
X-Google-Smtp-Source: ABdhPJy0ChQDSEQFEFYwJAY/lp6QPtMzorgpdnThkpJMvj+mgwIDqI2VfCm7n5De5jouxa1PQd6U1Q==
X-Received: by 2002:a19:8197:: with SMTP id
 c145mr14892915lfd.655.1614764849889; 
 Wed, 03 Mar 2021 01:47:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id k8sm2920796lfg.41.2021.03.03.01.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Mar 2021 01:47:29 -0800 (PST)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
 <20210223021343.GA6539@Asurada-Nvidia>
 <79bb1248-497f-8adf-663b-74448bea3849@gmail.com>
 <20210225062742.GA13353@Asurada-Nvidia>
 <ee0f40f4-dffe-2987-5d4b-c5896f27ec24@gmail.com>
 <20210302230856.GA22992@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4a407ad8-33cb-94e9-398a-78fa65178e08@gmail.com>
Date: Wed, 3 Mar 2021 12:47:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210302230856.GA22992@Asurada-Nvidia>
Content-Language: en-US
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org
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

MDMuMDMuMjAyMSAwMjowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gU2F0LCBGZWIg
MjcsIDIwMjEgYXQgMTI6NTk6MTdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAy
NS4wMi4yMDIxIDA5OjI3LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4gLi4uCj4+Pj4gVGhl
IHBhcnRpYWxseSByZXZlcnQgc2hvdWxkIGJlIG9rYXksIGJ1dCBpdCdzIG5vdCBjbGVhciB0byBt
ZSB3aGF0IG1ha2VzCj4+Pj4gZGlmZmVyZW5jZSBmb3IgVDEyNCBzaW5jZSBJIGRvbid0IHNlZSB0
aGF0IHByb2JsZW0gb24gVDMwLCB3aGljaCBhbHNvCj4+Pj4gaGFzIGFjdGl2ZSBkaXNwbGF5IGF0
IGEgYm9vdCB0aW1lLgo+Pj4KPj4+IEhtbS4uZG8geW91IHNlZSAtPmF0dGFjaF9kZXYoKSBpcyBj
YWxsZWQgZnJvbSBob3N0MXhfY2xpZW50X2lvbW11X2F0dGFjaAo+Pj4gb3IgZnJvbSBvZl9kbWFf
Y29uZmlndXJlX2lkL2FyY2hfc2V0dXBfZG1hX29wcz8KPj4+Cj4+Cj4+IEkgYXBwbGllZCB5b3Vy
cyBkZWJ1Zy1wYXRjaCwgcGxlYXNlIHNlZSBkbWVzZy50eHQgYXR0YWNoZWQgdG8gdGhlIGVtYWls
Lgo+PiBTZWVtcyBwcm9iZS1kZWZlciBvZiB0aGUgdGVncmEtZGMgZHJpdmVyIHByZXZlbnRzIHRo
ZSBpbXBsaWNpdAo+PiB0ZWdyYV9zbW11X2F0dGFjaF9kZXYsIHNvIGl0IGhhcHBlbnMgdG8gd29y
ayBieSBhY2NpZGVudC4KPiAKPj4gWyAgICAwLjMyNzgyNl0gdGVncmEtZGMgNTQyMDAwMDAuZGM6
IC0tLS0tLS10ZWdyYV9zbW11X29mX3hsYXRlOiBpZCAxCj4+IFsgICAgMC4zMjg2NDFdIFs8YzA1
MmVjNzU+XSAodGVncmFfc21tdV9vZl94bGF0ZSkgZnJvbSBbPGMwNTJlNTkxPl0gKG9mX2lvbW11
X3hsYXRlKzB4NTEvMHg3MCkKPj4gWyAgICAwLjMyODc0MF0gWzxjMDUyZTU5MT5dIChvZl9pb21t
dV94bGF0ZSkgZnJvbSBbPGMwNTJlNmQ3Pl0gKG9mX2lvbW11X2NvbmZpZ3VyZSsweDEyNy8weDE1
MCkKPj4gWyAgICAwLjMyODg5Nl0gWzxjMDUyZTZkNz5dIChvZl9pb21tdV9jb25maWd1cmUpIGZy
b20gWzxjMDczZjY5Nz5dIChvZl9kbWFfY29uZmlndXJlX2lkKzB4MWZiLzB4MmVjKQo+PiBbICAg
IDAuMzI5MDYwXSBbPGMwNzNmNjk3Pl0gKG9mX2RtYV9jb25maWd1cmVfaWQpIGZyb20gWzxjMDU5
NzQzZj5dIChyZWFsbHlfcHJvYmUrMHg3Yi8weDJhMCkKPj4gWyAgICAwLjMzMTQzOF0gdGVncmEt
ZGMgNTQyMDAwMDAuZGM6IC0tLS0tLS0tdGVncmFfc21tdV9wcm9iZV9kZXZpY2UsIDgyMgo+PiBb
ICAgIDAuMzMyMjM0XSBbPGMwNTJlYmVkPl0gKHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKSBmcm9t
IFs8YzA1MmJkNmQ+XSAoX19pb21tdV9wcm9iZV9kZXZpY2UrMHgzNS8weDFjNCkKPj4gWyAgICAw
LjMzMjM5MV0gWzxjMDUyYmQ2ZD5dIChfX2lvbW11X3Byb2JlX2RldmljZSkgZnJvbSBbPGMwNTJj
M2NkPl0gKGlvbW11X3Byb2JlX2RldmljZSsweDE5LzB4ZWMpCj4+IFsgICAgMC4zMzI1NDVdIFs8
YzA1MmMzY2Q+XSAoaW9tbXVfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA1MmU2YWI+XSAob2ZfaW9t
bXVfY29uZmlndXJlKzB4ZmIvMHgxNTApCj4+IFsgICAgMC4zMzI3MDFdIFs8YzA1MmU2YWI+XSAo
b2ZfaW9tbXVfY29uZmlndXJlKSBmcm9tIFs8YzA3M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9p
ZCsweDFmYi8weDJlYykKPj4gWyAgICAwLjMzMjgwNF0gWzxjMDczZjY5Nz5dIChvZl9kbWFfY29u
ZmlndXJlX2lkKSBmcm9tIFs8YzA1OTc0M2Y+XSAocmVhbGx5X3Byb2JlKzB4N2IvMHgyYTApCj4+
IFsgICAgMC4zMzUyMDJdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLS1pb21tdV9ncm91
cF9nZXRfZm9yX2RldiwgMTU3Mgo+PiBbICAgIDAuMzM1MjkyXSB0ZWdyYS1kYyA1NDIwMDAwMC5k
YzogLS0tLS0tLS0tdGVncmFfc21tdV9kZXZpY2VfZ3JvdXAsIDg2Mgo+PiBbICAgIDAuMzM1NDc0
XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0tdGVncmFfc21tdV9kZXZpY2VfZ3JvdXAs
IDkwOTogMTogZHJtCj4+IFsgICAgMC4zMzU1NjZdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiAtLS0t
LS0tLS1pb21tdV9ncm91cF9nZXRfZm9yX2RldiwgMTU3NAo+PiBbICAgIDAuMzM1NzE4XSB0ZWdy
YS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0taW9tbXVfZ3JvdXBfYWRkX2RldmljZSwgODU4Cj4+
IFsgICAgMC4zMzU4NjJdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiBBZGRpbmcgdG8gaW9tbXUgZ3Jv
dXAgMQo+PiBbICAgIDAuMzM1OTU1XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0taW9t
bXVfYWxsb2NfZGVmYXVsdF9kb21haW4sIDE1NDM6IHR5cGUgMwo+PiBbICAgIDAuMzM2MTAxXSBp
b21tdTogLS0tLS0taW9tbXVfZ3JvdXBfYWxsb2NfZGVmYXVsdF9kb21haW46IHBsYXRmb3JtLCAo
bnVsbCksIGRybQo+PiBbICAgIDAuMzM2MTg3XSAtLS0tLS0tLS10ZWdyYV9zbW11X2RvbWFpbl9h
bGxvYywgMjg0OiB0eXBlIDMKPiAgWyAgICAwLjMzNjk2OF0gWzxjMGEwZmY0NT5dICh0ZWdyYV9z
bW11X2RvbWFpbl9hbGxvYykgZnJvbSBbPGMwYTBmODdiPl0gKGlvbW11X2dyb3VwX2FsbG9jX2Rl
ZmF1bHRfZG9tYWluKzB4NGIvMHhmYSkKPj4gWyAgICAwLjMzNzEyN10gWzxjMGEwZjg3Yj5dIChp
b21tdV9ncm91cF9hbGxvY19kZWZhdWx0X2RvbWFpbikgZnJvbSBbPGMwNTJjNDFkPl0gKGlvbW11
X3Byb2JlX2RldmljZSsweDY5LzB4ZWMpCj4+IFsgICAgMC4zMzcyODVdIFs8YzA1MmM0MWQ+XSAo
aW9tbXVfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA1MmU2YWI+XSAob2ZfaW9tbXVfY29uZmlndXJl
KzB4ZmIvMHgxNTApCj4+IFsgICAgMC4zMzc0NDFdIFs8YzA1MmU2YWI+XSAob2ZfaW9tbXVfY29u
ZmlndXJlKSBmcm9tIFs8YzA3M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9pZCsweDFmYi8weDJl
YykKPj4gWyAgICAwLjMzNzU5OV0gWzxjMDczZjY5Nz5dIChvZl9kbWFfY29uZmlndXJlX2lkKSBm
cm9tIFs8YzA1OTc0M2Y+XSAocmVhbGx5X3Byb2JlKzB4N2IvMHgyYTApCj4+IFsgICAgMC4zMzk5
MTNdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLS1pb21tdV9wcm9iZV9kZXZpY2UsIDI3
Mgo+PiBbICAgIDAuMzQ4MTQ0XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogZmFpbGVkIHRvIHByb2Jl
IFJHQiBvdXRwdXQ6IC01MTcKPiAKPiBIbW0uLm5vdCBzdXJlIHdoZXJlIHRoaXMgRVBST0JFX0RF
RkVSIGNvbWVzIGZyb20uCgpEQyBkcml2ZXIgb24gTmV4dXMgNyBkZXBlbmRzIG9uIExWRFMgYnJp
ZGdlIGFuZCBkaXNwbGF5IHBhbmVsLCB3aGljaApjYXVzZSB0aGUgcHJvYmUgZGVmZXIuCgo+IEJ1
dCB5b3UgYXJlIHJpZ2h0LAo+IGFzIG9mX2RtYV9jb25maWd1cmVfaWQoKSByZXR1cm5zIGJlY2F1
c2Ugb2YgdGhhdCBzbyBpdCBkaWRuJ3QgcnVuIHRvCj4gYXJjaF9zZXR1cF9kbWFfb3BzKCkgY2Fs
bCwgd2hpY2ggYWxsb2NhdGVzIGFuIFVOTUFOQUdFRCBpb21tdSBkb21haW4KPiBhbmQgYXR0YWNo
ZXMgREMgdG8gaXQgb24gVGVncmExMjQuCj4gCj4gQnkgdGhlIHdheSwgYW55b25lIGNhbiBhY2Nl
cHQgdGhpcyBjaGFuZ2U/IEl0IGRvZXNuJ3QgZmVlbCByaWdodCB0bwo+IGxlYXZlIGEgcmVncmVz
c2lvbiBpbiB0aGUgbmV3ZXIgcmVsZWFzZS4uLgo+IAoKSSB0aGluayBUaGllcnJ5IHNob3VsZCBn
aXZlIGFjay4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
