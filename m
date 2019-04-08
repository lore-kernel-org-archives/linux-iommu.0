Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC77C10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:13:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6554A2148E
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 15:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6554A2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1D8F3EFE;
	Mon,  8 Apr 2019 15:13:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6214CEAD
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:13:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0CAA6623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 15:13:37 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id g8so7507564pgf.2
	for <iommu@lists.linux-foundation.org>;
	Mon, 08 Apr 2019 08:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FVl6aOFR69ewvK4p253QBCfWxNC1gqolfU07b0OHu3U=;
	b=K5ksFRmqzYmFhWiD8kh1sJFFpCG/eDMyPhNm6LbpnUgsLGVy7LlUuOfqB7GPUFI3D9
	cgX6oSwdghj4HriMG9N2K4uQ1ACvB0nAp1/90elMazws+L1UORqST4b2O8uw0C5QBmoS
	X79PFOpHiP4CFOTtwtTS3SkmKsNqRYODdt93IvI+2aD9llsSRBvL/2xUojid8hWewaqt
	4RA5rCBGvqBijzHMrM9jRxFut/2DU+OQC742Uw6vVa5hm9D/exbEBM6eJFfHsqkEDAFf
	uGIA0HeejSxjSh1MVC4OHGgS6RC5QjjLIB1rCLlCjL6ylM/+2T7E2DdEkAguVhycf56h
	lzFA==
X-Gm-Message-State: APjAAAV/oIYGxMbs8U6VDztVNksstFLQwN9jTSqrluOTZ8LBzhOF8/En
	h0Keesr08TzzWIN4FUUyiPE=
X-Google-Smtp-Source: APXvYqzY4/MrB3LAIwAn+Ugox276VhO3DJvVeUSpE8LrUFe18Qy2RgC0tq/MBXNYSRA6OBV5U2K2Kw==
X-Received: by 2002:a63:8142:: with SMTP id t63mr27496369pgd.63.1554736417360; 
	Mon, 08 Apr 2019 08:13:37 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5?
	([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
	by smtp.gmail.com with ESMTPSA id
	t190sm48947155pfb.33.2019.04.08.08.13.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 08 Apr 2019 08:13:36 -0700 (PDT)
Message-ID: <1554736414.118779.265.camel@acm.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
From: Bart Van Assche <bvanassche@acm.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 08 Apr 2019 08:13:34 -0700
In-Reply-To: <20190407173132.24032810@x1.home>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
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
Content-Type: multipart/mixed; boundary="===============7055709260679886307=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408151334.2Bu_KZztyXojokMnx2Ikefl2x-pQJ6RIj0ovlirBTWM@z>

--===============7055709260679886307==
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit

On Sun, 2019-04-07 at 17:31 -0600, Alex Williamson wrote:
+AD4 It's not possible to do what you want with this configuration.  An IOMMU
+AD4 group represents the smallest set of devices that are isolated from
+AD4 other sets of devices and is also therefore the minimum granularity we
+AD4 can assign devices to userspace (ex. QEMU).  The kernel reacts to
+AD4 breaking the isolation of the group with a BUG+AF8-ON.  If you managed not
+AD4 to hit the BUG+AF8-ON here, you'd hit the BUG+AF8-ON in vfio code when the loss
+AD4 of isolation is detected there. IOMMU groups are formed at the highest
+AD4 point in the topology which guarantees isolation.  This can be
+AD4 indicated either via native PCIe ACS support or ACS-equivalent quirks
+AD4 in the code.  If the root port provides neither of these, then all
+AD4 devices downstream are grouped together as well as all peer root ports
+AD4 in the same PCI slot and all devices downstream of those.  If a
+AD4 multifunction endpoint does not provide ACS or equivalent quirks, the
+AD4 functions will be grouped together. Not all endpoint devices or systems
+AD4 are designed for minimum possible granularity.  You can learn more
+AD4 here+AFs-1+AF0.  Thanks,
+AD4 
+AD4 Alex
+AD4 
+AD4 +AFs-1+AF0 http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html

Hi Alex,

Thank you for the detailed reply. The background information you provided
makes it very clear why the devices I mentioned in my e-mail ended up in the
same IOMMU group.

But it seems that I was not clear enough in my original e-mail. My concern is
that a user space action (modprobe) should never trigger a kernel BUG(). Is
there any way to make sure that the sequence of actions I performed causes
modprobe to fail with an error code instead of triggering a kernel BUG()?

Thanks,

Bart.

--===============7055709260679886307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7055709260679886307==--
