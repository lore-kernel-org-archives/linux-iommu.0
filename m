Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622C0C43462
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 16:17:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36BE6120E
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 16:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36BE6120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACF2E84568;
	Wed, 14 Apr 2021 16:17:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qzNAgsulCSo; Wed, 14 Apr 2021 16:17:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADE168268F;
	Wed, 14 Apr 2021 16:17:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8078FC000B;
	Wed, 14 Apr 2021 16:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C47E9C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 16:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D9E340189
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 16:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=networkplumber-org.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IUgI2CAhTiog for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 16:17:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBCCC400D2
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 16:17:48 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id y2so10400844plg.5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0eL/B6Xsq6Q/24IYguuLfwVoh9qvE+Qw7MZOf5nGHyg=;
 b=DWKLnEjIRc6nqOLRuoo9K6bOLQMW5c1mqbVDL7yGhVs88fhUl8h/izys8YK3f/gwVM
 PcQzKMKIFq9o0hwsUhKISfLDewBl34wWHl1mNxtvbMhH9ULpfprQDggqRkhav/DB3fq5
 Lt6TuRqVyREjop1FfnrZ4OwusSTzbuxed+y0o4pqUcZLeuQPE7o9Q0ERP1T2859SlHBK
 swDXpNsO2sseabX97kJN/6O4FliaKLmz/0n5+zOfFOhIc71jVo20vJcnie48mgAzBh32
 YSPSVWZiitdeHf/qr6sagNpJv+45RDkOHNv90Ca9f1wMkoDLDoLK0Hka9u0ctg+akLmV
 r8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0eL/B6Xsq6Q/24IYguuLfwVoh9qvE+Qw7MZOf5nGHyg=;
 b=o9WVkzEnkTI5m3DctAkfDfXcbJCxVb1RdKnhf13x+VM3F2oipkn7obktO1meXc4bIj
 2ZC8wvL7N/UPjP0t/jmcUBEuFJR+OSpY8V0g0FG6TqQ7T5mU0Js4dhrg+fp+AO2+BRvK
 cySeNiUGHpka26e4NlTYs3OwnUV+YKxZF+umKqEDV7eQIDxgjkopn2dhFP/aEF4BbJEX
 N7iuyYG8KEDgqzhZAu13n64zab7YEfkzbVAY63WpnC09riJaYXkfEjN1MiS5Kad6bgaF
 SUdwYYRJp5xlUyXfP/cFFWMRdEZA1MlgUDSVoxg+FZ/yHepj9OxVW+4dDm+/dCucFs+7
 WR6w==
X-Gm-Message-State: AOAM5317rCaaVN7gxBpP3W46oGSHXN/1R6Wkg4xQ0wI6PSfQObVPdAWM
 Q08q5UIfZy1cgfHG+3uzfflQFg==
X-Google-Smtp-Source: ABdhPJx5Ic6DX2vQpbh90Yradu9W82hKhZ9FhXc7n7c05NjGIO6V9+vgFJUqzgqafzt2aOiNHdkPHQ==
X-Received: by 2002:a17:902:cec1:b029:eb:66ee:6da0 with SMTP id
 d1-20020a170902cec1b02900eb66ee6da0mr1001099plg.84.1618417068337; 
 Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
 by smtp.gmail.com with ESMTPSA id r5sm5092591pjd.38.2021.04.14.09.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
Date: Wed, 14 Apr 2021 09:17:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Resend RFC PATCH V2 08/12] UIO/Hyper-V: Not load UIO HV driver
 in the isolation VM.
Message-ID: <20210414091738.3df4bed5@hermes.local>
In-Reply-To: <YHcOL+HlEoh5jPb8@kroah.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-9-ltykernel@gmail.com>
 <YHcOL+HlEoh5jPb8@kroah.com>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, hch@lst.de,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, Tianyu Lan <ltykernel@gmail.com>,
 mingo@redhat.com, kuba@kernel.org, jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org, sunilmut@microsoft.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net
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

On Wed, 14 Apr 2021 17:45:51 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 14, 2021 at 10:49:41AM -0400, Tianyu Lan wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > 
> > UIO HV driver should not load in the isolation VM for security reason.
> > Return ENOTSUPP in the hv_uio_probe() in the isolation VM.
> > 
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

This is debatable, in isolation VM's shouldn't userspace take responsibility
to validate host communication. If that is an issue please participate with
the DPDK community (main user of this) to make sure netvsc userspace driver
has the required checks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
