Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D57C433FF
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 16:40:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45831206A2
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="emoH3tJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45831206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 080C61871;
	Mon, 29 Jul 2019 16:40:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 457801B0A
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:36:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AEE745E4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:36:12 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id p74so54431413wme.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=xbzqNzt7pi2o9cfV+nAP8/nb/8H4XZUQFytgHk5gXMw=;
	b=emoH3tJLMtmN0uMcfxx1UiXoVfr/Zwy8gq2YJ9A3lcguoqdaKn9XSljObhR5cwWA5I
	0rj5LoUXaQoVFiN8/DRyn+6vJoOO8AfYM6GGr3Gj6JbNFyO6KeSc3nSNBQsGFplHi43Q
	+X1HLHDD5xaHhEMwr3bezs17B2IAWI7WMycH7N3PxRXUEq7kJmxgk/gLOgsJKfWZaYiF
	jCihlg2lvar25jesWAG1Tk/Cu1XLrAdVNjBlUZkW1dds1Jzbc1S+sYpp6uhVo/ivc8Ft
	D9CnyQpQiwCtGYQRB40QBJuwTFf6VkmAsUuUxNhpzvHB+xASwEREdYE5eaaXciAlBxj7
	zJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xbzqNzt7pi2o9cfV+nAP8/nb/8H4XZUQFytgHk5gXMw=;
	b=sqZGeavKZuKz4JRc0Tsvm7WAwj0bq4L7sgsrMgQrsD2KP0JlxJlbm0FZgEYPYoZ48j
	6sGlJSi0dH/m7dqwz6pQ8jtoMexAWeeVD0dPv+O2H0cKbKedkQQ9QG65pXmfeA2bfBQ/
	AkaLuyC8qJYyFxu0uqD++OA8JD7M/uOmQekdURIK1yZMLVNh9x1TdxJYf8qrJGqdhT/a
	xpHiyK0TxGV8F34Zsw6rwOCsxzJySUCG9Fy+GUooOJI7cgoOKXWVBd0OUFxKPzrBbuzY
	ld8Bpg8PUnIR6bR9nbFvepUokTQ2kV+iM2JxPCOYToBqloysxpIW5ezZjGYmGqUdE6GG
	cwNQ==
X-Gm-Message-State: APjAAAW12JGQJtYQwdr9gqCS06NCEznU6mtFEqFxarVbFMgEJPv7+nLp
	MK9kxXPyqxhYvWXwa+gYE0rZ2e6G51zYNypp4UFW3Nzrbrnc9YmsUoxEHFzlgU5dQnxdyX0Adpb
	cvxM/PnKTUId3vtcujKcTXBwQxhb6SP2dawMi0yijp//Dy05vALpJzItMLcztr2qccpFGaJUYjI
	Nb3Ji3JnCTaGDDrrzUnkCTGkG0oXmtYAkb/lD+CEpQvo/x
X-Google-Smtp-Source: APXvYqxc9YXcS+7THDqp0sS7IKwURKSr6zldbJPttfD7hIQhdTBNg+GUxcPcX2Axl/DhBrhfeMEyRg==
X-Received: by 2002:a05:600c:303:: with SMTP id
	q3mr103087464wmd.130.1564418171235; 
	Mon, 29 Jul 2019 09:36:11 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	v15sm60828909wrt.25.2019.07.29.09.36.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Jul 2019 09:36:10 -0700 (PDT)
Subject: Re: Patch "iommu/vt-d: Don't queue_iova() if there is no flush queue"
	has been added to the 5.2-stable tree
To: gregkh@linuxfoundation.org, baolu.lu@linux.intel.com,
	dwmw2@infradead.org, iommu@lists.linux-foundation.org, joro@8bytes.org, 
	jroedel@suse.de
References: <1564417834188112@kroah.com>
Message-ID: <7f66baf5-6492-12c0-c8b8-19cb1810b082@arista.com>
Date: Mon, 29 Jul 2019 17:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564417834188112@kroah.com>
Content-Language: en-US
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Cc: stable-commits@vger.kernel.org
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
From: Dmitry Safonov via iommu <iommu@lists.linux-foundation.org>
Reply-To: Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Greg,

On 7/29/19 5:30 PM, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     iommu/vt-d: Don't queue_iova() if there is no flush queue
> 
> to the 5.2-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      iommu-vt-d-don-t-queue_iova-if-there-is-no-flush-queue.patch
> and it can be found in the queue-5.2 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please, make sure to apply the following patch too (kudos to Joerg).
[Sorry for any inconvenience cause by my copy-n-paste mistake]

commit 201c1db90cd6
Author: Joerg Roedel <jroedel@suse.de>
Date:   Tue Jul 23 09:51:00 2019 +0200

    iommu/iova: Fix compilation error with !CONFIG_IOMMU_IOVA

    The stub function for !CONFIG_IOMMU_IOVA needs to be
    'static inline'.

    Fixes: effa467870c76 ('iommu/vt-d: Don't queue_iova() if there is no
flush queue')
    Signed-off-by: Joerg Roedel <jroedel@suse.de>


Thanks,
          Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
