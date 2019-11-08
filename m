Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B399C17441
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 22:49:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC81215EA
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOxHRcrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC81215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 35DADCC2;
	Fri,  8 Nov 2019 22:49:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1FFC8CB0
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 22:49:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
	[209.85.166.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CE806196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 22:49:03 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id s5so6552871iln.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 14:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=wae4FJoeXjSSIN6WIXQxANW3IlPt4nOq6cEJ/vITa3A=;
	b=GOxHRcrE0GKpkZiencP0jt95fTcpXZu3TT/w8qFPOAI1mUd4gXgqcDwTAP9ZO8VVBF
	dfM1YjK+KmAMZhiV4Ye8m2zv7rUjCvLdhyPxjljrUBBM9yiB0bRlRhvaDuJpq7Yy1u/5
	I+xLRGkI5d6OspOjyvamyLC23bO5rQ3nqRQjsHAVLKmbtM2EAtIrJAdtErkIt9Q90Efe
	1tR7mz4sEa0BFC70rowh5G2LredBxgpA2+GHxSizEhvpAvPUiriRC4XPVMDZJDM7My4n
	8uj/ZQhV4z8zrvhTdFYIOquVUpvg3HnxPHC0eBLVt/5OG9969RMRROFZZvbjKWwKb+4p
	DIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wae4FJoeXjSSIN6WIXQxANW3IlPt4nOq6cEJ/vITa3A=;
	b=Tjk4w0SbhTdx08bdVo0lnZhxkcu3/HuzQEjQAxYpH+ljAIb8rSXJ27fjQqQWYZTE8q
	R/2crFtrkgtM4gmAhV1bDA/1GN3lKTsbxajk0njTRV/7B27NozegI2JDy/lIUvBUZdvo
	IRXeQ5k/OaXZh4naIsQA2wnTpIYScWyOvmpijHZC/ssHBoH2rEH9GoPw1wRhrDUHemy0
	ZtqgzzS2KEXB9lyQMOGGq4Kik4GYqhigTOfiF4MbwV9Vehya15YJ5YSWuYXhU8KYahZo
	wT0eSwTyHehOC+SwLXAF11HszmE4NIjEOmgiUFGo1L195CkoGwDzSPJ4iyX9VAzozqdp
	Z6Wg==
X-Gm-Message-State: APjAAAXZKfmAOzUajqWrdp75BzMomOvBdL2w4nK//yfnVUCZdyMGs/JE
	AP7nAf3HceXcea42/z9hOyXrG8rZMCuN5XeqYlQ=
X-Google-Smtp-Source: APXvYqwGvQxpaAT2c4juU7qywbaTWicJVh6do/fR5zn/PMCh4PQSoYdT8lHJE18e6mZ1pxxNXn3mKG1mTo/ocB3dE5E=
X-Received: by 2002:a92:5e49:: with SMTP id s70mr16569333ilb.130.1573253342983;
	Fri, 08 Nov 2019 14:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
	<1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
	<addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 8 Nov 2019 14:48:51 -0800
Message-ID: <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To: "Zeng, Jason" <jason.zeng@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

> > > For VMM live update case, we should be able to detect and bypass
> > > the shutdown that Deepa introduced here, so keep IOMMU still operating?
> >
> > Is that a 'yes' to Deepa's "if someone wants to make it conditional, we
> > can do that" ?
>
> Yes, I think so. Thanks!

Are these changes already part of the kernel like avoiding shutdown of
the passthrough devices? device_shutdown() doesn't seem to be doing
anything selectively as of now.

Thanks,
Deepa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
