Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51FEC10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:30:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D602147A
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D602147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6BAD6EC9;
	Mon,  8 Apr 2019 15:30:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 32291E96
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:30:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE7CD67F
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:30:29 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id f36so3056211plb.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 08 Apr 2019 08:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CQVL8xFDAq3rcWdFOwhTsDIvsZjXR7fCcfNZ6DCf3eE=;
	b=LSf9kq/jeCkNxaAaxRJu3gnQoq6+tGQU6tMJCZhSKFJTSH7Jp9RCbFraZUSlBniaqu
	iqipbg0YZekE35BBjBn6Kl+ZjO/0/N3zvJj7ppi1hK3Z09VvsEmca2swn/vShGhM0jNb
	kR6enf4/iIDa7nqojy/FoWrCERT+PN6/ATYE6uSdcpCXmB/EoEF9SXSf8hwY+fFGSMvy
	BR48lsJMkmwcFQhrjJmLQ4Gjyc8ViBiEZ2xzUWnd6qj4PQ0BVS6wwTYWlRBbzzr5oHtj
	FE2Vf9UVwerdjKj/Pg4+gVA3r52XfPuhEHeCN6jJ13MZTs2SO4azrDX2tmWFRu7fCrFb
	dngQ==
X-Gm-Message-State: APjAAAWLazxa62LKp70jgMYOaU2wUo1iKhBCChLD8/TKTQCMpFoCZRki
	CSPlRGDc+aU1mUZM2oiSxsc=
X-Google-Smtp-Source: APXvYqyO8g8iiE0ul1sxBr6TLXwiGjDYOYDe8Hqple9COswZQfXFxeNB6Hs9z+LvZu3sdmkeWY4POw==
X-Received: by 2002:a17:902:7589:: with SMTP id
	j9mr5175561pll.287.1554737429145; 
	Mon, 08 Apr 2019 08:30:29 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5?
	([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
	by smtp.gmail.com with ESMTPSA id
	y10sm47199045pfm.27.2019.04.08.08.30.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 08 Apr 2019 08:30:28 -0700 (PDT)
Message-ID: <1554737427.118779.271.camel@acm.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
From: Bart Van Assche <bvanassche@acm.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 08 Apr 2019 08:30:27 -0700
In-Reply-To: <20190408092345.01751472@x1.home>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home> <1554736414.118779.265.camel@acm.org>
	<20190408092345.01751472@x1.home>
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Jiang Liu <jiang.liu@linux.intel.com>, James Smart <jsmart2021@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408153027.4JWySmZaP8DT3Lfe-RoXcXaGgn4S9p8YQxOP9FhZbbw@z>

On Mon, 2019-04-08 at 09:23 -0600, Alex Williamson wrote:
> Loading modules is privileged:
> 
> $ modprobe vfio-pci
> modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted
> 
> Granting a device to a user for device assignment purposes is also a
> privileged operation.  Can you describe a scenario where this is
> reachable without elevated privileges?  The driver core maintainer has
> indicated previously that manipulation of driver binding is effectively
> at your own risk.  It's entirely possible to bind devices to the wrong
> driver creating all sorts of bad behavior.  In this case, it appears
> that the system has been improperly configured if devices from a user
> owned group can accidentally be bound to host drivers. 

No user space action should ever crash the kernel, whether or not it
is a privileged action and whether or not a configuration mistake is
involved. The only exception are actions that are intended to crash
the kernel, e.g. SysRq-c. I'm surprised that I have to explain this.

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
