Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E7EC3A5A7
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 21:07:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15212339E
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 21:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HchqMEFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15212339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8AB33DDC;
	Tue,  3 Sep 2019 21:07:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D8897D7A
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 21:07:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 06342712
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 21:07:42 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id s12so4690993pfe.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 03 Sep 2019 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=vC5iA0bQsbGKHyeKcPI7gPcJFZDzY4mLs43Aq/+9Tik=;
	b=HchqMEFk8+5F9xV5oyWGTZDa6C4y79p3FWN4sLDb/LwG1ZPoPyup9gXWI0jqKjpMPj
	IyTezlwsToG7IzfOKQkE0Kt/N4rij2tPUfTCBvk0IKQU9giEtoVGyQkThfIGhOH70fvv
	GJ6zQis/rr1HCRcQpf4VnzHhmPGJ6nZ35VBDN1egClJyM7U3aOxLn+ffGqU+MhD5iB1f
	NXqeDjORIQGx05GOnsGQ/jmft/IYLCyRB7GE5vpuAH4yAyFhxBhNYV4N9dPhIAM6RyFM
	wiNbs1P0+msoJL3uVw0cLE7D/4GxGdT0t3lvjFU51YIegtOMEm23p8YeIrLu0UNYy5f7
	tcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=vC5iA0bQsbGKHyeKcPI7gPcJFZDzY4mLs43Aq/+9Tik=;
	b=ZXuub9QjN3rku9h02Y/kh3eI1Yud+KR+UzfVf1qm4m/LRbaErGpvfDeWRV4OVJ/wNE
	4VpFa7fjO46EE7fL9/WBdfyuQTOlV2NnBfS88k1dM7PDZfcr3bbG1z0WKOk9iZfLdyfd
	NO83F39saprPdrLR0WWN/xLybdkiR2LOuNow5Z/mGyJV2oUtHPgZdYDkxN6MOylrDOqa
	CrdxqXhVkRvGHHnc5Knoe+6hV+Vayr73toWLfLrkAcm3dg+y8hrQtbz2KQHyK2dbWIy3
	1SskFQdJhUEKLj5GyyN2SJI0edFqu6wEqzMqSHh4RwYy1jk9u7iReEs31PoaQgr1oaYO
	0/Nw==
X-Gm-Message-State: APjAAAXfOfVXoIEiZrVM+G0txy83tZ5Y7q92IKyS2JE7paTwAP+RWqih
	PZDm0muU62h7DiY6Qqtm1FKMvg==
X-Google-Smtp-Source: APXvYqxpWDYjlQ7HP5zqOy8oYtw2mwWvQ55CkeJud59Die7cmaNGXUSUGX0/WbXfo753JzRYQVkqGQ==
X-Received: by 2002:a62:6045:: with SMTP id u66mr41471485pfb.261.1567544862502;
	Tue, 03 Sep 2019 14:07:42 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	k8sm15646806pgm.14.2019.09.03.14.07.41
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 03 Sep 2019 14:07:41 -0700 (PDT)
Date: Tue, 3 Sep 2019 14:07:39 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] remoteproc: don't allow modular build
Message-ID: <20190903210739.GW6167@minitux>
References: <20190902200746.16185-1-hch@lst.de>
	<20190902200746.16185-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190902200746.16185-4-hch@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Loic Pallardy <loic.pallardy@st.com>
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

On Mon 02 Sep 13:07 PDT 2019, Christoph Hellwig wrote:

> Remoteproc started using dma_declare_coherent_memory recently, which is
> a bad idea from drivers, and the maintainers agreed to fix that.  But
> until that is fixed only allow building the driver built in so that we
> can remove the dma_declare_coherent_memory export and prevent other
> drivers from "accidentally" using it like remoteproc.  Note that the
> driver would also leak the declared coherent memory on unload if it
> actually was built as a module at the moment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Please pick this together with the other patches.

Regards,
Bjorn

> ---
>  drivers/remoteproc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 28ed306982f7..94afdde4bc9f 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -2,7 +2,7 @@
>  menu "Remoteproc drivers"
>  
>  config REMOTEPROC
> -	tristate "Support for Remote Processor subsystem"
> +	bool "Support for Remote Processor subsystem"
>  	depends on HAS_DMA
>  	select CRC32
>  	select FW_LOADER
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
