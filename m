Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BBEC4167B
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 09:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 950AE60797;
	Wed,  2 Mar 2022 09:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXH-LTrgUVmX; Wed,  2 Mar 2022 09:47:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 52EF560782;
	Wed,  2 Mar 2022 09:47:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32666C0082;
	Wed,  2 Mar 2022 09:47:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0134C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 09:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC81A402CA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 09:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fga6Cyu4FyqD for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:18:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE788401DF
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 09:18:39 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id r13so2335950ejd.5
 for <iommu@lists.linux-foundation.org>; Wed, 02 Mar 2022 01:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4LuLQynsRS5ZDdiypHmCRhWOSK0fPQgMoxmBubsA8FA=;
 b=YwA2Tp9/WRHVf+AhpCscraLQ5YZMBIbTnjRD9qXALixvArniZHwws+D5eKFYJ4w9RG
 r5YPECm/lP0oAUKfe9WRJhv6+FML2S+XIXHKeVDBXWzTRzpq8V5VyDtMBBLt+RgC4uif
 rGbJjiYJ+RaebcdTWE+lgavU2sjB3KE2oYMSI2g0SnLEMM8BFRLk6tjS00Xev2qK5BZV
 5Ssf9EZ0tsmaxYSBGN+JYRBhKcBJnRtyUIj9fj+nmKF1+vj7CNwKABPlCEiIkg4HqhVl
 prjve+Nrt6ySEZf00Hzlz9gQ4nrt4ykYynGeggVTPypi2WOB4Q0/x8pbTwKWJmRWzNiw
 F8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4LuLQynsRS5ZDdiypHmCRhWOSK0fPQgMoxmBubsA8FA=;
 b=dVVd5iYRlpC6xxPcG7wbNTpTvmRweTMrTF9igzKmf2IjKfh7pQaXOXzUAIkPIXHwj5
 ZNyxHfLaHPO2FJ95pwYqJ0dzVACTlygqMf+GQ//6K01tSlfMlcfoQeG99S+moJzS71XJ
 baf4y7vLQSYg0V30Sr4D5QnqSLnxvah156Mt+J3rsGb9aOhfGxdsxUHAKCKM+Bo+NMCi
 FgzuWDJJpINdPVPjoF0959+Y9RPFYU2jPKjK4BgMNRzZG8a3Lo0pkm3pJQ3BI7hJY68I
 aS+0Nly/2jn5fhMUTZ/wYhoxtvtdRpHD+UF4yuFRfYa4V1A9KHvJjbF8I1ANg2VlBE+k
 c7bg==
X-Gm-Message-State: AOAM530j+NgrnT3ovxLhWqbYgo4tgwp4HuMaaepJrL9WbFsbQMWHmRwp
 r33VJxkCXpaqRk1OzXcokh6Rtl0TJfb22hO8G6c=
X-Google-Smtp-Source: ABdhPJxefZcxfzkkMgbjOK8FTIKDUrSjhwIhlbq76ukZRP/HPSQoF7TsleylqvSIE+LRhSKcwrjAT6lGtFvgDJjKhNk=
X-Received: by 2002:a17:906:9f06:b0:6ce:36da:8247 with SMTP id
 fy6-20020a1709069f0600b006ce36da8247mr21813101ejc.651.1646212718008; Wed, 02
 Mar 2022 01:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20220227143055.335596-1-hch@lst.de>
 <20220227143055.335596-8-hch@lst.de>
In-Reply-To: <20220227143055.335596-8-hch@lst.de>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 2 Mar 2022 12:18:26 +0300
Message-ID: <CADxRZqxrjp4erFNorH+XqubZWLRNjw2E14z7vOW537no1eKnhw@mail.gmail.com>
Subject: Re: [PATCH 07/11] x86: remove the IOMMU table infrastructure
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Wed, 02 Mar 2022 09:47:37 +0000
Cc: Juergen Gross <jgross@suse.com>, linux-s390 <linux-s390@vger.kernel.org>,
 linux-hyperv@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-riscv@lists.infradead.org,
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

On Sun, Feb 27, 2022 at 7:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The IOMMU table tries to separate the different IOMMUs into different
> backends, but actually requires various cross calls.
>
> Rewrite the code to do the generic swiotlb/swiotlb-xen setup directly
> in pci-dma.c and then just call into the IOMMU drivers.
...
> --- a/arch/x86/include/asm/iommu_table.h
> +++ /dev/null
> @@ -1,102 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_IOMMU_TABLE_H
> -#define _ASM_X86_IOMMU_TABLE_H
> -
> -#include <asm/swiotlb.h>
> -
> -/*
> - * History lesson:
> - * The execution chain of IOMMUs in 2.6.36 looks as so:
> - *
> - *            [xen-swiotlb]
> - *                 |
> - *         +----[swiotlb *]--+
> - *        /         |         \
> - *       /          |          \
> - *    [GART]     [Calgary]  [Intel VT-d]
> - *     /
> - *    /
> - * [AMD-Vi]
> - *
> - * *: if SWIOTLB detected 'iommu=soft'/'swiotlb=force' it would skip
> - * over the rest of IOMMUs and unconditionally initialize the SWIOTLB.
> - * Also it would surreptitiously initialize set the swiotlb=1 if there were
> - * more than 4GB and if the user did not pass in 'iommu=off'. The swiotlb
> - * flag would be turned off by all IOMMUs except the Calgary one.
> - *
> - * The IOMMU_INIT* macros allow a similar tree (or more complex if desired)
> - * to be built by defining who we depend on.
> - *
> - * And all that needs to be done is to use one of the macros in the IOMMU
> - * and the pci-dma.c will take care of the rest.
> - */

Christoph,

Is it possible to keep documentation comments in source files? Or are
they completely irrelevant now?

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
