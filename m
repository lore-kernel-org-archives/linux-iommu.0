Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E12C47420
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 05:42:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B612821548
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl6NtFtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B612821548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6E43A86FD5;
	Tue, 29 Sep 2020 05:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aszsk6vcWRwK; Tue, 29 Sep 2020 05:42:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E655486F12;
	Tue, 29 Sep 2020 05:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C937BC016F;
	Tue, 29 Sep 2020 05:42:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D545C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 05:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0FD6D85C05
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 05:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id my2nVCw7Fwg3 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:42:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5422385BEE
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 05:42:08 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id x16so2957138pgj.3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ysq/ouKi6jMX8v57M9aoYWZV/MYW1mEd7coTo5/bzDw=;
 b=Pl6NtFtBjxltcAhP3oYqpHyC619vq+rUWAO9wpQ6r8xOUeOIxMFo/fHVYI4AEJHNp5
 za5pJuRd13498wxA34MIuOty5BAFPXDNXLNTPKu7BdxxumMPZFZCE8W8Qd0KEhvHyQi2
 M3vaxz28cgacT7MPwiOr3VsoRjQnjZfUgTrwYTCFb00/XO4S2QH1oNTz4af/IvgRweLO
 9wo/bGpsvINwXh9YQButyh5UJ2mv9kQggxpVN2aIb+C39jmG/gzP9lknTrgLHQiFS+nC
 yhTcr9o2sEkR+NKFCNn/apjx6TtRm9Ix3QDTddE4XM5mrR6W+fp0Qr5TWg504z/tAyWO
 uuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ysq/ouKi6jMX8v57M9aoYWZV/MYW1mEd7coTo5/bzDw=;
 b=MR8QGTAid1o5Esvhlkp/iQhMOOu5LYLzzsMzApY/rhuPEdlaKsvu71ZQ2CweYJAa1+
 NvXF9AM4bOmpWm7teuMDOCb68QSjWjC/fN0f5JF7xaesRBk7arUW9vJ4hFA1x8MGWnwY
 BorjwcImY6ry9N9YfyTPnvw4CAzdfH0jlP2mHR5oqTUgEs0/IUXzC+2BnJsAh3FPjEbV
 QaomkyqA/jffv/365FiRuiXOA1f51VtlQJbAozLXSwaUVEdxN3Z6fg+wZs4fy3fN8LS+
 lUpFzdPa4N4emqyN2aN+4UoktSjJgEtgOC+lVXSgABJ79U0HsmSZBs6gyek3ub7FWYXd
 pzGg==
X-Gm-Message-State: AOAM530vEf8fD6Yt475l61RjjQby2SK1s2CPAj0OQQjzvvMrzSHVJdYF
 OCCDe+u7jLqxEtvJ+884B30=
X-Google-Smtp-Source: ABdhPJyu1vAXv5K39kZ/daoUr01rwlDpclPujRxh1WhIz2iFoJLLEPOBrK46HT+Qjp2OFkW78c7Hjg==
X-Received: by 2002:a05:6a00:23cc:b029:142:2501:34e5 with SMTP id
 g12-20020a056a0023ccb0290142250134e5mr2621977pfc.62.1601358127716; 
 Mon, 28 Sep 2020 22:42:07 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id k14sm3527621pjd.45.2020.09.28.22.42.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Sep 2020 22:42:07 -0700 (PDT)
Date: Mon, 28 Sep 2020 22:36:45 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 3/5] iommu/tegra-smmu: Use iommu_fwspec in
 .probe_/.attach_device()
Message-ID: <20200929053645.GA16611@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-4-nicoleotsuka@gmail.com>
 <20200928075212.GF2837573@ulmo>
 <20200928221829.GB15720@Asurada-Nvidia>
 <2a38018a-3f95-74da-6dc1-270efc26a8fb@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a38018a-3f95-74da-6dc1-270efc26a8fb@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org
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

On Tue, Sep 29, 2020 at 07:06:37AM +0300, Dmitry Osipenko wrote:
> ...
> >> As I mentioned in another reply, I think tegra_smmu_find() should be all
> >> you need in this case.
> > 
> > This function is used by .probe_device() where its dev pointer is
> > an SMMU client. IIUC, tegra_smmu_find() needs np pointer of "mc".
> > For a PCI device that doesn't have a DT node with iommus property,
> > not sure how we can use tegra_smmu_find().
> 
> Perhaps you could get np from struct pci_dev.bus?

Possibly yes...but I was hoping the solution would be potentially
reused by other devices that don't have DT nodes, USB for example,
though I haven't tested with current version.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
