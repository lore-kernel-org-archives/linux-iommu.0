Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B6C47095
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 22:03:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5052078D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 22:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGtddg2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5052078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D7FA81E2B;
	Sun,  4 Oct 2020 22:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lyPUoOS_V8oq; Sun,  4 Oct 2020 22:03:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08F9B80ECB;
	Sun,  4 Oct 2020 22:03:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F37B4C016F;
	Sun,  4 Oct 2020 22:03:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C815EC0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B488086C6D
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7y79nZ-HRcUu for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 22:03:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 216DE86963
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:03:54 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id t7so4400313pjd.3
 for <iommu@lists.linux-foundation.org>; Sun, 04 Oct 2020 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=hiTQzSF4WkdU76QTi9QZDEhHhUN1SUtqOZbzP+32RK4=;
 b=YGtddg2oP1zVqUfCFFhAO4LAsgstkdAA3IL24t43oNsEjqjCnBLxcRDpe3b4GkB7Fi
 qNS7GUN7e0UwYYngF/FYAHRRt9pEpyYgHhBTEXJw7dW4Fszet2kUTtBdOOjst2f1eQqu
 K7XHAlKWXJe28W7vaswHtMLoBI5fuOyTK9/TT/VXfA9MUOcNuGor+S4fK7KTerhChyC0
 EEmoD8rnyMVoDE2sdy+Tk5LTuZN3I4oXlK/TRngSxw+8zU4ACUFj1NXaLTkQRSw0B0C3
 p1ekNvDq/IAtbH7rRTGm7qBOkM1LZJxME3P5839WQfuSvdRBtxGFP7gALM94EdoMM5eR
 DsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=hiTQzSF4WkdU76QTi9QZDEhHhUN1SUtqOZbzP+32RK4=;
 b=qj0U/HRVKnJVKYoz1FFse8BNyzqnZFZSzCPUhCuiVnHNrDLGgomIaiiVEYofQyjk6x
 WWakyvG1UeqOBINxFbq/RcfScNLAlAjEvmsppYrYhJBvmJiU6T4N4NYhB/GhtlXywKj1
 Y2VQQGzrN+mavkIJ8wX9yVgsqPKLxKzeeJsC5PVumi+lpuOjs1/fLEAX7pelbnbyEAgP
 gK7BDK2ZNaMzvg2WUqIpM16/JOQ8RU50qVSWA6bkgRD/NR1qgADheZ6+tKvSOyou4jOy
 POCBVy/CP2MGk7/BNZh8rryHtnGxQ8ZSP7/RseU+gM+7b4rOTaO4LE0s2nkcKeuCDC7h
 BoRA==
X-Gm-Message-State: AOAM530IQLEKg2vV/HgY9yZUb9FrbOte2nH8WbAwywGqinz6otyAReRA
 2NzP7hstgSAhe8epOmnbUVo=
X-Google-Smtp-Source: ABdhPJymMfT4hxoF5YwtFJKrWgXA9ioeVfiQ8Bw5gURBdv8+OmuXnFjc/3+WMwpThxpJKagDsNeu6A==
X-Received: by 2002:a17:90b:1741:: with SMTP id
 jf1mr13242190pjb.164.1601849033662; 
 Sun, 04 Oct 2020 15:03:53 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d128sm9942284pfc.8.2020.10.04.15.03.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Oct 2020 15:03:53 -0700 (PDT)
Date: Sun, 4 Oct 2020 14:57:31 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v5 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201004215731.GA21420@Asurada-Nvidia>
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-3-nicoleotsuka@gmail.com>
 <4a5a5b1c-080a-327a-1e2f-dc087948e1a1@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a5a5b1c-080a-327a-1e2f-dc087948e1a1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

T24gU2F0LCBPY3QgMDMsIDIwMjAgYXQgMDU6MDY6NDJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAzLjEwLjIwMjAgMDk6NTksIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
IHN0YXRpYyBpbnQgdGVncmFfc21tdV9vZl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiAg
CQkJICAgICAgIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MpCj4gPiAgewo+ID4gKwlzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICppb21tdV9wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShh
cmdzLT5ucCk7Cj4gPiArCXN0cnVjdCB0ZWdyYV9tYyAqbWMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShpb21tdV9wZGV2KTsKPiA+ICAJdTMyIGlkID0gYXJncy0+YXJnc1swXTsKPiA+ICAKPiA+ICsJ
cHV0X2RldmljZSgmaW9tbXVfcGRldi0+ZGV2KTsKPiA+ICsKPiA+ICsJaWYgKCFtYyB8fCAhbWMt
PnNtbXUpCj4gPiArCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsKPiAKPiBJJ20gbm90IHZlcnkgZXhj
aXRlZCBieSBzZWVpbmcgY29kZSBpbiB0aGUgcGF0Y2hlcyB0aGF0IGNhbid0IGJlCj4gZXhwbGFp
bmVkIGJ5IHRoZSBwYXRjaCBhdXRob3JzIGFuZCB3aWxsIGFwcHJlY2lhdGUgaWYgeW91IGNvdWxk
IHByb3ZpZGUKPiBhIGRldGFpbGVkIGV4cGxhbmF0aW9uIGFib3V0IHdoeSB0aGlzIE5VTEwgY2hl
Y2tpbmcgaXMgbmVlZGVkIGJlY2F1c2UgSQo+IHRoaW5rIGl0IGlzIHVubmVlZGVkLCBlc3BlY2lh
bGx5IGdpdmVuIHRoYXQgb3RoZXIgSU9NTVUgZHJpdmVycyBkb24ndAo+IGhhdmUgc3VjaCBjaGVj
ay4KClRoaXMgZnVuY3Rpb24gY291bGQgYmUgY2FsbGVkIGZyb20gb2ZfaW9tbXVfY29uZmlndXJl
KCksIHdoaWNoIGlzCmEgcGFydCBvZiBvdGhlciBkcml2ZXIncyBwcm9iZSgpLiBTbyBJIHRoaW5r
IGl0J3Mgc2FmZXIgdG8gaGF2ZSBhCmNoZWNrLiBZZXQsIGdpdmVuIG1jIGRyaXZlciBpcyBhZGRl
ZCB0byB0aGUgImFyY2hfaW5pdGNhbGwiIHN0YWdlLAp5b3UgYXJlIHByb2JhYmx5IHJpZ2h0IHRo
YXQgdGhlcmUncyBubyByZWFsbHkgbmVlZCBhdCB0aGlzIG1vbWVudApiZWNhdXNlIGFsbCBjbGll
bnRzIHNob3VsZCBiZSBjYWxsZWQgYWZ0ZXIgbWMvc21tdSBhcmUgaW5pdGVkLiBTbwpJJ2xsIHJl
c2VuZCBhIHY2LCBpZiB0aGF0IG1ha2VzIHlvdSBoYXBweS4KCj4gSSdtIGFza2luZyB0aGlzIHF1
ZXN0aW9uIHNlY29uZCB0aW1lIG5vdywgcGxlYXNlIGRvbid0IGlnbm9yZSByZXZpZXcKPiBjb21t
ZW50cyBuZXh0IHRpbWUuCgpJIHRoaW5rIEkgbWlzc2VkIHlvdXIgcmVwbHkgb3IgbWlzdW5kZXJz
dG9vZCBpdC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
