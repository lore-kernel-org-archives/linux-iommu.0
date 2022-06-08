Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E55AC43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 17:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DDD040A12;
	Wed,  8 Jun 2022 17:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVJgIcskufwM; Wed,  8 Jun 2022 17:28:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C887A40002;
	Wed,  8 Jun 2022 17:28:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A580DC0032;
	Wed,  8 Jun 2022 17:28:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5B76C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D375540A0D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdZB52nQgfcd for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 17:28:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 585BD40002
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:28:04 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id s14so18213019plk.8
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 10:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dpHSA3kj0eHHqdYze/RCpBE0tw7cvZjVvQOy/DfoJ2s=;
 b=ltlaHerkFpX0nHtPz59Psfs04hvr4qt2Qm8Z8QPAiYikZb+rpTsoyM/okXp7hK/zEN
 lkgdvHHyM2s9U/sDDns+Ccabnxpe3Rdg5Eaz7Zz8PyWYMyiPfN1CawS8vr0RSmPL0cQV
 JYjy+ZOLke+fGNVJ0HqrZaSK7XyU+PaOEK17kJDpeQzoPw1v0Z+7zw5N+uD7QvuVW2al
 b9CLD/bo7IUTsJf/o5nejM+QA9VtuPCoSqHBQt72tGyRaB5JF/sxXvjaQyzjKuj9Lb5w
 ucaf1tbjdB06KFYLhL2XiD3KBz3egj2mWFQ0Q7zNujLXhaQAQ5Eh7Xd/t5GQA/ZxHgAU
 QJAg==
X-Gm-Message-State: AOAM530p1oaNCGZnzWkh0TkMNTbPzVGzWru8tRx9YfvKqvbbHjVIybvg
 gWzLoZETAV3IkC2hnOiNdTk=
X-Google-Smtp-Source: ABdhPJzMDpvgYrNyCdrUrf5LIBVmTVoNnNeogBR/uNjDb79MyeVN9aegG63yruaNNjBQ7ETB9eku5Q==
X-Received: by 2002:a17:90b:3a87:b0:1e8:8079:b7e6 with SMTP id
 om7-20020a17090b3a8700b001e88079b7e6mr247147pjb.139.1654709283698; 
 Wed, 08 Jun 2022 10:28:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39?
 ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a170902c45300b00162496617b9sm6030401plm.286.2022.06.08.10.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 10:28:02 -0700 (PDT)
Message-ID: <543345ac-fbfa-1020-b6c7-72f65412f444@acm.org>
Date: Wed, 8 Jun 2022 10:27:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] dma-mapping: Add dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-2-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-2-git-send-email-john.garry@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/6/22 02:30, John Garry wrote:
> +::
> +
> +	size_t
> +	dma_opt_mapping_size(struct device *dev);
> +
> +Returns the maximum optimal size of a mapping for the device. Mapping large
> +buffers may take longer so device drivers are advised to limit total DMA
> +streaming mappings length to the returned value.

"Maximum optimal" sounds weird to me. Is there a single optimal value or 
are there multiple optimal values? In the former case I think that the 
word "maximum" should be left out.

Thanks,

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
