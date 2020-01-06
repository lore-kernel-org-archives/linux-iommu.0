Return-Path: <SRS0=Oi6h=23=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1376C33C8C
	for <iommu@archiver.kernel.org>; Mon,  6 Jan 2020 20:33:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A110820715
	for <iommu@archiver.kernel.org>; Mon,  6 Jan 2020 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UykzDSAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A110820715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7FF16226DB;
	Mon,  6 Jan 2020 20:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yCxm68j9D8wj; Mon,  6 Jan 2020 20:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 10DD2204C8;
	Mon,  6 Jan 2020 20:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03E67C1D83;
	Mon,  6 Jan 2020 20:33:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE29C0881
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 20:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9445388277
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 20:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EeLJdC4PiaEQ for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jan 2020 20:33:29 +0000 (UTC)
X-Greylist: delayed 01:49:14 by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0DC5588263
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 20:33:28 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id f16so19607582qvi.4
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jan 2020 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=TvsBEWaiYBZ2H17klDWmqKbuYTFZJoljwApjESxGTXI=;
 b=UykzDSAPX/ekra+WJHO0rI9DOpxf3LrEfin4zpblHFwND1Tan9sDYreT28HalQHYmF
 Rzi0Wr4mrid/WIi+nBPUd0JRVghQ/nmq7trM7ewFIBAGMyHDnMfVWuBcbEutPASnUIF1
 63FmsTKbfEG/a1APanPUofQJvKdvUJi/gzTdHy22Buld3m+bnjQa1P+KLfL//+igY8zU
 Gt1Pf+IjqkhgRYua631idbwBKGp4mj5r5R6oI5bejahzguGV+Xv2YHbRfU7q4GxxQxTe
 yxVgT8RF7It+WvZvCrbNNEgk8fAiBhKITv6bQRqsK9sKSjTgZBY7EdrhOcANVJA2GeKH
 ceeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=TvsBEWaiYBZ2H17klDWmqKbuYTFZJoljwApjESxGTXI=;
 b=oohRYGqoqFFeYGMnmx4QKg/ERyffwEGUN03hRvlU4Ic4TSUSBqmWQQgAqdTlc4yN+J
 hE+JqNS7Y74TuYpvKNEwfUCAdh+zZtf+oZi9o+kvDZbL/WTsGh0E131438Fjy6tXcnx0
 1uPtAZahBceBDFAS7DTATe8oP2+GivqHWjF/RngZHFUOdIeAH+baIftB9t0BzeWeCa6u
 cFp/87q/J8h+WGZ87sKLsy3x9LtmKNV+QQSG4Ndd6WVNah1A7AS30hioUtsOKnggAVVE
 nrYlu3BIzh+CGKikPclAJ64n/p0GFI4XetfWaBzQcYOAvNlQWkr+D0RFq566Wof+IPWT
 tI7A==
X-Gm-Message-State: APjAAAUvLohC+GOWIBFyGfhAEacTmOx8nW/wqSUYJySD2H6LDXWx1hz2
 eRPHvoWUdKdClyp+LOWAkcO/U0t4g1s=
X-Google-Smtp-Source: APXvYqybBDuHQSIN7YupUN/tu5gSnhXgnkVgnI6aC6tQvSyOeKrs63bRLYiD6KDtD8pNqV2zqWuL4g==
X-Received: by 2002:a05:6214:1348:: with SMTP id
 b8mr80545269qvw.137.1578336253923; 
 Mon, 06 Jan 2020 10:44:13 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id e21sm21131559qkm.55.2020.01.06.10.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 10:44:13 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iommu/dma: fix variable 'cookie' set but not used
Date: Mon, 6 Jan 2020 13:44:11 -0500
Message-Id: <1A4C3B76-FCC0-4C4F-85A3-4172BD42429D@lca.pw>
References: <418dcce0-f048-a4cc-3360-d4b9c7926a6d@arm.com>
In-Reply-To: <418dcce0-f048-a4cc-3360-d4b9c7926a6d@arm.com>
To: Robin Murphy <Robin.Murphy@arm.com>
X-Mailer: iPhone Mail (17C54)
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org
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



> On Jan 6, 2020, at 1:19 PM, Robin Murphy <Robin.Murphy@arm.com> wrote:
> 
> Fair enough... I guess this is a W=1 thing?

Yes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
