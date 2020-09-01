Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20263C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 09:06:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12392071B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 09:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTp0drHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12392071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B10986EA4;
	Tue,  1 Sep 2020 09:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id devUW6Rrtl3Q; Tue,  1 Sep 2020 09:06:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B391686E9D;
	Tue,  1 Sep 2020 09:06:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CAB6C07FF;
	Tue,  1 Sep 2020 09:06:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7440EC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 09:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 62EB086361
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 09:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f+KHT25q4EnC for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 09:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E508C85BA1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 09:06:10 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id e7so323847qtj.11
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D1PJjxl04vIbaOs4ebAEDi29TuKqnfLhXms4e4vAfJA=;
 b=QTp0drHkzoxPRdICP28IjclRm08/ZlHuAEtqzP1QG+vFQRN0wCHglbA4imGiRgaqQO
 vks9z3Oso2USraYzRybz8FI/N6N3pWRsUsc5mUvct+cAoZvC9nP8Q150X3oE+lVOh+uI
 cc5eAaKJppdn4BQl1wpeaony/BfyeOocoxpuZh716y4jvk1A8r/m/WkOXkLisljNgvJB
 BC+UzYfw2mq6UumWvrmF6vC9yUvrTEUAWTzGbkL+CrArI1Hh4guazMfegiUJHg1JaONv
 tjMS9UnBxWu3DcNoGgnvuzvZzihXwkA3A7lzQaDpeLmVP2VDewI206ZixijmZreELJ2C
 A1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D1PJjxl04vIbaOs4ebAEDi29TuKqnfLhXms4e4vAfJA=;
 b=JrEdrpskYLvms1XIZSKhwY892nBgXeRczHCa4O+gRvxDFEO2yJwkGoHtzpV83gd4U3
 nWLBZgSU1Sd8R7miB08RSna7Z2r6qdWSfEZMWSHHTXrAXNyH5mQ+i1Us5am+uX/FBaSz
 lemjeXLRxdlKvTEbxSPEpGeBrvIEMXDHWJet7cbGCifZA/pkv9au8xCoTr7bBWbpAuxq
 knPtSVVn+xNNwIohwCBgrJCfK4lnqr4kmids/Z9wNWf10ZAJvSC+sdpIVgxZ+ruDJyuG
 wGlCFulBg70o9vLWb0096q7Lkyw+fU7GQkSMUR09HVLqs1yFa8h5LXULKzq8WJkpNAqB
 Ds9g==
X-Gm-Message-State: AOAM532IGUvnHMZYhpG7D4LqeDeTtQ9kbJYOQUQM+Re5wr2x1cbFKUB/
 U+Y1Iv8jgZHF1VjnhEV42VI=
X-Google-Smtp-Source: ABdhPJxt3ZrWQoEsnnEytmhabGXMOaQWqtDOIGFcf7SKiVbdrdYBFa/qMAesxlpKByq3CmY3wYvUtw==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr732113qtd.362.1598951169970;
 Tue, 01 Sep 2020 02:06:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com.
 [66.111.4.228])
 by smtp.gmail.com with ESMTPSA id 16sm821427qks.102.2020.09.01.02.06.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:06:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailauth.nyi.internal (Postfix) with ESMTP id A373327C0054;
 Tue,  1 Sep 2020 05:06:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 01 Sep 2020 05:06:06 -0400
X-ME-Sender: <xms:_Q5OXyPVVGbcpSw2EztgFitqADIXh0znK6ysN4qTLzqv55nU0M0zsA>
 <xme:_Q5OXw9O1ucVg3XzURv5aBq9MWR-ujm1IY0XBjjrSQuPefDtuFYRg4XAcGDZcBkMp
 tcXR3XAdGe7v1BMaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
 ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
 htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
 gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduud
 durdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
 eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
 ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_Q5OX5QOlS9hptseCXLPkG7f68kHMQUlI3i-jPDbOGRzKYLyASdR7Q>
 <xmx:_Q5OXyuZ4zrB-ZbtoRa-Rpu_UoWQUIzoHuQrRiWd91wlsnAL9BcM1g>
 <xmx:_Q5OX6edbEi7U5puDhdDP9GBqTCRDrm3ddwWE59ZoxpGMHZzP9Qovg>
 <xmx:_g5OX2_-nLoht5YCspRL8HNcVmpA0wZmAAc-P8oKxThtmQZ08oqIImQ4auc>
Received: from localhost (unknown [52.155.111.71])
 by mail.messagingengine.com (Postfix) with ESMTPA id 897A630600A9;
 Tue,  1 Sep 2020 05:06:04 -0400 (EDT)
Date: Tue, 1 Sep 2020 17:06:03 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
Message-ID: <20200901090603.GA110903@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826111628.794979401@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 Michael Kelley <mikelley@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

Hi Thomas,

On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
[...]
> 
> The whole lot is also available from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git device-msi
> 
> This has been tested on Intel/AMD/KVM but lacks testing on:
> 
>     - HYPERV (-ENODEV)

FWIW, I did a build and boot test in a hyperv guest with your
development branch, the latest commit is 71cbf478eb6f ("irqchip: Add
IMS (Interrupt Message Storm) driver - NOT FOR MERGING"). And everything
seemed working fine.

If you want me to set/unset a particular CONFIG option or run some
command for testing purposes, please let me know ;-)

Regards,
Bqoun

>     - VMD enabled systems (-ENODEV)
>     - XEN (-ENOCLUE)
>     - IMS (-ENODEV)
> 
>     - Any non-X86 code which might depend on the broken compose MSI message
>       logic. Marc excpects not much fallout, but agrees that we need to fix
>       it anyway.
> 
> #1 - #3 should be applied unconditionally for obvious reasons
> #4 - #6 are wortwhile cleanups which should be done independent of device MSI
> 
> #7 - #8 look promising to cleanup the platform MSI implementation
>      	independent of #8, but I neither had cycles nor the stomach to
>      	tackle that.
> 
> #9	is obviously just for the folks interested in IMS
> 
> Thanks,
> 
> 	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
