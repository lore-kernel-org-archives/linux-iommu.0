Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF6BC3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 21:47:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853DD22DCC
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j/KvpmYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DD22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 35B55CB1;
	Mon,  2 Sep 2019 21:47:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5EB6BCB0
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 21:47:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BF1365D3
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 21:47:03 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id m9so6991752pls.8
	for <iommu@lists.linux-foundation.org>;
	Mon, 02 Sep 2019 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kernel-dk.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=bE3CAGhnJZegvIyfQXiX7dFDWRKDXbLDv++b0LQi4ZA=;
	b=j/KvpmYKp5WcE2QOK0RAlwqt+IgtxvzMAxVB8SmfSj0/pOnQV6c2CsE3AhMxEGZ7LO
	QHoUNeRRlAwj6j2iwtZMqBLNwFsXOT9docsS2b86DNBZRE7vNX7MG+axOrC0MA0QnjMK
	luQSr0KbW9tQ2SEmb7nPpFCRhkC0RIOVXlh6YM9O9Sg5g4VbVYdjagxeLsMMSHm1rQ8e
	aMJlnnuzI09Dj53mES7Bzt4WXwZ7m8nyMMU4IWG3o+BPiGpZheP82fcUcJgEI2yw7ZfR
	eqQhoJTb5btqwS+2uAS9Etps6GRDO9Glz3AxMp0Z2mFP73H+Vhjy02G6cpdk6gJVBPny
	pEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bE3CAGhnJZegvIyfQXiX7dFDWRKDXbLDv++b0LQi4ZA=;
	b=k5O5XFPdCv+9luCcg0umNdzrrvRwLi6rV+5WJp+fYp3UpIGOnp0UgMBfvC6y2qOMI3
	bymzLpwGpnIvI9/MPMAcvoNlCb+E03aJJfdS8UU4mFlSNAREF9T8Y1b/q5kNblJYXquI
	FE4VK72ZFuGmPQj2GesVeuc6xaWdkP+CQnUv6fCm23el4Hg8Un7xgDu2Qq8zDJfjQd16
	ekjBbCaCIHCgA1VDFrr6a5oi2+iUhE3PttKLt8HorSv8navVOi3VAfwBeU3XulnqCr8P
	zhDgm4cvBP+kP9RsfRzH5Nbe+XYkmr46R7Vu3riRijOHAq+rzw42bTCCz22pHmW9F9gz
	HImQ==
X-Gm-Message-State: APjAAAXtBbBau3VupcjY4s9YUi8V4hxypqTCTZTEm22z44vDxdA+NJeH
	ww64nvlKMsUBW8GCJbHoBWEc0w==
X-Google-Smtp-Source: APXvYqyJzfQKPBEQy19FPz3Lq5G4NPwWwbdV/9eJxkhq7nV/UN/iSGM54S9/O1hVayoRRjcFiYFOTA==
X-Received: by 2002:a17:902:b48c:: with SMTP id
	y12mr5329126plr.92.1567460823386; 
	Mon, 02 Sep 2019 14:47:03 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
	by smtp.gmail.com with ESMTPSA id
	71sm20770525pfw.157.2019.09.02.14.47.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Sep 2019 14:47:02 -0700 (PDT)
Subject: Re: [PATCH v10 3/4] block: add a helper function to merge the segments
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, joro@8bytes.org
References: <1566995743-5614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1566995743-5614-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e549e8e7-9dfe-6f68-2148-f49a9089db37@kernel.dk>
Date: Mon, 2 Sep 2019 15:47:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566995743-5614-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
Cc: linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
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

On 8/28/19 6:35 AM, Yoshihiro Shimoda wrote:
> This patch adds a helper function whether a queue can merge
> the segments by the DMA MAP layer (e.g. via IOMMU).

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
