Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A29C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 14:53:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA58F206BB
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mb8tCh2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA58F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 85EB4E5C;
	Mon, 19 Aug 2019 14:53:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 70984BB3
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 14:53:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C282C67F
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 14:53:48 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id x4so4841043iog.13
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kernel-dk.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CAozpPrx+Q1jLhuTy6OsL4NNG3IG45MFANMoIltkwAo=;
	b=Mb8tCh2bLsjeTjXBHqs0/cQN56crbWNd/Q8xr/pSttNKCouz6ipVyNQ0+eAAUwy4Fg
	s1np2ZTCFqN3neFZsTIeSJtxhAFbC+5XA8RAZAyolGlsOmTH9S3LITyl9eoPOssO0lnJ
	kpUpE6ip013rwPiNw2Bu9nefooFjpQS3wtXUPgNduuc2sBF0o7NXM475JBSCWstwU8k5
	NwYY4rZpqmg8nJv9ipS2IGWDJSJR8UJB890KZ+Cc3lRgtwo0iih8BhCEn4xhGKW+ZdAf
	ZDEUK9HPlh4Ub0yDU+XPxaEGu1+idYMNf2bT2tJijA6R6pwJ+0sV/oek3N7RrhW3k4HF
	tdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CAozpPrx+Q1jLhuTy6OsL4NNG3IG45MFANMoIltkwAo=;
	b=aOepZI4OH9t9SZHu16gBRoSUtviv86mg8/ehVexPV+ML7W+SbTs3KRFHo+3cEa8Cuu
	xwL6ZycFcm6wLNrdYkspM4AMiq1rXZGxbU+Noy6MJcjPiIuNis8wtZUaRBdUoMXovhQS
	3bzmVmAXIeX64gjF/uIT6su+kHcG/Ybj1IuNvIyCOJ09Z+BEm7iKtsqwz6rrWP7IG8hr
	JJQFTTuDDdBl8o8aFDDsL183zI32RSfObfAIXW1C55664k7ej3nJpokeFEOIINdXqlVB
	anBMDI5Vz/pK4hfWfS5VGoTUHki522dFfj/poGz4sVOT7z43p8V860DKO98vSW4JGCTJ
	v02Q==
X-Gm-Message-State: APjAAAUDV4yqK4Fnzbf/qCQ9Ck6zlPKxOFtXLeHXLdhaYcMVGQ0f1H3/
	1KnJXSI01VnBU9so7c2BK0DTqQ==
X-Google-Smtp-Source: APXvYqww0IFLngqPqM7W6572CFxzF909pM0goodpc31llb6Yt4oi/F2OvBrkbuK/8LN1xVz/+eRMdQ==
X-Received: by 2002:a02:952d:: with SMTP id y42mr15298473jah.66.1566226427998; 
	Mon, 19 Aug 2019 07:53:47 -0700 (PDT)
Received: from ?IPv6:2603:3026:406:3000:70aa:6052:7aba:c7b?
	([2603:3026:406:3000:70aa:6052:7aba:c7b])
	by smtp.gmail.com with ESMTPSA id
	o3sm13893887ioo.74.2019.08.19.07.53.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 19 Aug 2019 07:53:47 -0700 (PDT)
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
To: Wolfram Sang <wsa@the-dreams.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190816195026.GC6886@kunai>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6ed6c62d-d773-71ec-382b-acd850e3dff1@kernel.dk>
Date: Mon, 19 Aug 2019 08:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816195026.GC6886@kunai>
Content-Language: en-US
Cc: linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 8/16/19 1:50 PM, Wolfram Sang wrote:
> On Fri, Jul 26, 2019 at 05:31:14PM +0900, Yoshihiro Shimoda wrote:
>> This patch sorts the headers in alphabetic order to ease
>> the maintenance for this part.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
> 
> Jens, can we have your ack for this patch so Christoph can take this
> series via his tree (also for patch 4/5)?

Please just drop this patch.

-- 
Jens Axboe

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
