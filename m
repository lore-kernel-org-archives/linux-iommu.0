Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A1FC433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0767C2065F
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVRoeQwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0767C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9246870D0;
	Tue,  1 Sep 2020 18:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYS2koWnlJc6; Tue,  1 Sep 2020 18:56:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3699A870B0;
	Tue,  1 Sep 2020 18:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2361AC0052;
	Tue,  1 Sep 2020 18:56:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E74F6C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 18:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA5F8204DB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 18:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CofjxRqthj4C for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 18:56:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 69C3120467
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 18:56:25 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id y11so1392862lfl.5
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G85PUm7a3EZzS/FYnNEVI0eznDTH8pPJcc+osLm7WqY=;
 b=tVRoeQwB/gWeuJVETgIoI6uDSLBu9Oi18EgggfK6uMO6UdxaRljqsV964YZWadqrUD
 gnqR/AUlD1T/UL2fXjhcB4us5pytm/ub02fZv4t79xOsyGD7v2OKOonJB1hxTlohcn/b
 3SL21pqUtnNXQs4+7+oouQ2Ppzio4eXKbbvGhuujsuUCRBRioI75eRg/okkBcUhbEPXT
 Wb1CQfA3E//DU2JpFZteOvIezkrUmhiGht8sT2mEGv4iAMtCcwm76LuMvZO0fb6Dv1V/
 jScuFD/qzzG4zSH31l/chlaXN3QgEuoeBbsGZBYjbVRN9Hxo17lJ2aY1WoAw1VrY0L6M
 GiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G85PUm7a3EZzS/FYnNEVI0eznDTH8pPJcc+osLm7WqY=;
 b=c/ODlC14tDk/zbVDDvr+ueRMsF4pJipdOC+dTF/Nfp35lCllIv/cly8mR/ll33uuTH
 YoDWG9pW3JsSS9vNr2FoH2zLc97/6FsYJPkLPcGlpCtN0qdJL+fasAj0CakK6vp9KoVO
 b27vxccXyX38Jq7as4oOJOZPYhA51xiai9J2GIOnrKDWUi8tuOQ7goJbisibg2Lmyuuo
 nS9RG/KsEvMUHhYAdX7o3o2GRAsr4AhWV2l4WTwwQrWOc+FQxMvK4iGPcKG7kZ4dmxri
 fI5o16Ggl8v+X0p0sV9xNi7xU7bejKhOEe7KvXfhxVcMyRPCVd3R4/H0pMgUV4wNLjH8
 ax+w==
X-Gm-Message-State: AOAM532I8tSMEsvhYL/b6Zw802kvhXnt0psHwHpU3l2FGY2rweGdMZgG
 IH7oGgMtmrFew6+FjQ76M+w=
X-Google-Smtp-Source: ABdhPJytkMxC+QnEFyPCwOzPuvfcWYWQYoBFmyrc6f5aTlvzcgsyU7pjMfTvbqXAGKvX8ZR5PgQIPg==
X-Received: by 2002:a19:447:: with SMTP id 68mr1387400lfe.26.1598986583325;
 Tue, 01 Sep 2020 11:56:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id 10sm468433lfq.64.2020.09.01.11.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 11:56:22 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/tegra-smmu: Add locking around mapping operations
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krishna Reddy <vdumpa@nvidia.com>
References: <20200901171305.6929-1-digetx@gmail.com>
Message-ID: <2d38fcab-bc7a-2986-ff39-9403164914e4@gmail.com>
Date: Tue, 1 Sep 2020 21:56:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901171305.6929-1-digetx@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

MDEuMDkuMjAyMCAyMDoxMywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Ci4uLgo+ICsJLyoK
PiArCSAqIEluIG9yZGVyIHRvIHByZXZlbnQgZXhoYXVzdGlvbiBvZiB0aGUgYXRvbWljIG1lbW9y
eSBwb29sLCB3ZQo+ICsJICogYWxsb2NhdGUgcGFnZSBpbiBhIHNsZWVwaW5nIGNvbnRleHQgaWYg
R0ZQIGZsYWdzIHBlcm1pdC4gSGVuY2UKPiArCSAqIHNwaW5sb2NrIG5lZWRzIHRvIGJlIHVubG9j
a2VkIGFuZCByZS1sb2NrZWQgYWZ0ZXIgYWxsb2NhdGlvbi4KPiArCSAqLwo+ICsJaWYgKCEoZ2Zw
ICYgR0ZQX05PV0FJVCkpCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYXMtPmxvY2ssICpm
bGFncyk7Cj4gKwo+ICsJcGFnZSA9IGFsbG9jX3BhZ2UoZ2ZwIHwgX19HRlBfRE1BIHwgX19HRlBf
WkVSTyk7Cj4gKwo+ICsJaWYgKCEoZ2ZwICYgR0ZQX05PV0FJVCkpCj4gKwkJc3Bpbl9sb2NrX2ly
cXNhdmUoJmFzLT5sb2NrLCAqZmxhZ3MpOwoKSSByZWFsaXplZCB0aGF0IEdGUF9OT1dBSVQgaXMg
YSB3cm9uZyBmbGFnIHRvIGNoZWNrIGhlcmUgb25jZSBJIHNhdwp3YXJuaW5ncyBhYm91dCBzbGVl
cGluZyBpbiBhdG9taWMgY29udGV4dC4gQXBwYXJlbnRseSBfX0dGUF9BVE9NSUMKc2hvdWxkIGJl
IHVzZWQgaW5zdGVhZCwgSSdsbCBtYWtlIHY1LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
