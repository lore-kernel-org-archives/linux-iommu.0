Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453BC433DF
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 17:55:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878352075A
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 17:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T3isW0BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878352075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 665E588503;
	Fri, 29 May 2020 17:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUJv9RIpfPfD; Fri, 29 May 2020 17:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6F3E883D2;
	Fri, 29 May 2020 17:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94827C07FF;
	Fri, 29 May 2020 17:55:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58687C016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 17:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3DA5886C1D
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 17:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZfnWvd9YvLm for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 17:55:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 636D486BCB
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 17:55:27 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id f5so4674167wmh.2
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U/iWA+NM93lmEOR8BD3HSGFwn5myHStX/svocCwc2zk=;
 b=T3isW0BRXt8VQajj1U69CHubFeUebbA7xMKa/VSv/g1vunIpEUnbEgqdlAUG3dmxSY
 h+2fFSUWz5RSeir9VQUHRlYjikdIavLXyI7LELfjSHOEqDzuDt0smviqOBdljinxME5+
 KoE49ljxnvFhdKvzrug2mC7bA9NKZ1hJTbk3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U/iWA+NM93lmEOR8BD3HSGFwn5myHStX/svocCwc2zk=;
 b=KQDLTAo1pjHEQOAVL0/mDBsyun47kpEyUYyR3fkrxpvr5wutOhMv377IaTyrEapLTS
 7bPh7RmwoAX2kFFOfR0Gl3QdoXCbzl18/Vhg2+TDsO6M4BBKMTnTPaI9SdFiq+6qyKMt
 7MTETc5n4DUNpVDIE3551OAgUsUmq742lEQSsERPu4B58GoYxE5i/gyPTJ+mr+Nxe19R
 +f1uh/+00SeKgwtYDNERVJzM424063Jk8igOI+ONTz3XAVifCYes6vc6m5geFbg4WD7t
 RWyTlKOLMkJuyE8+t+hFVISV9/tGs7TtDso4Qjs+yJX+OIWjItTryMBF011DYjVerLdL
 L27w==
X-Gm-Message-State: AOAM532RLvcgpQcrkALm4Xbi/loKdLL+KL8BSQ9j0K8lQgZJV8XWUMrX
 LzstB62PtQKV2HPSPi/jIznymdWua2OUxnEUWbj4MQ==
X-Google-Smtp-Source: ABdhPJyddc3wujxmrCvzPzUS9jR6GnyypGU54L49z504ymdkHZAWzgGRss7csUxJVRpywWwHWAFmXu42cGVgC/AI5dc=
X-Received: by 2002:a05:600c:280c:: with SMTP id
 m12mr10012502wmb.92.1590774925565; 
 Fri, 29 May 2020 10:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200529174858.GA2640397@bogus>
In-Reply-To: <20200529174858.GA2640397@bogus>
Date: Fri, 29 May 2020 13:55:13 -0400
Message-ID: <CA+-6iNydfUPe4J_eMY_9OXR9Y+Bwc65wtKQRGAwuW+K=drCVqQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] PCI: brcmstb: enable PCIe for STB chips
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>, Julien Grall <julien.grall@arm.com>,
 Christoph Hellwig <hch@lst.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Corey Minyard <minyard@acm.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mark Brown <broonie@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Wolfram Sang <wsa@kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 29, 2020 at 1:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 26, 2020 at 03:12:39PM -0400, Jim Quinlan wrote:
> > v2:
> > Commit: "device core: Add ability to handle multiple dma offsets"
> >   o Added helper func attach_dma_pfn_offset_map() in address.c (Chistoph)
> >   o Helpers funcs added to __phys_to_dma() & __dma_to_phys() (Christoph)
> >   o Added warning when multiple offsets are needed and !DMA_PFN_OFFSET_MAP
> >   o dev->dma_pfn_map => dev->dma_pfn_offset_map
> >   o s/frm/from/ for dma_pfn_offset_frm_{phys,dma}_addr() (Christoph)
> >   o In device.h: s/const void */const struct dma_pfn_offset_region */
> >   o removed 'unlikely' from unlikely(dev->dma_pfn_offset_map) since
> >     guarded by CONFIG_DMA_PFN_OFFSET_MAP (Christoph)
> >   o Since dev->dma_pfn_offset is copied in usb/core/{usb,message}.c, now
> >     dev->dma_pfn_offset_map is copied as well.
> >   o Merged two of the DMA commits into one (Christoph).
> >
> > Commit "arm: dma-mapping: Invoke dma offset func if needed":
> >   o Use helper functions instead of #if CONFIG_DMA_PFN_OFFSET
> >
> > Other commits' changes:
> >   o Removed need for carrying of_id var in priv (Nicolas)
> >   o Commit message rewordings (Bjorn)
> >   o Commit log messages filled to 75 chars (Bjorn)
> >   o devm_reset_control_get_shared())
> >     => devm_reset_control_get_optional_shared (Philipp)
> >   o Add call to reset_control_assert() in PCIe remove routines (Philipp)
> >
> > v1:
> > This patchset expands the usefulness of the Broadcom Settop Box PCIe
> > controller by building upon the PCIe driver used currently by the
> > Raspbery Pi.  Other forms of this patchset were submitted by me years
> > ago and not accepted; the major sticking point was the code required
> > for the DMA remapping needed for the PCIe driver to work [1].
> >
> > There have been many changes to the DMA and OF subsystems since that
> > time, making a cleaner and less intrusive patchset possible.  This
> > patchset implements a generalization of "dev->dma_pfn_offset", except
> > that instead of a single scalar offset it provides for multiple
> > offsets via a function which depends upon the "dma-ranges" property of
> > the PCIe host controller.  This is required for proper functionality
> > of the BrcmSTB PCIe controller and possibly some other devices.
>
> If you can enable the h/w support without the multiple offset support,
> then I'd split up this series. The latter part might take a bit more
> time.
>
> Rob
Unfortunately, the STB PCIe  controller depends on the multiple PFN
offset functionality.
Thanks,
Jim
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
