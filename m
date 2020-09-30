Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E00C47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FD120759
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qny78H6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5F955204D8;
	Wed, 30 Sep 2020 15:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9JMIu3UzBecF; Wed, 30 Sep 2020 15:27:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 65207204E4;
	Wed, 30 Sep 2020 15:27:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E2BC0890;
	Wed, 30 Sep 2020 15:27:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4811C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9F32A204E4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bf2PeCi3n78D for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 15:27:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 0EB5520419
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:27:04 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id s205so1948828lja.7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=avlcz2uYKx1b+VN55Q6AvBFDNm1omKfFEfcGhuPQHCM=;
 b=Qny78H6XMz7lcxvDWiKZ+PwEbQfZI29OOhR2pp5WDOr703oXokC9aSWPUCz7uAiYtn
 5KQDtczgPxw4u4WLrFHgU53BM7V98/W59BoVxz52lX/B4q9V1iS1fuKU/D5aTHpdJepu
 t6VjIzYsgqJcsT+zAIP9cC1TvaM/vaXo/rRJrdW0t2j2TpS9hUbZ4invhNItntIOPjcP
 Wl/AtNk6489vzRarbS+lyM4hP+M/4zMBseuq3KBK7FWjGzMHT8uoW0x3MBy0YVTP1O9R
 E+Ez17z9qIgsO75viR3Hy53SNBtUGdBYEoAWMc+1VemYFRsSO91WjaGYD7oYZtiR0U5j
 BgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=avlcz2uYKx1b+VN55Q6AvBFDNm1omKfFEfcGhuPQHCM=;
 b=gi3c7FiwH3ZVDTxMf5bX96V8dq+RZg61bM3qCkIQ8FY6yg30t25BlA2vJEDiN9jAkM
 LvG1iKf4P0DpFOZLuQYQ4gc60WWYMElJJzIuHQUiFDGpjXv2ulckMOWoqrbl1tYibk6R
 z6Uqj8fGM+2Gy0xKrWE6QGcoHg7krPcu6lBC/tP++meoj1N4IF5fajtNEHa7UF/6VsN6
 cVRKMaJ6/OnPMjwj5/bL9cQQR1rxQTI+DoJyazQdL1DGVgbYFGMcLkNCuybB/hY7hUJ+
 yqtW3xN1r3lXs07DQIpCIBXyHTXwkZyJQ/D8oDvGPEa2IZikRK447iHdNgDFG6OrBNrC
 dzwQ==
X-Gm-Message-State: AOAM532A86k6/YNRkNcCT77LfUAS9v3n5ojyx9LXqHTKncZQ0XLYxYYS
 YUpOcHHzY9IUdXZemfl6mmk=
X-Google-Smtp-Source: ABdhPJxMvgL735tNkm0Fw3/FcRPsu/0e29fGVpKIGpyWEiEk7KdQWJlF8NOR/VUpnD4yoVkeZuTa6w==
X-Received: by 2002:a2e:b178:: with SMTP id a24mr943806ljm.276.1601479622062; 
 Wed, 30 Sep 2020 08:27:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id l29sm227634lfp.11.2020.09.30.08.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 08:27:01 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Thierry Reding <thierry.reding@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f1658651-e3e1-388a-1d4c-a7fe04b27251@gmail.com>
Date: Wed, 30 Sep 2020 18:27:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930152320.GA3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAxODoyMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBXZWQsIFNl
cCAzMCwgMjAyMCBhdCAwMTo0Mjo1NkFNIC0wNzAwLCBOaWNvbGluIENoZW4gd3JvdGU6Cj4+IEZy
b206IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KPj4KPj4gTXVsdGlwbGUgVGVn
cmEgZHJpdmVycyBuZWVkIHRvIHJldHJpZXZlIE1lbW9yeSBDb250cm9sbGVyIGFuZCBoZW5jZSB0
aGVyZQo+PiBpcyBxdWl0ZSBzb21lIGR1cGxpY2F0aW9uIG9mIHRoZSByZXRyaWV2YWwgY29kZSBh
bW9uZyB0aGUgZHJpdmVycy4gTGV0J3MKPj4gYWRkIGEgbmV3IGNvbW1vbiBoZWxwZXIgZm9yIHRo
ZSByZXRyaWV2YWwgb2YgdGhlIE1DLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVu
a28gPGRpZ2V0eEBnbWFpbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmlj
b2xlb3RzdWthQGdtYWlsLmNvbT4KPj4gLS0tCj4+Cj4+IENoYW5nZWxvZwo+PiB2Mi0+djM6Cj4+
ICAqIFJlcGxhY2VkIHdpdGggRGltdHJ5J3MgZGV2bV90ZWdyYV9nZXRfbWVtb3J5X2NvbnRyb2xs
ZXIoKQo+PiB2MS0+djI6Cj4+ICAqIE4vQQo+Pgo+PiAgZHJpdmVycy9tZW1vcnkvdGVncmEvbWMu
YyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgaW5jbHVk
ZS9zb2MvdGVncmEvbWMuaCAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDU2IGluc2VydGlvbnMoKykKPiAKPiBMZXQncyBub3QgYWRkIHRoaXMgaGVscGVyLCBw
bGVhc2UuIElmIGEgZGV2aWNlIG5lZWRzIGEgcmVmZXJlbmNlIHRvIHRoZQo+IG1lbW9yeSBjb250
cm9sbGVyLCBpdCBzaG91bGQgaGF2ZSBhIHBoYW5kbGUgdG8gdGhlIG1lbW9yeSBjb250cm9sbGVy
IGluCj4gZGV2aWNlIHRyZWUgc28gdGhhdCBpdCBjYW4gYmUgbG9va2VkIHVwIGV4cGxpY2l0bHku
Cj4gCj4gQWRkaW5nIHRoaXMgaGVscGVyIGlzIG9mZmljaWFsbHkgc2FuY3Rpb25pbmcgdGhhdCBp
dCdzIG9rYXkgbm90IHRvIGhhdmUKPiB0aGF0IHJlZmVyZW5jZSBhbmQgdGhhdCdzIGEgYmFkIGlk
ZWEuCgpNYXliZSB0aGF0J3MgYmVjYXVzZSB0aGUgcmVmZXJlbmNlIGlzbid0IHJlYWxseSBuZWVk
ZWQgZm9yIHRoZSBsb29rdXA/IDopCgpTZWNvbmRseSwgd2UgY291bGQgdXNlIHRoZSByZWZlcmVu
Y2UgYW5kIHRoZW4gZmFsbCBiYWNrIHRvIHRoZQpvZi1tYXRjaGluZyBmb3IgZGV2aWNlcyB0aGF0
IGRvbid0IGhhdmUgdGhlIHJlZmVyZW5jZSwgbGlrZSBhbGwgVGVncmEyMApkZXZpY2VzICsgVGVn
cmEzMC8xMjQgQUNUTU9OIGRldmljZXMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
