Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B2BC3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 05:56:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291A120644
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 05:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MexB0Fsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291A120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CCCA486D;
	Wed, 21 Aug 2019 05:56:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 507717F6
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 05:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76DA0F8
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 05:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1566366970;
	bh=z1gZdu3xLJGMMRcfM7coaKQ1nyQmvnZIViiTOc5+oHI=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=MexB0FslsXYmsYibspiLhrZJaEGckNHFLNzM5RMefGiHnn9wzWN2S/Wq2wG6f3qwO
	99PPAbeF/zex1pTN1t9UCwnQ3NLXoxsh+1ZjLRIDKPKFaGZ+6YeLshydOgSa230QU5
	Av1hDw3qI0XQd4OV6J1r6/mwZwC6yqUCwuS4Bsg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx104
	[212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1i3u5k1DCX-00EZnZ;
	Wed, 21 Aug 2019 07:56:10 +0200
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
To: Christoph Hellwig <hch@lst.de>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
	<825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
	<0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
	<20190820012415.GA21178@lst.de>
From: Stefan Wahren <wahrenst@gmx.net>
Message-ID: <f8ee890b-3bef-1147-101f-754f731d489e@gmx.net>
Date: Wed, 21 Aug 2019 07:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820012415.GA21178@lst.de>
Content-Language: en-US
X-Provags-ID: V03:K1:QZATAYirQLOIduivMgpncQ2CfI98TvCV4SMQF8HUui/JtOK6LYY
	hGl72BSxhSoQDV3BW6L3jqDzjQpeYkj2PcHaVldzddksqhK8iow286NGqtT1jFnOuUWpci6
	OPHxrHM4CBPbqjdcVYjG1Fp36X/BmEUm/Vkhl20LL5dQ7fEaCV9tVDTtvp5vSU5GFd26NMd
	Ji0amAZdMKuWNA1Oa5DrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBimPWIgeWs=:TXG3Gr+BpVlMx2ujdefSej
	I/AjxYih0fkfHyhTpAI6vAtdifphteoSQdeWnT6xk557kCC7XHN0bypgqHC9AveTVxjZNUcDZ
	9nZmKT6RgG3poRVYsJ6Bs5KisRCUoUet0MAPglamSFj1gKtAQKCQAhkWQaw/48GIxF6eb3FDu
	VTVPSvsqIK8YW1dMvfpej62raHDSyUBs4PiJ6mgp7fA3aCXF/KIv6W4S2guzsUsgk0RCobqXx
	Fj6MTzLwFZObhKNMO79J0hn5RAKFKU4jEFJwNbULE8U6Kbnw7z/sTuI+QElfdm67CWL2VEa37
	/6OvbHdZHtXG4pjfV83xcYVY4kouItmIYYKiMjnEb6f+Ii98+P37aHrXWmz5NxpBUd+N2JFyZ
	9Us2XtgRj6zqtj8mOrli6hFmF9Wndx9Jyy7iYpAMFjOG+GUW9IciwnTEWuKFY/Z940Lchx5ou
	TL3X7mRpfUBOMt1TVJFW0Ngcl7GgmLJKuky1MZvTqOhiVjEWVBWd2N/Rg45gCbwpvb+AkFSZP
	0crDSU6CyhRMnnRvxdR6wdQJl+ttR+AKVUVqXtwJVrzkgf771Mzfq5tgk5GIaC2zWeT1QBmtI
	grbnWdvPEae42RfR4v3yx/MlqZYCXUksggH3xbaxmg1eykrjMU3QFzVG2cvnOs+2A7Fe64oaG
	6rWautZIr3AhfapB/47sGRj9gr6+5pVc+vbciOOBaOUJiPF4cphPGWlcSAVvrYU6yORnKVY5y
	uqatnknUtxKs++VWkyJr9gfVPic3qv3PShsl3/5WCn86Rdvgtzw8g7V0p45xJsZVuVIMDNP5v
	oN2q6dkw5tnqMc9HKgRwLbBmufu5o1ajKN6xWNymlqsyJ59JKO04rcEgPjX5HNHBRMLhQlNf/
	Fm+0Aew9PeRCZCkYapuXj8Ur+xY6GCKvU3LPEOMbgSxYQLI0niMbMWXpEzQXoN8P6Qr/Yb534
	1liGHWiO1vU3VWAHpdNksWm/pgGEQFVaGfaDgZNj2CEnTv2yjq9IiCoo/fLZvONd/8ASsBR1R
	Z5qWIaYjrPqoUy/70KPJdDJUuUJsijZCcPkQf3lkFibTAEKifnN7TXgjILug8NhYaQuts5Xq+
	/shZzQbaN22LO1JQetSuIfSuwf97/PizM40CGqRDZpJpj37EACHqO2fKCtuLzL7yyKw0fi6yy
	8xIwc=
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
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

Am 20.08.19 um 03:24 schrieb Christoph Hellwig:
> Hi Stefan,
>
> please try the patch below.
>
> ---
> From e0570628d96faa50ebfc94ce8e545968336db225 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 20 Aug 2019 10:08:38 +0900
> Subject: arm: select the dma-noncoherent symbols for all swiotlb builds
>
> We need to provide the arch hooks for non-coherent dma-direct
> and swiotlb for all swiotlb builds, not just when LPAS is enabled.
> Without that the Xen build that selects SWIOTLB indirectly through
> SWIOTLB_XEN fails to build.
>
> Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Stefan Wahren <wahrenst@gmx.net>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
