Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3CAC433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 23:52:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11392072F
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 23:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mt/tNa3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11392072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 183A8888EA;
	Tue,  2 Jun 2020 23:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 53oSdVpFgtaC; Tue,  2 Jun 2020 23:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81DB5888C3;
	Tue,  2 Jun 2020 23:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C262C0178;
	Tue,  2 Jun 2020 23:52:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31654C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F8BD87C8B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXYTOi3DUt4Q for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 23:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5101B86A3C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:52:02 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id 69so434562otv.2
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AyHVm8H1V2i3mmbLZOQuNvzAiH5+9jtSq16k4ss/D+g=;
 b=Mt/tNa3CVtFoIPP9vs1G/pzU5s4Hc6kChAN1MjUSn58bltrswAMU5AiNUP9Mv+2kcT
 a0Y+fguR9tlG17LumUx/nVW31QoG9Ug8bjp5s8nsUGMBAh/HdduyvCCg86G5877Cg3GZ
 e/JVfVdPupzlXxohI4txQdgepZULQhGfZ+0wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AyHVm8H1V2i3mmbLZOQuNvzAiH5+9jtSq16k4ss/D+g=;
 b=sU5FuRsJqSVXgs6C7I3erHyhhOGizyO8pxoU3UuOTk6dJb4pH19sVCD+3uV4ABtQNS
 0SMj5HY7QGfVtNr94oxpD1h6MuScartPdXUIMjteLRCr9TWmh3yIwyRCbsgQ8dqMuGUe
 F137ktILYFogtGJjImDHWYIJmPJ2BpwWPH+IHEiXl9zTcEC10Z9luE9FQrBoeQHMO3iC
 JA6+i94qD8yWZIXvhet+2LnfD+eca52p345YOCs6Z6lFE4Hq0wrL8lXTqK3A6OrGYfDx
 Gaf4Tz3m/oF3MVuOh5/9Bzop30p/vNLr2NEcGPJ+emsb/g7IpZJWgqdvXBiXrMhJbdEL
 Jxtw==
X-Gm-Message-State: AOAM531SA0EwymVKOKj0/MP/Ser7nKSEFwp2ROJjdT51mTXz8iNsaQBM
 yT04d5YSVhuHf4nziDldtRF7PuKd
X-Google-Smtp-Source: ABdhPJwfqIxeVFPyYSW0HnX9GqZroEW760c16l5ACTIbwO8NZ7kNchICQfi7gL3an3LAcN3OQ3in4Q==
X-Received: by 2002:a9d:3bc2:: with SMTP id k60mr1217092otc.242.1591141921377; 
 Tue, 02 Jun 2020 16:52:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id k7sm81222oon.29.2020.06.02.16.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 16:52:00 -0700 (PDT)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Alexander Monakov <amonakov@ispras.ru>, linux-kernel@vger.kernel.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
Date: Tue, 2 Jun 2020 17:51:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, skhan@linuxfoundation.org
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

On 5/31/20 1:22 AM, Alexander Monakov wrote:
> Hi,
> 
> Adding Shuah Khan to Cc: I've noticed you've seen this issue on Ryzen 2400GE;
> can you have a look at the patch? Would be nice to know if it fixes the
> problem for you too.
> 

I am not seeing any change in behavior on my system. I still see:

I can't read perf counters.

The question I asked in my previous thread on this:

--------------------------------------------------------------------
I see 2 banks and 4 counters on my system. Is it sufficient to check
the first bank and first counter? In other words, if the first one
isn't writable, are all counters non-writable?

Should we read the config first and then, try to see if any of the
counters are writable? I have a patch that does that, I can send it
out for review.

I changed the logic to read config to get max banks and counters
before checking if counters are writable and tried writing to all.
The result is the same and all of them aren't writable. However,
when disable the writable check and assume they are, I can run

perf stat -e 'amd_iommu_0 on all events and get data.

perf stat -e 'amd_iommu_0/cmd_processed/' sleep 10

  Performance counter stats for 'system wide':

                 56      amd_iommu_0/cmd_processed/

       10.001525171 seconds time elapsed


perf stat -a -e amd_iommu/mem_trans_total/ sleep 10

  Performance counter stats for 'system wide':

              2,696      amd_iommu/mem_trans_total/

       10.001465115 seconds time elapsed

I tried all possible events listed under amd_iommu_0 and I can get
data on all of them. No problems in dmesg.
--------------------------------------------------------------------

This patch doesn't really address that question.

thanks,
-- Shuah
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
