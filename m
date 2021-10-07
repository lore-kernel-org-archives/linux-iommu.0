Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527ADC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 20:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54D861139
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 20:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D54D861139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9EE0F40161;
	Thu,  7 Oct 2021 20:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LPPUf3OLjTHD; Thu,  7 Oct 2021 20:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4DCBD401AD;
	Thu,  7 Oct 2021 20:22:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F076C0011;
	Thu,  7 Oct 2021 20:22:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6835C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 20:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7CB160754
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 20:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fmVDZWShMxcy for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 20:22:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 263A06071A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 20:22:32 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id p1so6272905pfh.8
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HMaYYwsvFJu5yPYeNceqJv1VciF17Wkz8xL47+/e1L8=;
 b=J4ObbtFRwTCG0JKtwfHFlWa3eyOzbC9HVmhoQwJOBNP4h+lo96nNKpk4NwBL1oM3RX
 qEO5ahF6tAERGlLyvxmiwnjk9qZHfIG3vbKhVHFnEWwOXFElr9eRS+VkuANLU+kDVFBa
 o6eiWzGdpvpTONifC0Kpmxm+IpNQaqtu331D3ImpmMUfB3tqGKN+jFb8hzT9mfR/KiO4
 5XxWFBQzQGG94c7qaDOTHFpvjR1sj4cqtPmUK0yl5/4X91Lfkz5cw0E5rcyhx8qNUMed
 xQ9qew0VfhNWkCmxZQDbZ/VYKajeVVaa7zhbgOWLzmUnpqa05KpT+tV87xMPtpA6dL3y
 S4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HMaYYwsvFJu5yPYeNceqJv1VciF17Wkz8xL47+/e1L8=;
 b=m/hoScjcNTGLnTVk6UPVEnQsJLpOVWSTIbb2AVaXZ7n5KRnweurLQkRj7tlyCAlxjR
 hRlwDsX9EHEKAFfQxKKIdzsPjxj69iA3ZDbHCG+KgVpOFKnhn27hIy9b7pmJA2/ai8B0
 V6rEt0Hkz8r12lsJ1NOPxmTEM09CFlRrxZ/GCFI2nT1Zg71EJUCqXqKcrqUFSeChL/ef
 R6wac5reB6+igrUwB3R3IJuJBeyFvzpUIBcVJmTDPij61TtBfJUoJXEJ+EriHfjz8JJw
 YyMSs6wUJMnyCYhMHR3vAYo2M66IRXfJ2UC9vxayym/QwVl5l5Upo2dlHOmDrl2RgPn4
 YcZw==
X-Gm-Message-State: AOAM533TgUEDtkJDahPf32RcMwcdtMEMxUMyB3otiyoY7GckNQsoqBWP
 usyLJNXOv+LTcOnlF9+61cE=
X-Google-Smtp-Source: ABdhPJyWqbvttFSUpjAZX/J/4Z8uWkF6W0LrsVdB4sFKKLf9QDWamxebP3Su12mkH8ig8En3cJ8KGA==
X-Received: by 2002:a63:101c:: with SMTP id f28mr1336126pgl.330.1633638151472; 
 Thu, 07 Oct 2021 13:22:31 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d18sm188951pgk.24.2021.10.07.13.22.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Oct 2021 13:22:31 -0700 (PDT)
Date: Thu, 7 Oct 2021 13:14:56 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 2/6] iommu/tegra-smmu: Rename struct
 tegra_smmu_group_soc *soc to *group_soc
Message-ID: <20211007201455.GA20821@Asurada-Nvidia>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-3-nicoleotsuka@gmail.com>
 <YV8lbCePQet+vICa@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YV8lbCePQet+vICa@orome.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 will@kernel.org
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

On Thu, Oct 07, 2021 at 06:50:52PM +0200, Thierry Reding wrote:

> >  static const struct tegra_smmu_group_soc *
> > -tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
> > +tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
> 
> This one might be okay to disambiguate, but even here I think this isn't
> really necessary. It's already clear from the return value what's being
> returned.

The point here is to disambiguate "group", as there are quite a few
places using the same naming for different structures. You may argue
that it's clear by looking at the return value/type. But it is still
hard to tell when reading the code of its caller, right?

> > @@ -921,9 +922,9 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
> >  	}
> >  
> >  	INIT_LIST_HEAD(&group->list);
> > +	group->group_soc = group_soc;
> >  	group->swgroup = swgroup;
> >  	group->smmu = smmu;
> > -	group->soc = soc;
> 
> As another example, it's pretty evident that group->soc refers to the
> group SoC data rather than the SMMU SoC data. The latter can be obtained
> from group->smmu->soc, which again is enough context to make it clear
> what this is.
> 
> So I don't think this makes things any clearer. It only makes the names
> more redundant and awkward to write.

Okay. I will drop the part of s/soc/group_soc.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
