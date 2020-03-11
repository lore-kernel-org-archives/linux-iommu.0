Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE02C0044D
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 17:48:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B5A20734
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 17:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsyT07n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B5A20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6C4B873B8;
	Wed, 11 Mar 2020 17:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6u-pbPMHRJsX; Wed, 11 Mar 2020 17:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9786F86B3B;
	Wed, 11 Mar 2020 17:48:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81B1EC07FF;
	Wed, 11 Mar 2020 17:48:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A95F2C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 17:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9276D8654C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 17:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TlRkw9g659xO for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 17:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AB7D386521
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 17:48:31 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id v11so3774183wrm.9
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dJisBFKbMBqKg6noQwABaFDqaax7PpzmdnTa5T7HIFc=;
 b=DsyT07n9KmuNUcGpnGQlykLySm8c1pZltZ9XAxU+VdONAIb0KGWhkcCiNIuS44ZvPd
 rUsM/WCVSYWVY9ECcwYrIBJgzqqtrSAQ0fQB9klx4Pe+rUGeeXUPHHdg3mMFaKqbgRbp
 RGRmSAUQZ41a7eN//8o3mS/dMVv6lst/LbuNRvatAfaPquh+qwjGa4F9AuLy/n8+Nld/
 X8JiCdm+VXkXZOpNqyuy0WWT8m4uOJHz+Iv5u5K1xFLZq0bnmzWZDBBH/FABLiCnOQqe
 7UyXsaGw7mJJ/IH8Q1/azfsGE8yiicmNPaA9nuYX/937Hi4Joe5XGXs45qkWQ4AMfpyJ
 huRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dJisBFKbMBqKg6noQwABaFDqaax7PpzmdnTa5T7HIFc=;
 b=OOddR3E+LpMNxl5dhRJgaD9iA1J1rO5FPjGB6Mb//w1WLZyBwyN1mTz9pXQ9Vb+qAs
 XfwfSlZZLYxhXJQB/9osIl/9NgTLjy3iW8Rm41WzFAGnWFe4hqtqwoprE3uQdjXpPODW
 +76kiVHaOfzVWQhiCBUsawoP8TOb6JiJMq7EvXOhg1xmwptbW7tFFIJUp5AkXuTcnTu5
 PhJ7TY1EjoTt+HOdGXG6w420A3ZPBLQU9GUYKRfFs1aCMe1yWt2bseOqkJm1OsUzAifl
 y/Y1yVDzzeGWP94n4yTohZLfI+xrSc99wvALC2oUO8M4qmOJhOx1GjX6+i6Wh2Kox7Kl
 JupA==
X-Gm-Message-State: ANhLgQ2fBhuEH5zoNfdNVGccZJGx8XE+g/brXqUlKU1oooDhzmAPyPc5
 bolk12AVuhdxtlviusBA8uKx2A==
X-Google-Smtp-Source: ADFU+vs2blBggilqwVNzNXsLeIM725udDE4U7R2eyLKGjPL9fnDruIpq1F+F76rZyHH40ix4+e295Q==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr5522683wrw.321.1583948910077; 
 Wed, 11 Mar 2020 10:48:30 -0700 (PDT)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f4sm15885350wrt.24.2020.03.11.10.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 10:48:29 -0700 (PDT)
Date: Wed, 11 Mar 2020 18:48:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200311174822.GA96893@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Thu, Mar 05, 2020 at 08:07:32AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker
> > Sent: Saturday, February 29, 2020 1:26 AM
> > 
> > Platforms without device-tree do not currently have a method for
> > describing the vIOMMU topology. Provide a topology description embedded
> > into the virtio device.
> > 
> > Use PCI FIXUP to probe the config space early, because we need to
> > discover the topology before any DMA configuration takes place, and the
> > virtio driver may be loaded much later. Since we discover the topology
> > description when probing the PCI hierarchy, the virtual IOMMU cannot
> > manage other platform devices discovered earlier.
> > 
> > This solution isn't elegant nor foolproof, but is the best we can do at
> 
> can you elaborate "isn't elegant nor foolproof" part? is there any other 
> limitation (beside pci fixup) along the route, when comparing it to 
> the ACPI-approach?

Yes "not elegant" in part because of the PCI fixup. Fixups are used to
work around bugs, and it seems strange to have one for a normal use-case.
We also have to copy some of the virtio infrastructure since this code
runs before module load. And we have to add a third DMA configuration
method.

I don't believe anymore that the "not foolproof" part is right. After
studying the device infrastructure a little more this solution seems less
fragile than I previously thought, but it's still a big hack, and it's
only half of the story.

This patch only handles PCI-based endpoints and viommu. On ACPI platforms,
where the virtio-mmio device is specified by an object with _HID LNRO0005,
supporting virtio-iommu on MMIO requires installing a bus notifier. There
I'd rather use an ACPI table for the topology. Platforms that don't have
ACPI such as microvm specify virtio-mmio devices on the command-line.
There devices are only created when the virtio-mmio module is loaded,
which is too late. In that case I think we need to add an early pass on
the command-line, instead of a bus notifier.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
