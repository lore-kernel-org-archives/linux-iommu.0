Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A0C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:16:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9852071E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFJ0lf8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9852071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 24871204E4;
	Wed, 30 Sep 2020 15:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSgfeioqvwZ2; Wed, 30 Sep 2020 15:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4C0212047C;
	Wed, 30 Sep 2020 15:16:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC73C0890;
	Wed, 30 Sep 2020 15:16:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B160C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 22AB6871DD
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wr6aMxt9fh6p for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 15:16:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 39AD6871D4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:16:50 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id a22so1902123ljp.13
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jw4xUwJEw3PBdXJ5pKldJCzPzGe94a2UdzCi5f8tbUA=;
 b=YFJ0lf8QP0Q8nhVCwx9JJ+oihFfCYDo1Wzs9JVlPOKiCPw3NwvecDKw8eiYEVxwBrF
 ac7nmF8Cxbl4CecpkPDMKfur68yFEkbMR3iZqKcOYtQb6w3cLTVemZTme8OaV6ktMa5E
 dwrHPbSBABbVwzDyFJmADESi5yP8mFl19fW12ButrUFw20GRWsD6BsfDFavhWIlkU+vr
 2lRQJYAkAbRigzWOItphQQSpkb7uQ8841vo2PjUCGB2A170L47qDi0u7zj69utDCTJnQ
 UGYdVm+qQOWoD8y2dMPHLPWqZW8nnzQFvBf7hIHXABx33j7cNMXHSyJkHYTcsSfQ4QOl
 qXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jw4xUwJEw3PBdXJ5pKldJCzPzGe94a2UdzCi5f8tbUA=;
 b=ZtVhILt2CYSFiDfcj/UfqwkxMQUtp7O5RhkS48U0wH+evvONeb7rKcSXtkVoM22wra
 GJDvsPeE1HxUHanmtufc89Or8ChaIN7hoKheAPJNyn4Ip4JZ9RsdmulvY0okRNf/tm9i
 LnvJ3k+kpBpSGJVa7aXUXraHzV+oExn62A2nT3KNr4mYzB22h394SckME6leLEaIkRA+
 yh7aGbqJJUwSeydViclN1FuttdHckE0hXSbhXaUwKMrlDEag7i2UfAQ5aUbDuwMcl1sr
 2KekUSSjNiBIsu1JlBn84jg52B+O8++rlDVtI8A1U0KMKHSqF7WasHZu91xOi7D3sd9x
 ++uw==
X-Gm-Message-State: AOAM530fk1FpFFXFiswowQ8W1KIgYeN39aD4hWwmPr5NZMjPMpNNFOkZ
 /5yYwmPhj4MMECSiItzKiYoGB1oNyqs=
X-Google-Smtp-Source: ABdhPJxdKp0HTLF54QUNCDS/RfutzAYTnKkUdZ+hvKfjD8MXi3huuEOAUhUKVfxoX4xcVoirspXW6A==
X-Received: by 2002:a05:6512:370e:: with SMTP id
 z14mr1115113lfr.80.1601478585016; 
 Wed, 30 Sep 2020 08:09:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id l8sm223130lfc.124.2020.09.30.08.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 08:09:44 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <30808bd3-a546-e981-00ff-34c07ee1a678@gmail.com>
Date: Wed, 30 Sep 2020 18:09:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930084258.25493-3-nicoleotsuka@gmail.com>
Content-Language: en-US
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

...
>  static int tegra_smmu_attach_dev(struct iommu_domain *domain,
>  				 struct device *dev)
>  {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
>  	struct tegra_smmu_as *as = to_smmu_as(domain);
> -	struct device_node *np = dev->of_node;
> -	struct of_phandle_args args;
>  	unsigned int index = 0;
>  	int err = 0;
>  
> -	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
> -					   &args)) {
> -		unsigned int swgroup = args.args[0];
> -
> -		if (args.np != smmu->dev->of_node) {
> -			of_node_put(args.np);
> -			continue;
> -		}
> -
> -		of_node_put(args.np);
> +	if (!fwspec || fwspec->ops != &tegra_smmu_ops)
> +		return -ENOENT;

In previous reply you said that these fwspec checks are borrowed from
the arm-smmu driver, but I'm now looking at what other drivers do and I
don't see them having this check.

Hence I'm objecting the need to have this check here. You either should
give a rational to having the check or it should be removed.

Please never blindly copy foreign code, you should always double-check it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
