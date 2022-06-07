Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DEECCA47C
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 12:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97E69408D5;
	Tue,  7 Jun 2022 12:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlch6i4FQnqX; Tue,  7 Jun 2022 12:36:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55ACF401B7;
	Tue,  7 Jun 2022 12:36:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBCDC0032;
	Tue,  7 Jun 2022 12:36:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7ADBC002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 12:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F26C408D5
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 12:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tulez5ZmJRRS for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 12:36:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66479401B7
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 12:36:43 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id a184so9506639qkg.5
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 05:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jI9Eiy9NqYqthM/bM2aEWTmdS6Ov8FCqsQpj0jvzrm0=;
 b=bVA+a/OAxZiH9K5zw5uiXMvk2kyzjwqvOpVxZjigs5eNmspMu9muq0u8TjHCgNWqZ3
 2zYMHMZHJy6/uwZWpfZyHD+NdByaFcCrXnZCjZlc+dnU8CVzBoeY7IS+GYr5gsbfKvEN
 suw/n2kVEtrRm3mFisPtc9o9EYgKf31953qXMIZLEQAm0FKJLIQ5AILxQFeHzPDYPJGX
 1BqIxFwy6ycudH3pxBo13P62AE+G47hFeYpS5oAr9I3r2x8I66cKlpMHwUBj/SuUwJ7t
 TT76Qf1O1VWaCdKoID7XyVnZ/zseITBKoG87sdsbpm187+n01SxWnXADgV4StTvkdmh5
 xppg==
X-Gm-Message-State: AOAM531jCxUqie+GmRZ13mLdTl8TjtSGu+Ghtpop4a/af/Pj/9J5qd/M
 zhYnkmI4FTiSthw0OD2tQXnuiL9aMeuazA==
X-Google-Smtp-Source: ABdhPJyD6LTjhUqLUDKoac2BmGzgUyEnbZlsm7UTHIORQBPWvM9sZGOhcrr8MNoNFiNB1ZuwMt2R/A==
X-Received: by 2002:a05:620a:2889:b0:6a2:fa49:d9d1 with SMTP id
 j9-20020a05620a288900b006a2fa49d9d1mr18991310qkp.547.1654605401850; 
 Tue, 07 Jun 2022 05:36:41 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169]) by smtp.gmail.com with ESMTPSA id
 r12-20020ac8424c000000b00304dec6452csm8525280qtm.78.2022.06.07.05.36.40
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jun 2022 05:36:40 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id v22so30908979ybd.5
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 05:36:40 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr30887112ybh.36.1654605399923; Tue, 07
 Jun 2022 05:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-9-saravanak@google.com>
In-Reply-To: <20220526081550.1089805-9-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Jun 2022 14:36:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrTjjNcqro+FA0BPJ+rK3bCAX+boYdf5=ZvGGocVJPMw@mail.gmail.com>
Message-ID: <CAMuHMdXrTjjNcqro+FA0BPJ+rK3bCAX+boYdf5=ZvGGocVJPMw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 8/9] net: ipconfig: Force fw_devlink to unblock any
 devices that might probe
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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

SGkgU2FyYXZhbmEsCgpPbiBUaHUsIE1heSAyNiwgMjAyMiBhdCAxMDoxNiBBTSBTYXJhdmFuYSBL
YW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29tPiB3cm90ZToKPiBJZiB0aGVyZSBhcmUgbmV0d29y
ayBkZXZpY2VzIHRoYXQgY291bGQgcHJvYmUgd2l0aG91dCBzb21lIG9mIHRoZWlyCj4gc3VwcGxp
ZXJzIHByb2JpbmcgYW5kIHRob3NlIG5ldHdvcmsgZGV2aWNlcyBhcmUgbmVlZGVkIGZvciBJUCBh
dXRvCj4gY29uZmlnIHRvIHdvcmssIHRoZW4gZndfZGV2bGluaz1vbiBtaWdodCBicmVhayB0aGF0
IHVzZWNhc2UgYnkgYmxvY2tpbmcKPiB0aGUgbmV0d29yayBkZXZpY2VzIGZyb20gcHJvYmluZyBi
eSB0aGUgdGltZSBJUCBhdXRvIGNvbmZpZyBzdGFydHMuCj4KPiBTbywgd2hlbiBJUCBhdXRvIGNv
bmZpZyBpcyBlbmFibGVkLCBtYWtlIHN1cmUgZndfZGV2bGluayBkb2Vzbid0IGJsb2NrCj4gdGhl
IHByb2Jpbmcgb2YgYW55IGRldmljZSB0aGF0IGhhcyBhIGRyaXZlciBieSB0aGUgdGltZSB3ZSBn
ZXQgdG8gSVAKPiBhdXRvIGNvbmZpZy4KPgo+IFNpZ25lZC1vZmYtYnk6IFNhcmF2YW5hIEthbm5h
biA8c2FyYXZhbmFrQGdvb2dsZS5jb20+Cj4gLS0tCj4gIG5ldC9pcHY0L2lwY29uZmlnLmMgfCAy
ICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9u
ZXQvaXB2NC9pcGNvbmZpZy5jIGIvbmV0L2lwdjQvaXBjb25maWcuYwo+IGluZGV4IDlkNDFkNWQ1
Y2QxZS4uYWE3YjhiYTY4Y2E2IDEwMDY0NAo+IC0tLSBhL25ldC9pcHY0L2lwY29uZmlnLmMKPiAr
KysgYi9uZXQvaXB2NC9pcGNvbmZpZy5jCj4gQEAgLTE0MzUsNiArMTQzNSw4IEBAIHN0YXRpYyBp
bnQgX19pbml0IHdhaXRfZm9yX2RldmljZXModm9pZCkKPiAgewo+ICAgICAgICAgaW50IGk7Cj4K
PiArICAgICAgIGZ3X2RldmxpbmtfdW5ibG9ja19tYXlfcHJvYmUoKTsKPiArCj4gICAgICAgICBm
b3IgKGkgPSAwOyBpIDwgREVWSUNFX1dBSVRfTUFYOyBpKyspIHsKPiAgICAgICAgICAgICAgICAg
c3RydWN0IG5ldF9kZXZpY2UgKmRldjsKPiAgICAgICAgICAgICAgICAgaW50IGZvdW5kID0gMDsK
CkZUUiwgdGhpcyBsYWNrcyBhbiBpbmNsdWRlIDxsaW51eC9md25vZGUuaD4sIGFzIG15IG1pcHMg
cmJ0eDQ5MjcKYnVpbGQgZmFpbHMgd2l0aDoKCm5ldC9pcHY0L2lwY29uZmlnLmM6MTQzODoyOiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24K4oCYZndfZGV2bGlua191bmJs
b2NrX21heV9wcm9iZeKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0K
ClN3aXRjaGluZyB0byB2MiBpbnN0ZWFkLi4uCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAg
ICAgICAgICAgICAgICAgIEdlZXJ0CgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBs
b3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJz
b25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBh
IGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
