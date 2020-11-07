Return-Path: <SRS0=7JV3=EN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51592C55179
	for <iommu@archiver.kernel.org>; Sat,  7 Nov 2020 08:51:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7BD20872
	for <iommu@archiver.kernel.org>; Sat,  7 Nov 2020 08:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDX33btd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7BD20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7BC678731E;
	Sat,  7 Nov 2020 08:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIAU77TguCz5; Sat,  7 Nov 2020 08:51:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D44787306;
	Sat,  7 Nov 2020 08:51:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D83B2C088B;
	Sat,  7 Nov 2020 08:51:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 349CBC0889
 for <iommu@lists.linux-foundation.org>; Sat,  7 Nov 2020 08:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1881986957
 for <iommu@lists.linux-foundation.org>; Sat,  7 Nov 2020 08:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPeFtXRGITu5 for <iommu@lists.linux-foundation.org>;
 Sat,  7 Nov 2020 08:51:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 72D1286948
 for <iommu@lists.linux-foundation.org>; Sat,  7 Nov 2020 08:51:11 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id t6so2081037plq.11
 for <iommu@lists.linux-foundation.org>; Sat, 07 Nov 2020 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QPvzVmvWxLmKrMg0Sr8OPDxq+YAWcayXVhURIV2qcs4=;
 b=rDX33btdGtMNq+Bz99R1w1obQXwIQ9IekqpbkTp3q7MRYFS2prTnbcLv1GOwk1ueHL
 PdQIA8SbRQVZK9UyOX4QaX6grk8aHnpitYpYAfchMOjwXdBCv5VY1uDywA/VplQt1EqJ
 nYEO6ZxCO4RIX6Qm2SHoaldztJcL68qR+3RqA9VIWaX6b8ahejKVQQA4QP054qE8+8om
 uKAsR9IZLGfV1H4xiHCroxcM9kUVmjqfhiBhZ5RCDsuL3kSMixp3CtqK3aZ5GSdyIaCm
 cH+1TzubPk1ftVO5o+jCOWFGvrWt4QpbHGLN+h/qeBDIs2X9Ygs1ltsqcJI7SXFd6dDU
 h4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QPvzVmvWxLmKrMg0Sr8OPDxq+YAWcayXVhURIV2qcs4=;
 b=t5GiHhcaEDelGUX8WWNmSOMrlZsM0aaZ9/bLSNI5ZIeIyflB0VLnDNjNJSvyCyvbjb
 ciu9VNzPEhdUmaw2jsRE53+xiXYUlmNbkPNLW6N0MKd6ZC2iXqw/I3aGferBOSMLy8zB
 9rEJW3CUFLP0qvaI1lBZmU2ERF2ANYtA9uBvqeA71c6Ztnq4rWuJtEsYENthhS6YYqIY
 PtT66bEfRXTAJDCdL1f7uulL3NfoKqGLaMfsrzS/H/9P5vhVBsbFdcxdk6bga1FuexBc
 DmMFuidCR+zIAPJypbjOSZ9bjEjiv1WP0p411pgRirU6Cit7i9XK6xiqx8LsI17Jpbqp
 Ta9A==
X-Gm-Message-State: AOAM533Bz1fMnjUPyGswuQM7cbFet/Ez198pab1nOp/1NLQtmGczpUfZ
 +4m3y3Y5a4ELxgw8Z42AM2A=
X-Google-Smtp-Source: ABdhPJxkh8t4Zw81Sd+8sRSeTYa+FjFDXD44nHGvdsv5U7xnmrOEWCsK0OCpq+IgwzBmuv601yp45w==
X-Received: by 2002:a17:90a:ee8b:: with SMTP id
 i11mr3718689pjz.118.1604739071088; 
 Sat, 07 Nov 2020 00:51:11 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 3sm4819037pfv.92.2020.11.07.00.51.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 07 Nov 2020 00:51:10 -0800 (PST)
Date: Sat, 7 Nov 2020 00:38:55 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, digetx@gmail.com
Subject: Re: [PATCH v7 0/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201107083855.GA32464@Asurada-Nvidia>
References: <20201009161936.23122-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009161936.23122-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Oct 09, 2020 at 09:19:33AM -0700, Nicolin Chen wrote:
> This series is to add PCI support in tegra-smmu driver.

This v7 has fixed all the existing comments and been in the
maillist for nearly a month. Can anyone please apply them?

Thanks
Nic

> Changelog (Detail in each patch)
> v6->v7
>  * Added comments for put_device in PATCH-2
>  * Renamed goto labels in PATCH-3
>  * Kept Dmitry's Reviewed-by and Tested-by as no function change
> v5->v6
>  * Dropped a NULL check, per Dmitry's comments
>  * Added Dmitry's Reviewed-by and Tested-by
> v4->v5
>  * PATCH-1 Cleaned two variables inits
>  * PATCH-2 Fixed put() in ->of_xlate() and Updated commit message
>  * PATCH-3 Added Dmitry's Reviewed-by
> v3->v4
>  * Dropped helper function, per Thierry's comments
>  * Found another way to get smmu pointer
> v2->v3
>  * Replaced with devm_tegra_get_memory_controller
>  * Updated changes by following Dmitry's comments
> v1->v2
>  * Added PATCH-1 suggested by Dmitry
>  * Reworked PATCH-2 to unify certain code
> 
> Nicolin Chen (3):
>   iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
>   iommu/tegra-smmu: Rework tegra_smmu_probe_device()
>   iommu/tegra-smmu: Add PCI support
> 
>  drivers/iommu/tegra-smmu.c | 187 +++++++++++++------------------------
>  1 file changed, 63 insertions(+), 124 deletions(-)
> 
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
