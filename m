Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D9C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:32:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362ED208C3
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHKi2HpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362ED208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CE914D85;
	Fri, 20 Sep 2019 16:32:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 30DFFD84
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:32:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9889A8BD
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:32:38 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id r16so7023741edq.11
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=WDmmqCZYXexmb0eMYG+EBBMVOjtRn4WXWY9o5YS1U8w=;
	b=XHKi2HpQvTaSkYa589k9BCAaRbhq1vYia/RSN+zRQi7UhZpXqMPGKbGrZz7sGIXaAk
	4O9q+WGUu4fcL0IATXV0mJZxtaPNNNo7tlde6UlnOA0Tb+Niquur3wEf4lK28211rCLo
	/Eb+yd5VQQ42If/e68qL+FbFI9U+N+u4vv6V46QgiTaoPpQ2OH5wcxUYEfWtMY1znh5h
	nMqygv3vOtftd1WqijSQ5m1tFGJBW/kBReEDoour9JUJsyoTHYN1gZHw/cYNQ2E1zq7O
	aSwNUfDm0cL+hwYdEPj12VhzM7L9QEVqO+6IuNkRDvItfoccVz36ICWHVNiy9JmTaCNg
	KGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=WDmmqCZYXexmb0eMYG+EBBMVOjtRn4WXWY9o5YS1U8w=;
	b=OIuOXuaSmgZ+Ku7W520G5BT/VMNLPsfVYo1KTpghqUVhGL1CMEaluEqKwfP0TiUZxH
	vI3gyQv3eZMrCvR019Ue/Sr17jqaN4KqHgFsv4JXk6fTjCH17p4QmWZcItV6sHkRIjs8
	AQMlIz6nmyZivoHLBLeN05a4f7bRoo/SXSG2YOpPE7jiGYD5WctaNA9G9oy4Udg+9AQe
	5N8DsNlNXvfCa6Iq4rV4KFrPJGme6jPe0tKKHqqqG5gg3c8Lmfxdf0sGm64Nm6l0EdyS
	7WKAe6skbbQIQkZ7V9Xdx1OxTjKRl+zzQDKQzpJ/JOeNozTD/Fz/yG6ueci3FjUfXJs5
	1a2Q==
X-Gm-Message-State: APjAAAWE4k5zZTxBfn5VLDEvaq5BV4A52LVKQ0aoSCT8udCc/ihD4keM
	T6PJ+SQvEvgwEhVRKkG2rrdvjQ==
X-Google-Smtp-Source: APXvYqy5vbARL91iYKGvt6OWKfTM8NNpXTSIn1jRhrBps5tW8eSu9hv2YM1yO+cHqlw9tFdbaGY94w==
X-Received: by 2002:a17:906:5c49:: with SMTP id
	c9mr20162972ejr.78.1568997157032; 
	Fri, 20 Sep 2019 09:32:37 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id j8sm405906edy.44.2019.09.20.09.32.35
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 09:32:36 -0700 (PDT)
Date: Fri, 20 Sep 2019 18:32:34 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu: Introduce cache_invalidate API
Message-ID: <20190920163234.GA1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1568849194-47874-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568849194-47874-2-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, Sep 18, 2019 at 04:26:31PM -0700, Jacob Pan wrote:
> From: Yi L Liu <yi.l.liu@intel.com>
> 
> In any virtualization use case, when the first translation stage
> is "owned" by the guest OS, the host IOMMU driver has no knowledge
> of caching structure updates unless the guest invalidation activities
> are trapped by the virtualizer and passed down to the host.
> 
> Since the invalidation data can be obtained from user space and will be
> written into physical IOMMU, we must allow security check at various
> layers. Therefore, generic invalidation data format are proposed here,
> model specific IOMMU drivers need to convert them into their own format.
> 
> Signed-off-by: Yi L Liu <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

I tried to take a fresh look at this and didn't see anything
problematic, though I might have been the last one to edit it. Anyway:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
