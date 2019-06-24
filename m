Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9CC4646B
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 10:28:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BAE20674
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ae3GjDPO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gDEuET4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BAE20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3E382EF1;
	Mon, 24 Jun 2019 10:28:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3A143EEA
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 10:28:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5B8F58E0
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 10:28:50 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 817EE6085C; Mon, 24 Jun 2019 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1561372129;
	bh=Yo8X3dqiiQ1UfNiElYZLxap+rtuWrdAb9vMVVB+Ox+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ae3GjDPONu0L4o01Dg+0ZPaoqbTuCx3E4go0l1apkykT3ssll2W0LxcKlIXoPuDcy
	7ZT/N3bD78c5FiD7cRV481iMctHAd8dMc83WetlaHyZbLavVqJhOEaGMECP+qOAefZ
	dBbVN8DhpFzKBrSr/XN4YqBs2/pHnytF2b9IA0B4=
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 64CBC6074C
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1561372126;
	bh=Yo8X3dqiiQ1UfNiElYZLxap+rtuWrdAb9vMVVB+Ox+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gDEuET4C0e23NAVMlDD0YYVtYeaZmhrDCpYHMy002urpTEz23zc3tLGyDg2gjdUUt
	opfKWC41nGYYhIw0TUVpNNU5fUpTrM/aXR8Uk5+bEuT+pADrGXcgRuqiyyo1SaWWDV
	0U9L8/Wn7opSTjmg3p94naSmpdMYaxdJl5Cd9ZG8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64CBC6074C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f42.google.com with SMTP id d4so20967144edr.13
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 03:28:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXHGKuZ+edKLuL17VznBMUJK0NOoo+f+yO6CsALP1nu2RIY2+7p
	KFlRY/INsz6WAeuWENrUHbHKPqrzf24gx+Fn0UI=
X-Google-Smtp-Source: APXvYqzS9YfgWqNtJBndTuIFVgJlLmOUhAdYZF1/h1ikpnhDX6yCJp0IUNtl0PCH/+Af5EI0Rq50UzRsBHoddpF7g0g=
X-Received: by 2002:aa7:c515:: with SMTP id o21mr121190379edq.2.1561372124494; 
	Mon, 24 Jun 2019 03:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-4-vivek.gautam@codeaurora.org>
	<20190614040520.GK22737@tuxbook-pro>
	<3e1f5e03-6448-8730-056d-fc47bdd71b3f@codeaurora.org>
	<20190618175218.GH4270@fuggles.cambridge.arm.com>
In-Reply-To: <20190618175218.GH4270@fuggles.cambridge.arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 24 Jun 2019 15:58:32 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEynLa=Jt_-oAwt4zmzxzhEXtWNCmghz6rFzcpQVGwrMg@mail.gmail.com>
Message-ID: <CAFp+6iEynLa=Jt_-oAwt4zmzxzhEXtWNCmghz6rFzcpQVGwrMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu: Add support to handle Qcom's
	wait-for-safe logic
To: Will Deacon <will.deacon@arm.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	David Brown <david.brown@linaro.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	robh+dt <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, pratikp@codeaurora.org
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

Hi Will,

On Tue, Jun 18, 2019 at 11:22 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Vivek,
>
> On Fri, Jun 14, 2019 at 02:48:07PM +0530, Vivek Gautam wrote:
> > On 6/14/2019 9:35 AM, Bjorn Andersson wrote:
> > > On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:
> > >
> > > > Qcom's implementation of arm,mmu-500 adds a WAIT-FOR-SAFE logic
> > > > to address under-performance issues in real-time clients, such as
> > > > Display, and Camera.
> > > > On receiving an invalidation requests, the SMMU forwards SAFE request
> > > > to these clients and waits for SAFE ack signal from real-time clients.
> > > > The SAFE signal from such clients is used to qualify the start of
> > > > invalidation.
> > > > This logic is controlled by chicken bits, one for each - MDP (display),
> > > > IFE0, and IFE1 (camera), that can be accessed only from secure software
> > > > on sdm845.
> > > >
> > > > This configuration, however, degrades the performance of non-real time
> > > > clients, such as USB, and UFS etc. This happens because, with wait-for-safe
> > > > logic enabled the hardware tries to throttle non-real time clients while
> > > > waiting for SAFE ack signals from real-time clients.
> > > >
> > > > On MTP sdm845 devices, with wait-for-safe logic enabled at the boot time
> > > > by the bootloaders we see degraded performance of USB and UFS when kernel
> > > > enables the smmu stage-1 translations for these clients.
> > > > Turn off this wait-for-safe logic from the kernel gets us back the perf
> > > > of USB and UFS devices until we re-visit this when we start seeing perf
> > > > issues on display/camera on upstream supported SDM845 platforms.
>
> Re-visit what exactly, and how?
>
> > > > Now, different bootloaders with their access control policies allow this
> > > > register access differently through secure monitor calls -
> > > > 1) With one we can issue io-read/write secure monitor call (qcom-scm)
> > > >     to update the register, while,
> > > > 2) With other, such as one on MTP sdm845 we should use the specific
> > > >     qcom-scm command to send request to do the complete register
> > > >     configuration.
> > > > Adding a separate device tree flag for arm-smmu to identify which
> > > > firmware configuration of the two mentioned above we use.
> > > > Not adding code change to allow type-(1) bootloaders to toggle the
> > > > safe using io-read/write qcom-scm call.
> > > >
> > > > This change is inspired by the downstream change from Patrick Daly
> > > > to address performance issues with display and camera by handling
> > > > this wait-for-safe within separte io-pagetable ops to do TLB
> > > > maintenance. So a big thanks to him for the change.
> > > >
> > > > Without this change the UFS reads are pretty slow:
> > > > $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=10 conv=sync
> > > > 10+0 records in
> > > > 10+0 records out
> > > > 10485760 bytes (10.0MB) copied, 22.394903 seconds, 457.2KB/s
> > > > real    0m 22.39s
> > > > user    0m 0.00s
> > > > sys     0m 0.01s
> > > >
> > > > With this change they are back to rock!
> > > > $ time dd if=/dev/sda of=/dev/zero bs=1048576 count=300 conv=sync
> > > > 300+0 records in
> > > > 300+0 records out
> > > > 314572800 bytes (300.0MB) copied, 1.030541 seconds, 291.1MB/s
> > > > real    0m 1.03s
> > > > user    0m 0.00s
> > > > sys     0m 0.54s
> > > >
> > > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > > ---
> > > >   drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
> > > >   1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > > index 0ad086da399c..3c3ad43eda97 100644
> > > > --- a/drivers/iommu/arm-smmu.c
> > > > +++ b/drivers/iommu/arm-smmu.c
> > > > @@ -39,6 +39,7 @@
> > > >   #include <linux/pci.h>
> > > >   #include <linux/platform_device.h>
> > > >   #include <linux/pm_runtime.h>
> > > > +#include <linux/qcom_scm.h>
> > > >   #include <linux/slab.h>
> > > >   #include <linux/spinlock.h>
> > > > @@ -177,6 +178,7 @@ struct arm_smmu_device {
> > > >           u32                             features;
> > > >   #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> > > > +#define ARM_SMMU_OPT_QCOM_FW_IMPL_SAFE_ERRATA (1 << 1)
> > > >           u32                             options;
> > > >           enum arm_smmu_arch_version      version;
> > > >           enum arm_smmu_implementation    model;
> > > > @@ -262,6 +264,7 @@ static bool using_legacy_binding, using_generic_binding;
> > > >   static struct arm_smmu_option_prop arm_smmu_options[] = {
> > > >           { ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
> > > > + { ARM_SMMU_OPT_QCOM_FW_IMPL_SAFE_ERRATA, "qcom,smmu-500-fw-impl-safe-errata" },
> > > This should be added to the DT binding as well.
> >
> > Ah right. I missed that. Will add this and respin unless Robin and Will have
> > concerns with this change.
>
> My only concern really is whether it's safe for us to turn this off. It's
> clear that somebody went to a lot of effort to add this extra goodness to
> the IP, but your benchmarks suggest they never actually tried it out after
> they finished building it.
>
> Is there some downside I'm not seeing from disabling this stuff?

This wait-for-safe is a TLB invalidation enhancement to help display
and camera devices.
The SMMU hardware throttles the invalidations so that clients such as
display and camera can indicate when to start the invalidation.
So the SMMU essentially reduces the rate at which invalidations are
serviced from its queue. This also throttles the invalidations from
other masters too.

On sdm845, the software is expected to serialize the invalidation
command loading into SMMU invalidation FIFO using hardware locks
(downstream code [2]), and is also expected to throttle non-real time
clients while waiting for SAFE==1 (downstream code[2]). We don't do
any of these yet, and as per my understanding as this wait-for-safe is
enabled by the bootloader in a one time config, this logic reduces
performance of devices such as usb and ufs.

There's isn't any downside from disabling this logic until we have all
the pieces together from downstream in upstream kernels, and until we
have sdm845 devices that are running with full display/gfx stack
running. That's when we plan to revisit this and enable all the pieces
to get display and USB/UFS working with their optimum performance.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n5172
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n5135

Thanks
Vivek

>
> We probably also need some co-ordination with Andy if we're going to
> merge this, since he maintains the firmware calling code.
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
