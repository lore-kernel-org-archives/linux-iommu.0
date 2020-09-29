Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D5C4727C
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 01:21:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9C12083B
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 01:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB5AkSvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9C12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 19A0520526;
	Tue, 29 Sep 2020 01:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cpIsHqUMdvJ2; Tue, 29 Sep 2020 01:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 486D220523;
	Tue, 29 Sep 2020 01:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15A7FC0891;
	Tue, 29 Sep 2020 01:21:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA15C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 01:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E550866A1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 01:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VES3iizpjEq for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3AED486689
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 01:21:18 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id m34so2461863pgl.9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LJ2EaLyywMeQ220DXk/3m8ij2UCaXBFliElieIvVcWo=;
 b=dB5AkSvgSsuC4jqhJi1Du6fOX/N7Xqa7co1RAVRI7k5jGv6Bykuo2tOZ/hkkel3qzY
 CTS8a/Oal7MbkDg+kiT/tRhuH74Nl3g/7dKHJijJyXGtbC8AlTGjsR/d9vYzi2kf/nR1
 4oizg3sYkVtgATl4O58g0KvM7Gi3/4ZWup+Dxtczp0wmPtnV6YAR/bIsw1Er0jVGTujr
 NNzOmFB+JjELoSImcu53H6HFX6UmQpQGSgK396wSboSVx3JwNZhGUL6f5QLWlLhJ7BnP
 +5ITYJYN8klNUwbH3449wW7mMwZp0FIU8cp32Es6bcaZnfwrQWbNiFOcq4eUzNCZ4vzR
 wOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LJ2EaLyywMeQ220DXk/3m8ij2UCaXBFliElieIvVcWo=;
 b=NM0cHUt0Uk/5u4kOdzvmbRqLWftPSwK+LStJhxdmQEtffIewDlJeHnisl/L4oGbX/2
 535N8Xk+XsyKUZ8DE2R+2S83kFb3uhlEhJx4QUOStwGFsqSl1coHJWPcwfwBtbKV1bSG
 J2I8xQjPOn/uXqFIdghJ9oEp1/lIpcuOQQYHyK6So56AO6N539O6uxuS4WWBqbRextqX
 N+DJ2M87fNeHGEYUAq9Qw6HtsSVLpo9uWc7tSI6IuxyBbZpwUx0SpKmqRwFJuorlcAMf
 ZcGV+q9LW3CNpvFzkfO+vMeOUl7ylx4IdGnkyl/oqcDnOTCdwPk7N5jaE/XylEnFRCyO
 WApA==
X-Gm-Message-State: AOAM533BRiBPB0rXl0vxpK0pF9ELiN5IvCDVuoOFCi2eubiQ7eR0Rnld
 xnStPg/wRDabd20354flRgQ=
X-Google-Smtp-Source: ABdhPJyImG3w8frEfpcUQx/Q4jWtb4RC9mBhFFjza2RqlH0U2v8tnaw3/b8ogIZGHZf/614y9A889w==
X-Received: by 2002:a17:902:b685:b029:d2:1e62:4cbe with SMTP id
 c5-20020a170902b685b02900d21e624cbemr2075538pls.58.1601342477766; 
 Mon, 28 Sep 2020 18:21:17 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d25sm2589760pgl.23.2020.09.28.18.21.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Sep 2020 18:21:17 -0700 (PDT)
Date: Mon, 28 Sep 2020 18:15:57 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/2] iommu/tegra-smmu: Expend mutex protection range
Message-ID: <20200929011557.GA905@Asurada-Nvidia>
References: <20200928235901.28337-1-nicoleotsuka@gmail.com>
 <20200928235901.28337-3-nicoleotsuka@gmail.com>
 <692b51fa-7a3e-dee7-b628-7cb2d2dc188d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <692b51fa-7a3e-dee7-b628-7cb2d2dc188d@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Sep 29, 2020 at 03:17:58AM +0300, Dmitry Osipenko wrote:
> ...
> >  static bool tegra_smmu_capable(enum iommu_cap cap)
> > @@ -420,17 +413,21 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
> >  				 struct tegra_smmu_as *as)
> >  {
> >  	u32 value;
> > -	int err;
> > +	int err = 0;
> > +
> > +	mutex_lock(&smmu->lock);
> >  
> >  	if (as->use_count > 0) {
> >  		as->use_count++;
> > -		return 0;
> > +		goto err_unlock;
> 
> This looks a bit odd because it's not a error condition. Perhaps should
> be better to "goto bump_usecount"?
> 
> Or make it similar to tegra_smmu_as_unprepare()?

Hmm...I think it's simple to just make it "goto unlock" then.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
