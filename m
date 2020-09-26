Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39676C2D0A8
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 21:38:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D2623719
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 21:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNHTmFzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D2623719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97B0E1FD90;
	Sat, 26 Sep 2020 21:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgWWfdBi-RbP; Sat, 26 Sep 2020 21:38:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B86431FC71;
	Sat, 26 Sep 2020 21:38:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BAF4C0889;
	Sat, 26 Sep 2020 21:38:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B203EC0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A6AB48672B
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hAUiVGUgqIpz for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 21:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C2F0B86712
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 21:37:59 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id b22so6712746lfs.13
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2O1+q9UmEqA1AfayXwYwEqLOHYTG6dlJa8oak1VIgDg=;
 b=vNHTmFzgH8QnV/FBqlopnm5inoooP9qzVr2IXPxHTgDN2tFGmDFkEMh8hkm1NtKQOx
 qjDI8CZtUreR7RPIXjRH1T7UP+9fsnb2Vt/8WhMl6tDdqjNyHSGOMzSa6nDrznC2v0Qe
 gP6WEJiH3n5APBzpziMK14F1ORCoymwCQCjQZRAMXnYerm9NkGLPFm1Ay5j+nFlRWMdB
 6jtXfs4M3a8b4A7MsnX9zKTzuLsMnPsRvuLaG4YLztx+Tuhqkezwv6Db3trx+pykpnOL
 VdO1c4AfB+EHg5KFGd3RawjL6uYlce1C52KkS7v+8n7mFGrlKSyl+ebVSyUhjB3jSjVJ
 /vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2O1+q9UmEqA1AfayXwYwEqLOHYTG6dlJa8oak1VIgDg=;
 b=ulg8lhue5NvVFW/qPCpZr3OZAHAubYg6Ke8nvyWyp2PIcXQHP5ptkk7pTW1/rOb8FK
 QwGbNR8EnHFZBlNM0ErxWTrD8HFKIzJwSBv6EJmmL2gX38hROn0gmT0lVTzySxzWaYzt
 jwcYEJHaj9DMiItsdEBjWe+IsfShLe5USqVA0WRXahRgZ6RMYDAphYcgMRczIo0UhS8H
 6+dK06v9Vak1aIdqm7qUmOqoEYEaz4wLfwmQ/PV6lUs1/p4ylh5mM+0BloDukva6EPUy
 C3Aq2RZWmiyHRetfAU0agj5wVzBpTb9K6DurOIPxChbFPY23Sx+p7vIt/O2ctC5F16eY
 G0jQ==
X-Gm-Message-State: AOAM533SsIJmJNinS6bChsaENp9/P/mjPnfdRaFUyri0l8BdDlxMqwQG
 GMXbbb6jS5Ldtr7sm8BwbH4=
X-Google-Smtp-Source: ABdhPJwRrZKVmTy09whw7BIXlDF16kk6a09TKGUIpAzZpY2JnQIP3AhMgrN+BYta2GoMOzzDhdgeQA==
X-Received: by 2002:ac2:5e2e:: with SMTP id o14mr1630604lfg.163.1601156277884; 
 Sat, 26 Sep 2020 14:37:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id a27sm5424327ljp.7.2020.09.26.14.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 14:37:57 -0700 (PDT)
Subject: Re: [PATCH 5/5] iommu/tegra-smmu: Add pagetable mappings to debugfs
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-6-nicoleotsuka@gmail.com>
 <0451e362-30eb-2ba2-33f1-e9ab3972cada@gmail.com>
Message-ID: <a321fc27-54ba-9ba5-7121-4598a7f94795@gmail.com>
Date: Sun, 27 Sep 2020 00:37:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0451e362-30eb-2ba2-33f1-e9ab3972cada@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

MjcuMDkuMjAyMCAwMDoyNCwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjYuMDkuMjAy
MCAxMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gLi4uCj4+ICsJZm9yIChwZF9pbmRl
eCA9IDA7IHBkX2luZGV4IDwgU01NVV9OVU1fUERFOyBwZF9pbmRleCsrKSB7Cj4+ICsJCXN0cnVj
dCBwYWdlICpwdDsKPj4gKwkJdTMyICphZGRyOwo+PiArCj4+ICsJCWlmICghYXMtPmNvdW50W3Bk
X2luZGV4XSB8fCAhcGRbcGRfaW5kZXhdKQo+PiArCQkJY29udGludWU7Cj4gCj4gSSBndWVzcyB0
aGUgaWRlYSBvZiB0aGlzIHBhdGNoIGlzIHRvIHByaW50IG91dCB0aGUgaGFyZHdhcmUgc3RhdGUs
IGlzbid0Cj4gaXQ/IEhlbmNlIHRoZSBhcy0+Y291bnQgc2hvdWxkbid0IGJlIGNoZWNrZWQgaGVy
ZS4KClBlcmhhcHMgYWxzbyB3aWxsIGJlIGdvb2QgdG8gY2hlY2sgd2hldGhlciB0aGUgc3RhdGUg
b2YKIWFzLT5jb3VudFtwZF9pbmRleF0gbWF0Y2hlcyBzdGF0ZSBvZiAhcGRbcGRfaW5kZXhdLgoK
V0FSTl9PTl9PTkNFKCFhcy0+Y291bnRbcGRfaW5kZXhdIF4gIXBkW3BkX2luZGV4XSkKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
