Return-Path: <SRS0=KSvG=YF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C47C47404
	for <iommu@archiver.kernel.org>; Sat, 12 Oct 2019 00:06:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8B02089F
	for <iommu@archiver.kernel.org>; Sat, 12 Oct 2019 00:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="focYvhDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8B02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B3D981D5A;
	Sat, 12 Oct 2019 00:06:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6DBF31AD2
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 23:55:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 22B8D12F
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 23:55:59 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id y22so6979240pfr.3
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=B53cihCDlQEMDEXWkPSpWvvJvFe4J1DmTtw67eP/AR8=;
	b=focYvhDusq7k7Sglq+SIQ8pVkuU3dKBEqSJ35alrt50LvSHfrQWxNay7wgpupYLQSG
	6uMdheHpg/2DhAWDIuxvXJrcFjL9nUCd4pKzlZsiZvmX9JpRvn0SSA83m9DC5QNkJGaN
	04lt3hs9g6a/yr/VWcV+/5Z5hpkxBHrSsEzk0uvDU7SY8oIXGbSnX8+B6PVpLiLbsgrY
	zgf/0+fhrHM9kp14pAEz5SG59oEj85K0WxS/wqYKcHoJqNBCVFUMyO+u2fGQHK0Mjwvd
	i29oRue0YJI2wFfoJcUg4IRt9fqMeHklgvR/KLHGzXw8NnUbf7qro7qdHXTdQXX9ynJw
	xE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=B53cihCDlQEMDEXWkPSpWvvJvFe4J1DmTtw67eP/AR8=;
	b=Kn4V4Bt8FBYT3MNSkhM/tSyJK6hSGDXCPvbgTrg5nkeRb/KgltDXLMCasN8ae16gGG
	bvs8PomTXbvN86nhiXqQXYtPvW8MPvJ4eln9Dn7ZKSed5sTf5/iyrgYRXHnQU1JAfyBc
	Y00ExSt/X4/3Dk6kOQaFvL/IJ/Af+cDp0Ql+4njcEZ0Ia/nkKIYSSOjH844TffOvHvP3
	DS5LsON2WwovPjnr878qLx9rIRcrTTlfZIXw0FvYBEXrv1/k5hfIWi5YAhWHUqJlrjW+
	4k2IL7DRK357UNvUQbl8DwB8+sot0FvfcxqRZWLcpdelEONxWZW+i3jdCw3fPzHOfdnm
	F8eg==
X-Gm-Message-State: APjAAAWhMO8fmhVcFydB6Ua9qYOBBXNjZfyhZ1slXoy75pkw4ePgjGx3
	4f3ZT2wD70SGSJ1PN9AS+CY=
X-Google-Smtp-Source: APXvYqykbanmhecTAUKKoCbXPpv7i5TVrqw+8GQSS1J+dImn1y1yvpKb9BgeUI0Fa24oEauLCUbPHw==
X-Received: by 2002:a62:d402:: with SMTP id a2mr19167165pfh.115.1570838158481; 
	Fri, 11 Oct 2019 16:55:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	g12sm16155270pfb.97.2019.10.11.16.55.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 11 Oct 2019 16:55:58 -0700 (PDT)
Date: Fri, 11 Oct 2019 16:55:25 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Add an optional "input-address-size"
	property
Message-ID: <20191011235524.GA20683@Asurada-Nvidia.nvidia.com>
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
	<e99e07c2-88c6-e4d8-af80-c46d36bc6cd0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e99e07c2-88c6-e4d8-af80-c46d36bc6cd0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 11, 2019 at 10:16:28AM +0100, Robin Murphy wrote:
> On 2019-10-11 4:46 am, Nicolin Chen wrote:
> > This series of patches add an optional DT property to allow an SoC to
> > specify how many bits being physically connected to its SMMU instance,
> > depending on the SoC design.
> 
> This has come up before, and it doesn't work in general because a single
> SMMU instance can have many master interfaces, with potentially different
> sizes of address bus wired up to each. It's also a conceptually-wrong
> approach anyway, since this isn't a property of the SMMU; it's a property of
> the interconnect(s) upstream of the SMMU.
> 
> IIRC you were working on Tegra - if so, Thierry already has a plan, see this
> thread:
> https://lore.kernel.org/linux-arm-kernel/20190930133510.GA1904140@ulmo/

Thanks for the reply and link!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
