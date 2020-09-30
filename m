Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE0C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:48:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736E82074B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrROXhnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736E82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 15FBE2001C;
	Wed, 30 Sep 2020 05:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jYf+hOAu0bhV; Wed, 30 Sep 2020 05:48:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 265C82001F;
	Wed, 30 Sep 2020 05:48:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 039FCC0889;
	Wed, 30 Sep 2020 05:48:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59249C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 555AF84042
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r1YvUWH19iKW for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7BD7385168
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:48:52 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id u8so664137lff.1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sTlqCEGp37rQgxee6pjO54hL90cDz6DxVD42l2S1fWY=;
 b=WrROXhnNJZ43uGT8pW9Rnhr+LT9VvW+DFmVprWAhpR3nZMSv5vu9GOL1Ad0E+G4KL8
 G9Yjr+DlX/OqgZOOgX68ds3hbhEKVwbiI3UWVFx1/Hw2HN1yQMeS4WJ2c/F34LIcg6vc
 iLk25EcYpFZZKVTD1fQC7t2gGywRyzFj9AM29bPoXVn1jrN4dkggBousL1Goo+C626qL
 TzjuwG9rZbs2cFRPa/5hTElwVT+sDSIk2vQb5uyNnhHajwz7IKPw0SLwAC7qxaufOB4G
 hhj7UaY2v597eq8iq+wCCGRMIIeik1G1TK5sc2bmecIU/zv8QQ6nQjM/6Gesup59aA5S
 +NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sTlqCEGp37rQgxee6pjO54hL90cDz6DxVD42l2S1fWY=;
 b=K8Mfr4BZvckz+0Kivlden77CUdfqb1ZDS/v+66lHlEycOQ4mQ2rn9sygHQOJpaDp2W
 Nc3qfgMIHZwzwNyvJy6znO7/laqplAmjevCglKcgo0rBWyrrJzS10qcNjB0c+9swJd19
 TYwJn8kxq6G7dGr8wJRfrgMQwtUrn0DKsNxIfMxynVmo1nml1OMiQMPI0etfw2zTIJUh
 chZevdddpBpOiHiVcJrMDjc8mhO37RouT0MCS9glQi8FYN/NjFq+xBH0VFP11ShgTx2R
 g+v1slnevZ2M3DuGYrYJ/595SwalMgKmV6IQL06vsnfiHCVDpdJQIEP1t7lU1Wh6G4wY
 w+yA==
X-Gm-Message-State: AOAM533wdzpYtbzUqxbXIxw9dSy6Wig8bAj8h8A+Rz71yYcOSjG3VbVZ
 7taO1/wB+jKVloASxzokfv4=
X-Google-Smtp-Source: ABdhPJwIHrMGRrOWHIrTo+petVlBtwi5nTRuibwE2GQlD+fqVI+v+lUc38fkumcR4VVvfR5iahMuxg==
X-Received: by 2002:ac2:593b:: with SMTP id v27mr303325lfi.338.1601444930557; 
 Tue, 29 Sep 2020 22:48:50 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id l188sm63762lfd.127.2020.09.29.22.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:48:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <03710107-b6ad-5256-4550-09c610d0fded@gmail.com>
 <20200930053930.GD31821@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e5b9f269-3ddd-d4e5-de26-413414c3ccf2@gmail.com>
Date: Wed, 30 Sep 2020 08:48:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930053930.GD31821@Asurada-Nvidia>
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

MzAuMDkuMjAyMCAwODozOSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBTZXAg
MzAsIDIwMjAgYXQgMDg6MjQ6MDJBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAz
MC4wOS4yMDIwIDAzOjMwLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICsJLyoKPj4+ICsJ
ICogSU9NTVUgY29yZSBhbGxvd3MgLUVOT0RFViByZXR1cm4gdG8gY2Fycnkgb24uIFNvIGJ5cGFz
cyBhbnkgY2FsbAo+Pj4gKwkgKiBmcm9tIGJ1c19zZXRfaW9tbXUoKSBkdXJpbmcgdGVncmFfc21t
dV9wcm9iZSgpLCBhcyBhIGRldmljZSB3aWxsCj4+PiArCSAqIGNhbGwgaW4gYWdhaW4gdmlhIG9m
X2lvbW11X2NvbmZpZ3VyZSB3aGVuIGZ3c3BlYyBpcyBwcmVwYXJlZC4KPj4+ICsJICovCj4+PiAr
CWlmICghbWMtPnNtbXUgfHwgIWZ3c3BlYyB8fCBmd3NwZWMtPm9wcyAhPSAmdGVncmFfc21tdV9v
cHMpCj4+PiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsKPj4KPj4gVGhlICFtYy0+c21tdSBj
YW4ndCBiZSB0cnVlLgo+IAo+IEFyZSB5b3Ugc3VyZT8gSSBoYXZlIHJlbW92ZWQgdGhlICJtYy0+
c21tdSA9IHNtbXUiIGluIHByb2JlKCkgd2l0aAo+IHRoaXMgY2hhbmdlLiBTbyB0aGUgb25seSB0
aW1lICJtYy0+c21tdSA9PSAhTlVMTCIgaXMgYWZ0ZXIgcHJvYmUoKQo+IG9mIFNNTVUgZHJpdmVy
IGlzIHJldHVybmVkLiBBcyBteSBjb21tZW50cyBzYXlzLCB0ZWdyYV9zbW11X3Byb2JlKCkKPiBj
YWxscyBpbiB0aGlzIGZ1bmN0aW9uIHZpYSBidXNfc2V0X2lvbW11KCksIHNvIG1jLT5zbW11IGNh
biBiZSBOVUxMCj4gaW4gdGhpcyBjYXNlLgo+IAoKSSBtaXNzZWQgdGhhdC4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
