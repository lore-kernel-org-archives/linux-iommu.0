Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEEC4CEC9
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:32:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8802D2171F
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yLz0Vc5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8802D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3FE92B59;
	Tue, 17 Sep 2019 18:32:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E03B2B50
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:32:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3B57876D
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:32:49 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id q1so10090202ion.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kernel-dk.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qNIe53zrgCg2gFdQMfvAbWjy6VVymIDFBP+9g5s+/5Y=;
	b=yLz0Vc5U1aO7M/ZcTpzpUb/M/FylLyeSzNkhWs6+dhbqe4TpVMHfVrI2BRMs0Pq6U7
	T0p85T4alWTjJHm0Xojwq4P7cWFxs+OjlB/YaiWj9o1pcjKvw51aDzuO+VWqs+BA+wQK
	g9lwNzve5rdMUpYV5maaStxNBFaPM5sWl/dYLUjnPElt1jnpHrgX22V303IvfbYEr16x
	JYKGWb8xjTouEglYkck+LANfX05kEhv+ekMY0ASfwzk0ECLjdzzl36QZEZRz7m6H+qdf
	AmS3EVhaPjmF2ETJuekkDS2DGOIQYelXgQCX8dBScQJBoG/YgoFkJWoq3qe2EROuqzq0
	KF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qNIe53zrgCg2gFdQMfvAbWjy6VVymIDFBP+9g5s+/5Y=;
	b=TyQOXnEMc2bgwYUBRSisROiyO3JczVKtfPUH7pMUrFOj5FnOfIJh7jQhanszGcN5Rr
	feadpg8/p29YECeHeVdpdTDqXQNAV0srUZnEzclC8PdHF1i4BP6q77FxB1AcD1bLtrz4
	Yh+0JHF8ecZpPu/w9oDvMu7HtIaf+6Byjnph+9Wx9dL6jwNe953ZPnxRdTbQRF61LGj3
	lUVwd8KYHj/lqXIOO0Z8cRpYJbrAztDNY8KYm+EIOFu2nw53dsHp6B0gDj4b1bzLAEkx
	kpmpnA7l3HAy9Vl7KNp8vSMESFFUTlGp8vS1UM4R78MD+33J/xYmFo3VCKCHoGFOiFRX
	O/pg==
X-Gm-Message-State: APjAAAXPhsj9VRzHZEH5HPdQ+1MmLEZLJxlnCfHoY0Kf5jMN/59TkF5K
	MSHxxrEqmJWf/8YwosL5Pl8bzpkD5Z9vbA==
X-Google-Smtp-Source: APXvYqxWUls28UFYxnGhX2kD5xZyHA3aFDkbk+EhHIwX49f2ds+U5AnNAiD7AeluDxPN3kHHkCXu0w==
X-Received: by 2002:a6b:b487:: with SMTP id d129mr112912iof.223.1568745168066; 
	Tue, 17 Sep 2019 11:32:48 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
	by smtp.gmail.com with ESMTPSA id m9sm890768ion.65.2019.09.17.11.32.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Sep 2019 11:32:47 -0700 (PDT)
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
To: David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
	<20190905060627.GA1753@lst.de>
	<alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
	<alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
	<alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4cd700ef-f2fc-2bb5-35d2-0b2194accc45@kernel.dk>
Date: Tue, 17 Sep 2019 12:32:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
Content-Language: en-US
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	iommu@lists.linux-foundation.org, Peter Gonda <pgonda@google.com>,
	Jianxiong Gao <jxgao@google.com>
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

On 9/17/19 12:23 PM, David Rientjes wrote:
> On Mon, 16 Sep 2019, David Rientjes wrote:
> 
>> Brijesh and Tom, we currently hit this any time we boot an SEV enabled
>> Ubuntu 18.04 guest; I assume that guest kernels, especially those of such
>> major distributions, are expected to work with warnings and BUGs when
>> certain drivers are enabled.
>>
>> If the vmap purge lock is to remain a mutex (any other reason that
>> unmapping aliases can block?) then it appears that allocating a dmapool
>> is the only alternative.  Is this something that you'll be addressing
>> generically or do we need to get buy-in from the maintainers of this
>> specific driver?
>>
> 
> We've found that the following applied on top of 5.2.14 suppresses the
> warnings.
> 
> Christoph, Keith, Jens, is this something that we could do for the nvme
> driver?  I'll happily propose it formally if it would be acceptable.

No, this is not going to be acceptable, I'm afraid. This tells blk-mq
that the driver always needs blocking context for queueing IO, which
will increase latencies for the cases where we'd otherwise issue IO
directly from the context that queues it.

-- 
Jens Axboe

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
