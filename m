Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA1C433EF
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 11:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D50FD84B46;
	Wed, 12 Jan 2022 11:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tC3CTpIx6RCj; Wed, 12 Jan 2022 11:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC6A384B1C;
	Wed, 12 Jan 2022 11:54:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 881CFC002F;
	Wed, 12 Jan 2022 11:54:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB98C001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 041146FB9A
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TqeuGmthWvG for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:54:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 811726FB88
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:54:39 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 b1-20020a17090a990100b001b14bd47532so4324396pjp.0
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 03:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LT0CPQ4LjGQda0r31DVagHWPW/WMPcFrzJQSM8nEMzY=;
 b=XXHml25tt60drO39EtR8zK5L1Iz7/ByCY2ePEkE6ZC3/SXcRL8eYBBAc5Z2o4STa6Y
 ERzQII6QW51u9O72XmVQdBn10hSPBEirs/WSNZynh0UdcWJaYwiOMFNQYGeYQzk4BB0Q
 H0MtQWV7t5ww1dfQ0ulV1KsNttsDxZsgbJOmc4CP+2kpyEPvmfdpmmuIdbTWFY78lwp6
 i4YoMn8EhjD+Eq7sqPjs5fFmEcqo7C42qJpNWQ9aQyilQA98CgaB2sTZw0KTSKX3VdSj
 3DMq7SKJeDzCIwCTdsZY9yg3ZHrfcth7njtWIwbn1QEu1TrEepKOO3h5MhujyOF7o6MF
 l4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LT0CPQ4LjGQda0r31DVagHWPW/WMPcFrzJQSM8nEMzY=;
 b=Bjy2R0fllPSeAAaoSfVUpC71PFRyZJa01z6x9k1fhCqJTnNK8PjgZmC7C0k1LeSk3Z
 o16Sw8VAJQp10dW7h4eLIydXSRtJreYIVV3a2LAar6ttXaILbcUARyHeC7p3FDAke45Z
 betrV+KT3yNGW8DpA1vu71tWbiYH53Orzdm3RCbAypH+BajV9qPzu0MFKKCMryduPt/f
 qkT64PyOBpD8khECr3YQigzQIrIlmugE+k7ufY5qVqk4CimSJXHFb4Ny8smQMMbUEWht
 088mzQeSpPQlGF+slp0GJKkFHVFZ7G1Zxp0ZaKizjHvmSM5DIfD0ktpFaIBBefuqk4u7
 gLkA==
X-Gm-Message-State: AOAM531BRHvd+n2ZMotETc3gFIcdgtTUqLARA1z6zUGF4cR6BUAzdzkJ
 nY33Y7jZy3JMD6n/biRTJh8=
X-Google-Smtp-Source: ABdhPJwJYlKnZr2PrQgseAYhkwhTlfxEl3/6t8ytnMogoOwa6qEIpKivSILXXDn61XzZIX3rkM/WJw==
X-Received: by 2002:a05:6a00:2151:b0:4a2:5c9a:f0a9 with SMTP id
 o17-20020a056a00215100b004a25c9af0a9mr9073381pfk.39.1641988478895; 
 Wed, 12 Jan 2022 03:54:38 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([159.226.95.33])
 by smtp.gmail.com with ESMTPSA id r11sm13791398pff.81.2022.01.12.03.54.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Jan 2022 03:54:38 -0800 (PST)
Date: Wed, 12 Jan 2022 19:54:35 +0800
From: Miaoqian Lin <linmq006@gmail.com>
To: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Message-ID: <20220112114851.GA712@VICKYMQLIN-NB1.localdomain>
References: <20220107080428.10873-1-linmq006@gmail.com>
 <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
 <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
 <fd659736-2106-1be3-084b-7caddf2dc18e@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd659736-2106-1be3-084b-7caddf2dc18e@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Nagalla, Hari" <hnagalla@ti.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Suman,

On Mon, Jan 10, 2022 at 12:43:57PM -0600, Suman Anna wrote:
> Hi Miaoqian,
> 
> On 1/9/22 8:43 PM, Miaoqian Lin wrote:
> > Hi Suman Anna,
> > On Fri, Jan 07, 2022 at 08:42:16AM -0600, Suman Anna wrote:
> >> Hi Miaoqian,
> >>
> >>
> >>> Add the corresponding 'put_device()' in the error handling paths.
> >>
> >> Also, need it in the regular path, not just in error handling path.
> > I think after calling platform_get_drvdata() normally, the
> > reference will be released in other functions, so don't need it in the
> > regular path.
> > 
> 
> No, it's a local reference and is acquired within omap_iommu_probe_device() and
> needs to be released within this function. What other function are you referring
> to here?
> 

I am referring to the release function of this device, here is
omap_iommu_release_device(). But I find omap_iommu_release_device()
doesn't handle the reference, and calls kfree(arch_data) directly.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
