Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD999C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 07:27:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5AF613D7
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 07:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5AF613D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1525F606AE;
	Thu,  3 Jun 2021 07:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K60OOdixjE0i; Thu,  3 Jun 2021 07:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2C79606BD;
	Thu,  3 Jun 2021 07:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC199C000D;
	Thu,  3 Jun 2021 07:27:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE612C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 07:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D480B404F6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 07:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwXvCxCYaVCp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:27:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88883402CD
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 07:27:00 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id y7so117096wrh.7
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LjHtr3gTuVS3B9K5gbkiLkfbQy+nc18Icq13dk6Hd1w=;
 b=gqAljoVqc5fs1ymDkbbBYpsEQ7RF47C3qAXxPM/IDZ7QGRMMt4Qm9KZjsynqPNnZFx
 G88bnyxRirGhQlA5aMJ+ZlaywFszPax9Ye7ymRdRlmNAfmC6tMZpNr5ASjvmgSW6oPNM
 psClF/DwNzrV5uPP9TD5iPoCD8EHb5usEhu3PuHfta13Zvk/12h15e0W98vrRkcdFvO5
 Vn+4SexMSyoG+9o8Qd2zKDwZiiHGcvL7/yN4eycIvfp9SK9ShWiJYWiDgECcBlxLjwNv
 jLcrHvpY2qI1Rubo8cyK7e3T9D2TTbHvDweU8BtFKgrSPQZBHY8QAq4bugMxn4Tk0MW3
 ftDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LjHtr3gTuVS3B9K5gbkiLkfbQy+nc18Icq13dk6Hd1w=;
 b=iANTmWBtTFPEaEOONAMNoOQZ7zlgdQFEmTU/UYQqossDHnyYjHQQGzmhO45+dlnaxu
 ZBJOqZIM1RFopNNdcG/JLjpFRaAEDauUAZ84i6GTwHiHw9Qz/0T4BARc4eHBPr7Wvbdq
 X0B9hi8MNma57LqHasqg+OIJVcURhGVtuCpVPExKoDDenYnNVXLhanHPYCSPyh4hqLQo
 fEalLPpxa1rMWqFfHJ1c2i0i0RP1wrrfiW71hmigTOgmtWqPFbxHdV8kgSSXedM7pJQc
 4x1LAMwmf9Q6e1LGXAbj75UnyPCdUGm+N1WUF0/X0iNo3WuaV4kW4PkYgmm9OmojC/Zq
 sThQ==
X-Gm-Message-State: AOAM532d5SJO/j1WW42Yqywe9HYLF97hRwpcXsN+qa684f8NVCW74kyj
 xEH9IeF5UZlM14PNJA9i02YcOQ==
X-Google-Smtp-Source: ABdhPJwRy3qSdOxODp9+jlDSTJTRJuDx6IpDrmgJgxbzvXau7vT2HNKEfmMsuaZf+pQ3I7sWqx4oxA==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr8109626wrr.35.1622705218314; 
 Thu, 03 Jun 2021 00:26:58 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id n2sm2121259wmb.32.2021.06.03.00.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 00:26:57 -0700 (PDT)
Date: Thu, 3 Jun 2021 09:26:39 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YLiELyo+KLuYqA24@myrica>
References: <20210602154444.1077006-3-jean-philippe@linaro.org>
 <202106030417.97asL7dA-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202106030417.97asL7dA-lkp@intel.com>
Cc: kbuild-all@lists.01.org, linux-acpi@vger.kernel.org, mst@redhat.com,
 catalin.marinas@arm.com, rjw@rjwysocki.net, clang-built-linux@googlegroups.com,
 iommu@lists.linux-foundation.org, will@kernel.org, dwmw2@infradead.org,
 lenb@kernel.org
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

On Thu, Jun 03, 2021 at 04:06:18AM +0800, kernel test robot wrote:
> >> drivers/acpi/scan.c:1540:26: error: no member named 'ops' in 'struct iommu_fwspec'
>            return fwspec ? fwspec->ops : NULL;
>                            ~~~~~~  ^
> >> drivers/acpi/scan.c:1564:9: error: implicit declaration of function 'iommu_probe_device' [-Werror,-Wimplicit-function-declaration]
>                    err = iommu_probe_device(dev);
>                          ^

These are only defined when CONFIG_IOMMU_API is set. IORT uses them inside
an #ifdef, I can do the same. Maybe moving these two functions to a new
drivers/acpi/iommu.c would be nicer, though.

Thanks,
Jean

>    2 errors generated.
> 
> 
> vim +1540 drivers/acpi/scan.c
> 
>   1535	
>   1536	static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
>   1537	{
>   1538		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   1539	
> > 1540		return fwspec ? fwspec->ops : NULL;
>   1541	}
>   1542	
>   1543	static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
>   1544							       const u32 *id_in)
>   1545	{
>   1546		int err;
>   1547		const struct iommu_ops *ops;
>   1548	
>   1549		/*
>   1550		 * If we already translated the fwspec there is nothing left to do,
>   1551		 * return the iommu_ops.
>   1552		 */
>   1553		ops = acpi_iommu_fwspec_ops(dev);
>   1554		if (ops)
>   1555			return ops;
>   1556	
>   1557		err = iort_iommu_configure_id(dev, id_in);
>   1558	
>   1559		/*
>   1560		 * If we have reason to believe the IOMMU driver missed the initial
>   1561		 * add_device callback for dev, replay it to get things in order.
>   1562		 */
>   1563		if (!err && dev->bus && !device_iommu_mapped(dev))
> > 1564			err = iommu_probe_device(dev);
>   1565	
>   1566		/* Ignore all other errors apart from EPROBE_DEFER */
>   1567		if (err == -EPROBE_DEFER) {
>   1568			return ERR_PTR(err);
>   1569		} else if (err) {
>   1570			dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
>   1571			return NULL;
>   1572		}
>   1573		return acpi_iommu_fwspec_ops(dev);
>   1574	}
>   1575	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
