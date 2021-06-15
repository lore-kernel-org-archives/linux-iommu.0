Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7317FC48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:05:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D886128B
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D886128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA9B4401E7;
	Tue, 15 Jun 2021 19:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SaDS1em83F15; Tue, 15 Jun 2021 19:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B535C400F3;
	Tue, 15 Jun 2021 19:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BCD7C000D;
	Tue, 15 Jun 2021 19:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3DF9C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A76E40651
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1KQ3CEUKW9y for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:05:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7944E40650
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:05:13 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id n12so12223200pgs.13
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=bedgGZfvHTDG3utqka5ZC/z/HrI2g7jOruJT77//JN4=;
 b=KGNhS2wRptJPNS3Sx2q5hBAcAv0CPqiiJ6J5Bw69bIfK4C0hwP8h9atByP2SirnvvU
 gfdLjLt2ESmDYtkrkTP2rALRPhsjy+5iVG0x6NoYX6xvUiV6UZ6fj6I6FnTqkcV7/JOt
 OHTduTztQOKd2TPZHLTJT11mg/nVZdJ2iti7JsJey/cyTPBDxHTrmo4MS6bun7hkVpHH
 khDkXT4B9dTL/CJjUkiLF0VvWej712DS3tTM5Ygt8C+uoZ8JHju5IyO8f++8qyTqxH/+
 2EJf9PMLMReZ1OejYnQvcqDyew+mYBbO/USajmPsrGemzluGtyKyZ1eRUSwr9DWnRfzO
 iHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=bedgGZfvHTDG3utqka5ZC/z/HrI2g7jOruJT77//JN4=;
 b=awKkoIG/Xx06qOmPcI4S/NQraLwYZAaWJLjLvTgd86ms7l5v4SngYFBh5s0EJE3HTy
 SLP3YrLtdmgvsVg80dr9b2wCoqKLFYbdCdSqLuOI+s+V61qvlhxNxQrxIUbt+YgtFdle
 EKBaxoeXdT3AcCwRAjFBcO8M/yzSSwhNV5BbDXAeNukBdxU77T0Da7M7/X07idjfzJvU
 VjVBqYXGfvfeURmczqpPieKXi/QDFSiaBN078xiXhIGdO2uESQDR5gpjrvDyeOJtPrhq
 xs/jiGruSrxQg7wOrPJoR3V19/k3nqUrTm3F+aQq63X6CmfGJNQpTsi++HdyEzxqkQJ2
 BjMw==
X-Gm-Message-State: AOAM5314DuLqFcj+JQ/KsgARaH4HFc1EtTmM2MUeZKLJzam+jqfuFkkM
 lwpbrR9tB1AqNMOiPw75rmU=
X-Google-Smtp-Source: ABdhPJw+kc1wTNNf1KoBk7ErUKM1wCKsgTlMM/yOOKbvzqGiE1ia/ImVwyXo4iPcUxKiP6iLflMfxg==
X-Received: by 2002:a05:6a00:1a88:b029:2ea:548:5ed4 with SMTP id
 e8-20020a056a001a88b02902ea05485ed4mr4345549pfv.47.1623783912769; 
 Tue, 15 Jun 2021 12:05:12 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id d12sm15829068pfo.113.2021.06.15.12.05.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jun 2021 12:05:12 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <07969028-d807-cad1-2a01-8efc87390157@arm.com>
Date: Tue, 15 Jun 2021 12:05:11 -0700
Message-Id: <25B4DBA5-72A3-4122-8678-AF3500F5023E@gmail.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
 <07969028-d807-cad1-2a01-8efc87390157@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> On Jun 15, 2021, at 3:42 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 2021-06-07 19:25, Nadav Amit wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> The Mediatek driver is not the only one which might want a basic
>> address-based gathering behaviour, so although it's arguably simple
>> enough to open-code, let's factor it out for the sake of cleanliness.
>> Let's also take this opportunity to document the intent of these
>> helpers for clarity.
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Nit: missing your signoff.
> 
>> ---
>> Changes from Robin's version:
>> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
> 
> Out of curiosity, is there any config in which a stub is actually needed? Unlike iommu_iotlb_gather_init(), I would have thought that these helpers should only ever be called by driver code which already depends on IOMMU_API.

Indeed, this was only done as a defensive step.

I will remove it. I see no reason for it. Sorry for ruining your patch.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
