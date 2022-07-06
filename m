Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB68C433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 08:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6CB960F99;
	Wed,  6 Jul 2022 08:36:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6CB960F99
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com header.i=@ozlabs-ru.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=dk2nJfeF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUHIMSsbGUWF; Wed,  6 Jul 2022 08:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9ABE660FA5;
	Wed,  6 Jul 2022 08:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ABE660FA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A22C0033;
	Wed,  6 Jul 2022 08:36:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52730C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25FC583689
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25FC583689
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com
 header.i=@ozlabs-ru.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=dk2nJfeF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DC5To3w1ORJ4 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 08:36:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99FE083279
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99FE083279
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:36:15 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id e132so13476005pgc.5
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=3rzfxOGSqbmsMXygj1P/cqh2Us2vss/rVotjH7eOiew=;
 b=dk2nJfeFYSbNNmJ7tfrqvCIB0euid3h5zOgKmeIekOTSjhv32mCcyofMLQzJOxVoHK
 aRq8F2c7iJUjCTd7Y/R57xcY2bQaG6ioi6kv+TLcL+BJXAejshlsS8xum/OPiXvWATUT
 vdpXbQt44L+uRaYXT/JYB1kPPRa5y4RCwgzLVcx6cO8cxsxhXpGhmN3kN09lXKVIZ1EV
 2RM/eb4YmuKY00crYGVaIq/BcRRUuz6NJ06G7GmqQXyCv3np8UGtERkM6G7D8uEfqBjH
 kNj56D5Yll5Oi4SUi1xuGmI0nMVIO/WeFD/kdtiHRvSGSaLJFJ39dLB9U3M7/SenAMsI
 7e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3rzfxOGSqbmsMXygj1P/cqh2Us2vss/rVotjH7eOiew=;
 b=w/T5iiMM5zdCo0zq8KNHUYW/P8oZXKHFlmAamro16UrT+mi5ojkXr9obgiJHc4Mo+S
 ym5CGwqKjZE4ls5t9Fch2ojdJ8VD06pB8IKXouDLqbHI7Cl4cfnpo8zgQ8dJI1ajAb5B
 IXfbq0aycj5A8RfzAvQwkQncXBdqJD9Hm4lNpIbIzqJHAjoaQSplzOfdLkE/3TyX5bnk
 Jbi4/0BUswIwDu5btRe6mqKZs4pd9KtDat9L15o86v9U96nvMB80ZmhQ6zo9UFvW6Yru
 TS2U0iXSFGd2Xcq8PuW/nU3bJzEl8PNnphvyShVLVPt/lYDHCRFbG9S/Rc/Sn8DaCOja
 Vcgw==
X-Gm-Message-State: AJIora9381kzLAG5G+RXaEN67l17s7jCKVkuX6ZFDLgze6eIG68RxrdP
 Lae4DQBC5Mbqt/maaA3fS2mmjg==
X-Google-Smtp-Source: AGRyM1tFhqz+nKiml8dYdUjMlqXU6Xc6JmbRL/P4emD0Q/E95wuRF7UkZpzP0rKmsb8rD5oZaq+n2Q==
X-Received: by 2002:a05:6a00:17a7:b0:525:4306:72ad with SMTP id
 s39-20020a056a0017a700b00525430672admr45748510pfg.42.1657096575284; 
 Wed, 06 Jul 2022 01:36:15 -0700 (PDT)
Received: from [192.168.10.153] (203-7-124-83.dyn.iinet.net.au. [203.7.124.83])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a056a00080e00b00525b61f4792sm19405754pfk.109.2022.07.06.01.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 01:36:14 -0700 (PDT)
Message-ID: <aef1d470-e8a0-4ba8-2a55-adf05b836684@ozlabs.ru>
Date: Wed, 6 Jul 2022 18:38:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 09/14] iommu/ipmmu-vmsa: Clean up bus_set_iommu()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 28/04/2022 23:18, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary. This also
> leaves the custom initcall effectively doing nothing but register
> the driver, which no longer needs to happen early either, so convert
> it to builtin_platform_driver().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 35 +----------------------------------
>   1 file changed, 1 insertion(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 8fdb84b3642b..2549d32f0ddd 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1090,11 +1090,6 @@ static int ipmmu_probe(struct platform_device *pdev)
>   		ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
>   		if (ret)
>   			return ret;
> -
> -#if defined(CONFIG_IOMMU_DMA)
> -		if (!iommu_present(&platform_bus_type))
> -			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> -#endif
>   	}
>   
>   	/*

The comment which starts here did not make it to the patch but it should 
have as it mentions bus_set_iommu() which is gone by the end of the series.


More general question/request - could you please include the exact sha1 
the patchset is based on? It did not apply to any current trees and 
while it was trivial, it was slightly annoying to resolve the conflicts 
:)  Thanks,


> @@ -1168,32 +1163,4 @@ static struct platform_driver ipmmu_driver = {
>   	.probe = ipmmu_probe,
>   	.remove	= ipmmu_remove,
>   };
> -
> -static int __init ipmmu_init(void)
> -{
> -	struct device_node *np;
> -	static bool setup_done;
> -	int ret;
> -
> -	if (setup_done)
> -		return 0;
> -
> -	np = of_find_matching_node(NULL, ipmmu_of_ids);
> -	if (!np)
> -		return 0;
> -
> -	of_node_put(np);
> -
> -	ret = platform_driver_register(&ipmmu_driver);
> -	if (ret < 0)
> -		return ret;
> -
> -#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
> -	if (!iommu_present(&platform_bus_type))
> -		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> -#endif
> -
> -	setup_done = true;
> -	return 0;
> -}
> -subsys_initcall(ipmmu_init);
> +builtin_platform_driver(ipmmu_driver);

-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
