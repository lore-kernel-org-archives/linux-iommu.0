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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09AC4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:41:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D01B2076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEMQ+z3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D01B2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E14952010D;
	Wed, 30 Sep 2020 14:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o7w9vlKyX4HN; Wed, 30 Sep 2020 14:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BF6C420337;
	Wed, 30 Sep 2020 14:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B90CFC016F;
	Wed, 30 Sep 2020 14:41:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27595C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0B07620337
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eoQ9cSyozYTV for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 14:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 7BC572010D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:41:45 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id y11so2454580lfl.5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d/fQGHk0RGcvSyO7Alc7YxaloLPaa9kMj4sfJ/VwT08=;
 b=BEMQ+z3XJa7zab6wRr0sP48ke26xdy1Qs34DjaVa2NyLiI6OoDNLwVTaZbwtlln4+j
 9BNKM1M/hsNreK7GTRJAjEwM247uejaFNZ1YNM/d7MYlrFpsUY2HFvdfQ3D27d8xf7o7
 foD10cJWXgKmctzfd4cPQfrcmTOP08/w1eoIj9i8dSkVQ/lL6OuNRNWUA8QS6OzWD4WA
 4ntbzOLMZ4oJ4YIpe44MfXvvt1iyc3TVsHnlP4t4lpd2711WAVoeTkaD0MHIxRfs60uV
 o+N6BXFrLW2UvkMOcTuFSk44rQoFu5r/rfKkjHdy26g17bstyasiIhctIEE8MNMdB5Zg
 FAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d/fQGHk0RGcvSyO7Alc7YxaloLPaa9kMj4sfJ/VwT08=;
 b=j1y+ZJKb1BCdrYyOOT4NV7Si+bjhkWE+DTu/crfEe3TFg0Ktrke0CIpntkKdAXxQd8
 dYI8K22r57Cs63uAtwVTciW+ezyRHIPdS30nWR6AcbL4yYu/hicUX30tq5WZ1ZkuSPwx
 4L7Ogpxm0P0ENH2qJrSJvGsCrcYwJ1KpkYzlzdQqjKW7VJpW4fpDEk6fySAJE6Hf1h8i
 zFQ9Sfd2gOb+y5/kzpAi0/dFvDc9Pd0DJwhFVPXVfgs7e5/l2yb6rwgl4M3e+Z1TLD+m
 TcKUSC28McAVZ6SvnKgjUwARYNnrCh7ls7mNs2XyydKty746twrVA5C23XRgnH0ng9K5
 5qDw==
X-Gm-Message-State: AOAM530G3nlAl0ancSequgdRKKohGhrQLPVplT1bRFlbFWrZhl9E8bQK
 mXVQGnGL7aS8z9MRxzfXR6E=
X-Google-Smtp-Source: ABdhPJxyN664IN3UyNlM/y7PUcbpe0h2+VOfS9ltqOMC7lfWQIEr88+UNPiqe6pRxBZTt8xbZqdrjg==
X-Received: by 2002:a19:12:: with SMTP id 18mr1001563lfa.237.1601476903445;
 Wed, 30 Sep 2020 07:41:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id q6sm176381ljg.115.2020.09.30.07.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 07:41:42 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <01728f61-df0c-291d-5589-4468be25f00c@gmail.com>
Date: Wed, 30 Sep 2020 17:41:42 +0300
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
> +	struct tegra_mc *mc = devm_tegra_get_memory_controller(dev);
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  
> -		of_node_put(args.np);
> -		index++;
> -	}
> +	/* An invalid mc pointer means mc and smmu drivers are not ready */
> +	if (IS_ERR(mc))
> +		return ERR_PTR(-EPROBE_DEFER);
>  
> -	if (!smmu)
> +	/*
> +	 * IOMMU core allows -ENODEV return to carry on. So bypass any call
> +	 * from bus_set_iommu() during tegra_smmu_probe(), as a device will
> +	 * call in again via of_iommu_configure when fwspec is prepared.
> +	 */
> +	if (!mc->smmu || !fwspec || fwspec->ops != &tegra_smmu_ops)
>  		return ERR_PTR(-ENODEV);
>  
> -	return &smmu->iommu;
> +	dev_iommu_priv_set(dev, mc->smmu);
> +
> +	return &mc->smmu->iommu;
>  }

Is it really okay to use devm_tegra_get_memory_controller() here?

I assume it should be more preferred to do it only for devices that have
fwspec->ops == &tegra_smmu_ops.

Secondly, it also looks to me that a non-devm variant should be more
appropriate here because tegra_smmu_probe_device() isn't invoked by the
devices themselves.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
