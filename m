Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE8C433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 09:35:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318572171F
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 09:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="VcVeBlNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318572171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BF3C8E40;
	Fri,  9 Aug 2019 09:35:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 14B5AE3C
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 09:35:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
	[209.85.167.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56CC267F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 09:35:18 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id x3so15288477lfn.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 09 Aug 2019 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ZhZIKbPy1ojcvmbIo8mwd7oy4V33VIdwk5j1j74WW9w=;
	b=VcVeBlNEjS4wa/wbZ2Jy74bbWsbslezZzRDF5L5UlZPXuFgueVv76Apfbc48KCG7go
	O+JybRtPA55YOzc+rFrImDZn5Uzf4Iypjkw1Q2Jrzsy02VozkkgOmiMWFsyG/90IeJID
	s7g3Gev/hUXSaIrCTrM7IhGUouQ5uAYJrQU3W3SKx3qZhdrx3pME6i2VY+znRnPsMDZ6
	IqCV+5+rqLIKHOuF9OdviK0y/AZ3VputL3vLRILFoF8nj2+pSMBc+S3cQ85tH9TO2N3S
	m8AsLb+p6B1SXzPU1ej0Ppenwk9xbIlPPfP789O8926HVT26h04IVIjFQkPvwouSfOGR
	RQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZhZIKbPy1ojcvmbIo8mwd7oy4V33VIdwk5j1j74WW9w=;
	b=YkiVISDLyQO/vErmnVsedvpt9L4PoF8O61fH61NXVQoq65KGsIgn+0XJthmWsYC/NT
	WOfRFCc8IU6nWoicRCgDv9f+FBCY/heWRr7WuP4UJFD4E5mZR7ng8YYH1XXX5ISYtsjo
	ZbDBuwz0B7KvVU3OshRvRG3d3Ap6frdNSdvBh0r8anih/SL8IreLVZjDMxVGZ5mWWnA5
	4+qOey2gApLDIUK1gHs0TduDRH+WPoK+dNtjrT2zPKqpyOcv/nj1vShqC1Zilaoo8Sv4
	deYH2+NRDvwdhlXAEsqjyE8Pp0hzjz6YCcRzjBfpEZT1p8H2v+TQEHN+5EoEpQjBbdN9
	ysyg==
X-Gm-Message-State: APjAAAVKW9J79IOv/+UVu6fciVBQqug/X6fQdIcr+0YMU/1P+4Z34H27
	oRp5awCndmhs/HeF0wv1DE0icg==
X-Google-Smtp-Source: APXvYqzlq7k/M37b+stHUNm1aCq6nUomyYeuBENCXNdKlF0iST4RYWqRChfyDEB29cAPzX6iW+LIMA==
X-Received: by 2002:ac2:5981:: with SMTP id w1mr12123067lfn.85.1565343316741; 
	Fri, 09 Aug 2019 02:35:16 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:44bf:fcca:cd2a:e5bf:7de5:cd?
	([2a00:1fa0:44bf:fcca:cd2a:e5bf:7de5:cd])
	by smtp.gmail.com with ESMTPSA id
	t21sm19110864ljg.60.2019.08.09.02.35.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 09 Aug 2019 02:35:15 -0700 (PDT)
Subject: Re: [PATCH 6/8] arm-nommu: call dma_mmap_from_dev_coherent directly
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190808160005.10325-1-hch@lst.de>
	<20190808160005.10325-7-hch@lst.de>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <247fabce-5284-8140-c492-fe49e1683ca6@cogentembedded.com>
Date: Fri, 9 Aug 2019 12:35:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808160005.10325-7-hch@lst.de>
Content-Language: en-US
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 08.08.2019 19:00, Christoph Hellwig wrote:

> Ther is no need to go through dma_common_mmap for the arm-nommu

    There. :-)

> dma mmap implementation as the only possible memory not handled above
> could be that from the per-device coherent pool.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
