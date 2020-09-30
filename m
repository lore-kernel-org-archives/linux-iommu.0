Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A85C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:31:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C720E207C3
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fan3qd6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C720E207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80D4484F12;
	Wed, 30 Sep 2020 07:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nc3efFC4q1j5; Wed, 30 Sep 2020 07:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6E57084EAD;
	Wed, 30 Sep 2020 07:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50943C016F;
	Wed, 30 Sep 2020 07:31:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B125C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2907A84F12
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iUvUbPJdpFi for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 07:31:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1882A84EAD
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:31:39 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id b12so904709lfp.9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SGO2NZQ83mZVSNOizDUSniAn+rBNIh90Przur6itDd8=;
 b=Fan3qd6TBFqgoYlbCgxq0HtITaSK4cpNUMlfGMYYKjbDmxl0TkLyPLN2/vE8s6eq3S
 Vt18W2ziFdKm6w5eDliw9VY+x4t5Wx69zEMPX6V6XoTMcAFKQ3GffIt6Dtku32O1SkQw
 91mYdUvIww+E63p2SWh9CU4ZGt8q2JD/3c5Er6UNnSTNvAPmlJu+9o/HEi+MymPUKlXs
 LGEKj3votjVHLNZ2agZ/xnMMlG14ch92/p8PnN9f0PFcbl/2kJTiHRyHmliAc5V3ZM3X
 bZ9xUtW0HcAHOi/ZQ69j4GD08yRJz0HVWrsVR/u5kQ5eIEfpJT1nGnVjfguSeopXXF05
 n3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SGO2NZQ83mZVSNOizDUSniAn+rBNIh90Przur6itDd8=;
 b=DNCoAwvtAPNBgCD8av/9QHQGtrGzCE/S4e3Q5r1HLS3vaw3qQyiAPfjSS7zuT7gREY
 p080z6g4YuliMQcx/d/9Szi3RXR0tUqqyJcX51jXfD/9I5uqV0p6D/MHBkJsNXf6muLZ
 a7XMDNNhkZa0VhmjgtC3CcmPHRNS3+WhPdINJg/L9quy9JQtH63aDIKlM5hNm6/bG/2O
 FUW+8msoA2kdLzLGMGPilshFiYtDEWkuP9lOfUBDQuQc8AbdYm+oQENLFIRoWxDppdCq
 jkARGrSXigfmONFZTN/OB5OLKQh3CcU37Lh9TVzK1KKzFU0J24AvXxPyW3Nzfc8Hcyxg
 qY0g==
X-Gm-Message-State: AOAM530D/zFzSnP7iC4swJfWhMAHttQFzAA/2HfZ+86F5tTWeuq6DeFL
 +Eg5AQt+KW5ssqknjKT7lRI=
X-Google-Smtp-Source: ABdhPJyQqUXR6tmLauIulzo2x4C8Vf0e5lddBc1ZH/i32Csp4UkDO+xG7Ug15AKoPIN4RwmY0CgLgA==
X-Received: by 2002:a19:402:: with SMTP id 2mr397312lfe.279.1601451097259;
 Wed, 30 Sep 2020 00:31:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id h124sm90415lfd.151.2020.09.30.00.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 00:31:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
 <93803d8b-9863-e977-fa87-a03e877b095d@gmail.com>
 <20200930054455.GF31821@Asurada-Nvidia>
 <2f752179-5ad3-c000-8794-494c79f7b21f@gmail.com>
 <20200930063820.GD16460@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a613dac4-1a7e-54b3-02da-4aedc673ecfb@gmail.com>
Date: Wed, 30 Sep 2020 10:31:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930063820.GD16460@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAwOTozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBTZXAg
MzAsIDIwMjAgYXQgMDk6MzI6MjBBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAz
MC4wOS4yMDIwIDA4OjQ0LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9uIFdlZCwgU2Vw
IDMwLCAyMDIwIGF0IDA4OjEyOjEwQU0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+
PiAzMC4wOS4yMDIwIDAzOjMwLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+PiAuLi4KPj4+
Pj4gIGludCB0ZWdyYV9tY193cml0ZV9lbWVtX2NvbmZpZ3VyYXRpb24oc3RydWN0IHRlZ3JhX21j
ICptYywgdW5zaWduZWQgbG9uZyByYXRlKTsKPj4+Pj4gIHVuc2lnbmVkIGludCB0ZWdyYV9tY19n
ZXRfZW1lbV9kZXZpY2VfY291bnQoc3RydWN0IHRlZ3JhX21jICptYyk7Cj4+Pj4+ICtzdHJ1Y3Qg
dGVncmFfbWMgKnRlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcih2b2lkKTsKPj4+Pj4gIAo+Pj4+
PiAgI2VuZGlmIC8qIF9fU09DX1RFR1JBX01DX0hfXyAqLwo+Pj4+Pgo+Pj4+Cj4+Pj4gVGhpcyB3
aWxsIGNvbmZsaWN0IHdpdGggdGhlIHRlZ3JhMjAtZGV2ZnJlcSBkcml2ZXIsIHlvdSBzaG91bGQg
Y2hhbmdlIGl0Cj4+Pj4gYXMgd2VsbC4KPj4+Cj4+PiBXaWxsIHJlbW92ZSB0aGF0IGluIHYzLgo+
Pj4KPj4+IFRoYW5rcwo+Pj4KPj4KPj4gUGxlYXNlIGFsc28gY29uc2lkZXIgdG8gYWRkIGEgcmVz
b3VyY2UtbWFuYWdlZCB2YXJpYW50LCBzaW1pbGFyIHRvIHdoYXQKPj4gSSBkaWQgaGVyZToKPj4K
Pj4gaHR0cHM6Ly9naXRodWIuY29tL2dyYXRlLWRyaXZlci9saW51eC9jb21taXQvMjEwNWU3NjY0
MDYzNzcyZDcyZmVmZTk2OTZiZGFiMGI2ODhiOWRlMgo+Pgo+PiBJIHdhcyBnb2luZyB0byB1c2Ug
aXQgaW4gdGhlIG5leHQgaXRlcmF0aW9uIG9mIHRoZSBtZW1vcnkgaW50ZXJjb25uZWN0Cj4+IHNl
cmllcy4KPj4KPj4gQnV0IG5vdyBpdCBhbHNvIHdpbGwgYmUgZ29vZCBpZiB5b3UgY291bGQgYWRk
IHRoZSBkZXZtIHZhcmlhbnQgdG8geW91cnMKPj4gU01NVSBwYXRjaHNldCBzaW5jZSB5b3UncmUg
YWxyZWFkeSBhYm91dCB0byB0b3VjaCB0aGUgdGVncmEyMC1kZXZmcmVxCj4+IGRyaXZlci4gSSds
bCB0aGVuIHJlYmFzZSBteSBwYXRjaGVzIG9uIHRvcCBvZiB5b3VycyBwYXRjaC4KPiAKPiBKdXN0
IHNhdyB0aGlzIHJlcGx5LiBZZWEsIEkgdGhpbmsgdGhpcydkIGJlIGJldHRlci4gVGhhbmtzCj4g
CgpQbGVhc2UgZG9uJ3QgZm9yZ2V0IHRvIGFkZCBhIHN0dWIgZm9yICFNQyBhcyB3ZWxsIHNpbmNl
IGRldmZyZXEgZHJpdmVycwp1c2UgQ09NUElMRV9URVNUIGFuZCBkb24ndCBkaXJlY3RseSBkZXBl
bmQgb24gdGhlIE1DIGRyaXZlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
