Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB14C432C0
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 18:02:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5124C20740
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 18:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVZoTiVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5124C20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2067D87937;
	Mon, 25 Nov 2019 18:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xoNNX0LGhLnL; Mon, 25 Nov 2019 18:02:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7585C87839;
	Mon, 25 Nov 2019 18:02:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B1DBC0881;
	Mon, 25 Nov 2019 18:02:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C08A3C0878
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 18:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A6AE02010A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 18:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rY+VjGM8bzs for <iommu@lists.linux-foundation.org>;
 Mon, 25 Nov 2019 18:02:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 817152000D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 18:02:51 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id b11so267017wmj.4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DsVFgOaoUnvqgpXrrfO/kuxApZChsstp982wmsPwKow=;
 b=BVZoTiVVWzkDa6J2Q2Qlyztkv9vYFsD8IQFSzj6F/veUx4CwkaYyPnMFRUYWaN8vy4
 FN/26iKAp68el7tDKgZOR8bbr3gZQ+IIjxSCIbCU3xYwtaRnVItBvJtOT5eD0zVON6uG
 /vdQ+r1fFJyFa5adDPjnZxlevY/yeOnNxUybX639YiR7WofyJKBI4nK48UtjD0iVidNm
 6GJ9ITcStA6id5xJFVLJHZv6Lax/OfEErhFa/2G/Ceczqd2xJ8z/NNb+5Zv+8SmMkZFv
 HaZyLOMDnD+07/EQFr1qxCxir+RJwAnSaMeHJgSUMK3rZ0osaPrGXBCwdtx82UlEbUCw
 EIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DsVFgOaoUnvqgpXrrfO/kuxApZChsstp982wmsPwKow=;
 b=AYF6g5aOKGhFjbMs+Jl+GCbgmuNevQldBx77ip1vP417/OCPhZ1dbZ3+CR5zVxq6lx
 Wo4uvGyuf4bkVi7hbG62BdMgc/4rF05Qe3RD3riJIQogrzUyjkIcPg/b11bLGLpW2zAn
 5AuABopZPpnNt26l3YatKVO+pnb/TNWPjdl5+lzY4lQftmA2as72F1oKsPiE1K0sruQV
 qdVi1SQeWPkEKUfwQqE90p9dD7XD1J+pB5I8qqfSeBNA/SJvg+mFzcSqP0C/QVfBMBZk
 Aj+MDTdwrbnaLurcbBnGCNuTEjBWnpv1Z9aUYIxw4p7o5c0kmsc1q+cEXeIouDMZJ05X
 FhHA==
X-Gm-Message-State: APjAAAU7v7/IEEijqlVfB7I1Lk27PPZi8DOEc5i2Eg9AKU2WoOJrL6Hy
 V3pofGlVTz9t+euDPPZGnbRD7Q==
X-Google-Smtp-Source: APXvYqw9M5aeYuFnK4VC6ZcTBEX4VkbAMP2hH5YfKViShTZm/FHN5Dr4VO7dByhvs7N0wxzK+UaojA==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr93685wmj.127.1574704970043;
 Mon, 25 Nov 2019 10:02:50 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id 72sm11785825wrl.73.2019.11.25.10.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 10:02:49 -0800 (PST)
Date: Mon, 25 Nov 2019 19:02:47 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191125180247.GD945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122160102.00004489@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191122160102.00004489@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, sudeep.holla@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, mst@redhat.com, guohanjun@huawei.com,
 bhelgaas@google.com, jasowang@redhat.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:
> > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and
> > IORT for Arm). From my point of view IORT is easier to extend, since
> > we just need to introduce a new node type. There are no dependencies
> > to Arm in the Linux IORT driver, so it works well with CONFIG_X86.
> > 
> From my limited understanding, IORT and VIOT is to solve device topology
> enumeration only? I am not sure how it can be expanded to cover
> information beyond device topology. e.g. DMAR has NUMA information and
> root port ATS, I guess they are not used today in the guest but might
> be additions in the future.

The PCI root-complex node of IORT has an ATS attribute, which we can
already use. However its scope is the root complex, not individual root
ports like with DMAR.

I'm not very familiar with NUMA, but it looks like we just need to specify
a proximity domain in relation to the SRAT table, for each viommu? The
SMMUv3 node in IORT has a 4-bytes "proximity domain" field for this. We
can add the same to the VIOT virtio-iommu nodes later, since the
structures are extensible.

But it might be better to keep the bare minimum information in the FW
descriptor, and put the rest in the virtio-iommu. So yes topology
enumeration is something the device cannot do itself (not fully that is,
see (2)) but for the rest, virtio-iommu's PROBE request can provide
details about each endpoint in relation to their physical IOMMU.

We could for example add a bit in a PROBE property saying that the whole
path between the IOMMU and the endpoint supports ATS. For NUMA it might
also be more interesting to have a finer granularity, since one viommu
could be managing endpoints that are behind different physical IOMMUs. If
in the future we want to allocate page tables close to the physical IOMMU
for example, we might need to describe multiple NUMA nodes per viommu,
using the PROBE request.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
