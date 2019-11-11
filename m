Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA3C17442
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:59:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAB7206B6
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dmSbbkVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAB7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0EF00C6A;
	Mon, 11 Nov 2019 02:59:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 32A7ABE7
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:58:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D6330102
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:58:58 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id o49so14143403qta.7
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=content-transfer-encoding:from:mime-version:subject:date:message-id
	:references:cc:in-reply-to:to;
	bh=65bhuoPgriNtBUE2R+ohrdrdN/rvxnp383N9kf00A4s=;
	b=dmSbbkVEbFq3Auqxd7cNVOfavGXhUuzR/jNDxWcpYZsb/q5otj5juiciqFQLs5h9zu
	ua8wpEmtXRG49V+5P/HRsP8O5U1OgNREa/hCWX85nLnyvR+pIvYWO8pyTnnOGgTgrPwg
	ytx7Ll+rB1zUqY22w/s3m4fbnn94LFpxK1s/YMhyHR0/q/DPboqWMsPIu+WhxBb4N1ej
	WiPWDyK9nT7cThdxDd0bn7yBFfsFaXJwjrGzb2J7IrhEl3XuWFfyzsOxt7J85W/iQChi
	73+Xuu5oCmnJfCcbRdhWgFfA3/8KENy2CKbN8AuXD/bjuJUZsyVREd+a/7dGd37Yy6cT
	jyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:content-transfer-encoding:from:mime-version
	:subject:date:message-id:references:cc:in-reply-to:to;
	bh=65bhuoPgriNtBUE2R+ohrdrdN/rvxnp383N9kf00A4s=;
	b=YLxRMQPpB+tA4DFSPnQ0ZvkL+8yiYKedEURMunf9aRPOcEz0HHt6vTkGMM31oCTL9M
	Sm4hPUiEMoH+YSfHoE0migVTJTNDhTu0RK/jfPFoHl+6SvTvh3+lXKwBsRBVTh2khLmW
	2jjxGRB3MTuHB6UzEONxfZrF/7HAOZafcS+mueuqFG5Bpv9MguIOk5azgTHNqVpi3Vud
	GBbF9GswvgTIt8WhYsw3YJAlIrKjs8J2Y30fIk5WVLcZO95oQAqyGeVJVkqMQO8LrjlA
	q8P5nDDkxxvCoV2w4IfRhZbNrJAR1hDe4j1jSesnc7ms7JFWGeZ888Ym4ZTI8rlJ+4si
	nnUQ==
X-Gm-Message-State: APjAAAX4QZHJTKORG57ImkVGyCXQYml+SydmnG3G6mSyPmmNBUVUCyfl
	AxYxy0hk16VROwhQk0BZvg/z4w==
X-Google-Smtp-Source: APXvYqzgxJuH1MyOEI2dRYJeUBelSt0rQZuJ56c5fwz39EZF78E2gj0SlimsTSCYTi0Z+TMmH4PwUw==
X-Received: by 2002:ac8:524a:: with SMTP id y10mr23155907qtn.325.1573441137896;
	Sun, 10 Nov 2019 18:58:57 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
	[71.184.117.43]) by smtp.gmail.com with ESMTPSA id
	r80sm6465873qke.121.2019.11.10.18.58.56
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Sun, 10 Nov 2019 18:58:57 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
Date: Sun, 10 Nov 2019 21:58:56 -0500
Message-Id: <472617D4-1652-45FB-90A4-0D45766DB78B@lca.pw>
References: <20191109034039.27964-1-baolu.lu@linux.intel.com>
In-Reply-To: <20191109034039.27964-1-baolu.lu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: iPhone Mail (17A878)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
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



> On Nov 8, 2019, at 10:43 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> +config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +    prompt "Enable Intel IOMMU scalable mode by default"
> +    depends on INTEL_IOMMU
> +    help
> +      Selecting this option will enable the scalable mode if
> +      hardware presents the capability. If this option is not
> +      selected, scalable mode support could also be enabled
> +      by passing intel_iommu=sm_on to the kernel.
> +

Does it also make sense to mention which hardware presents this capability or how to check it?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
