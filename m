Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9520DC433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 15:31:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3CF60FED
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 15:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C3CF60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA16583C25;
	Tue, 19 Oct 2021 15:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3zXJR-9SIdYS; Tue, 19 Oct 2021 15:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CBBE983C3D;
	Tue, 19 Oct 2021 15:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9494EC0011;
	Tue, 19 Oct 2021 15:31:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CDA6C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 15:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BABA60C01
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 15:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1HxbhPSEymKV for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 15:31:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E67260BFF
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 15:31:51 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 o24-20020a05600c511800b0030d9da600aeso3613883wms.4
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ahyIg8IXbPMyXbPLTmiCDlAfPsNcwBHd3znqPzuBKqo=;
 b=tD8/Ui0VOLFB+QsqZDNEIiSk/TpeD42xZaRnIW1xDxShBJrWHlUKopOsDvHIcwc8Pq
 AOBw2hWypue34RBfF8WtRK0cx8mcmrkeaGAMSPls5rtGKJYdsTRqtkd4f6buSVVqxQg5
 T+VFoppoHgQECGetLRmx0l1zTqNLX8D/8CMK6aQPKi+gstYUF2wgvAxv65mHPTeSNcs7
 fFlvfTqRY9UhN1oxhB83rBXgpqJOhvCKhgyDeGa1Rh83P15gbRIRzUr1iUvlKcSOHGqV
 GaL2/AyTIbE4t+atMRdbmzNUTsroe+T6bEykru98nQU3PCOV8q2Zrs9jPlb+pBuvGilu
 Jxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ahyIg8IXbPMyXbPLTmiCDlAfPsNcwBHd3znqPzuBKqo=;
 b=74NNygbboV9BPAKNsGfbWhcvL+29qX5Jx+nlAT0aj+H7GB8aZr0JN6knkdshFzIk52
 KyKdL4DxHxd07gQDAp/PDq01TR6tC+krbTzPu/yvxm54ZMmGrgFm/ESrNDQBgMJ8CpDZ
 SDMkd3oKA1owZHY4j0TNSNw6/+fT8/brcbnRxr4HKE9wQnZJUEMWWFKl/rZ3SGXXwFAF
 29eIHi6GG/4g8Uhy7FK8cG/u7SBMeqlop6vpKlGUuAQ1do4W9expr9uWTYPf1QaIbzi6
 nZgHwB3BGO4SG7PbZ5rIP+K8R2LK6W1+z4VVC2A+XftOoj/ufkTy3aXE5CBal+1NaW0M
 1VoA==
X-Gm-Message-State: AOAM533/hy5Tk1ijePRIgiUZ1bfewaflNFk4kLb+O3TgZQJyv131qNxI
 7RnJxqIYj6TOmB48daoJrp99iw==
X-Google-Smtp-Source: ABdhPJwm0+YKImJfZsVs1yBP6XntaugFO7fd3tS2pFtn2Irj9kJxrmGBbC5MtCnBaR35OpDvGBq6qg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr43901799wrc.209.1634657509428; 
 Tue, 19 Oct 2021 08:31:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id i13sm2943270wmq.41.2021.10.19.08.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 08:31:48 -0700 (PDT)
Date: Tue, 19 Oct 2021 16:31:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
Message-ID: <YW7kz8MG9SBEyCim@myrica>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YW2RfXJwAxFYOYzs@myrica>
 <20211018113237-mutt-send-email-mst@kernel.org>
 <CACGkMEuJrQcPSMdRJ9wmc3riLK_3Q6t9596b5ida-j00Yf7+WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEuJrQcPSMdRJ9wmc3riLK_3Q6t9596b5ida-j00Yf7+WQ@mail.gmail.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "will@kernel.org" <will@kernel.org>
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

On Tue, Oct 19, 2021 at 09:22:13AM +0800, Jason Wang wrote:
> > > So I think clarifying system reset should address your questions.
> > > I believe we should leave bypass sticky across device reset, so a FW->OS
> > > transition, where the OS resets the device, does not open a vulnerability
> > > (if bypass was enabled at boot and then left disabled by FW.)
> > >
> > > It's still a good idea for the OS to restore on shutdown the bypass value
> > > it was booted with. So it can kexec into an OS that doesn't support
> > > virtio-iommu, for example.
> > >
> > > Thanks,
> > > Jean
> >
> > Is this stickiness really important?

It is important when FW has to hand the IOMMU over to the OS while keeping
DMA disabled for all endpoints. For example DMA was globally disabled on
boot through some external mechanism (e.g. Bus Master Enable in PCI
bridges), and FW disables IOMMU bypass before enabling Bus Master, and
there are some untrusted endpoints in the system that should never be
allowed to perform arbitrary DMA. If a side effect of resetting the IOMMU
is to enable bypass, then the OS opens a vulnerability without knowing it.
That's a real problem on hardware platforms, but maybe too far fetched on
virtual ones.

> > Can't this be addressed just by hypervisor disabling bypass at boot?

Yes I suppose we have that option. If we make bypass non-sticky, we're
preventing FW from working around vulnerable device implementations, but
fixing the implementation itself is much easier in virtualization than in
hardware.

> And I'm not sure if sticky can survive transport reset.

I thought "device reset" includes transport reset as well?  There seems to
be a precedent with virtio-mem which keeps state across device reset. And
PCI allows sticky registers across FLR (RWS registers)

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
