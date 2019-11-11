Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF50C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F0F21783
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Bgw8Z2dG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F0F21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4F9B5CB0;
	Mon, 11 Nov 2019 14:05:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 16D5ECAD
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:05:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
	[209.85.219.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 930C68AB
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:05:23 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id w11so4876963qvu.13
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=content-transfer-encoding:from:mime-version:subject:date:message-id
	:references:cc:in-reply-to:to;
	bh=TUlJCeoF38DKIrVWoIThW1y6VPH1GtKS/JV6B3O9+e8=;
	b=Bgw8Z2dGCYAnlOXhOPDnkhsV3By/I0Z7d7ccWtm1tXqINtmjF4r9crBGOwA312gElP
	ZZgSr9vVjPOGi06MDhGGOwG+eqKCnnjKUrq4pcXW6QB3+zhieOT4jwQrYDhQwtaU/CJz
	bwLos1fDgh9ocIxTS0BsZ5deRjRtihP/UhG66iyMXhsHdIYA2oLAV607Vi+lfk2FZCj6
	uAhu1UKADe4jAOz1KA4HWC+wkggiNw4PqETA5ozAyYyiu0x1NT+B4Q8HtRXyz9MiZxnF
	dCr44BHhu4tzalrK2+gzFzlz2k6eSpj7pvGZeZHdkbauLL6St6r4tcIXIBmh3R+3u6KP
	nJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:content-transfer-encoding:from:mime-version
	:subject:date:message-id:references:cc:in-reply-to:to;
	bh=TUlJCeoF38DKIrVWoIThW1y6VPH1GtKS/JV6B3O9+e8=;
	b=IUikLJgEbtOo3tcPawtsDvVRXq5VIgawwU7xhk8T/iPymRcr3H79nWIAynVkU1X48I
	LvncMV3tMPiFkTNS8Tji6rT1hIHGFkUo0WsIfeB1btr9JcabaANaHi21fjh8ingTMAG5
	w36XEY6OSF84U34INHnXbUM90qAsNhnmcZsMv7UNrGYNJRzNRYLY4kJs6ZI8+5h6ramQ
	NL/11oWzkDHXGiIZ4XMWpD4dsi+FXxs+32nini7W8Zta+Lt+EONcJgFIznX+iM8R2oq7
	VUbDbm5fhcB82g2RSqwXi9CDWikUypsZSJTeQA5ZNl/jvPDqSWXKfaINgDNGHGSqJt3J
	zNJw==
X-Gm-Message-State: APjAAAWEEa7HfY67NYt20vUvMhcHyXxwXhrm2lUPWf9wHMRG54XGfMqN
	5DjY53wy3DjVHcP6LMKZV2XoPg==
X-Google-Smtp-Source: APXvYqzqhrRm/F68CA5PU/mQDVIRouMaJ2axN9SXyskCosIsXv5cShq2L9eqdvDzzBRD/pc3m0W5VQ==
X-Received: by 2002:a05:6214:90f:: with SMTP id
	dj15mr9905628qvb.224.1573481122495; 
	Mon, 11 Nov 2019 06:05:22 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
	[71.184.117.43]) by smtp.gmail.com with ESMTPSA id
	x11sm9257781qtk.93.2019.11.11.06.05.21
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Mon, 11 Nov 2019 06:05:21 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
	scalable mode
Date: Mon, 11 Nov 2019 09:05:20 -0500
Message-Id: <77EC0C76-22C1-4982-8E0A-9AD7223B3410@lca.pw>
References: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
In-Reply-To: <f5b8521e-d88d-5439-34e2-f7b54a77c9d3@linux.intel.com>
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



> On Nov 11, 2019, at 12:23 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> The scalable mode is defined in VT-d 3.0. The scalable mode capability
> could be checked by reading /sys/devices/virtual/iommu/dmar*/intel-
> iommu/ecap. It's currently not friendly for reading. You need to decode
> it according to the spec.

This looks like some perfect information to put in the Kconfig description.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
