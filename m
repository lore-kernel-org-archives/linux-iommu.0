Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70FECE58C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 14:18:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51401222CE
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 14:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0CGhE7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51401222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2CA2DEF6;
	Wed,  2 Oct 2019 14:18:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C4CB4EEC
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 14:18:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4ACF58A8
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 14:18:15 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id y91so15396195ede.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 02 Oct 2019 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=1fxLpOvxXjmYD9btfQy/Q69rKcNISxOaD+GEumCPo2Y=;
	b=M0CGhE7fvba+3sfLMywUWvxthwUABn1pfs/nG71DIGE6llAqL48cSUKBqCJXAv/bK4
	3s9dVWdEW6MGNWrNMbrewR+P3kTT36bEpTNZ7jB7ELJFO74woE3zAQNo8yf81otGx9np
	SuEYJ/RtzN/Wu+TrudFOrKTuuhBpLS2mvqJTVGNld+3dDmIW6/bN4aQ0uwLbkdmn/uvC
	NZ6PjPl5d3qAflqjfNiL1QiVN8ILAAKSn+hANSQ+vIFc1j8+tvURPV4+hCPewLISbmeV
	nZ7gTCZM5vGtGstE/uOEw4LcOImx3foPoFhpptWEQcRApzZwNpo7Pnn7GjqUtCTGPLGV
	dU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=1fxLpOvxXjmYD9btfQy/Q69rKcNISxOaD+GEumCPo2Y=;
	b=fOO4avBSacaHBUrvHwWTNla7L8g+fECo1TkC5qP6R5vrvKY/6fQc7DCyRN9XPWdVWe
	Qw3d0V6GUm9f3twTObp0pkJ8tCJv4U4vOAWxVvidtFREtNmstO+g68nxSUHtYQW7UKS6
	MEMBc2K6yhl9sNtTxITRq+8yR8hxG46P2VwpuozfxucG+ZA1T7fqwpuyY3/gOLnMKO1M
	TXDzyogEOIyNkV2/pK0BewcAM24uVP1QsnXSLiVG2SQqZighXPtO85p642HF10eBZCSq
	keDNSc7ht+Uhch2P3Dk3KdnkGYS6eekyO3dqyu8DqjHPBfsGHQ5YSzWLFZNLqhqL1fyr
	Ry+Q==
X-Gm-Message-State: APjAAAWh7B5Q1yjswwB88nJdnU+Dv+zu4Ts85qv2BqIA0ELxh94ttV0D
	onH0j5z3WP9BKQANotX+xcoLAg==
X-Google-Smtp-Source: APXvYqwzQCj4RcHWe9o2dtTIHvxFq6emx/0SCFncRGSHXKEzOKo92Y/YHzeOoyawc0mNLSdPyTt7bg==
X-Received: by 2002:a17:906:7e06:: with SMTP id
	e6mr3271372ejr.149.1570025893804; 
	Wed, 02 Oct 2019 07:18:13 -0700 (PDT)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	c24sm2254422ejp.43.2019.10.02.07.18.12
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 07:18:13 -0700 (PDT)
Date: Wed, 2 Oct 2019 16:18:10 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191002141810.GA407870@lophozonia>
References: <1569972805-27664-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1569972805-27664-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1569972805-27664-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,

There seem to be a mix-up here, the changes from your v2 are lost and
patches 1 and 3 are back to v1. Assuming this isn't intended, I'll
review v2 of this patch since it looked good to me overall.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
