Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8CC433E4
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 07:27:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390F4206F5
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="bSlzrRXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390F4206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E4408A1FA;
	Thu, 16 Jul 2020 07:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OMBtvtoPOp-k; Thu, 16 Jul 2020 07:27:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E949C863B7;
	Thu, 16 Jul 2020 07:27:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D293DC07FF;
	Thu, 16 Jul 2020 07:27:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3C12C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C3B1288259
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rju_gcR2hoj0 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 07:27:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 01C7788243
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:27:36 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id k15so2754006lfc.4
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zPDRGSa50UmakAcCbGtdk+EyDTkt0fVgobaBWRA0X/4=;
 b=bSlzrRXjpKRPCl0hArlSuL0p66sGr+eTsxLNyQvOi9YB3Pjk9vOPe3d2OKG1DF9kPx
 CO1KN2bjOhfUZyk8ZcgsRvcgfv0U7EsODKgUnUNrNtPVPeZzh5rVBDJhJQdj+NNK9W9r
 EVVxv1Lg7/nWWVm0ZOr5n3C7KA0Kd3OUnIRJUxHNPBWUAmD9prbOFiGk59RkD/TGLLuP
 BwvwKl6n9rATW+k54GyLtBkxC7XcSaJ2FGF8E+P3XlSzhtmzZBw4imaG6E9McesxzIE6
 NVw58/IU//Ud31i+CqWs2uIvj9TqdunDiIzaNTbZykEZsRuWxlHFwBDiOefTpTAqXbeo
 +Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zPDRGSa50UmakAcCbGtdk+EyDTkt0fVgobaBWRA0X/4=;
 b=NvqE6lUY051H2fK064cEWW4QJlwjFJ7KNjfpXywSBEf/dKBbKzECNOYsqxR4XHiVnT
 5h5RnB6XKJBdCSltXiY+SEuF5PAuON+duDo65FKtaldx1eYk+MCD+yJtFBVLIxSnMxFj
 kVJeHGgRQwZocqHNipURC3OBmfiAvzFFPLvQI8XTSHaBbZlKHmjSCq0CenfiVTcyi+C7
 ZJH/8tQbfg33OKf57kNrFCRlYYux/vT12SsB6vwiFw8kKJ+65nnkrMg6YH+sM/vSSjbF
 OMIPKgsCEc84aMkXl2t0RmCT/ShciRp0W2LC7UjFA8nNsPUC+klMoJvoDrEQEAAAezJb
 d9EQ==
X-Gm-Message-State: AOAM5309cm3LlHi7snb387oyV2wjgdlRC1JBt58be9d5OE+HsZQB9egg
 jTlwODpDp2ZE2LMlea/209LtVw==
X-Google-Smtp-Source: ABdhPJzjgZSJHNOCVeLAWUGQMY4lBBLhOUXjm/PaVTPymlG/+KgEIckwdogSmLzxx8u074kW6hfL1A==
X-Received: by 2002:a19:8407:: with SMTP id g7mr1444144lfd.61.1594884455131;
 Thu, 16 Jul 2020 00:27:35 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
 by smtp.googlemail.com with ESMTPSA id v19sm1000788lfi.65.2020.07.16.00.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 00:27:34 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
References: <20200715070649.18733-1-tn@semihalf.com>
 <20200715070649.18733-4-tn@semihalf.com>
 <7147e4ae-30e2-5a2f-7fb0-4027e9adc94c@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <282a8963-c2c2-c68d-e77e-28da18096d71@semihalf.com>
Date: Thu, 16 Jul 2020 09:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7147e4ae-30e2-5a2f-7fb0-4027e9adc94c@arm.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 15.07.2020 12:36, Robin Murphy wrote:
> On 2020-07-15 08:06, Tomasz Nowicki wrote:
>> Add specific compatible string for Marvell usage due to errata of
>> accessing 64bits registers of ARM SMMU, in AP806.
>>
>> AP806 SoC uses the generic ARM-MMU500, and there's no specific
>> implementation of Marvell, this compatible is used for errata only.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Presumably Will can pick up these first 3 patches for 5.9 and #4 can go 
> via arm-soc.

Thanks Robin for review and valuable comments.

Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
