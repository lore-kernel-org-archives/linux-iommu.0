Return-Path: <SRS0=SJ72=H2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC150C433DB
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 21:59:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFB764EFA
	for <iommu@archiver.kernel.org>; Wed, 24 Feb 2021 21:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFB764EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C378E83A8C;
	Wed, 24 Feb 2021 21:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7EEoecd3nHs; Wed, 24 Feb 2021 21:59:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B6DA83279;
	Wed, 24 Feb 2021 21:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E884C000B;
	Wed, 24 Feb 2021 21:59:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF0DC0001
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 21:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35F9F6F640
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 21:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAZSPL4wnMvh for <iommu@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 21:39:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7EF86F4F6
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 21:39:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id j187so3008031wmj.1
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 13:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BD4TMcGc8znR7jXz+3t4kYsLronkqlh6PWWcuwDtmDE=;
 b=gb27Ajne2JYQESFv0ps4F6yxTV8s8btpnsDzB9WmJxYo+0fmLxL7RH/nNK+e8GInV2
 vVK661clcGzlWVU0velttreF5aSmB4ZcD+WBYEKji9pygGPXhFBnuX6Y67/ltEjqvPqh
 osEq77Kn/RfaWWiNo8VExEcChLXJcqxAZBAz501dlfouR1PQuB/Z6NF18FF/qYl1plX9
 czl1ev4fZzyxZSVqT3w5/18J+sgSDL7mfKKcQi6b+Q2jMwqVrag28OvttlQo0s/H9IfT
 GoCz0UI7O1NlvkF1Eg02/958Zd7HeHUo2YZK/fxV8nIsQgq1t7pS2T3vLtASnIHTtak0
 zWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BD4TMcGc8znR7jXz+3t4kYsLronkqlh6PWWcuwDtmDE=;
 b=GgSMz3rYBuwR4hLKtrB714BKAfsAaKfMMd0Gqi5sGE4HSgBkJLm0fRXyGIuIjc+VwE
 A1HhN8fx3/S3zWliqXolOsw+mdL+8mx+qM+rV+fSg2QR2rjV35RWZb86DRNeHbwoID0g
 myQBl4X0qOMdar716CUPCZwYieERWilS5AESqXn8cXBdqNgdUkx0JTZPq2T5GaqnwKmd
 JaW1Dfh1Qs02+XJ2h+yXK44pirzZ0qmnM1or1+TVcNpUJFcEsEHUIG5jw6m/Q2uPwcY/
 /1BPEVNgESjA1do8gWIadOnCrrZc8M6gV+j7bhLU8xb/3pxPi4apE511U0qGlq/1cW22
 gSOg==
X-Gm-Message-State: AOAM532bSarx1/nCmLV3Q1rsf5ty7PSZ29EguaTfigDVOXAMOD2T1Ic+
 y9TnCzzqw3y4tDEpV9RLrJk=
X-Google-Smtp-Source: ABdhPJwdvUV9eo5JBZfZQpCJZHtLJscksD5TKytwbKtbxJ94zcN/F3Ipi51/9KeFReIlTVBZGVEUBw==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr65061wmb.59.1614202783912;
 Wed, 24 Feb 2021 13:39:43 -0800 (PST)
Received: from [192.168.0.105] (ip1f1322f8.dynamic.kabel-deutschland.de.
 [31.19.34.248])
 by smtp.gmail.com with ESMTPSA id f7sm5227549wre.78.2021.02.24.13.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Feb 2021 13:39:43 -0800 (PST)
Subject: Re: next/master bisection: baseline.login on r8a77960-ulcb
To: Guillaume Tucker <guillaume.tucker@collabora.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jianxiong Gao <jxgao@google.com>, Christoph Hellwig <hch@lst.de>
References: <60346234.1c69fb81.cd55e.770d@mx.google.com>
 <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Message-ID: <db197ccf-3b55-098e-bc19-ca8adc98c6b2@gmail.com>
Date: Wed, 24 Feb 2021 22:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 24 Feb 2021 21:59:23 +0000
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org,
 "kernelci-results@groups.io" <kernelci-results@groups.io>
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

Hi Christoph and all,

On 23.02.21 10:56, Guillaume Tucker wrote:
> Hi Christoph,
> 
> Please see the bisection report below about a boot failure on
> r8a77960-ulcb on next-20210222.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
> 
> The log shows a kernel panic, more details can be found here:
> 
>    https://kernelci.org/test/case/id/6034bde034504edc9faddd2c/
> 
> Please let us know if you need any help to debug the issue or try
> a fix on this platform.

I am also seeing this problem on an iMX8MQ board and can help test if 
you have a fix.

BR
-- 
Heiko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
