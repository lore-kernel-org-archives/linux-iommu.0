Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A5C4332B
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 09:16:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D643222DFB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 09:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D643222DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4B921204E2;
	Tue, 12 Jan 2021 09:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnrI8ld9pAch; Tue, 12 Jan 2021 09:16:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E530D204BC;
	Tue, 12 Jan 2021 09:16:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE838C088B;
	Tue, 12 Jan 2021 09:16:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCA66C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 09:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA7C4851FB
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 09:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iRYsw1cs_VqW for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 09:16:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 59C23851CC
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 09:16:52 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id v26so1445479eds.13
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=V4Ma0KkD8d21UACM4ffQTckGsQRVOOOjeKQ7H9bkegg=;
 b=tqns5ex3W/22GNSQjU3yHEUq6Lx0NP96Ysb/ui4paO62uBN1fxSQTYwaE9hkYeZZQ3
 +OsoewHGvx/NJl0tGOelIJS7NW25gPVldz3D+LhuhiHgp1kwFsnVxvo1AxoWnGvC0v7f
 fPLYq75eocGKThJXMhyHGVDEhGZUrQ9eq/oII/jJtfNIxEbXNRxcwJwgouUnjpfdx8ST
 T8G5xSxjsCNmIYPDPyBO2+ILzXpirbSIuxR6yIkNmsNpTohxn35Qd+ULH8Tbw3mA5P3b
 YBjYT2owuHJcg3U/sfVhyg9K17im8jtzLM3LMh81MoBbUZC0i4VOIwNQ9qdwdgdr35xk
 iDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V4Ma0KkD8d21UACM4ffQTckGsQRVOOOjeKQ7H9bkegg=;
 b=g3GHu09cz3mU4+PYz/fDmvre4XcT2b0/kNedixPEvrKHR+WRUJ2fSFa3WFLWPGD/q0
 uZpW88HCzfxjBR6YSk9I8VtlnMXLJKbHuhRBReThcAD8HFjlVEc90XD6xBH8A7fOxjb3
 Qgk5Q151Jv5llt0GBThCJ834IfezMOjKmk6DEo94NjgtHVq8L3awimwa7Ks6aXDQTSJh
 /TJidpxNJ615HDUqdLUv1Zbqfl+TJy2CrDHx2rcLocB3k17JHq+Lj8snho8tKN1Lu7A5
 Jf8gYnvfHSP0xoQd87tC82uLj4zarAO9qtHB9b8HwjLfbaQ4VX4/RycAK2DbDRXRy3UU
 8xFQ==
X-Gm-Message-State: AOAM532Dh7rtbRn/R6Fhif+V6arXHHMWyE+lPXftIexxqUxUT5rdASVz
 F4qa7BdLQfuOa7RWHLUCpLNcyA==
X-Google-Smtp-Source: ABdhPJxkiyPcGha8EA9sg/7lQmn+O5OBib7oEZX270HhCUOKgigDK4OOnz98pAkIlqJKozflypcvug==
X-Received: by 2002:a05:6402:895:: with SMTP id
 e21mr2679030edy.284.1610443010649; 
 Tue, 12 Jan 2021 01:16:50 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m7sm934913eji.118.2021.01.12.01.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 01:16:50 -0800 (PST)
Date: Tue, 12 Jan 2021 10:16:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <X/1o72DTmzdCMhDz@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, vivek.gautam@arm.com,
 guohanjun@huawei.com, will@kernel.org, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org, "Tian,
 Kevin" <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

Hi Baolu,

On Tue, Jan 12, 2021 at 12:31:23PM +0800, Lu Baolu wrote:
> Hi Jean,
> 
> On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
> > Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> > on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> > mandating IOMMU-managed IOPF. The other device drivers now need to first
> > enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > ---
> >   include/linux/iommu.h | 20 +++++++++++++++++---
> >   1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 583c734b2e87..701b2eeb0dc5 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -156,10 +156,24 @@ struct iommu_resv_region {
> >   	enum iommu_resv_type	type;
> >   };
> > -/* Per device IOMMU features */
> > +/**
> > + * enum iommu_dev_features - Per device IOMMU features
> > + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> > + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> > + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
> > + *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
> > + *			 some devices manage I/O Page Faults themselves instead
> > + *			 of relying on the IOMMU. When supported, this feature
> > + *			 must be enabled before and disabled after
> > + *			 %IOMMU_DEV_FEAT_SVA.
> 
> Is this only for SVA? We may see more scenarios of using IOPF. For
> example, when passing through devices to user level, the user's pages
> could be managed dynamically instead of being allocated and pinned
> statically.

Hm, isn't that precisely what SVA does?  I don't understand the
difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
later be used as a prerequisite some another feature. For special cases
device drivers can always use the iommu_register_device_fault_handler()
API and handle faults themselves.

> If @IOMMU_DEV_FEAT_IOPF is defined as generic iopf support, the current
> vendor IOMMU driver support may not enough.

IOMMU_DEV_FEAT_IOPF on its own doesn't do anything useful, it's mainly a
way for device drivers to probe the IOMMU capability. Granted in patch
10 the SMMU driver registers the IOPF queue on enable() but that could be
done by FEAT_SVA enable() instead, if we ever repurpose FEAT_IOPF.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
