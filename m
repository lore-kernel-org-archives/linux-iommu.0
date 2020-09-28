Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E33C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:38:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC7523A50
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLn/8LCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC7523A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 22E7385BC8;
	Mon, 28 Sep 2020 22:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 001nOdeyoyhV; Mon, 28 Sep 2020 22:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4B2585BAE;
	Mon, 28 Sep 2020 22:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBB95C0889;
	Mon, 28 Sep 2020 22:38:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 452A0C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3DF3C85BAE
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xmRBLg_21Mju for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C1FA085B9A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:38:18 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id d13so2180501pgl.6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bCRYpdT7NGRtkVazdgtf6o3aGwT35lyfsAF6rcG5spo=;
 b=nLn/8LCzs7yTYeAM2DPkPN9MMDmgUbgRT/r6oGGCl5jgtytupzFVBrasvsFLiiQOOc
 HciVOoQ5GgquoUpsbblwGP3RhXwHcqJJgRI+tdm/NFHaoB84JLr1H9oszSSSC2qkcpyp
 5SBvQQAfSJs/BP2GTaE3H6riH1s+xZmIyjrifR7apIYjL4c4yRbHgVu9jj29FXDlDKS8
 mmtqhJVf6YiRxCQvs6l7x91ZBjY0bb7DJIYQbBmJYu9aHHV/zBc9Jehot2UzWT3LfTrm
 eTErYau3Gwg8tRiDucCstblmr5nVLCNj/QyCM9MojdffZOlEXXYK7chIJ8klLzw2be5H
 qPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bCRYpdT7NGRtkVazdgtf6o3aGwT35lyfsAF6rcG5spo=;
 b=hduqwv72tZRfY3PoqZG4XazGC/NH2Vq5f5rkUUrL9Ww341vuOWrWWDnranMlosBUL2
 d+3gBBeCAf2yPFQSsUQM01lm5AVfXFJDXslu2r9vrQgn4fBVL+zSjV62d3NX5V9kWDSw
 8fLXRQedFNHYXtgcV9EYJnfiKNMfFz4m4SaGv253HlpNhr9wKnEFbemQNnV6THTAIhtX
 BbsV8TXUylMx+99WSyIelH3oiq3pL4txRsxw3VTXjdja9gDU6cnjoDRhGVjYjn2pq2A+
 ZsG1fRKAe4+zdbp5LkHYBNfxBXJI71OfAFrov4UZbsHKNblMKU3b5cuRKARuiYbC+fpH
 JS7A==
X-Gm-Message-State: AOAM531zvNdty3pBncCeAC9ChqCdQ5toWPsXZT6ESEwUVCNUXboaXZb2
 Y6OET7jGcLHUDGYUTIp+jqg=
X-Google-Smtp-Source: ABdhPJzb7jOPaSs4Eb+q5ngvBKrHtOrxzcBCSLUk3NX2KbTSI4kOj+0aUPnEe/ZxWKipEjBtooz5zg==
X-Received: by 2002:a17:902:9047:b029:d2:8d1f:1629 with SMTP id
 w7-20020a1709029047b02900d28d1f1629mr1537691plz.44.1601332698344; 
 Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id bj2sm2404418pjb.20.2020.09.28.15.38.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Sep 2020 15:38:18 -0700 (PDT)
Date: Mon, 28 Sep 2020 15:33:01 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/5] iommu/tegra-smmu: Add PCI support
Message-ID: <20200928223301.GB4816@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-5-nicoleotsuka@gmail.com>
 <20200928075545.GG2837573@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928075545.GG2837573@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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

On Mon, Sep 28, 2020 at 09:55:45AM +0200, Thierry Reding wrote:
> On Sat, Sep 26, 2020 at 01:07:18AM -0700, Nicolin Chen wrote:
> > +#ifdef CONFIG_PCI
> > +	if (!iommu_present(&pci_bus_type)) {
> > +		pci_request_acs();
> > +		err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
> > +		if (err < 0) {
> > +			bus_set_iommu(&platform_bus_type, NULL);
> > +			iommu_device_unregister(&smmu->iommu);
> > +			iommu_device_sysfs_remove(&smmu->iommu);
> > +			return ERR_PTR(err);
> 
> It might be worth factoring out the cleanup code now that there are
> multiple failures from which we may need to clean up.

Will do.

> Also, it'd be great if somehow we could do this without the #ifdef,
> but I guess since we're using the pci_bus_type global variable directly,
> there isn't much we can do here?

Probably no -- both pci_bus_type and pci_request_acs seem to depend
on it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
