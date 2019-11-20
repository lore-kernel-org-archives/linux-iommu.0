Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A9CC432C0
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 21:30:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2BA2084D
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 21:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VFaWU9eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2BA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFFF486F8A;
	Wed, 20 Nov 2019 21:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSuMASb+m62X; Wed, 20 Nov 2019 21:30:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2F3E386E6E;
	Wed, 20 Nov 2019 21:30:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1135FC1DD8;
	Wed, 20 Nov 2019 21:30:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4A13C18DA
 for <iommu@lists.linuxfoundation.org>; Wed, 20 Nov 2019 21:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CB6038828D
 for <iommu@lists.linuxfoundation.org>; Wed, 20 Nov 2019 21:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h3HNBSIwg4N8 for <iommu@lists.linuxfoundation.org>;
 Wed, 20 Nov 2019 21:30:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0177D88275
 for <iommu@lists.linuxfoundation.org>; Wed, 20 Nov 2019 21:30:26 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id c14so989746oth.2
 for <iommu@lists.linuxfoundation.org>; Wed, 20 Nov 2019 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nUDu8pQZs8u4Dn19/rZi/JgFr5hx8f/ET+blpc5+y7Y=;
 b=VFaWU9egorIKHZTBFjI5Fwdj0smrWgFszEVzB7Ip0fjbadB9C0CyXHESHz1qSsZVOz
 F+0J1zvICdKoskSyLaOzB4f/6y05Zaf3boy2QfRyMQmqugTghGWVoZD0pTv0qeEy1x5R
 7YaKDC6RVWnKR8CbISJvBNRSlUEE+9fgdUYmDIZ02pAoqGP/01eTysTN3C4bczgnpStI
 um+mxvQso3f2pn9Bs8WwOFgNiAbRZKwT8PtDbNEFC2MaD1pA1gIMdRyNU7whc1JWzr5y
 i0hKDRzZ741z+p4EY+PhwOJnHkfXE3Nryq/vaTPTFOsQwXoRdkAWAOvKHlAtNxFxO9ti
 v1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nUDu8pQZs8u4Dn19/rZi/JgFr5hx8f/ET+blpc5+y7Y=;
 b=cjTxvZQgUPDbwyZZVQf40VGEHdj1+ZIg26BU8cwzwwhQt7F780iU6dYF5o8q3JseD7
 Mo8YHApYbHm3+UCVC4joskoiQfYTrLqi7VUVBl3zIhU7Ph1TeuLTcAbi4LF7CzYKzlvh
 bdrM7zLJxsDrBSxsnXK5kiDZNjkVBiQvmokIP7vh4c3G1TzftCY2lVqar9HfFd7hFZf3
 A6r4bjl9J1SV0tzGULgmqGpd4L3G8K3qzuQM0Geok38nCgtWl/T8lTI69q1FhWfu/Iif
 wIsz1aEzYf539yGysJvUDAz8QnWzV+XPDIrLLX+VmDMCMHxVTF4xug0ui3Q7RPGMQTgV
 caYg==
X-Gm-Message-State: APjAAAVSdGZ6lWmNaNoX0n6bpKOncpdaU0qHOD3+4s/vyyWdJp1UwmiU
 SeTFLE7piPOA8krlSc6wf4vcQm+l9erk4eBf4mvVmQ==
X-Google-Smtp-Source: APXvYqygFo11WYxCVP+Ff0HIEHLO15X3S5vxH+0fAs3zZpM3s/nSMwLje5GuocvH+GT3Ivkku9sYRuYHvwwpTD5ONKc=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr3780959otl.195.1574285425773; 
 Wed, 20 Nov 2019 13:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191120190028.4722-1-will@kernel.org>
In-Reply-To: <20191120190028.4722-1-will@kernel.org>
Date: Wed, 20 Nov 2019 13:29:49 -0800
Message-ID: <CAGETcx-b+cyzPwfJVKkPzaaDrYNy+gjTTcMZ0MBxBPC2EsVVzQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linuxfoundation.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Nov 20, 2019 at 11:00 AM Will Deacon <will@kernel.org> wrote:
>
> Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> mboxes and io-channels") added device link support for IOMMU linkages
> described using the "iommus" property. For PCI devices, this property
> is not present and instead the "iommu-map" property is used on the host
> bridge node to map the endpoint RequesterIDs to their corresponding
> IOMMU instance.
>
> Add support for "iommu-map" to the device link supplier bindings so that
> probing of PCI devices can be deferred until after the IOMMU is
> available.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> Applies against driver-core/driver-core-next.
> Tested on AMD Seattle (arm64).
>
>  drivers/of/property.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 0fa04692e3cc..37e0d408430d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1190,10 +1190,20 @@ DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>
> +static struct device_node *parse_iommu_maps(struct device_node *np,
> +                                           const char *prop_name, int index)
> +{
> +       if (strcmp(prop_name, "iommu-map"))
> +               return NULL;
> +
> +       return of_parse_phandle(np, prop_name, (index * 4) + 1);
> +}
> +
>  static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_clocks, },
>         { .parse_prop = parse_interconnects, },
>         { .parse_prop = parse_iommus, },
> +       { .parse_prop = parse_iommu_maps, },
>         { .parse_prop = parse_mboxes, },
>         { .parse_prop = parse_io_channels, },
>         { .parse_prop = parse_regulators, },

Heh... a lot smaller than I thought this would be.

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
