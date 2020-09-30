Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF095C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:20:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7171A20659
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv9Fa3zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7171A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E285886658;
	Wed, 30 Sep 2020 05:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xL93xF8nbSTS; Wed, 30 Sep 2020 05:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E37F864DA;
	Wed, 30 Sep 2020 05:20:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15878C0889;
	Wed, 30 Sep 2020 05:20:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31495C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2D4F4870F4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKFfRo39D1+x for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3996987005
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:20:53 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id b22so553614lfs.13
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/vquZx1A3iluTEUeE59wLilR4MqylWrQ+TBuI0tvfkQ=;
 b=Zv9Fa3zqpk+N0YQ0z9cb0GU+O+b/3HX7q7p7JtJBxw88h1Z3Gh9kNKxU89jNs6Xcwr
 f2hxCnYi8ucVK3VjDxwohagnbSNv2epSHbt3iBVw1nzW/ECu/iUzvD48cF+lG+hz3Fw/
 clukDexDUQNteNUcfXzOFMMtMqxioHuHrXFOlX0+a4FQmn4XV6dVYewKQoPnDAyMayiX
 l00YvljfkiEN5cSh9xyJ0BvbsI4bgc055dCh6xktc1FdXif9hvs1+1rbKPmSHhQBv/yv
 ij4Rb1FibJVjyU4TVML21msMmuKjim+Fedhe/qdDTFbIdt1goIJVysyQZhQCdLdCbFTi
 /pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/vquZx1A3iluTEUeE59wLilR4MqylWrQ+TBuI0tvfkQ=;
 b=Q3QFSyDOVxhFteiCZHGOjw+/cBKJCRvJ0TaYupgWwxp2nz8uYj0W13qxTfsIYU2SJr
 ekL+KJZn7BCwaJtuTf2vAbBwgvKtUX6M8a5u9X+rEydrfSjXrxzg9CyCZi0X4y4MrXxV
 fUHmD4FhdQlOXAMrDnoDX2CJxUjVj3r7HyxDNttEme4UK9vo3RPbgdF9NGqHDjgXpxs8
 E0Ex4ECYz5chvcxCe5aipSthZqNXhwMl4HqOYFc+UKNopXyW/nV0sDMGGldiSKCjbzuQ
 Fv6T6sorownZK7w4HKnjat5ddEx05zdOoetmimdviW6OG55l4KbEkT/iIMhkaRW3yyns
 YbxA==
X-Gm-Message-State: AOAM533d4Uc6uHTdTxiRRPELMbUcduNCQjX7se8d/rZM7lt+dMM5u2By
 KZU8vlDcLF9LDh99DVVQxWM=
X-Google-Smtp-Source: ABdhPJz82QlO70fJl2vNtlSBQ8vbMM7nm+VNivgOHxtah8c167tZ1uRj7xH7oN+Usj5eoVq0Yd2Msw==
X-Received: by 2002:a19:3c8:: with SMTP id 191mr227547lfd.549.1601443251483;
 Tue, 29 Sep 2020 22:20:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id e14sm50128ljp.15.2020.09.29.22.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:20:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <db183fdf-d566-599a-94ff-cfab0e08aa7a@gmail.com>
Message-ID: <931eb16b-4529-2c20-c696-c57a9138aded@gmail.com>
Date: Wed, 30 Sep 2020 08:20:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <db183fdf-d566-599a-94ff-cfab0e08aa7a@gmail.com>
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

MzAuMDkuMjAyMCAwODoxMCwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMzAuMDkuMjAy
MCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+ICBzdGF0aWMgdm9pZCB0ZWdyYV9z
bW11X3JlbGVhc2VfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKPiAKPiBUaGUgdGVncmFfZ2V0
X21lbW9yeV9jb250cm9sbGVyKCkgdXNlcyBvZl9maW5kX2RldmljZV9ieV9ub2RlKCksIGhlbmNl
Cj4gdGVncmFfc21tdV9yZWxlYXNlX2RldmljZSgpIHNob3VsZCBwdXRfZGV2aWNlKG1jKSBpbiBv
cmRlciB0byBiYWxhbmNlCj4gYmFjayB0aGUgcmVmY291bnRpbmcuCj4gCgpBY3R1YWxseSwgdGhl
IHB1dF9kZXZpY2UobWMpIHNob3VsZCBiZSByaWdodCBhZnRlcgp0ZWdyYV9nZXRfbWVtb3J5X2Nv
bnRyb2xsZXIoKSBpbiB0ZWdyYV9zbW11X3Byb2JlX2RldmljZSgpIGJlY2F1c2UgU01NVQppcyBh
IHBhcnQgb2YgTUMsIGhlbmNlIE1DIGNhbid0IGp1c3QgZ28gYXdheS4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
