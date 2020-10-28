Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96411C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 23:19:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C74520796
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 23:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="SpwfTtMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C74520796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7E698744F;
	Wed, 28 Oct 2020 23:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KV8e76Y1qavT; Wed, 28 Oct 2020 23:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF31B873B9;
	Wed, 28 Oct 2020 23:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 966B8C0859;
	Wed, 28 Oct 2020 23:19:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4D58C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 933B184D7A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNZctHnaQRMH for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 23:19:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BE34884974
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:19:35 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id 133so722490pfx.11
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9KLgU2ii04BMgmi9GJzMZxGva6u6t/mvJPjkoxUhr74=;
 b=SpwfTtMc6fpZxAapRbEYqZhJ275joqIjQxSqHFrK4Yekqe+Gh2zz6qdapj9A1/J6xI
 foQfDDB0AVcez/2sNAO+Vh7ZW8qJCyoy9o3KnSyOfL1YPG6414L3YyOl4Njh8oZ8j6cN
 k/wpFmINd26rcv9udGDVOqncEZKOYKWgN538CHGj59P1jCeuXhh4uJhVDNt/VOl8thrA
 6gQgeAs5qDBHuJGVR26BnE+b3PWJaR95jKJGVTFY9pcLxUn1YiPeNXt/l0VYXsG6V6rf
 jRAzk4WcwmAviBfA8VMWZx8MtjV20TQ/6IZFDqchgrG1GICr9zCbtwiBXkLs+Jmdbxyv
 Ab1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9KLgU2ii04BMgmi9GJzMZxGva6u6t/mvJPjkoxUhr74=;
 b=lqPFRvXfg8XsmACXHllMKjrpo9CeWKWyNFdD30Y8WH84utdy3E6E/7ikczFjdoR7Pm
 k5J5DKh6X8iIvfmHSWDJ9Z7Aj8fb3YRXipHimkxDe/6Ni/Y0A7dNKkxlZDukt0TIW7nr
 MowmMCfZ32hnBPip5qpATGvAfhdtRKUfTxd45PRNbPaxlD5D1C/aXi56+Rbkh09RbGH6
 n1vgrCRiN38o3BFs+7kl1Zq4Arnn1s5EJiDxh3YR+YW0Ulmww7tyKVFOeyEF43lrwawe
 QRACS6S3auGTuaAogFzwYEjxr5aboVLx/edvrQJUDxeHNSk5T9o8iK4rxDUL2+JNLTTh
 RHxA==
X-Gm-Message-State: AOAM531bBvM1uBQcDwU7xcntDriBAle2fCFwRoDYKsKDu77LO2rOPzqR
 fiEwRLXch58AiH2tOhPcGpHvHz4w1P21bQ==
X-Google-Smtp-Source: ABdhPJy00goGFzfZHxvXhNS7gg6ez4rHGE2d6wvUjsKkNkmVUyn+UFMehJccnUwS8rJlbF8q7y3A5Q==
X-Received: by 2002:a63:1649:: with SMTP id 9mr1419124pgw.91.1603926711033;
 Wed, 28 Oct 2020 16:11:51 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au.
 [124.171.72.187])
 by smtp.gmail.com with UTF8SMTPSA id q5sm449440pjj.26.2020.10.28.16.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 16:11:50 -0700 (PDT)
Subject: Re: [PATCH kernel v2 1/2] dma: Allow mixing bypass and normal IOMMU
 operation
To: Christoph Hellwig <hch@lst.de>
References: <20201027101841.96056-1-aik@ozlabs.ru>
 <20201027101841.96056-2-aik@ozlabs.ru> <20201027164858.GA30651@lst.de>
 <28147035-500d-f3cd-f283-257066343697@ozlabs.ru>
 <20201028172106.GA10015@lst.de>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f4420b19-05cd-5817-9ba4-8f6f166a7e5c@ozlabs.ru>
Date: Thu, 29 Oct 2020 10:11:45 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201028172106.GA10015@lst.de>
Content-Language: en-US
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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



On 29/10/2020 04:21, Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 05:55:23PM +1100, Alexey Kardashevskiy wrote:
>>
>> It is passing an address of the end of the mapped area so passing a page
>> struct means passing page and offset which is an extra parameter and we do
>> not want to do anything with the page in those hooks anyway so I'd keep it
>> as is.
>>
>>
>>> and
>>>      maybe even hide the dma_map_direct inside it.
>>
>> Call dma_map_direct() from arch_dma_map_page_direct() if
>> arch_dma_map_page_direct() is defined? Seems suboptimal as it is going to
>> be bypass=true in most cases and we save one call by avoiding calling
>> arch_dma_map_page_direct(). Unless I missed something?
> 
> C does not even evaluate the right hand side of a || expression if the
> left hand evaluates to true.

Right, this is what I meant. dma_map_direct() is inline and fast so I 
did not want it inside the arch hook which is not inline.


-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
