Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E790C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:50:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1412820578
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1412820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C4F492042D;
	Fri, 21 Aug 2020 13:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUizCyuGyhtl; Fri, 21 Aug 2020 13:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 11A5F20399;
	Fri, 21 Aug 2020 13:50:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00C56C0889;
	Fri, 21 Aug 2020 13:50:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D855C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EB1A6203AB
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZP3Ob8y9HjXG for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:50:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by silver.osuosl.org (Postfix) with ESMTPS id 9E1F820399
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:50:40 +0000 (UTC)
Received: from mail-pl1-f198.google.com ([209.85.214.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1k97RG-0007WL-Fc
 for iommu@lists.linux-foundation.org; Fri, 21 Aug 2020 13:50:38 +0000
Received: by mail-pl1-f198.google.com with SMTP id f17so1155822plj.16
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 06:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Ixzpb7ZTHJuiKoZP8ciVIDdnuS6WspeERPksthDch4Y=;
 b=HvoKC43p5SXcmThZtLNt2WAAk8IvRm923/s8TSLrGsgEmaTnWyDhAnDGj3Y2hJS57J
 uRrwCyHtbnpCejjnqC0k0RrTlkYIiv8eQRG6GjBxuKRJq2Q7CyzBA7JT7IOKA00l3lQM
 5f0c2/6A9RyamugtnlBrj5fr2ayEYblyoKqOLeBoOd9e/JE4LZ3EfpJqQsKpy2mML/4y
 2D1bUBWd7uWXqm83jhU5/QSmywnPt/6s6okAdAGPCgfoEwfuaVrvrWwjPtBcccFyD6Sd
 2fPniKyMZv6fARwrHym4MRgSmHMeTqI6gQXWaCR2Kd/R4bDG6GAYGGNK3PgYS/skBkNw
 +Gyg==
X-Gm-Message-State: AOAM532KUuV+fqP76ldPFjcuJ0jRGyY4dXoIzxtl1dHQ6vNyQLzyGQjt
 z8m8TshbuN1i8AxI3Q3aW2M/9erYbz2F0FjwBBDo8u0pQWSHbPQ3XjgJWOq481Q6wbHniKsJtQV
 w/qMW/HOklGKIh5zWRHWeZRgJi+Mvqr+Dx27uJ/mLSTWMpgI=
X-Received: by 2002:aa7:9096:: with SMTP id i22mr2636812pfa.310.1598017836965; 
 Fri, 21 Aug 2020 06:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz9IMJ2Q79QQio5v7ZYraOE2lxE3lXGA5Fa/cyXoTyQecljb6qYd041APJoAVi65wVQprz5Q==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr2636791pfa.310.1598017836623; 
 Fri, 21 Aug 2020 06:50:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id r186sm2928966pfr.162.2020.08.21.06.50.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:50:35 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200821134300.GM3354@suse.de>
Date: Fri, 21 Aug 2020 21:50:33 +0800
Message-Id: <5D7A63DF-D360-4453-845C-924F4C13E3DB@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
 <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
 <20200821134300.GM3354@suse.de>
To: Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Cc: iommu@lists.linux-foundation.org, open list <linux-kernel@vger.kernel.org>
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

Hi Joerg,

> On Aug 21, 2020, at 21:43, Joerg Roedel <jroedel@suse.de> wrote:
> 
> Hi Kai,
> 
> On Mon, Jun 29, 2020 at 08:33:22PM +0800, Kai-Heng Feng wrote:
>> I am still seeing the issue on v5.8-rc3. The issue goes away as soon
>> as "iommu=off" is added.
> 
> Can you probably help with debugging this issue? I've had no luck so far
> getting my hands on a machine with tg3 hardware and an AMD IOMMU.

Of course, I still have the system at my side.

The offending commit is 92d420ec028d ("iommu/amd: Relax locking in dma_ops path"), however be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api") removed .map_page entirely so I don't know where to start.

Kai-Heng

> 
> Regards,
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
