Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF44C433DF
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 23:58:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5B0207DD
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaAgyktY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5B0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B6FF86B57;
	Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fFMr8BdVSWDy; Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 120C8869F7;
	Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03544C088E;
	Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC72C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E722203FE
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w5JRvJlHQdku for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 23:58:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 1BADA203F7
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:58:46 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id k71so218905pje.0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GuyDVxBXJ2eH/fhFLNQsFiugfMp6zgAf3tWvMyaED+s=;
 b=HaAgyktYnJOdjm5FRHn5a2ME+0Fd9HVyv0m5tug3+N2yvslrpy2kUqaZrnPLE5PP5J
 +W1u5brVAx92kBbDzk+6zrBBUcNNPgkh7Yuhwl07N9CJU25tAyyf427zq3s7OMTudGMH
 9xd4r4hn/FAIex3VFg1YQUnS+tpDa1SDcwP/OMueE0jBmmByQTwFY6ovbcf5bg9gidev
 6tycNK/hXF7XZ6Ddhqc/Rwdh7puaq/3P2q6jMZKBN4udkoMsKVizjO6WN9H7+6SAv1Hh
 Xjtolx88vxG70K2suFvarVbFLW2TVF2dHuDRl2yX2whEBF6VUdpLrQ3QucfhyNdamySF
 qf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GuyDVxBXJ2eH/fhFLNQsFiugfMp6zgAf3tWvMyaED+s=;
 b=otATaBcDt+BuwQ+stgeSsdASu+SjCoNrji4ug11RjX27KQW3GWTr+pmseVyfcvvnMp
 Fe5UZVq5GqyLSsBqcSoq4/UAp+4k2RFoIqTkbetz4hSJnab242VXDpdKDw31UMjjii/P
 jSNpLwmp8ycZ8k7VZ0Ju6/kTb3JC/KYMLvX8DuITK8/8WK0xpV7f3C0VLHjIcKyObX0J
 +y0EPERodcgSA/gHZ6Ltmav9KeWKpjc0XUzBDWsecYqMpiw6VC3Ojt1A4CQNpq61/Miu
 bf210TyXHrLSSj4ZOkZh3hGMlK4qxc88dSLTrOmD1scxw/Xqp+N/GaWJ/DTAam7NlJnr
 zZ/Q==
X-Gm-Message-State: AOAM531qAXHe3JncEO/n5Reh9I68QrQIhv5tmDO+0FmjL1KHE8V4/3ZS
 8g4pUJMSw/tCqceD065e7GUpCQ==
X-Google-Smtp-Source: ABdhPJyNuk7PzxMd8B56wIzfsRBCUaRfXZEp3SIsJsCTjayO+IwYE5wac4ySM2zGZNDAQTp1F3brfA==
X-Received: by 2002:a17:902:8ecb:: with SMTP id
 x11mr18820708plo.123.1595375925125; 
 Tue, 21 Jul 2020 16:58:45 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id a2sm21698033pfg.120.2020.07.21.16.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 16:58:44 -0700 (PDT)
Date: Tue, 21 Jul 2020 16:56:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200721235650.GN388985@builder.lan>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
 <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
 <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
Cc: DTML <devicetree@vger.kernel.org>, skrzynka@konradybcio.pl,
 Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Tue 21 Jul 09:20 PDT 2020, Konrad Dybcio wrote:

> >The current
> >focus has been on moving more of the SMMU specific bits into the arm-smmu-qcom
> >implementation [1] and I think that is the right way to go.
> 
> Pardon if I overlooked something obvious, but I can't seem to find a
> clean way for implementing qcom,skip-init in arm-smmu-qcom, as neither
> the arm_smmu_test_smr_masks nor the probe function seem to be
> alterable with arm_smmu_impl. I'm open to your ideas guys.
> 

Is the problem on SDM630 that when you write to SMR/S2CR the device
reboots? Or that when you start writing out the context bank
configuration that trips the display and the device reboots?

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
