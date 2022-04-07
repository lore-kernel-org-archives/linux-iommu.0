Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCE6C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 061DE612A6;
	Thu,  7 Apr 2022 16:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZg_v9L7iCeC; Thu,  7 Apr 2022 16:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CDA26129F;
	Thu,  7 Apr 2022 16:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02BFCC001D;
	Thu,  7 Apr 2022 16:21:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DEEDC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B47281970
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IbXljUTJoDhS for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:05:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACB1181948
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:05:21 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id d29so8512897wra.10
 for <iommu@lists.linux-foundation.org>; Thu, 07 Apr 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RwGnOv9tuCS4Glh/q7Oki8zffnkUd/Q0fjECuAqwO7c=;
 b=gmV3yEoVNk48jcao6xPblrNPo2DepjB/cLhPBrWrEehQVu9A8va2bBHzlDCfzHi5sm
 GMGDkHH6ugea546NIYx/mw+RooJuDb2MQNzC9pBuoFhkqem4NjIjUbsVCRPkqusvtGA6
 dVISATNeHRq6Pd2MEN/MqxDOQ+nJCDF/HOzwyZpbPbahgsWgkXaSfp10+g3BndlncXnp
 fKf+wkkD+pzzWTAoJGgzOPdI17YByZWb3bC6+tDxp2qzjzgqJuZgDwnr20OdJZb5HX4M
 +n0afAhNsqjK7zxZ6pc3seudiFD8Q2CqvlqKS4dEKu1H8GAlzeI5qwrvzeAFIYfCyJHt
 WdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RwGnOv9tuCS4Glh/q7Oki8zffnkUd/Q0fjECuAqwO7c=;
 b=TAScbCjGQX/Zm5dus2Ewy8KgVahP4fo1YSas2jh0aPBPsJA+NK32oDnI6GU7KuOu+S
 LbUFH+S4/V/0+/L2TsDhFHtbvHuK7dEwvntSb4pT6FHdIYwuT5ugaecXVWnPiYchtsTw
 nO5v7pmQx/KjlaDlCWwGcg7qf1o/J6s8q5IssKDP6FFj5s0tf297wo0pomP6WvkWIktm
 XN9bRr97scbUY5DkabY9IGelHdjXrCHtREQ6AfsBa1fZNP2AxQwoH1wnZgBVV4ldCv7s
 /ZSaCXQNBG78olVLAui+zB0uMMOzAvQLTfhGnQb7wXEx1vQo2F8rSv6U9+AQ/a35mBc+
 c1kw==
X-Gm-Message-State: AOAM533VhaieFgUTp2FP2EwDY3aR7WAKCiK3Ur75Yfactd5Wf5HDZnJ7
 HoNweEpyPFem3VNSEe2fUn8=
X-Google-Smtp-Source: ABdhPJw5LXgWJ0+mFqcCsIxYkYvOGUsbpwr0rk1MnX3hYB9nf98fHqjiWFS+OJN2YQaf4rPa8l7aAQ==
X-Received: by 2002:adf:b745:0:b0:205:b8e2:f470 with SMTP id
 n5-20020adfb745000000b00205b8e2f470mr11089350wre.91.1649347519726; 
 Thu, 07 Apr 2022 09:05:19 -0700 (PDT)
Received: from [192.168.1.122]
 (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c198600b0038cafe3d47dsm8725698wmq.42.2022.04.07.09.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 09:05:19 -0700 (PDT)
Subject: Re: [PATCH net-next] sfc: Stop using iommu_present()
To: Robin Murphy <robin.murphy@arm.com>, habetsm.xilinx@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
References: <7350f957944ecfce6cce90f422e3992a1f428775.1649166055.git.robin.murphy@arm.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <296fa369-723f-f9b7-773f-7695b12c9971@gmail.com>
Date: Thu, 7 Apr 2022 17:05:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <7350f957944ecfce6cce90f422e3992a1f428775.1649166055.git.robin.murphy@arm.com>
Content-Language: en-GB
X-Mailman-Approved-At: Thu, 07 Apr 2022 16:21:49 +0000
Cc: netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

On 05/04/2022 14:40, Robin Murphy wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. It appears that what we care about here is specifically
> whether DMA mapping ops involve any IOMMU overhead or not, so check for
> translation actually being active for our device.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
