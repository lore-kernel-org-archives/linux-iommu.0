Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8159C47095
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:28:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCFB20709
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKVgE5e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCFB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11237861CE;
	Sat,  3 Oct 2020 14:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id thi9oQ3Uu85f; Sat,  3 Oct 2020 14:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F146860F9;
	Sat,  3 Oct 2020 14:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 390AEC016F;
	Sat,  3 Oct 2020 14:28:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0E80C0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91DBE87141
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nBLb4WE3eDBE for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 14:28:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9F57887140
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:27:59 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id z19so5485614lfr.4
 for <iommu@lists.linux-foundation.org>; Sat, 03 Oct 2020 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WcsBuP3zP0tyQaN/LT3trjYTTJjbx6YMciPdXNhaCSc=;
 b=nKVgE5e4W8YLfy5meKUdYu8j+1C+p3kRksSQLxOvu8bVkiWnH9Il35e69GQp7tia9o
 Xg8d5NR8T3ymDHMQzK43jBXe+T+tOBtNKVo7Jp+dgR0804GaXwEBntkEhcxC0BHV50dl
 g/H7yiPT8KWadrr+2KvR+MJQLuTXdbi/7LD7nIa4FVxxY6pQwln0sECcnQPwT9DMtlJh
 3oZJ2mMY2y3yN5xjBGxxUXXJrc2STKAYNSOSDOyWFeh7KJDVNTHwC1xQICyAHY/iuK+P
 cVg4EYC9ZASmiGfde4HUYunWpmkIUazxQjRqf9ZciYCBbCnmvT+3JELvTNqgKSQpyN89
 P3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WcsBuP3zP0tyQaN/LT3trjYTTJjbx6YMciPdXNhaCSc=;
 b=pniL14EnjetwQZT4Q7fpspxnfluaDK0u2fYngQjoeitbk/mFxQ5Ok7ivx7SIsc1i7E
 nXEtjJARwiybOTenCWIrrONsy/vPDTPjhLPqfFd58rGx72gjQwY4hepJz4eqI45xKAwJ
 5wdXatrAUIaZqIabg3/C1GurOtQHvnrJhT7DTWcwe5ggNJ2tDWPswP6vHw3hrWWx/jiU
 OZLkS8Kj6mKwSm91vwJDBskiJHESP5AphDHK73mabjLytsVlrTqLINyDNCvY5Foeniuz
 qyawG0qCDtVQIl5i1HDYLdSrFHkUXR0A6eqvcSoMYOHn5CcLWkl0T08ysntnKqD6g7pJ
 LzkA==
X-Gm-Message-State: AOAM533XVq3b9Zg78ajlEqraA+3tjUo9Nb8R6qfyYLaatbKrcuTOwBz5
 tCvYlHDZx5iupSAW+sM+oYc=
X-Google-Smtp-Source: ABdhPJzNCwTkVXy5Gvj9nlcWlPzP08lu7UGmjgsHq9zxLPPHQ2Uyqy1897ulAmyitOucaozbgNvuBA==
X-Received: by 2002:ac2:443a:: with SMTP id w26mr674369lfl.435.1601735277910; 
 Sat, 03 Oct 2020 07:27:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id p21sm1586032lfo.194.2020.10.03.07.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 07:27:57 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-2-nicoleotsuka@gmail.com>
 <35d789ae-7deb-7f8c-0556-98fe73f5999f@gmail.com>
Message-ID: <0cc12c08-e2f2-b915-e7b4-8e2e94ea2ac4@gmail.com>
Date: Sat, 3 Oct 2020 17:27:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <35d789ae-7deb-7f8c-0556-98fe73f5999f@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, hch@infradead.org, linux-tegra@vger.kernel.org
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

MjkuMDkuMjAyMCAyMDo0MSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjkuMDkuMjAy
MCAwOToxMywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+IFRoZSB0ZWdyYV9zbW11X2dyb3Vw
X2dldCB3YXMgYWRkZWQgdG8gZ3JvdXAgZGV2aWNlcyBpbiBkaWZmZXJlbnQKPj4gU1dHUk9VUHMg
YW5kIGl0J2QgcmV0dXJuIGEgTlVMTCBncm91cCBwb2ludGVyIHVwb24gYSBtaXNtYXRjaCBhdAo+
PiB0ZWdyYV9zbW11X2ZpbmRfZ3JvdXAoKSwgc28gZm9yIG1vc3Qgb2YgY2xpZW50cy9kZXZpY2Vz
LCBpdCB2ZXJ5Cj4+IGxpa2VseSB3b3VsZCBtaXNtYXRjaCBhbmQgbmVlZCBhIGZhbGxiYWNrIGdl
bmVyaWNfZGV2aWNlX2dyb3VwKCkuCj4+Cj4+IEJ1dCBub3cgdGVncmFfc21tdV9ncm91cF9nZXQg
aGFuZGxlcyBkZXZpY2VzIGluIHNhbWUgU1dHUk9VUCB0b28sCj4+IHdoaWNoIG1lYW5zIHRoYXQg
aXQgd291bGQgYWxsb2NhdGUgYSBncm91cCBmb3IgZXZlcnkgbmV3IFNXR1JPVVAKPj4gb3Igd291
bGQgZGlyZWN0bHkgcmV0dXJuIGFuIGV4aXN0aW5nIG9uZSB1cG9uIG1hdGNoaW5nIGEgU1dHUk9V
UCwKPj4gaS5lLiBhbnkgZGV2aWNlIHdpbGwgZ28gdGhyb3VnaCB0aGlzIGZ1bmN0aW9uLgo+Pgo+
PiBTbyBwb3NzaWJpbGl0eSBvZiBoYXZpbmcgYSBOVUxMIGdyb3VwIHBvaW50ZXIgaW4gZGV2aWNl
X2dyb3VwKCkKPj4gaXMgdXBvbiBmYWlsdXJlIG9mIGVpdGhlciBkZXZtX2t6YWxsb2MoKSBvciBp
b21tdV9ncm91cF9hbGxvYygpLgo+PiBJbiBlaXRoZXIgY2FzZSwgY2FsbGluZyBnZW5lcmljX2Rl
dmljZV9ncm91cCgpIG5vIGxvbmdlciBtYWtlcyBhCj4+IHNlbnNlLiBFc3BlY2lhbGx5IGZvciBk
ZXZtX2t6YWxsb2MoKSBmYWlsaW5nIGNhc2UsIGl0J2QgY2F1c2UgYQo+PiBwcm9ibGVtIGlmIGl0
IGZhaWxzIGF0IGRldm1fa3phbGxvYygpIHlldCBzdWNjZWVkcyBhdCBhIGZhbGxiYWNrCj4+IGdl
bmVyaWNfZGV2aWNlX2dyb3VwKCksIGJlY2F1c2UgaXQgZG9lcyBub3QgY3JlYXRlIGEgZ3JvdXAt
Pmxpc3QKPj4gZm9yIG90aGVyIGRldmljZXMgdG8gbWF0Y2guCj4+Cj4+IFRoaXMgcGF0Y2ggc2lt
cGx5IHVud3JhcHMgdGhlIGZ1bmN0aW9uIHRvIGNsZWFuIGl0IHVwLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+Cj4+IC0tLQo+IAo+IFJl
dmlld2VkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Cj4gCgpUZXN0ZWQt
Ynk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
