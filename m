Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C866C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:58:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA7620719
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMFQfuv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA7620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 36F0C84BC1;
	Fri,  2 Oct 2020 14:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CO31L4fiGv-S; Fri,  2 Oct 2020 14:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6E27084949;
	Fri,  2 Oct 2020 14:58:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57AEAC016F;
	Fri,  2 Oct 2020 14:58:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62483C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 587DC8733B
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ahpRfqLpWjX1 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 14:58:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4DAE087317
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 14:58:32 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id w11so2242244lfn.2
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=POx9xNcyZ1bKEH/Nadf1rvAFo4+ruSQ7V+OZSsyFX6g=;
 b=TMFQfuv0Qh0lLdh0vVjIQO+fdxv6cHJnhKY7+CWPxva3rdoMWV89Fk+t2WRk98Qr+U
 p9hv7jTprDfzqtCTWDqp7ReSuhWBmV+JlhXeFboJPToOk8t0TA3NkgP7eKAh7cMh74QA
 Pp5oDp3WGUGSjjjBVClx3y96ZWnOEo3lX6oT0Q/HFpXnTIYQzKY6hc9n9xhgHOkzR++g
 DJmGig8VdFzKtK7MCgXugCSOwAJ46y0c3awG2DXdlsE4w+voPjrc8kah+brF30PMTCW3
 ZFUsjgSaO8iZSWk/Hcqje69IAASY/6YUtwiZMMYrD093WyKlRmICzFOPUZ8SlcN3KJjN
 +W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=POx9xNcyZ1bKEH/Nadf1rvAFo4+ruSQ7V+OZSsyFX6g=;
 b=HuNVfi9E+7DOUI1pQf+9+NSltWlOrzKXm58q5h3sR+0TVF4dwpb6Rc0UidFONCHtH1
 AyyM/v4337B9x0At3w0odFmIoLFQb0k02zOwX0ba/t30sJikH5dJXkjuHZ9wQXtWG5kJ
 1DvapL4gIYJc3oEDReSSCELyBeeaklxeBPjuyhgdywgPxOQgWoA3QHnvNeP65znJHevm
 JdAWb7DzVjOkPEfjRAPTbewj+LzS0TIAdbmRwvVjX54YdTz181lTYG7U17F47V9xhMgj
 EqSwwb5No0U9qHDEeicjBq4SzdAgdeSoZcq3k/9ONhvEsLJs4DsAcY98wiKB0ZP4iSh9
 cRAA==
X-Gm-Message-State: AOAM531SuhDdg5nPuw1B9vNk9KlPG3aofojyNpalJ+AL8eXzqEQce2WC
 ZC3v8N7HmDGp1mlJ5Zjj4lY=
X-Google-Smtp-Source: ABdhPJzHqivXR66Y+JVSjJn+1N1gTJ4gMom+lfo9gaKUXgseuzuJh9AWZ1varuvAobqqGknypZgdYg==
X-Received: by 2002:a05:6512:3113:: with SMTP id
 n19mr1137596lfb.241.1601650710594; 
 Fri, 02 Oct 2020 07:58:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id g23sm335325lfb.230.2020.10.02.07.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:58:30 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <c42f1f51-9fa5-6503-91aa-3809f1f27d0c@gmail.com>
Message-ID: <0f186339-1e49-4878-834e-11ae8bf140f2@gmail.com>
Date: Fri, 2 Oct 2020 17:58:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c42f1f51-9fa5-6503-91aa-3809f1f27d0c@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MDIuMTAuMjAyMCAxNzoyMiwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDIuMTAuMjAy
MCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+IC1zdGF0aWMgdm9pZCB0ZWdyYV9z
bW11X3JlbGVhc2VfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKPj4gLXsKPj4gLQlkZXZfaW9t
bXVfcHJpdl9zZXQoZGV2LCBOVUxMKTsKPj4gLX0KPj4gK3N0YXRpYyB2b2lkIHRlZ3JhX3NtbXVf
cmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KSB7fQo+IAo+IFBsZWFzZSBrZWVwIHRo
ZSBicmFjZXMgYXMtaXMuCj4gCgpJIG5vdGljZWQgdGhhdCB5b3UgYm9ycm93ZWQgdGhpcyBzdHls
ZSBmcm9tIHRoZSBzdW41MGktaW9tbXUgZHJpdmVyLCBidXQKdGhpcyBpcyBhIGJpdCB1bnVzdWFs
IGNvZGluZyBzdHlsZSBmb3IgdGhlIGMgZmlsZXMuIEF0IGxlYXN0IHRvIG1lIGl0J3MKdW51c3Vh
bCB0byBzZWUgaGVhZGVyLXN0eWxlIGZ1bmN0aW9uIHN0dWIgaW4gYSBtaWRkbGUgb2YgYyBmaWxl
LiBCdXQKbWF5YmUgaXQncyBqdXN0IG1lLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
