Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1485C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:23:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B0421783
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rjx1UwaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B0421783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 274A4B65;
	Mon, 11 Nov 2019 14:23:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 34EEBAC8
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:23:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9467D12E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:23:40 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id l1so2151480wme.2
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 06:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=QhApH+e+i1QGjMyLyS0RlzrYEikz1jJglxVHu07q3w0=;
	b=Rjx1UwaCBW1rE0eMUFcg/MO/zhXAlW1fiGdqMrr493J7PHC3rRC11Hzq2kgf0EJEqK
	TajBAFbNmyn6iiEtjb7PVgsi7QMdjGHQdxvlW9YZqfm3D4X7aVALVYsfec//hz3W2ieT
	zxxs151ehHtsvrylhaKFlSx0lxoFVXdxlXValihzN2TjNsSfazyu8jjLdTg0hKkYUZ3K
	RQJGjHW6WtcUfkUikinuH13LbrAPhwecSnkv9Ic30ORfkYqxx/LboNzB/sOPCRqGsNAf
	5sD5jJUBSK5c5dAylA8wb7qYUQpYj/xWGWR8i9s/XplykSH9BB7XFnARx0g+FPpigAz9
	yAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=QhApH+e+i1QGjMyLyS0RlzrYEikz1jJglxVHu07q3w0=;
	b=E69Fn7cEO/4upSDKAeimsvAcNmyEVxSn8hq9/wNLXxIsFr5OCgdcJdKyamYa/JGhGP
	NEW2QvbxB9rPKRtDB4GQC92OZb3lQbEloFql6qYIxDyov7ucD8220nheGvNvDWOGkYxP
	R2/HgNSYomUHp/1vNpXs0CbK44KZ7XorAkrp+2P1PFBSJ3s2KOtzQeWJDIBppxwKW4+t
	sVLR8xMaMbOYEt7RBcsz9wzgQ/rjOcCP/E6vB36rwe/WyY/xFdBh54WmiF0k6m1h4NH0
	GKhb5FUsU7hgfNeLT6Ut3snhAAGVb2z7wC5M7u3oryvVH+Gxa/eGNtDyEQHY1eRJ1Fh0
	M1yg==
X-Gm-Message-State: APjAAAXHC/6Zp1Ctx5IHvLGa9leNIZowWPoETcB0VvLliBk/IgINXMjS
	iDljegHnunM8bgUWKNvFEbpcqg==
X-Google-Smtp-Source: APXvYqzlKqn/z/qlkyc8kfzKpiMoqvEhMc93VYH6no07llV4Ze4AbBRWFrOgSZTRuLAk9Ukd0pheOA==
X-Received: by 2002:a1c:98c5:: with SMTP id
	a188mr20837159wme.133.1573482219172; 
	Mon, 11 Nov 2019 06:23:39 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
	by smtp.gmail.com with ESMTPSA id
	n23sm15692840wmc.18.2019.11.11.06.23.38
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 11 Nov 2019 06:23:38 -0800 (PST)
Date: Mon, 11 Nov 2019 15:23:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Don't display an error when IRQ
	lines are missing
Message-ID: <20191111142336.GC4132491@lophozonia>
References: <20191111111721.4145919-1-jean-philippe@linaro.org>
	<d0dfd82d-dcec-010c-6a69-c8f2b15f5c7a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d0dfd82d-dcec-010c-6a69-c8f2b15f5c7a@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

Hi John,

On Mon, Nov 11, 2019 at 11:52:38AM +0000, John Garry wrote:
> On 11/11/2019 11:17, Jean-Philippe Brucker wrote:
> > Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
> > to platform_get_irq*()"), platform_get_irq_byname() displays an error
> > when the IRQ isn't found. Since the SMMUv3 driver uses that function to
> > query which interrupt method is available, the message is now displayed
> > during boot for any SMMUv3 that doesn't implement the combined
> > interrupt, or that implements MSIs.
> > 
> > [   20.700337] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ combined not found
> > [   20.706508] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ eventq not found
> > [   20.712503] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ priq not found
> > [   20.718325] arm-smmu-v3 arm-smmu-v3.7.auto: IRQ gerror not found
> > 
> > Use platform_get_irq_byname_optional() to avoid displaying a spurious
> > error.
> > 
> > Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> That stops a nuisance:
> Tested-by: John Garry <john.garry@huawei.com>

Thanks

> However, I will say though that the combined irq seems necessary for TX2,
> which is not warned about being missing now.

I don't think we warned about this before commit 7723f4c5ecdb either.
There are some warnings later in arm_smmu_setup_irqs() if the firmware
didn't describe any wiring at all, but we don't check whether the TX2 does
have the combined interrupt. Personally I wouldn't tie this to one SMMU
implementation because it would prevent from supporting a (hypothetical)
platform that integrates the same SMMU but "fixes" the IRQ lines.

> Finally, A cover letter would have been handy to mention that the new API
> was only introduced after rc1

Oh, I didn't even notice that, I thought it was introduced by rc1. I'll
add a cover if I send a v2.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
