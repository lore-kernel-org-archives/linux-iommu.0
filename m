Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB8C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 12:09:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5253861262
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 12:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5253861262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AEF640333;
	Wed, 15 Sep 2021 12:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VC1SCOfR6dBW; Wed, 15 Sep 2021 12:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C1F26401F8;
	Wed, 15 Sep 2021 12:09:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0C12C000F;
	Wed, 15 Sep 2021 12:09:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81645C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 12:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E427401C8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 12:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K9q6nZCO-is1 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 12:09:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55D6F400FE
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 12:09:52 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id s12so772368ljg.0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nsbC/14C+kMeJoOAkh98qBGl2wGnLGSFlhXpNUqwCFE=;
 b=LhPdYdNBwz8NgzDrN2yfcZ22U38rnPVJDJATIRjG63cwjSqJeLcOJ7rb7Mqkfcwr33
 3/auLAlxO62WVV4QiDO2Df8ksHGq6u9HEH3oLpPwx4Cq9Qj5dUy22XthraTolzPolOaJ
 E96kLqsddIYf83sJUP/zJ5eyEXN+fxcw2imlkHqzTrIeUZsdad/E3q0cC2y9z5UUqlI5
 ifZGau8FbHZDNZXkRREq1RuEUHjYLqRrIEK/pF3SQczPs6bpDrNI64nHDcCj81CzN4Na
 aEB1HaqB8+/GWyI0+TrO8Fh4E1l5bJCHLuFwLvlPKH5nysZxgvKVRb9jvMnVkARREFoB
 MD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nsbC/14C+kMeJoOAkh98qBGl2wGnLGSFlhXpNUqwCFE=;
 b=PgdO8HOEaxrn2MpcC/rQi5Y850PyEdclaVsZ8RsqlSHiP7w+N2l0F9ANhOdbH0yQaj
 bf0z8asUzyCe21h7USbI1VgJAnnffMlCdU3qa6fWk+f8TxQrRa7ZVRqc2Gcvvwurg1jY
 tRJL/p1NR1s7iwFzMrYmoX42JkZ1uH6fOkntO+Cgu2ms+6N8FpLin/bwfmOHALh1m+TT
 4rWXrsY0J06QWXL0WiCF97zKD8wJdhXkExEFIy2WMf3ZvM01dAWKQ1PGiWTTw1I3/V51
 CO7P5qdap4pmy0QCWJ2ee29q228oOOdRI/gCIQc3jmXtQ/5u6xBaDDKPPKgTZ+HaWNk3
 hNIw==
X-Gm-Message-State: AOAM530ESR7ALjEd8TOFp97srVmZ4Z9nj9dJPJwcDBckcKhO/CSLAjRG
 8vqisxIj12vK7hQhplbcw0I=
X-Google-Smtp-Source: ABdhPJzOIae3cS6tf91ZADkHw1B21IDeEToB3I4V6VKYcoxN7S0aHhdx0UnbwyEdNqZF0e1u7b1E9g==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr18646458ljh.437.1631707789844; 
 Wed, 15 Sep 2021 05:09:49 -0700 (PDT)
Received: from [192.168.2.145] (94-29-62-67.dynamic.spd-mgts.ru. [94.29.62.67])
 by smtp.googlemail.com with ESMTPSA id u16sm1798222ljl.9.2021.09.15.05.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 05:09:49 -0700 (PDT)
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
 <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
 <20210914184933.GA32705@Asurada-Nvidia>
 <25d68aff-323a-df54-45f9-55b22f3089e0@gmail.com>
 <20210915043806.GA19185@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a5a77169-8711-2983-d2cb-4b94061741b9@gmail.com>
Date: Wed, 15 Sep 2021 15:09:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210915043806.GA19185@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

MTUuMDkuMjAyMSAwNzozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVHVlLCBTZXAg
MTQsIDIwMjEgYXQgMTA6MjA6MzBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAx
NC4wOS4yMDIxIDIxOjQ5LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9uIFR1ZSwgU2Vw
IDE0LCAyMDIxIGF0IDA0OjI5OjE1UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+
PiAxNC4wOS4yMDIxIDA0OjM4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+Pj4gK3N0YXRp
YyB1bnNpZ25lZCBsb25nIHBkX3B0X2luZGV4X2lvdmEodW5zaWduZWQgaW50IHBkX2luZGV4LCB1
bnNpZ25lZCBpbnQgcHRfaW5kZXgpCj4+Pj4+ICt7Cj4+Pj4+ICsJcmV0dXJuICgoZG1hX2FkZHJf
dClwZF9pbmRleCAmIChTTU1VX05VTV9QREUgLSAxKSkgPDwgU01NVV9QREVfU0hJRlQgfAo+Pj4+
PiArCSAgICAgICAoKGRtYV9hZGRyX3QpcHRfaW5kZXggJiAoU01NVV9OVU1fUFRFIC0gMSkpIDw8
IFNNTVVfUFRFX1NISUZUOwo+Pj4+PiArfQo+Pj4+Cj4+Pj4gV2Uga25vdyB0aGF0IElPVkEgaXMg
Zml4ZWQgdG8gdTMyIGZvciB0aGlzIGNvbnRyb2xsZXIuIENhbiB3ZSBhdm9pZCBhbGwKPj4+PiB0
aGVzZSBkbWFfYWRkcl90IGNhc3RpbmdzPyBJdCBzaG91bGQgbWFrZSBjb2RlIGNsZWFuZXIgYSB0
YWQsIElNTy4KPj4+Cj4+PiBUZWdyYTIxMCBhY3R1YWxseSBzdXBwb3J0cyAzNC1iaXQgSU9WQS4u
Lgo+Pj4KPj4KPj4gSXQgZG9lc24ndC4gMzQtYml0IGlzIFBBLCAzMi1iaXQgaXMgVkEuCj4+Cj4+
IFF1b3RlIGZyb20gVDIxMCBUUk06Cj4+Cj4+ICJUaGUgU01NVSBpcyBhIGNlbnRyYWxpemVkIHZp
cnR1YWwtdG8tcGh5c2ljYWwgdHJhbnNsYXRpb24gZm9yIE1TUy4gSXQKPj4gbWFwcyBhIDMyLWJp
dCB2aXJ0dWFsIGFkZHJlc3MgdG8gYSAzNC1iaXQgcGh5c2ljYWwgYWRkcmVzcy4gSWYgdGhlCj4+
IGNsaWVudCBhZGRyZXNzIGlzIDQwIGJpdHMgdGhlbiBiaXRzIDM5OjMyIGFyZSBpZ25vcmVkLiIK
PiAKPiBJZiB5b3Ugc2Nyb2xsIGRvd24gYnkgYSBjb3VwbGUgb2Ygc2VjdGlvbnMsIHlvdSBjYW4g
c2VlIDM0LWJpdAo+IHZpcnR1YWwgYWRkcmVzc2VzIGluIHNlY3Rpb24gMTguNi4xLjI7IGFuZCBp
ZiBjaGVja2luZyBvbmUgQVNJRAo+IHJlZ2lzdGVyLCB5b3UgY2FuIHNlZSBpdCBtZW50aW9uIHRo
ZSBleHRyYSB0d28gYml0cyB2YVszMzozMl0uCgpUaGFua3MgZm9yIHRoZSBwb2ludGVyLiBJdCBz
YXlzIHRoYXQgb25seSBjZXJ0YWluIG1lbW9yeSBjbGllbnRzIGFsbG93CnRvIGNvbWJpbmUgNCBB
U0lEcyB0byBmb3JtIDM0Yml0IFZBIHNwYWNlLiBJbiB0aGlzIGNhc2UgdGhlIFBBIHNwYWNlIGlz
CnNwbGl0IGludG8gNEdCIGFyZWFzIGFuZCB0aGVyZSBhcmUgYWRkaXRpb25hbCBiaXRmaWVsZHMg
d2hpY2ggY29uZmlndXJlCnRoZSBBU0lEIG1hcHBpbmcgb2YgZWFjaCA0R0IgYXJlYS4gU3RpbGwg
ZWFjaCBBU0lEIGlzIDMyYml0LgoKVGhpcyBpcyB3aGF0IFRSTSBzYXlzOgoKIkZvciB0aGUgR1BV
IGFuZCBvdGhlciBjbGllbnRzIHdpdGggMzQtYml0IGFkZHJlc3MgaW50ZXJmYWNlcywgdGhlIEFT
SUQKcmVnaXN0ZXJzIGFyZSBleHRlbmRlZCB0byBwb2ludCB0byBmb3VyIEFTSURzLiBUaGUgU01N
VSBzdXBwb3J0cyA0R0Igb2YKdmlydHVhbCBhZGRyZXNzIHNwYWNlIHBlciBBU0lELCBzbyBtYXBw
aW5nIGFkZHJbMzM6MzJdIGludG8gQVNJRFsxOjBdCmV4dGVuZHMgdGhlIHZpcnR1YWwgYWRkcmVz
cyBzcGFjZSBvZiBhIGNsaWVudCB0byAxNkdCLiIKCj4gSG93ZXZlciwgdGhlIGRyaXZlciBjdXJy
ZW50bHkgc2V0cyBpdHMgZ2VvbWV0cnkuYXBlcnR1cmVfZW5kIHRvCj4gMzItYml0LCBhbmQgd2Ug
Y2FuIG9ubHkgZ2V0IDMyLWJpdCBJT1ZBcyB1c2luZyBQREUgYW5kIFBURSBvbmx5LAo+IHNvIEkg
dGhpbmsgaXQgc2hvdWxkIGJlIHNhZmUgdG8gcmVtb3ZlIHRoZSBjYXN0aW5ncyBoZXJlLiBJJ2xs
Cj4gd2FpdCBmb3IgYSBjb3VwbGUgb2YgZGF5cyBhbmQgc2VlIGlmIHRoZXJlJ2QgYmUgb3RoZXIg
Y29tbWVudHMKPiBmb3IgbWUgdG8gYWRkcmVzcyBpbiBuZXh0IHZlcnNpb24uCgpZb3Ugd2lsbCBu
ZWVkIHRvIHJlYWQgdGhlIHNwZWNpYWwgIkFTSUQgQXNzaWdubWVudCBSZWdpc3RlciIgd2hpY2gK
c3VwcG9ydHMgNCBzdWItQVNJRHMgdG8gdHJhbnNsYXRlIHRoZSBQQSBhZGRyZXNzIGludG8gdGhl
IGFjdHVhbCBWQS4gQnkKZGVmYXVsdCBhbGwgY2xpZW50cyBhcmUgbGltaXRlZCB0byBhIHNpbmds
ZSBBU0lEIGFuZCB1cHN0cmVhbSBrZXJuZWwKZG9lc24ndCBzdXBwb3J0IHByb2dyYW1taW5nIG9m
IDM0Yml0IFZBcy4gU28gZG9lc24ndCB3b3J0aCB0aGUgZWZmb3J0IHRvCmZ1bGx5IHRyYW5zbGF0
ZSB0aGUgVkEsIElNTy4KCj4+IEV2ZW4gaWYgaXQgc3VwcG9ydGVkIG1vcmUgdGhhbiAzMmJpdCwg
dGhlbiB0aGUgcmV0dXJuZWQgdWxvbmcgaXMgMzJiaXQsCj4+IHdoaWNoIGRvZXNuJ3QgbWFrZSBz
ZW5zZS4KPiAKPiBPbiBBUk02NCAoVGVncmEyMTApLCBpc24ndCB1bG9uZyA2NC1iaXQ/CgpZZXMs
IGluZGVlZC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
