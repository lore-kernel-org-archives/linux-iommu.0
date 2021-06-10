Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD79AC47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 07:27:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0DE613F1
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 07:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0DE613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A4FF60844;
	Thu, 10 Jun 2021 07:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iVNbK4soDfOL; Thu, 10 Jun 2021 07:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17BC6607D6;
	Thu, 10 Jun 2021 07:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF85DC000E;
	Thu, 10 Jun 2021 07:27:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA631C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AE586082A
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cFa8fVE15MCv for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:27:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB226607D6
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:27:01 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id g204so5515283wmf.5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=avXVNANZtbNtwGIzbu5/mOfsXzmuN+oN/aMUmryqr0Q=;
 b=VRc2QaSAIMV+KGi0BcOqJRfSdMyNdLNEnXzUhLI7MlCE0fkDGka7VzIygBBqC2saf9
 MPf2W6216h7Xg6oe2W1TW2qNY8OMi4TArPB3UivfENQTdjQJWZDSbeW7OPBTjSDOd3Kt
 gpkC7T9gXVRYLEWez/PECMfvnheDLFss2Sljc7DXK5q6EQ9XViOXVnnqszp7h61tIz/t
 A6T7EPBDCVW3HxlxhDfZrgtX71Q4H8Iq2BQRIlmxZNbmGfKP+bPpb2prIJk0UUGjSLk1
 AiGQEGOI0F87ozUc9J0SJbp8AxJ7Ss5VjUhtdIdM9kQSi81BL/1617BSJlYRD8gKInXi
 JnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=avXVNANZtbNtwGIzbu5/mOfsXzmuN+oN/aMUmryqr0Q=;
 b=TDjVhGw/H9me64MPkEdZvIQOMDe/M5GmPoB/COkQtBq088sf9kXr43ZO/CM+HpXuL4
 DMf2mdndYCdmLPa8FAmleLSs0zuZXJIYM/SNn137oYuVZdsipZdR+SlSUiW2uHWzCOrd
 qNSv8jk9AjOMfIhxHIEr1p1NO+LDX5/NR0Y1e8tT2XWnkRv25bUrdA5J9cO5RKwigBAY
 2l7Bi83EvK5xjx4x28Y9lg6UH+e0rBGXmJHrwoe7kSHq42iA6CEeEwdF7Zpf7fWfuURo
 vP9WSPbDpbM9Mh99uXGDvoMkglWVsn/ENtDR1WK3iMe/qAwNrcUCjE3Z/GWtpLA3W6OW
 ruAw==
X-Gm-Message-State: AOAM531YL72bvfwrg1Tz2yyNLG/amY66gFEwV/wJagYg6SiLuml0BUCp
 2cm5oEmBrye2HMHQ2OWulUguzw==
X-Google-Smtp-Source: ABdhPJwbq9CPx2IleqzQLDh7nuPcvAdqoVFXQyJlT7lKUCc0c5RG1MjzcAoY254nLwYIvQPK18ygFg==
X-Received: by 2002:a05:600c:410c:: with SMTP id
 j12mr3466501wmi.117.1623310020028; 
 Thu, 10 Jun 2021 00:27:00 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id l16sm8809890wmj.47.2021.06.10.00.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 00:26:58 -0700 (PDT)
Date: Thu, 10 Jun 2021 09:26:41 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YMG+sdvQ9/BkeBCe@myrica>
References: <20210602154444.1077006-3-jean-philippe@linaro.org>
 <202106030417.97asL7dA-lkp@intel.com> <YLiELyo+KLuYqA24@myrica>
 <YLpFHwGPuWsB3AgV@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLpFHwGPuWsB3AgV@8bytes.org>
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>, mst@redhat.com,
 catalin.marinas@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org,
 will@kernel.org, dwmw2@infradead.org, lenb@kernel.org
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

On Fri, Jun 04, 2021 at 05:22:07PM +0200, Joerg Roedel wrote:
> On Thu, Jun 03, 2021 at 09:26:39AM +0200, Jean-Philippe Brucker wrote:
> > These are only defined when CONFIG_IOMMU_API is set. IORT uses them inside
> > an #ifdef, I can do the same. Maybe moving these two functions to a new
> > drivers/acpi/iommu.c would be nicer, though.
> 
> Not sure what the ACPI maintainers and reviewers prefer, but I would
> just #ifdef the functions and provide stubs in the #else path if
> necessary.

Yes, I'll resend with that

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
