Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F03C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 03:22:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CEA206A3
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 03:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOeSPNWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CEA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C338AC4E;
	Mon, 11 Nov 2019 03:22:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97E72C3F
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 03:21:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3C6C9102
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 03:21:58 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id r144so12982960iod.8
	for <iommu@lists.linux-foundation.org>;
	Sun, 10 Nov 2019 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=udsQv+N/pb8sImm3oVXMjvN8DC7yoxu7rp8gANjC+ZI=;
	b=fOeSPNWUQuqmIuXxkOnX4SnvOU9F1lJ2n0a5rpfPfLI4VvySftz2NbnkaajWQOBKTe
	Ot+czn8T/vy3lXWzebOoOoWAOYNCoJ9zNpNyI+gB1FgicDS9cjtQ0lshhgAhDeslZ8Ki
	dmKXuCCC7SzdUHLOIo+NDQjG5u9IFaVunyn0g2Eo1AFlqRlXlTd1UPzw/tZ9NBuc45CP
	rw4negqEtPAJOBxDK/rwOG7BD7gObrQZyeigXG10j+F0tjMTua88kp/Vm4jwRPDeS2K6
	hgqbHi6ahDX6Gen/SUKnH7Ia50PPVCiRK8vMF5WeNZIxQ3RtQfx/UQUhM52HctxfZ1cn
	knFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=udsQv+N/pb8sImm3oVXMjvN8DC7yoxu7rp8gANjC+ZI=;
	b=P7JzcRdKCY6anXKWw1sQa1342QdwRZV2II1yBLC4SRaoNAImzjjs9ZwsJv73AaxA0c
	IfaUwUrYWNZdSokg0BaJVmDbfRTA5H70Toop701/7bTugtzzJz0PKlkgiOkQwx34ohNq
	KvktJnsY5Klkp+srQYLiFZfsOgerkKodH4TS/GWOU+mMvQpKWtgiRcyMz1yCKYwQQ16w
	GeBjNqzhu8Tfz44tG16X/Y1iedOx3e/QImOWTQk2OEFOjNf4sFB1yeTadcnHeIZAd1G3
	9b7ckrZBU1gs3+HRLcuJlMf+wssODD4X6cMVvOSuCihxIf2Pfp5iZDV+IQyb6s5wKl+8
	Fqaw==
X-Gm-Message-State: APjAAAUOEqvWeFN2r8KIO2H7ih+7oQ1bpEEXWkrg1AjzoFB/WmSqIpEY
	IsskNv/pB7+78yo2a9psPaBANUWCp/MjrRYKDC0=
X-Google-Smtp-Source: APXvYqwqRZFBots0x7hq0WUknPcn7B1YNn618XbuZplmZKM1pbfZk6DfmP7mTrrx/86Q3qmWJpPc5QToVvJPlSSHzwM=
X-Received: by 2002:a5e:da45:: with SMTP id o5mr22758469iop.265.1573442517410; 
	Sun, 10 Nov 2019 19:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20191110172744.12541-1-deepa.kernel@gmail.com>
	<9e2e95e2-37ac-c0d6-d438-bd09ba7064bd@linux.intel.com>
In-Reply-To: <9e2e95e2-37ac-c0d6-d438-bd09ba7064bd@linux.intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 10 Nov 2019 19:21:45 -0800
Message-ID: <CABeXuvofh-z97=iq9S7E1igbzyWwNU-MPbuCjNa_gzC3Q=L7hg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Turn off translations at shutdown
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org
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

On Sun, Nov 10, 2019 at 5:35 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 11/11/19 1:27 AM, Deepa Dinamani wrote:
> > The intel-iommu driver assumes that the iommu state is
> > cleaned up at the start of the new kernel.
> > But, when we try to kexec boot something other than the
> > Linux kernel, the cleanup cannot be relied upon.
> > Hence, cleanup before we go down for reboot.
> >
> > Keeping the cleanup at initialization also, in case BIOS
> > leaves the IOMMU enabled.
>
> Do you mind shining more light on this statement? I can't get your point
> here. Currently iommu_shutdown() only happens for reboot, right?

In this part, I'm saying that I'm leaving intel_iommu_init() alone.
I'm not taking out disabling the iommu from intel_iommu_init(). This
will help when BIOS has enabled the IOMMU and for whatever reason, the
kernel is booting with IOMMU off.

-Deepa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
