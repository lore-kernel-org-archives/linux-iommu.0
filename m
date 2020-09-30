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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14372C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 21:24:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846632075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 21:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXjsNbxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846632075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B3A386F66;
	Wed, 30 Sep 2020 21:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDaETv46Jgu0; Wed, 30 Sep 2020 21:24:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8818A871D4;
	Wed, 30 Sep 2020 21:24:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F230C0889;
	Wed, 30 Sep 2020 21:24:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7BD6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 89EFD203A8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jpPK2r5mPfNX for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 21:24:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 291D6203A7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 21:24:29 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id n25so2854559ljj.4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w7o/225bpCqBg7FmoWrj/SlNuFA9GxGFAjODbwr8ThA=;
 b=eXjsNbxQqWC5CCwUu0puomcGEldKCcKmI8va7D2gUg851zg1BA+c3zkKJ0dBQVbi3p
 qD0rvTyXPPz7eq/yxfyje4zD07KO9hAgoEfoLXjglZrjSBupeQz4EN5gLGAHzNPvqrnm
 ONdhWJPmxCBO2Ii+nIcHV5UHiX9/1TqLY+/Tt9Z4kEAFmxRnqlk/gmeHZIVClgLeUxPR
 b0tmypFPj17AJ74vzTIOhBY88as2kCPAtfXpOwncrW4QfyzigcM00eTRfksMwOwz8tgf
 MNCdpU6lzZiM9CqX1X4Sb1MTKvuJ+9O2Em351/8knDMKj5uSJJMHu/tVv49rFv/mmAao
 RBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w7o/225bpCqBg7FmoWrj/SlNuFA9GxGFAjODbwr8ThA=;
 b=iV7yIXuThv9gPCSVFNsB4dBbawhNF4Pp4FcXBcnQW9l2bU0AaXZod8Kvq1gG5xQALV
 UDT7uZbKsD5BLUFLMXDa8YXKWQld2er7tjJUGGsjhR144tvZ/mOm8DP54FUq/8XjRmh0
 I1MG1wCv6x4PewDremcSGahTWc/hLXk2Gtp8Aof9Xui7cEV11W09zHp9ELcTN6toFud2
 +ZuXYroinadOX3zORBxAU/DHfNNhpftZPgIlCB3U4Zz0F30JgdDuemfzYX9Sts4ZDVn9
 CoxC4ScnexOz7ski9cnNC+3d56Nt4P1yH0vQXZrzBQUpkKejGfyOyUxnMMQZp0UhWDfq
 mMdQ==
X-Gm-Message-State: AOAM530xjLPXvO8ZRkhIP3z++yBY4ayq6yDpnnZzVTLcGDBHqv92pMHw
 zkWCJsRYte1R0L91Oo8L4H4=
X-Google-Smtp-Source: ABdhPJxazgKnQ5JAOpCi1Vg2QPdUoElCCe0hJ/hGbfuYkEhuKGv1ohTnGFJKhfl79I++iT+FqdRVTg==
X-Received: by 2002:a2e:880d:: with SMTP id x13mr1482497ljh.20.1601501067211; 
 Wed, 30 Sep 2020 14:24:27 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id n3sm315733lfq.274.2020.09.30.14.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 14:24:26 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo> <20200930203618.GC2110@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
Date: Thu, 1 Oct 2020 00:24:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930203618.GC2110@Asurada-Nvidia>
Content-Language: en-US
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

...
>> It looks to me like the only reason why you need this new global API is
>> because PCI devices may not have a device tree node with a phandle to
>> the IOMMU. However, SMMU support for PCI will only be enabled if the
>> root complex has an iommus property, right? In that case, can't we
>> simply do something like this:
>>
>> 	if (dev_is_pci(dev))
>> 		np = find_host_bridge(dev)->of_node;
>> 	else
>> 		np = dev->of_node;
>>
>> ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
>> sure that exists.
>>
>> Once we have that we can still iterate over the iommus property and do
>> not need to rely on this global variable.
> 
> I agree that it'd work. But I was hoping to simplify the code
> here if it's possible. Looks like we have an argument on this
> so I will choose to go with your suggestion above for now.

This patch removed more lines than were added. If this will be opposite
for the Thierry's suggestion, then it's probably not a great suggestion.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
