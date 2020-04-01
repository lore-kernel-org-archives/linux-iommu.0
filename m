Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E7C43331
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 22:53:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE4820719
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 22:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtlmw4dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE4820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B362687DB2;
	Wed,  1 Apr 2020 22:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdPIyDx9gmMb; Wed,  1 Apr 2020 22:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC16787DAA;
	Wed,  1 Apr 2020 22:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A566CC1AE2;
	Wed,  1 Apr 2020 22:53:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E364C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 22:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2E275861D2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 22:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AwZQpts1JDDV for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 22:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8DEFC85D5C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 22:53:41 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id c12so583973plz.2
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qukBrnnromGiSCTnyz4L9HyTen8DUq+f4oJWku7HGRc=;
 b=Wtlmw4dpm0UzBF2ljJcSpqIpYf97R9uDwQrPvVTbaSenQDwQi3zvynD1LIClNrkmgr
 v32L1eIqgqLy8+C0tdcrFx4NIBZ+wCN4R412gfu4QxRCwZ/sfOT+dVSTGIlEgQDGKtGc
 Mg2L1WUgME8bLCAaxIKdcIbhbxS3s9IFK/YwjeBMFT7Vb2xPaA7fb+x64nCK4sIPQ7xi
 OT9fFgOcgErtV+krCWbMjDBk81Ulu08eQ45eeJHeZI25BbvV06cZq4TegLtjkQiD05oj
 h5vYGZaD//05KrmpM84Jafe7Po1SM+DipPPAjmVtfyugjt6UBeOGQ0szs/M0DCyqRWvN
 8BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qukBrnnromGiSCTnyz4L9HyTen8DUq+f4oJWku7HGRc=;
 b=BMjo016qioctGMiwU0gU4ea1JN6o1lLMpltA9LF4yfrlLymBT0BJe5nX6dF5JqMYmA
 ZvjK8J6z5QGXo55GGqWYSlYAAvdk9e7SNg7gKcC6Y/lp4CuH3NVl8JmBiaAwcC0EZKp2
 6BkjGdnozdIiJzg9XXD7XrlkB8P1M8Y65/A3pYkF1ebqCTZHSkphRJoo4OFstUqITSBf
 EJE92D8QP7J4hSOLEriVJDnOkgVFCUfRLx0Qy4JdBP5e7OT77ULV5AKo+ZcE9QxqbeJA
 tZPAQdkhmve/w2AVETq3+MYoSB9ex6Zgw46HD0w+1Ch568FKmVgPF1zPjIB31+ZSqX7t
 VzKQ==
X-Gm-Message-State: AGi0PuZAruahnM8D5nJMsL/LMPW96adCwSWUNRRzKI6+JbPHgNAm0uCp
 G3jm07Y/OCeM57rt8mwuNEU=
X-Google-Smtp-Source: APiQypKdEp028ZPQjbmb21Al2LBskm5n5yoA6i/WOLkLRtbqs/InmFgJatpLUGky6jX9D+uBLxMQRg==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr133733plc.245.1585781621214; 
 Wed, 01 Apr 2020 15:53:41 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net.
 [73.241.150.58])
 by smtp.gmail.com with ESMTPSA id m68sm2554947pjb.0.2020.04.01.15.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 15:53:40 -0700 (PDT)
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
To: Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@infradead.org>
References: <1517438756.3715.108.camel@gmail.com>
 <20180202185301.GA8232@infradead.org>
 <CANn89i+FBn3fttEyU_znAd-+8BgM7VZogFeeZPA7_zubChFpBA@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <34c70805-44f5-6697-3ebf-2f4d56779454@gmail.com>
Date: Wed, 1 Apr 2020 15:53:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CANn89i+FBn3fttEyU_znAd-+8BgM7VZogFeeZPA7_zubChFpBA@mail.gmail.com>
Content-Language: en-US
Cc: Benjamin Serebrin <serebrin@google.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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



On 2/2/18 10:59 AM, Eric Dumazet wrote:
> On Fri, Feb 2, 2018 at 10:53 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> I've got patches pending to replace all that code with
>> dma_direct_alloc, which will do the right thing.  They were
>> submitted for 4.16, and I will resend them after -rc1.
> 
> I see, thanks Christoph !
> 

Hi Christoph 

It seems 4.16 has shipped ( :) ) , and intel_alloc_coherent() still has no NUMA awareness.

Should I respin https://lore.kernel.org/patchwork/patch/884326/

Thanks !
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
