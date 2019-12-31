Return-Path: <SRS0=RkdD=2V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69323C2D0CE
	for <iommu@archiver.kernel.org>; Tue, 31 Dec 2019 08:14:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D66206DA
	for <iommu@archiver.kernel.org>; Tue, 31 Dec 2019 08:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D66206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1650A2048D;
	Tue, 31 Dec 2019 08:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGg-QZ-ulo86; Tue, 31 Dec 2019 08:14:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 485CC20198;
	Tue, 31 Dec 2019 08:14:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34807C1D81;
	Tue, 31 Dec 2019 08:14:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 097FAC077D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 08:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EBF6486356
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 08:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H9ASvjhHUj4B for <iommu@lists.linux-foundation.org>;
 Tue, 31 Dec 2019 08:14:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0EFF384E0C
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 08:14:34 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id dc19so34703813edb.10
 for <iommu@lists.linux-foundation.org>; Tue, 31 Dec 2019 00:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BA/6ccf7o5PJh07KawasqXwPysbrUNZi9TDVA0trLq0=;
 b=F/HUrJ3ovGIJ4s7qVmy/Cedxcd75NPI5V4aiQbmnAqdSeBu9P3Pl6vsCPT4q/8gUAZ
 cw6kQ4Et7VN5BSYbWBV+o0O4JlYry1sYV9Uxzq1S5wChPKZyjDyFSLPVxxlmxOeJhbJB
 uAoYXkUeWAFZ6Ns3yzDJ4lWhQX3Ot3ebDjTicLC18rPGUbZsTxGH2NdJzlz6hLdKTMji
 M0uRpgcW2KxIDvBaWCDiiJP78eQAaDDTtxUSZ/mBEJVAtnnB2+7xY2Ez2vM7Cpi5eGyU
 ugi10TNED3UnDRVeHzabBtG9vWQC9ah+PQJMCF++5GdI3Z4nuLtiJdNoBljvNdkgT/my
 JaMQ==
X-Gm-Message-State: APjAAAXDsVXcB2PJUGZwvAoiv0ZPM0PB9+UHv9enuD9Dg5rnks8NPaWR
 ciCDwCRqrhurJNgTOWgEto4=
X-Google-Smtp-Source: APXvYqzKNFFiPREmzreH7+QxwMfA39pRqo7Zxb/2Tp90xaIwQj2J582XTApIImaIRCLvqyMzzOzoAw==
X-Received: by 2002:a17:906:d4a:: with SMTP id
 r10mr75471357ejh.125.1577780072399; 
 Tue, 31 Dec 2019 00:14:32 -0800 (PST)
Received: from pi3 ([194.230.155.138])
 by smtp.googlemail.com with ESMTPSA id v2sm6035132ejj.44.2019.12.31.00.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2019 00:14:31 -0800 (PST)
Date: Tue, 31 Dec 2019 09:14:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Message-ID: <20191231081429.GB6804@pi3>
References: <20191230172619.17814-3-krzk@kernel.org>
 <201912310916.ScYTgEyR%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201912310916.ScYTgEyR%lkp@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kbuild-all@lists.01.org,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Dec 31, 2019 at 09:08:38AM +0800, kbuild test robot wrote:
> Hi Krzysztof,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on iommu/next]
> [also build test ERROR on v5.5-rc4 next-20191219]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-omap-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191231-022212
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Thanks, kbuild!

I sent a fix:
https://lore.kernel.org/linux-arm-kernel/1577779956-7612-1-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
