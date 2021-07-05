Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714CC07E99
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 14:31:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF12A61954
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF12A61954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A20BB833A8;
	Mon,  5 Jul 2021 14:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AidtEa_BAWTU; Mon,  5 Jul 2021 14:31:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BD6E83299;
	Mon,  5 Jul 2021 14:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 625DFC001A;
	Mon,  5 Jul 2021 14:31:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1864C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 14:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D09344037C
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 14:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mya8QA1gf3qI for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 14:30:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA8D4402DC
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 14:30:58 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 p4-20020a17090a9304b029016f3020d867so70502pjo.3
 for <iommu@lists.linux-foundation.org>; Mon, 05 Jul 2021 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qCX0zqI0eQXVpUhdOeIljsrEhyXkSFc8ZHVG8DOrOfo=;
 b=hhiMI4R6zydKTznJcV8joyAdL09Mn8PR3l4s92ExtC/hDylAApwIRXBg5EmvwFbE8w
 T2TFBHe5C0xXOIr406keJ5p5+zTsRlSvri1NC4SV7tDoKdBGJrgYJwUSTniDNXOtot+4
 Si4Taz/9GcqlHnpypRsxlg1W0kT9ch6dLeWc8imemr6ZnKCambJ7uDGL2+AtrPV2a8PE
 QINYv0INIAumkolHUgI/Sranme6xPN8YkIDKhAi1C91+3nEgYhMtaDesjLIz0q8tj6Vf
 XG61msJhy/vACNJUlHmtwH185SdFkkBVxQAIdPDod8BhOWJ5339x7HS+HTTvMhw6vcrP
 RO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qCX0zqI0eQXVpUhdOeIljsrEhyXkSFc8ZHVG8DOrOfo=;
 b=NBHVaE1QMexUGM3L2CvSAgTQM8LdUwg4k1Qw2FBY3Oxuty1gvijUCjq5Fv450DkAch
 hrVycJww7S6/FkhfJdvLwZPx1I796E+VtKZgsnplhkSGAYu34xoIqQR45MQc/XjS+G+/
 bKaZFccIHCbjmggW4af7VQKJ6RvBSokjVi+0y492ROVKSX1FwlpibdWfoGppQzDBmD7C
 PIOi/FM23MDQyO4ghYMPc0Lgpkt1l/E8lh7ZiOTV9OEybF6SP42G3MafhfEK3StloyLj
 /tibzcTKRTbety39sWeLOnoelPhH9UxfyHdZluzB28iJf3LcYmT0LgIc9ePMWwD+zCBs
 P84A==
X-Gm-Message-State: AOAM533KHi1mvIKbhrCwrxuBDxxDbHFLio0hSxo7LbU/sgJsw4VGNPL+
 vTwL+6fgmp6e8k7QqkOY42s=
X-Google-Smtp-Source: ABdhPJzbjAlVB+N2u0Xd2IZAFCqgYzh5K+zJ+VsL2kc2RNXE5E180B06wBsqArVIp4xnErpN4dteSA==
X-Received: by 2002:a17:90b:164c:: with SMTP id
 il12mr15355402pjb.44.1625495458209; 
 Mon, 05 Jul 2021 07:30:58 -0700 (PDT)
Received: from localhost ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
 by smtp.gmail.com with ESMTPSA id x13sm11382532pjk.37.2021.07.05.07.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 07:30:57 -0700 (PDT)
Date: Mon, 5 Jul 2021 20:00:54 +0530
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu: qcom: Revert "iommu/arm: Cleanup resources in
 case of probe error path"
Message-ID: <20210705143054.nxy4ii6t6npj22ov@archlinux>
References: <CGME20210705065703eucas1p2e89258a2fc286896b755047e06f514cb@eucas1p2.samsung.com>
 <20210705065657.30356-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705065657.30356-1-m.szyprowski@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 21/07/05 08:56AM, Marek Szyprowski wrote:
> QCOM IOMMU driver calls bus_set_iommu() for every IOMMU device controller,
> what fails for the second and latter IOMMU devices. This is intended and
> must be not fatal to the driver registration process. Also the cleanup
> path should take care of the runtime PM state, what is missing in the
> current patch. Revert relevant changes to the QCOM IOMMU driver until
> a proper fix is prepared.
>
Apologies for the broken patch I don't have any arm machine to test the
patches. Is this bug unique to qcom iommu?
[...]

Thanks,
Amey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
