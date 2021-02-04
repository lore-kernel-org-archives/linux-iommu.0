Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F10C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 16:48:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3904964DF5
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 16:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3904964DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F2C4486529;
	Thu,  4 Feb 2021 16:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4EQsyDwB81T7; Thu,  4 Feb 2021 16:48:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A21F86538;
	Thu,  4 Feb 2021 16:48:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E30ACC0174;
	Thu,  4 Feb 2021 16:48:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D12AC013A;
 Thu,  4 Feb 2021 16:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7266D274E3;
 Thu,  4 Feb 2021 16:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XT44Kf6U6vZq; Thu,  4 Feb 2021 16:48:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by silver.osuosl.org (Postfix) with ESMTPS id 189D727484;
 Thu,  4 Feb 2021 16:48:39 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id c12so4298041wrc.7;
 Thu, 04 Feb 2021 08:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZKBnpUeMo730D8AdWVMakbcCm1b7M/eKIDeLqDP9XrI=;
 b=jkEVKBWCmhkIg3sM3GoAQbQAY3fiYxYJeqRl90//Zv4tIMINCQzvvI8EJEJfuDUx3g
 aUhoEeCTuuvzTTSgwMvp8Ow8tlzbUnKMegfzWtCvnaZmBtYJrn89njAMdYIBCUq5UUpj
 RFu9AnGp25G4bLs9nvU0EQjqrJos2SKIziaRRkaZ5nAWXaN2Z9fwSc3CMNIOaTqJSeoV
 1zyiKUINl9uu1cpR+tcjMFj8zXrFVAzeV4ReooYXRCwwBBvCBE5Y5iLKYgJVdGkZ7oe6
 N9z1pxekaw3QTZIyrpUd55qEbgT8YZAmCA1HrjhY96NypGnJemZyoCaIWqnSWlTjL+ol
 XEAg==
X-Gm-Message-State: AOAM53288pbfMg0ZjdJDW09Hps0Lh+69LvekyyKio5h6fXAeUPpVHaVk
 ON11IMMc6yN+Wv3rUTMQ5W8=
X-Google-Smtp-Source: ABdhPJzP5TV1DdTEip1CBP5TkYTA31w954zIpqhAtz0ZyGAXo/7QIe6RobDJOF5XaAec/SkKKYIAJw==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr235527wrd.29.1612457317643;
 Thu, 04 Feb 2021 08:48:37 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id v1sm6662200wmj.31.2021.02.04.08.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 08:48:37 -0800 (PST)
Date: Thu, 4 Feb 2021 16:48:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Message-ID: <20210204164835.b74zjs6n5hll5bnz@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-17-wei.liu@kernel.org>
 <MWHPR21MB15936ED25B56AF897B655B76D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210203124700.ugx5vd526455u7lb@liuwe-devbox-debian-v2>
 <MWHPR21MB1593F0BB81545B450D2ACBE6D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593F0BB81545B450D2ACBE6D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Feb 04, 2021 at 04:41:47PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 4:47 AM
[...]
> > > > +
> > > > +	if (level)
> > > > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> > > > +	else
> > > > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > > > +
> > > > +	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
> > > > +
> > > > +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input,
> > output) &
> > > > +			 HV_HYPERCALL_RESULT_MASK;
> > > > +	local_irq_restore(flags);
> > > > +
> > > > +	*entry = output->interrupt_entry;
> > > > +
> > > > +	return status;
> > >
> > > As a cross-check, I was comparing this code against hv_map_msi_interrupt().  They are
> > > mostly parallel, though some of the assignments are done in a different order.  It's a nit,
> > > but making them as parallel as possible would be nice. :-)
> > >
> > 
> > Indeed. I will see about factoring out a function.
> 
> If factoring out a separate helper function is clumsy, just having the parallel code
> in the two functions be as similar as possible makes it easier to see what's the
> same and what's different.
> 

No. It is not clumsy at all. I've done it in the newly posted v6.

I was baffled why I wrote hv_unmap_interrupt helper to be used by both
hv_unmap_ioapic_interrupt and hv_unmap_msi_interrupt in the previous
patch, but didn't write a hv_map_interrupt. Maybe I didn't have enough
coffee that day. :-/

Thanks for pointing out that issue. It definitely helped improve the
quality of this series.

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
