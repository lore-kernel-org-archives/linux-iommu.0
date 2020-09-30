Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BDC4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 21:38:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0D020739
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDP8U5qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0D020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E547B84FB9;
	Wed, 30 Sep 2020 21:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FP3jKntMJwrn; Wed, 30 Sep 2020 21:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6DD4C84FB0;
	Wed, 30 Sep 2020 21:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52F09C0889;
	Wed, 30 Sep 2020 21:38:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB364C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B38E78493F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xUAdXQWrctG for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 21:38:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 17D188324B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:38:25 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 7so1994235pgm.11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/7M+m304EbzXdELkQvrts+2IAKCx+eNRKpz9TTnYchQ=;
 b=PDP8U5qqzZT05fUVILGe3OnV05AlxULeVzaTbmN1blGKkX8i6n1on2U6MydWDO5quS
 zrhZs1QYBik1BH4Q4pCkt4DU4gDJQR4zW11H3ez3LNY+iC+DoXgepPqmPYzOaxuLs14R
 F/pWFEgIhfK1/XDf5gsZ0ixXUGPjJGp7eCaWWa3ZocUFhdBTOfzY1SYBJoryhatsNiLT
 uWaEIyB/eoGFDiZyotYwehpYYRZy3Ip7NtanSfKye5TLi986z0zRISfLquwLIwl4fNfA
 ApJIOXe9m00Oe4b7vdp3M4KlquPDyB/vXaKzhGy8zlGGmUJlf6AKBhKHv5yj3VZ/JY9O
 4xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/7M+m304EbzXdELkQvrts+2IAKCx+eNRKpz9TTnYchQ=;
 b=XMtlQZ/O93bFNbKR/P+ciDRUe4I3tb0fx9cX94v49k4iFMMR93r4OhzKCykYTQDi7S
 RomtifMXrSO0+PEe00tAZZzEQOp62xUlc99XO2NIFDJ3qLOA7Obf7SS2OA1uloXvTkFd
 nXKbPMsjPpmIMisa22ch9DcUV2yZZ7+pBP/WfwlnfM/Pzp+p6guhdoypZVAOozthgiBP
 ltvcmDcByHsIfnH8ECixPClxwmiVjAkZx7qNLek63JJtDEpzO9o50wUr+q4041rG7hNj
 7xt/VNW+bnJJhEDuyseQNRFn8vMg8DiVppvWm8BydrciMiAtVtpAqBzDfRsps0Qh45am
 VgYg==
X-Gm-Message-State: AOAM533IcHGKev/JKB3WebVICIY/Rus3SkM305VKWDagXAoBRPL2gosx
 OvPW2SEhJYzkAINADZQn2Y0=
X-Google-Smtp-Source: ABdhPJw1hLq5lcWj28hcW5D/VbiXUDwlCYD9+XODjgXVO027DtJlObOk4ThtLe0DNXKOmM4EGrrtmA==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr3547807pgg.135.1601501904553; 
 Wed, 30 Sep 2020 14:38:24 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id h12sm3490699pfo.68.2020.09.30.14.38.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Sep 2020 14:38:24 -0700 (PDT)
Date: Wed, 30 Sep 2020 14:32:44 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930213244.GA10573@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

On Thu, Oct 01, 2020 at 12:24:25AM +0300, Dmitry Osipenko wrote:
> ...
> >> It looks to me like the only reason why you need this new global API is
> >> because PCI devices may not have a device tree node with a phandle to
> >> the IOMMU. However, SMMU support for PCI will only be enabled if the
> >> root complex has an iommus property, right? In that case, can't we
> >> simply do something like this:
> >>
> >> 	if (dev_is_pci(dev))
> >> 		np = find_host_bridge(dev)->of_node;
> >> 	else
> >> 		np = dev->of_node;
> >>
> >> ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
> >> sure that exists.
> >>
> >> Once we have that we can still iterate over the iommus property and do
> >> not need to rely on this global variable.
> > 
> > I agree that it'd work. But I was hoping to simplify the code
> > here if it's possible. Looks like we have an argument on this
> > so I will choose to go with your suggestion above for now.
> 
> This patch removed more lines than were added. If this will be opposite
> for the Thierry's suggestion, then it's probably not a great suggestion.

Sorry, I don't quite understand this comments. Would you please
elaborate what's this "it" being "not a great suggestion"?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
