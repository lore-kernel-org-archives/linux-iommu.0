Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FCBC433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:51:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680B1613AE
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680B1613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F071D83A7A;
	Tue, 20 Apr 2021 09:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqOcuP74WyZO; Tue, 20 Apr 2021 09:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C752783A60;
	Tue, 20 Apr 2021 09:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A22FFC000E;
	Tue, 20 Apr 2021 09:51:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39CB3C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23BED83A7E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOof_LmfjEGR for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:39:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F15CA83576
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:39:03 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id m7so31941296ljp.10
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:references:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0cgFeiaCJmuEwdxXqsfxCg9P2r8ydkzAaV1kqEK2h0w=;
 b=gvB2Kjtuq3c6hDrfV3q09iYFnvk6b3RYxllwzrHlnk+X8nahI/9ZgjrPXry5x6L08J
 ZqUJbyfgrU/17jihKD9RUFrWkKnPLnaOIz5SfrAgdH3V6GQqhJBsJvkRB5ags8nff6/g
 3cv4VDvDqV2sSqUfb8205g5G7kjLsdASVbSOa0/k/nLxNeajkm1KtVIIys66vWeGWX+c
 R9IfZtnbhr3czfjp/hluYCcP4dflvCu/ccDgljZf5znlxpNeSE4/7JXLhxawyn0f1SMK
 6r42KR2eqy29tw7Neimeshqmq4hBcMWCqRWk5EiKSmXItxwa+o1xYehRrMSSHpcpkKnQ
 slWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0cgFeiaCJmuEwdxXqsfxCg9P2r8ydkzAaV1kqEK2h0w=;
 b=lPDvgUKBSpWoHA6gD1456RGI7aYXs3WXhSZEPea7cQLnycPFfJmjYko7/F5yQjA6Mv
 Z7dJyYP9qjRtgEYi2TcvxAKUWjPGtcbgNk1vbj2AzXZvq8fG3rms1IpCoRR5Q7I0G2cv
 fXcK8u376aoSxowGOVPoWfUVWpNSL9X5rbAvoCGLicoeCBJJFFsj3hqdApgpB3gqb799
 LvDabWK6bfB97EypoKLBkN5DPxWVs/vy5LeWHTFGYvfA3u/SS2O4sbN0ePHM2vb6Yk8D
 Mb0RDQ0F4Uu5GEvoJ7B61nVcgF6ICT4IBHpkTM5pAoGX9Sr/13stzvXGNLeXCXlAAATK
 l3Ig==
X-Gm-Message-State: AOAM533BUJtUoEBHsoZHrAEnljx3FlbrGE6jKqn77DVBu4xeUSfofVCp
 LtGSt3BEdYwEsN0I0lkmBtc=
X-Google-Smtp-Source: ABdhPJxU9OnhgUvmhfsaX0XQNxKFEPf1HsBVx73r0wgo9gbzwsyEGSVJJz6LhIbQa4C3GIRFxd4WnA==
X-Received: by 2002:a2e:9f49:: with SMTP id v9mr14102607ljk.44.1618911541931; 
 Tue, 20 Apr 2021 02:39:01 -0700 (PDT)
Received: from [10.0.0.42] (91-155-111-71.elisa-laajakaista.fi.
 [91.155.111.71])
 by smtp.gmail.com with ESMTPSA id n22sm723197lfu.144.2021.04.20.02.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Apr 2021 02:39:01 -0700 (PDT)
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, horia.geanta@nxp.com, aymen.sghaier@nxp.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, tony@atomide.com,
 geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 vkoul@kernel.org, a.hajda@samsung.com, narmstrong@baylibre.com,
 robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
 khilman@baylibre.com, tomba@kernel.org, jyri.sarha@iki.fi, joro@8bytes.org,
 will@kernel.org, mchehab@kernel.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, kishon@ti.com, kuba@kernel.org,
 linus.walleij@linaro.org, Roy.Pledge@nxp.com, leoyang.li@nxp.com,
 ssantosh@kernel.org, matthias.bgg@gmail.com, edubezval@gmail.com,
 j-keerthy@ti.com, balbi@kernel.org, linux@prisktech.co.nz,
 stern@rowland.harvard.edu, wim@linux-watchdog.org, linux@roeck-us.net
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
Message-ID: <2924b8af-d176-01b1-a221-5219c1128494@gmail.com>
Date: Tue, 20 Apr 2021 12:40:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419042722.27554-4-alice.guo@oss.nxp.com>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 20 Apr 2021 09:51:00 +0000
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-phy@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

SGkgQWxpY2UsCgpPbiA0LzE5LzIxIDc6MjcgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToKPiBG
cm9tOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPgo+IAo+IFVwZGF0ZSBhbGwgdGhlIGNv
ZGUgdGhhdCB1c2Ugc29jX2RldmljZV9tYXRjaCBiZWNhdXNlIGFkZCBzdXBwb3J0IGZvcgo+IHNv
Y19kZXZpY2VfbWF0Y2ggcmV0dXJuaW5nIC1FUFJPQkVfREVGRVIuCj4gCj4gU2lnbmVkLW9mZi1i
eTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9idXMvdGkt
c3lzYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9jbGsvcmVu
ZXNhcy9yOGE3Nzk1LWNwZy1tc3NyLmMgICAgICAgIHwgIDQgKysrLQo+ICBkcml2ZXJzL2Nsay9y
ZW5lc2FzL3JjYXItZ2VuMi1jcGcuYyAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2Nsay9y
ZW5lc2FzL3JjYXItZ2VuMy1jcGcuYyAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2RtYS9m
c2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmMgICAgICAgfCAgNyArKysrKystCj4gIGRyaXZlcnMv
ZG1hL3RpL2szLXBzaWwuYyAgICAgICAgICAgICAgICAgICAgICB8ICAzICsrKwo+ICBkcml2ZXJz
L2RtYS90aS9rMy11ZG1hLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYnJpZGdlL253bC1kc2kuYyAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVzb24vbWVzb25fZHJ2LmMgICAgICAgICAgICAgfCAgNCArKystCj4gIGRyaXZl
cnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kaXNwYy5jICAgICAgICAgICB8ICAyICstCj4gIGRyaXZl
cnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kcGkuYyAgICAgICAgICAgICB8ICA0ICsrKy0KPiAgZHJp
dmVycy9ncHUvZHJtL29tYXBkcm0vZHNzL2RzaS5jICAgICAgICAgICAgIHwgIDMgKysrCj4gIGRy
aXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kc3MuYyAgICAgICAgICAgICB8ICAzICsrKwo+ICBk
cml2ZXJzL2dwdS9kcm0vb21hcGRybS9kc3MvaGRtaTRfY29yZS5jICAgICAgfCAgMyArKysKPiAg
ZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vZHNzL3ZlbmMuYyAgICAgICAgICAgIHwgIDQgKysrLQo+
ICBkcml2ZXJzL2dwdS9kcm0vb21hcGRybS9vbWFwX2Rydi5jICAgICAgICAgICAgfCAgMyArKysK
PiAgZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMgICAgICAgIHwgIDQgKysr
LQo+ICBkcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2x2ZHMuYyAgICAgICAgICAgfCAgMiAr
LQo+ICBkcml2ZXJzL2dwdS9kcm0vdGlkc3MvdGlkc3NfZGlzcGMuYyAgICAgICAgICAgfCAgNCAr
KystCj4gIGRyaXZlcnMvaW9tbXUvaXBtbXUtdm1zYS5jICAgICAgICAgICAgICAgICAgICB8ICA3
ICsrKysrLS0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yY2FyLXZpbi9yY2FyLWNvcmUuYyAg
IHwgIDIgKy0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yY2FyLXZpbi9yY2FyLWNzaTIuYyAg
IHwgIDIgKy0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92c3AxL3ZzcDFfdWlmLmMgICAgICAg
IHwgIDQgKysrLQo+ICBkcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9jb3JlLmMgICAgICAg
ICAgfCAgMiArLQo+ICBkcml2ZXJzL21tYy9ob3N0L3JlbmVzYXNfc2RoaV9pbnRlcm5hbF9kbWFj
LmMgfCAgMiArLQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMgICAgICAgICAg
ICAgfCAyMSArKysrKysrKysrKysrKy0tLS0tCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb21h
cC5jICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfYW02
NTQuYyAgICAgICAgICAgICAgICB8ICAyICstCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlbmVz
YXMvcmF2Yl9tYWluLmMgICAgICB8ICA0ICsrKy0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkv
YW02NS1jcHN3LW51c3MuYyAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkv
Y3Bzdy5jICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkv
Y3Bzd19uZXcuYyAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9waHkvdGkvcGh5LW9tYXAt
dXNiMi5jICAgICAgICAgICAgICAgIHwgIDQgKysrLQo+ICBkcml2ZXJzL3BpbmN0cmwvcmVuZXNh
cy9jb3JlLmMgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL3BpbmN0cmwvcmVuZXNh
cy9wZmMtcjhhNzc5MC5jICAgICAgICAgfCAgNSArKysrLQo+ICBkcml2ZXJzL3BpbmN0cmwvcmVu
ZXNhcy9wZmMtcjhhNzc5NC5jICAgICAgICAgfCAgNSArKysrLQo+ICBkcml2ZXJzL3NvYy9mc2wv
ZHBpby9kcGlvLWRyaXZlci5jICAgICAgICAgICAgfCAxMyArKysrKysrKy0tLS0KPiAgZHJpdmVy
cy9zb2MvcmVuZXNhcy9yOGE3NzRjMC1zeXNjLmMgICAgICAgICAgIHwgIDUgKysrKy0KPiAgZHJp
dmVycy9zb2MvcmVuZXNhcy9yOGE3Nzk1LXN5c2MuYyAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJp
dmVycy9zb2MvcmVuZXNhcy9yOGE3Nzk5MC1zeXNjLmMgICAgICAgICAgIHwgIDUgKysrKy0KPiAg
ZHJpdmVycy9zb2MvdGkvazMtcmluZ2FjYy5jICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAg
ZHJpdmVycy9zdGFnaW5nL210NzYyMS1wY2kvcGNpLW10NzYyMS5jICAgICAgIHwgIDIgKy0KPiAg
ZHJpdmVycy90aGVybWFsL3JjYXJfZ2VuM190aGVybWFsLmMgICAgICAgICAgIHwgIDQgKysrLQo+
ICBkcml2ZXJzL3RoZXJtYWwvdGktc29jLXRoZXJtYWwvdGktYmFuZGdhcC5jICAgfCAxMCArKysr
KysrLS0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9yZW5lc2FzX3VzYjMuYyAgICAgICAgIHwg
IDIgKy0KPiAgZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRmb3JtLmMgICAgICAgICAgICAgIHwg
IDQgKysrLQo+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jICAgICAgICAgICAgICAgICAg
fCAgMiArLQo+ICBkcml2ZXJzL3dhdGNoZG9nL3JlbmVzYXNfd2R0LmMgICAgICAgICAgICAgICAg
fCAgMiArLQo+ICA0OCBmaWxlcyBjaGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgNTIgZGVsZXRp
b25zKC0pCj4gCgouLi4KCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3RpL2szLXVkbWEuYyBi
L2RyaXZlcnMvZG1hL3RpL2szLXVkbWEuYwo+IGluZGV4IDk2YWQyMTg2OWJhNy4uNTBhNGM4ZjA5
OTNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZG1hL3RpL2szLXVkbWEuYwo+ICsrKyBiL2RyaXZl
cnMvZG1hL3RpL2szLXVkbWEuYwo+IEBAIC01MTg4LDcgKzUxODgsNyBAQCBzdGF0aWMgaW50IHVk
bWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCXVkLT5tYXRjaF9kYXRh
ID0gbWF0Y2gtPmRhdGE7Cj4gIAo+ICAJc29jID0gc29jX2RldmljZV9tYXRjaChrM19zb2NfZGV2
aWNlcyk7Cj4gLQlpZiAoIXNvYykgewo+ICsJaWYgKCFJU19FUlIoc29jKSAmJiAhc29jKSB7Cgp0
aGlzIGRvZXMgbm90IHNvdW5kIHJpZ2h0Li4uCgppZiAoIXNvYyB8fCBJU19FUlIoc29jKSkKb3IK
aWYgKElTX0VSUl9PUl9OVUxMKHNvYykpCmlzIGV2ZW4gYmV0dGVyLgoKPiAgCQlkZXZfZXJyKGRl
diwgIk5vIGNvbXBhdGlibGUgU29DIGZvdW5kXG4iKTsKPiAgCQlyZXR1cm4gLUVOT0RFVjsKClRo
ZXJlIG1pZ2h0IGJlIGEgY2xldmVyIG1hY3JvIGZvciBpdCwgYnV0OgoKcmV0dXJuIHNvYyA/IFBU
Ul9FUlIoc29jKSA6IC1FTk9ERVY7Cgo+ICAJfQoKLS0gClDDqXRlcgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
