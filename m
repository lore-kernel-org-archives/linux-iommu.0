Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A07C48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:45:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A776C613D8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A776C613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73A3B60A75;
	Wed, 16 Jun 2021 11:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbVpGbOMo6q5; Wed, 16 Jun 2021 11:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F3C660609;
	Wed, 16 Jun 2021 11:45:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B466C000D;
	Wed, 16 Jun 2021 11:45:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1D6BC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FCEE403E8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vhbyPBYzBJNn for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:45:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D563E4045B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:45:44 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id e25so3430463ljj.1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dtd/r4kQdNTFgMzEtuMDxRln8AeazBFMNuFE+IwxLQ0=;
 b=tM9YyD9dbmrU6QAIak9v1L1Hze3NeFQPPNBEtD4omgZjEyhQcUg1q3wkLUmDpwXXOT
 6u+FMb976YVcaypY+NkjNsra9tUi2NzMsuaXdS253tuTX+l569fNkUgrvOzggDbWTp8W
 ENky2qq1vTSb11/DZgVTmvzbf9N+SWxrHqqLmE895cQUdLDT00v5gJHuqst+RLC6DELx
 AZubyEXZLMybvYei/eZAvnHzFQnU3mWT2NbfPe9zTz+GpRTN5egfyB5q61LhPml0mNjt
 9xsP8j3AJPQS9llNh712rLD/eGmKOg1uNQpb4kiRypPtttLcmaoFcMAzMHxwwR+iDCTV
 h9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dtd/r4kQdNTFgMzEtuMDxRln8AeazBFMNuFE+IwxLQ0=;
 b=NHPtZnljp0pvZbV9QxSkx64UDXh5kj2h0P0gcYn4ltK4+rdNyac9iU9QcMkMdHGvCW
 nALzGkN62ufI9arg3ul+soYw9m3N6E76ibMlgU28T7qoDoNXQcEtGjdSwsnRKSy6e6z1
 RlVbqJID8CPU+wDJgYKi66ODYW6tDx5tUhnngvXzrobqGI2Nn+0ayfRGn8JjQ44aFzXc
 +Yhgf/vZMDW0jDtw+CmfzVqznjEvnEgAqoQ45iMpJy7eaRbRFVMwCUMCrdHKZkBsBxM2
 L7iwF5znkckmOhpMD+qyucr1TD2Ut0Tm4ZRp5TthyCXo5D73+qC1hv/j2zPQrzbsry4p
 cdjg==
X-Gm-Message-State: AOAM532MmtrxdBPXAZaYTiotVQH+zb+oYab3G5SkA8fC14bQoJcVzU5F
 tMyRRoqUDyTjm9VztQdaV6yUTQOSgVMNC9OWQf4=
X-Google-Smtp-Source: ABdhPJzI40Mx409ixL6A8VaGSABYZuuy5E1EPuBErhnFhAQBqUvi8LwmZwSBohmrfaadIq0f8nBwGp02vfH8jjD6rDc=
X-Received: by 2002:a05:651c:291:: with SMTP id
 b17mr2735729ljo.497.1623843942771; 
 Wed, 16 Jun 2021 04:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210611095528.9230-1-roman_skakun@epam.com>
 <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <CADu_u-MqALJkG8RJHrr65vC_sHu-UyvCGwwUfaBong0eir5+hQ@mail.gmail.com>
 <fbaeaad5-ea8a-ff2d-2e62-d27b4d234e8e@oracle.com>
In-Reply-To: <fbaeaad5-ea8a-ff2d-2e62-d27b4d234e8e@oracle.com>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Wed, 16 Jun 2021 14:45:32 +0300
Message-ID: <CADu_u-MgdJYH-sf57AL_Fg3AnjpHoZ1Bk1nxytmoupJc=hJDfw@mail.gmail.com>
Subject: Re: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 xen-devel@lists.xenproject.org, Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

> We make sure that we allocate contiguous memory in xen_swiotlb_alloc_coherent().

I understood.
Thanks!

-- 
Best Regards, Roman.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
