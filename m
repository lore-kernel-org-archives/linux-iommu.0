Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5014ABA
	for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313935; cv=none; b=M1Q2LKmqChRoI3Xt5rl/R6gK7fdGD5qHt2qxMSJBz2/ndL58ZpQG2B+YWOLZZ+pitDTkVWpDt7H1hJb+xXlYj7LbXO7VQtXMnmMh5f0Dw+qKqXjlBHL16p1/dNJyLfY5Gc1ZermfkmXZLyeRdFKkPOWxCe1FmVCwl0bhZbsWi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313935; c=relaxed/simple;
	bh=ISnVFZ/Q1UsEFptZeULr7aFUw+NEIEUAkyZmi5bMaaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QLwQBnkagmWA4SGccGTsAGbdCzUPZ02+AmYn+5lb6ImHb4K7LhARWH2HmsuShGkad+fKg9RdT8x3o9bx05R0iyDCAWKSOkFmIEDmwJdOFDC14Nmxvr8KTNsc8uNKOH1idwBHJXiDa+vnCT58L1BR8cLwFd8hItI6wNrNH0mW2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dD+CzlNv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dD+CzlNv"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56877761303so1651443a12.3
        for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710313932; x=1710918732; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUeEEmvrXVjz8nX0zE+loC+ERznBjekZC7DXMyKlw94=;
        b=dD+CzlNvwinurYs/UbCuwjsSppkpHSc9FeB0QOwPWi4ssG6wgD1Tau7bIrDIMVZDtd
         gpu/wPOFsVWz6GSqfVbkjHdkw5tkCp5NKa4dnUj5yPcLhGfUM/mu8YAXVg26yR8AWwmm
         8JwpZzy+G268Q5M+E1oydtbkLy8vl7e+K02riq28df6Z2t/Zhe4BR9KfjbTdPDWcFiv4
         6/ql7HCqozmh4NHBnjKLiXO2wpbWfHTknNyTRWztMpNpNVAfnkusEMBQyK65lZObKsr9
         RP/dRi6lP/IiQOg3fu6LSTRDkak+zKYA7S1boZL3SCefAm9H7lP7lxe34D++G4CcweWE
         Tysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710313932; x=1710918732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUeEEmvrXVjz8nX0zE+loC+ERznBjekZC7DXMyKlw94=;
        b=BcREO2ppps7McKW3CUMzIbmlBXuYwsnHvxHxRsGgnhchX5ORY4qZq+yS3wmS7HSmz+
         NG4jmx7hXmV0eHLlAs5+6aqFXamjoHOcaZSDAkZhTpHKBrqjaxqv2H/eAdy4eyHcKXZS
         zP7eW/pKAoipigcpISoiR0AlMIMv1HVQCEcC0YmyhFb4fpckBRUoIolF+A94F/nLb+xK
         iAiMmkJXrShiYZtGAbcXM4oUSIc3/8RL/QZs5p5/nCRBvRL2gJ5o4AATvq1pbHvjAmxo
         lfpTJDvebbRunhXOZLNIqfgrT69XO4j5D5lKQ/U5rq29TrZnoXwrGGAug7BZR6TM6EFP
         cCqw==
X-Forwarded-Encrypted: i=1; AJvYcCWhFuqcsgPW8T+utWogpkUxdoboq0HN0s2rHkG/XqU78pdDZ7H5K9DvYNaN9gDiM7mtRJYQLPSl0FM2yFRlD7KWIEAC5VQ=
X-Gm-Message-State: AOJu0Yx1hKnaw/WC+YIPircsSdDv9EpIIlQ73sCUPK+cZhjwdK+5oLDs
	yEdmgsamu9AvEOp6dslfE12FENiY7tuQYuuJkZ1yrLfCApUCNm+GDoRVmfbgTvQ=
X-Google-Smtp-Source: AGHT+IGAhXlOyTIasCZ1oXofKqW7fLjUn5QUwNAqvfrreaVvI2dD2vwqllW1t90TkcK+5NO/1oTsnA==
X-Received: by 2002:a17:907:7846:b0:a46:3f47:ea4b with SMTP id lb6-20020a170907784600b00a463f47ea4bmr2617362ejc.65.1710313931359;
        Wed, 13 Mar 2024 00:12:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906230800b00a4131367204sm4567232eja.80.2024.03.13.00.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 00:12:11 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:12:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Howard Yen <howardyen@google.com>,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	mathias.nyman@intel.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, andriy.shevchenko@linux.intel.com,
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Subject: Re: [PATCH v5 2/2] usb: host: xhci-plat: add support for multi
 memory regions
Message-ID: <18aa0f43-df7b-4a21-9359-02defa1b04a2@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311094947.3738200-3-howardyen@google.com>

Hi Howard,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Howard-Yen/dma-coherent-add-support-for-multi-coherent-rmems-per-dev/20240311-175308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240311094947.3738200-3-howardyen%40google.com
patch subject: [PATCH v5 2/2] usb: host: xhci-plat: add support for multi memory regions
config: riscv-randconfig-r081-20240311 (https://download.01.org/0day-ci/archive/20240313/202403131441.SrhLAZvp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202403131441.SrhLAZvp-lkp@intel.com/

New smatch warnings:
drivers/usb/host/xhci-plat.c:207 xhci_plat_probe() warn: missing unwind goto?

vim +207 drivers/usb/host/xhci-plat.c

ec5499d338ece9 Arnd Bergmann             2023-01-31  146  int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const struct xhci_plat_priv *priv_match)
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  147  {
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  148  	const struct hc_driver	*driver;
ec5499d338ece9 Arnd Bergmann             2023-01-31  149  	struct device		*tmpdev;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  150  	struct xhci_hcd		*xhci;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  151  	struct resource         *res;
e0fe986972f5b6 Heiner Kallweit           2022-05-12  152  	struct usb_hcd		*hcd, *usb3_hcd;
fe4daa605d0cae Howard Yen                2024-03-11  153  	int			i, count, ret;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  154  	int			irq;
f768e718911e03 Peter Chen                2020-09-18  155  	struct xhci_plat_priv	*priv = NULL;
16b7e0cccb2430 Johan Hovold              2023-11-03  156  	bool			of_match;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  157  
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  158  	if (usb_disabled())
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  159  		return -ENODEV;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  160  
1885d9a33753b7 Andrew Bresticker         2014-10-03  161  	driver = &xhci_plat_hc_driver;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  162  
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  163  	irq = platform_get_irq(pdev, 0);
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  164  	if (irq < 0)
4b148d5144d64e Thomas Petazzoni          2017-05-17  165  		return irq;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  166  
c6b8e79306f515 Adam Wallis               2017-09-18  167  	if (!sysdev)
c6b8e79306f515 Adam Wallis               2017-09-18  168  		sysdev = &pdev->dev;
4c39d4b949d36f Arnd Bergmann             2017-03-13  169  
4c39d4b949d36f Arnd Bergmann             2017-03-13  170  	ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
c10cf1189d7659 Xenia Ragiadakou          2013-08-14  171  	if (ret)
c10cf1189d7659 Xenia Ragiadakou          2013-08-14  172  		return ret;
c10cf1189d7659 Xenia Ragiadakou          2013-08-14  173  
b0c69b4bace370 Baolin Wang               2017-04-19  174  	pm_runtime_set_active(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  175  	pm_runtime_enable(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  176  	pm_runtime_get_noresume(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  177  
4c39d4b949d36f Arnd Bergmann             2017-03-13  178  	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
4c39d4b949d36f Arnd Bergmann             2017-03-13  179  			       dev_name(&pdev->dev), NULL);
b0c69b4bace370 Baolin Wang               2017-04-19  180  	if (!hcd) {
b0c69b4bace370 Baolin Wang               2017-04-19  181  		ret = -ENOMEM;
b0c69b4bace370 Baolin Wang               2017-04-19  182  		goto disable_runtime;
b0c69b4bace370 Baolin Wang               2017-04-19  183  	}
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  184  
fb222273a2159a Dejin Zheng               2020-03-24  185  	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
fd666348c51f6a Himangi Saraogi           2014-06-20  186  	if (IS_ERR(hcd->regs)) {
fd666348c51f6a Himangi Saraogi           2014-06-20  187  		ret = PTR_ERR(hcd->regs);
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  188  		goto put_hcd;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  189  	}
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  190  
e7020f193a3d13 Varka Bhadram             2014-11-04  191  	hcd->rsrc_start = res->start;
e7020f193a3d13 Varka Bhadram             2014-11-04  192  	hcd->rsrc_len = resource_size(res);
e7020f193a3d13 Varka Bhadram             2014-11-04  193  
08048c04cc6f75 Chunfeng Yun              2019-04-17  194  	xhci = hcd_to_xhci(hcd);
08048c04cc6f75 Chunfeng Yun              2019-04-17  195  
4736ebd7fcaff1 Heiner Kallweit           2022-05-12  196  	xhci->allow_single_roothub = 1;
4736ebd7fcaff1 Heiner Kallweit           2022-05-12  197  
fe4daa605d0cae Howard Yen                2024-03-11  198  	count = of_property_count_u32_elems(sysdev->of_node, "memory-region");
fe4daa605d0cae Howard Yen                2024-03-11  199  
fe4daa605d0cae Howard Yen                2024-03-11  200  	for (i = 0; i < count; i++) {
fe4daa605d0cae Howard Yen                2024-03-11  201  		ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
fe4daa605d0cae Howard Yen                2024-03-11  202  		if (ret) {
fe4daa605d0cae Howard Yen                2024-03-11  203  			dev_err(sysdev, "Could not get reserved memory\n");
fe4daa605d0cae Howard Yen                2024-03-11  204  			if (i > 0)
fe4daa605d0cae Howard Yen                2024-03-11  205  				of_reserved_mem_device_release(sysdev);
fe4daa605d0cae Howard Yen                2024-03-11  206  
fe4daa605d0cae Howard Yen                2024-03-11 @207  			return ret;

Needs to clean up before returning.

fe4daa605d0cae Howard Yen                2024-03-11  208  		}
fe4daa605d0cae Howard Yen                2024-03-11  209  	}
fe4daa605d0cae Howard Yen                2024-03-11  210  
4718c177405112 Gregory CLEMENT           2014-05-15  211  	/*
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  212  	 * Not all platforms have clks so it is not an error if the
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  213  	 * clock do not exist.
4718c177405112 Gregory CLEMENT           2014-05-15  214  	 */
08048c04cc6f75 Chunfeng Yun              2019-04-17  215  	xhci->reg_clk = devm_clk_get_optional(&pdev->dev, "reg");
08048c04cc6f75 Chunfeng Yun              2019-04-17  216  	if (IS_ERR(xhci->reg_clk)) {
08048c04cc6f75 Chunfeng Yun              2019-04-17  217  		ret = PTR_ERR(xhci->reg_clk);
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  218  		goto put_hcd;
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  219  	}
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  220  
08048c04cc6f75 Chunfeng Yun              2019-04-17  221  	xhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
08048c04cc6f75 Chunfeng Yun              2019-04-17  222  	if (IS_ERR(xhci->clk)) {
08048c04cc6f75 Chunfeng Yun              2019-04-17  223  		ret = PTR_ERR(xhci->clk);
8c6e8b09617915 Biju Das                  2023-01-21  224  		goto put_hcd;
4718c177405112 Gregory CLEMENT           2014-05-15  225  	}
4718c177405112 Gregory CLEMENT           2014-05-15  226  
224eb5311d6a8c Biju Das                  2023-01-21  227  	xhci->reset = devm_reset_control_array_get_optional_shared(&pdev->dev);
224eb5311d6a8c Biju Das                  2023-01-21  228  	if (IS_ERR(xhci->reset)) {
224eb5311d6a8c Biju Das                  2023-01-21  229  		ret = PTR_ERR(xhci->reset);
224eb5311d6a8c Biju Das                  2023-01-21  230  		goto put_hcd;
224eb5311d6a8c Biju Das                  2023-01-21  231  	}
224eb5311d6a8c Biju Das                  2023-01-21  232  
224eb5311d6a8c Biju Das                  2023-01-21  233  	ret = reset_control_deassert(xhci->reset);
8c6e8b09617915 Biju Das                  2023-01-21  234  	if (ret)
8c6e8b09617915 Biju Das                  2023-01-21  235  		goto put_hcd;
8c6e8b09617915 Biju Das                  2023-01-21  236  
224eb5311d6a8c Biju Das                  2023-01-21  237  	ret = clk_prepare_enable(xhci->reg_clk);
224eb5311d6a8c Biju Das                  2023-01-21  238  	if (ret)
224eb5311d6a8c Biju Das                  2023-01-21  239  		goto err_reset;
224eb5311d6a8c Biju Das                  2023-01-21  240  
08048c04cc6f75 Chunfeng Yun              2019-04-17  241  	ret = clk_prepare_enable(xhci->clk);
08048c04cc6f75 Chunfeng Yun              2019-04-17  242  	if (ret)
08048c04cc6f75 Chunfeng Yun              2019-04-17  243  		goto disable_reg_clk;
08048c04cc6f75 Chunfeng Yun              2019-04-17  244  
2847d242a1e48c Geert Uytterhoeven        2017-10-05  245  	if (priv_match) {
f768e718911e03 Peter Chen                2020-09-18  246  		priv = hcd_to_xhci_priv(hcd);
4efb2f69411456 Yoshihiro Shimoda         2015-11-24  247  		/* Just copy data for now */
4efb2f69411456 Yoshihiro Shimoda         2015-11-24  248  		*priv = *priv_match;
4efb2f69411456 Yoshihiro Shimoda         2015-11-24  249  	}
4efb2f69411456 Yoshihiro Shimoda         2015-11-24  250  
4bb4fc0dbfa23a Peter Chen                2020-09-18  251  	device_set_wakeup_capable(&pdev->dev, true);
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  252  
9fa733f24bb54d Roger Quadros             2015-05-29  253  	xhci->main_hcd = hcd;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  254  
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  255  	/* imod_interval is the interrupt moderation value in nanoseconds. */
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  256  	xhci->imod_interval = 40000;
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  257  
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  258  	/* Iterate over all parent nodes for finding quirks */
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  259  	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  260  
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  261  		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
4750bc78efdb12 Thang Q. Nguyen           2017-10-05  262  			xhci->quirks |= XHCI_HW_LPM_DISABLE;
4750bc78efdb12 Thang Q. Nguyen           2017-10-05  263  
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  264  		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
20f6fdd01c2c0d Pratyush Anand            2014-07-04  265  			xhci->quirks |= XHCI_LPM_SUPPORT;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  266  
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  267  		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
21939f003ad093 Felipe Balbi              2017-01-23  268  			xhci->quirks |= XHCI_BROKEN_PORT_PED;
21939f003ad093 Felipe Balbi              2017-01-23  269  
520b391e3e813c Prashanth K               2024-01-16  270  		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
520b391e3e813c Prashanth K               2024-01-16  271  			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
520b391e3e813c Prashanth K               2024-01-16  272  
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  273  		device_property_read_u32(tmpdev, "imod-interval-ns",
ab725cbec3e83d Adam Wallis               2017-12-08  274  					 &xhci->imod_interval);
222471f7640d97 Anurag Kumar Vulisha      2018-08-31  275  	}
ab725cbec3e83d Adam Wallis               2017-12-08  276  
16b7e0cccb2430 Johan Hovold              2023-11-03  277  	/*
16b7e0cccb2430 Johan Hovold              2023-11-03  278  	 * Drivers such as dwc3 manages PHYs themself (and rely on driver name
16b7e0cccb2430 Johan Hovold              2023-11-03  279  	 * matching for the xhci platform device).
16b7e0cccb2430 Johan Hovold              2023-11-03  280  	 */
16b7e0cccb2430 Johan Hovold              2023-11-03  281  	of_match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
16b7e0cccb2430 Johan Hovold              2023-11-03  282  	if (of_match) {
4c39d4b949d36f Arnd Bergmann             2017-03-13  283  		hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
7b8ef22ea547b8 Maxime Ripard             2015-03-17  284  		if (IS_ERR(hcd->usb_phy)) {
7b8ef22ea547b8 Maxime Ripard             2015-03-17  285  			ret = PTR_ERR(hcd->usb_phy);
7b8ef22ea547b8 Maxime Ripard             2015-03-17  286  			if (ret == -EPROBE_DEFER)
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  287  				goto disable_clk;
7b8ef22ea547b8 Maxime Ripard             2015-03-17  288  			hcd->usb_phy = NULL;
7b8ef22ea547b8 Maxime Ripard             2015-03-17  289  		} else {
7b8ef22ea547b8 Maxime Ripard             2015-03-17  290  			ret = usb_phy_init(hcd->usb_phy);
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  291  			if (ret)
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  292  				goto disable_clk;
7b8ef22ea547b8 Maxime Ripard             2015-03-17  293  		}
16b7e0cccb2430 Johan Hovold              2023-11-03  294  	}
7b8ef22ea547b8 Maxime Ripard             2015-03-17  295  
c94d41e9dd1ba3 Peter Chen                2018-09-20  296  	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  297  
8e10548f7f4814 Pali Rohár                2022-02-03  298  	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
f768e718911e03 Peter Chen                2020-09-18  299  		hcd->skip_phy_initialization = 1;
f768e718911e03 Peter Chen                2020-09-18  300  
bac1ec55143469 Tejas Joglekar            2020-12-08  301  	if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
bac1ec55143469 Tejas Joglekar            2020-12-08  302  		xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
bac1ec55143469 Tejas Joglekar            2020-12-08  303  
4ac53087d6d48e Roger Quadros             2015-05-29  304  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
7b8ef22ea547b8 Maxime Ripard             2015-03-17  305  	if (ret)
7b8ef22ea547b8 Maxime Ripard             2015-03-17  306  		goto disable_usb_phy;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  307  
e0fe986972f5b6 Heiner Kallweit           2022-05-12  308  	if (!xhci_has_one_roothub(xhci)) {
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  309  		xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  310  						    dev_name(&pdev->dev), hcd);
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  311  		if (!xhci->shared_hcd) {
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  312  			ret = -ENOMEM;
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  313  			goto dealloc_usb2_hcd;
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  314  		}
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  315  
16b7e0cccb2430 Johan Hovold              2023-11-03  316  		if (of_match) {
9134c1fd05034d Stanley Chang             2023-04-07  317  			xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
9134c1fd05034d Stanley Chang             2023-04-07  318  										"usb-phy", 1);
9134c1fd05034d Stanley Chang             2023-04-07  319  			if (IS_ERR(xhci->shared_hcd->usb_phy)) {
9134c1fd05034d Stanley Chang             2023-04-07  320  				xhci->shared_hcd->usb_phy = NULL;
9134c1fd05034d Stanley Chang             2023-04-07  321  			} else {
9134c1fd05034d Stanley Chang             2023-04-07  322  				ret = usb_phy_init(xhci->shared_hcd->usb_phy);
9134c1fd05034d Stanley Chang             2023-04-07  323  				if (ret)
9134c1fd05034d Stanley Chang             2023-04-07  324  					dev_err(sysdev, "%s init usb3phy fail (ret=%d)\n",
9134c1fd05034d Stanley Chang             2023-04-07  325  						__func__, ret);
9134c1fd05034d Stanley Chang             2023-04-07  326  			}
16b7e0cccb2430 Johan Hovold              2023-11-03  327  		}
9134c1fd05034d Stanley Chang             2023-04-07  328  
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  329  		xhci->shared_hcd->tpl_support = hcd->tpl_support;
e0fe986972f5b6 Heiner Kallweit           2022-05-12  330  	}
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  331  
e0fe986972f5b6 Heiner Kallweit           2022-05-12  332  	usb3_hcd = xhci_get_usb3_hcd(xhci);
e0fe986972f5b6 Heiner Kallweit           2022-05-12  333  	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
e0fe986972f5b6 Heiner Kallweit           2022-05-12  334  		usb3_hcd->can_do_streams = 1;
5de4e1ea9a731c William wu                2017-01-17  335  
e0fe986972f5b6 Heiner Kallweit           2022-05-12  336  	if (xhci->shared_hcd) {
4ac53087d6d48e Roger Quadros             2015-05-29  337  		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
4ac53087d6d48e Roger Quadros             2015-05-29  338  		if (ret)
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  339  			goto put_usb3_hcd;
e0fe986972f5b6 Heiner Kallweit           2022-05-12  340  	}
4ac53087d6d48e Roger Quadros             2015-05-29  341  
c70a1529b29cb1 Andrew Bresticker         2017-04-07  342  	device_enable_async_suspend(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  343  	pm_runtime_put_noidle(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  344  
b0c69b4bace370 Baolin Wang               2017-04-19  345  	/*
b0c69b4bace370 Baolin Wang               2017-04-19  346  	 * Prevent runtime pm from being on as default, users should enable
b0c69b4bace370 Baolin Wang               2017-04-19  347  	 * runtime pm using power/control in sysfs.
b0c69b4bace370 Baolin Wang               2017-04-19  348  	 */
b0c69b4bace370 Baolin Wang               2017-04-19  349  	pm_runtime_forbid(&pdev->dev);
c70a1529b29cb1 Andrew Bresticker         2017-04-07  350  
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  351  	return 0;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  352  
4ac53087d6d48e Roger Quadros             2015-05-29  353  
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  354  put_usb3_hcd:
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  355  	usb_put_hcd(xhci->shared_hcd);
0cf1ea040a7e2c Heiner Kallweit           2022-05-12  356  
4ac53087d6d48e Roger Quadros             2015-05-29  357  dealloc_usb2_hcd:
4ac53087d6d48e Roger Quadros             2015-05-29  358  	usb_remove_hcd(hcd);
4ac53087d6d48e Roger Quadros             2015-05-29  359  
7b8ef22ea547b8 Maxime Ripard             2015-03-17  360  disable_usb_phy:
7b8ef22ea547b8 Maxime Ripard             2015-03-17  361  	usb_phy_shutdown(hcd->usb_phy);
7b8ef22ea547b8 Maxime Ripard             2015-03-17  362  
4718c177405112 Gregory CLEMENT           2014-05-15  363  disable_clk:
08048c04cc6f75 Chunfeng Yun              2019-04-17  364  	clk_disable_unprepare(xhci->clk);
4718c177405112 Gregory CLEMENT           2014-05-15  365  
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  366  disable_reg_clk:
08048c04cc6f75 Chunfeng Yun              2019-04-17  367  	clk_disable_unprepare(xhci->reg_clk);
3ae2da7b28b393 Gregory CLEMENT           2018-04-20  368  
224eb5311d6a8c Biju Das                  2023-01-21  369  err_reset:
224eb5311d6a8c Biju Das                  2023-01-21  370  	reset_control_assert(xhci->reset);
224eb5311d6a8c Biju Das                  2023-01-21  371  
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  372  put_hcd:
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  373  	usb_put_hcd(hcd);
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  374  
b0c69b4bace370 Baolin Wang               2017-04-19  375  disable_runtime:
b0c69b4bace370 Baolin Wang               2017-04-19  376  	pm_runtime_put_noidle(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  377  	pm_runtime_disable(&pdev->dev);
b0c69b4bace370 Baolin Wang               2017-04-19  378  
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  379  	return ret;
3429e91a661e1f Sebastian Andrzej Siewior 2012-03-13  380  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

