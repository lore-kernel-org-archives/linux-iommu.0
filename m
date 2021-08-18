Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1438C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 20:42:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AA8610F7
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 20:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46AA8610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C597405F7;
	Wed, 18 Aug 2021 20:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ylsZ1R4f61cv; Wed, 18 Aug 2021 20:41:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95A99404AB;
	Wed, 18 Aug 2021 20:41:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DF99C0010;
	Wed, 18 Aug 2021 20:41:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2393BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 20:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3C9460622
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 20:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gMuI4arwVJqZ for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 20:41:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAA316060F
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 20:41:51 +0000 (UTC)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 56C3C3F36B
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629319303;
 bh=UOE20OlnZGDBI1w8hzaIpuPN6xfmK8WguChjFrKnZuU=;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=AMPMxxlzH93EbqKkvvLs1/DuQFC7yPashajwqCWDTb5Z9STiD2KQD41p3+feaJbPp
 /cavtIUhM2VD1MxPW7G9Pv9TOz0eUjj1uCFo4t/f6c0z0V4e7J1eWINFZGX4DmGZwg
 /V9g9bFGwUVunKivZPtwf+GOK3tvuP0OLH7ybfssKcqx9c51xRFTvCHxFn73IFxyHJ
 xCOGkA/NksndsMW8fZQ6Abiu+eVTqGyJJ3lttmpJQ6IDjMTDMSWp5pOczdmsfKLXsn
 elTPpgn1cjxoz4n6IVIyL+lyUFHLky2PUsVs/GC/3m11yuONC2thZ7mTLXMiewr1Vx
 WFBrpiBsD0KsA==
Received: by mail-ed1-f70.google.com with SMTP id
 j15-20020aa7c40f0000b02903be5fbe68a9so1675828edq.2
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UOE20OlnZGDBI1w8hzaIpuPN6xfmK8WguChjFrKnZuU=;
 b=H0KGIdrQYavNAywVCnxiqbpawVPFX65uf626st3HMQAnOBrksJalbmmNt4oJ5KkTEQ
 LcvwGGF8HkqGqT6BdB3Y/8m+PK79ih0geygWXQ1Hz+isa00F8jE2V7PTEpIGI5C1WYqk
 ryzrUZ7wXRILmWLLrcCFJooAyl4nmh7Am7NS229CM4It22E8GBSmz5ELAyaAAM6ycmU/
 QjsNfY8xDpWmTGoCm3i0WBS9zvUf81j55O3fTDs4WgqbqtnvBkGcvVCpruZrZ1r6fMI3
 OH7Ch4s3zts0Tp81zOD6B2yaSoE6KTmysfgTd+IhE0xue63eWpbdXRewfw2pmcA6Vstw
 CIvw==
X-Gm-Message-State: AOAM533Xoi9+6O1C+3+1RaeW+pqR/YUuZNBQzaXKZRptxvpq/+zWCMNt
 1RxgEOpZb91vvwDVZKt3zwWx52eMaD4sDTdrO7QVDvErOFzHqiaS+M0VA/EJRM2JOW5dHc4r45V
 pg8ltPl3O9bI0aQC8dG9FUIYNHD13Efh3MwN1HdZOoW+1okE=
X-Received: by 2002:a17:906:bc81:: with SMTP id
 lv1mr11590276ejb.393.1629319303108; 
 Wed, 18 Aug 2021 13:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuYU3uP7y//yQFosQFGT8VE96LJF4E5eKGo52ons6ugHXq2GC+IHUQY+3g7aV0U22I95MmCg==
X-Received: by 2002:a17:906:bc81:: with SMTP id
 lv1mr11590254ejb.393.1629319302920; 
 Wed, 18 Aug 2021 13:41:42 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
 by smtp.gmail.com with ESMTPSA id kv4sm360228ejc.35.2021.08.18.13.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 13:41:42 -0700 (PDT)
Subject: Re: [PATCH v3 00/13] MT8195 SMI support
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1a160afd-ceeb-04a3-8213-fe781ec18e30@canonical.com>
Date: Wed, 18 Aug 2021 22:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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

On 10/08/2021 10:08, Yong Wu wrote:
> This patchset mainly adds SMI support for mt8195.
> 
> Comparing with the previous version, add two new functions:
> a) add smi sub common
> b) add initial setting for smi-common and smi-larb.
> 
> Change note:
> v3:1) In the dt-binding:
>        a. Change mediatek,smi type from phandle-array to phandle from Rob.
>        b. Add a new bool property (mediatek,smi_sub_common)
>           to indicate if this is smi-sub-common.
>    2) Change the clock using bulk parting.
>       keep the smi-common's has_gals flag. more strict.
>    3) More comment about larb initial setting.
>    4) Add a maintain patch

The patchset looks good to me but I saw now comments from Rob, so I
expect a resend. Therefore there is also time for additional review -
maybe continued by Ikjoon Jang?

If you sent a v4 with fixes rather soon and get ack from Rob, I could
still try to get it into next merge window. After this weekend I won't
be taking patches for this cycle and it will wait for the merge window
to finish.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
